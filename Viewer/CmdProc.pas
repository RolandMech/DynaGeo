unit CmdProc;

interface

uses  Types, WinTypes, Graphics, Classes, Forms, Controls,
      ComCtrls, ExtCtrls, Dialogs, SysUtils, Messages,
      Declar, GlobVars, GeoTypes, GeoLocLines, GeoConic, GeoHelper,
      GeoImage, GeoTransf, GeoEvents, GeoMakro, FileIO,
      NameDlg, TermForm, TermEdit, RangeEdit, WertEing, KoordEing;

const
      HandCursor   = 1;
      HelpCursor   = 2;
      InputCursor  = 3;
      CatchCursor  = 4;
      DragCursor   = 5;

type
  TInpObj = class(TObject)
              exp_type : Integer;
              sel_obj  : TGeoObj;
              constructor create(iExpType: Integer; iSelObj: TGeoObj);
            end;

  TCmdExecuter = class(TObject)
      protected
        FModus        : Integer;
        FLocalFileName,
        FTermBuf      : String;
        FGeoListe     : TGeoObjListe;
        FLastMousePos : TPoint;
        FPreSelected,
        FSelected     : TGeoObj;
        FTermIsUSC,                  //  USC = unsigned constant
        FLastAutoTrace: Boolean;
        Handle        : HWnd;
        DrawWin       : TPaintBox;
        ToolWin       : TToolBar;
        InpList,
        SelObjList    : TList;
        PopupObj      : TGeoObj;
        PopupParam,
        Last2Show,
        NextIObjIndex,
        LocalCRNr,
        MakNum,
        CmdNum        : Integer;
        Wait          : Boolean;

        function  GetBuffered: Boolean;
        function  WaitMessageDlg(const Msg: string; DlgType: TMsgDlgType;
                                 Buttons: TMsgDlgButtons; HelpCtx: Longint): Word;
        function  ExpectedType: Integer;
        function  SelectObjFromList(mx, my: Integer): TGeoObj;
        procedure SelectUniqueDragObject(mx, my: Integer);
        procedure SetModus(newMode: Integer);
        procedure SafeLoadCursors;
        procedure ClearInpList;
        procedure InitInpList(newMode: Integer);
        procedure RegisterInpObj(mx, my : Integer);
        function  GetInpObj(n: Integer): TGeoObj;
        procedure DoNameObject(GO: TGeoObj);
        procedure DoEditComment(GO: TGeoObj);
        procedure DoNewComment;
        procedure DoNewTermObj(mode, state: Integer; var ErrNum: Integer);
        procedure DoEditTerm;
        procedure DoEditRange;
        procedure DoEditValTerm; // (mode, state: Integer);
        procedure DoMakeCircleWDR(var ErrNum: Integer);
        procedure DoMakeFunktion(var ErrNum: Integer);
        procedure DoMakeGRicht(var ErrNum: Integer);
        procedure DoHideObject(GO: TGeoObj);
        procedure DoDeleteObject(GO: TGeoObj);
        procedure DoBindPoint2Line(P: TGPoint; TL: TGLine);
        procedure DoReleasePoint(P: TGPoint);
        procedure DoCheckSolution;
        procedure MakeMappedObj(map_type: Integer;
                                OriObj, MapDefObj1, MapDefObj2: TGeoObj;
                                withTraces: Boolean; ErrNum: Integer);
        procedure MakePolygon(var ErrNum: Integer);
        procedure MakeIntersection(GO1, GO2: TGeoObj; var ErrNum: Integer);
        procedure ActualizeMouseCursor(Shift: TShiftState);
      public
        LocalCRText   : TStringList;
        LocalFileName : String;
        GeoTimer      : TGeoTimer;
        LastMapping   : TGTransformation;
        constructor Create(iParentHandle: HWnd; iTargetWin: TPaintBox; iToolWin: TToolBar);
        procedure Free;
        function  GetMousedObject(mx, my, expected_type: Integer): TGeoObj;
        function  LoadGeoFile(R: TRect): Integer;
        function  ReadLinesAngle: Boolean;
        function  ReadCirclesRadius: Boolean;
        procedure RealizeNewFile(R: TRect);
        procedure FreeGeoListe;
        procedure MouseMoveProc(Shift: TShiftState; X, Y: Integer);
        procedure MouseDownProc(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        procedure MouseUpProc(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        procedure DoubleClickProc(Sender: TObject);
        procedure KeyPressedProc(key: Char; shift: TShiftState);
        procedure ExecuteCommand(cl_x, cl_y: Integer);
        procedure ProcessPopupObj(PO: TGeoObj; iPopupParam: Integer = 0);
        procedure Reset2DragMode;
        procedure Break2DragMode;
        procedure StartAnimation;
        procedure RunAnimation;
        procedure StartMakro(MakroNum: Integer);
        procedure RunMakro;
        property Modus: Integer read FModus write SetModus;
        property GeoListe: TGeoObjListe read FGeoListe;
        property LastMousePos: TPoint read FLastMousePos;
        property Selected: TGeoObj read FSelected;
        property Buffered: Boolean read GetBuffered;
      end;

implementation

uses Utility, CommentWin, SmallSelectWin, TBaum,
     ToolBarProc, ValidateResultWin;

{-------- TInpObj ----------------------------------------------}

constructor TInpObj.create(iExpType: Integer; iSelObj: TGeoObj);
  begin
  Inherited Create;
  exp_type := iExpType;
  sel_obj  := iSelObj;
  end;


{========= TCmdExecuter ========================================}

constructor TCmdExecuter.Create(iParentHandle: HWnd; iTargetWin: TPaintBox;
                                iToolWin: TToolBar);
  begin
  Inherited Create;
  SafeLoadCursors;
  FLocalFileName := '';
  FGeoListe  := Nil;
  InpList    := TList.Create;
  SelObjList := TList.Create;
  Handle     := iParentHandle;
  DrawWin    := iTargetWin;
  ToolWin    := iToolWin;
  FModus     := cmd_Drag;
  GeoTimer   := TGeoTimer.GeoCreate(DrawWin, Handle, FGeoListe);
  LocalCRText:= TStringList.Create;
  Wait       := False;
  NextIObjIndex := -1;
  end;


procedure TCmdExecuter.Free;
  begin
  ClearInpList;
  LocalCRText.Free;
  GeoTimer.Free;
  InpList.Free;
  SelObjList.Free;
  LocalFileName := '';   { Löscht eine eventuelle temporäre Datei ! }
  Inherited Free;
  end;

{---------- Interne Hilfs-Methoden -----------------------}

procedure TCmdExecuter.SafeLoadCursors;
  var err : String;

  procedure SafeLoadCursor(Num: Integer; CName: String);
    var CursorHandle : HCursor;
    begin
    CursorHandle := LoadCursor(HInstance, PChar(CName));
    If CursorHandle <> 0 then
      Screen.Cursors[Num] := CursorHandle
    else
      err := Format(MyStartMsg[18], [CName]);
    end;

  begin
  err := '';
  SafeLoadCursor(HandCursor,   'HAND');
  SafeLoadCursor(HelpCursor,   'HILFEPFEIL');
  SafeLoadCursor(InputCursor,  'KREUZ');
  SafeLoadCursor(CatchCursor,  'KREUZKREIS');
  SafeLoadCursor(DragCursor,   'ZANGE');
  If Length(err) > 0 then
    WaitMessageDlg(err, mtError, [mbOk], 0);
  end;

function TCmdExecuter.WaitMessageDlg(const Msg: string; DlgType: TMsgDlgType;
                                     Buttons: TMsgDlgButtons; HelpCtx: Longint): Word;
  begin
  Wait := True;
  Result := MessageDlg(Msg, DlgType, Buttons, HelpCtx);
  Wait := False;
  end;

function TCmdExecuter.ExpectedType: Integer;
  begin
  If (Modus = cmd_Drag) or (InpList.Count = 0) then      { Zug-Modus     }
    Result := ccDragableObj
  else                          { anderer Modus }
    If (NextIObjIndex >= 0) and
       (NextIObjIndex < InpList.Count) then
      Result := TInpObj(InpList[NextIObjIndex]).exp_type
    else
      Result := -1;     { Fehler !!! }
  end;

function TCmdExecuter.GetBuffered: Boolean;
  begin
  Result := (Length(FLocalFileName) > 0) and
            (Pos('\_eudytmp_', FLocalFileName) > 0);
  end;

procedure TCmdExecuter.SetModus(newMode: Integer);
  begin
  If newMode <> FModus then begin
    FModus := newMode;
    If Modus in [cmd_RunAnimaFD, cmd_RunAnimaBK] then begin
      SendMessage(Handle, cmd_AdjToolBtn, Modus, 0);
      StartAnimation;
      end
    else begin
      FPreselected := Nil;
      If GeoListe <> Nil then
        GeoListe.IsDoubleBuffered := Double_Buffered;
      InitInpList(Modus);
      If (Modus = cmd_MakeLocLine) and
         (OLineMode = 0) then
        OLineMode := 1;
      end; { of else }
    end;
  end;

function TCMdExecuter.SelectObjFromList(mx, my: Integer): TGeoObj;
  var i         : Integer;
      SelectWin : TSelectWin;
      spot      : TPoint;
  begin
  Assert(SelObjList.Count > 1, 'SelObjList.Count <= 1 !');
  SelectWin := TSelectWin.Create(DrawWin);
  try
    Wait := True;
    spot := DrawWin.ClientToScreen(Point(mx, my));
    SelectWin.Left := spot.x;
    SelectWin.Top  := spot.y;
    SelectWin.ListBox.Items.Clear;
    For i := 0 to Pred(SelObjList.Count) do
      SelectWin.ListBox.Items.Add(TGeoObj(SelObjList.Items[i]).Name);
    SelectWin.ListBox.Selected[0] := True;
    If SelectWin.ShowModal = mrOk then begin
      i := 0;
      While (i < SelectWin.ListBox.Items.Count) and
            Not SelectWin.ListBox.Selected[i] do
        i := i + 1;
      If i < SelectWin.ListBox.Items.Count then
        Result := SelObjList.Items[i]
      else
        Result := Nil;
      end
    else
      Result := Nil;
  finally
    Wait := False;
    SelectWin.Free;
  end; { of try }
  end;

function TCmdExecuter.GetMousedObject(mx, my, expected_type: Integer): TGeoObj;
  {25.05.2008 : Anordnung der selektierten Objekte in der SelObjList
                geändert weil ein Polygon P1 unzugänglich war, wenn es
   von einem anderen Polygon P2 verdeckt wurden, obwohl P1 *vor* P2 lag.
   Daher wurde die Abarbeitungsrichtung der mit [*] markierten "for"-
   Schleife umgedreht.                                                  }
  var lxm, lym, LogCatchDist : Double;
      ActMO : TGeoObj;  { Moused Object }
      i, k  : Integer;
  begin
  If (GeoListe = Nil) or Wait then
    Result := Nil
  else begin
    GeoListe.GetLogCoords(mx, my, lxm, lym);
    LogCatchDist := CatchDist/GeoListe.e1x;
    SelObjList.Clear;
    For i := 0 to GeoListe.LastValidObjIndex do    // [*]
      If (TGeoObj(GeoListe.Items[i]).IsVisible) and
         (TGeoObj(GeoListe.Items[i]).dist(lxm, lym) < LogCatchDist) then begin
        ActMO := TGeoObj(GeoListe.Items[i]);
        If ActMo.IsCompatibleWith(expected_type) then begin
          k := 0;   { Einsortieren nach fallender Priorität }
          While (k < SelObjList.Count) and
                (TGeoObj(SelObjList.Items[k]).IsPriorTo(ActMo.ClassType)) do
            Inc(k);
          SelObjList.Insert(k, ActMO)
          end;
      end;

    If SelObjList.Count = 0 then
      Result := Nil
    else
      Result := SelObjList.Items[0];
    end;
  end;


function TCmdExecuter.ReadCirclesRadius: Boolean;
  var wPos  : TPoint;
      TIWin : TWertEingabeDlg;
  begin
  Result := False;
  wpos   := DrawWin.ClientToScreen(Point(150, 100));
  wpos.X := wpos.X + 10;
  wpos.Y := wpos.Y + 10;
  TIWin  := TWertEingabeDlg.CreateWithData
              (Handle, DrawWin.Owner, Selected, GeoListe, wpos, cmd_MCreate);
  try
    If (TIWin.ShowModal = mrOk) and
       (TIWin.ValidResult) then begin
      FTermBuf := TIWin.Edit1.PlainText[0];
      Result   := True;
      end
  finally
    TIWin.Free;
  end; { of try }
  end;


function TCmdExecuter.ReadLinesAngle: Boolean;
  var TIWin: TWertEingabeDlg;
      wPos : TPoint;
  begin
  Result := False;
  wpos := DrawWin.ClientToScreen(Point(150, 100));
  wpos.X := wpos.X + 10;
  wpos.Y := wpos.Y + 10;
  TIWin := TWertEingabeDlg.CreateWithData
             (Handle, DrawWin.Owner, Selected, GeoListe, wpos, cmd_GRichtTerm);
  try
    IF (TIWin.ShowModal = mrOk) and
       (TIWin.ValidResult) then begin
      FTermIsUSC := TIWin.UnsignedConstantIn(TIWin.Edit1);
      FTermBuf := TIWin.Edit1.PlainText[0];
      Result := True;
      end;
  finally
    TIWin.Free;
  end; { of try }
  end;


procedure TCmdExecuter.SelectUniqueDragObject(mx, my: Integer);
  begin
  Case SelObjList.Count of
    0 : FSelected := Nil;
    1 : FSelected := SelObjList.Items[0];
  else
    If (TGeoObj(SelObjList.Items[0]) is TGPoint) and   { nur bei Kollision von }
       (TGeoObj(SelObjList.Items[1]) is TGPoint) then  {   zwei Basispunkten ! }
      If FPreSelected = Nil then begin  { nix vorgewählt }
        FSelected := Nil;
        FPreSelected := SelectObjFromList(mx, my);
        end
      else                              { Ein Basispunkt vorgewählt: }
        If SelObjList.IndexOf(FPreSelected) >= 0 then begin
          FSelected := FPreSelected;       { wählen und dann ....    }
          FPreSelected := Nil;             { ...Vorauswahl löschen ! }
          end
        else
          FSelected := SelObjList.Items[0]
    else begin
    
      FSelected := SelObjList.Items[0];
      end;
  end;  { of case }
  end;


procedure TCmdExecuter.ProcessPopupObj(PO: TGeoObj; iPopupParam: Integer = 0);
  begin
  FSelected := PO;
  SelObjList.Clear;   { 13.08.04: unterdrückt überflüssiges Auswahlfenster }
  PopupParam := iPopupParam;
  RegisterInpObj(LastMousePos.X, LastMousePos.Y);
  If (NextIObjIndex >= InpList.Count) or
     (InpList.Count = 0) then begin
    ExecuteCommand(LastMousePos.X, LastMousePos.Y);
    end;
  end;


procedure TCmdExecuter.DoNameObject(GO: TGeoObj);
  var NameEdit: TObjNameDlg;
  begin
  If (GO is TGArea) or           { Falls eine Füllung oder ein Name    }
     (GO is TGName) then         { angeklickt wurde, wird das gefüllte }
    GO := GO.Parent[0];          { oder das benannte Objekt editiert.  }
  If Not (GO is TGTextObj) then begin
    Reset2DragMode;
    Wait := True;
    NameEdit := TObjNameDlg.Create(DrawWin.Owner);
    try
      with NameEdit do begin
        DisableAttributes;
        SetPosCenteredTo(DrawWin.ClientToScreen(LastMousePos));
        ActObj := GO;
        ShowModal;
        end;
    finally
      NameEdit.Free;
      Wait := False;
    end;
    end;
  end;

procedure TCmdExecuter.DoEditComment(GO: TGeoObj);
  var TextWin: TTextWin;
  begin
  TGComment(GO).HideDisplay;
  TextWin := TTextWin.CreateWithData
               (DrawWin, GeoListe, TGComment(GO), GO.WinPos);
  With TextWin do begin
    ShowModal;
    If ActComment = Nil then
      GeoListe.FreeObject(GO)
    else
      GO.ShowsAlways := True;
    Free;
    end;
  GeoListe.Repaint;
  end;

procedure TCmdExecuter.DoNewTermObj(mode, state: Integer; var ErrNum: Integer);
  var wpos      : TPoint;
      TIWin     : TWertEingabeDlg;
      iShowTerm : Boolean;
      ts        : String;
  begin
  wpos   := DrawWin.ClientToScreen(Point(0, 0));          // Im DrawWin-
  wpos.X := wpos.X + (DrawWin.ClientWidth  - 516) div 2;  //   Fenster
  wpos.Y := wpos.Y + (DrawWin.ClientHeight - 356) div 2;  //   zentrieren
  TIWin := TWertEingabeDlg.CreateWithData
                (Handle, DrawWin.Owner, Nil, GeoListe, wpos, Modus);
  If (TIWin.ShowModal = mrOk) and
      TIWin.ValidResult then begin
    ts := TIWin.Edit1.PlainText[0];
    iShowTerm := Not TIWin.ConstantIn(TIWin.Edit1);
    GeoListe.InsertObject(TGTermObj.Create(GeoListe, ts, '', iShowTerm, True),
                          ErrNum);
    end;
  TIWin.Free;
  Reset2DragMode;
  end;

procedure TCmdExecuter.DoEditTerm;
  var wpos: TPoint;
      TIWin : TTermEditDlg;
  begin
  wpos   := DrawWin.ClientToScreen(Point(0, 0));         // Im DrawWin-
  wpos.X := wpos.X + (DrawWin.ClientWidth  - 516) div 2; //   Fenster
  wpos.Y := wpos.Y + (DrawWin.ClientHeight - 356) div 2; //   zentrieren
  TIWin := TTermEditDlg.CreateWithData
               (Handle, DrawWin.Owner, Selected, GeoListe, wpos, Modus);
  TIWin.ShowModal;
  TIWin.Free;
  Reset2DragMode;
  end;

procedure TCmdExecuter.DoEditRange;
  var RangeDlg : TRangeEditWin;
  begin
  PopupObj := Selected;
  RangeDlg := TRangeEditWin.CreateWithData(DrawWin, PopupObj);
  try
    RangeDlg.ShowModal
  finally
    RangeDlg.Free;
    GeoListe.UpdateAllDescendentsOf(PopupObj);
  end; { of try }
  end;

procedure TCmdExecuter.DoEditValTerm;
  var PosObj : TGeoObj;
      wPos   : TPoint;
      TIWin  : TTermForm;
  begin
  PopupObj := Selected;
  Case Modus of
    cmd_EditRadius: PosObj := PopupObj.Parent[0];
    cmd_EditAngle : PosObj := PopupObj.Parent[1];
  else
    PosObj := PopupObj;
  end;
  wpos := DrawWin.ClientToScreen(PosObj.WinPos);
  wpos.X := wpos.X + 10;
  wpos.Y := wpos.Y + 10;
  If Modus = cmd_EditCoords then
    TIWin := TKoordEingabeDlg.CreateWithData
                (Handle, DrawWin.Owner, PopupObj, GeoListe, wpos, Modus)
  else
    TIWin := TWertEingabeDlg.CreateWithData
                (Handle, DrawWin.Owner, PopupObj, GeoListe, wpos, Modus);
  try
    If (TIWin.ShowModal = mrOK) and
        TIWin.ValidResult then
      Case Modus of
        cmd_EditRadius  : With TGXCircle(PopupObj).rTerm do begin
                            UnregisterTermParentsIn(PopupObj);
                            BuildTree(TWertEingabeDlg(TIWin).Edit1.PlainText[0]);
                            RegisterTermParentsIn(PopupObj);
                            end;
        cmd_EditAngle   : With TGXLine(PopupObj).wTerm do begin
                            UnregisterTermParentsIn(PopupObj);
                            BuildTree(TWertEingabeDlg(TIWin).Edit1.PlainText[0]);
                            RegisterTermParentsIn(PopupObj);
                            end;
        cmd_EditFunktion: TGFunktion(PopupObj).TermString :=
                            TWertEingabeDlg(TIWin).Edit1.PlainText[0];
        cmd_EditCoords:   begin
                          With TGXPoint(PopupObj).XTerm do begin
                            UnregisterTermParentsIn(PopupObj);
                            BuildTree(TKoordEingabeDlg(TIWin).Edit1.PlainText[0]);
                            RegisterTermParentsIn(PopupObj);
                            end;
                          With TGXPoint(PopupObj).YTerm do begin
                            UnregisterTermParentsIn(PopupObj);
                            BuildTree(TKoordEingabeDlg(TIWin).Edit2.PlainText[0]);
                            RegisterTermParentsIn(PopupObj);
                            end;
                          end;
      end;
  finally
    TIWin.Free;
    GeoListe.UpdateAllObjects;   // Vorsichtshalber alle.
    Reset2DragMode;
  end; { of try }
  end;


procedure TCmdExecuter.DoMakeGRicht(var ErrNum: Integer);
  var pS1, pVP,
      pOP      : TGPoint;

  procedure CheckOrientation;
    var xop, yop, dx, dy,
        vSide, iAngle : Double;
        TestBaum      : TTBaum;
    begin
    TestBaum := TTBaum.Create(GeoListe, Deg);
    try
      TestBaum.BuildTree(FTermBuf);
      TestBaum.Calculate(0, iAngle);
      With pOP do begin       { Orientierung des Winkels        }
        xop := X;             { überprüfen und ....             }
        yop := Y;
        end;
      dx    := pS1.X - pVP.X;
      dy    := pS1.Y - pVP.Y;
      vSide := (yop - pVP.Y) * dx - (xop - pVP.X) * dy;
      If vSide * iAngle < 0 then begin
        TestBaum.ChangeSign;   { ... gegebenenfalls korrigieren }
        FTermBuf := TestBaum.source_str;
        end;
    finally
      TestBaum.Free;
    end;
    end;

  begin
  pS1 := TGPoint(TInpObj(InpList.Items[0]).sel_obj);
  pVP := TGPoint(TInpObj(InpList.Items[1]).sel_obj);
  If InpList.Count >= 3 then begin { Falls Orientierungspunkt vorhanden }
    pOP := TGPoint(TInpObj(InpList.Items[2]).sel_obj);
    CheckOrientation;
    If GeoListe.IndexOf(pOP) > Last2Show then begin
      pOP.ShowsAlways := False;
      GeoListe.FreeObject(pOP);
      end;
    end;
  Last2Show := -1;
  GeoListe.InsertObject(TGXLine.Create(GeoListe, pS1, pVP, FTermBuf, True), ErrNum);
  Reset2DragMode;
  end;


procedure TCmdExecuter.DoMakeCircleWDR(var ErrNum: Integer);
  begin
  GeoListe.InsertObject(TGXCircle.Create(GeoListe, TInpObj(InpList[0]).sel_obj,
                                         FTermBuf, True),
                        ErrNum);
  Reset2DragMode;
  end;


procedure TCmdExecuter.DoMakeFunktion(var ErrNum: Integer);
  var wPos    : TPoint;
      funcStr : String;
      new_f   : TGeoObj;
      FTIWin  : TWertEingabeDlg;
  begin
  wpos := DrawWin.ClientToScreen(Point(150, 100));
  wpos.X := wpos.X + 10;
  wpos.Y := wpos.Y + 10;
  FTIWin := TWertEingabeDlg.CreateWithData
                    (Handle, DrawWin.Owner, Selected, GeoListe, wpos, Modus);
  try
    If (FTIWin.ShowModal = mrOk) and
       FTIWin.ValidResult then begin
      funcStr := FTIWin.Edit1.PlainText[0];
      new_f := GeoListe.InsertObject(TGFunktion.Create(GeoListe, funcStr),
                            ErrNum);
      new_f.ShowsAlways := new_f.DataValid;
      end;
  finally
    FTIWin.Free;
    Reset2DragMode;
  end; { of try }
  end;


procedure TCmdExecuter.DoNewComment;
  var TextWin: TTextWin;
  begin
  TextWin := TTextWin.CreateWithData
               (DrawWin, GeoListe, Nil, LastMousePos);
  With TextWin do begin
    ShowModal;
    Free;
    end;
  GeoListe.Repaint;
  end;


procedure TCmdExecuter.DoHideObject(GO: TGeoObj);
  var NO : TGName;
      ss : Boolean;
      i : Integer;
  begin
  If (GO.ClassType = TGOrigin) or
     (GO.ClassType = TGaugePoint) or
     (GO.ClassType = TGAxis) then begin   { Koordinatensystem verstecken }
    ss := TGeoObj(GeoListe[0]).ShowsAlways;
    For i := 0 to 2 do
      TGeoObj(GeoListe[i]).ShowsAlways := Not ss;
    For i := 3 to 4 do
      TGeoObj(GeoListe[i]).ShowsAlways := False;
    end
  else begin                                 { "Normale" Objekte:  }
    If GO.ShowsAlways and GO.HasNameObj(NO) then
      NO.ShowsAlways := False;
    GO.ShowsAlways := Not GO.ShowsAlways;    { ....umschalten !    }
    If GO.ShowsAlways and (GO is TGName) then
        TGeoObj(GO.Parent[0]).ShowsAlways := True;
    end;
  DrawWin.Invalidate;
  end;


procedure TCmdExecuter.DoDeleteObject(GO: TGeoObj);
  var i, Result : Integer;
  begin
  If (GO.ClassType = TGOrigin) or
     (GO.ClassType = TGaugePoint) or
     (GO.ClassType = TGAxis) then begin
    Result := WaitMessageDlg(MyMess[41], mtConfirmation, [mbYes, mbNo], 0);
    If Result = id_Yes then begin
      For i := 0 to 2 do
        TGeoObj(GeoListe.Items[i]).ShowsAlways := False;
      With GeoListe do
        For i := 0 to Pred(Count) do
          If TGeoObj(Items[i]) is TGCoordPt then
            ConvertCoord2BasePt(TGeoObj(Items[i]));
      end;
    end
  else begin
    GO.IsMarked := True;
    If GeoListe.MarkedObjCount > 1 then
      Result := WaitMessageDlg(MyMess[1], mtConfirmation, [mbYes, mbNo], 0)
    else
      Result := mrYes;
    GO.IsMarked := False;
    If Result = mrYes then begin
      If (GO is TGOLLongLine) or   { Ortslinien stets komplett löschen }
         (GO is TGOLCircle) then
        GO := TGeoObj(GO.Parent[0]);
      FSelected := Nil;
      If (GO is TGLocLine) and
         (Not TGLocLine(GO).IsDynamic) then
        GeoListe.FreeObject(GO)     { Einfache Spuren total löschen !!! }
      else                             { Bei anderen Objekten :        }
        GeoListe.InvalidateObject(GO);  {  "Rückgängig" ermöglichen     }
      end;
    end;
  DrawWin.Invalidate;
  end;


procedure TCmdExecuter.DoBindPoint2Line(P: TGPoint; TL: TGLine);
  var ok : Boolean;
  begin
  If P <> Nil then begin
    P.IsFlagged := True;          { überprüft, ob die Linie von dem zu bindenden Punkt }
    ok := Not TL.IsFlagged;       {   bzw. von einem von dessen "Freunden" abstammt;   }
    P.IsFlagged := False;         {   in diesem Fall kann ein "Abstammungszirkel" ent- }
    If Not ok then                {   stehen, also ist die Bindung dann unzulässig !   }
      WaitMessageDlg(MyMess[8], mtError, [mbOk], 0)
    else                           { Falls der Punkt über eine Strecke fester Länge an  }
      If (P.Parent.Count > 0) and { einen Nicht-Basis-Punkt gebunden ist:              }
         ((TGeoObj(P.Parent.List[0]) is TGPoint) and  { keine Bindung mehr zulässig !  }
          (TGeoObj(P.Parent.List[0]).ClassType <> TGPoint)) then
        WaitMessageDlg(MyMess[43], mtInformation, [mbOk], 0)
      else begin
        DoReleasePoint(P);    { Wenn alle Hürden genommen sind, wird eine eventuell vorhandene }
        P.BecomesChildOf(TL); { alte Bindung aufgelöst und die gewünschte neue geknüpft.       }
        with GeoListe do begin
          SortObjects;        { Sorgt für die korrekte Objekt-Reihenfolge. 06.08.2002 }
          FillDragList(P);
          DragObjects(Self.LastMousePos.X, Self.LastMousePos.Y, False);
          P.CheckChildLinesCBDI;
          end;
        DrawWin.Invalidate;
        end;
    end;
  end;


procedure TCmdExecuter.DoReleasePoint(P: TGPoint);
  var i : Integer;
  begin
  If (P <> Nil) and
     (P.ClassType = TGPoint) and
     (P.Parent.Count > 0) and
     ((TGeoObj(P.Parent.List[0]) is TGLine)  or
      (TGeoObj(P.Parent.List[0]) is TGPolygon))then begin
    i := GeoListe.LastValidObjIndex;
    While i > 4 do begin
      If TGeoObj(Geoliste[i]) is TGLocLine then
        TGLocLine(GeoListe[i]).CheckOLState(P);
      i := i - 1;
      end;
    P.Stops2BeChildOf(P.Parent.List[0]);
    P.CheckChildLinesCBDI;
    end;
  end;


procedure TCmdExecuter.ActualizeMouseCursor(Shift: TShiftState);
  begin
  If (Modus = cmd_Drag) then           { Zug-Modus     }
    If Selected = Nil then
      If ssShift in Shift then
        DrawWin.Cursor := HandCursor
      else
        DrawWin.Cursor := crDefault
    else
      DrawWin.Cursor := Selected.GetMatchingCursor(LastMousePos) // DragCursor
  else if (Modus = cmd_RunAnimaFD) then
    DrawWin.Cursor := crDefault
  else                                 { Anderer Modus }
    If (Selected <> Nil) and
       (NextIObjIndex >= 0) and
       Selected.IsCompatibleWith(TInpObj(InpList[NextIObjIndex]).exp_type) then
      DrawWin.Cursor := CatchCursor
    else
      DrawWin.Cursor := InputCursor;
  end;


{---------- Input-Liste -----------------------------------}

procedure TCmdExecuter.ClearInpList;
  var i: Integer;
  begin
  NextIObjIndex := -1;
  If InpList.Count > 0 then begin
    For i := Pred(InpList.Count) downto 0 do
      TInpObj(InpList[i]).Free;
    InpList.Clear;
    end;
  end;


procedure TCmdExecuter.InitInpList(newMode: Integer);
  { Initialisiert die Input-Liste mit den Typen der erwarteten Startobjekte }

  procedure AddCheckSolutionParams;
    var VarL : TStringList;
        m, i : Integer;
    begin
    VarL := TStringList.Create;
    try
      VarL.Text := (GeoListe.CheckControl as TGCheckControl).VVars;
      For i := 1 to VarL.Count do begin
        m := GetValidationVarType(VarL.ValueFromIndex[i-1]);
        If m > 0 then
          InpList.Add(TInpObj.Create(m, Nil));
        end;
    finally
      VarL.Free;
    end;
    end;

  var ActMakCmd : TMakroCmd;
      n, i : Integer;
  begin
  ClearInpList;
  If newMode = cmd_RunMakro then begin
    ActMakCmd := TMakro(GeoListe.MakroList[MakNum]).GetMakroCmd4Input;
    If ActMakCmd <> Nil then begin
      CmdNum := TMakro(GeoListe.MakroList[MakNum]).IndexOf(ActMakCmd);
      InpList.Add(TInpObj.create(ActMakCmd.ExpType, Nil));
      NextIObjIndex := 0;
      GeoTimer.InitObjBlinking(GeoListe);
      end
    else
      RunMakro;
    end
  else begin
    GeoTimer.Reset(GeoListe);
    FSelected := Nil;
    n := 0;
    While (n <= MaxModeListIndex) and
          (newMode <> InitModeList[n, 0]) do
      Inc(n);
    If n <= MaxModeListIndex then begin   { Modus gefunden }
      If newMode = cmd_CheckSol then
        AddCheckSolutionParams
      else begin
        i := 1;
        While ((i <= 3) and (InitModeList[n, i] > 0)) do begin
          InpList.Add(TInpObj.Create(InitModeList[n, i], Nil));
          Inc(i);
          If (newMode = cmd_GRichtTerm) and (i = 3) and Not FTermIsUSC then
            Inc(i);
          end;
        end;
      If InpList.Count > 0 then begin
        NextIObjIndex := 0;
        GeoTimer.InitObjBlinking(GeoListe);
        end;
      end;
    end;
  end;


procedure TCmdExecuter.RegisterInpObj(mx, my : Integer);
  var err : Integer;
  begin
  If NextIObjIndex >= 0 then   { Es wird ein Objekt erwartet. }
    If Selected <> Nil then       { Es ist ein Objekt selektiert. }
      Case TInpObj(InpList[NextIObjIndex]).exp_type of
        ccPointOrShortLn:
          If Selected is TGShortLine then begin
            TInpObj(InpList[NextIObjIndex]).sel_obj := Selected.Parent[0];
            TGeoObj(Selected.Parent[0]).InitBlinking(True);
            Inc(NextIObjIndex);
            TInpObj(InpList[NextIObjIndex]).sel_obj := Selected.Parent[1];
            TGeoObj(Selected.Parent[1]).InitBlinking(True);
            Inc(NextIObjIndex);
            end
          else begin
            TInpObj(InpList[NextIObjIndex]).sel_obj := Selected;
            Selected.InitBlinking(True);
            Inc(NextIObjIndex);
            end;
        ccPointOrAngle:
          If Selected is TGAngle then begin
            TInpObj(InpList[NextIObjIndex]).sel_obj := Selected.Parent[0];
            TGeoObj(Selected.Parent[0]).InitBlinking(True);
            Inc(NextIObjIndex);
            TInpObj(InpList[NextIObjIndex]).sel_obj := Selected.Parent[1];
            TGeoObj(Selected.Parent[1]).InitBlinking(True);
            Inc(NextIObjIndex);
            TInpObj(InpList[NextIObjIndex]).sel_obj := Selected.Parent[2];
            TGeoObj(Selected.Parent[2]).InitBlinking(True);
            Inc(NextIObjIndex);
            end
          else begin
            TInpObj(InpList[NextIObjIndex]).sel_obj := Selected;
            Selected.InitBlinking(True);
            Inc(NextIObjIndex);
            end;
        ccMappableObj:
          If Selected is TGArea then
            If Selected.Parent.Count = 1 then begin
              TInpObj(InpList[NextIObjIndex]).sel_obj := Selected.Parent[0];
              Selected.InitBlinking(True);
              Inc(NextIObjIndex);
              end
            else
          else begin
            TInpObj(InpList[NextIObjIndex]).sel_obj := Selected;
            Selected.InitBlinking(True);
            Inc(NextIObjIndex);
            end;
      else { of case }
        If SelObjList.Count > 1 then
          If Modus in MultiSelect_Commands then
            FSelected := SelectObjFromList(mx, my)
          else
          If (Modus = cmd_Schnitt) and
             (NextIObjIndex = 1) and
             (TInpObj(InpList[0]).sel_obj = Selected) then
            FSelected := SelObjList.Items[1];
        If Selected <> Nil then begin
          TInpObj(InpList[NextIObjIndex]).sel_obj := Selected;
          Selected.InitBlinking(True);
          Inc(NextIObjIndex);
          end;
      end { of case }
    else { Selected = Nil, also: kein Objekt selektiert ! }
      If TInpObj(InpList[NextIObjIndex]).exp_type in
            [ccAnyPoint, ccPointOrVector,
             ccPointOrShortLn, ccPointOrAngle] then begin
        FSelected := TGPoint.Create(GeoListe, mx, my, True);
        GeoListe.InsertObject(Selected, err);
        TInpObj(InpList[NextIObjIndex]).sel_obj := Selected;
        Selected.InitBlinking(True);
        Inc(NextIObjIndex);
        end;
  FLastMousePos := Point(mx, my);
  end;


function TCmdExecuter.GetInpObj(n: Integer): TGeoObj;
  begin
  If (n >= 0) and (n < InpList.Count) then
    Result := TInpObj(InpList[n]).sel_obj
  else
    Result := Nil;
  end;


{----------- Geo-Datei laden ------------------------------}

function TCmdExecuter.LoadGeoFile(R: TRect): Integer;
  var VTData : TValTabData;
      err    : Integer;

  begin
  If FGeoListe = Nil then
    FGeoListe := TGeoObjListe.Create(Handle, DrawWin.Canvas, R);
  VTData := Nil;
  err  := GeoXMLFileLoad(LocalFileName, FGeoListe, VTData);
  If err > 0 then begin
    FGeoListe.Free;
    FGeoListe := Nil;
    end
  else
    If GeoListe.CRNr <> 0 then
      GeoTimer.InitShowCRMsg(FGeoListe);
  FreeAndNil(VTData);
  Result := err;
  end;

procedure TCmdExecuter.RealizeNewFile(R: TRect);
  var SQO : TGeoObj;
  begin
  If GeoListe <> Nil then
    With GeoListe do begin
      IsDoubleBuffered := Double_Buffered;
      InitScale(e1x, e2y, WindowOrigin, R);
      If HasSetsquare(SQO) then
        FreeObject(SQO);
      UpdateAllObjects;          { 28.04.03 : Soll Ladeprobleme beheben    }
      end;
  end;

procedure TCmdExecuter.FreeGeoListe;
  begin
  FreeAndNil(FGeoListe);
  LocalFileName := '';
  end;

{---------- Konstruktions-Methoden ----------------------------}

procedure TCmdExecuter.Reset2DragMode;
  var i : Integer;
  begin
  For i := 0 to Pred(ToolWin.ButtonCount) do
    ToolWin.Buttons[i].Down := False;
  GeoTimer.Reset(GeoListe);
  PopupObj := Nil;
  If DrawWin.Tag >= 0 then begin
    If GeoListe <> Nil then
      GeoListe.HideHiddenObjects;
    Modus := cmd_Drag;
    InpList.Clear;
    DrawWin.Cursor := crDefault;
    SendMessage(Handle, cmd_AdjToolBtn, cmd_Drag, 0);
    If GeoListe <> Nil then
      GeoListe.DrawFirstObjects(GeoListe.LastValidObjIndex, True);
    end
  else
    FModus := cmd_Drag;
  end;


procedure TCmdExecuter.Break2DragMode;
  begin
  If OLineMode > 0 then begin
    With GeoListe do
      If TGeoObj(Items[LastValidObjIndex]) is TGLocLine then
        FreeObject(TGeoObj(Items[LastValidObjIndex]));
    OLineMode   := 0;
    end;
  Reset2DragMode;
  end;


procedure TCmdExecuter.MakeMappedObj(map_type: Integer;
                                     OriObj, MapDefObj1, MapDefObj2: TGeoObj;
                                     withTraces: Boolean; ErrNum: Integer);

  procedure SetMapping;
    { Für map_type = 0 bleibt FLastMapping auf seinem alten Wert, was
         für Befehlswiederholungen verwendet werden kann. Dies deckt die
         Verwendung *aller* möglichen Abbildungen ab!
      Falls 0 < map_type <= mapSimilarity ist, wird in Drawing nach einer
         entsprechenden Abbildung gesucht; existiert diese noch nicht, wird
         sie erzeugt und in Drawing eingefügt. In jedem Fall wird
         FLastMapping auf die gemeinte Abbildung gesetzt.
      Für map_type = mapInversion wird entsprechend eine Kreisinversion
         gesucht bzw. erzeugt und in FLastMapping abgelegt.
      Andere Werte von map_type dürfen hier nicht vorkommen: sollen Objekte
         durch affine Transformationen abgebildet werden, dann müssen diese
         zuvor erzeugt worden sein. Siehe oben, Fall "map_type = 0" !      }

    var newMap : TGTransformation;
        err, n : Integer;
    begin
    If map_type > 0 then begin
      If map_type = mapTranslation then       // Verschiebung normalisieren !
        MapDefObj1 := TGVector(MapDefObj1).GetAncestorVector;
      n := IndexOfTransformationIn(GeoListe, map_type, MapDefObj1, MapDefObj2);
      If n >= 0 then
        LastMapping := GeoListe[n]
      else begin
        If map_type = mapInversion then
          newMap := TGInversion.Create(GeoListe, MapDefObj1)
        else if map_type <= mapSimilarity then
          newMap := TGSimiliarity.Create(GeoListe, map_type, MapDefObj1, MapDefObj2)
        else begin
          SpyOut('Falscher Aufruf von "MakeMappedObj" mit affinem Map-Typ: %d !', [map_type]);
          newMap := Nil;  Halt(1);  // Das sollte nie(!) passieren !!!
          end;
        FLastAutoTrace := withTraces;
        LastMapping := GeoListe.InsertObject(newMap, err) as TGTransformation;
        end;
      end
    else
      map_type := LastMapping.MapType;
    end;

  procedure ShowTrace(Pt, BPt : TGPoint);
    var s      : TGeoObj;
        n, err : Integer;
    begin
    n := GeoListe.LastValidObjIndex;
    s := Nil;
    Case map_type of
      mapReflectionLine, mapReflectionPoint, mapDilation, mapInversion:
        s := GeoListe.InsertObject(TGShortLine.Create(GeoListe, Pt, BPt, False), err);
      mapTranslation:
        s := GeoListe.InsertObject(TGVector.Create(GeoListe, Pt, BPt, False), err);
      mapRotation:
        s := GeoListe.InsertObject(TGArc.Create(GeoListe, Pt, LastMapping.Parent[0], BPt,
                                               (LastMapping as TGSimiliarity).IsReverse,
                                               False), err);
    end;  // Für affine Abbildungen: keine Spuren erzeugen !
    If (GeoListe.LastValidObjIndex > n) and (s <> Nil) then begin
      s.MyPenStyle  := psDot;
      s.ShowsAlways := True;
      end;
    end;

  procedure CreateMappedPoint;
    var p : TGPoint;
    begin
    p := TGMappedPoint.Create(GeoListe, OriObj, LastMapping, OriObj.IsVisible);
    p := GeoListe.InsertObject(p, ErrNum) as TGPoint;
    If withTraces then
      ShowTrace(OriObj as TGPoint, p);
    end;

  procedure CreateMappedStraightLine;
    var p1, p2 : TGPoint;
        ErrNum : Integer;
    begin
    If map_type <> mapInversion then begin   // Alle geradentreuen Abbildungen
      If OriObj is TGLongLine then
        if OriObj is TGMSenkr then begin  // Sonderbehandlung für Mittelsenkrechten
          p1 := TGMappedPoint.Create(GeoListe, OriObj.Parent[0], LastMapping, TGeoObj(OriObj.Parent[0]).IsVisible);
          p1 := GeoListe.InsertObject(p1, ErrNum) as TGPoint;
          p2 := TGMappedPoint.Create(GeoListe, OriObj.Parent[1], LastMapping, TGeoObj(OriObj.Parent[1]).IsVisible);
          p2 := GeoListe.InsertObject(p2, ErrNum) as TGPoint;
          GeoListe.InsertObject(TGMSenkr.Create(GeoListe, p1, p2, OriObj.IsVisible), ErrNum);
          If withTraces then begin
            ShowTrace(OriObj.Parent[0], p1);
            ShowTrace(OriObj.Parent[1], p2);
            end;
          end
        else  // Alle anderen Geraden-Typen
          GeoListe.InsertObject(TGMappedLine.Create(GeoListe, OriObj, LastMapping, OriObj.IsVisible), ErrNum)
      else begin
        Assert((OriObj.Parent.Count = 2) and
               (TGeoObj(OriObj.Parent[0]) is TGPoint) and
               (TGeoObj(OriObj.Parent[1]) is TGPoint),
               'Objekt kann wegen ungeeigneter Eltern nicht gespiegelt werden.');
        p1 := TGMappedPoint.Create(GeoListe, OriObj.Parent[0], LastMapping, TGeoObj(OriObj.Parent[0]).IsVisible);
        p1 := GeoListe.InsertObject(p1, ErrNum) as TGPoint;
        p2 := TGMappedPoint.Create(GeoListe, OriObj.Parent[1], LastMapping, TGeoObj(OriObj.Parent[1]).IsVisible);
        p2 := GeoListe.InsertObject(p2, ErrNum) as TGPoint;
        If OriObj is TGVector then
          GeoListe.InsertObject(TGVector.Create(GeoListe, p1, p2, True), ErrNum)
        else if OriObj is TGShortLine then
          GeoListe.InsertObject(TGShortLine.Create(GeoListe, p1, p2, True), ErrNum)
        else if OriObj is TGHalfLine then
          GeoListe.InsertObject(TGHalfLine.Create(GeoListe, p1, p2, True), ErrNum);
        If withTraces then begin
          ShowTrace(OriObj.Parent[0], p1);
          ShowTrace(OriObj.Parent[1], p2);
          end;
        end;
      end
    else begin // Spezialfall  Inversion am Kreis
      if OriObj is TGLongLine then
        GeoListe.InsertObject(TGMappedCircle.Create(GeoListe, OriObj, LastMapping, OriObj.IsVisible), ErrNum)
      else
        MessageDlg(MyMess[70], mtError, [mbOk], 0);
      end;
    end;

  procedure CreateMappedCircle;
    var p1, p2, p3 : TGPoint;
        revers     : Boolean;
        NMC        : TGCircle;   { 'N'ew 'M'apped 'C'ircle }
        FO         : TGArea;     { 'F'ill 'O'bject }
    begin
    If map_type <= mapCongruency then              // Kongruenz-Abbildungen
      if OriObj.ClassType = TGCircle then begin
        p1 := TGMappedPoint.Create(GeoListe, OriObj.Parent[0], LastMapping, TGeoObj(OriObj.Parent[0]).IsVisible);
        p1 := GeoListe.InsertObject(p1, ErrNum) as TGPoint;
        p2 := TGMappedPoint.Create(GeoListe, OriObj.Parent[1], LastMapping, TGeoObj(OriObj.Parent[1]).IsVisible);
        p2 := GeoListe.InsertObject(p2, ErrNum) as TGPoint;
        NMC := GeoListe.InsertObject(TGCircle.Create(GeoListe, p1, p2, OriObj.IsVisible),
                                    ErrNum) as TGCircle;
        If (ErrNum = 0) and PolyFilled and TGCircle(OriObj).IsFilled(FO) then
          GeoListe.InsertObject(TGArea.Create(GeoListe, NMC, True, True), ErrNum);
        end
      else if OriObj is TGArc then begin
        p1 := TGMappedPoint.Create(GeoListe, OriObj.Parent[0], LastMapping, TGeoObj(OriObj.Parent[0]).IsVisible);
        p1 := GeoListe.InsertObject(p1, ErrNum) as TGPoint;
        p2 := TGMappedPoint.Create(GeoListe, OriObj.Parent[1], LastMapping, TGeoObj(OriObj.Parent[1]).IsVisible);
        p2 := GeoListe.InsertObject(p2, ErrNum) as TGPoint;
        p3 := TGMappedPoint.Create(GeoListe, OriObj.Parent[2], LastMapping, TGeoObj(OriObj.Parent[2]).IsVisible);
        p3 := GeoListe.InsertObject(p3, ErrNum) as TGPoint;
        revers := (map_type = mapReflectionLine) xor TGArc(OriObj).IsReversed;
        GeoListe.InsertObject(TGArc.Create(GeoListe, p2, p1, p3, revers, True), ErrNum);
        If withTraces then begin
          ShowTrace(OriObj.Parent[0], p1);
          ShowTrace(OriObj.Parent[1], p2);
          ShowTrace(OriObj.Parent[2], p3);
          end;
        end
      else begin
        NMC := GeoListe.InsertObject(TGMappedCircle.Create(GeoListe, OriObj, LastMapping, True),
                                    ErrNum) as TGCircle;
        If (ErrNum = 0) and PolyFilled and TGCircle(OriObj).IsFilled(FO) then
          GeoListe.InsertObject(TGArea.Create(GeoListe, NMC, True, True), ErrNum);
        end
    else if map_type <= mapAffineMapMat then begin  // Affine Abbildungen
      GeoListe.InsertObject(TGMappedConic.Create(GeoListe, OriObj as TGLine, LastMapping, True),
                           ErrNum);
      end
    else          // d.h. map_type = mapInversion, also: Inversion am Kreis
      If OriObj.ClassType <> TGArc then begin
        NMC := GeoListe.InsertObject(TGMappedCircle.Create(GeoListe, OriObj, LastMapping, True),
                                    ErrNum) as TGCircle;
        If (ErrNum = 0) and PolyFilled and
           (OriObj.ClassType <> TGArc) and
           (TGCircle(OriObj).IsFilled(FO)) then
          GeoListe.InsertObject(TGArea.Create(GeoListe, NMC, True, True), ErrNum);
        end
      else
        MessageDlg(MyMess[70], mtError, [mbOk], 0);
    end;

  procedure CreateMappedPolygon;
    var PList : TList;
        GO    : TGPoint;
        NPO   : TGPolygon;
        i     : Integer;
        FO    : TGArea;     { 'F'ill 'O'bject }
    begin
    If map_type <> mapInversion then begin
      PList := TList.Create;
      For i := 0 to Pred(OriObj.Parent.Count) do begin
        GO := GeoListe.InsertObject(TGMappedPoint.Create(GeoListe, OriObj.Parent[i], LastMapping, True),
                                   ErrNum) as TGPoint;
        If withTraces then
          ShowTrace(OriObj.Parent[i], GO);
        PList.Add(GO);
        end;
      PList.Add(PList.Items[0]);
      For i := 1 to Pred(PList.Count) do
        GeoListe.InsertObject(TGShortLine.Create(GeoListe, PList[Pred(i)], PList[i], True), ErrNum);
      NPO := GeoListe.InsertObject(TGPolygon.Create(GeoListe, PList, True),
                                  ErrNum) as TGPolygon;
      If (ErrNum in [0, 5]) and     { ErrNum "5" ergänzt 27.06.06 wg. Kittel-Problem }
         PolyFilled and TGPolygon(OriObj).IsFilled(FO) then
        GeoListe.InsertObject(TGArea.Create(GeoListe, NPO, True, True), ErrNum);
      PList.Free;
      end
    else
      MessageDlg(MyMess[70], mtError, [mbOk], 0);
    end;

  procedure CreateMappedCurve;
    var MC     : TGCurve;
        ErrNum : Integer;
    begin
    If map_type in [mapReflectionLine..mapAffineMapMat] then begin
      MC := Nil;
      If OriObj is TGConic then
        MC := TGMappedConic.Create(GeoListe, OriObj as TGConic, LastMapping, OriObj.IsVisible)
      else if OriObj is TGLocLine then
        MC := TGMappedLocLine.Create(GeoListe, OriObj as TGLocLine, LastMapping);
      If MC <> Nil then
        GeoListe.InsertObject(MC, ErrNum)
      else
        MessageDlg(MyMess[70], mtError, [mbOk], 0);
      end
    else
      MessageDlg(MyMess[70], mtError, [mbOk], 0);
    end;

  procedure CreateMappedImage;
    begin
    If map_type in [mapReflectionLine..mapAffineMapMat] then
      GeoListe.InsertObject(TGMappedImage.Create(GeoListe, OriObj as TGImage, LastMapping, OriObj.IsVisible), ErrNum)
    else
      MessageDlg(MyMess[70], mtError, [mbOk], 0);
    end;

  begin { of MakeMappedObj }
  SetMapping;
  If LastMapping <> Nil then begin
    If OriObj is TGPoint then
      CreateMappedPoint
    else if OriObj is TGStraightLine then
      CreateMappedStraightLine
    else if OriObj is TGCircle then
      CreateMappedCircle
    else if OriObj is TGPolygon then
      CreateMappedPolygon
    else if (OriObj is TGConic) or
            (OriObj is TGLocLine) then
      CreateMappedCurve
    else if (OriObj is TGImage) then
      CreateMappedImage
    else
      MessageDlg(MyMess[70], mtError, [mbOk], 0);
    end
  else
    MessageDlg(MyMess[86], mtError, [mbOk], 0);
  end;  { of MakeMappedObj }


procedure TCmdExecuter.MakePolygon(var ErrNum: Integer);
  { Der aktuelle Eckpunkt darf nur als letzter (!) in der Start-Liste
    vorkommen. Falls er zusätzlich mit einer Nummer 1 < n < Count-1
    vorkommt, gibt's eine Fehlermeldung. Falls er zusätzlich als erster
    (also mit n = 0) vorkommt und schon mindestens 3 gültige Ecken
    registriert sind, wird das Polygon geschlossen.
    Überarbeitet 26.07.99 wg. BugReport Matthias Taulien;
    überarbeitet 07.10.03 wg. BugReport Dietmar Viertel. }
  var Polygon   : TGeoObj;
      Vertexes  : TList;
      i         : Integer;
  begin
  With InpList do
    If (Count > 3) and
       (TInpObj(Last).sel_obj = TInpObj(First).sel_obj) then begin  { Schließen }
      GeoListe.InsertObject(TGShortLine.Create(GeoListe, GetInpObj(Count-2),
                                               GetInpObj(Count-1), True), ErrNum);
      Vertexes := TList.Create;
      For i := 0 to Pred(InpList.Count) do
        Vertexes.Add(GetInpObj(i));
      Polygon := GeoListe.InsertObject(TGPolygon.Create(GeoListe, Vertexes, True), ErrNum);
      Vertexes.Free;
      If PolyFilled then
        GeoListe.InsertObject(TGArea.Create(GeoListe, TGLine(Polygon), True, True), ErrNum);
      Clear;
      FModus := cmd_NEckReady;
      end
    else begin                    { Erweitern }
      If Count > 1 then
        If IndexOf(Last) = Count-1 then
          GeoListe.InsertObject(TGShortLine.Create(GeoListe, GetInpObj(Count-2),
                                                   GetInpObj(Count-1), True), ErrNum)
        else begin
          Delete(Count-1);
          WaitMessageDlg(MyMess[15], mtError, [mbOk], 0);
          end;
      NextIObjIndex := Count;
      Add(TInpObj.create(ccAnyPoint, Nil));
      end;
  end;


procedure TCmdExecuter.MakeIntersection(GO1, GO2: TGeoObj; var ErrNum: Integer);
    var ISec   : TGeoObj;
        ErrNum1,
        ErrNum2,
        n, i   : Integer;
    begin
    If (GO1 is TGConic) or (GO2 is TGConic) then begin  // mindestens 1 Kegelschnitt !
      If not (GO2 is TGConic) then begin
        ISec := GO1; GO1 := GO2; GO2 := ISec;
        end;          // Jetzt ist immer der 2. Parameter ein Kegelschnitt !
      If (GO1 is TGConic) or (GO1 is TGCircle) then begin
        ISec := GeoListe.InsertObject(TGQuadIntersection.Create(GeoListe, GO1, GO2), ErrNum);
        n := 4;
        end
      else begin      // Schnitt von Kegelschnitt mit einer geraden Linie !
        ISec := GeoListe.InsertObject(TGDoubleIntersection.Create(GeoListe, GO1, GO2), ErrNum);
        n := 2;
        end;
      For i := 1 to n do
        GeoListe.InsertObject(TGIntersectPt.Create(GeoListe, ISec, i-1, True), ErrNum);
      end
    else
    If (GO1 is TGCircle) or (GO2 is TGCircle) then begin
      If (GO2 is TGCircle) then  { Kreis als 2. Parameter ! }
        ISec := GeoListe.InsertObject(TGDoubleIntersection.Create(GeoListe, GO1, GO2), ErrNum)
      else
        ISec := GeoListe.InsertObject(TGDoubleIntersection.Create(GeoListe, GO2, GO1), ErrNum);
      If ISec.Parent.Count <= 2 then begin
        GeoListe.InsertObject(TGIntersectPt.Create(GeoListe, ISec, 0, True), ErrNum1);
        GeoListe.InsertObject(TGIntersectPt.Create(GeoListe, ISec, 1, True), ErrNum2);
        If (ErrNum1 = 0) or (ErrNum2 = 0) then
          ErrNum := 0
        else
          If ErrNum1 > ErrNum2 then   { Mindestens eines der Objekte existiert schon! }
            ErrNum := ErrNum1
          else
            ErrNum := ErrNum2;
        end
      else
        GeoListe.InsertObject(TGIntersectPt.Create(GeoListe, ISec, 0, True), ErrNum);
      { Wenn das DoublePt-Objekt nur 2 Eltern hat, werden zwei Schnitt-
        punkte erzeugt. Gibt es einen 3. Elter, dann ist einer
        der Schnittpunkte mit dem Kreis schon als definierender Punkt
        auf dieser Kreislinie vorhanden. In diesem Fall braucht man
        nur noch einen zusätzlichen Schnittpunkt, der immer brav die Rolle
        des "anderen" Schnittpunktes spielt!         }
      end
    else
      GeoListe.InsertObject(TGLxLPt.Create(GeoListe, GO1, GO2, True),
                           ErrNum);   { Andernfalls werden 2 Geraden  }
    end;                              { bzw. Strecken übergeben.      }


procedure TCmdExecuter.DoCheckSolution;
    var ZielObj   : Array of TGeoObj;
        GoOn      : Boolean;
        ValResDlg : TValidationResultWin;
        res, i    : Integer;
  begin
  Screen.Cursor := crHourGlass;
  SetLength(ZielObj, InpList.Count);
  For i := 0 to Pred(InpList.Count) do
    ZielObj[i] := TInpObj(InpList[i]).sel_obj;
  res := GeoListe.CheckSolution(ZielObj);
  Screen.Cursor := crDefault;
  Case res of
    0 : begin                   // Alles okay, Zeichung korrekt !
        GoOn := Length(GeoListe.LinkForward) > 0;
        ValResDlg := TValidationResultWin.CreateWD(DrawWin, True, GoOn, True);
        With ValResDlg do begin
          ShowModal;
          GoOn := GoOn and CB_GoToNext.Checked;
          Free;
          end;
        If GoOn then
          SendMessage(Handle, cmd_JumpLink, idh_LinkForward, 0);
        end;
    1 : begin                   // Fehler in Korrektheits-Bedingung
        GeoListe.SimClose;
        MessageDlg(MyMess[111],
                   mtError, [mbOk], cmd_CheckSol);
        end;
    2 : begin                   // Zeichnung nicht korrekt
        GoOn := Length(GeoListe.LinkBack) > 0;
        ValResDlg := TValidationResultWin.CreateWD(DrawWin, False, GoOn, True);
        With ValResDlg do begin
          ShowModal;
          GoOn := CB_GoToNext.Enabled and CB_GoToNext.Checked;
          Free;
          end;
        If GoOn then begin
          GeoListe.SimClose;
          SendMessage(Handle, cmd_JumpLink, idh_LinkBack, 0);
          end
        else begin
          GeoListe.SimDrag(True, 1);  // Zurück in Anfangslage !
          GeoListe.SimClose;
          end;
        end;
  end; { of case }
  ZielObj := Nil;
  end;

procedure TCmdExecuter.ExecuteCommand(cl_x, cl_y: Integer);
  var n, err : Integer;
      px, py : String;
      newObj : TGeoObj;
  begin
  err := 0;
  Case Modus of
    cmd_PCreate : GeoListe.InsertObject
                    (TGPoint.Create(GeoListe, cl_x, cl_y, True),
                     err);
    cmd_PonLine : begin
                  newObj := GeoListe.InsertObject
                    (TGPoint.Create(GeoListe, cl_x, cl_y, True), err);
                  DoBindPoint2Line(newObj as TGPoint, GetInpObj(0) as TGLine);
                  end;
    cmd_SCreate : GeoListe.InsertObject
                    (TGShortLine.Create(GeoListe, GetInpObj(0), GetInpObj(1), True),
                     err);
    cmd_GCreate : GeoListe.InsertObject
                    (TGLongLine.Create(GeoListe, GetInpObj(0), GetInpObj(1), True),
                     err);
    cmd_Vector  : GeoListe.InsertObject
                    (TGVector.Create(GeoListe, GetInpObj(0), GetInpObj(1), True),
                     err);
    cmd_Strahl  : GeoListe.InsertObject
                    (TGHalfLine.Create(GeoListe, GetInpObj(0), GetInpObj(1), True),
                     err);
    cmd_KCreate : GeoListe.InsertObject
                    (TGCircle.Create(GeoListe, GetInpObj(0), GetInpObj(1), True),
                     err);
    cmd_NCreate : MakePolygon(err);

    cmd_Schnitt : MakeIntersection(GetInpObj(0), GetInpObj(1), err);

    cmd_Mitte   : GeoListe.InsertObject
                    (TGMiddlePt.Create(GeoListe, GetInpObj(0), GetInpObj(1), True),
                     err);
    cmd_MSenkr  : GeoListe.InsertObject
                    (TGMSenkr.Create(GeoListe, GetInpObj(0), GetInpObj(1), True),
                     err);
    cmd_WHalb   : GeoListe.InsertObject
                    (TGWHalb.Create(GeoListe, GetInpObj(0), GetInpObj(1), GetInpObj(2), True),
                     err);
    cmd_Parall  : GeoListe.InsertObject
                    (TGParall.Create(GeoListe, GetInpObj(0), GetInpObj(1), True),
                     err);
    cmd_Lot     : GeoListe.InsertObject
                    (TGSenkr.Create(GeoListe, GetInpObj(0), GetInpObj(1), True),
                     err);

    cmd_DelObj  : DoDeleteObject(GetInpObj(0));

    cmd_NameObj : If Selected is TGComment then
                    DoEditComment(Selected)
                  else
                    DoNameObject(Selected);
    cmd_Comment : DoNewComment;

    cmd_BindP2L : DoBindPoint2Line(TGPoint(GetInpObj(0)), TGLine(GetInpObj(1)));

    cmd_ReleaseP: DoReleasePoint(TGPoint(GetInpObj(0)));

    cmd_MirrorAxisObj  : MakeMappedObj(mapReflectionLine, GetInpObj(0), GetInpObj(1), Nil,
                                       AutoTraceMirrorAxis, err);
    cmd_MirrorCentreObj: MakeMappedObj(mapReflectionPoint, GetInpObj(0), GetInpObj(1), Nil,
                                       AutoTraceMirrorCentre, err);
    cmd_MoveObj        : MakeMappedObj(mapTranslation, GetInpObj(0), GetInpObj(1), Nil,
                                       AutoTraceMove, err);
    cmd_RotateObj      : MakeMappedObj(mapRotation, GetInpObj(0), GetInpObj(1), GetInpObj(2),
                                       AutoTraceRotate, err);
    cmd_StretchObj     : MakeMappedObj(mapDilation, GetInpObj(0), GetInpObj(1), GetInpObj(2),
                                       AutoTraceStretch, err);
    cmd_MirrorCircleObj: MakeMappedObj(mapInversion, GetInpObj(0), GetInpObj(1), Nil,
                                       False, err);
    cmd_MapObj         : MakeMappedObj(0, GetInpObj(0), Nil, Nil, FLastAutoTrace, err);

    cmd_MakeLocLine    : If OLineMode = 1 then begin
                           GeoListe.InsertObject(TGLocLine.Create(GeoListe, GetInpObj(0) as TGPoint),
                                                 err);
                           OLineMode := 3;
                           end;

    cmd_MeasureAngle   : If InpList.Count = 3 then begin
                           newObj := TGAngle.Create(GeoListe, GetInpObj(0), GetInpObj(1), GetInpObj(2), True);
                           newObj := GeoListe.InsertObject(newObj, err);
                           GeoListe.InsertObject(TGAngleWidth.Create(GeoListe, newObj, True),
                                                 err);
                           end
                         else
                           GeoListe.InsertObject
                             (TGAngleWidth.Create(GeoListe, GetInpObj(0), True),
                              err);
    cmd_MeasureDist    : GeoListe.InsertObject(TGDistLine.Create(GeoListe, GetInpObj(0), GetInpObj(1), True),
                                               err);
    cmd_MeasureSL      : GeoListe.InsertObject(TGDistLine.Create(GeoListe, GetInpObj(0), GetInpObj(1), True),
                                               err);
    cmd_MeasureArea    : GeoListe.InsertObject(TGAreaSize.Create(GeoListe, GetInpObj(0), True),
                                               err);
    cmd_NumberObj      : GeoListe.InsertObject(TGNumberObj.Create(GeoListe, 100, -3, 1, 5, True),
                                               err);
    cmd_TermObj        : DoNewTermObj(cl_x, cl_y, err);

    cmd_GRichtTerm     : DoMakeGRicht(err);

    cmd_MCreate        : DoMakeCircleWDR(err);

    cmd_ToggleVis      : If InpList.Count > 0 then begin
                           DoHideObject(GetInpObj(0));
                           DrawWin.Invalidate;
                           end;
    cmd_EditColour     : If Selected <> Nil then begin
                           Selected.MyColour := TColor(PopupParam);
                           DrawWin.Invalidate;
                           end;
    cmd_EditLineStyle  : If Selected <> Nil then begin
                           Selected.SetGraphTools(PopupParam, 0, 0, Selected.MyColour);
                           DrawWin.Invalidate;
                           end;
    cmd_EditPointStyle : If Selected <> Nil then begin
                           Selected.SetGraphTools(0, PopupParam, 0, Selected.MyColour);
                           DrawWin.Invalidate;
                           end;
    cmd_EditPattern    : If Selected <> Nil then begin
                           Selected.SetGraphTools(0, 0, PopupParam, Selected.MyColour);
                           DrawWin.Invalidate;
                           end;

    cmd_EditLocLineStyle : If Selected <> Nil then begin
                             If Selected.MyLineWidth > 1 then
                               Selected.MyLineWidth := 1
                             else
                               Selected.MyLineWidth := 3;
                             DrawWin.Invalidate;
                             end;
    cmd_EditLocLineCurve : If Selected <> Nil then begin
                             TGLocLine(Selected).IsSpline :=
                               Not TGLocLine(Selected).IsSpline;
                             DrawWin.Invalidate;
                             end;
    cmd_EditLocLineDyna  : If Selected <> Nil then
                             TGLocLine(Selected).IsDynamic :=
                               Not TGLocLine(Selected).IsDynamic;
    cmd_EditLocLineStnd  : If Selected <> Nil then begin
                             If (TGeoObj(Selected.Parent[0]) is TGLocLine) and
                                (TGLocLine(Selected.Parent[0]).IsStandardLine) then
                               With TGLocLine(Selected.Parent[0]) do begin
                                 If IsStraightLine then
                                   IsStraightLine := False
                                 else
                                   If IsCircle then
                                     IsCircle := False;
                                 end
                             else
                               If (TGeoObj(Selected) is TGLocLine) and
                                  (TGLocLine(Selected).Check4StandardLine(n)) then begin
                                 If n = ols_IsStraightLine then
                                   TGLocLine(Selected).IsStraightLine := True
                                 else
                                   If n = ols_IsCircle then
                                     TGLocLine(Selected).IsCircle := True;
                                 end;
                             DrawWin.Invalidate;
                             end;

    cmd_EditTerm         : If (Selected <> Nil) or
                              (cl_x = cmd_EditTerm) then
                             DoEditTerm;
    cmd_EditRange        : If Selected <> Nil then
                             DoEditRange;
    cmd_EditRadius,
    cmd_EditAngle,
    cmd_EditFunktion     : begin
                           If Selected = Nil then
                             FSelected := PopupObj;
                           If Selected <> Nil then begin
                             FSelected.scrx := cl_x;
                             FSelected.scry := cl_y;
                             DoEditValTerm;
                             end;
                           end;
    cmd_EditCoords       : begin
                           If Selected = Nil then
                             FSelected := PopupObj;
                           If Selected <> Nil then
                             DoEditValTerm;
                           end;
    cmd_RunMakro         : If Selected <> Nil then begin
                             Selected.SetAsStartObject4MacroRun(MakNum, CmdNum);
                             InitInpList(cmd_RunMakro);
                             end;
    cmd_CheckSol         : DoCheckSolution;

    cmd_EllipseF         : GeoListe.InsertObject(TGEllipseF.Create(GeoListe,
                                                                   GetInpObj(0) as TGPoint,
                                                                   GetInpObj(1) as TGPoint,
                                                                   GetInpObj(2) as TGPoint, True),
                                                 err);
    cmd_ParabelF         : GeoListe.InsertObject(TGParabelF.Create(GeoListe,
                                                                   GetInpObj(0) as TGPoint,
                                                                   GetInpObj(1) as TGStraightLine, True),
                                                 err);
    cmd_HyperbelF        : GeoListe.InsertObject(TGHyperbelF.Create(GeoListe,
                                                                    GetInpObj(0) as TGPoint,
                                                                    GetInpObj(1) as TGPoint,
                                                                    GetInpObj(2) as TGPoint, True),
                                                 err);
    cmd_Graph            : DoMakeFunktion(err);

    cmd_SetDotPt         : begin
                           px := FloatToStr(GetInpObj(0).GetValue(gv_x));
                           py := FloatToStr(GetInpObj(0).GetValue(gv_y));
                           newObj := TGXPoint.Create(GeoListe, px, py, True);
                           newObj.MyBrushStyle := bsClear;
                           newObj.MyColour := clRed;
                           GeoListe.InsertObject(NewObj, err);
                           end;

  end; { of case }
  Case err of
    0,    { Kein Fehler ! }
    1,    { derzeit nicht verwendet !!! }
    5 : ; { Objekt schon als gelöschtes Objekt vorhanden; keine Meldung ! }
    2 : MessageDlg(MyMess[16], mtInformation, [mbOk], 0);
    3 : MessageDlg(MyMess[27], mtError, [mbOk], 0);
    4 : MessageDlg(MyMess[47], mtInformation, [mbOk], 0);
  else
    MessageDlg(MyMess[87], mtError, [mbOk], 0);
  end;
  If Not (Modus in [cmd_Drag, cmd_NCreate, cmd_TermInput, cmd_EditTerm,
                    cmd_EditRadius, cmd_EditAngle, cmd_EditCoords,
                    cmd_GRichtTerm, cmd_MCreate, cmd_TermObj, cmd_Graph,
                    cmd_RunMakro]) then
    Reset2DragMode;
  end;


{---------- Animation --------------------------------------}

procedure TCmdExecuter.StartAnimation;
  begin
  If GeoListe.AnimationSource <> Nil then begin
    GeoListe.IsDoubleBuffered := True;
    GeoListe.FillDragList(GeoListe.AnimationSource);
    GeoListe.AnimationRunning := True;
    With GeoListe.AnimationSource do
      If Modus = cmd_RunAnimaFD then begin
        If AniMaxValue - AniValue < AniStep then
          AniValue := AniMinValue;
        end
      else { also Modus = cmd_RunAnimaBK ! }
        If AniValue - AniMinValue < AniStep then
          AniValue := AniMaxValue;
    RunAnimation;      
    end;
  end;

procedure TCmdExecuter.RunAnimation;
  var newMode: Integer;
  begin
  try
    If DrawWin.Tag >= 0 then begin
      newMode := GeoListe.Animate(Modus);
      If newMode in [cmd_RunAnimaFD, cmd_RunAnimaBK] then  // Wiederholung
        PostMessage(Handle, cmd_RunAnimation, Modus, 0)    //   anstoßen
      else begin
        GeoListe.AnimationRunning := False;     // Aufräumen und zurück
        Reset2DragMode;                         //   zum Zugmodus
        end;
      end;
  except
    // Nichts tun! Das DynaGeoX-Objekt ist eigentlich schon abgebaut!
  end;
  end;

{---------- Makros -----------------------------------------}

procedure TCmdExecuter.StartMakro(MakroNum: Integer);
  begin
  MakNum := MakroNum;
  CmdNum := 0;
  TMakro(GeoListe.MakroList[MakNum]).Reset(GeoListe);
  Modus  := cmd_RunMakro;   // ruft automatisch InitInpList auf !
  GeoTimer.InitObjBlinking(GeoListe);
  end;

procedure TCmdExecuter.RunMakro;
  var ActMakro : TMakro;
  begin
  NextIObjIndex := -1;
  ActMakro := TMakro(GeoListe.MakroList[MakNum]);
  ActMakro.RunIt(MakNum);
  If ActMakro.MakroStatus <> 0 then
    ActMakro.ShowErrorMsg(CmdNum);
  MakNum := -1;
  CmdNum := -1;
  Reset2DragMode;
  end;

{---------- Maus-Ereignis-Methoden -------------------------}

procedure TCmdExecuter.MouseMoveProc(Shift: TShiftState; X, Y: Integer);
  begin
  If (GeoListe = Nil) or Wait then Exit;
  If ssLeft in Shift then  { Linke Maustaste gedrückt       }
    If Selected <> Nil then
      If Selected = GeoListe.Items[0] then begin
        GeoListe.Slide(X - LastMousePos.x, Y - LastMousePos.y);
        DrawWin.Repaint;
        end
      else
        If Modus = cmd_Drag then begin  { Nur im Zug-Modus! }
          GeoListe.DragObjects(X, Y, ssCtrl in Shift);
          GeoListe.DrawFirstObjects(GeoListe.LastValidObjIndex);
          end
        else
    else
      If ssShift in Shift then begin
        GeoListe.Slide(X - LastMousePos.x, Y - LastMousePos.y);
        DrawWin.Cursor := HandCursor;
        DrawWin.Repaint;
        end
      else
  else begin               { Linke Maustaste nicht gedrückt }
    FSelected := GetMousedObject(X, Y, ExpectedType);
    ActualizeMouseCursor(Shift);
    end;
  FLastMousePos := Point(X, Y);
  end;


procedure TCmdExecuter.MouseDownProc(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  { Wird nur aufgerufen für Klicks mit der linken Maustaste ! }
  var ttag : Integer;
  begin
  If (GeoListe = Nil) or Wait then Exit;
  Case Modus of
    cmd_Drag        : begin   { Zug-Modus     }
                      SelectUniqueDragObject(X, Y);
                      If Selected <> Nil then begin
                        GeoListe.LastMousePos := Point(X, Y);
                        GeoListe.FillDragList(Selected);
                        If Selected is TGTextObj then
                          if Selected is TGComment then begin
                            ttag := (Selected as TGComment).GetLinkTagFromWinPos(GeoListe.LastMousePos);
                            Case ttag of
                               0 : TGComment(Selected).InitMoving(X, Y);
                            1000 : TGComment(Selected).Expand;
                            1001 : TGComment(Selected).Collapse;
                             { Hier die Behandlungsroutinen für alle anderen "special cases"
                               (z.B. für Spezial-Buttons in Textboxen) ergänzen ! }
                            end; { of case / else }
                            If ttag > 0 then  // Anzeige aktualisieren !
                              GeoListe.DrawFirstObjects(GeoListe.LastValidObjIndex, True);
                            end
                          else
                            TGTextObj(Selected).InitMoving(X, Y)
                        else if Selected is TGNumberObj then
                          GeoTimer.InitNumberAdjust(TGNumberObj(Selected));
                        If OLineMode = 3 then
                          OLineMode := 4;
                        end
                      else
                        If ssShift in Shift then
                          DrawWin.Cursor := HandCursor
                        else
                          DrawWin.Cursor := crDefault;
                      end;
    cmd_RunMakro    : If MakNum < 0 then
                        Reset2DragMode
                      else begin
                        RegisterInpObj(X, Y);
                        If (NextIObjIndex >= InpList.Count) or
                           (InpList.Count = 0) then
                          ExecuteCommand(X, Y);
                        end;
    cmd_ChooseMakro,
    cmd_RunAnimaFD,
    cmd_RunAnimaBK,
    cmd_ContextMenu : Reset2DragMode;
  else                             { Anderer Modus }
    RegisterInpObj(X, Y);
    If (NextIObjIndex >= InpList.Count) or
       (InpList.Count = 0) then
      ExecuteCommand(X, Y);
  end;
  FLastMousePos := Point(X, Y);
  end;

procedure TCmdExecuter.MouseUpProc(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var TL : TGLine;
  begin
  If (GeoListe = Nil) or Wait then Exit;
  If (Modus = cmd_Drag) and
     (Selected <> Nil) then begin
    GeoTimer.Reset(GeoListe);
    If Selected is TGTextObj then
      TGTextObj(Selected).SetNewRelativPos;
    If OLineMode = 4 then begin
      With GeoListe do
        If TGeoObj(Items[LastValidObjIndex]) is TGLocLine then
          with TGLocLine(Items[LastValidObjIndex]) do begin
            IsDynamic   := (NewLocLineStatus and ols_IsDynamic > 0) and
                           TGPoint(Parent[0]).IsLineBound(TL);
            IsSpline    := NewLocLineStatus and ols_IsSpline > 0;
            DrawWin.Invalidate;
            end;
      OLineMode := 0;
      end;
    GeoListe.ResetDragList;
    GeoListe.AutoUpdateLocLines;
    FSelected := Nil;
    end;
  end;

procedure TCmdExecuter.DoubleClickProc(Sender: TObject);
  var SelObj : TGeoObj;
      ttag   : Integer;
  begin
  If (Modus = cmd_Drag) and (Selected <> Nil) then begin
    SelObj := Selected;
    If SelObj is TGTermObj then
      Modus := cmd_EditTerm
    else if SelObj is TGComment then begin
      ttag := TGComment(SelObj).GetLinkTagFromWinPos(GeoListe.LastMousePos);
      Case ttag of
         0 : if (Not TGComment(SelObj).IsDynamic) then begin  // editieren
               InitInpList(cmd_NameObj);
               TInpObj(InpList.Items[0]).sel_obj := SelObj;
               ExecuteCommand(0, 0); // ProcessGeoObject;
               end;
      1000 : ;  // Nichts zu tun, da schon als Einfach-Klick abgearbeitet !
      1001 : ;  // Nichts zu tun, da schon als Einfach-Klick abgearbeitet !
       { Hier die Behandlungsroutinen für alle anderen "special cases"
         (z.B. für Spezial-Buttons in Textboxen) ergänzen ! }
      else              // Doppelklick auf einen Link
        SendMessage(Handle, cmd_JumpLink, ttag, 0);
      end; { of case - else }
      end  { of else if LastSelectedObj is TGComment }
    else
      Modus := cmd_NameObj;
    Fselected := SelObj;
    ExecuteCommand(0, 0);
    end;
  end;

{----------- Tastatur-Ereignis-Methoden ---------------------}

procedure TCmdExecuter.KeyPressedProc(key: Char; shift: TShiftState);
  begin
  If Modus in [cmd_RunAnimaFD, cmd_RunAnimaBK] then
    Case key of
      '+' : GeoListe.AnimationSource.ChangeAniSpeed(1.500);
      '-' : GeoListe.AnimationSource.ChangeAniSpeed(0.666);
      '*' : Case FModus of
              cmd_RunAnimaFD : FModus := cmd_RunAnimaBK;
              cmd_RunAnimaBK : FModus := cmd_RunAnimaFD;
            end;
    end; { of case }
  end;

end.
