unit FileIO3;

interface

Uses Classes, XMLDoc, XMLIntf, GlobVars, GeoTypes,
     GeoLocLines, GeoConic, GeoHelper;

function I2GXMLFileLoad (fname: String;
                         var Drawing: TGeoObjListe;
                         var ValTabData: TValTabData): Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Lesen der Datei         }

function I2GXMLFileSave (fname: String;
                         Drawing: TGeoObjListe;
                         ValTabData: TValTabData;
                         PngPreviewStream: TStream): Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Schreiben der Datei     }


implementation

uses SysUtils, WSDLIntf, ZipForge, MathLib, FileIO, Windows;

{============ Tabellen und Hilfs-Routinen ==========================}

const maxETN = 9;
      ElementTypeXMLName  : Array [1..maxETN] of String =
           ('point', 'line', 'line_segment', 'directed_line_segment',
            'ray', 'vector', 'circle', 'conic', 'locus');

      ElementTypeGeoName  : Array [1..maxETN] of String =
           ('TGPoint', 'TGStraightLine', 'TGShortLine', 'TGShortLine',
            'TGHalfLine', 'TGVector', 'TGCircle', 'TGConic', 'TGLocLine');

      maxCXN = 39;
      ConstraintsXMLName  : Array [1..maxCXN] of String =
           ('free_point', 'free_line',
            'point_on_line', 'point_on_line_segment', 'point_on_circle',
            'line_through_point', 'line_through_two_points',
            'line_angular_bisector_of_three_points', 'line_angular_bisector_of_two_lines',
            'line_segment_by_points', 'directed_line_segment_by_points',
            'ray_from_point_and_vector', 'ray_from_point_through_point',
            'line_parallel_to_line_through_point', 'line_perpendicular_to_line_through_point',
            'point_intersection_of_two_lines',
            'midpoint_of_two_points', 'midpoint_of_line_segment', 'center_of_circle',
            'circle_by_center_and_radius', 'circle_by_center_and_point', 'circle_by_three_points',
            'intersection_points_of_two_circles', 'intersection_points_of_circle_and_line',
            'intersection_points_of_two_conics', 'intersection_points_of_conic_and_line',
            'other_intersection_point_of_two_circles', 'other_intersection_point_of_circle_and_line',
            'other_intersection_point_of_conic_and_line',
            'locus_defined_by_point_on_line', 'locus_defined_by_point_on_line_segment',
            'locus_defined_by_point_on_circle', 'locus_defined_by_point_on_locus',
            'endpoints_of_line_segment', 'starting_point_of_directed_line_segment', 'end_point_of_directed_line_segment',
            'starting_point_of_ray', 'vector_of_ray', 'line_segment_of_directed_line_segment');

      ConstrGeoTypeName   : Array [1..maxCXN] of String =
           ('TGPoint', '',
            'TGPoint', 'TGPoint', 'TGPoint',
            '', 'TGLongLine',
            'TGWHalb', '',
            'TGShortLine', 'TGShortLine',
            '', 'TGHalfLine',
            'TGParall', 'TGSenkr',
            'TGLxLPt',
            'TGMiddlePt', 'TGMiddlePt', 'TGMiddlePt',
            'TGXCircle', 'TGCircle', 'TGCircle3P',
            'TGDoubleIntersection', 'TGDoubleIntersection',
            'TGQuadIntersection', 'TGDoubleIntersection',
            'TGDoubleIntersection', 'TGDoubleIntersection',
            'TGDoubleIntersection',
            'TGLocLine', 'TGLocLine',
            'TGLocLine', 'TGLocLine',
            'EndPointsOfSegment', 'StartPointOfSegment', 'EndPointOfSegment',
            'StartPointOfRay', 'VectorOfRay', 'SegmentOfDirectedSegment');

function GetGeoTypeFromXMLType(XT: String): String;
  var i : Integer;
  begin
  Result := '';
  i := 0;
  While (i < maxETN) and (Result = '') do begin
    Inc(i);
    If ElementTypeXMLName[i] = XT then
      Result := ElementTypeGeoName[i];
    end;
  end;

function GetGeoTypeFromConstraint(ct: String): String;
  var i : Integer;
  begin
  Result := '';
  i := 0;
  While (i < maxCXN) and (Result = '') do begin
    Inc(i);
    If ConstraintsXMLName[i] = ct then
      Result := ConstrGeoTypeName[i];
    end;
  end;



{============ Interne Liste der Objekt-Skizzen ==========================}

type TObjScetch = class(TObject)
       public
         FId   : WideString;
         FType : String;
         coCnt : Integer;  // Coord Count
         coTyp : Integer;  // Possible values:  0: invalid;
                           //                   1: euclidian;
                           //                   2: homogeneous;
                           //                   3: polar;
                           //                   4: matrix;
         coord : TCNumberList;
         build : Boolean;
         constructor CreateFromElementsData(node: IXMLNode);
         destructor Destroy; override;
         function ReadCoordsFrom(node: IXMLNode): Integer;
         function IsValid: Boolean;
         function GetXYCoords(var x, y: Double): Boolean;
         function GetCoord(n: Integer; var cv: Double): Boolean;
       end;

type TObjScetchList = class(TList)
       protected
         function getScetch(n: Integer): TObjScetch;
       public
         constructor CreateFromElementsData(elements: IXMLNode);
         destructor Destroy; override;
         function GetObjById(id: WideString): TObjScetch;
         procedure MarkAsBuilt(sName: String);
         property scetch[n: Integer]: TObjScetch read getScetch;
       end;

{------------- TObjScetch ---------------------}

constructor TObjScetch.CreateFromElementsData(node: IXMLNode);
  var tName  : String;
      coNode : IXMLNode;
  begin
  Inherited Create;
  FId   := node.getAttribute('id');
  tName := node.nodeName;
  FType := GetGeoTypeFromXMLType(tName);
  coord := TCNumberList.create;
  build := False;
  if tName = 'locus' then
    coTyp := 1
  else
    coTyp := 0;  // invalid !!!
  If (Length(FType) > 0) and node.hasChildNodes then begin
    coNode := node.childnodes.FindNode('euclidean_coordinates');
    If coNode <> Nil then begin
      coCnt := ReadCoordsFrom(coNode);
      if coCnt = 2 then coTyp := 1;
      end
    else begin
      coNode := node.childNodes.FindNode('homogeneous_coordinates');
      If coNode <> Nil then begin
        coCnt := ReadCoordsFrom(coNode);
        if coCnt = 3 then coTyp := 2;
        end
      else begin
        coNode := node.childNodes.FindNode('polar_coordinates');
        if coNode <> Nil then begin
          coCnt := ReadCoordsFrom(coNode);
          if coCnt = 2 then coTyp := 3;
          end
        else begin
          coNode := node.ChildNodes.FindNode('matrix');
          if coNode <> Nil then begin
            coCnt := ReadCoordsFrom(coNode);
            if coCnt = 9 then coTyp := 4;
            end;
          end;
        end;
      end;
    end;
  end;

destructor TObjScetch.Destroy;
  begin
  coord.Free;
  Inherited Destroy;
  end;

function TObjScetch.ReadCoordsFrom(node: IXMLNode): Integer;
  var valNode,
      rNode, iNode : IXMLNode;
      valStr       : String;
      rpr, ipr     : Double;  // RealPartRead, ImgPartRead
      i            : Integer; // Counts the coordinate data sets read
  begin
  i := 0;
  valNode := node.childNodes.findNode('double');
  if valNode <> Nil then begin
    While valNode <> Nil do begin
      try
        valStr := valNode.NodeValue;
        if Uppercase(valStr) <> 'NAN' then begin
          coord.Add(TCNumber.create(AsFloat(valStr), 0));
          Inc(i);
          end;
      finally
        try
          valNode := valNode.NextSibling;
        except
          valNode := Nil;
        end;
      end;
      end;
    end
  else begin
    valNode := node.childNodes.findNode('complex');
    while valNode <> Nil do begin
      rNode := valNode.childNodes.findNode('double');
      if rNode <> Nil then begin
        iNode := rNode.NextSibling;
        if iNode <> Nil then
          try
            rpr := AsFloat(rNode.nodeValue);
            ipr := AsFloat(iNode.nodeValue);
            Inc(i);
            coord.Add(TCNumber.create(rpr, ipr));
          except
            // do nothing !
          end;
        end;
      try
        valNode := valNode.NextSibling;
      except
        valNode := Nil;
      end;
      end;
    end;
  Result := i;
  end;

function TObjScetch.IsValid: Boolean;
  begin
  Result := (coTyp > 0) and (Length(FType) > 0);
  end;

function TObjScetch.GetXYCoords(var x, y: Double): Boolean;
  var r, phi : Double;
  begin
  if IsValid then
    case coTyp of
      1 : begin
          x := coord.item[0].getRealPart;
          y := coord.item[1].getRealPart;
          end;
      2 : if coord.item[2].isZero then
            coTyp := 0
          else begin
            coord.item[0].divideBy(coord.item[2]);
            coord.item[1].divideBy(coord.item[2]);
            if coord.item[0].isReal and coord.item[1].isReal then begin
              x := coord.item[0].getRealPart;
              y := coord.item[1].getRealPart;
              end
            else
              coTyp := 0;
            end;
      3 : begin
          r   := coord.item[0].getRealPart;
          phi := coord.item[1].getRealPart;
          x := r * cos(phi);
          y := r * sin(phi);
          end;
    end; { of case }
  Result := IsValid;
  end;

function TObjScetch.GetCoord(n: Integer; var cv: Double): Boolean;
  begin
  if IsValid and (n < coCnt) then begin
    cv := coord.item[n].getRealPart;
    Result := True;
    end
  else
    Result := False;
  end;

{-----------------TObjScetchList --------------------}

constructor TObjScetchList.CreateFromElementsData(elements: IXMLNode);
  var Elem : IXMLNode;
      OS : TObjScetch;
  begin
  Inherited Create;
  Elem := elements.childNodes.First;
  While Elem <> Nil do begin
    OS := TObjScetch.CreateFromElementsData(Elem);
    If OS.IsValid then
      Add(OS)
    else
      OS.Free;
    Elem := Elem.NextSibling;
    end;
  end;

destructor TObjScetchList.Destroy;
  begin
  while Count > 0 do begin
    (TObjScetch(Items[0])).Free;
    Delete(0);
    end;
  Inherited Destroy;
  end;

function TObjScetchList.getScetch(n: Integer): TObjScetch;
  begin
  if (n >= 0) and (n < Count) then
    Result := TObjScetch(items[n])
  else
    Result := Nil;
  end;

function TObjScetchList.GetObjById(id: WideString): TObjScetch;
  var i : Integer;
  begin
  Result := Nil;
  i := 0;
  While (Result = Nil) and (i < Count) do
    if TObjScetch(Items[i]).FId = id then
      Result := Items[i]
    else
      Inc(i);
  end;

procedure TObjScetchList.MarkAsBuilt(sName: String);
  var actScetch : TObjScetch;
  begin
  actScetch := GetObjById(sName);
  if actScetch <> Nil then
    actScetch.build := True;
  end;

{======================= I2G-XML interpretieren =========================}

function GetObjectsFrom(root: IXMLNode; var Drawing: TGeoObjListe): Integer;
  var elements,
      constraints : IXMLNode;
      AliasList   : TStringList;
      ScetchList  : TObjScetchList;
      newDrawing  : TGeoObjListe;
      failCnt     : Integer;        // Anzahl der nicht geladenen Objekte

  function DecryptAlias(oriName: String): String;
    var n : Integer;
    begin
    n := AliasList.IndexOfName(oriName);
    if n < 0 then
      Result := oriName
    else
      Result := AliasList.ValueFromIndex[n];
    end;

  function newI2GBaseObject(aScetch: TObjScetch): TGeoObj;
    var x, y  : Double;
        c     : Array [1..9] of Double;
        i     : Integer;
    begin
    Result := Nil;
    try
      If aScetch.FType = 'TGPoint' then
        if aScetch.GetXYCoords(x, y) then
          Result := TGPoint.Create(newDrawing, x, y, True)
        else
      else if aScetch.FType = 'TGStraightLine' then begin
        for i := 1 to 3 do
          aScetch.GetCoord(Pred(i), c[i]);
        Result := TGBaseLine.CreateFromHesseEq(newDrawing, c[1], c[2], c[3], True);
        end
      else if aScetch.FType = 'TGCircle' then begin
        for i := 1 to 9 do
          aScetch.GetCoord(Pred(i), c[i]);
        Result := TGBaseCircle.CreateFromMat(newDrawing, c, True);
        end
      else if aScetch.FType = 'TGConic' then begin
        for i := 1 to 9 do
          aScetch.GetCoord(Pred(i), c[i]);
        Result := TGConic.CreateFromMat(newDrawing, c, True);
        end;
    except
      { Nothing to do !! }
    end;
    If Result <> Nil then
      Result.PatchName(aScetch.FId);
    end;

  function newI2GDepObject(GeoTypeName: String; outCnt: Integer;
                           args: TStrings): TGeoObj;
    var CarrierLine,
        Pa1, Pa2, Pa3 : TGeoObj;
        x, y, p : Double;
        sx, sy  : Integer;
    begin
    Result := Nil;
    try

      { Generatoren: die folgenden Anweisungen erzeugen jeweils ein Objekt,
        welches als "Result" zurückgegeben wird.                            }

      If GeoTypeName = 'TGPoint' then begin  // Basispunkt, auch an eine Linie gebunden
        if (ScetchList.GetObjById(args[0])).GetXYCoords(x, y) then begin
          newDrawing.GetWinCoords(x, y, sx, sy);
          Result := TGPoint.Create(newDrawing, sx, sy, True);
          if outCnt < args.Count then begin
            CarrierLine := newDrawing.GetGeoObjByName(args[outCnt]);
            If (CarrierLine <> Nil) and (CarrierLine is TGLine) then begin
              Result.BecomesChildOf(CarrierLine);
              (CarrierLine as TGLine).GetParamFromCoords(x, y, p);
              (Result as TGPoint).BoundParam := p;
              end;
            end;
          end;
        end
      else if GeoTypeName = 'TGLxLPt' then begin  // Schnittpunkt zweier gerader Linien
        Pa1 := newDrawing.GetGeoObjByName(args[1]);
        Pa2 := newDrawing.GetGeoObjByName(args[2]);
        If (Pa1 <> Nil) and (Pa2 <> Nil) then
          Result := TGLxLPt.Create(newDrawing, Pa1, Pa2, True);
        end
      else if GeoTypeName = 'TGMiddlePt' then begin  // Mittelpunkte:
        if args.Count = 2 then begin  // Mittelpunkt von Strecke, Kreis, Ellipse oder Hyperbel:
          Pa1 := newDrawing.GetGeoObjByName(args[1]);
          if Pa1 <> Nil then
            Result := TGMiddlePt.Create(newDrawing, Pa1, Nil, True);
          end
        else begin // args.Count = 3, also Mittelpunkt zwischen 2 Punkten:
          Pa1 := NewDrawing.GetGeoObjByName(args[1]);
          Pa2 := NewDrawing.GetGeoObjByName(args[2]);
          if (Pa1 <> Nil) and (Pa2 <> Nil) then
            Result := TGMiddlePt.Create(newDrawing, Pa1, Pa2, True);
          end;
        end
      else if GeoTypeName = 'TGShortLine' then begin  // Strecke
        Pa1 := newDrawing.GetGeoObjByName(args[1]);
        Pa2 := newDrawing.GetGeoObjByName(args[2]);
        If (Pa1 <> Nil) and (Pa2 <> Nil) then
          Result := TGShortLine.Create(newDrawing, Pa1, Pa2, True);
        end
      else if GeoTypeName = 'VectorOfRay' then begin  //  Vektor
        Pa1 := newDrawing.GetGeoObjByName(args[1]);  // Halbgerade!
        if Pa1 <> Nil then
          Result := TGVector.Create(newDrawing, Pa1.Parent[0], Pa1.Parent[1], True);
        end
      else if GeoTypeName = 'TGHalfLine' then begin   // Halbgerade
        Pa1 := newDrawing.GetGeoObjByName(args[1]);
        Pa2 := newDrawing.GetGeoObjByName(args[2]);
        If (Pa1 <> Nil) and (Pa2 <> Nil) then
          Result := TGHalfLine.Create(newDrawing, Pa1, Pa2, True);
        end
      else if GeoTypeName = 'TGLongLine' then begin   // Gerade
        Pa1 := newDrawing.GetGeoObjByName(args[1]);
        Pa2 := newDrawing.GetGeoObjByName(args[2]);
        If (Pa1 <> Nil) and (Pa2 <> Nil) then
          Result := TGLongLine.Create(newDrawing, Pa1, Pa2, True);
        end
      else if GeoTypeName = 'TGSenkr' then begin     // Senkrechte
        Pa1 := newDrawing.GetGeoObjByName(args[1]); // Punkt
        Pa2 := newDrawing.GetGeoObjByName(args[2]); // Gerade
        If (Pa1 <> Nil) and (Pa2 <> Nil) then
          Result := TGSenkr.Create(newDrawing, Pa1, Pa2, True);
        end
      else if GeoTypeName = 'TGParall' then begin     // Parallele
        Pa1 := newDrawing.GetGeoObjByName(args[1]);  // Punkt
        Pa2 := newDrawing.GetGeoObjByName(args[2]);  // Gerade
        If (Pa1 <> Nil) and (Pa2 <> Nil) then
          Result := TGParall.Create(newDrawing, Pa1, Pa2, True);
        end
      else if GeoTypeName = 'TGWHalb' then begin      // Winkelhalbierende
        Pa1 := newDrawing.GetGeoObjByName(args[1]);
        Pa2 := newDrawing.GetGeoObjByName(args[2]);
        Pa3 := newDrawing.GetGeoObjByName(args[3]);
        If (Pa1 <> Nil) and (Pa2 <> Nil) and (Pa3 <> Nil) then
          Result := TGWHalb.Create(newDrawing, Pa1, Pa2, Pa3, True);
        end
      else if GeoTypeName = 'TGCircle' then begin     // Kreis durch
        Pa1 := newDrawing.GetGeoObjByName(args[1]);  // Mittelpunkt
        Pa2 := newDrawing.GetGeoObjByName(args[2]);  // Kreispunkt
        If (Pa1 <> Nil) and (Pa2 <> Nil) then
          Result := TGCircle.Create(newDrawing, Pa1, Pa2, True);
        end
      else if GeoTypeName = 'TGCircle3P' then begin   // Kreis durch
        Pa1 := newDrawing.GetGeoObjByName(args[1]);  // 3 Kreispunkte
        Pa2 := newDrawing.GetGeoObjByName(args[2]);
        Pa3 := newDrawing.GetGeoObjByName(args[3]);
        If (Pa1 <> Nil) and (Pa2 <> Nil) and (Pa3 <> Nil) then
          Result := TGCircle3P.Create(newDrawing, Pa1, Pa2, Pa3, True);
        end
      else if GeoTypeName = 'TGDoubleIntersection' then begin // Schnitt-Doppelpunkt
        Pa1 := newDrawing.GetGeoObjByName(args[2]);  // Kreis;             Kegelschnitt
        Pa2 := newDrawing.GetGeoObjByName(args[3]);  // Kreis oder Gerade; Gerade
        if (Pa1 <> Nil) and (Pa2 <> Nil) then
          Result := TGDoubleIntersection.Create(newDrawing, Pa2, Pa1, True);
        end
      else if GeoTypeName = 'TGQuadIntersection' then begin // Schnitt-Vierfachpunkt
        Pa1 := newDrawing.GetGeoObjByName(args[4]);  // Kegelschnitt
        Pa2 := newDrawing.GetGeoObjByName(args[5]);  // Kegelschnitt
        if (Pa1 <> Nil) and (Pa2 <> Nil) then
          Result := TGDoubleIntersection.Create(newDrawing, Pa2, Pa1, True);
        end
      else if GeoTypeName = 'TGLocLine' then begin    // Ortslinie
        Pa1 := newDrawing.GetGeoObjByName(args[1]);  // Generator-Punkt
        Pa2 := newDrawing.GetGeoObjByName(args[2]);  // Zug-Punkt
        Pa3 := newDrawing.GetGeoObjByName(args[3]);  // Trägerlinie des Zug-Punkts
        if (Pa1 <> Nil) and (Pa2 <> Nil) and (Pa3 <> Nil) then begin
          if (Pa3 is TGLocLine) and (Pa2 = (Pa3 as TGLocLine).Parent.Last) then
            Pa2 := Pa3.Parent[0];
          Result := TGLocLine.CreateFromI2G(newDrawing, Pa1, Pa2, True);
          Result.AfterLoading();
          end;
        end

      { Emulationen : die folgenden Anweisungen führen nicht zur Erzeugung neuer Objekte;
        stattdessen übernehmen schon vorhandene Objekte der DynaGeo-Zeichnung über eine
        Alias-Liste die Funktionen der angeforderten Objekte. }

      else if (GeoTypeName = 'StartPointOfSegment') or     // Startpunkt einer Strecke
              (GeoTypeName = 'StartPointOfRay') then begin //       oder eines Strahls
        Pa1 := newDrawing.GetGeoObjByName(args[1]);  // Strecke oder Halbgerade
        AliasList.Add(args[0] + AliasList.NameValueSeparator + TGeoObj(Pa1.Parent[0]).Name);
        ScetchList.MarkAsBuilt(args[0]);
        Dec(failCnt); // Zur vorauseilenden Kompensation des späteren "Inc(failCnt)" !
        end
      else if GeoTypeName = 'EndPointOfSegment' then begin  // Endpunkt einer Strecke
        Pa1 := newDrawing.GetGeoObjByName(args[1]);  // Strecke
        AliasList.Add(args[0] + AliasList.NameValueSeparator + TGeoObj(Pa1.Parent[1]).Name);
        ScetchList.MarkAsBuilt(args[0]);
        Dec(failCnt); // Zur vorauseilenden Kompensation des späteren "Inc(failCnt)" !
        end
      else if GeoTypeName = 'EndPointsOfSegment' then begin // Start- und Endpunkt einer Strecke
        Pa1 := newDrawing.GetGeoObjByName(args[2]);  // Strecke
        AliasList.Add(args[0] + AliasList.NameValueSeparator + TGeoObj(Pa1.Parent[0]).Name);
        AliasList.Add(args[1] + AliasList.NameValueSeparator + TGeoObj(Pa1.Parent[1]).Name);
        ScetchList.MarkAsBuilt(args[0]);
        ScetchList.MarkAsBuilt(args[1]);
        Dec(failCnt); // Zur vorauseilenden Kompensation des späteren "Inc(failCnt)" !
        end
      else if GeoTypeName = 'SegmentOfDirectedSegment' then begin  // gerichtete Strecke ==> Strecke
        AliasList.Add(args[0] + AliasList.NameValueSeparator + args[1]);
        ScetchList.MarkAsBuilt(args[0]);
        Dec(failCnt); // Zur vorauseilenden Kompensation des späteren "Inc(failCnt)" !
        end


      { Fehlermeldung bei unbekanntem Typ: }
      else
        SpyOut('Unknown GeoTypeName "%s"!', [GeoTypeName]);

    except
      SpyOut('Error while processing "%s" command!', [GeoTypeName]);
    end;
    If (Result <> Nil) and Not (Result is TGDoubleIntersection) then
      Result.PatchName(args[0]);
    end;

  function BuildDrawingFromConstraints: Boolean;
    var cnstr,
        arg         : IXMLNode;
        GeoTypeName,
        nameStr     : String;
        actObj,
        newObj      : TGeoObj;
        args        : TStringList;
        actScetch   : TObjScetch;
        outCnt,                    // Anzahl der "out"-Parameter
        err,
        i           : Integer;
    begin
    failCnt := 0;
    cnstr := constraints.childNodes.First;
    args := TStringList.Create;
    try
      { Alle durch constraints definierten Objekte erzeugen }
      While cnstr <> Nil do begin
        GeoTypeName := GetGeoTypeFromConstraint(cnstr.nodeName);
        If Length(GeoTypeName) > 0 then begin // Neues Objekt erzeugen
          args.Clear;
          outCnt  := 0;
          arg := cnstr.childNodes.First;
          While arg <> Nil do begin
            nameStr := DecryptAlias(arg.NodeValue);
            If arg.hasAttribute('out') and (UpperCase(arg.getAttribute('out')) = 'TRUE') then begin
              args.Insert(outCnt, nameStr);
              Inc(outCnt);
              end
            else
              args.Add(nameStr);   // Hinten anfügen !
            arg := arg.NextSibling;
            end;
          { Die folgende Schleife iteriert über alle "Nicht-OUT"-Parameter !}
          For i := outCnt to Pred(args.Count) do begin
            { Noch nicht vorhandene Argumente als Basisobjekte erzeugen: }
            If newDrawing.GetGeoObjByName(args[i]) = Nil then begin
              actScetch := ScetchList.GetObjById(args[i]);
              newObj := newI2GBaseObject(actScetch);
              If newObj <> Nil then begin
                newDrawing.InsertObject(newObj, err);
                actScetch.build := True;
                end
              else
                Inc(failCnt);
              end;
            end;
          { Das im aktuellen "constraint" beschriebene Objekt erzeugen: }
          newObj := newI2GDepObject(GeoTypeName, outCnt, args);
          If newObj <> Nil then begin
            newDrawing.InsertObject(newObj, err);
            if newObj is TGDoubleIntersection then begin
              { Sonderbehandlung für Mehrfach-Schnitt-Objekte: }
              i := 0;
              While i < outCnt do begin
                actObj := newDrawing.InsertObject(TGIntersectPt.Create(newDrawing, newObj, i, True), err);
                actObj.PatchName(args[i]);
                ScetchList.MarkAsBuilt(args[i]);
                i := i + 1;
                end;
              end
            else
              { Normalbehandlung für alle anderen Objekte: }
              ScetchList.MarkAsBuilt(newObj.Name);
            end
          else
            Inc(failCnt);
          end
        else begin // Kein passendes Objekt in DynaGeo verfügbar!
          Inc(failCnt);
          SpyOut('Failed to process the constraint "%s"!', [cnstr.nodeName]);
          end;
        cnstr := cnstr.NextSibling;
        end;
      { Alle nicht durch constraints definierten Elemente, die bisher noch nicht
        als Eltern anderer Objekte erzeugt wurden, als Basisobjekte erzeugen }
      for i := 0 to ScetchList.Count - 1 do begin
        actScetch := ScetchList.scetch[i];
        if Not actScetch.build then begin
          newObj := newI2GBaseObject(actScetch);
          if newObj <> Nil then
            newDrawing.InsertObject(newObj, err);
          end;
        end;
    finally
      args.Free;
    end; { of try }
    Result := newDrawing.Count > 0;
    end;

  begin { of GetObjectsFrom() }
  Result := 1;
  elements    := root.childNodes.findNode('elements');
  constraints := root.childNodes.findNode('constraints');
  ScetchList  := TObjScetchList.CreateFromElementsData(elements);
  AliasList   := TStringList.Create(True);
  try
    newDrawing  := TGeoObjListe.CreateFromI2GData(Nil, Drawing);
    If BuildDrawingFromConstraints then begin
      Drawing.Free;
      Drawing := newDrawing;
      Drawing.UpdateAllObjects;
      Result := -failCnt;
      end;
  finally
    ScetchList.Free;
    AliasList.Free;
  end;
  end;  { GetObjectsFrom() }


{======================== I2G-Datei laden ===============================}

function I2GXMLFileLoad (fname: String;
                         var Drawing: TGeoObjListe;
                         var ValTabData: TValTabData): Integer;
  var OrgThousandSeparator,
      OrgDecimalSeparator : Char;
      Zipper    : TZipForge;
      ArchItem  : TZFArchiveItem;
      XMLStream : TMemoryStream;
      XMLDoc    : IXMLDocument;
      construct : IXMLNode;
      newDrawing: TGeoObjListe;

  begin
  OrgThousandSeparator := FormatSettings.ThousandSeparator;
  FormatSettings.ThousandSeparator    := #0;
  OrgDecimalSeparator  := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator     := '.';

  Result := 4;   // Unbekanntes Format !
  zipper := TZipForge.Create(Nil);
  try
    zipper.FileName := fname;
    zipper.OpenArchive(fmOpenRead);
    if zipper.FindFirst('private\de.dynageo\dynageo.xml', ArchItem) then begin
      XMLStream := TMemoryStream.Create;
      try
        XMLStream.Clear;
        zipper.ExtractToStream(ArchItem.StoredPath + ArchItem.FileName, XMLStream);
        XMLStream.Position := 0;      // Unbedingt zurücksetzen!!!
        XMLDoc := NewXMLDocument;
        XMLDoc.LoadFromStream(XMLStream);
        newDrawing := TGeoObjListe.CreateFromGeoDomData(
                            XMLDoc.documentElement, Drawing, ValTabData);
        If newDrawing <> Nil then begin
          Drawing.Free;
          Drawing := newDrawing;
          Result := 0;
          end;
      finally
        XMLDoc := Nil;
        XMLStream.Free;
      end; { of try }
      end
    else begin
      if zipper.FindFirst('construction\*.xml', ArchItem) then begin
        XMLStream := TMemoryStream.Create;
        try
          XMLStream.Clear;
          zipper.ExtractToStream(ArchItem.StoredPath + ArchItem.FileName, XMLStream);
          XMLStream.Position := 0; // SkipCommentsIn(XMLStream);
          XMLDoc := NewXMLDocument;
          XMLDoc.LoadFromStream(XMLStream);
          if XMLDoc.DocumentElement.NodeName = 'construction' then
            construct := XMLDoc.DocumentElement
          else
            construct := XMLDoc.DocumentElement.childNodes.findNode('construction');
          If construct <> Nil then
            Result := GetObjectsFrom(construct, Drawing);
        finally
          XMLDoc := Nil;
          XMLStream.Free;
        end; { of try }
        end;
      end;
    zipper.CloseArchive;
  finally
    zipper.Free;
  end;  { of try }

  FormatSettings.ThousandSeparator := OrgThousandSeparator;
  FormatSettings.DecimalSeparator  := OrgDecimalSeparator;
  end;

{======================== I2G-Datei speichern ===========================}

function I2GXMLFileSave(fname: String;
                        Drawing: TGeoObjListe;
                        ValTabData: TValTabData;
                        PngPreviewStream: TStream): Integer;

  var zipper    : TZipForge;
      DOMDoc    : IXMLDocument;
      XMLStream : TMemoryStream;

  function CreateI2GDomDocFromDrawing: IXMLDocument;
    var OrgThousandSeparator,
        OrgDecimalSeparator : Char;
        root, elem, el, co,
        constr : IXMLNode;
        ObjIds : TStringList;
        AGO    : TGeoObj;
        i      : Integer;
    begin
    OrgThousandSeparator := FormatSettings.ThousandSeparator;
    FormatSettings.ThousandSeparator    := #0;
    OrgDecimalSeparator  := FormatSettings.DecimalSeparator;
    FormatSettings.DecimalSeparator     := '.';

    Result := NewXMLDocument;
    root := Result.createNode('construction');
    ObjIds := TStringList.Create;
    try
      elem := Result.createNode('elements');
      constr := Result.createNode('constraints');

      { "elements"-Abschnitt mit Daten füllen }
      For i := 5 to Drawing.LastValidObjIndex do begin
        el := TGeoObj(Drawing.Items[i]).CreateI2GElementNode(Result);
        If el <> Nil then begin
          elem.childNodes.add(el);
          ObjIds.Add(TGeoObj(Drawing.Items[i]).Name);
          end;
        end;

      { "constraints"-Abschnitt mit Daten füllen }
      For i := 0 to Pred(ObjIds.Count) do begin
        AGO := Drawing.GetGeoObjByName(ObjIds.Strings[i]);
        If AGO <> Nil then begin
          co := AGO.CreateI2GConstraintNode(Result, ObjIds);
          If co <> Nil then
            constr.childNodes.add(co)
          else begin
            ObjIds.Free;
            Result := Nil;
            Exit;
            end;
          end;
        end;
    finally
      ObjIds.Free;
    end;

    root.childNodes.add(elem);
    root.childNodes.add(constr);
    Result.childNodes.add(root);

    FormatSettings.ThousandSeparator := OrgThousandSeparator;
    FormatSettings.DecimalSeparator  := OrgDecimalSeparator;
    end;

  begin { of I2GXMLFileSave }
  Result := 0;
  zipper := TZipForge.Create(Nil);
  zipper.FileName := fname;
  if SysUtils.FileExists(fname) then
    SysUtils.DeleteFile(fname);
  zipper.OpenArchive(fmCreate);
  XMLStream := TMemoryStream.Create;
  try
    try
      DOMDoc := CreateI2GDomDocFromDrawing;
      DomDoc.SaveToStream(XMLStream);
      XMLStream.Position := 0;
      zipper.AddFromStream('construction\intergeo.xml', XMLStream, True, 0, XMLStream.Size);
      DomDoc := Nil;
      XMLStream.Clear;
      zipper.AddFromStream('construction\preview.png', PngPreviewStream);
      DomDoc := CreateGeoDomDocFromDrawing(Drawing, ValTabData, False);
      DomDoc.SaveToStream(XMLStream);
      XMLStream.Position := 0;
      zipper.AddFromStream('private\de.dynageo\dynageo.xml', XMLStream);
      zipper.CloseArchive;
      DomDoc := Nil;
      XMLStream.Clear;
    except
      Result := 1;
    end;
  finally
    XMLStream.Free;
    zipper.Free;
  end; { of try }
  end; { of I2GXMLFileSave }


end.
