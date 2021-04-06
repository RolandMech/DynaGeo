unit CommentWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, ComCtrls, GeoTypes, Buttons,
  FormatText, FormatEdit, Utility, LinkWin, Symbols;

type
  TTextWin = class(TForm)
    Panel1: TPanel;
    ComboBox1: TComboBox;
    SpinEdit1: TSpinEdit;
    SB_Fett: TSpeedButton;
    SB_Kursiv: TSpeedButton;
    SB_Unterstrichen: TSpeedButton;
    SB_Tiefgestellt: TSpeedButton;
    SB_Hochgestellt: TSpeedButton;
    FormatEdit1: TFormatEdit;
    BtnLink: TButton;
    BtnSpecial: TButton;
    BtnPara: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_FettClick(Sender: TObject);
    procedure SB_KursivClick(Sender: TObject);
    procedure SB_UnterstrichenClick(Sender: TObject);
    procedure SB_TiefgestelltClick(Sender: TObject);
    procedure SB_HochgestelltClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormatEdit1FontChange(Sender: TObject; Font: TFormatFont);
    procedure FormatEdit1Change(Sender: TObject);
    procedure BtnLinkClick(Sender: TObject);
    procedure BtnSpecialClick(Sender: TObject);
    procedure BtnParaClick(Sender: TObject);
  private
    { Private-Deklarationen }
    updating    : Boolean;
    OldRect     : TRect;
    SpecialWin  : TSymbolWin;
    FExtFuncs   : Boolean;
    function NrOfFontNamed(FaceName: String): Integer;
    procedure SetExtFuncs(nv: Boolean);
    procedure GetFontNames;
  public
    { Public-Deklarationen }
    ActComment : TGComment;
    property ExtendedFuncs: Boolean read FExtFuncs write SetExtFuncs;
  end;


implementation

uses globvars, mainwin;

{$R *.DFM}

function EnumFontProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
                      FontType: Integer; Data: Pointer): Integer; stdcall;
  begin
  If (FontType = TrueType_FontType) and
     (LogFont.lfCharSet <= SYMBOL_CHARSET) then
    TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
  end;

{ Private Methoden }

procedure TTextWin.GetFontNames;
  var DC : HDC;
  begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @EnumFontProc, Pointer(ComboBox1.Items));
  ReleaseDC(0, DC);
  ComboBox1.Sorted := True;
  end;

function TTextWin.NrOfFontNamed(FaceName: String): Integer;
  var i : Integer;
  begin
  i := 0;
  FaceName := UpperCase(FaceName);
  While (i < ComboBox1.Items.Count) and
        (UpperCase(ComboBox1.Items[i]) <> FaceName) do
    Inc(i);
  If i < ComboBox1.Items.Count then
    Result := i
  else
    Result := -1;
  end;

procedure TTextWin.FormatEdit1FontChange(Sender: TObject; Font: TFormatFont);
  begin
  try
    updating := True;
    ComboBox1.ItemIndex   := NrOfFontNamed(Font.Name);
    SpinEdit1.Value       := Font.Size;
    SB_Fett.Down          := fsBold in Font.Style;
    SB_Kursiv.Down        := fsItalic in Font.Style;
    SB_Unterstrichen.Down := fsUnderline in Font.Style;
    SB_Tiefgestellt.Down  := (Font.Position = fpSub);
    SB_Hochgestellt.Down  := (Font.Position = fpSup);
  finally
    updating := False;
  end;
  end;

procedure TTextWin.FormatEdit1Change(Sender: TObject);
  { Diese Routine macht das FormatEdit-Feld effektiv "bottomless".
    Geändert wird nur das umgebende Textfenster. Die Anpassung des
    FormatEdit-Feldes geschieht über einen impliziten Aufruf von
    FormResize aufgrund des OnResize-Ereignisses. }
  var D2B, AFS : Integer;
  begin
  D2B := FormatEdit1.Dist2Bottom;
  AFS := Round(FormatEdit1.ActFont.Size * PixelsPerInch / 72);
  If D2B < 2 * AFS then begin
    Constraints.MaxHeight := 0;
    Height := Height + 2 * AFS - D2B + 10;
    Constraints.MaxHeight := Height;
    Constraints.MinHeight := Height;
    end;
  end;

procedure TTextWin.FormResize(Sender: TObject);
  { Diese Routine implementiert  FormatEdit1.Align = alClient, was leider
    so nicht geht, da FormatEdit gar nicht über dieses Attribut verfügt!  }
  var R         : TRect;
      oldHeight : Integer;
  begin
  Repeat
    oldHeight := Height;
    R.Top    := Succ(Panel1.Height);
    R.Left   := 1;
    R.BottomRight := ClientRect.BottomRight;
    FormatEdit1.BoundsRect := R;
    FormatEdit1Change(Sender);
  until oldHeight = Height;
  end;

procedure TTextWin.SetExtFuncs(nv: Boolean);
  var nmw : Integer;    { "n"ew "m"in "w"idth }
  begin
  If FExtFuncs <> nv then begin
    FExtFuncs := nv;
    BtnLink.Enabled := FExtFuncs;
    BtnLink.Visible := FExtFuncs;
    BtnPara.Enabled := FExtFuncs;
    BtnPara.Visible := FExtFuncs;
    end;
  If ExtendedFuncs then begin
    nmw := BtnLink.Left + BtnLink.Width + 10;
    If width < nmw then
      width := nmw;
    end;
  end;


{ Methoden der visuellen Elemente }

procedure TTextWin.FormCreate(Sender: TObject);
  begin
  GetFontNames;
  updating := False;
  FormatEdit1.DefaultFont := GlobalDefaultFont;  // vorsichtshalber !
  end;

procedure TTextWin.ComboBox1Change(Sender: TObject);
  begin
  If updating then Exit;
  FormatEdit1.SetFontName(ComboBox1.Items[ComboBox1.ItemIndex])
  end;

procedure TTextWin.SpinEdit1Change(Sender: TObject);
  begin
  If updating then Exit;
  FormatEdit1.SetSize(SpinEdit1.Value);
  end;

procedure TTextWin.FormShow(Sender: TObject);
  var xo, yo : Integer;
      cp     : TPoint;
      R      : TRect;
  begin
  FormatEdit1.Clear;
  FormatEdit1.DefaultFont := Hauptfenster.Drawing.StartFont;
  If ActComment <> Nil then begin
    xo := Round(ActComment.WinPos.X) + Hauptfenster.PaintBox1.ClientOrigin.X;
    yo := Round(ActComment.WinPos.Y) + HauptFenster.PaintBox1.ClientOrigin.Y;
    Left := xo;
    While FormatEdit1.ClientOrigin.x > xo do
      Left := Left - 1;
    Top  := yo;
    While FormatEdit1.ClientOrigin.y > yo do
      Top  := Top  - 1;
    If Left < 10 then Left :=  10;
    If Top  <  5 then Top  :=   5;
    Constraints.MinHeight  := 180;
    Constraints.MaxHeight  :=   0;
    If ExtendedFuncs then
      Constraints.MinWidth := 365
    else
      Constraints.MinWidth := 265;
    FormatEdit1.HTMLTextAsString := ActComment.HTMLText;
    R := ActComment.GetRenderWin;
    Width  := R.Right - R.Left + 2 * BorderWidth;
    Height := R.Bottom - R.Top + Panel1.Height;
    If FormatEdit1.LineCount > 0 then begin
      cp.Y := Pred(FormatEdit1.LineCount);
      cp.X := FormatEdit1.LineLength(cp.Y)
      end
    else
      cp := Point(0, 0);
    FormatEdit1.ActCursorPos := cp;
    end
  else begin  { Immer in Minimalgröße in der Paintbox zentrieren ! }
    If ExtendedFuncs then
      Constraints.MinWidth := 365
    else
      Constraints.MinWidth := 265;
    Width := Self.Constraints.MinWidth;
    Height := Self.Constraints.MinHeight;
    With Hauptfenster.PaintBox1 do
      cp := ClientToScreen(Point((ClientWidth  - Self.Width ) Div 2,
                                 (ClientHeight - Self.Height) Div 2));
    Left := cp.X;
    Top  := cp.Y;
    If ExtendedFuncs then
      FormatEdit1.HTMLTextAsString := MyMess[118]
    else
      FormatEdit1.HTMLTextAsString := '';
    FormatEdit1FontChange(Self, FormatEdit1.ActFont);
    end;
  FormatEdit1.SetFocus;
  OldRect := BoundsRect;
  end;

procedure TTextWin.FormClose(Sender: TObject; var Action: TCloseAction);
  var NewOri : TPoint;
      err    : Integer;
  begin
  if assigned(SpecialWin) then
    SpecialWin.Release;
  If Visible then
    try
      Screen.Cursor := crHourGlass;
      Action   := caHide;
      If Assigned(SpecialWin) then begin
        SpecialWin.Close;
        FreeAndNil(SpecialWin);
        end;
      If (BoundsRect.Top = OldRect.Top) and
         (BoundsRect.Left = OldRect.Left) and
         (ActComment <> Nil) then
        NewOri := ActComment.WinPos
      else begin
        NewOri   := HauptFenster.PaintBox1.ScreenToClient(ClientOrigin);
        NewOri.Y := NewOri.Y + Panel1.Height;
        end;
      If Not PtInRect(HauptFenster.PaintBox1.ClientRect, NewOri) then
        NewOri := Point(20, 20);
      If Not FormatEdit1.IsEmpty then begin
        If ActComment = Nil then with Hauptfenster do begin
          ActComment := TGComment.Create(Drawing, clBlack, NewOri);
          Drawing.InsertObject(ActComment, err);
          end;
        With ActComment do begin
          ComboBox1.SetFocus;
          With OutRect do begin
            right   := left + FormatEdit1.GetTextExtent.X + 3;
            bottom  := top  + FormatEdit1.GetTextExtent.Y + 3;
            end;
          GetDataFrom(FormatEdit1);
          SetNewAbsolutePos(NewOri);
          ObjList.IsDirty := True;
          end;
        end
      else
        ActComment := Nil;
    finally
      Screen.Cursor := crDefault;
    end
  else
    Action := caFree;
  end;

procedure TTextWin.SB_FettClick(Sender: TObject);
  begin
  FormatEdit1.SetBold(SB_Fett.Down);
  end;

procedure TTextWin.SB_KursivClick(Sender: TObject);
  begin
  FormatEdit1.SetItalic(SB_Kursiv.Down);
  end;

procedure TTextWin.SB_UnterstrichenClick(Sender: TObject);
  begin
  FormatEdit1.SetUnderline(SB_Unterstrichen.Down);
  end;

procedure TTextWin.SB_TiefgestelltClick(Sender: TObject);
  begin
  FormatEdit1.SetSub(SB_Tiefgestellt.Down);
  end;

procedure TTextWin.SB_HochgestelltClick(Sender: TObject);
  begin
  FormatEdit1.SetSup(SB_Hochgestellt.Down);
  end;


procedure TTextWin.BtnLinkClick(Sender: TObject);
  { Halbfertiges Link-Interface für HTML-Texte }
  var LinkDlg: TEditLinkDlg;
      s      : String;
  begin
  LinkDlg := TEditLinkDlg.CreateWithTargetEdit(Self, FormatEdit1,
                                               HauptFenster.ActGeoFileName);
  try
    s := FormatEdit1.GetHTMLLinkAt(FormatEdit1.ActCursorPos);
    If Length(s) > 0 then begin
      LinkDlg.Edit1.Text := HTMLKillAllTags(s);
      LinkDlg.Edit2.Text := HTMLExtractAttrValue('href', s);
      end
    else begin
      LinkDlg.Edit1.Text := '';
      LinkDlg.Edit2.Text := '';
      end;
    If LinkDlg.ShowModal = mrOK then
      FormatEdit1.InsertHTMLLinkAt(FormatEdit1.ActCursorPos,
                                   LinkDlg.Edit1.Text,
                                   LinkDlg.Edit2.Text)
    else
      FormatEdit1.SetFocus;
  finally
    LinkDlg.Release;
  end;
  end;

procedure TTextWin.BtnSpecialClick(Sender: TObject);
  begin
  If Not Assigned(SpecialWin) then
    SpecialWin := TSymbolWin.CreateWD(Self, FormatEdit1,
                                      Point(Left, Top - 40), 4);
  SpecialWin.Show;
  end;

procedure TTextWin.BtnParaClick(Sender: TObject);
  begin
  FormatEdit1.InsertHTMLTextAt(FormatEdit1.ActCursorPos, '<hr>');
  FormatEdit1.SetFocus;
  end;

end.
