unit TermForm;

interface

uses types, wintypes, classes, forms, comctrls, GeoTypes, FormatEdit;

type
  TTermForm = class(TForm)
    protected
      FPos        : TPoint;
      FMode       : Integer;
      EditedObj   : TGeoObj;
      ObjList     : TGeoObjListe;
      ParentHWnd  : HWnd;
      FValidResult: Boolean;
    public
      constructor CreateWithData(AParentHandle: HWnd; AOwner: TComponent;
                                 APopupObj: TGeoObj; ADrawing: TGeoObjListe;
                                 APos: TPoint; AMode: Integer);
      function ValidTermIn(REdit: TFormatEdit; Drawing: TGeoObjListe): Boolean;
      function ConstantIn(REdit: TFormatEdit): Boolean;
      function UnsignedConstantIn(REdit: TFormatEdit): Boolean;
      procedure AddObj2Term(GO: TObject); virtual; abstract;
      procedure SetLinksToMainWindow;
      procedure InsertTempParams;
      procedure RestoreOldParams(ParamCount, HintId : Integer);
      property  ValidResult: Boolean read FValidResult;
    end;

implementation

Uses Dialogs, Declar, MathLib, GlobVars, TBaum;

constructor TTermForm.CreateWithData(AParentHandle: HWnd; AOwner: TComponent;
                                     APopupObj: TGeoObj; ADrawing: TGeoObjListe;
                                     APos: TPoint; AMode: Integer);
  begin
  Create(AOwner);
  FValidResult := False;
  ParentHWnd := AParentHandle;
  FPos := APos;
  If FPos.X > Screen.DesktopWidth - Width then
    FPos.X := Screen.DesktopWidth - Width;
  If FPos.Y > Screen.DesktopHeight - Height then
    FPos.Y := Screen.DesktopHeight - Height;
  If FPos.X < 0 then FPos.X := 0;
  If FPos.Y < 0 then FPos.Y := 0;
  FMode     := AMode;
  EditedObj := APopupObj;
  ObjList   := ADrawing;
  end;

function TTermForm.ValidTermIn(REdit: TFormatEdit; Drawing: TGeoObjListe): Boolean;
  var testbaum : TTBaum;
      err_spot : Integer;
      ws       : String;
  begin
  Result := False;
  testBaum := TTBaum.Create(Drawing, Deg);
  try
    ws := REdit.GetHTMLTextLine(0);
    DeleteChars(' ', ws);
    If Length(ws) = 0 then begin
      MessageDlg(MyMess[34], mtError, [mbOk], 0);
      REdit.SelectActualLine;
      REdit.SetFocus;
      end
    else begin
      testbaum.BuildTree(ws);
      If testbaum.Status <> tbOkay then begin
        MessageDlg(testbaum.error_str, mtError, [mbOk], 0);
        REdit.SetFocus;
        REdit.RevokeActSelection;
        REdit.ActCursorPos := Point(Pred(testbaum.error_spot), 0);
        end
      else
        If (EditedObj <> Nil) and
           testbaum.ContainsADescendentOf(EditedObj, err_spot) then begin
          MessageDlg(MyMess[85], mtError, [mbOk], 0);
          REdit.SetFocus;
          REdit.RevokeActSelection;
          REdit.ActCursorPos := Point(Pred(err_spot), 0);
          end
        else
          Result := True;
      end;
  finally
    testbaum.Free;
  end; { of try }
  end;

function TTermForm.ConstantIn(REdit: TFormatEdit): Boolean;
  var testbaum: TTBaum;
  begin
  Result := False;
  testBaum := TTBaum.Create(ObjList, Deg);
  try
    If REdit.LineLength(0) > 0 then
      with testBaum do begin
        BuildTree(REdit.GetPlainASCIITextLine(0));
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
  testBaum := TTBaum.Create(ObjList, Deg);
  try
    If REdit.LineLength(0) > 0 then
      with testBaum do begin
        al := REdit.GetPlainASCIITextLine(0);
        BuildTree(al);
        If Status = tbOkay then
          Result := (is_const) and
                    (Pos('+', al) = 0) and
                    (Pos('-', al) = 0);
        end;
  finally
    testbaum.Free;
  end;
  end;


{********************************************************************
   The following 3 procedures are dummies. Their only job
   is to ease keeping DynaGeo and DynaGeoX syncronized.
 ********************************************************************}

procedure TTermForm.InsertTempParams;
  begin
  // Do nothing.
  end;

procedure TTermForm.RestoreOldParams(ParamCount, HintId: Integer);
  begin
  // Do nothing.
  end;

procedure TTermForm.SetLinksToMainWindow;
  begin
  // Do nothing.
  end;

end.
