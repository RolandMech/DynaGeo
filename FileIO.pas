unit FileIO;

interface

Uses Classes, Windows, Forms, Dialogs, SysUtils, StrUtils, Graphics, Math,
     GlobVars, TBaum, GeoTypes, GeoLocLines, GeoTransf,
     XMLDoc, XMLIntf;


function GeoXmlFileSave(GeoFileName: String;
                        Drawing: TGeoObjListe;
                        ValTabData: TValTabData;
                        XMLFormat: TXMLOutputFormat;
                        Check4JExp: Boolean = False): Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Schreiben der Datei     }

function GEOXMLFileLoad(GeoFileName: String;
                        var Drawing: TGeoObjListe;
                        var ValTabData: TValTabData): Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Lesen der Datei         }

function BMPFileSave   (R: TRect;
                        BmpFileName: String;
                        Drawing: TGeoObjListe;
                        outDPI: Integer = 0): Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Schreiben der Datei
                   =2 : Unbekannter Dateityp
                   =3 : Nicht genügend Speicher             }

function MetaFileSave  (R: TRect;
                        MetaFileName: String;
                        Drawing: TGeoObjListe): Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Schreiben der Datei     }

function MakXMLFileSave (MakFileName : String;
                         Drawing     : TGeoObjListe;
                         MakNum      : Integer): Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Schreiben der Datei     }

function MakXMLFileLoad(MakFileName : String;
                        Drawing     : TGeoObjListe): Integer;
  { Rückgabewert   =0 : alles okay !
                   >0 : Bitweise Interpretation :
                           1 : Falsches Dateiformat
                           2 : Datei nicht gefunden         }

function CreateGeoDomDocFromDrawing
                       (Drawing: TGeoObjListe;
                        ValTabData: TValTabData;
                        Check4JExp: Boolean): IXMLDocument;
  { gibt ein gültiges IXMLDocument-Objekt zurück, falls dieses korrekt
    erstellt werden konnte; andernfalls wird NIL zurückgegeben. }


implementation

Uses Utility, MathLib, GeoHelper, GeoMakro,
     MainWin, MyWebWin, ZLib, JPEG, PNGImage;


{---------- Alte GEO-Dateien ----------------------------------}

function valid_version (Logo : String): Boolean;
  begin
  valid_version := (CompareStr(Logo, 'EUKLID 0.9') >= 0) and
                   (CompareStr(Logo, EuklidLogo  ) <= 0);
  end;

function GeoFileLoad (    GeoFileName : String;
                      var drawing     : TGeoObjListe): Integer;
  var R      : TReader;
      TempSL : TStiftListe;
      TempPL : TPinselListe;
      TempGL : TGeoObjListe;
      CRTextStr,
      Logo   : String;
      idNum  : Word;
      IntCRNr,
      GFL    : Integer;
      file_pixelPerCentimeter : Double;
      GOS    : TFileStream;

  procedure CheckDoublePts(Item: Pointer);
    begin
    If TGeoObj(Item).ClassType = TGDoublePt then
      TGDoublePt(Item).CheckParent3;
    end;

  procedure CheckSecondPts(Item: TGeoObj);
    var pP, TGO : TGeoObj;
        NO      : TGName;
    begin
    If Item is TGSecondPt then with TGSecondPt(Item) do begin
      If TGeoObj(Parent.List[0]).Parent.Count >= 3 then
        pP := TGeoObj(Parent.List[0]).Parent.List[2]
      else
        pP := Nil;
      If pP <> Nil then begin
        If HasNameObj(NO) then
          NO.ShowsAlways := False;
        While Children.Count > 0 do begin
          TGO := Children.Items[0];
          TGO.Stops2BeChildOf(Item);
          If TGO.ClassType <> TGPoint then begin { Basispunkte sind hier stets Endpunkte von Strecken fester }
            TGO.BecomesChildOf(pP);              {   Länge und werden daher bei diesen mitverwaltet !        }
            If TGO.ClassType = TGFixLine then    { Strecke mit fester Länge }
              TGFixLine(TGO).AdjustFriendlyLinks;
            end;
          end;
        Drawing.FreeObject(Item);
        Drawing.UpdateAllDescendentsOf(pP);
        end;
      end;
    end;

  procedure PatchMeasurementObjects(Item: TGeoObj); far;

    procedure Adjust(knoten: TKnoten);
      var pGO : TGeoObj;
      begin
      If knoten <> Nil then with knoten do
        Case token of
          22 : begin { Abstandsobjekt }
               pGO := Drawing.GetObj(Round(right_ch.value));   { sucht das Abstandsobjekt          }
               If right_ch.right_ch = Nil then
                 right_ch.right_ch :=
                   TKnoten.Init4Int(0, Integer(pGO.Parent.List[0]), Integer(pGO.Parent.List[1]), 0, 0, Nil, Nil);
               end;
          23 : begin {Winkelmaßobjekt }
               pGO := Drawing.GetObj(Round(right_ch.value));   { sucht das Winkelmaßobjekt         }
               pGO := Drawing.GetObj(Integer(pGO.Parent.List[0]));           { sucht das zugehörige Winkelobjekt }
               If right_ch.right_ch = Nil then
                 right_ch.right_ch :=
                   TKnoten.Init4Int(0, Integer(pGO.Parent.List[0]), Integer(pGO.Parent.List[1]), Integer(pGO.Parent.List[2]), 0, Nil, Nil);
               end;
        else
          Adjust(left_ch );
          Adjust(right_ch);
        end; { of case }
      end;

    begin
    If Item.ClassType = TGXCircle then
      Adjust(TGXCircle(Item).rTerm.baum)
    else
      If Item.ClassType = TGXLine then
        Adjust(TGXLine(Item).wTerm.baum)
      else;
    end;

  procedure PatchData;
    var i : Integer;
    begin
    With Drawing do begin
      If CompareStr(Logo, 'EUKLID 1.2') <= 0 then begin  { Schaltet in DoublePt-Objekten Parent[3] }
        For i := 0 to Pred(Count) do                     {   ein, sofern das nötig ist, und löscht }
          CheckDoublePts(Items[i]);                      {   die dadurch überflüssig gewordenen    }
        For i := 0 to Pred(Count) do                     {   SecondPt-Objekte;                     }
          CheckSecondPts(Items[i]);

        InitCoordSys(WindowOrigin.x,                     { fügt in "alte" Zeichnungen ein          }
                     WindowOrigin.y,                     {   unsichtbares (Standard-)              }
                     WindowRect,                         {   Koordinatensystem ein                 }
                     1, False);
        end;

      If CompareStr(Logo, 'EUKLID 1.3') >= 0 then begin    { errechnet für Dateien, die auf einem  }
        If CompareStr(Logo, 'EUKLID 1.4') >= 0 then        {   anderen Rechner erstellt wurden,    }
          GOS.Read(file_PixelPerCentimeter,                {   die korrekten Längen                }
                         SizeOf(file_PixelPerCentimeter))
        else begin
          For i := 0 to Pred(Count) do
            PatchMeasurementObjects(Items[i]);
          file_PixelPerCentimeter := Drawing.e1x;
          end;
        end;

      { Objekte anpassen : }
      If CompareStr(Logo, 'EUKLID 2.0') < 0 then           { Nur für alte EUKLID 1.x - Dateien !!! }
        For i := 0 to Pred(Count) do                       {   Aber da gibt's ohnehin wenig        }
          TGeoObj(Items[i]).UpdateV1xObjects;              {   Hoffnung auf Erfolg !               }

      { Neue Hintergrund-Farbe nachtragen : }
      BackGroundColor := clWhite;
      end;
    end;

  procedure ReadTermsFromFile;  { alte 16-Bit-Versionen }
    var testbaum : TTBaum;
    begin
    If GOS.Position < GOS.Size then begin
      testbaum := TTBaum.Load(Drawing, GOS);
      If (testbaum <> Nil) and
         (testbaum.Status = tbOkay) then
        Drawing.Add(TGTermObj.Create(Drawing,
                                     Testbaum.source_str, '', True, True));
      testbaum.Free;
      If GOS.Position < GOS.Size then begin
        testbaum := TTBaum.Load(Drawing, GOS);
        If (testbaum <> Nil) and
           (testbaum.Status = tbOkay) then
          Drawing.Add(TGTermObj.Create(Drawing,
                                        Testbaum.source_str, '', True, True));
        testbaum.Free;
        end
      end;
    Drawing.LengthUnit := DefLengthUnit;
    Drawing.AreaUnit   := DefAreaUnit;
    Drawing.AngleUnit  := DefAngleUnit;
    end;

  procedure ReadAdditionalSupportData(R: TReader);  { Ab v2.0 ! }
    var i : Integer;

    procedure ReadOldTermFromStream;
      var TestBaum   : TTBaum;
          comment_str : String;
      begin
      comment_str := R.ReadString;
      TestBaum := TTBaum.Load32(Drawing, R);
      If (TestBaum <> Nil) and
         (TestBaum.Status = tbOkay) then
        Drawing.Add(TGTermObj.Create(Drawing, TestBaum.source_str,
                                     comment_str, True, True));
      TestBaum.Free;
      end;

    begin { of ReadAdditionalSupportData }
    If (R.Position < GOS.Size) and        { Noch Daten da ?   }
       (CompareStr(Logo, 'EUKLID 2.4') < 0) then   { bis v2.3 }
      For i := 1 to 2 do
        ReadOldTermFromStream;

    With Drawing do begin
      LengthUnit   := DefLengthUnit;         { Default-Werte setzen,      }
      AngleUnit    := DefAngleUnit;          { falls nix im Stream steht  }
      AreaUnit     := DefAreaUnit;
      DragStrategy := DefDragStrategy;

      If R.Position < GOS.Size then begin    { Noch Daten da ? (Ab v2.1)  }
        LengthUnit := R.ReadString;
        AngleUnit  := R.ReadString;
        If R.Position < GOS.Size then begin  { Noch Daten da ? (Ab v2.4)  }
          DragStrategy := R.ReadInteger;
          If R.Position < GOS.Size then      { Noch Daten da ? (Ab v2.5/6)}
            CmdString := R.ReadString;
          end;
        end;

      For i := 0 to Pred(Count) do   { Zahlobjekte initialisieren }
        If TGeoObj(Items[i]) is TGNumber then
          TGNumber(Items[i]).RedimData;
      end;
    end;  { of ReadAdditionalSupportData }

  procedure PatchOld24Data;
    var i   : Integer;
        nfo : TGArea;    { "n"ew "f"ill "o"bject }
    begin
    If CompareStr(Logo, 'EUKLID 2.5') < 0 then
      With Drawing do begin
        SortObjects;
        VirtualizeCoords;

        { Polygon-Füllungen aktualisieren }
        For i := Pred(Count) DownTo 0 do
          If (TGeoObj(Items[i]) is TGPolygon) and
             (TGPolygon(Items[i]).MyShape > 0) then begin
            nfo := TGArea.Create(Drawing, TGPolygon(Items[i]),
                                 TGPolygon(Items[i]).IsVisible, True);
            nfo.MyShape := TGPolygon(Items[i]).MyShape;
            nfo.MyBrushStyle := TGPolygon(Items[i]).MyBrushStyle;
            nfo.MyColour := TGPolygon(Items[i]).MyColour;
            Drawing.Insert(i+1, nfo);
            Inc(Drawing.LastValidObjIndex);
            end;

        { Bei alten Ortslinien Doppelte vermeiden }
        KillLocLineDoubles;
        end;
    end;

  procedure PatchOld26Objects;
    var i, j, k : Integer;

    procedure ReplaceTGLotWithTGSenkr;
      var oldObj : TGLot;
          newObj : TGSenkr;
          i : Integer;
      begin
      For i := 0 to Pred(Drawing.Count) do
        If TGeoObj(Drawing.Items[i]).ClassType = TGLot then begin
          oldObj := TGLot(Drawing.Items[i]);
          newObj := TGSenkr.CreateFrom(oldObj);
          Drawing.Items[i] := newObj;
          oldObj.Free;
          end;
      Drawing.UpdateAllLongLines;   // Orientierungen aktualisieren !
      end;

    procedure ReplaceOldDPWithIntersection(n: Integer);
      var ODPObj : TGDoublePt;
          ODP_P0,
          ODP_P1 : TGeoObj;
          OSPObj : TGSecondPt;
          NDIObj : TGDoubleIntersection;
          NFIObj,
          NSIObj : TGIntersectPt;
          j      : Integer;
      begin
      ODPObj := Drawing.Items[n];

      { 13.05.06: Die folgende IF-Konstruktion wurde ergänzt, um beim Import
                  alter Dateien die Produktion zusätzlicher funktionsloser
        Schnittpunkte zu unterbinden. Siehe z.B.:  Elschenbroich/Seebacher,
        Elektronische Arbeitsblätter, Kl. 9, Kapitel 1, a1-01.geo, a1-04.geo  }
      If (ODPObj.Children.Count = 0) and
         (Not ODPObj.IsVisible) then begin
        Drawing.FreeObject(ODPObj);
        Drawing.KillInvalidObjects;
        Exit;
        end;
      OSPObj := Nil;

      { Eltern des alten Doppelpunkt-Objekts merken,
        dann das Objekt von seinen Eltern abkoppeln  }
      ODP_P0 := ODPObj.Parent[0];
      ODP_P1 := ODPObj.Parent[1];
      While (ODPObj.Parent.Count > 0) and
            (Drawing.IndexOf(ODPObj.Parent[0]) >= 0) do
        ODPObj.Stops2BeChildOf(ODPObj.Parent[0]);
      ODPObj.Parent.Clear;

      { Neues Doppelpunkt-Objekt erzeugen }
      NDIObj := TGDoubleIntersection.Create(Drawing, ODP_P0, ODP_P1, False);
      NFIObj := TGIntersectPt.Create(Drawing, NDIObj, 0, ODPObj.IsVisible);

      { Altes SecondPt-Objekt suchen und vom Doppelpunkt-Objekt abkoppeln }
      For j := Pred(ODPObj.Children.Count) DownTo 0 do
        If TGeoObj(ODPObj.Children[j]) is TGSecondPt then begin
          OSPObj := ODPObj.Children[j];
          OSPObj.Stops2BeChildOf(ODPObj);
          end;

      { Alte Punkt-Position(en) merken: }
      If Assigned(OSPObj) then
        NDIObj.StoreOldPoints(ODPObj.X, ODPObj.Y, OSPObj.X, OSPObj.Y,
                              ODPObj.DataValid, OSPObj.DataValid)
      else
        NDIObj.StoreOldPoints(ODPObj.X, ODPObj.Y, -12345, -12345,
                              ODPObj.DataValid, FALSE);

      { Kinder übertragen : erst vom ersten Punkt.....}
      NFIObj.AdoptChildrenOf(ODPObj);

      { ....dann vom zweiten, wenn's denn einen gibt! }
      If OSPObj <> Nil then begin
        NSIObj := TGIntersectPt.Create(Drawing, NDIObj, 1, OSPObj.IsVisible);
        NSIObj.AdoptChildrenOf(OSPObj);
        end
      else
        NSIObj := Nil;

      { Alte Schnitt-Objekte durch neue ersetzen, Daten übernehmen }
      Drawing.Items[n] := NDIObj;
      Drawing.Insert(n+1, NFIObj);
      Drawing.LastValidObjIndex := Drawing.LastValidObjIndex + 1;
      If OSPObj <> Nil then begin
        j := Drawing.IndexOf(OSPObj);
        Drawing.Items[j] := NSIObj;
        NSIObj.PatchDataFrom(OSPObj);
        end;
      NFIObj.PatchDataFrom(ODPObj);

      { Alte Schnitt-Objekte löschen }
      ODPObj.Free;
      If OSPObj <> Nil then
        OSPObj.Free;
      end;

    begin { of PatchOld26Objects }
    If GFL <> 0 then Exit;

    { Alte TGLot-Objekte durch neue TSenkr-Objekte ersetzen: }
    ReplaceTGLotWithTGSenkr;

    { Alte Doppelpunkte durch neue DoubleIntersection ersetzen: }
    i := 0;   // Unbedingt While-Schleife! Objekt-Zahl ändert sich!
    While i <= Drawing.LastValidObjIndex do begin
      If TGeoObj(Drawing.Items[i]) is TGDoublePt then
        ReplaceOldDPWithIntersection(i);
      i := i + 1;
      end;

    { Ortslinien brauchen ein Update ihrer Elternliste,
      gebundene Basispunkte müssen in den Wartezustand : }
    For i := 0 to Pred(Drawing.Count) do
      If TGeoObj(Drawing.Items[i]) is TGLocLine then
        TGLocLine(Drawing.Items[i]).ResetParentList
      else
      if TGeoObj(Drawing.Items[i]).ClassType = TGPoint then
        with TGPoint(Drawing.Items[i]) do
          IsWaiting := Parent.Count > 0;

    { Orientierung der Doppelpunkte überprüfen : }
    i := 0; //Pred(Drawing.Count);
    While i < Drawing.Count {>= 0} do begin
      If TGeoObj(Drawing.Items[i]) is TGDoubleIntersection then begin
        TGDoubleIntersection(Drawing.Items[i]).CheckParent3(False);
        end;
      Inc(i);
      end;

    { Veraltete Abbildungs-Objekte durch modernere Varianten ersetzen : }
    i := 5;
    While i < Drawing.Count do begin
      k := 0;
      { 25.03.2007 : Die Untergrenze(!) der folgenden j-Schleife wurde
                     um 4 nach oben geschoben, um folgende Aufrufe von
        ConvertOldMappedObj2NewMappingObj() mit ungültigen Parametern
        zu vermeiden. Die ersten 4 der als "deprecated" gekennzeichneten
        Klassen in der Liste XMLTypeNames[] haben nämlich überhaupt
        nichts mit Abbildungen zu tun!
         ( Objekte der ersten 3 dieser "deprecated"-Klassen werden erst
           beim Speichern gepatcht; Objekte der 4. "deprecated"-Klasse
           (TGLot) wurden hingegen schon oben konvertiert.)            }
      For j := MaxXMLTypeIndex downto DeprTypeIndex + 4 do
        If TGeoObj(Drawing.Items[i]).ClassNameIs(XMLTypeNames[j, 0]) then
          k := j;
      If k > 0 then
        ConvertOldMappedObj2NewMappingObj(Drawing.Items[i]);
      i := i + 1;
      end;

    Drawing.SortObjects;
    end;  { of PatchOld26Objects }

  begin
  GFL := 8;    { Datei nicht gefunden }
  ppcm_corrfactor := 1.0;
  R := Nil;
  If FileExists(GeoFileName) then
    try
      GOS := TFileStream.Create(GeoFileName,
                                fmOpenRead or fmShareDenyWrite);
      GFL  := 4;   { Falsches Format }
      Logo := ReadOldStrFromStream(GOS, 10);
      If valid_version(Logo) then
        try
          GeoFileVersion := Copy(Logo, 8, 3);
          If CompareStr(Logo, 'EUKLID 2.0') < 0 then begin  { altes 16-Bit-Format }
            GOS.Read(idNum, SizeOf(idNum));
            If idNum = $93 then begin
              TempSL:= TStiftListe.Load(GOS);
              TempSL.Free;
              GOS.Read(idNum, SizeOf(idNum));
              end;
            If idNum = $94 then begin
              TempPL:= TPinselListe.Load(GOS);
              TempPL.Free;
              GOS.Read(idNum, SizeOf(idNum));
              end;
            If idNum = $95 then begin
              try
                TempGL:= TGeoObjListe.Load(GOS, Drawing.HostWinHandle,
                                           Drawing.ActCanvas, Drawing.WindowRect);
                TempGL.BackgroundColor := Drawing.BackgroundColor;
                Drawing.Free;
                Drawing:= TempGL;
                PatchData;
                PatchOld24Data;
                ReadTermsFromFile;
                GFL := 0;
                If Not Drawing.LinksOkay then   { prüft auf falsche Links, versucht Reparatur }
                  GFL := GFL or 2;
              except
                // do nothing !
              end; { of try }
              end;
            end

          else begin {!!!!!!!!!!!!!!! neues 32-Bit-Format !!!!!!!!!!!!}
            R    := TReader.Create(GOS, 4096);
            IntCRNr := R.ReadInteger;
            If IntCRNr <> 0 then begin
              IntCRNr   := IntCRNr XOR GeoFileCRMask;
              CRTextStr := R.ReadString;
              end
            else begin
              IntCRNr   := 0;
              CRTextStr := '';
              end;
            TempGL  := Drawing;
            Drawing := TGeoObjListe.Load32
                         (R, TempGL.HostWinHandle, TempGL.ActCanvas,
                          Nil, TempGL.WindowRect);
            TempGl.Free;
            Application.ProcessMessages;
            If IntCRNr > 0 then begin
              Drawing.CRNr        := IntCRNr;
              Drawing.CRText.Text := CRTextStr;
              end
            else begin
              Drawing.CRNr := 0;
              Drawing.CRText.Clear;
              end;
            file_PixelPerCentimeter := R.ReadFloat;
            If Abs(file_PixelPerCentimeter) > epsilon then
              ppcm_corrfactor := RoundTo(act_pixelPerXcm / file_PixelPerCentimeter, -3);
            ReadAdditionalSupportData(R);
            GFL := 0;       { Alles erfolgreich geladen.        }
            PatchOld24Data; { Ruft VirtualizeCoords auf ! }
            TGOrigin(Drawing.Items[0]).ExportBackPic2GeoList;
            end;
        except
          On E: Exception do
            If E is EStreamError then
              GFL := 128     { Falsche Daten im Stream }
            else
              GFL := 256;    { Mysteriöser Datei-Fehler }
        end; { of try-except }
      PatchOld26Objects;
    finally
      R.Free;
      GOS.Free;
      GOS := Nil;
      Result := GFL;
    end { of try-finally }
  else
    Result := GFL;
  end;



{---------- Neue GEO-XML-Dateien ----------------------------}

function MakXMLSave(actMacro: TMakro;
                    DomNode: IXMLNode) : Integer;
  var FName,
      FHelpTxt,
      FCmdList : IXMLNode;
      DomDoc   : IXMLDocument;
      ht       : String;
  begin
  try
    DomDoc := DomNode.ownerDocument;
    FName := DomDoc.createNode('name');
    FName.childNodes.Add(DomDoc.createNode(actMacro.Name, ntText));
    DomNode.childNodes.add(FName);

    FHelpTxt := DomDoc.createNode('helptext');
    ht := FormatAllBreaks(actMacro.HelpText); // Formatierung ergänzt 27.12.2009
    FHelpTxt.childNodes.add(DomDoc.createNode(ht, ntText));
    DomNode.childNodes.add(FHelpTxt);

    FCmdList := actMacro.CreateCmdsNode(DomDoc);
    DomNode.childNodes.add(FCmdList);
    Result := 0;
  except
    Result := 1
  end; { of try }
  end;


function CreateGeoDomDocFromDrawing(Drawing: TGeoObjListe;
                                    ValTabData: TValTabData;
                                    Check4JExp: Boolean): IXMLDocument;
  var OrgThousandSeparator,
      OrgDecimalSeparator : Char;
      FDoc  : IXMLDocument;
      FDraw : IXMLNode;

  function CreateMakListNode(DDoc: IXMLDocument): IXMLNode;
    var macList, actMac : IXMLNode;
        i               : Integer;
    begin
    macList := DDoc.createNode('macrolist');
    For i := 0 to Pred(Drawing.MakroList.Count) do begin
      actMac := DDoc.createNode('macro');
      If MakXMLSave(Drawing.MakroList[i], actMac) = 0 then
        macList.childNodes.add(actMac);
      end;
    Result := macList;
    end;

  begin
  OrgThousandSeparator := FormatSettings.ThousandSeparator;
  FormatSettings.ThousandSeparator    := #0;
  OrgDecimalSeparator  := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator     := '.';

  Drawing.KillInvalidObjects;
  FDoc := NewXMLDocument;
  try
    FDraw := FDoc.createNode('dg:drawing');
    FDraw.setAttribute('xmlns:dg', 'http://www.dynageo.com/xml/dg12');
    FDraw.setAttribute('xmlns:xsi',
         'http://www.w3.org/2001/XMLSchema-instance');
    FDraw.setAttribute('xsi:schemaLocation',
         'http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd');
    FDraw.childNodes.add(Drawing.CreateHeaderNode(FDoc));
    FDraw.childNodes.add(Drawing.CreateWindowNode(FDoc, ValTabData));
    If Drawing.MakroList.Count > 0 then
      FDraw.childNodes.add(CreateMakListNode(FDoc));
    FDraw.childNodes.add(Drawing.CreateObjListNode(FDoc, Check4JExp));
    If Drawing.GroupList.Count > 0 then
      FDraw.childNodes.add(Drawing.GroupList.CreateGroupListNode(FDoc));
    FDoc.DocumentElement := FDraw;
    Result := FDoc;
  except
    Result := Nil;
  end;

  FormatSettings.ThousandSeparator := OrgThousandSeparator;
  FormatSettings.DecimalSeparator  := OrgDecimalSeparator;
  end;


function GeoXmlFileSave(GeoFileName: String;
                        Drawing: TGeoObjListe;
                        ValTabData: TValTabData;
                        XMLFormat: TXMLOutputFormat;
                        Check4JExp: Boolean = False): Integer;
  var FDoc : IXMLDocument;
      XMLBuf : TMemoryStream;
      CompStream : TCompressionStream;
      FileStream : TFileStream;
      DataSize : Int64;

  function WriteXMLBufDataTo(fs: TFileStream): Boolean;
    { Killt alle Zeilen, die nur TAB, CR oder LF enthalten,
      also keine XML-Informationen tragen                   }
    var SL   : TStringList;
        ws   : String;
        cf   : Boolean;   // "C"har "F"ound
        i, k : Integer;
    begin
    SL := TStringList.Create;
    Try
      Try
        XMLBuf.Position := 0;
        SL.LoadFromStream(XMLBuf);
        i := 0;
        While i < SL.Count do begin
          ws := SL.Strings[i];
          CF := False;
          k  := 1;
          While (Not CF) and (k <= Length(ws)) do
            if CharInSet(ws[k], [#9, #10, #13]) then
              k := k + 1
            else
              CF := True;
          If CF then
            i := i + 1
          else
            SL.Delete(i);
          end;
        SL.SaveToStream(fs);
        Result := True;
      except
        Result := False;
      end;
    finally
      SL.Free;
    end;
    end;

  begin
  If FileAllowsWriting(GeoFileName) then begin
    FDoc  := CreateGeoDomDocFromDrawing(Drawing, ValTabData, Check4JExp);
    try
      FileStream := TFileStream.Create(GeoFileName, fmCreate or fmOpenWrite or fmShareExclusive);
      Result := 1;
      try
        If XMLFormat = fofCompressed then begin
          WriteOldStrToStream(FileStream, EuklidLogo);
          XMLBuf := TMemoryStream.Create;
          CompStream := TCompressionStream.Create(clMax, XMLBuf);
          FDoc.SaveToStream(CompStream);
          DataSize := CompStream.Position;
          FileStream.Write(DataSize, SizeOf(Int64));
          CompStream.Free;
          FileStream.CopyFrom(XMLBuf, 0);
          XMLBuf.Free;
          Result := 0;
          end
        else begin
          XMLBuf := TMemoryStream.Create;
          Try
            FDoc.SaveToStream(XMLBuf);
            If WriteXMLBufDataTo(FileStream) then
              Result := 0;
          finally
            XMLBuf.Free;
          end; { of try }
          end;
      finally
        FileStream.Free;
      end;  { of inner try }
    finally
      FDoc := Nil;
    end;  { of outer try }
    end   { of if }
  else
    Result := 2;
  end;

function GetLogo(stream: TMemoryStream): String;
  var n   : Integer;
      buf : AnsiString;
      s   : String;
  begin
  SetLength(buf, 20);
  stream.Read(buf[1], 20);
  s := String(buf);
  n := POS('<?xml', Lowercase(s));
  If n > 0 then begin          { unkomprimiertes XML }
    stream.Position := 0;         { Stream-Position auf den Anfang setzen;     }
    Result := Copy(s, n, 6);      { Störende Zeichen vor "<?xml" werden später }
    end                           {   von KillASCIITabsAndBreaks entfernt      }
  else begin
    n := POS('EUKLID', s);     { altes Binär-Format oder "XML 2.7" }
    If n > 0 then begin
      stream.Position := n + 9;   { Logo "EUKLID_x.y" überlesen und exakt      }
      Result := Copy(s, n, 10);   { positionieren für den Fall "XML zipped"    }
      end
    else begin                 { ??? Sollte nie passieren ! }
      stream.Position := 0;
      Result := s;
      end;
    end;
  end;

function MakXMLLoad(ObjList: TGeoObjListe; DomNode: IXMLNode): Integer;
  var newMakro : TMakro;
  begin
  If DomNode <> Nil then
    try
      newMakro := TMakro.CreateFromDomData(ObjList, DomNode);
      If newMakro <> Nil then begin
        ObjList.MakroList.Add(newMakro);
        Result := 0;
        end
      else
        Result := 1;
    except
      Result := 1;
    end
  else
    Result := 1;
  end;

procedure KillASCIITabsAndBreaks(MS: TMemoryStream);
  { 12.05.2012 : Um das Laden großer Bilder zu beschleunigen, wurde die
                 Funktion zum Bereinigen des XML-Quelltextes von störenden
    Zeilenvorschüben und Tabs stark vereinfacht: jetzt werden *alle*
    ControlCodes aus dem Quelltext entfernt. Allerdings werden dabei die
    langsamen String-Befehle wie "Delete()" vermieden; stattdessen wird der
    Quelltext Zeichen für Zeichen in eine neue String-Variable umkopiert.
    Dabei wird "on the fly" der ControlCodes-Filter angewendet. }

  var SL   : TStringList;
      s, t : String;
      i, n : Integer;

  begin
  MS.Position := 0;
  SL := TStringList.Create;
  try
    SL.LoadFromStream(MS);
    MS.Clear;
    t := SL.Text;
  finally
    SL.Free;
  end;

  n := Pos('<', t);       { Alles vor dem ersten Tag killen ! }
  If n > 1 then
    Delete(t, 1, n - 1);

  s := '';                { Alle ControlCodes [ Ord(c) < Ord(' ') ] killen ! }
  for i := 1 to Length(t) do
    if t[i] >= ' ' then
      s := s + t[i];
  SetLength(t, 0);

  MS.Write(s[1], Length(s));
  MS.Position := 0;
  SetLength(s, 0);
  end;

function GEOXMLFileLoad(GeoFileName    : String;
                        var Drawing    : TGeoObjListe;
                        var ValTabData : TValTabData): Integer;
  var OrgThousandSeparator,
      OrgDecimalSeparator : Char;
      MemStream : TMemoryStream;
      ExpStream : TDecompressionStream;
      XMLBuf    : TMemoryStream;
      OldGeoFileVersion,
      Logo      : String;
      DataSize  : Int64;
      DOMDoc    : IXMLDocument;
      FromXML   : Boolean;

  function GetMakrosFromDOMDoc: Integer;
    var DomMakList, DomMakro : IXMLNode;
    begin
    Result := 0;
    Drawing.MakroList.Clear;
    try
      DomMakList := DOMDoc.DocumentElement.ChildNodes.FindNode('macrolist', '');
      If DomMakList <> Nil then begin
        DomMakro := DomMakList.ChildNodes.FindNode('macro', '');
        While DomMakro <> Nil do begin
          Drawing.MakroList.Add(TMakro.CreateFromDomData(Drawing, DomMakro));
          DomMakro := DomMakList.ChildNodes.FindSibling(DomMakro, 1);
          end;
        end
    except
      Result := 1;
    end; { of try }
    end;

  function GetObjsFromDOMDoc: Integer;
    var new_drawing : TGeoObjListe;
        falseObjs   : String;
        old_cnt,
        new_cnt     : Integer;
    begin
    Result := 0;
    Try
      new_drawing := TGeoObjListe.CreateFromGeoDomData
                            (DOMDoc.DocumentElement, Drawing, ValTabData);
      Drawing.Free;
      Drawing := new_drawing;
      falseObjs := Drawing.CollectBuggyTermObjs;
      If Length(falseObjs) > 0 then begin
        old_cnt := Drawing.Count;
        Drawing.KillBuggyTermObjs;
        new_cnt := Drawing.Count;
        Result := new_cnt - old_cnt;
        SpyOut('objects that contain uncompilable terms: %s',  [falseObjs]);
        SpyOut('deleted these objects and their children, altogether %d objects', [-Result]);
        end;
      Case Drawing.KillUnknownObjects of
        0 : ;
        1 : MessageDlg(MyMess[60] + MyMess[61] + MyMess[63], mtInformation, [mbOk], 0);
        2 : MessageDlg(MyMess[60] + MyMess[62] + MyMess[63], mtWarning, [mbOk], 0);
      end; { of case }
      If Length(Drawing.LastEditVers) = 0 then
        Result := Result + 32  { Kein Programm gefunden }
      else
        Result := Result + GetMakrosFromDOMDoc;  // Hier werden die Makros geladen !!!
    except
      Result := 4; { Unbekanntes Format }
    end;
    end;

  var start : Cardinal;

  begin
  OrgThousandSeparator := FormatSettings.ThousandSeparator;
  FormatSettings.ThousandSeparator    := #0;
  OrgDecimalSeparator  := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator     := '.';
  FromXML              := True;
  OldGeoFileVersion    := GeoFileVersion;
  GeoFileVersion       := '';

  Result := 0;
  MemStream := TMemoryStream.Create;
  MemStream.LoadFromFile(GeoFileName);
  Logo := GetLogo(MemStream);          { setzt auch die MemStream.Position ! }
  If POS('xml', Lowercase(Logo)) > 0 then begin        { unkomprimiertes XML }
    try
      SpyOut(#0009 + 'Start building DOM tree from XML file data.', []);
      start := GetTickCount;
      KillASCIITabsAndBreaks(MemStream);
      DOMDoc := LoadXMLDocument(GeoFileName); // statt: fileToDom(GeoFileName);
      SpyOut(#0009 + 'Ready building DOM tree after %6.3f sec.',
              [ (GetTickCount - start)/1000 ]);
    except
      On EXMLDocError do Result := 64;
      else Result := 4;
    end;
    MemStream.Free;
    If Result = 0 then begin
      SpyOut(#0009 + 'Start building objects from DOM tree.', []);
      start := GetTickCount;
      Result := GetObjsFromDOMDoc;
      SpyOut(#0009 + 'Ready building objects after %6.3f sec.',
              [ (GetTickCount - start)/1000 ]);
      end;
    end
  else
    If POS('EUKLID', Logo) = 1 then
      If CompareStr(Logo, 'EUKLID 2.6') <= 0 then begin { altes Binär-Format  }
        MemStream.Free;
        FromXML := False;
        Result  := GeoFileLoad(GeoFileName, Drawing);
        end
      else begin                                        { komprimiertes XML   }
        MemStream.Read(DataSize, SizeOf(Int64));
        ExpStream := TDecompressionStream.Create(MemStream);
        XMLBuf := TMemoryStream.Create;
        XMLBuf.SetSize(LongInt(DataSize));
        ExpStream.Read(XMLBuf.Memory^, LongInt(DataSize));
        ExpStream.Free;
        MemStream.Free;
        DOMDoc := NewXMLDocument;
        DOMDoc.LoadFromStream(XMLBuf);
        XMLBuf.Free;
        Result := GetObjsFromDOMDoc;
        end
    else begin
      MemStream.Free;
      Result := 1;
      end;

  If Length(GeoFileVersion) = 0 then
    If (Drawing <> Nil) and (Length(Drawing.LastEditVers) > 0) then
      GeoFileVersion := Drawing.LastEditVers
    else if (Drawing <> Nil) and (Length(Drawing.CreationVers) > 0) then
      GeoFileVersion := Drawing.CreationVers;

  { 02.06.2011 :  Die folgende IF-Bedingung wurde nun von "i = 0" zu
                  "i <= 0" entschärft, um auch im Falle des Weglassens
    von Objekten mit unkompilierbaren Termen die Initialisierung der
    GeoObj-Liste (und damit der GEO-Objekte!) zu ermöglichen.          }
  If Result <= 0 then
    Drawing.AfterLoading(FromXML)
  else
    GeoFileVersion := OldGeoFileVersion;

  FormatSettings.ThousandSeparator := OrgThousandSeparator;
  FormatSettings.DecimalSeparator  := OrgDecimalSeparator;
  end;


{---------- BMP-Dateien ----------------------------------}

function BMPFileSave (R: TRect;
                      BmpFileName: String;
                      Drawing: TGeoObjListe;
                      outDPI: Integer = 0): Integer;
  { Rückgabewert   = 0 : alles okay !
                   = 1 : Fehler beim Schreiben der Datei
                   = 2 : Unbekannter Dateityp
                   = 3 : Nicht genügend Speicher          }
  var MyBitMap   : TBitmap;
      jpeg       : TJPEGImage;
      png        : TPngImage;
      fn_ext     : String;
      dx, dy     : Integer;
      scaleF,
      xul, yul,
      xlr, ylr   : Double;
      outStream  : TMemoryStream;
  begin
  Result := 0;
  If outDPI = 0 then
    scaleF := 1
  else
    scaleF := outDPI / (screenPPCmx * 2.54);
  With R do begin
    dx := Round((Right - Succ(Left)) * scaleF);
    dy := Round((Bottom - Succ(Top)) * scaleF);
    Drawing.GetLogCoords(Left,  Top,    xul, yul);
    Drawing.GetLogCoords(Right, Bottom, xlr, ylr);
    end;
  MyBitMap := TBitMap.Create;
  Try { für sichere Ressourcen-Freigabe }
    try
      MyBitMap.Width  := dx;
      MyBitMap.Height := dy;
      try
        If Abs(scaleF - 1) < 1e-5 then  // keine Neuskalierung nötig =>
          Drawing.Copy2Bitmap(MyBitMap, Point(R.Left, R.Top)) // Kopie vom Screen
        else                            // andernfalls: neu rendern !
          Drawing.ExportScaled_To(MyBitMap.Canvas, outFile,
                                  xul, yul, xlr, ylr, scaleF, 1);
        outStream := TMemoryStream.Create;
        try
          fn_ext := LowerCase(ExtractFileExt(BmpFileName));
          If (fn_ext = '.jpg') or
             (fn_ext = '.jpeg') then begin
            jpeg := TJPEGImage.Create;
            jpeg.Assign(MyBitMap);
            jpeg.SaveToStream(outStream);
            jpeg.Free;
            if outDPI > 0 then
              patch_DPIres_in_JPG_Stream(outStream, outDPI);
            outStream.SaveToFile(BmpFileName);
            end
          else
          If fn_ext = '.png' then begin
            png := TPngImage.Create;
            png.Assign(MyBitMap);
            if outDPI > 0 then begin
              png.PixelInformation.PPUnitX := Round (outDPI / 0.0254);
              png.PixelInformation.PPUnitY := Round (outDPI / 0.0254);
              end;
            png.SaveToStream(outStream);
            png.Free;
            outStream.SaveToFile(BmpFileName);
            end
          else
          If fn_ext = '.bmp' then begin
            MyBitMap.SaveToStream(outStream);
            if outDPI > 0 then
              patch_DPIres_in_BMP_Stream(outStream, outDPI);
            outStream.SaveToFile(BmpFileName)
            end
          else
            Result := 2;
        finally
          outStream.Free;
        end;
      except
        Result := 1;
      end;
    except
      Result := 3;
    end;
  finally
    MyBitMap.Free;
  end; { of try }
  end;


{---------- Meta-Dateien ----------------------------------}

function MetaFileSave(R: TRect; MetaFileName : String; Drawing: TGeoObjListe) : Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Schreiben der Datei   }
  var CopyCanvas : TCanvas;
      MyMetaFile : TMetaFile;
      orgX, orgY,
      dx, dy,
      MFS        : Integer;
  begin
  MFS := 0;
  With R do begin
    orgX  := Left;
    orgY  := Top;
    dx := Pred(Right - Succ(Left));
    dy := Pred(Bottom - Succ(Top));
    end;
  MyMetafile := TMetafile.Create;
  With MyMetafile do begin
    Width  := dx;
    Height := dy;
    { 25.05.06 Rückzug auf Pixelgröße angesichts der anisotropen
               Koordinatensysteme; schon zuvor gab es beim Export
               in eine Datei regelmäßig falsche Skalierungen!     }
//    MMWidth  := Round(dx * 1000 / act_pixelPerXcm);
//    MMHeight := Round(dy * 1000 / act_pixelPerYcm);
    end;
  try
    CopyCanvas := TMetafileCanvas.CreateWithComment
                   (MyMetafile, 0, 'EUKLID', EuklidLogo { + Filename });
    try
      with CopyCanvas do begin
        Font.Assign   (Drawing.StartFont);
        SetMapMode    (Handle, mm_text);
        SelectClipRgn (Handle, CreateRectRgn(0, 0, dx, dy));
        SetWindowExtEx(Handle, dx, dy, nil);
        SetWindowOrgEx(Handle, orgX, orgY, nil);
        end;
      Drawing.Export_To(CopyCanvas, R, 1);
//      If IsShareWare then with CopyCanvas do begin
//        Font.Color := clBlack;
//        TextOut(orgX + 20, orgY + 20, MyStartMsg[16]);
//        TextOut(orgX + 20, orgY + 50, MyStartMsg[17]);
//        end;
    finally
    CopyCanvas.Free;
    end; { of inner try }
    With MyMetaFile do begin
      Enhanced := UpperCase(ExtractFileExt(MetaFileName)) = '.EMF';
      SaveToFile(MetaFileName);
      end;
  except
    MFS := 1;
  end; { of outer try }
  MyMetaFile.Free;
  MetaFileSave := MFS;
  end;

{-------- HTML-Dateien --------------------------}

function RegisterDynaGeoX(ExePath: String): Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Browser nicht gefunden
                   =2 : Fehler beim Patchen der HTML-Datei  }
  var ViewerPath : String;
      HtmlData   : TStrings;
      BrowserWin : TBrowserWin;
      i          : Integer;
  begin
  Result := 2;
  ViewerPath := ExtractFilePath(ExePath) + 'viewer\';
  HtmlData := TStringList.Create;
  try
    With HtmlData do begin
      LoadFromFile(ViewerPath + 'InstallDGX_LocalSource.html');
      i := 0;
      While (i < Count) and
            (Pos('codebase', Strings[i]) = 0) do
        i := i + 1;
      If i < Count then begin
        Strings[i] := #9'codebase="file:///' + ViewerPath +
                      'dynageoxi.cab#version=3.1.0.0"';
        SaveToFile(ViewerPath + 'InstallDGX_LocalSource.html');
        Result := 1;
        end;
      end;
  finally
    HtmlData.Free;
  end;
  If Result = 1 then begin
    BrowserWin := TBrowserWin.CreateWD(Hauptfenster.PaintBox1,
                           ViewerPath + 'InstallDGX_LocalSource.html');
    BrowserWin.ShowModal;
    BrowserWin.Free;
    Result := 0;
    end;
  end;


{-------- Makro-Dateien -------------------------}

function MakXMLFileSave(MakFileName : String;
                        Drawing : TGeoObjListe;
                        MakNum  : Integer)   : Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Schreiben der Datei     }
  var FDoc       : IXMLDocument;
      FMak {, FName, FHelpTxt,
      FCmdList}   : IXMLNode;
      actMacro   : TMakro;
      FileStream : TFileStream;
      OrgThousandSeparator,
      OrgDecimalSeparator : Char;

  function CreateHeaderNode(DDoc: IXMLDocument): IXMLNode;
    var created : IXMLNode;
        s       : String;
    begin
    Result := DDoc.createNode('header');
    created := DDoc.createNode('created');
    created.setAttribute('prog_name', 'EUKLID DynaGeo');
    created.setAttribute('prog_version', FullVersionString(Application.ExeName));
    DateTimeToString(s, 'yyyy"-"mm"-"dd"T"hh":"nn":"ss', Now);
    created.setAttribute('date', s);
    Result.childNodes.add(created);
    end;

  begin
  OrgThousandSeparator := FormatSettings.ThousandSeparator;
  FormatSettings.ThousandSeparator    := #0;
  OrgDecimalSeparator  := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator     := '.';

  try
    FDoc  := NewXMLDocument;

    FMak  := FDoc.createNode('dg:macro');
    FMak.setAttribute('xmlns:dg', 'http://www.dynageo.com');
    FMak.setAttribute('xmlns:xsi',
         'http://www.w3.org/2001/XMLSchema-instance');
    FMak.setAttribute('xsi:schemaLocation',
         'http://www.dynageo.com D:/XML/xsv12/geotypes.xsd');

    FMak.childNodes.add(CreateHeaderNode(FDoc));

    actMacro := Drawing.MakroList[MakNum];
    If MakXMLSave(actMacro, FMak) = 0 then begin
      FDoc.DocumentElement := FMak;
      FileStream := TFileStream.Create(MakFileName, fmCreate or fmOpenWrite or fmShareExclusive);
      FDoc.SaveToStream(FileStream);
      FileStream.Free;
      FDoc := Nil;

      actMacro.FilePath := MakFileName;
      Result := 0;
      end
    else
      Result := 1;
  except
    Result := 1;
  end;

  FormatSettings.ThousandSeparator := OrgThousandSeparator;
  FormatSettings.DecimalSeparator  := OrgDecimalSeparator;
  end;


function MakFileLoad(MakFileName : String; Drawing: TGeoObjListe) : Integer;
  { Rückgabewert   =0 : alles okay !
                    1 : Falsches Dateiformat
                    2 : Datei nicht gefunden           }
  var mfl,
      id      : Integer;
      GOS     : TFileStream;
      TypName,
      Logo    : String;
      NewMak  : TMakro;
      R       : TReader;

  procedure RegisterMakro(nm : TMakro);
    begin
    nm.FilePath := MakFileName;
    Drawing.MakroList.Add(nm);
    Dec(mfl);   { => 0, d.h. alles okay }
    end;

  begin
  mfl := 2;    { Datei nicht  gefunden }
  GOS := Nil;
  R   := Nil;
  If FileExists(MakFileName) then
    try
      GOS  := TFileStream.Create(MakFileName,
                                 fmOpenRead or fmShareDenyWrite);
      R := TReader.Create(GOS, 4096);
      Dec(mfl);   { => 1, d.h. falsches Format }
      Logo := ReadOldStrFromStream(GOS, 10);
      If valid_version(Logo) then begin
        NewMak := Nil;
        If CompareStr(Logo, 'EUKLID 2.0') < 0 then begin  { altes 16-Bit-Format }
          id := ReadOldIntFromStream(GOS);
          If id = 145 then
            try
              NewMak := TMakro.Load(Drawing, GOS, MakFileName);
            except
              NewMak := Nil;
            end;
          end
        else begin  { neues 32-Bit-Format }
          TypName := R.ReadString;
          If AnsiUpperCase(TypName) =
             AnsiUpperCase(TMakro.ClassName) then
            try
              NewMak := TMakro.Load32(Drawing, R);
            except
              NewMak := Nil;
            end;
          end;
        If NewMak <> Nil then begin
          RegisterMakro(NewMak);    { Hier wird "mfl" auf Null gesetzt! }
          NewMak.ConvertOldObjects; { Hier wird eventuell "FilePath" gelöscht! }
          end;
        end;
    finally
      R.Free;
      GOS.Free;
    end; { of try }
  MakFileLoad := mfl;
  end;


function MakXMLFileLoad(MakFileName : String;
                        Drawing: TGeoObjListe) : Integer;
  { Rückgabewert   =0 : alles okay !
                    1 : Falsches Dateiformat
                    2 : Datei nicht gefunden           }
  var MemStream : TMemoryStream;
      Logo      : String;
      DomDoc    : IXMLDocument;
      DomData   : IXMLNode;
      newMacro  : TMakro;
      OrgThousandSeparator,
      OrgDecimalSeparator : Char;

  begin
  OrgThousandSeparator := FormatSettings.ThousandSeparator;
  FormatSettings.ThousandSeparator    := #0;
  OrgDecimalSeparator  := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator     := '.';

  If FileExists(MakFileName) then begin
    MemStream := TMemoryStream.Create;
    MemStream.LoadFromFile(MakFileName);
    If MemStream.Size > 0 then begin
      Logo := GetLogo(MemStream);
      MemStream.Free;
      If POS('xml', Lowercase(Logo)) > 0 then begin   { neues XML-Format    }
        DOMDoc  := LoadXMLDocument(MakFileName);
        DOMData := DOMDoc.documentElement;
        newMacro := TMakro.CreateFromDomData(Drawing, DOMData);
        If newMacro <> Nil then begin
          newMacro.FilePath := MakFileName;
          Drawing.MakroList.Add(newMacro);
          Result := 0;
          end
        else
          Result := 1;
        end
      else
        If POS('EUKLID', Logo) = 1 then               { altes Binär-Format  }
          Result := MakFileLoad(MakFileName, Drawing)
        else
          Result := 1;
      end
    else begin
      MemStream.Free;
      Result := 2;
      end
    end
  else
    Result := 2;

  FormatSettings.ThousandSeparator := OrgThousandSeparator;
  FormatSettings.DecimalSeparator  := OrgDecimalSeparator;
  end;


{ ----------- Verschiedenes ------------------- }


end.
