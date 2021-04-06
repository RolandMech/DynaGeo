unit SpeedBtnData;

interface

Uses classes, buttons;

type
     TSpBtnData     = class(TObject)
                      public
                        SpBtn    : TSpeedButton;
                        CmdId,
                        HelpId,
                        ToolPage,
                        OrgLeft  : Integer;
                        constructor Create(iSpBtn : TSpeedButton;
                                           iCmdId,
                                           iHelpId,
                                           iPage  : Integer);
                      end;

     TSpBtnDataList = class(TList)
                      protected
                        PageCount,
                        RightBorder : Integer;
                        Offset      : Array of Integer;
                        ScrollBtn   : Array of TSpeedButton;
                        procedure SetBtnVisibility(PageNum, Width: Integer );
                        procedure FillWithData;
                        procedure FillUpFreeSpace(     fbi , lbi : Integer;
                                                   var fvbi, lvbi: Integer );
                      public
                        constructor Create;
                        function GetSpeedBtnFromCommand (cmd : Integer): TSpeedButton;
                        function GetHelpIdFromCommand   (cmd : Integer): Integer;
                        function GetToolPageFromCommand (cmd : Integer): Integer;
                        function GetHelpIdFromSpeedBtn  (Btn : TSpeedButton): Integer;
                        function GetToolPageFromSpeedBtn(Btn : TSpeedButton): Integer;
                        function GetCommandFromSpeedBtn (Btn : TSpeedButton): Integer;
                        procedure UpperAllButtons;
                        procedure ResizeSpeedBar(Width: Integer);
                        procedure ScrollLeft(PageNum: Integer);
                        procedure ScrollRight(PageNum: Integer);
                        destructor Destroy; override;
                      end;


implementation

uses windows, graphics, math, declar, globvars, mainwin;


constructor TSpBtnData.Create(iSpBtn : TSpeedButton;
                              iCmdId,
                              iHelpId,
                              iPage: Integer);
  begin
  Inherited Create;
  SpBtn    := iSpBtn;
  CmdId    := iCmdId;
  HelpId   := iHelpId;
  ToolPage := iPage;
  OrgLeft  := SpBtn.Left;
  end;

{ TSpBtnDataList }

constructor TSpBtnDataList.Create;
  begin
  Inherited Create;
  FillWithData;
  end;

function TSpBtnDataList.GetHelpIdFromCommand(cmd: Integer): Integer;
  var i : Integer;
  begin
  Result := -1;    { Default-Wert }
  i := 0;
  While (Result < 0) and (i < Count) do
    If TSpBtnData(Items[i]).CmdId = cmd then
      Result := TSpBtnData(Items[i]).HelpId
    else
      Inc(i);
  end;

function TSpBtnDataList.GetSpeedBtnFromCommand(cmd: Integer): TSpeedButton;
  var i : Integer;
  begin
  Result := Nil;   { Default-Wert }
  i := 0;
  While (Result = Nil) and (i < Count) do
    If TSpBtnData(Items[i]).CmdId = cmd then
      Result := TSpBtnData(Items[i]).SpBtn
    else
      Inc(i);
  If Result = Nil then      // Ausnahme-Regelungen
    Case cmd of
      cmd_RepeatMapping: Result := Hauptfenster.SB_MapObj;
    end;
  end;

function TSpBtnDataList.GetToolPageFromCommand(cmd: Integer): Integer;
  var i : Integer;
  begin
  Result := -1;    { Default-Wert }
  i := 0;
  While (Result < 0) and (i < Count) do
    If TSpBtnData(Items[i]).CmdId = cmd then
      Result := TSpBtnData(Items[i]).ToolPage
    else
      Inc(i);
  end;

function TSpBtnDataList.GetHelpIdFromSpeedBtn(Btn: TSpeedButton): Integer;
  var i : Integer;
  begin
  Result := -1;    { Default-Wert }
  i := 0;
  While (Result < 0) and (i < Count) do
    If TSpBtnData(Items[i]).SpBtn = Btn then
      Result := TSpBtnData(Items[i]).HelpId
    else
      Inc(i);
  end;

function TSpBtnDataList.GetToolPageFromSpeedBtn(Btn: TSpeedButton): Integer;
  var i : Integer;
  begin
  Result := -1;    { Default-Wert }
  i := 0;
  While (Result < 0) and (i < Count) do
    If TSpBtnData(Items[i]).SpBtn = Btn then
      Result := TSpBtnData(Items[i]).ToolPage
    else
      Inc(i);
  end;

function TSpBtnDataList.GetCommandFromSpeedBtn(Btn: TSpeedButton): Integer;
  var i : Integer;
  begin
  Result := -1;    { Default-Wert }
  i := 0;
  While (Result < 0) and (i < Count) do
    If TSpBtnData(Items[i]).SpBtn = Btn then
      Result := TSpBtnData(Items[i]).CmdId
    else
      Inc(i);
  end;

procedure TSpBtnDataList.FillWithData;
  { 09.03.2011 :  Diejenigen SpeedButtons, die zusätzlich mit ALT-Befehlen
                  belegt sind, werden mehrfach (bisher: doppelt!) registriert.
    Ob das überhaupt irgend einen praktischen Nutzen bringt bzw. irgend wo
    wirklich verwendet wird, ist derzeit unklar.
    Immerhin wurden die Algorithmen zum Scrollen verkürzter Werkzeug-Leisten
    umgerüstet, so dass sie jetzt nicht mehr durch die doppelten Einträge aus
    der Kurve fliegen.                                                       }
  var i : Integer;
  begin
  With HauptFenster do begin
    Add(TSpBtnData.Create(SB_FileNew,        cmd_New,         101, 0));
    Add(TSpBtnData.Create(SB_FileLoad,       cmd_Load,        102, 0));
    Add(TSpBtnData.Create(SB_FileSave,       cmd_Save,        103, 0));
    Add(TSpBtnData.Create(SB_FilePrint,      cmd_Print,       106, 0));
    Add(TSpBtnData.Create(SB_Undo,           cmd_Undo,        203, 0));
    Add(TSpBtnData.Create(SB_UndoUndo,       cmd_UndoUndo,    204, 0));
    Add(TSpBtnData.Create(SB_NameObj,        cmd_NameObj,     113, 0));
    Add(TSpBtnData.Create(SB_HideObj,        cmd_ToggleVis,   112, 0));
    Add(TSpBtnData.Create(SB_EraseObj,       cmd_DelObj,      114, 0));
    Add(TSpBtnData.Create(SB_BindPoint2Line, cmd_BindP2L,     152, 0));
    Add(TSpBtnData.Create(SB_ReleasePoint,   cmd_ReleaseP,    153, 0));
    Add(TSpBtnData.Create(SB_TextBox,        cmd_Comment,      90, 0));
    Add(TSpBtnData.Create(SB_Image,          cmd_Image,        91, 0));
    Add(TSpBtnData.Create(SB_Action,         cmd_RunMakro,   1217, 0));
    Add(TSpBtnData.Create(SB_CheckSolution,  cmd_CheckSol,   1350, 0));

    Add(TSpBtnData.Create(SB_BasePoint,      cmd_PCreate,   121, 1));
    Add(TSpBtnData.Create(SB_CoordPoint,     cmd_PtCoord,    42, 1));
    Add(TSpBtnData.Create(SB_PointOnLine,    cmd_PonLine,   109, 1));
    Add(TSpBtnData.Create(SB_Intersection,   cmd_Schnitt,   132, 1));
    Add(TSpBtnData.Create(SB_MidPoint,       cmd_Mitte,     133, 1));
    Add(TSpBtnData.Create(SB_ShortLine,      cmd_SCreate,   122, 1));
    Add(TSpBtnData.Create(SB_FixLine,        cmd_LCreate,   128, 1));
    Add(TSpBtnData.Create(SB_Vector,         cmd_Vector,     45, 1));
    Add(TSpBtnData.Create(SB_MidLine,        cmd_Strahl,     43, 1));
    Add(TSpBtnData.Create(SB_LongLine,       cmd_GCreate,   123, 1));
    Add(TSpBtnData.Create(SB_Perpendicular,  cmd_Lot,       138, 1));
    Add(TSpBtnData.Create(SB_Perpendicular,  cmd_LotStrecke,138, 1));
    Add(TSpBtnData.Create(SB_ParallelLine,   cmd_Parall,    137, 1));
    Add(TSpBtnData.Create(SB_PerpBisector,   cmd_MSenkr,    135, 1));
    Add(TSpBtnData.Create(SB_PerpBisector,   cmd_Chordal,   135, 1));
    Add(TSpBtnData.Create(SB_Bisector,       cmd_WHalb,     136, 1));
    Add(TSpBtnData.Create(SB_Bisector,       cmd_WHalbKomp, 136, 1));
    Add(TSpBtnData.Create(SB_XAngleLine,     cmd_GRichtTerm,139, 1));
    Add(TSpBtnData.Create(SB_CircleArc,      cmd_Arc,        44, 1));
    Add(TSpBtnData.Create(SB_Circle,         cmd_KCreate,   124, 1));
    Add(TSpBtnData.Create(SB_Circle,         cmd_Circle3P,  124, 1));
    Add(TSpBtnData.Create(SB_XCircle,        cmd_MCreate,   129, 1));
    Add(TSpBtnData.Create(SB_Triangle,       cmd_DCreate,   125, 1));
    Add(TSpBtnData.Create(SB_Polygon,        cmd_NCreate,   131, 1));

    Add(TSpBtnData.Create(SB_MirrorAxisObj,      cmd_MirrorAxisObj,     47, 2));
    Add(TSpBtnData.Create(SB_MirrorCentreObj,    cmd_MirrorCentreObj,   49, 2));
    Add(TSpBtnData.Create(SB_MoveObj,            cmd_MoveObj,           51, 2));
    Add(TSpBtnData.Create(SB_RotateObj,          cmd_RotateObj,         53, 2));
    Add(TSpBtnData.Create(SB_StretchObj,         cmd_StretchObj,        55, 2));
    Add(TSpBtnData.Create(SB_MirrorPtAtCircle,   cmd_MirrorCircleObj,   56, 2));
    Add(TSpBtnData.Create(SB_DefineAffinMap,     cmd_DefineAffin,       57, 2));
    Add(TSpBtnData.Create(SB_MapObj,             cmd_MapObj,            58, 2));

    Add(TSpBtnData.Create(SB_MakeTrace,      cmd_MakeLocLine, 158, 3));
    Add(TSpBtnData.Create(SB_Graph,          cmd_Graph,       230, 3));
    Add(TSpBtnData.Create(SB_Graph,          cmd_Polynom,     229, 3));
    Add(TSpBtnData.Create(SB_Tangente,       cmd_Tangente,    231, 3));
    Add(TSpBtnData.Create(SB_Tangente,       cmd_Normale,     231, 3));
    Add(TSpBtnData.Create(SB_GraphArea,      cmd_GraphArea,   233, 3));
    Add(TSpBtnData.Create(SB_GraphArea,      cmd_Riemann,     233, 3));
    Add(TSpBtnData.Create(SB_EllipseF,       cmd_EllipseF,    222, 3));
    Add(TSpBtnData.Create(SB_EllipseS,       cmd_EllipseS,    223, 3));
    Add(TSpBtnData.Create(SB_EllipseK,       cmd_EllipseK,    224, 3));
    Add(TSpBtnData.Create(SB_ParabelF,       cmd_ParabelF,    225, 3));
    Add(TSpBtnData.Create(SB_ParabelT,       cmd_ParabelT,    226, 3));
    Add(TSpBtnData.Create(SB_HyperbelA,      cmd_HyperbelA,   227, 3));
    Add(TSpBtnData.Create(SB_HyperbelF,      cmd_HyperbelF,   228, 3));
    Add(TSpBtnData.Create(SB_Conic,          cmd_Conic,       221, 3));
    Add(TSpBtnData.Create(SB_Polare,         cmd_Polare,       34, 3));
    Add(TSpBtnData.Create(SB_Pol,            cmd_Pol,          35, 3));
    Add(TSpBtnData.Create(SB_MakeEnvelop,    cmd_MakeEnvelop, 235, 3));

    Add(TSpBtnData.Create(SB_EditObj,        cmd_EditDraw,  119, 4));
    Add(TSpBtnData.Create(SB_LineStyle,      cmd_EditDraw,  119, 4));
    Add(TSpBtnData.Create(SB_PointShape,     cmd_EditDraw,  119, 4));
    Add(TSpBtnData.Create(SB_ObjColour,      cmd_EditDraw,  119, 4));
    Add(TSpBtnData.Create(SB_FillArea,       cmd_FillArea,  206, 4));
    Add(TSpBtnData.Create(SB_FillColour,     cmd_FillArea,  206, 4));
    Add(TSpBtnData.Create(SB_Patterns,       cmd_FillArea,  206, 4));
    Add(TSpBtnData.Create(SB_CutArea,        cmd_CutArea,   207, 4));

    Add(TSpBtnData.Create(SB_CoordSys,       cmd_CoordSys,     241, 5));
    Add(TSpBtnData.Create(SB_FixAPoint,      cmd_FixPt,        242, 5));
    Add(TSpBtnData.Create(SB_ClipPoint2Grid, cmd_Clip2Grid,    244, 5));
    Add(TSpBtnData.Create(SB_UnfixAPoint,    cmd_UnfixPt,      243, 5));
    Add(TSpBtnData.Create(SB_MeasureDist,    cmd_MeasureDist,  156, 5));
    Add(TSpBtnData.Create(SB_MeasureDist,    cmd_MeasureSL,    156, 5));
    Add(TSpBtnData.Create(SB_MeasureAngle,   cmd_MeasureAngle, 155, 5));
    Add(TSpBtnData.Create(SB_MeasureArea,    cmd_MeasureArea,  159, 5));
    Add(TSpBtnData.Create(SB_TermObj,        cmd_TermObj,       79, 5));
    Add(TSpBtnData.Create(SB_NumberObj,      cmd_NumberObj,     78, 5));

    Add(TSpBtnData.Create(SB_AniOptions,     cmd_AnimaParams,  212, 6));
    Add(TSpBtnData.Create(SB_AniFastBK,      cmd_ResetAnima,  1246, 6));
    Add(TSpBtnData.Create(SB_AniGoBK,        cmd_RunAnimaBK,  1246, 6));
    Add(TSpBtnData.Create(SB_AniStop,        cmd_StopAnima,   1246, 6));
    Add(TSpBtnData.Create(SB_AniGoFD,        cmd_RunAnimaFD,  1246, 6));
    Add(TSpBtnData.Create(SB_AniFastFD,      cmd_ResetAnima,  1246, 6));

    //Affin.Init(RegData, RegName, RegAddr1, RegAddr2);
    end;

  PageCount := 7;                    // Anzahl der Werkzeugleisten

  SetLength(Offset, PageCount);
  For i := 0 to Pred(PageCount) do   // Alle Werkzeugleisten als
    Offset[i] := 0;                  //   unverschoben markieren

  SetLength(ScrollBtn, 2*PageCount);
  With Hauptfenster do begin
    ScrollBtn[ 0] := SB_Scroll_1L;
    ScrollBtn[ 1] := SB_Scroll_1R;
    ScrollBtn[ 2] := SB_Scroll_2L;
    ScrollBtn[ 3] := SB_Scroll_2R;
    ScrollBtn[ 4] := SB_Scroll_3L;
    ScrollBtn[ 5] := SB_Scroll_3R;
    ScrollBtn[ 6] := SB_Scroll_4L;
    ScrollBtn[ 7] := SB_Scroll_4R;
    ScrollBtn[ 8] := SB_Scroll_5L;
    ScrollBtn[ 9] := SB_Scroll_5R;
    ScrollBtn[10] := SB_Scroll_6L;
    ScrollBtn[11] := SB_Scroll_6R;
    ScrollBtn[12] := SB_Scroll_7L;
    ScrollBtn[13] := SB_Scroll_7R;
    end;
  end;

procedure TSpBtnDataList.UpperAllButtons;
  var i : Integer;
  begin
  For i := 0 to Pred(Count) do
    TSpBtnData(Items[i]).SpBtn.Down := False;
  end;

procedure TSpBtnDataList.FillUpFreeSpace(fbi, lbi: Integer; var fvbi, lvbi: Integer);
  var d, n, i : Integer;
  begin
  While (lvbi < lbi) and             // Rechts verborgene Knöpfe sichtbar machen
        (TSpBtnData(Items[lvbi+1]).SpBtn.Left + TSpBtnData(Items[lvbi+1]).SpBtn.Width
              < RightBorder - 5) do begin
    TSpBtnData(Items[lvbi+1]).SpBtn.Visible := True;
    lvbi := lvbi + 1;
    end;
  d := RightBorder - (TSpBtnData(Items[lvbi]).SpBtn.Left +
                      TSpBtnData(Items[lvbi]).SpBtn.Width);
  n := 0;
  While (fbi < fvbi-n) and
        (TSpBtnData(Items[fvbi      ]).SpBtn.Left -
         TSpBtnData(Items[fvbi-(n+1)]).SpBtn.Left < d) do
    n := n + 1;
  If n > 0 then begin
    d := TspBtnData(Items[fvbi]).SpBtn.Left - TSpBtnData(Items[fvbi-n]).SpBtn.Left;
    For i := fbi to lbi do
      With TSpBtnData(Items[i]).SpBtn do begin
        Left := Left + d;
        end;
    For i := n DownTo 1 do
      TSpBtnData(Items[fvbi-i]).SpBtn.Visible := True;
    fvbi := fvbi - n;
    end;
  end;

procedure TSpBtnDataList.SetBtnVisibility(PageNum, Width: Integer);
  var FirstBtn,
      LastBtn     : TSpeedButton;
      LeftEnable,
      RightEnable : Boolean;
      FirstBtnIndex,
      FirstVisBtnIndex,
      LastVisBtnIndex,
      LastBtnIndex,
      i           : Integer;

  begin
  i := -1;
  Repeat
    i := i + 1;
  until TSpBtnData(Items[i]).ToolPage = PageNum;
  FirstBtnIndex := i;
  FirstBtn := TSpBtnData(Items[FirstBtnIndex]).SpBtn;
  Repeat
    i := i + 1;
  until (i >= Count) or (TSpBtnData(Items[i]).ToolPage <> PageNum);
  LastBtnIndex := Pred(i);
  While (Not TSpBtnData(Items[LastBtnIndex]).SpBtn.Enabled) and
        (LastBtnIndex > FirstBtnIndex) do
    Dec(LastBtnIndex);
  LastBtn := TSpBtnData(Items[LastBtnIndex]).SpBtn;

  LeftEnable  := FirstBtn.Left < TSpBtnData(Items[FirstBtnIndex]).OrgLeft;
  RightEnable := LastBtn.Left + LastBtn.Width > Width;

  If LeftEnable or RightEnable then begin
    RightBorder := ScrollBtn[2*PageNum].Left - 5;
    FirstVisBtnIndex := -1;
    LastVisBtnIndex  := -1;
    For i := FirstBtnIndex to LastBtnIndex do
      with TSpBtnData(Items[i]) do
        If (SpBtn.Left < 0) or
           (SpBtn.Left + SpBtn.Width > RightBorder) then
          SpBtn.Visible := False
        else begin
          SpBtn.Visible := True;
          If FirstVisBtnIndex < 0 then
            FirstVisBtnIndex := i
          else
            LastVisBtnIndex  := i;
          end;
    FillUpFreeSpace(FirstBtnIndex, LastBtnIndex,
                    FirstVisBtnIndex, LastVisBtnIndex);
    If (FirstVisBtnIndex = FirstBtnIndex) and
       (LastVisBtnIndex  = LastBtnIndex ) then begin
      ScrollBtn[2*PageNum  ].Visible := False;
      ScrollBtn[2*PageNum+1].Visible := False;
      end
    else begin
      ScrollBtn[2*PageNum  ].Visible := True;
      ScrollBtn[2*PageNum  ].Enabled := FirstVisBtnIndex <> FirstBtnIndex;
      ScrollBtn[2*PageNum+1].Visible := True;
      ScrollBtn[2*PageNum+1].Enabled := LastVisBtnIndex <> LastBtnIndex;
      end;
    end
  else begin
    ScrollBtn[2*PageNum  ].Visible := False;
    ScrollBtn[2*PageNum+1].Visible := False;
    For i := FirstBtnIndex to LastBtnIndex do
      TSpBtnData(Items[i]).SpBtn.Visible := True;
    end;
  end;

procedure TSpBtnDataList.ResizeSpeedBar(Width: Integer);
  var i : Integer;
  begin
  For i := 0 to Pred(PageCount) do begin
    ScrollBtn[2*i+1].Left := Width - ScrollBtn[2*i+1].Width - 2;
    ScrollBtn[2*i  ].Left := ScrollBtn[2*i+1].Left - ScrollBtn[2*i].Width;
    SetBtnVisibility(i, Width);
    end;
  end;

{ 09.03.2010 : In den folgenden beiden SCROLL-Prozeduren wurde die Schleife,
               die die Verschiebungen der Werkzeug-Knöpfe durchführt, so
  umgestaltet, dass sie nun nicht mehr durch doppelt registrierten Werkzeug-
  knöpfe aus dem Takt gebracht wird. (Solche Doppelbelegungen werden durch
  die Registrierung von ALT-Befehlen verursacht.) Es wird dabei ausgenutzt,
  dass die Einträge für mehrfach registrierte Werkzeug-Knöpfe direkt auf-
  einanderfolgen. Wenn nun ein Eintrag bearbeitet wurde, werden eventuelle
  Folgeeinträge mit gleichem Werkzeug-Knopf-Namen übersprungen.            }

procedure TSpBtnDataList.ScrollLeft(PageNum: Integer);
  var FirstBtnIndex,
      FirstVisBtnIndex,
      LastBtnIndex,
      d, i : Integer;
  begin
  i := -1;
  Repeat
    i := i + 1;
  until (TSpBtnData(Items[i]).ToolPage = PageNum);
  FirstBtnIndex := i;
  While (i < Count) and
        (TSpBtnData(Items[i]).ToolPage = PageNum) and
        (Not TSpBtnData(Items[i]).SpBtn.Visible) do
    i := i + 1;
  FirstVisBtnIndex := i;
  Repeat
    i := i + 1;
  until (i >= Count) or (TSpBtnData(Items[i]).ToolPage <> PageNum);
  LastBtnIndex := Pred(i);
  While Not TSpBtnData(Items[LastBtnIndex]).SpBtn.Enabled do
    Dec(LastBtnIndex);
  d := RightBorder Div 2;
  i := FirstBtnIndex;
  While TSpBtnData(Items[FirstVisBtnIndex]).SpBtn.Left -
        TSpBtnData(Items[i               ]).SpBtn.Left > d do
    i := i + 1;
  If i < FirstVisBtnIndex then begin
    d := TSpBtnData(Items[FirstVisBtnIndex]).SpBtn.Left -
         TSpBtnData(Items[i               ]).SpBtn.Left;
    i := FirstBtnIndex - 1;
    While i < LastBtnIndex do begin
      i := i + 1;
      TSpBtnData(Items[i]).SpBtn.Left := TSpBtnData(Items[i]).SpBtn.Left + d;
      TSpBtnData(Items[i]).SpBtn.Visible :=
         (TSpBtnData(Items[i]).SpBtn.Left > 0) and
         (TSpBtnData(Items[i]).SpBtn.Left + TSpBtnData(Items[i]).SpBtn.Width < RightBorder);
      while TSpBtnData(Items[i+1]).SpBtn.Name = TSpBtnData(Items[i]).SpBtn.Name do
        i := i + 1;   // Jump across the Alt-commands !!!
      end;
    ScrollBtn[2*PageNum  ].Enabled := Not TSpBtnData(Items[FirstBtnIndex]).SpBtn.Visible;
    ScrollBtn[2*PageNum+1].Enabled := Not TSpBtnData(Items[LastBtnIndex]).SpBtn.Visible;
    end;
  end;

{ Siehe die Bemerkung vor der vorigen ScrollLeft()-Prozedur !!! }

procedure TSpBtnDataList.ScrollRight(PageNum: Integer);
  var FirstBtnIndex,
      FirstVisBtnIndex,
      LastVisBtnIndex,
      LastBtnIndex,
      d, i : Integer;
  begin
  i := -1;
  Repeat
    i := i + 1;
  until (TSpBtnData(Items[i]).ToolPage = PageNum);
  FirstBtnIndex := i;
  While (i < Count) and
        (TSpBtnData(Items[i]).ToolPage = PageNum) and
        (Not TSpBtnData(Items[i]).SpBtn.Visible) do
    i := i + 1;
  FirstVisBtnIndex := i;
  Repeat
    i := i + 1;
  until (i >= Count) or (TSpBtnData(Items[i]).ToolPage <> PageNum);
  LastBtnIndex := Pred(i);
  While Not TSpBtnData(Items[LastBtnIndex]).SpBtn.Enabled do
    Dec(LastBtnIndex);
  i := LastBtnIndex + 1;
  Repeat
    i := i - 1;
  until TSpBtnData(Items[i]).SpBtn.Visible;
  LastVisBtnIndex := i;
  d := min(RightBorder Div 2,
           TSpBtnData(Items[LastBtnIndex]).SpBtn.Left -
             TSpBtnData(Items[LastVisBtnIndex]).SpBtn.Left);
  i := FirstVisBtnIndex + 1;
  While TSpBtnData(Items[i]).SpBtn.Left -
        TSpBtnData(Items[FirstVisBtnIndex]).SpBtn.Left < d do
    Inc(i);
  If i > FirstVisBtnIndex then begin
    d := TSpBtnData(Items[i               ]).SpBtn.Left -
         TSpBtnData(Items[FirstVisBtnIndex]).SpBtn.Left;
    i := FirstBtnIndex - 1;
    While i < LastBtnIndex do begin
      i := i + 1;
      TSpBtnData(Items[i]).SpBtn.Left := TSpBtnData(Items[i]).SpBtn.Left - d;
      TSpBtnData(Items[i]).SpBtn.Visible :=
         (TSpBtnData(Items[i]).SpBtn.Left > 0) and
         (TSpBtnData(Items[i]).SpBtn.Left + TSpBtnData(Items[i]).SpBtn.Width < RightBorder);
      while TSpBtnData(Items[i+1]).SpBtn.Name = TSpBtnData(Items[i]).SpBtn.Name do
        i := i + 1;   // Jump across the Alt-commands !!!
      end;
    ScrollBtn[2*PageNum  ].Enabled := Not TSpBtnData(Items[FirstBtnIndex]).SpBtn.Visible;
    ScrollBtn[2*PageNum+1].Enabled := Not TSpBtnData(Items[LastBtnIndex]).SpBtn.Visible;
    end;
  end;

destructor TSpBtnDataList.Destroy;
  begin
  While Count > 0 do begin
    TSpBtnData(Items[0]).Free;
    Delete(0);
    end;
  Offset    := Nil;
  ScrollBtn := Nil;
  Inherited Destroy;
  end;

end.
