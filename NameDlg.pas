unit NameDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Spin,
  GeoTypes, GeoConic, MathLib, Buttons, FormatText, FormatEdit,
  Symbols;

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
    Btn_SpecialChars: TButton;
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
    procedure Btn_SpecialCharsClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private-Deklarationen }
    updating   : Boolean;
    ActualFont : TFormatFont;
    SpecialWin : TSymbolWin;
    function  NrOfFontNamed(FaceName: String): Integer;
    procedure GetFontNames;
  public
    { Public-Deklarationen }
    ActObj   : TGeoObj;
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

{ ------------- Life-Cycle -------------------------------}

procedure TObjNameDlg.FormCreate(Sender: TObject);
  begin
  GetFontNames;
  ActObj     := Nil;
  updating   := False;
  ActualFont := TFormatFont.Create(GlobalDefaultFont);
  end;

procedure TObjNameDlg.FormShow(Sender: TObject);
  begin
  FormatEdit1.Clear;
  FormatEdit1.DefaultFont := ActObj.ObjList.StartFont;
  If ActObj <> Nil then begin
    FormatEdit1.HTMLTextAsString := ActObj.GetFormattedName;
    FormatEdit1.SelectActualLine;
    FormatEdit1.SetFocus;
    Btn_SpecialChars.Enabled := ActObj is TGAngle;
    end;
  end;

procedure TObjNameDlg.FormHide(Sender: TObject);
  begin
  FreeAndNil(SpecialWin);
  end;

procedure TObjNameDlg.FormDestroy(Sender: TObject);
  begin
  if assigned(SpecialWin) then
    SpecialWin.Release;
  ActualFont.Free;
  end;

{----------- Interactions ------------------------}

procedure TObjNameDlg.CancelBtnClick(Sender: TObject);
  begin
  Close;
  end;

procedure TObjNameDlg.OkBtnClick(Sender: TObject);
  var NewName : WideString;
      Sel     : TSelection;

  function AllCharsAllowed(s : WideString) : Boolean;
    var ACA : Boolean;
        i   : Integer;
    begin
    s := HTMLKillAllTags(s);
    If Length(s) > 0 then
      If s[1] <> '_' then begin
        ACA := True;
        i := 1;
        While ACA and (i <= Length(s)) do
          If IsNameChar(s[i]) then
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

  function NotUsedYet(s : WideString) : Boolean;
    { 15.12.99:  Schleife läuft nun über *alle* Objekte in der Drawing-
                 Liste, damit auch kein Namenskonflikt mit einem gelöschten,
      aber noch reaktivierbaren Objekt auftreten kann.
      Außerdem gibt's eine Sonderbehandlung für Winkel : alpha <> a, obwohl
      kein Unterschied in ASCII, sondern nur im Font!
      11.08.08:  Umstellung auf UCS-2-Darstellung von Namen, damit alpha und
                 a in Zukunft verschieden kodiert werden und ohne Rückgriff
      auf den Font unterscheidbar sind. Damit vereinfacht sich der Namens-
      vergleich ziemlich. }
    var NUY     : Boolean;
        i       : Integer;
        err_str : String;

    begin
    NUY := True;
    i   := 0;
    While NUY and (i < ActObj.ObjList.Count) do
      If (TGeoObj(ActObj.ObjList[i]) <> ActObj) and
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
  NewName := HTMLString2WideString(FormatEdit1.HTMLTextAsString);
  If AllCharsAllowed(NewName) and
     NotUsedYet(NewName) then begin
    ActObj.SetNewName(NewName); { Spätestens hier wird ein Namenobjekt erzeugt }
    If ActObj is TGNumber then
      TGNumber(ActObj).ShowName := True
    else begin
      ActObj.ShowNameInNameObj := True;
      With TGName(ActObj.Children.List[0]) do begin
        HideDisplay;
        With OutRect do begin                { 13.04.06 : Dimensionierung muss }
          Right := Left +  NameRenderWin.X;  { unbedingt *vor* dem Aufruf von  }
          Bottom := Top + NameRenderWin.Y;   { GetDataFrom() passieren !       }
          end;
        GetDataFrom(FormatEdit1);  { Datenübernahme ins Namen-Objekt }
        Redraw;
        end;
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

procedure TObjNameDlg.Btn_SpecialCharsClick(Sender: TObject);
  begin
  If Not Assigned(SpecialWin) then
    SpecialWin := TSymbolWin.CreateWD(Self, FormatEdit1, Point(Left, Top), 2);
  SpecialWin.Show;
  end;

initialization

end.
