unit NameDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Spin,
  GeoTypes, GeoConic, MathLib, Buttons, FormatText, FormatEdit;

type
  TObjNameDlg = class(TForm)
    Panel1: TPanel;
    ComboBox1: TComboBox;
    SpinEdit1: TSpinEdit;
    NewName: TLabel;
    SB_Fett: TSpeedButton;
    SB_Kursiv: TSpeedButton;
    SB_Unterstrichen: TSpeedButton;
    SB_Hochgestellt: TSpeedButton;
    SB_Tiefgestellt: TSpeedButton;
    Panel2: TPanel;
    CancelBtn: TButton;
    OkBtn: TButton;
    CBShowName: TCheckBox;
    FormatEdit1: TFormatEdit;
    procedure FormShow(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SB_FettClick(Sender: TObject);
    procedure SB_HochgestelltClick(Sender: TObject);
    procedure SB_KursivClick(Sender: TObject);
    procedure SB_TiefgestelltClick(Sender: TObject);
    procedure SB_UnterstrichenClick(Sender: TObject);
    procedure FormatEdit1FontChange(Sender: TObject; newFont: TFormatFont);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
    updating   : Boolean;
    ActualFont : TFormatFont;
    function  NrOfFontNamed(FaceName: String): Integer;
    procedure GetFontNames;
  public
    { Public-Deklarationen }
    ActObj   : TGeoObj;
    procedure SetPosCenteredTo(newPos: TPoint);
    procedure DisableAttributes;
  end;

implementation

{$R *.DFM}

Uses GlobVars, Utility;


{ ============= Hilfen fürs Font-Management ==================== }

function HTMLName(PlainName: String; UseFont: TFormatFont): String;
  var v, h : String;
  begin
  v := '<font name="' + UseFont.Name +
       '" size="' + IntToStr(UseFont.Size) + '">';
  h := '</font>';
  If fsBold in UseFont.Style then begin
    v := v + '<b>';
    h := '</b>' + h;
    end;
  If fsItalic in UseFont.Style then begin
    v := v + '<i>';
    h := '</i>' + h;
    end;
  If fsUnderline in UseFont.Style then begin
    v := v + '<u>';
    h := '</u>' + h;
    end;
  Result := v + PlainName + h;
  end;


function EnumFontProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
                      FontType: Integer; Data: Pointer): Integer; stdcall;
  begin
  If (FontType = TrueType_FontType) and
     (LogFont.lfCharSet <= SYMBOL_CHARSET) then
    TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
  end;

function HTMLKillBlanks(source: String): String;
  var e, i : Integer;
  begin
  e := 0;
  For i := Length(source) downto 1 do  // Leerzeichen löschen
    Case source[i] of
      '<' : e := e - 1;
      '>' : e := e + 1;
      ' ' : If e = 0 then Delete(source, i, 1);
    end;
  Result := HTMLKillEmptyTags(source);
  end;

procedure TObjNameDlg.GetFontNames;
  var DC : HDC;
  begin
  DC := GetDC(0);
  EnumFontFamilies(DC, nil, @EnumFontProc, Integer(ComboBox1.Items));
  ReleaseDC(0, DC);
  ComboBox1.Sorted := True;
  end;

function TObjNameDlg.NrOfFontNamed(FaceName: String): Integer;
  var i : Integer;
  begin
  i := 0;
  While (i < ComboBox1.Items.Count) and
        (UpperCase(ComboBox1.Items[i]) <> UpperCase(FaceName)) do
    Inc(i);
  If i < ComboBox1.Items.Count then
    Result := i
  else
    Result := -1;
  end;

{ ============= Objektnamen-Dialog ====================== }

procedure TObjNameDlg.FormCreate(Sender: TObject);
  begin
  GetFontNames;
  ActObj     := Nil;
  ActualFont := TFormatFont.Create();
  updating   := False;
  NameRenderWin.X := FormatEdit1.ClientWidth;
  NameRenderWin.Y := FormatEdit1.ClientHeight;
  end;

procedure TObjNameDlg.SetPosCenteredTo(newPos: TPoint);
  var nLeft, nTop: Integer;
  begin
  Position := poDesigned;
  nLeft := newPos.X - Width Div 2;
  nTop  := newPos.Y - Height Div 2;
  MoveWinIntoDesktop(width, height, nLeft, nTop);
  Left := nLeft;
  Top  := nTop;
  end;

procedure TObjNameDlg.DisableAttributes;
  begin
  SB_Fett.Enabled := False;
  SB_Kursiv.Enabled := False;
  SB_Unterstrichen.Enabled := False;
  SB_Tiefgestellt.Enabled := False;
  SB_Hochgestellt.Enabled := False;
  SB_Fett.Visible := False;
  SB_Kursiv.Visible := False;
  SB_Unterstrichen.Visible := False;
  SB_Tiefgestellt.Visible := False;
  SB_Hochgestellt.Visible := False;
  end;

procedure TObjNameDlg.FormShow(Sender: TObject);
  var NO  : TGName;
      FoFo: TFormatFont;
      NOExists : Boolean;
      n   : Integer;
  begin
  FormatEdit1.Clear;
  FormatEdit1.DefaultFont := ActObj.ObjList.StartFont;
  If ActObj <> Nil then begin
    NOExists := ActObj.HasNameObj(NO) and (Length(NO.HTMLText) > 0);
    If NOExists then begin
      FormatEdit1.HTMLTextAsString := HTMLKillBlanks(NO.HTMLText);
      FoFo := FormatEdit1.GetCharFont(Point(0,0));
      If FoFo <> Nil then begin
        ActualFont.Assign(FoFo);
        With FormatEdit1.DefaultFont do begin
          Name := FoFo.Name;
          Size := FoFo.Size;
          end;
        end
      else begin                    // sollte nicht passieren !
        ActualFont.Assign(ActObj.ObjList.StartFont);
        if ActObj is TGAngle then
          ActualFont.Name := 'Symbol';
        end;
      FormatEdit1.ActCursorPos := Point(0, 0);
      FormatEdit1FontChange(Self, ActualFont);
      n := FormatEdit1.LineLength(0);
      If n > 1 then
        FormatEdit1.ActCursorPos := Point(n-1, 0)
      else
        FormatEdit1.SelectActualLine;
      end
    else begin
      ActualFont.Assign(ActObj.ObjList.StartFont);
      if ActObj is TGAngle then
        ActualFont.Name := 'Symbol';
      FormatEdit1.Paste(HTMLName(ActObj.Name, ActualFont));
      FormatEdit1FontChange(Self, ActualFont);
      FormatEdit1.SelectActualLine;
      FormatEdit1.SetFont(ActualFont);
      end;
    If ActObj is TGNumber then
      CBShowName.Checked := TGNumberObj(ActObj).ShowName;
    FormatEdit1.SetFocus;
    end;
  end;

procedure TObjNameDlg.CancelBtnClick(Sender: TObject);
  begin
  Close;
  end;

procedure TObjNameDlg.OkBtnClick(Sender: TObject);
  var NewName : String;
      Sel     : TSelection;

  function AllCharsAllowed(s : String) : Boolean;
    var ACA : Boolean;
        i   : Integer;
    begin
    If Length(s) > 0 then
      If s[1] <> '_' then begin
        ACA := True;
        i := 1;
        While ACA and (i <= Length(s)) do
          If CharInSet(s[i], NameChar) then
            Inc(i)
          else begin
            // Falsches Zeichen selektieren !!!
            Sel.Start := Point(Pred(i), 0);
            Sel.Ende  := Point(i, 0);
            FormatEdit1.ActSelection := Sel;
            MessageDlg(MyMess[66], mtError, [mbOk], 0);
            ACA := False;
            end;
        end
      else begin
        // Erstes Zeichen selektieren !!!
        Sel.Start := Point(0, 0);
        Sel.Ende  := Point(1, 0);
        FormatEdit1.ActSelection := Sel;
        MessageDlg(MyMess[66], mtError, [mbOk], 0);
        ACA := False;
        end
    else begin
      MessageDlg(MyMess[89], mtError, [mbOk], 0);
      ACA := False;
      end;
    AllCharsAllowed := ACA;
    end;

  function NotUsedYet(s : String) : Boolean;
    { geändert 15.12.99:
      Schleife läuft nun über *alle* Objekte in der Drawing-Liste,
      damit auch kein Namenskonflikt mit einem gelöschten, aber noch
      reaktivierbaren Objekt auftreten kann.
      Außerdem gibt's eine Sonderbehandlung für Winkel : alpha <> a,
      obwohl kein Unterschied in ASCII, sondern nur im Font ! }
    var NUY     : Boolean;
        i       : Integer;
        err_str : String;
    function IsExpectedType(GO: TGeoObj): Boolean;
      begin
      If ActObj is TGAngle then
        Result := GO is TGAngle
      else
        Result := Not (GO is TGAngle);
      end;

    begin
    NUY := True;
    i   := 0;
    While NUY and (i < ActObj.ObjList.Count) do
      If (TGeoObj(ActObj.ObjList[i]) <> ActObj) and
         IsExpectedType(ActObj.ObjList[i]) and
         (TGeoObj(ActObj.ObjList[i]).Name = s) then begin
        //  Ganzen Namen selektieren !!!
        Sel.Start := Point( 0, 0);
        Sel.Ende  := Point(-1, 0);
        FormatEdit1.ActSelection := Sel;
        If i <= ActObj.ObjList.LastValidObjIndex then
          err_str := MyMess[67]
        else
          err_str := MyMess[67] + MyMess[88];
        MessageDlg(err_str, mtError, [mbOk], 0);
        NUY := False;
        end
      else
        Inc(i);
    NotUsedYet := NUY;
    end;

  begin
  NewName := FormatEdit1.PlainText[0];
  If AllCharsAllowed(NewName) and
     NotUsedYet(NewName) then begin
    ActObj.SetNewName(NewName); { Spätestens hier wird ein Namenobjekt erzeugt }
    If ActObj is TGNumber then
      TGNumber(ActObj).ShowName := CBShowName.Checked
    else
      With TGName(ActObj.Children.List[0]) do begin
        HideDisplay;
        With OutRect do begin                { 13.04.06 : Dimensionierung muss }
          Right := Left +  NameRenderWin.X;  { unbedingt *vor* dem Aufruf von  }
          Bottom := Top + NameRenderWin.Y;   { GetDataFrom() passieren !       }
          end;
        GetDataFrom(FormatEdit1);  { Datenübernahme ins Namen-Objekt }
        ShowsAlways := CBShowName.Checked;
        Redraw;
        end;
    ActObj.ObjList.IsDirty := True;    
    Close;
    end;
  end;

procedure TObjNameDlg.ComboBox1Change(Sender: TObject);
  begin
  If updating then Exit;
  FormatEdit1.SetFontName(ComboBox1.Items[ComboBox1.ItemIndex]);
  end;

procedure TObjNameDlg.SpinEdit1Change(Sender: TObject);
  begin
  If updating then Exit;
  FormatEdit1.SetSize(SpinEdit1.Value);
  end;

procedure TObjNameDlg.SB_FettClick(Sender: TObject);
  begin
  FormatEdit1.SetBold(SB_Fett.Down);
  end;

procedure TObjNameDlg.SB_KursivClick(Sender: TObject);
  begin
  FormatEdit1.SetItalic(SB_Kursiv.Down);
  end;

procedure TObjNameDlg.SB_UnterstrichenClick(Sender: TObject);
  begin
  FormatEdit1.SetUnderline(SB_Unterstrichen.Down);
  end;

procedure TObjNameDlg.SB_HochgestelltClick(Sender: TObject);
  begin
  FormatEdit1.SetSup(SB_Hochgestellt.Down);
  end;

procedure TObjNameDlg.SB_TiefgestelltClick(Sender: TObject);
  begin
  FormatEdit1.SetSub(SB_Tiefgestellt.Down);
  end;


procedure TObjNameDlg.FormatEdit1FontChange(Sender: TObject; newFont: TFormatFont);
  begin
  try
    updating := True;
    ComboBox1.ItemIndex   := NrOfFontNamed(newFont.Name);
    SpinEdit1.Value       := newFont.Size;
    SB_Fett.Down          := fsBold in newFont.Style;
    SB_Kursiv.Down        := fsItalic in newFont.Style;
    SB_Unterstrichen.Down := fsUnderline in newFont.Style;
    SB_Tiefgestellt.Down  := (newFont.Position = fpSub);
    SB_Hochgestellt.Down  := (newFont.Position = fpSup);
  finally
    updating := False;
  end;
  end;

procedure TObjNameDlg.FormDestroy(Sender: TObject);
  begin
  ActualFont.Free;
  end;

initialization

end.
