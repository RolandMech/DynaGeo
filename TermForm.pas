unit TermForm;

interface

uses types, forms, comctrls, TBaum, GeoTypes, FormatEdit;

type
  TTermForm = class(TForm)
    private
      Old_IL_Line : Integer;
      function  CanCalculate(tb: TTBaum; xmin, xmax: Double): Boolean;
    public
      EditedObj   : TGeoObj;
      function ValidTermIn(REdit: TFormatEdit; Drawing: TGeoObjListe): Boolean;
      function ConstantIn(REdit: TFormatEdit): Boolean;
      function UnsignedConstantIn(REdit: TFormatEdit): Boolean;
      function GetWideTextFrom(REdit: TFormatEdit): WideString;
      procedure AddObj2Term(GO: TObject); virtual; abstract;
      procedure SetLinksToMainWindow;
      procedure InsertTempParams;
      procedure RestoreOldParams(ParamCount, HintId : Integer);
    end;

implementation

Uses Controls, Dialogs, Declar, MathLib, GlobVars, Utility, MainWin;

procedure TTermForm.SetLinksToMainWindow;
  begin
  With HauptFenster do begin
    ActiveTermWin := Self;
    If Modus in [cmd_EditRadius, cmd_EditAngle, cmd_EditCoords,
                 cmd_EditTerm, cmd_EditMap, cmd_EditFunktion] then
      EditedObj := ActPopupObj
    else
      EditedObj := Nil;
    end;
  end;

procedure TTermForm.InsertTempParams;
  begin
  With Hauptfenster.Start do begin
    If IL_Line <> TermInputIndex then begin
      Old_IL_Line := IL_Line;
      IL_Line := TermInputIndex;  { enthält die Daten für TermInput ! }
      end;
    Clear;
    IL_Row := 1;
    ExpectedCount := 1;
    ExpectedType  := InitModeList[IL_Line, IL_Row];
    end;
  end;

function TTermForm.GetWideTextFrom(REdit: TFormatEdit): WideString;
  { 12.01.2013 : For-Schleife geändert wegen Überarbeitung von
                 TFormatEdit.LineCount.
    Anstoß :     Fehlermeldung am 11.01.2013 von Herrn Tatzel im Forum
    ("Fehler und Probleme / Bezeichnerfragen") mit dortiger Beispieldatei
    "Horiz_Vertik_sonnenuhr.geo".
    Diagnose :   Im Gegensatz zu meiner Vermutung im Forum waren es nicht
                 die Zeilenvorschübe, über die DynaGeo gestolpert ist,
    sondern es wurde einfach die letzte Zeile nicht hinzugefügt! Mehrere
    kleine Fehler zusammen täuschten in einfachen Fällen (nur 1 Zeilen-
    sprung) vor, dass das Programm korrekt arbeiten würde, was es aber
    frühestens jetzt, d.h. *nach* dieser Reparatur tut.
  }
  var s : String;
      i : Integer;
  begin
  s := '';
  For i := 1 to REdit.LineCount do
    s := s + REdit.GetHTMLTextLine(i-1);
  Result := HTMLString2WideString(s);
  end;

function TTermForm.ValidTermIn(REdit: TFormatEdit; Drawing: TGeoObjListe): Boolean;
  var testbaum : TTBaum;
      err_spot : Integer;
      s        : WideString;
      oldCursor: TCursor;
  begin
  oldCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Result := False;
  testBaum := TTBaum.Create(Drawing, Rad);
  try
    s := GetWideTextFrom(REdit);
    If Length(s) = 0 then begin
      MessageDlg(MyMess[34], mtError, [mbOk], 0);
      REdit.SelectActualLine;
      REdit.SetFocus;
      end
    else begin
      testbaum.BuildTree(s);
      If testbaum.Status <> tbOkay then begin
        MessageDlg(testbaum.error_str, mtError, [mbOk], 0);
        REdit.SetFocus;
        REdit.RevokeActSelection;
        REdit.ActCursorPos := Point(Pred(testbaum.error_spot), 0);
        REdit.Invalidate;
        end
      else begin
        If EditedObj <> Nil then begin
          testbaum.RegisterTermParentsIn(EditedObj);
          try
            if testbaum.ContainsADescendentOf(EditedObj, err_spot) then
              if Not RecursionAllowed then begin  // Keine Rekursion erlaubt :
                MessageDlg(MyMess[85], mtError, [mbOk], 0);
                REdit.SetFocus;
                REdit.RevokeActSelection;
                REdit.ActCursorPos := Point(Pred(err_spot), 0);
                REdit.Invalidate;
                end
              else
                Result := MessageDlg(MyMess[146], mtWarning,
                                     [mbYes, mbNo], 0) = mrYes
            else
              Result := True;
          finally
            testbaum.UnregisterTermParentsIn(EditedObj);
          end; { of try }
          end
        else
          Result := True;
        end;

      If Result and (Not CanCalculate(testbaum, Drawing.xMin, Drawing.xMax)) then begin
        MessageDlg(MyMess[147], mtError, [mbOk], 0);
        REdit.SetFocus;
        REdit.RevokeActSelection;
        Result := False;
        end;
      If Result and testbaum.is_estimated then
        Result := MessageDlg(MyMess[143], mtWarning, [mbYes, mbNo], 0) = mrYes;
      If Result and
         (Hauptfenster.Modus in [cmd_GRichtTerm, cmd_SRichtTerm, cmd_EditAngle]) and
         Testbaum.is_const and
         (Not Testbaum.containsToken(50)) then
        Result := MessageDlg(MyMess[151], mtConfirmation, [mbYes, mbNo, mbHelp], idh_deg_rad_problem) = mrYes;
      end;
  finally
    testbaum.Free;
  end;
  Screen.Cursor := oldCursor;
  end;

function TTermForm.ConstantIn(REdit: TFormatEdit): Boolean;
  var testbaum: TTBaum;
  begin
  Result := False;
  testBaum := TTBaum.Create(HauptFenster.Drawing, Rad);
  try
    If REdit.LineLength(0) > 0 then
      with testBaum do begin
        BuildTree(HTMLString2WideString(REdit.GetHTMLTextLine(0)));
        If Status = tbOkay then
          Result := is_const;
        end;
  finally
    testbaum.Free;
  end;
  end;

function TTermForm.UnsignedConstantIn(REdit: TFormatEdit): Boolean;
  var testbaum: TTBaum;
      al : String;
  begin
  Result := False;
  testBaum := TTBaum.Create(HauptFenster.Drawing, Rad);
  try
    If REdit.LineLength(0) > 0 then
      with testBaum do begin
        al := HTMLString2WideString(REdit.GetHTMLTextLine(0));
        BuildTree(al);
        If Status = tbOkay then
          Result := is_const and (Pos('+', al) = 0) and (Pos('-', al) = 0);
        end;
  finally
    testbaum.Free;
  end;
  end;

procedure TTermForm.RestoreOldParams(ParamCount, HintId : Integer);
  begin
  If ParamCount > 0 then
    with HauptFenster.Start do begin
      Clear;
      IL_Line := Old_IL_Line;
      IL_Row  := 1;
      ExpectedType  := InitModeList[IL_Line, IL_Row];
      ExpectedCount := ParamCount;
      end;
  If HintId >= 0 then
    Hauptfenster.ShowMyHint(HintId);
  end;

function TTermForm.CanCalculate(tb: TTBaum; xmin, xmax: Double): Boolean;
  var x, y : Double;
      n, i : Integer;
  begin
  n := 0;
  For i := 1 to 10 do begin
    x := MathLib.GetRandom(xmin, xmax);
    tb.Calculate(x, y);
    if tb.status = tbOkay then
      Inc(n);
    end;
  Result := n > 0;
  end;


end.
