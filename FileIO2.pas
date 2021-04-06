unit FileIO2;

interface

Uses Classes, Forms, SysUtils, GeoTypes, XMLIntf,
     HTMLDynaGeoXSettings, HTMLDynaGeoJSettings;

{------- Helpers -----------------------------------------------------------}

function GeoFileAlreadySaved   (geoFilePath : String;
                                isDirty     : Boolean    ): Boolean;
  { Rückgabewert true <==> Zeichnung im aktuellen Zustand schon gespeichert }

{------- DynaGeoX - Export -------------------------------------------------}

function HTMLDynaGeoXFileSave  (FileName    : String;
                                HTMLData    : THTMLDynaGeoXDataForm;
                                AddToolBarSpace : Boolean): Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Schreiben der Datei     }

{-------- DynaGeoJ - Export ------------------------------------------------}

function AllObjectsJExportable (Drawing  : TGeoObjListe  ): Boolean;

function HTMLDynaGeoJFileSave  (FileName : String;
                                HTMLData : THTMLDynaGeoJDataForm;
                                AddToolBarSpace : Boolean): Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Schreiben der Datei     }



implementation

Uses Utility, GlobVars, GeoVerging, GeoConic, GeoLocLines,
     GeoTransf, GeoImage, Controls, Dialogs;

{=================== Private Helper Functions ======================}

function HTMLEquivalent(source: String): String;
  { Transformiert einen ASCII-Text in eine vom
    HTML-Browser interpretierbare Form:
    -  Harte ASCII-Zeilenumbrüche ($0D$0A) werden durch <br> ersetzt.
    -  jedes <br> erhält genau ein nachfolgendes $0D$0A angehängt,
         falls da noch keins kommt.
    -  Außerdem werden die deutschen Sonderzeichen nach HTML
         konvertiert.                                                 }
  var buf : String;

  begin
  buf := source;
  Replace('<br>', '<_br_>', buf);         { Schon vorhandene HTML-Breaks durch    }
  Replace('<BR>', '<_br_>', buf);         {   workbreaks ersetzen                 }
  Replace('<_br_>'#13#10, '<_br_>', buf); { "Doppelte" LineFeeds erst einmal raus }
  Replace(#13#10, '<_br_>', buf);         { ASCII-CRLFs durch workbreaks ersetzen }
  Replace('<_br_>', '<br>'#13#10, buf);   { Endgültige LineFeed-Codes setzen      }

  Replace('ä', '&auml;', buf);            { Deutsche Sonderzeichen ersetzen       }
  Replace('ö', '&ouml;', buf);
  Replace('ü', '&uuml;', buf);
  Replace('ß', '&szlig;', buf);
  Replace('Ä', '&Auml;', buf);
  Replace('Ö', '&Ouml;', buf);
  Replace('Ü', '&Uuml;', buf);

  Result := buf;
  end;

{=========== Public Functions =========================}

function GeoFileAlreadySaved   (geoFilePath : String;
                                isDirty     : Boolean    ): Boolean;
  begin
  If (Pos(MyFileMsg[12], UpperCase(geoFilePath)) = 0) and
     FileExists(geoFilePath) then
    if isDirty then
      Result := MessageDlg(MyFileMsg[36], mtConfirmation, [mbYes, mbNo], 0) = mrYes
    else
      Result := true
  else begin
    MessageDlg(MyFileMsg[35], mtWarning, [mbOk], 0);
    Result := false;
    end;
  end;

{----------- DynaGeoX-HTML-Dateien --------------------}

function HTMLDynaGeoXFileSave(FileName        : String;
                              HTMLData        : THTMLDynaGeoXDataForm;
                              AddToolBarSpace : Boolean             ): Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Schreiben der Datei     }
  var SL, BL : TStringList;
      dS, dE,
      dW, i  : Integer;
  begin
  Result := 0;
  try
    If AddToolBarSpace then dW := 50 else dW :=  0;
    SL := TStringList.Create;
    try
      SL.Sorted := False;
      If FileExists(FileName) and                // Vorhandene Datei editieren
         (HTMLData.TagStartLine > 0) then begin
        SL.LoadFromFile(FileName);
        dS := HTMLData.TagStartLine;                 // Das komplette
        If SearchForw('</object>', SL, dS, dE) then  // komplette
          For i := dE downto dS do                   // object-Tag
            SL.Delete(i);                            // löschen
        end
      else begin                                 // Neue Datei schreiben !
        SL.Add('<HTML>');
        SL.Add('<HEAD>');
        SL.Add('<TITLE>EUKLID DynaGeoX: ' + ExtractFileName(FileName) + ' </TITLE>');
        SL.Add('<META NAME="Generator" CONTENT="' + ProjectName +
               ' ' + EuklidVersionString + '">');
        SL.Add('</HEAD>');
        SL.Add('<BODY>');
        HTMLData.TextFirstLine := SL.Count;      // ergänzt 23.02.08, V3.1 Beta04
        With HTMLData.PreText do
          If Lines.Count > 0 then
            SL.Add(HTMLEquivalent(Text) + '<br>');
        HTMLData.TextLastLine := Pred(SL.Count); // ergänzt 23.02.08, V3.1 Beta04
        SL.Add('<br>');
        SL.Add('<center>');
        dS := SL.Count;
        SL.Add('</center><br>');
        SL.Add('</BODY>');
        SL.Add('</HTML>');
        end;

      If HTMLData.IsNewTag then begin
        SL.Insert(dS,     '<br>');
        SL.Insert(dS + 1, '<center>');
        dS := dS + 2;
        end;
      SL.Insert(dS    , '<object ');
      SL.Insert(dS + 1, #9'classid="clsid:2EF98DE5-183F-11D4-83EC-EC6A1DB6E213"');
      SL.Insert(dS + 2, #9'codebase="' + HTMLData.EditViewerPath.Text +
                        '#version=4,0,0,0"');
      SL.Insert(dS + 3, #9'width="' + IntToStr(HTMLData.IEditWinWidth.Value + dW) + '"');
      SL.Insert(dS + 4, #9'height="' + IntToStr(HTMLData.IEditWinHeight.Value) + '"');
      SL.Insert(dS + 5, '>');
      SL.Insert(dS + 6, '<param name="DataFile" value="' +
                        ExtractFileName(HTMLData.GEOFilePath) + '">');
      SL.Insert(dS + 7, '</object><br>');
      If HTMLData.IsNewTag then
        SL.Insert(dS + 8, '</center><br>');

      { 06.12.2006 : Ergänzt, damit man Änderungen am "Text oberhalb des
                     DynaGeoX-Objekts" eintragen kann }
      If HTMLData.TextFirstLine > 0 then begin
        If HTMLData.TextFirstLine <= HTMLData.TextLastLine then
          For i := HTMLData.TextLastLine DownTo HTMLData.TextFirstLine do
            SL.Delete(i)
        else
          SL.Delete(HTMLData.TextFirstLine);
        end
      else
        HTMLData.TextFirstLine := dS - 2;
      If HTMLData.PreText.Lines.Count > 0 then begin
        BL := TStringList.Create;
        try
          BL.Text := HTMLEquivalent(HTMLData.PreText.Text);
          For i := Pred(BL.Count) downTo 0 do
            SL.Insert(HTMLData.TextFirstLine, BL.Strings[i]);
        finally
          BL.Free;
        end; { of inner try }
        end;
      With HTMLData.EditAuthorName do
        If Length(Text) > 0 then
          If Pos('NAME="Author"', SL.Strings[3]) > 0 then
            SL.Strings[3] := '<META NAME="Author" CONTENT="' + Text + '">'
          else
            SL.Insert(3, '<META NAME="Author" CONTENT="' + Text + '">');
      SL.SaveToFile(HTMLData.HTMLFilePath);
    finally
      SL.Free;
    end;
  except
    on EFCreateError do begin  { Schreibgeschütztes Ziel ? }
      raise Exception.CreateFmt(MyFileMsg[9] + MyFileMsg[10], [FileName]);
      Result := 1;
      end;
    on EStreamError do begin   { sonstiger Stream-Fehler   }
      raise Exception.CreateFmt(MyFileMsg[9], [FileName]);
      Result := 1;
      end;
    else begin                 { unbekannter Fehler        }
      raise Exception.CreateFmt(MyFileMsg[0], [FileName]);
      Result := 1;
      end;
  end; { of try }
  end;


{------------- DynaGeoJ-HTML-Dateien --------------------}

function AllObjectsJExportable(Drawing : TGeoObjListe): Boolean;
  var oc      : TGeoObj;
      msg     : String;
      cnt,
      i       : Integer;
  begin
  Drawing.ResetAllMarks;
  cnt := 0;
  i   := 0;
  While i <= Drawing.LastValidObjIndex do begin
    oc := Drawing.Items[i];
    if Not canJexport(oc) then begin
      oc.IsMarked := True;
      cnt := cnt + 1;
      end;
    i := i + 1;
    end;
  If cnt > 0 then begin
    msg := Format(MyMess[149],
                  [IntToStr(Drawing.LastValidObjIndex),
                   IntToStr(Drawing.MarkedObjCount)]) + #13#10;
    For i := 0 to Drawing.LastValidObjIndex do begin
      oc  := Drawing.Items[i];
      if oc.IsMarked then
        msg := msg + '     ' + oc.ClassName + '  ' + oc.Name + #13#10;
      end;
    msg := msg + #10 + MyMess[150];
    Result := MessageDlg(msg, mtWarning, [mbYes, mbNo], 0) = mrYes;
    end
  else
    Result := True;
  Drawing.ResetAllMarks;
  end;


function HTMLDynaGeoJFileSave(FileName : String;
                              HTMLData : THTMLDynaGeoJDataForm;
                              AddToolBarSpace : Boolean): Integer;
  { Rückgabewert   =0 : alles okay !
                   =1 : Fehler beim Schreiben der Datei     }

  function GetLanguageID: String;
    begin
    if Length(EuklidLanguage) >= 2 then
      Result := LowerCase(Copy(EuklidLanguage, 1, 2))
    else
      Result := 'de';
    end;

  var SL, BL : TStringList;
      buf    : String;
      dS, dE,
      dW, i  : Integer;
  begin
  Result := 0;
  try
    If AddToolBarSpace then dW := 50 else dW :=  0;
    SL := TStringList.Create;
    try
      SL.Sorted := False;
      If FileExists(FileName) and                // Vorhandene Datei editieren
         (HTMLData.TagStartLine > 0) then begin
        SL.LoadFromFile(FileName);
        dS := HTMLData.TagStartLine;                 // Das komplette
        If SearchForw('</applet>', SL, dS, dE) then  // komplette
          For i := dE downto dS do                   // applet-Tag
            SL.Delete(i);                            // löschen
        end
      else begin                                 // Neue Datei schreiben !
        SL.Add('<HTML>');
        SL.Add('<HEAD>');
        SL.Add('<TITLE>EUKLID DynaGeoJ: ' + ExtractFileName(FileName) + ' </TITLE>');
        SL.Add('<META NAME="Generator" CONTENT="' + ProjectName +
               ' ' + EuklidVersionString + '">');
        SL.Add('</HEAD>');
        SL.Add('<BODY>');
        HTMLData.TextFirstLine := SL.Count;      // ergänzt 23.02.08, V3.1 Beta04
        With HTMLData.PreText do
          If Lines.Count > 0 then
            SL.Add(HTMLEquivalent(Text) + '<br>');
        HTMLData.TextLastLine := Pred(SL.Count); // ergänzt 23.02.08, V3.1 Beta04
        SL.Add('<br>');
        SL.Add('<center>');
        dS := SL.Count;
        SL.Add('</center><br>');
        SL.Add('</BODY>');
        SL.Add('</HTML>');
        end;

      If HTMLData.IsNewTag then begin
        SL.Insert(ds,     '<br>');
        SL.Insert(dS + 1, '<center>');
        dS := dS + 2;
        end;
      SL.Insert(dS    , '<applet ');
      SL.Insert(dS + 1, #9'code="applet.DynaGeoJ"');
      buf := HTMLData.EditViewerPath.Text;
      replace('\', '/', buf);    // Write this path as URL path!
      SL.Insert(dS + 2, #9'archive="' + buf + '"');
      SL.Insert(dS + 3, #9'width="' + IntToStr(HTMLData.IEditWinWidth.Value + dW) + '"');
      SL.Insert(dS + 4, #9'height="' + IntToStr(HTMLData.IEditWinHeight.Value) + '"');
      SL.Insert(dS + 5, '>');
      SL.Insert(dS + 6, '<param name="language_id" value="' +
                        GetLanguageID + '">');
      SL.Insert(dS + 7, '<param name="geofile" value="' +
                        ExtractFileName(HTMLData.GEOFilePath) + '">');
      SL.Insert(dS + 8, '</applet><br>');
      If HTMLData.IsNewTag then
        SL.Insert(dS + 9, '</center><br>');

      { 06.12.2006 : Ergänzt, damit man Änderungen am "Text oberhalb des
                     DynaGeoX-Objekts" eintragen kann }
      If HTMLData.TextFirstLine > 0 then begin
        If HTMLData.TextFirstLine <= HTMLData.TextLastLine then
          For i := HTMLData.TextLastLine DownTo HTMLData.TextFirstLine do
            SL.Delete(i)
        else
          SL.Delete(HTMLData.TextFirstLine);
        end
      else
        HTMLData.TextFirstLine := dS - 2;
      If HTMLData.PreText.Lines.Count > 0 then begin
        BL := TStringList.Create;
        try
          BL.Text := HTMLEquivalent(HTMLData.PreText.Text);
          For i := Pred(BL.Count) downTo 0 do
            SL.Insert(HTMLData.TextFirstLine, BL.Strings[i]);
        finally
          BL.Free;
        end;  { of inner try }
        end;
      With HTMLData.EditAuthorName do
        If Length(Text) > 0 then
          If Pos('NAME="Author"', SL.Strings[3]) > 0 then
            SL.Strings[3] := '<META NAME="Author" CONTENT="' + Text + '">'
          else
            SL.Insert(3, '<META NAME="Author" CONTENT="' + Text + '">');
      SL.SaveToFile(HTMLData.HTMLFilePath);
    finally
      SL.Free;
    end;
  except
    on EFCreateError do begin  { Schreibgeschütztes Ziel ? }
      raise Exception.CreateFmt(MyFileMsg[9] + MyFileMsg[10], [FileName]);
      Result := 1;
      end;
    on EStreamError do begin   { sonstiger Stream-Fehler   }
      raise Exception.CreateFmt(MyFileMsg[9], [FileName]);
      Result := 1;
      end;
    else begin                 { unbekannter Fehler        }
      raise Exception.CreateFmt(MyFileMsg[0], [FileName]);
      Result := 1;
      end;
  end;
  end;

end.
