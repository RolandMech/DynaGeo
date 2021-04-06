unit CommentWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, ComCtrls, GeoTypes, Buttons,
  FormatText, FormatEdit;

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
  private
    { Private-Deklarationen }
    updating : Boolean;
    OldRect  : TRect;
    ObjList  : TGeoObjListe;
    PaintWin : TPaintBox;
    Spot     : TPoint;
    FExtFuncs: Boolean;
    function NrOfFontNamed(FaceName: String): Integer;
    procedure GetFontNames;
    procedure SetExtFuncs(newVal: Boolean);
  public
    { Public-Deklarationen }
    ActComment : TGComment;
    constructor CreateWithData(iPaintBox: TPaintBox;
                               iObjList: TGeoObjListe;
                               iActComment: TGComment;
                               iSpot: TPoint);
    property ExtendedFuncs: Boolean read FExtFuncs write SetExtFuncs;
  end;


implementation

uses globvars;

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

procedure TTextWin.SetExtFuncs(newVal: Boolean);
  begin
  FExtFuncs := False;
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


{ Methoden der visuellen Elemente }

constructor TTextWin.CreateWithData(iPaintBox: TPaintBox;
                                    iObjList: TGeoObjListe;
                                    iActComment: TGComment;
                                    iSpot: TPoint);
  begin
  Inherited Create(iPaintBox);
  ActComment := iActComment;
  ObjList    := iObjList;
  PaintWin   := iPaintBox;
  Spot       := iSpot;
  FExtFuncs  := False;
  FormatEdit1.DefaultFont := ObjList.StartFont;
  end;

procedure TTextWin.FormCreate(Sender: TObject);
  begin
  GetFontNames;
  updating  := False;
  FExtFuncs := False;
  FormatEdit1.DefaultFont := GlobalDefaultFont;
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
  xo := Round(Spot.X) + PaintWin.ClientOrigin.X;
  yo := Round(Spot.Y) + PaintWin.ClientOrigin.Y;
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
  Constraints.MinWidth   := 265;
  If Assigned(ObjList) then
    FormatEdit1.DefaultFont := ObjList.StartFont;
  If ActComment <> Nil then begin
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
  else begin
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
  If Visible then
    try
      Screen.Cursor := crHourGlass;
      Action   := caHide;
      If (BoundsRect.Top = OldRect.Top) and
         (BoundsRect.Left = OldRect.Left) and
         (ActComment <> Nil) then
        NewOri := ActComment.WinPos
      else begin
        NewOri   := PaintWin.ScreenToClient(ClientOrigin);
        NewOri.Y := NewOri.Y + Panel1.Height;
        end;
      If Not PtInRect(PaintWin.ClientRect, NewOri) then
        NewOri := Point(20, 20);
      If Not FormatEdit1.IsEmpty then begin
        If ActComment = Nil then begin
          ActComment := TGComment.Create(ObjList, clBlack, NewOri);
          ObjList.InsertObject(ActComment, err);
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
        ActComment := Nil;     // signalisiert dem Hauptfenster, dass
    finally                    // die Textbox leer ist ==> Löschen !!
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


end.
