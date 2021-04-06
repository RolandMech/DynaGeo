unit IniFDlg;

interface

{$IFDEF NO_PLATFORMWARNINGS}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
{$ENDIF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles, ComCtrls, Menus,
  MathLib, GeoTypes, Utility, GlobVars, MenuCfgNew, Spin;

Type
  TMyIniFile = class(TObject)

               protected
                 FUp2date: Boolean;
                 function ReadFirstUseDate: Integer;
                 function CanWriteTo(IniF: TIniFile): Boolean;
                 procedure DeleteLicDataDoubles;

               public
                 GlobalIF,
                 PrivatIF: TIniFile;

                 constructor Create(GlobalIniPath: String);
                 destructor Destroy; override;

                 function LoadLicenceDataFromDGLFile: Boolean;
                 function LoadLicenceDataFromINIFile: Boolean;
                 function CopyLicenceDataFile(sourcePath: String): Boolean;
                 function LoadLicenceStrings(var s1, s2, s3 : String): Boolean;

                 function IsOlderThanExe: Boolean;
                 function IsUpTodate: Boolean;
                 function TimeCheck: Integer;
                 function SaveRunTime: Integer;

                 function SavePresetMenuConfigs: Boolean;
                 function LoadMenuConfigKeys (    privat   : Boolean;
                                                  SL       : TStrings): Boolean;
                 function LoadMenuConfigNames(    SL       : TStrings;
                                              var Selected : Integer ): Boolean;
                 function LoadMenuConfigName (key : String) : String;
                 function SaveMenuConfigName (key, cfgName: String;
                                              privat: Boolean = True): Boolean;
                 function LoadMenuConfigData (key : String) : String;
                 function SaveMenuConfigData (key, cfgData: String;
                                              privat: Boolean = True): Boolean;
                 function LoadStandardMenuIndex: Integer;
                 function SaveStandardMenuIndex(num: Integer): Boolean;

                 function ShiftToGlobalMenuList(srcKey: String): Boolean;
                 function ShiftToPrivatMenuList(srcKey: String): Boolean;
                 function GetNewKeyStr(privat: Boolean): String;
                 function KillMenuConfig   (key : String) : Boolean;

                 function SaveSetupDefaults     : Boolean;
                 function SaveLangInfo          : Boolean;
                 function SaveVersion           : Boolean;

                 function LoadNetOptions: Boolean;
                 function SaveNetOptions: Boolean;
                 function LoadOptions(Section: String): Boolean;
                 function SaveOptions(Section: String): Boolean;
                 function LoadUserCols: Boolean;
                 function SaveUserCols: Boolean;
                 function LoadLRUList(sl: TLRUList): Boolean;
                 function SaveLRUList(sl: TLRUList): Boolean;
               end;

  TOptionsDlg = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    Label5: TLabel;
    Label6: TLabel;
    BtnCancel: TButton;
    BtnOkay: TButton;
    TabSheet1: TTabSheet;
    RGStartWindow: TRadioGroup;
    RGNewCoordSys: TRadioGroup;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    CB_AngleOrient: TCheckBox;
    TabSheet5: TTabSheet;
    EMouseC: TEdit;
    EZoomF: TEdit;
    TabSheet4: TTabSheet;
    OptionsMenu: TMainMenu;
    StandardEinstellungenwiederladen1: TMenuItem;
    LetzteUserEinstellungenwiederladen1: TMenuItem;
    AktuelleUserEinstellungenspeichern1: TMenuItem;
    CfgDatei: TMenuItem;
    CB_AutoNameCol: TCheckBox;
    TabSheet6: TTabSheet;
    CB_NoNamesInConstrText: TCheckBox;
    TabSheet7: TTabSheet;
    EAngleAcc: TEdit;
    Label4: TLabel;
    Label9: TLabel;
    EDistAcc: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ELRUCount: TEdit;
    Panel2: TPanel;
    CfgList: TComboBox;
    BtnNewMenuCfg: TButton;
    BtnEditMenuCfg: TButton;
    BtnDelMenuCfg: TButton;
    CB_PolygonAutoFill: TCheckBox;
    TabSheet8: TTabSheet;
    GroupBox1: TGroupBox;
    CB_AutoTraceMirrorAxis: TCheckBox;
    CB_AutoTraceMirrorCentre: TCheckBox;
    CB_AutoTraceMove: TCheckBox;
    CB_AutoTraceRotate: TCheckBox;
    CB_AutoTraceStretch: TCheckBox;
    TabSheet9: TTabSheet;
    GroupBox2: TGroupBox;
    CB_BezierOLines: TCheckBox;
    CB_DynaOLines: TCheckBox;
    Label8: TLabel;
    EOLDist: TEdit;
    LizenzDatenAktualisieren1: TMenuItem;
    CB_StandardOLines: TCheckBox;
    BtnExpertOpts: TButton;
    N1: TMenuItem;
    NetzwerkOptionen1: TMenuItem;
    AlsStandardspeichern1: TMenuItem;
    GB_PointDefaults: TGroupBox;
    Label15: TLabel;
    BB_BasePointDefStyle: TBitBtn;
    SE_PointSize: TSpinEdit;
    Label7: TLabel;
    Label16: TLabel;
    BB_ConstrPointDefStyle: TBitBtn;
    GB_LineDefaults: TGroupBox;
    BB_NormalLineDefStyle: TBitBtn;
    BB_LocLineDefStyle: TBitBtn;
    Label17: TLabel;
    Label18: TLabel;
    PointStyleMenu: TPopupMenu;
    GefllterKreis1: TMenuItem;
    GeflltesQuadrat1: TMenuItem;
    HohlerKreis1: TMenuItem;
    HohlesQuadrat1: TMenuItem;
    Kreuzaufrecht1: TMenuItem;
    Kreuzdiagonal1: TMenuItem;
    LineStyleMenu: TPopupMenu;
    dnn1: TMenuItem;
    dick1: TMenuItem;
    fett1: TMenuItem;
    gestrichelt1: TMenuItem;
    punktiert1: TMenuItem;
    strichpunktiert1: TMenuItem;
    LocLineStyleMenu: TPopupMenu;
    dnneLinie1: TMenuItem;
    dickeLinie1: TMenuItem;
    PunkteSerie1: TMenuItem;
    PunktSeriedick1: TMenuItem;
    HohlerKreisdnn1: TMenuItem;
    HilesQuadratdnn1: TMenuItem;
    Kreuzaufrechtdnn1: TMenuItem;
    Kreuzdiagonaldnn1: TMenuItem;
    CB_FatCursors: TCheckBox;
    BB_CoordPointDefStyle: TBitBtn;
    Label19: TLabel;
    RG_LineEquationStyle: TRadioGroup;
    CB_ShowSim: TCheckBox;
    CB_AllAreasSigned: TCheckBox;
    GB_Accuracy: TGroupBox;
    Label3: TLabel;
    SpELengthDecimals: TSpinEdit;
    Label14: TLabel;
    SpEAngleDecimals: TSpinEdit;
    Label21: TLabel;
    SpEAreaDecimals: TSpinEdit;
    GB_Units: TGroupBox;
    Label20: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    ELengthUnit: TEdit;
    EAngleUnit: TEdit;
    EAreaUnit: TEdit;
    CB_ExtPointCmd: TCheckBox;
    CB_RightAnglePt: TCheckBox;
    CB_FrameMeasures: TCheckBox;
    CB_FillAngleSector: TCheckBox;
    RG_XMLFormat: TRadioGroup;
    GroupBox3: TGroupBox;
    CB_InternalLS_Prn: TCheckBox;
    CB_InternalCS_Prn: TCheckBox;
    CB_HatchedFill_Prn: TCheckBox;
    CB_UserDefBrush_Prn: TCheckBox;
    GroupBox4: TGroupBox;
    CB_InternalLS_Clipboard: TCheckBox;
    CB_InternalCS_Clipboard: TCheckBox;
    Ed_ScaleX_Clpbrd: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Ed_Aspect_Clpbrd: TEdit;
    GroupBox5: TGroupBox;
    Label24: TLabel;
    CB_BMP_Res: TComboBox;
    Label25: TLabel;
    SpEMaxRieCnt: TSpinEdit;
    Label26: TLabel;
    CosysColBox: TColorBox;
    Label27: TLabel;
    GroupBox6: TGroupBox;
    CB_DefaultFontFace: TComboBox;
    Label28: TLabel;
    SE_DefaultFontSize: TSpinEdit;
    Label29: TLabel;
    Label30: TLabel;
    PreviewPanel: TPanel;
    GroupBox7: TGroupBox;
    CB_DynaEnvLines: TCheckBox;
    CB_EnvShowCurve: TCheckBox;
    CB_EnvShowLines: TCheckBox;
    procedure OkayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LoadStandardClick(Sender: TObject);
    procedure LoadUserClick(Sender: TObject);
    procedure SaveUserClick(Sender: TObject);
    procedure CfgListChange(Sender: TObject);
    procedure NewMenuCfgClick(Sender: TObject);
    procedure EditMenuCfgClick(Sender: TObject);
    procedure DelMenuCfgClick(Sender: TObject);
    procedure LizenzDatenAktualisieren1Click(Sender: TObject);
    procedure BtnExpertOptsClick(Sender: TObject);
    procedure NetzwerkOptionen1Click(Sender: TObject);
    procedure AlsStandardspeichern1Click(
      Sender: TObject);
    procedure BB_BasePointDefStyleClick(Sender: TObject);
    procedure PointStyleClick(Sender: TObject);
    procedure BB_ConstrPointDefStyleClick(Sender: TObject);
    procedure LineStyleMenuClick(Sender: TObject);
    procedure BB_NormalLineDefStyleClick(Sender: TObject);
    procedure LineStyleMenu_MeasureItem(Sender: TObject; ACanvas: TCanvas; var Width,
      Height: Integer);
    procedure LineStyleMenu_DrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
    procedure LocLineStyleMenuClick(Sender: TObject);
    procedure LocLineStyleMenu_DrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
    procedure BB_LocLineDefStyleClick(Sender: TObject);
    procedure CB_BezierOLinesClick(Sender: TObject);
    procedure BB_CoordPointDefStyleClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure DefaultFontChange(Sender: TObject);
  private
    { Private-Deklarationen }
    PointStyleEditor         : TBitBtn;
    Local_DefBasePointStyle,
    Local_DefCoordPointStyle,
    Local_DefConstrPointStyle,
    Local_DefNormalLineStyle,
    Local_DefLocLineStyle    : Integer;
    procedure ShowCurrentValues;
    procedure SetNewValues;
    procedure DisableCommandsIn(key: String);
  public
    { Public-Deklarationen }
    procedure RealizeActualMenuCfg(AtOnce: Boolean = False);
  end;


implementation

{$R *.DFM}

Uses FileIO, FileCtrl, ImgList, Math,
     Declar, ascrypt, GeoMakro, MainWin, ExpertOptWin, NetOptDlg;


var StartTime         : TDateTime;
    FirstMenuCfg2Edit : Integer;


{ ========= Hilfsfunktionen ============= }

function TextFramedBy2Blanks(s : String): String;
  begin
  While (Length(s) > 0) and (s[Length(s)] = ' ') do Delete(s, Length(s), 1);
  While (Length(s) > 0) and (s[1] = ' ') do Delete(s, 1, 1);
  Result := ' ' + s + ' ';
  end;

function GetLicenceNumber: LongInt;
  var NNr  : LongInt;
      code : Integer;
      pu   : String;

  procedure CountChars;
    var k, i : Integer;
        pz   : Array [0..3] of Integer;
        ps   : String;
    begin
    for k := Length(pu) DownTo 1 do
      If (pu[k] <= #32) or (pu[k] >= #127) then
        Delete(pu, k, 1)                { Alle Leer- und Sonderzeichen raus...  }
      else
        pu[k] := UpCase(pu[k]);         { ...alles in Großbuchstaben umwandeln! }

    for i := 0 to 3 do { Hier könnte der Algorithmus je nach Bedarf verschieden }
      pz[i] := 0;      { initialisiert werden.  Achtung !! Auf Synchronisation  }
    i := 0;            { mit externer Lizenznummern-Berechnung achten !         }

    for k := 1 to Length(pu) do begin
      pz [i] := (pz [i] + Byte(pu[k])) Mod 100;   { einfache Prüfsumme }
      i      :=  pz [i] Mod 4;
      end;
    pu := '';
    for k := 0 to 3 do begin
      ps := IntToStr(pz[k]);
      While Length(ps) < 2 do ps := '0' + ps;
      pu := pu + ps;
      end;
    If pu[1] = '0' then Delete(pu, 1, 1);
    end;

  begin
  Try
    pu  := String(RegName + RegAddr1 + RegAddr2);
    CountChars;
    Val(pu, NNr, code);
    If (code = 0) and (NNr > 100) then begin
      LizNumStr := pu;
      Result    := NNr
      end
    else begin
      LizNumStr := '0';
      Result    := 0;
      end;
  except
    Result := 0;
  end; { of try }
  end;

function GetLogicalProfilNum(key: String): Integer;
  begin
  If Length(key) = 0 then
    Result := 0
  else
    try
      Result := StrToInt(Copy(key, 2, 2));
    except
      Result := 0;
    end;
  end;

function GetKeyStrFromLogicalNum(Num: Integer): String;
  var gks : String;
  begin
  gks := '';
  If Num > 0 then begin
    gks := IntToStr(Num);
    If Length(gks) = 1 then
      gks := 'P0' + gks
    else
      gks := 'P' + gks;
    end;
  Result := gks;
  end;

function GetKeyStrFromIndex(Index: Integer): String;
  begin
  If (Index >= FirstMenuCfg2Edit) then
    Index := Index - FirstMenuCfg2Edit + 41;
  Result := GetKeyStrFromLogicalNum(Index);
  end;

function GetRGIndexFrom(XOF: TXMLOutputFormat): Integer;
  const tbl : Array[TXMLOutputFormat] of Integer = (1, 0, 2, 3);
  begin
  Case XOF of
    fofRaw           : Result := 1;
    fofCompressed    : Result := 0;
    fofPrettyPrint   : Result := 3;
  else
    Result := 2;
  end; { of case }
  end;

function GetXOFFrom(RGIndex: Integer): TXMLOutputFormat;
  const tbl : Array[0..3] of TXMLOutputFormat =
               (fofCompressed, fofRaw, fofShortLines, fofPrettyPrint);
  begin
  If (RGIndex >= 0) and (RGIndex <= 3) then
    Result := tbl[RGIndex]
  else
    Result := fofShortLines;
  end;


{ ========= TMyIniFile ================= }

constructor TMyIniFile.Create(GlobalIniPath: String);
  var LocalUsrPath,
      oldini,
      dir          : string;
      GlobalIsNew,
      PrivatIsNew  : Boolean;
      n            : Integer;

  begin
  Inherited Create;
  FUp2date := True;

  { Erst globale Initialisierungsdatei öffnen bzw. erstellen }
  GlobalIsNew := Not FileExists(GlobalIniPath);
  GlobalIF := TIniFile.Create(GlobalIniPath);
  If GlobalIsNew then       { Ini-Datei existiert noch nicht  }
    try
      UserIsAdmin  := True;    { hoffentlich !                                }
      AutoRegister := True;    { Veranlaßt die spätere Suche nach Lizenzdaten }
      SaveLangInfo;
      SaveVersion;
      SaveOptions('STANDARD');
      SavePresetMenuConfigs;
      SaveNetOptions;
    except
      UserIsAdmin := False;
    end { of try }
  else begin                { Ini-Datei existiert schon ==> Updaten !         }
    EuklidLanguage := UpperCase(GlobalIF.ReadString('Lizenz', 'Sprache', EuklidLanguage));
    UserIsAdmin := CanWriteTo(GlobalIF);
    LoadNetOptions;
    LoadOptions('STANDARD');
    If IsOlderThanExe then begin
      FUp2Date := False;
      If UserIsAdmin then begin
        DeleteLicDataDoubles;
        SavePresetMenuConfigs;
        SaveVersion;
        With GlobalIF do begin
          If SectionExists('SETUP') then EraseSection('SETUP');
          If SectionExists('USER') then EraseSection('USER');
          If SectionExists('MAKROS') then EraseSection('MAKROS');
          If SectionExists('LRU-LISTE') then EraseSection('LRU-LISTE');
          If SectionExists('USER-FARBEN') then EraseSection('USER-FARBEN');
          UpdateFile;
          end;
        FUp2Date := True;
        end;
      end;
    end;
  GlobalIF.UpdateFile;
  MyStartMsg[16] := Get_EUKLID_VCR_Text; { erst nachdem die Sprache klar ist }


  { Pfad für die private Initialisierungsdatei ermitteln }
  If UserOptFileInExeDir then begin { Spezialfall der transportablen Installation }
    LocalUsrPath := ExtractFileDir(Application.ExeName) + '\edg_user.ini';
    PrivatIsNew := Not FileExists(LocalUsrPath);
    end
  else begin { Normalfall der Netzwerk-/NT-Installation }
    dir := GetActUsersAppDataFolder('\DynaGeo');
    If DirectoryExists(dir) then
      LocalUsrPath := dir + '\edg_user.ini'
    else
      LocalUsrPath := '';
    PrivatIsNew := (Length(LocalUsrPath) > 0) and
                   (Not FileExists(LocalUsrPath));
    end;

  { Alte Private Initialisierungsdaten suchen und Daten umspeichern }
  If PrivatIsNew then begin
    oldini := ExpandFileName('dynageo.ini'); { Erst im aktuellen Verzeichnis suchen,}
    If Not FileExists(oldini) then begin     { ... dann im DynaGeo-Verzeichnis!     }
      oldini := ExtractFileDir(GlobalIniPath) + '\dynageo.ini';
      If Not FileExists(oldini) then
        oldini := '';
      end;
    If Length(oldini) > 0 then begin
      CopyFile(PChar(oldini), PChar(LocalUsrPath), True);
      SetFileAttributes(PChar(LocalUsrPath), FILE_ATTRIBUTE_NORMAL);
      end;
    end;

  { Private Initialisierungsdatei anlegen }
  If Length(LocalUsrPath) > 0 then
    try
      PrivatIF := TIniFile.Create(LocalUsrPath);
      If PrivatIsNew then begin    { Ini-Datei existiert noch nicht oder  }
        With PrivatIF do begin     { ist eine Kopie der alten Dynageo.ini }
          { Nicht mehr benötigte Abschnitte löschen }
          If SectionExists('LIZENZ') then EraseSection('LIZENZ');
          If SectionExists('STANDARD') then EraseSection('STANDARD');
          If SectionExists('PROFILNAMEN') then EraseSection('PROFILNAMEN');
          If SectionExists('PROFILE') then EraseSection('PROFILE');
          If SectionExists('SETUP') then EraseSection('SETUP');
          { Eventuell vorhandene Einstellungen laden }
          If SectionExists('USER') then LoadOptions('USER');
          If SectionExists('USER-FARBEN') then LoadUserCols;
          end;
        SaveSetupDefaults;         { ShareWare-Defaults eintragen         }
        PrivatIF.UpdateFile;
        end
      else                         { Ini-Datei existiert schon !          }
        If EditOptionsAllowed then begin
          LoadOptions('USER');
          LoadUserCols;
          end;
      If (Not PrivatIF.SectionExists('Lizenz')) or        { INI *vor* 2.6 }
         (Not PrivatIF.ValueExists('Lizenz', 'TempLizNr')) then begin
        n := Trunc(Now) * 1317 + 483;
        PrivatIF.WriteInteger('Lizenz', 'TempLizNr', n);
        end;
      PrivatIF.WriteString('Lizenz', 'Path', ExtractFilePath(Application.ExeName));
    except
      LocalUsrPath := '';
    end;
  end;

destructor TMyIniFile.Destroy;
  begin
  GlobalIF.Free;
  PrivatIF.Free;
  Inherited Destroy;
  end;

function TMyIniFile.LoadOptions(Section: String): Boolean;
  var IniF : TIniFile;
      n    : Integer;
  begin
  Section := UpperCase(Section);
  If Section = 'USER' then
    IniF    := PrivatIF
  else begin
    Section := 'STANDARD';
    IniF    := GlobalIF;
    end;

  If Section = 'STANDARD' then
    With IniF do
      try
        RightAnglePt     := ReadInteger(Section, 'RechterWinkelPunkt',   0) = 1;
        FillAngleSector  := ReadBool(Section, 'GefüllteWinkel', True);
        Use_Fat_Cursors  := ReadBool(Section, 'Use_Fat_Cursors', False);
        ExtPointCmd      := ReadBool(Section, 'Smart_PointCmd', False);
        SimShow          := ReadBool(Section, 'Show_OkCheckSim', False);
        RecursionAllowed := ReadBool(Section, 'Recursion_Allowed', False);
        XMLOutputFormat  := GetXOFFrom(ReadInteger(Section, 'XMLOutputFormat', 2));

        PrnNeedsLineSupport       := ReadBool(Section, 'Int_Geradenstil_Prn', False);
        PrnNeedsCurvSupport       := ReadBool(Section, 'Int_Kurvenstil_Prn', False);
        PrnKnowsHatchedFillings   := ReadBool(Section, 'HatchedFill_Prn', False);
        PrnKnowsUserDefinedBrush  := ReadBool(Section, 'UserDefBrush_Prn', False);

        ClipboardNeedsLineSupport := ReadBool(Section, 'Int_Geradenstil_Clipboard', False);
        ClipboardNeedsCurvSupport := ReadBool(Section, 'Int_Kurvenstil_Clipboard', False);
        ClipboardScaleX           := AsFloat(ReadString(Section, 'SkalFaktorX_Clipboard', '1.00'));
        ClipboardAspect           := AsFloat(ReadString(Section, 'YXAspekt_Clipboard', '1.00'));

        ExportBitmap_dpi          := ReadInteger(Section, 'ExportBitmap_dpi', 0);

        SynchronizeCols           := ReadBool(Section, 'AutoNamenfarbe', True);
        ShowMeasuresFramed        := ReadBool(Section, 'MaßeUmrahmen', False);
        NoNamesInConstrText       := ReadBool(Section, 'KeineNamenImKonstrText', True);
        PolyFilled                := ReadBool(Section, 'PolygonAutoFill', False);

        AutoTraceMirrorAxis   := ReadBool(Section, 'AutoSpurenBeiAchsenspiegelungen', True);
        AutoTraceMirrorCentre := ReadBool(Section, 'AutoSpurenBeiPunktspiegelungen', True);
        AutoTraceMove         := ReadBool(Section, 'AutoSpurenBeiVerschiebungen', True);
        AutoTraceRotate       := ReadBool(Section, 'AutoSpurenBeiDrehungen', True);
        AutoTraceStretch      := ReadBool(Section, 'AutoSpurenBeiStreckungen', True);

        DefBasePointStyle   := ReadInteger(Section, 'DefBasePointStyle', 1);
        DefCoordPointStyle  := ReadInteger(Section, 'DefCoordPointStyle', 3);
        DefConstrPointStyle := ReadInteger(Section, 'DefConstrPointStyle', 0);
        DefNormalLineStyle  := ReadInteger(Section, 'DefNormalLineStyle', 0);

        // Optionen für Ortslinien :
        DefLocLineStyle  := ReadInteger(Section, 'DefLocLineStyle', 1);
        If ValueExists(Section, 'DefLocLineStatus') then begin
          DefLocLineStatus := ReadInteger(Section, 'DefLocLineStatus', 7);
          LocLinesDynamic := (DefLocLineStatus and ols_IsDynamic) > 0;
          LocLinesStandard := DefLocLineStatus >= ols_TryStandard;
          end
        else begin
          If DefLocLineStyle < 2 then n := ols_IsSpline else n := 0;
          LocLinesDynamic  := ReadBool(Section, 'OLDynamic', True);
          LocLinesStandard := ReadBool(Section, 'OLStandard', False);
          If LocLinesDynamic then n := n OR ols_IsDynamic;
          If LocLinesStandard then n := n OR ols_TryStandard;
          DefLocLineStatus := n;
          end;

        // Optionen für Einhüllende :
        EnvLinesDynamic := ReadBool(Section, 'EnvDynamic', True);
        EnvShowCurve    := ReadBool(Section, 'EnvShowCurve', True);
        EnvShowLines    := ReadBool(Section, 'EnvShowLines', False);

        // Optionen für den Default-Font :
        GlobalDefaultFont.Name    := ReadString(Section, 'DefFontName', 'Arial');
        GlobalDefaultFont.CharSet := ReadInteger(Section, 'DefFontCharSet', Default_Charset);
        GlobalDefaultFont.Size    := ReadInteger(Section, 'DefFontSize', 12);
        If ReadBool(Section, 'DefFontStyleBold', False) then
          GlobalDefaultFont.Style := GlobalDefaultFont.Style + [fsBold]
        else
          GlobalDefaultFont.Style := GlobalDefaultFont.Style - [fsBold];
        If ReadBool(Section, 'DefFontStyleItalic', False) then
          GlobalDefaultFont.Style := GlobalDefaultFont.Style + [fsItalic]
        else
          GlobalDefaultFont.Style := GlobalDefaultFont.Style - [fsItalic];

        PointSize       := ReadInteger (Section, 'Punktgröße',   4);
        CatchDist       := ReadInteger (Section, 'Fangbereich',  5);
        ZoomFaktor      := RoundTo(AsFloat(ReadString(Section, 'ZoomFaktor', '1.5')), -2);
        AngleEpsilon    := RoundTo(AsFloat(ReadString(Section, 'Winkelgenauigkeit',  '0.5')), -5);
        AngleEpsilon    := bogen(AngleEpsilon);
        DistEpsilon     := AsFloat(ReadString(Section, 'Distanzgenauigkeit', '1e-4'));
        OLMinDist       := RoundTo(AsFloat(ReadString(Section, 'OL_Punktabstand',    '10.0')), -1);

        prn_UserScaleF  := RoundTo(AsFloat(ReadString(Section, 'DruckerSkalierung', '1.000')), -3);
        prn_UserBorder  := RoundTo(AsFloat(ReadString(Section, 'DruckerRandbreite',   '0.0')), -1);
        prn_PaperFormat := ReadInteger(Section, 'DruckFormat', 0);

        DefLengthUnit   := TextFramedBy2Blanks(ReadString(Section, 'Längeneinheit', 'cm'));
        DefAngleUnit    := TextFramedBy2Blanks(ReadString(Section, 'Winkeleinheit', '°'));
        DefAreaUnit     := TextFramedBy2Blanks(ReadString(Section, 'Flächeneinheit', 'cm²'));
        LengthDecimals  := ReadInteger(Section, 'LängenDezimalen', 3);
        AngleDecimals   := ReadInteger(Section, 'WinkelDezimalen', 0);
        AreaDecimals    := ReadInteger(Section, 'FlächenDezimalen', 2);
        SignedAngles    := ReadInteger(Section, 'Winkelorientierung',   1) = 1;
        SignedAreas     := ReadBool(Section, 'AllAreasSigned', False);
        MaxRiemannCount := ReadInteger(Section, 'MaxRiemannIntervalCount', 256);

        TermDigits      := ReadInteger(Section, 'TermStellenzahl', 4);
        LineEqStyle     := ReadInteger(Section, 'GeradenGleichungsTyp', 0);

        Hauptfenster.LRUList.LRUCount
                     := ReadInteger (Section, 'LRUCount',        4);
        NewCosysType := ReadInteger (Section, 'Koordsystem_Typ', 1);
        n            := ReadInteger (Section, 'Koordsystem_Col', $00808080);
        DefCosysCol  := TColor(n);

        n            := ReadInteger (Section, 'Profilnummer',    0);
        If (Section = 'STANDARD') or ChooseMenuAllowed then
          ActualMenuConfigKey := GetKeyStrFromLogicalNum(n);

        StartWindowState := ReadInteger(Section, 'StartFenster', 0);
        If StartWindowState = 2 then begin
          StartLinks  := ReadInteger(section, 'FensterLinks', 80);
          StartOben   := ReadInteger(section, 'FensterOben', 80);
          StartBreite := ReadInteger(section, 'FensterBreite', 480);
          StartHoehe  := ReadInteger(section, 'FensterHöhe', 320);
          end;
        IniF.UpdateFile;
        LoadOptions := True;
      except
        LoadOptions := False;
      end  { of try }

  else  { Section = 'USER' }
    With IniF do
      try
        n := ReadInteger (Section, 'Winkelorientierung',   -2);
        If n > -1 then SignedAngles        := n = 1;
        n := ReadInteger (Section, 'RechterWinkelPunkt',   -2);
        If n > -1 then RightAnglePt        := n = 1;
        FillAngleSector  := ReadBool(Section, 'GefüllteWinkel', FillAngleSector);
        Use_Fat_Cursors  := ReadBool(Section, 'Use_Fat_Cursors', Use_Fat_Cursors);
        ExtPointCmd      := ReadBool(Section, 'Smart_PointCmd', False);
        SimShow          := ReadBool(Section, 'Show_OkCheckSim', SimShow);
        RecursionAllowed := ReadBool(Section, 'Recursion_Allowed', False);
        XMLOutputFormat  := GetXOFFrom(ReadInteger (Section, 'XMLOutputFormat', 2));

        PrnNeedsLineSupport       := ReadBool(Section, 'Int_Geradenstil_Prn', PrnNeedsLineSupport);
        PrnNeedsCurvSupport       := ReadBool(Section, 'Int_Kurvenstil_Prn', PrnNeedsCurvSupport);
        PrnKnowsHatchedFillings   := ReadBool(Section, 'HatchedFill_Prn', PrnKnowsHatchedFillings);
        PrnKnowsUserDefinedBrush  := ReadBool(Section, 'UserDefBrush_Prn', PrnKnowsUserDefinedBrush);

        ClipboardNeedsLineSupport := ReadBool(Section, 'Int_Geradenstil_Clipboard', ClipboardNeedsLineSupport);
        ClipboardNeedsCurvSupport := ReadBool(Section, 'Int_Kurvenstil_Clipboard', ClipboardNeedsCurvSupport);
        ClipboardScaleX           := AsFloat(ReadString(Section, 'SkalFaktorX_Clipboard', '1.00'));
        ClipboardAspect           := AsFloat(ReadString(Section, 'YXAspekt_Clipboard', '1.00'));

        ExportBitmap_dpi          := ReadInteger(Section, 'ExportBitmap_dpi', 0);

        SynchronizeCols           := ReadBool(Section, 'AutoNamenfarbe', SynchronizeCols);
        ShowMeasuresFramed        := ReadBool(Section, 'MaßeUmrahmen', ShowMeasuresFramed);
        NoNamesInConstrText       := ReadBool(Section, 'KeineNamenImKonstrText', NoNamesInConstrText);
        PolyFilled                := ReadBool(Section, 'PolygonAutoFill', PolyFilled);
        SignedAreas               := ReadBool(Section, 'AllAreasSigned', SignedAreas);
        MaxRiemannCount           := ReadInteger(Section, 'MaxRiemannIntervalCount', MaxRiemannCount);

        AutoTraceMirrorAxis   := ReadBool(Section, 'AutoSpurenBeiAchsenspiegelungen', AutoTraceMirrorAxis);
        AutoTraceMirrorCentre := ReadBool(Section, 'AutoSpurenBeiPunktspiegelungen', AutoTraceMirrorCentre);
        AutoTraceMove         := ReadBool(Section, 'AutoSpurenBeiVerschiebungen', AutoTraceMove);
        AutoTraceRotate       := ReadBool(Section, 'AutoSpurenBeiDrehungen', AutoTraceRotate);
        AutoTraceStretch      := ReadBool(Section, 'AutoSpurenBeiStreckungen', AutoTraceStretch);

        DefBasePointStyle   := ReadInteger(Section, 'DefBasePointStyle', DefBasePointStyle);
        DefCoordPointStyle  := ReadInteger(Section, 'DefCoordPointStyle', DefCoordPointStyle);
        DefConstrPointStyle := ReadInteger(Section, 'DefConstrPointStyle', DefConstrPointStyle);
        DefNormalLineStyle  := ReadInteger(Section, 'DefNormalLineStyle', DefNormalLineStyle);

        // Optionen für Ortslinien :
        DefLocLineStyle  := ReadInteger(Section, 'DefLocLineStyle', 1);
        If ValueExists(Section, 'DefLocLineStatus') then begin
          DefLocLineStatus := ReadInteger(Section, 'DefLocLineStatus', 7);
          LocLinesDynamic := (n and ols_IsDynamic) > 0;
          LocLinesStandard :=  n >= ols_TryStandard;
          end
        else begin
          If DefLocLineStyle < 2 then n := ols_IsSpline else n := 0;
          LocLinesDynamic  := ReadBool(Section, 'OLDynamic', True);
          LocLinesStandard := ReadBool(Section, 'OLStandard', False);
          If LocLinesDynamic then n := n OR ols_IsDynamic;
          If LocLinesStandard then n := n OR ols_TryStandard;
          DefLocLineStatus := n;
          end;

        // Optionen für Einhüllende :
        EnvLinesDynamic := ReadBool(Section, 'EnvDynamic', True);
        EnvShowCurve    := ReadBool(Section, 'EnvShowCurve', True);
        EnvShowLines    := ReadBool(Section, 'EnvShowLines', False);

        // Optionen für den Default-Font :
        GlobalDefaultFont.Name    := ReadString(Section, 'DefFontName', GlobalDefaultFont.Name);
        GlobalDefaultFont.CharSet := ReadInteger(Section, 'DefFontCharSet', GlobalDefaultFont.Charset);
        GlobalDefaultFont.Size    := ReadInteger(Section, 'DefFontSize', GlobalDefaultFont.Size);
        If ValueExists(Section, 'DefFontStyleBold') then
          If ReadBool(Section, 'DefFontStyleBold', False) then
            GlobalDefaultFont.Style := GlobalDefaultFont.Style + [fsBold]
          else
            GlobalDefaultFont.Style := GlobalDefaultFont.Style - [fsBold];
        If ValueExists(Section, 'DefFontStyleItalic') then
          If ReadBool(Section, 'DefFontStyleItalic', False) then
            GlobalDefaultFont.Style := GlobalDefaultFont.Style + [fsItalic]
          else
            GlobalDefaultFont.Style := GlobalDefaultFont.Style - [fsItalic];

        PointSize       := ReadInteger (Section, 'Punktgröße',   PointSize);
        CatchDist       := ReadInteger (Section, 'Fangbereich',  CatchDist);
        If ValueExists(Section, 'ZoomFaktor') then
          ZoomFaktor      := RoundTo(AsFloat(ReadString(Section, 'ZoomFaktor', '1.5')), -2);
        If ValueExists(Section, 'Winkelgenauigkeit') then begin
          AngleEpsilon    := RoundTo(AsFloat(ReadString(Section, 'Winkelgenauigkeit',  '0.5')), -5);
          AngleEpsilon    := bogen(AngleEpsilon);
          end;
        If ValueExists(Section, 'Distanzgenauigkeit') then
          DistEpsilon     := AsFloat(ReadString(Section, 'Distanzgenauigkeit', '1e-4'));
        If ValueExists(Section, 'OL_Punktabstand') then
          OLMinDist       := RoundTo(AsFloat(ReadString(Section, 'OL_Punktabstand',    '10.0')), -1);
        If ValueExists(Section, 'DruckerSkalierung') then
          prn_UserScaleF  := RoundTo(AsFloat(ReadString(Section, 'DruckerSkalierung', '1.000')), -3);
        If ValueExists(Section, 'DruckerRandbreite') then
          prn_UserBorder  := RoundTo(AsFloat(ReadString(Section, 'DruckerRandbreite',   '0.0')), -1);
        If ValueExists(Section, 'DruckFormat') then
          prn_PaperFormat := ReadInteger(Section, 'DruckFormat', 0);

        DefLengthUnit   := TextFramedBy2Blanks(ReadString(Section, 'Längeneinheit', DefLengthUnit));
        DefAngleUnit    := TextFramedBy2Blanks(ReadString(Section, 'Winkeleinheit', DefAngleUnit));
        DefAreaUnit     := TextFramedBy2Blanks(ReadString(Section, 'Flächeneinheit', DefAreaUnit));
        LengthDecimals  := ReadInteger(Section, 'LängenDezimalen', LengthDecimals);
        AngleDecimals   := ReadInteger(Section, 'WinkelDezimalen', AngleDecimals);
        AreaDecimals    := ReadInteger(Section, 'FlächenDezimalen', AreaDecimals);
        TermDigits      := ReadInteger(Section, 'TermStellenzahl', TermDigits);
        LineEqStyle     := ReadInteger(Section, 'GeradenGleichungsTyp', LineEqStyle);

        With Hauptfenster.LRUList do
          LRUCount   := ReadInteger (Section, 'LRUCount',  LRUCount);
        NewCosysType := ReadInteger (Section, 'Koordsystem_Typ', NewCosysType);
        n            := ReadInteger (Section, 'Koordsystem_Col', $00C0C0C0);
        DefCosysCol  := TColor(n);
        
        If ValueExists(Section, 'Profilnummer') then begin
          n            := ReadInteger (Section, 'Profilnummer',    0);
          If ChooseMenuAllowed then
            ActualMenuConfigKey := GetKeyStrFromLogicalNum(n);
          end;

        StartWindowState := ReadInteger(Section, 'StartFenster', StartWindowState);
        If StartWindowState = 2 then begin
          StartLinks  := ReadInteger(section, 'FensterLinks', StartLinks);
          StartOben   := ReadInteger(section, 'FensterOben', StartOben);
          StartBreite := ReadInteger(section, 'FensterBreite', StartBreite);
          StartHoehe  := ReadInteger(section, 'FensterHöhe', StartHoehe);
          end;
        IniF.UpdateFile;
        LoadOptions := True;
      except
        LoadOptions := False;
      end; { of try }
  end;

function TMyIniFile.LoadNetOptions: Boolean;
  begin
  With GlobalIF do begin
    EditOptionsAllowed := ReadBool('NET', 'CanEditOptions', True);
    SaveOptionsAllowed := ReadBool('NET', 'CanSaveOptions', True);
    ChooseMenuAllowed := ReadBool('NET', 'CanChooseMenu', True);
    EditMenuesAllowed := ReadBool('NET', 'CanEditMenues', True);
    UserOptFileInExeDir := ReadBool('NET', 'UserOptFileInExeDir', False);
    end;
  Hauptfenster.Einstellungen1.Enabled := EditOptionsAllowed or UserIsAdmin;
  Result := True;
  end;

function TMyIniFile.SaveNetOptions: Boolean;
  begin
  If UserIsAdmin then
    try
      With GlobalIF do begin
        WriteBool('NET', 'CanEditOptions', EditOptionsAllowed);
        WriteBool('NET', 'CanSaveOptions', SaveOptionsAllowed);
        WriteBool('NET', 'CanChooseMenu', ChooseMenuAllowed);
        WriteBool('NET', 'CanEditMenues', EditMenuesAllowed);
        WriteBool('NET', 'UserOptFileInExeDir', UserOptFileInExeDir);
        UpdateFile;
        end;
      Result := True;
    except
      Result := False;
    end
  else
    Result := False;
  end;

function TMyIniFile.SaveOptions(Section: String): Boolean;
  var IniF : TIniFile;
      s    : Integer;
  begin
  Section := UpperCase(Section);
  If Section = 'USER' then
    IniF    := PrivatIF
  else begin
    Section := 'STANDARD';
    IniF    := GlobalIF;
    end;
  With IniF do
    Try
      If SignedAngles then s := 1 else s := 0;
      WriteInteger(section, 'Winkelorientierung', s);
      If RightAnglePt then s := 1 else s := 0;
      WriteInteger(section, 'RechterWinkelPunkt', s);
      WriteBool(section, 'GefüllteWinkel', FillAngleSector);
      WriteBool(section, 'Use_Fat_Cursors', Use_Fat_Cursors);
      WriteBool(section, 'Smart_PointCmd', ExtPointCmd);
      WriteBool(section, 'Show_OkCheckSim', SimShow);
      WriteBool(section, 'Recursion_Allowed', RecursionAllowed);
      WriteInteger(section, 'XMLOutputFormat', GetRGIndexFrom(XMLOutputFormat));

      WriteBool(section, 'Int_Geradenstil_Prn', PrnNeedsLineSupport);
      WriteBool(section, 'Int_Kurvenstil_Prn', PrnNeedsCurvSupport);
      WriteBool(section, 'HatchedFill_Prn', PrnKnowsHatchedFillings);
      WriteBool(section, 'UserDefBrush_Prn', PrnKnowsUserDefinedBrush);

      WriteBool(section, 'Int_Geradenstil_Clipboard', ClipboardNeedsLineSupport);
      WriteBool(section, 'Int_Kurvenstil_Clipboard', ClipboardNeedsCurvSupport);
      WriteString(section, 'SkalFaktorX_Clipboard', FloatToStr(ClipboardScaleX));
      WriteString(section, 'YXAspect_Clipboard', FloatToStr(ClipboardAspect));

      WriteInteger(section, 'ExportBitmap_dpi', ExportBitmap_dpi);

      WriteBool(section, 'AutoNamenfarbe', SynchronizeCols);
      WriteBool(section, 'MaßeUmrahmen', ShowMeasuresFramed);
      WriteBool(section, 'KeineNamenImKonstrText', NoNamesInConstrText);
      WriteBool(section, 'PolygonAutoFill', PolyFilled);
      WriteBool(section, 'AllAreasSigned', SignedAreas);
      WriteInteger(section, 'MaxRiemannIntervalCount', MaxRiemannCount);

      WriteBool(Section, 'AutoSpurenBeiAchsenspiegelungen', AutoTraceMirrorAxis);
      WriteBool(Section, 'AutoSpurenBeiPunktspiegelungen', AutoTraceMirrorCentre);
      WriteBool(Section, 'AutoSpurenBeiVerschiebungen', AutoTraceMove);
      WriteBool(Section, 'AutoSpurenBeiDrehungen', AutoTraceRotate);
      WriteBool(Section, 'AutoSpurenBeiStreckungen', AutoTraceStretch);

      WriteInteger(section, 'DefBasePointStyle', DefBasePointStyle);
      WriteInteger(section, 'DefCoordPointStyle', DefCoordPointStyle);
      WriteInteger(section, 'DefConstrPointStyle', DefConstrPointStyle);
      WriteInteger(section, 'DefNormalLineStyle', DefNormalLineStyle);

      WriteInteger(section, 'DefLocLineStyle', DefLocLineStyle);
      WriteInteger(section, 'DefLocLineStatus', DefLocLineStatus);
      If ValueExists(section, 'OLDynamic') then DeleteKey(section, 'OLDynamic');
      If ValueExists(section, 'OLStandard') then DeleteKey(section, 'OLStandard');
      WriteBool(section, 'EnvDynamic', EnvLinesDynamic);
      WriteBool(section, 'EnvShowCurve', EnvShowCurve);
      WriteBool(section, 'EnvShowLines', EnvShowLines);

      WriteString(section, 'DefFontName', GlobalDefaultFont.Name);
      WriteInteger(section, 'DefFontCharSet', GlobalDefaultFont.CharSet);
      WriteInteger(section, 'DefFontSize', GlobalDefaultFont.Size);
      WriteBool(section, 'DefFontStyleBold', fsBold in GlobalDefaultFont.Style);
      WriteBool(section, 'DefFontStyleItalic', fsItalic in GlobalDefaultFont.Style);

      WriteInteger(section, 'Punktgröße', PointSize);
      WriteInteger(section, 'Fangbereich', CatchDist);
      WriteString (section, 'Zoomfaktor', FloatToStrF(ZoomFaktor, ffGeneral, 10, 0));
      WriteString (section, 'Winkelgenauigkeit', FloatToStrF(grad(AngleEpsilon), ffGeneral, 10, 0));
      WriteString (section, 'Distanzgenauigkeit', FloatToStrF(DistEpsilon, ffGeneral, 2, 1));
      WriteString (section, 'OL_Punktabstand', FloatToStrF(OLMinDist, ffGeneral, 10, 0));
      WriteString (section, 'DruckerSkalierung', FloatToStrF(prn_UserScaleF, ffGeneral, 10, 0));
      WriteString (section, 'DruckerRandbreite', FloatToStrF(prn_UserBorder, ffGeneral, 10, 0));
      WriteInteger(section, 'DruckFormat', prn_PaperFormat);
      WriteString (section, 'Längeneinheit', Trim(DefLengthUnit));
      WriteString (section, 'Winkeleinheit', Trim(DefAngleUnit));
      WriteString (section, 'Flächeneinheit', Trim(DefAreaUnit));
      WriteInteger(section, 'LängenDezimalen', LengthDecimals);
      WriteInteger(section, 'WinkelDezimalen', AngleDecimals);
      WriteInteger(section, 'FlächenDezimalen', AreaDecimals);
      WriteInteger(section, 'TermStellenzahl', TermDigits);
      WriteInteger(section, 'GeradenGleichungsTyp', LineEqStyle);

      WriteInteger(section, 'LRUCount', Hauptfenster.LRUList.LRUCount);
      WriteInteger(section, 'Koordsystem_Typ', NewCosysType);
      WriteInteger(section, 'Koordsystem_Col', Integer(DefCosysCol));

      If (Section = 'STANDARD') or ChooseMenuAllowed then
        WriteInteger(section, 'Profilnummer', GetLogicalProfilNum(ActualMenuConfigKey));

      WriteInteger(section, 'StartFenster', StartWindowState);
      If StartWindowState = 2 then with HauptFenster do begin
        WriteInteger(section, 'FensterLinks', Left);
        WriteInteger(section, 'FensterOben', Top);
        WriteInteger(section, 'FensterBreite', Width);
        WriteInteger(section, 'FensterHöhe', Height);
        end;
      If section = 'USER' then
        WriteString('Lizenz', 'Path', ExtractFilePath(Application.ExeName));
      SaveOptions := True;
    except
      SaveOptions := False;
    end; { of try }
  end;

function TMyIniFile.LoadUserCols: Boolean;
  begin
  Result := False;
  If Assigned(PrivatIF) then
    with PrivatIF do
      try
        If SectionExists('User-Farben') then
          ReadSectionValues('User-Farben', Hauptfenster.ActColorDialog.CustomColors);
        Result := True;
      except
        Result := False;
      end;
  end;

function TMyIniFile.SaveUserCols: Boolean;
  var name, wert : String;
      n          : Integer;
  begin
  Result := False;
  If Assigned(PrivatIF) then
    with PrivatIF do
      try
        If SectionExists('User-Farben') then
          EraseSection('User-Farben');
        With Hauptfenster.ActColorDialog.CustomColors do begin
          name := 'ColorA';
          n    := IndexOfName(name);
          While n >= 0 do begin
            wert := Copy(strings[n], Pos('=', Strings[n])+1, 20);
            WriteString('User-Farben', name, wert);
            Inc(name[6]);
            n := IndexOfName(name);
            end;
          Result := True;
        end;
      except
        Result := False;
      end;
  end;


function TMyIniFile.LoadLRUList(sl: TLRUList): Boolean;
  var i, k : Integer;
      pu   : TStringList;
  begin
  sl.Clear;
  If Assigned(PrivatIF) then begin
    pu := TStringList.Create;
    PrivatIF.ReadSection('LRU-Liste', pu);
    Result := True;
    i := Pred(sl.LRUCount);
    While i >= pu.Count do
      Dec(i);
    For k := i downto 0 do
      sl.AddItem(pu.Strings[k]);
    pu.Free;
    end
  else
    Result := False;
  end;


function TMyIniFile.SaveLRUList(sl: TLRUList): Boolean;
  var i : Integer;
  begin
  If Assigned(PrivatIF) then
    try
      i := 0;
      If PrivatIF.SectionExists('LRU-Liste') then
        PrivatIF.EraseSection('LRU-Liste');
      While (i < sl.Count) and (i < sl.LRUCount) do begin
        PrivatIF.WriteString('LRU-Liste', sl[i], '');
        Inc (i);
        end;
      Result := True;
    except
      Result := False;  
    end
  else
    Result := False;
  end;


function TMyIniFile.SavePresetMenuConfigs: Boolean;
  { CAUTION : Any changes done here must also be done
              in the ISS install script file ! }
  begin
  With GlobalIF do
    Try
      KillMenuConfig('P01');    { Drei Einträge sind immer da ! }
      KillMenuConfig('P02');
      KillMenuConfig('P03');
      KillMenuConfig('P04');

      WriteString('PROFILNAMEN', 'P01', MyMess[ 75]);  // Nur Zirkel und Lineal
      WriteString('PROFILNAMEN', 'P02', MyMess[ 76]);  // Nur affine Objekte
      WriteString('PROFILNAMEN', 'P03', MyMess[ 77]);  // Keine Abbildungen, keine Kegelschnitte
      WriteString('PROFILNAMEN', 'P04', MyMess[104]);  // Keine Kegelschnitte

      WriteString('PROFILE', 'P0101', '041 042 047 049 051 053 055 056 057');
      WriteString('PROFILE', 'P0102', '058 059 078 079 133 134 128 135 136');
      WriteString('PROFILE', 'P0103', '137 138 139 129 154 155 156 157 159');
      WriteString('PROFILE', 'P0104', '222 223 224 225 226 227 228 221 230');
      WriteString('PROFILE', 'P0105', '231 233 241 242 243 244 034 035');

      WriteString('PROFILE', 'P0201', '041 042 056 078 079 128 129 139 154');
      WriteString('PROFILE', 'P0202', '155 156 157 159 241 242 243 244');

      WriteString('PROFILE', 'P0301', '047 049 051 053 055 056 057 058 059');
      WriteString('PROFILE', 'P0302', '221 222 223 224 225 226 227 228 034');
      WriteString('PROFILE', 'P0303', '035');

      WriteString('PROFILE', 'P0401', '221 222 223 224 225 226 227 228 034');
      WriteString('PROFILE', 'P0402', '035');

      Result := True;
    except
      Result := False;
    end; { of try }
  end;


function TMyIniFile.LoadLicenceStrings(var s1, s2, s3 : String): Boolean;
  begin
  With GlobalIF do begin
    If ReadInteger('USER', 'PrivateSecret', 0) = 0 then begin
      s1 := String(RegName);
      s2 := String(RegAddr1);
      s3 := String(RegAddr2);
      end
    else begin
      s1 := ReadString('USER', 'PSUser1', String(RegName));
      s2 := ReadString('USER', 'PSUser2', String(RegAddr1));
      s3 := ReadString('USER', 'PSUser3', String(RegAddr2));
      end;
    end;
  Result := True;
  end;

function TMyIniFile.CopyLicenceDataFile(sourcePath: String): Boolean;
  { sourcePath muß entweder
     - ein vollständiger Pfad einer existierenden DGL-Datei sein oder
     - ein existierendes Verzeichnis bezeichnen.
    Im ersten Fall wird genau die bezeichnete DGL-Datei geladen,
    im letzteren wird im benannten Verzeichnis nach einer beliebigen
    Datei mit Kennung ".DGL" gesucht und diese dann ins
    EXE-Verzeichnis kopiert. }

  var sl         : TStringList;
      sr         : TSearchRec;
      drivePart  : Char;
      dirPart,
      filePart,
      newPath    : String;
      i          : Integer;
  begin
  sl := TStringList.Create;
  ProcessPath(sourcePath, drivePart, dirPart, filePart);
  If Length(filePart) > 0 then
    sl.LoadFromFile(sourcePath)
  else begin
    If FindFirst(sourcePath + '*.dgl', faHidden + faArchive, sr) = 0 then begin
      sourcePath := sourcePath + sr.FindData.cFileName;
      sl.LoadFromFile(sourcePath);
      end;
    FindClose(sr);
    end;
  If sl.Count > 0 then                   { Leerzeilen löschen ! }
    For i := Pred(sl.Count) downto 0 do
      If Length(sl[i]) = 0 then
        sl.Delete(i);
  If (sl.Count > 5) and
     (Pos('DYNAGEO_LICDATA', sl[0]) > 0) and        { Logo ok ? }
     TextCheckSumIsOk(sl) then begin          { Checksumme ok ? }
    newPath := ExtractFilePath(Application.ExeName) +
               ExtractFileName(sourcePath);
    If Not FileExists(newPath) then
      sl.SaveToFile(newPath);
    If UserIsAdmin then
      With GlobalIF do begin
        WriteString('Lizenz', 'DGL', ExtractFileName(newPath));
        WriteString('Lizenz', 'Sprache', EuklidLanguage);
        end;
    Result := True;
    end
  else
    Result := False;
  sl.Free;
  end;

function TMyIniFile.LoadLicenceDataFromDGLFile: Boolean;
  var dgl_file,
      exepath : String;
      sl      : TStringList;
      sr      : TSearchRec;
      i       : Integer;
  begin
  Result := False;
  exepath := ExtractFilePath(Application.ExeName);
  dgl_file := GlobalIF.ReadString('LIZENZ', 'DGL', '');
  If ((Length(dgl_file) = 0) or                 { noch kein oder ein falscher }
      (Not FileExists(exepath + dgl_file))) and { DGL-Pfad eingetragen        }
     (FindFirst(exepath + '*.dgl', faHidden + faArchive, sr) = 0) then begin
    dgl_file := sr.FindData.cFileName;
    If (Length(dgl_file) > 0) and UserIsAdmin then
      GlobalIF.WriteString('Lizenz', 'DGL', dgl_file);
    end;
  If Length(dgl_file) > 0 then
    If FileExists(exepath + dgl_file) then begin
      sl := TStringList.Create;
      sl.LoadFromFile(exepath + dgl_file);
      For i := Pred(sl.Count) DownTo 0 do
        If Length(sl[i]) = 0 then
          sl.Delete(i);
      If (sl.Count > 5) and
         (Pos('DYNAGEO_LICDATA', sl[0]) > 0) and        { Logo ok ? }
         TextCheckSumIsOk(sl) then begin          { Checksumme ok ? }
        RegName  := AnsiString(sl[2]);
        RegAddr1 := AnsiString(sl[3]);
        RegAddr2 := AnsiString(sl[4]);
        GetLicenceNumber;   { setzt LizNum !!! }
        LizenzNr := StrToInt(LizNumStr);
        i := 5;
        RegData := '';
        While i < sl.Count do begin
          RegData := RegData + AnsiString(sl[i]);
          Inc(i);
          end;
        Result := True;
        end;
      sl.Free;
      end
    else
      GlobalIF.DeleteKey('Lizenz', 'DGL');
  end;


function TMyIniFile.LoadLicenceDataFromINIFile: Boolean;
  var key,
      p  : String;
  begin
  with GlobalIF do
    Try
      LizNumStr := ReadString('Lizenz', 'Nummer', '0');
      If Length(LizNumStr) < 4 then
        LoadLicenceDataFromINIFile := False
      else begin
        RegName  := AnsiString(ReadString('Lizenz', 'User1', ''));
        RegAddr1 := AnsiString(ReadString('Lizenz', 'User2', ''));
        RegAddr2 := AnsiString(ReadString('Lizenz', 'User3', ''));
        LizenzNr := StrToInt(LizNumStr);
        // EuklidLanguage := ReadString('Lizenz', 'Sprache', EuklidLanguage);
        key      := 'Data01';
        RegData  := '';
        While ValueExists('Lizenz', key) do begin
          p := ReadString('Lizenz', key, '');
          RegData := RegData + AnsiString(p);
          Increment(key);
          end;
        LoadLicenceDataFromINIFile := Length(RegData) > 100;
        end;
    except
      LoadLicenceDataFromINIFile := False;
    end;  { of try }
  end;

function TMyIniFile.ReadFirstUseDate : Integer;
{ Ersetzt die komplette "[Setup]"-Shareware-Verwaltung des "FirstUse"-
  Datums durch *einen* Eintrag in "edg_user.ini" (private Konfigurations-
  datei!), nämlich das Item [TempLizNr] im Abschnitt [Lizenz].
  Wenn dieser Eintrag noch nicht existiert, wird zunächst "50097846"
  ( ~ 22.02.2004 ) zurückgegeben; sodann wird aber sofort das aktuelle
  Datum als "FirstUse date" kodiert und die entsprechende "TempLizNr" in
  die "edg_user.ini" geschrieben.
  Wenn der Eintrag schon existiert, wird aus der eingelesenen "TempLizNr"
  das "FirstUse date" extrahiert und zurückgegeben. }
  var n : Integer;
  begin
  Result := -1;
  n := PrivatIF.ReadInteger('Lizenz', 'TempLizNr', 50097846);
  // SpyOut('The TempLizNr %s holds the FirstUse date %s.',
  //        [IntToStr(n), DateToStr(n/1317)]);
  If n <= 50097846 then begin
    n := Trunc(Now) * 1317 + 483;
    PrivatIF.WriteInteger('Lizenz', 'TempLizNr', n);
    end;
  If n MOD 1317 = 483 then begin
    n := n Div 1317;
    If (38040 < n) and (n < Trunc(Now) + 2) then
      Result := n;
    end;
  end;


function TMyIniFile.TimeCheck: Integer;
  var FU_Date : Integer;    { FirstUseDate !!!}
      SList   : TStringList;
      pu,
      root    : String;
      n, i    : Integer;
  begin
  Result := 0;
  root := 'D:';
  If StartingFromCD(root) and
     GlobalIF.SectionExists('CDSpecs') then begin
    SList := TStringList.Create;
    GlobalIF.ReadSectionValues('CDSpecs', SList);
    If SList.Count > 0 then begin
      Result := 1007;          { Unbeschränkte Laufzeit !        }
      For i := 0 to Pred(SList.Count) do begin
        pu := SList[i];
        Delete(pu, 1, Pos('=', pu));
        pu := Decode86String(pu);
        n := Pred(Pos('\', pu));
        If n > 0 then
          Delete(pu, 1, n);
        pu := root + pu;
        n := Pos('"', pu);
        While n > 0 do begin
          Delete(pu, n, 1);
          n := Pos('"', pu);
          end;
        If Not FileExists(pu) then begin
          SpyOut('Wrong CD path : %s', [pu]);
          Result := -3;        { Falsche Initialisierungsdaten ! }
          end;
        end;
      end;
    SList.Free;
    end;
  If Result = 0 then begin
    // Ursprünglich:
    // FU_Date := GetCtrlIntegerFrom(PrivatIF.ReadString('Setup', 's3', '-'));
    FU_Date := ReadFirstUseDate;  // Geändert, weil vorige Variante zu fehleranfällig !
    If (FU_Date < 0) or (Now < FU_Date) then { Invalid ctrl string !  }
      Result := -2                           { Oops, we are cracked ! }
    else                    { Ctrl string okay !                      }
      If Now - FU_Date > SW_RunTime then           { Test time over !       }
        Result := -1
      else                                { Test time still running ! }
        Result := SafeRound(SW_RunTime - (Now - FU_Date));
    end;
  end;


function TMyIniFile.IsOlderThanExe : Boolean;
  var VersStr : String;
      IniMajHi, IniMajLo, IniMinHi, IniMinLo,
      ExeMajHi, ExeMajLo, ExeMinHi, ExeMinLo,
      ppos    : Integer;
  begin
  With GlobalIF do
    If GlobalIF.ValueExists('Lizenz', 'Version') then begin
      VersStr := ReadString('Lizenz', 'Version', '1.0.0.0');
      ppos := Pos('.', VersStr);
      IniMajHi := StrToIntDef(Copy(VersStr, 1, Pred(ppos)), 1);
      Delete(VersStr, 1, ppos); ppos := Pos('.', VersStr);
      IniMajLo := StrToIntDef(Copy(VersStr, 1, Pred(ppos)), 0);
      Delete(VersStr, 1, ppos); ppos := Pos('.', VersStr);
      IniMinHi := StrToIntDef(Copy(VersStr, 1, Pred(ppos)), 0);
      Delete(VersStr, 1, ppos); // Kein Punkt mehr da !
      IniMinLo := StrToIntDef(VersStr, 0);
      end
    else begin
      IniMajHi := ReadInteger('Lizenz', 'VersMajor', 1);
      IniMajLo := ReadInteger('Lizenz', 'VersMinor', 0);
      IniMinHi := ReadInteger('Lizenz', 'VersDebug', 0);
      IniMinLo := ReadInteger('Lizenz', 'VersBuild', 0);
      end;
  GetFileVersion(Application.ExeName,
                 ExeMajHi, ExeMajLo,
                 ExeMinHi, ExeMinLo);
  If IniMajHi = ExeMajHi then
    If IniMajLo = ExeMajLo then
      If IniMinHi = ExeMinHi then
        If IniMinLo = ExeMinLo then
          Result := False
        else
          Result := IniMinLo < ExeMinLo
      else
        Result := IniMinHi < ExeMinHi
    else
      Result := IniMajLo < ExeMajLo
  else
    Result := IniMajHi < ExeMajHi;
  end;

function TMyIniFile.IsUpToDate: Boolean;
  begin
  Result := FUp2date;
  end;

function TMyIniFile.GetNewKeyStr(privat: Boolean): String;
  var IniF : TIniFile;
      s    : String;
  begin
  If privat then
    If Assigned(PrivatIF) then begin
      IniF := PrivatIF;
      s := 'P40';
      end
    else
      IniF := Nil
  else begin
    IniF := GlobalIF;
    s := 'P00';
    end;

  If Assigned(IniF) then begin
    Repeat
      Increment(s)
    until Not IniF.ValueExists('PROFILNAMEN', s);
    Result := s;
    end
  else
    Result := '';
  end;

function TMyIniFile.SaveLangInfo: Boolean;
  var pathbuf : String;
  begin
  pathbuf := ChangeFileExt(Hauptfenster.LangPath, '.eng');
  If FileExists(pathbuf) then EuklidLanguage := 'ENG';
  Try
    GlobalIF.WriteString('Lizenz', 'Sprache', EuklidLanguage);
    Result := True;
  except
    Result := False;
  end; { of try }
  end;


function TMyIniFile.SaveVersion: Boolean;
  var VersStr : String;
  begin
  Result  := True;
  VersStr := FullVersionString(Application.ExeName);
  With GlobalIF do
    try
      WriteString ('Lizenz', 'Version', VersStr);
      DeleteKey ('Lizenz', 'FCS32');
      DeleteKey ('Lizenz', 'Version32');
      DeleteKey ('Lizenz', 'VersMajor');
      DeleteKey ('Lizenz', 'VersMinor');
      DeleteKey ('Lizenz', 'VersDebug');
      DeleteKey ('Lizenz', 'VersBuild');
    except
      Result := False;
    end;
  end;

function TMyIniFile.SaveSetupDefaults: Boolean;
  { s1, s2 und s5 enthalten derzeit zufällige Verwirrdaten;
    s3 enthält das Datum des ersten Starts
       (in Tagen, d.h. den Trunc-Anteil von DateTime ! )
    s4 enthält die bisherige Laufzeit der Shareware-Version
       (in Minuten)                                           }
  begin
  If Assigned(PrivatIF) then
    with PrivatIF do begin
      Result := True;
      try
        If ReadString('Setup', 's4', '-13') = '-13' then begin
          WriteString('Setup', 's1', GetCtrlStringFrom(Random(100000)));
          WriteString('Setup', 's2', GetCtrlStringFrom(Random(100000)));
          WriteString('Setup', 's3', GetCtrlStringFrom(SafeRound(Now)));
          WriteString('Setup', 's4', GetCtrlStringFrom(             1));
          WriteString('Setup', 's5', GetCtrlStringFrom(Random(100000)));
          WriteString('Lizenz', 'path', ExtractFilePath(Application.ExeName));
          end
        else
          Result := False;
      except
        Result := False;
      end;
      end
  else
    Result := False;
  end;

function TMyIniFile.SaveRunTime: Integer;
  { Zur größeren Verwirrung werden alle 5 Strings neu geschrieben,
    obwohl ja nur s3 und s4 eine echte Information transportieren. }
  var fu,            { FirstUse : s3 }
      rt : Integer;  { RunTime  : s4 }
  begin
  If Assigned(PrivatIF) then
    with PrivatIF do begin
      fu := GetCtrlIntegerFrom(ReadString('Setup', 's3', GetCtrlStringFrom(Round(StartTime))));
      rt := GetCtrlIntegerFrom(ReadString('Setup', 's4', GetCtrlStringFrom(               1)));
      If fu <= 0 then
        fu := SafeRound(StartTime);
      If rt <  0 then
        rt := Round((Now - StartTime) * 24 * 60)
      else
        rt := rt + Round((Now - StartTime) * 24 * 60);
      try
        WriteString('Setup', 's1', GetCtrlStringFrom(Random(100000)));
        WriteString('Setup', 's2', GetCtrlStringFrom(Random(100000)));
        WriteString('Setup', 's3', GetCtrlStringFrom(fu));
        WriteString('Setup', 's4', GetCtrlStringFrom(rt));
        WriteString('Setup', 's5', GetCtrlStringFrom(Random(100000)));
        Result := rt;
      except
        Result := -1;
      end; { of try }
      end
  else
    Result := -1;
  end;

function TMyIniFile.CanWriteTo(IniF : TIniFile) : Boolean;
  var tw, tr : Integer;
  begin
  With IniF do
    try
      tw := Random(999999) + 1;
      WriteInteger('WriteTest', 'wt1', tw);
      UpdateFile;
      tr := ReadInteger('WriteTest', 'wt1', 0);
      EraseSection('WriteTest');
      UpdateFile;
      Result := tr = tw;
    except
      Result := False;
    end; { of try }
  end;

procedure TMyIniFile.DeleteLicDataDoubles;
  var SR  : TSearchRec;
      SP,                   { Serach Path }
      k2d : String;         { key to delete }

  function SafeDeleteKey(sec, key: String): Boolean;
    begin
    With GlobalIF do
      If ValueExists(sec, key) then begin
        DeleteKey(sec, key);
        Result := True;
        end
      else
        Result := False;
    end;

  begin
  SP := ExtractFilePath(Application.ExeName) + '*.DGL';
  If FindFirst(SP, faAnyFile, SR) = 0 then
    With GlobalIF do begin
      SafeDeleteKey('LIZENZ', 'NUMMER');
      SafeDeleteKey('LIZENZ', 'USER1');
      SafeDeleteKey('LIZENZ', 'USER2');
      SafeDeleteKey('LIZENZ', 'USER3');
      k2d := 'DATA00';
      Repeat
        Increment(k2d)
      until Not SafeDeleteKey('LIZENZ', k2d);
      end;
  FindClose(SR);
  end;

function TMyIniFile.LoadMenuConfigNames(SL : TStrings; var Selected : Integer): Boolean;
  var i   : Integer;
      buf : String;
      bufList : TStringList;
  begin
  bufList := TStringList.Create;
  bufList.Sorted := True;
  With GlobalIF do begin
    SL.Clear;
    ReadSection('PROFILNAMEN', bufList);
    For i := 0 to Pred(bufList.Count) do begin
      buf := ReadString('PROFILNAMEN', bufList[i], '');
      If Length(buf) > 0 then SL.Add(buf);
      end;
    SL.Insert(0, MyMess[50]);   { Nullter Eintrag }
    FirstMenuCfg2Edit := SL.Count;
    i := bufList.IndexOf(ActualMenuConfigKey);
    If i >= 0 then
      Selected := i + 1
    else
      Selected := -1;
    end;

  If Assigned(PrivatIF) then
    with PrivatIF do begin
      ReadSection('PROFILNAMEN', bufList);
      For i := 0 to Pred(bufList.Count) do begin
        buf := ReadString('PROFILNAMEN', bufList[i], '');
        If Length(buf) > 0 then SL.Add(buf);
        end;
      If (Selected < 0) and (bufList.Count > 0) then begin
        i := bufList.IndexOf(ActualMenuConfigKey);
        If i >= 0 then
          Selected := i + FirstMenuCfg2Edit
        else
          Selected := -1;
        end;
      end;

  If Selected < 0 then
    Selected := 0;
  bufList.Free;
  Result := True;
  end;

function TMyIniFile.LoadMenuConfigKeys(privat: Boolean; SL: TStrings): Boolean;
  begin
  SL.Clear;
  If privat then
    If Assigned(PrivatIF) then begin
      PrivatIF.ReadSection('PROFILNAMEN', SL);
      Result := True;
      end
    else
      Result := False
  else begin
    GlobalIF.ReadSection('PROFILNAMEN', SL);
    Result := True;
    end;
  end;

function TMyIniFile.LoadMenuConfigName(key: String): String;
  var IniF : TIniFile;
  begin
  IniF := PrivatIF;
  If Assigned(IniF) and IniF.ValueExists('PROFILNAMEN', key) then
    Result := IniF.ReadString('PROFILNAMEN', key, '')
  else begin
    IniF := GlobalIF;
    If IniF.ValueExists('PROFILNAMEN', key) then
      Result := IniF.ReadString('PROFILNAMEN', key, '')
    else
      Result := '';
    end;
  end;

function TMyIniFile.SaveMenuConfigName(key, cfgName : String; privat: Boolean = True): Boolean;
  begin
  try
    If privat then
      PrivatIF.WriteString('PROFILNAMEN', key, cfgName)
    else
      GlobalIF.WriteString('PROFILNAMEN', key, cfgName);
    Result := True;
  except
    Result := False;
  end;
  end;

function TMyIniFile.ShiftToGlobalMenuList(srcKey: String): Boolean;
  var destKey, data, title : String;
  begin
  Result := False;
  If UserIsAdmin then begin
    If GlobalIF.ValueExists('PROFILNAMEN', srcKey) then
      Result := False
    else begin  { Aktuelle Konfiguration steht noch nicht in der Liste ! }
      data  := LoadMenuConfigData(srcKey);
      title := LoadMenuConfigName(srcKey);
      with GlobalIF do begin
        destKey := 'P00';
        Repeat
          Increment(destKey)
        until Not ValueExists('PROFILNAMEN', destKey);
        If Length(title) = 0 then               { Das sollte nie vorkommen !!! }
          title := 'Global menu configuration (' + destKey + ')';
        If Length(data) > 0 then begin
          SaveMenuConfigName(destKey, title, False);
          SaveMenuConfigData(destKey, data, False);
          KillMenuConfig(srcKey);
          If ActualMenuConfigKey = srcKey then
            ActualMenuConfigKey := destKey;
          UpdateFile;
          Result := True;
          end;
        end;
      end;
    end;
  end;

function TMyIniFile.ShiftToPrivatMenuList(srcKey: String): Boolean;
  var destKey, data, title : String;
  begin
  Result := False;
  If UserIsAdmin then begin
    If PrivatIF.ValueExists('PROFILNAMEN', srcKey) then
      Result := False
    else begin  { Aktuelle Konfiguration steht noch nicht in der Liste ! }
      data  := LoadMenuConfigData(srcKey);
      title := LoadMenuConfigName(srcKey);
      with PrivatIF do begin
        destKey := 'P40';
        Repeat
          Increment(destKey)
        until Not ValueExists('PROFILNAMEN', destKey);
        If Length(title) = 0 then               { Das sollte nie vorkommen !!! }
          title := 'Private menu configuration (' + destKey + ')';
        If Length(data) > 0 then begin
          SaveMenuConfigName(destKey, title, True);
          SaveMenuConfigData(destKey, data, True);
          KillMenuConfig(srcKey);
          If ActualMenuConfigKey = srcKey then
            ActualMenuConfigKey := destKey;
          UpdateFile;
          Result := True;
          end;
        end;
      end;
    end;
  end;

function TMyIniFile.KillMenuConfig(key: String): Boolean;
  var IniF : TIniFile;
  begin
  Result := False;
  IniF := PrivatIF;
  If Assigned(IniF) and IniF.ValueExists('PROFILNAMEN', key) then
    IniF.DeleteKey('PROFILNAMEN', key)
  else begin
    IniF := GlobalIF;
    If UserIsAdmin and IniF.ValueExists('PROFILNAMEN', key) then
      IniF.DeleteKey('PROFILNAMEN', key)
    else
      IniF := Nil;
    end;
  If Assigned(IniF) then begin
    key := key + '01';
    While IniF.ValueExists('PROFILE', key) do begin
      IniF.DeleteKey('PROFILE', key);
      Increment(key);
      end;
    Result := True;
    IniF.UpdateFile;
    end;
  end;

function TMyIniFile.LoadMenuConfigData(key: String): String;
  var IniF : TIniFile;
      s    : String;
  begin
  If Assigned(PrivatIF) and
     PrivatIF.ValueExists('PROFILNAMEN', key) then
    IniF := PrivatIF
  else
    If GlobalIF.ValueExists('PROFILNAMEN', key) then
      IniF := GlobalIF
    else
      IniF := Nil;
  If Assigned(IniF) then begin
    key := key + '01';
    s   := '';
    Repeat
      If Length(s) > 0 then s := s + ' ';
      s := s + IniF.ReadString('PROFILE', key, '');
      Increment(key);
    until Not IniF.ValueExists('PROFILE', key);
    Result := s;
    end
  else
    Result := '';
  end;

function TMyIniFile.SaveMenuConfigData(key, cfgData : String; privat: Boolean = True): Boolean;
  var IniF  : TIniFile;
      cfgdl : String;   { "C"on"F"i"G"uration "D"ata "L"ine }
      i     : Integer;
  begin
  If privat then
    IniF := PrivatIF
  else
    If UserIsAdmin then
      IniF := GlobalIF
    else
      IniF := Nil;
  If Assigned(IniF) then
    try
      key := key + '01';
      While Length(cfgData) > 0 do begin
        If Length(cfgData) > 40 then begin { nach Leerzeichen suchen        }
          i := 40;
          While (i <= Length(cfgData)) and (cfgData[i] <> ' ') do Inc(i);
          If i < Length(cfgData) then begin   { i zeigt auf Leerzeichen !   }
            cfgdl := Copy(cfgData, 1, Pred(i));
            Delete(cfgData, 1, Pred(i));
            While cfgData[1] = ' ' do Delete(cfgData, 1, 1);
            end
          else begin                          { i zeigt hinter den String ! }
            cfgdl   := cfgData;
            cfgData := '';
            end;
          end
        else begin                         { ganzen Rest-String verarbeiten }
          cfgdl   := cfgData;
          cfgData := '';
          end;
        IniF.WriteString('PROFILE', key, cfgdl);
        Increment(key);
        end;
      Result := True;
    except
      Result := False;
    end
  else
    Result := False;
  end;

function TMyIniFile.LoadStandardMenuIndex: Integer;
  begin
  If UserIsAdmin then
    Result := GlobalIF.ReadInteger('STANDARD', 'Profilnummer', 0)
  else
    Result := -1;
  end;

function TMyIniFile.SaveStandardMenuIndex(num: Integer): Boolean;
  begin
  try
    GlobalIF.WriteInteger('STANDARD', 'Profilnummer', num);
    Result := True;
  except
    Result := False;
  end;
  end;



{ ====== TOptionsDlg ==================== }

var LinesMenuPics : TImageList;

function GetResIndex(val: Integer): Integer;
  begin
  Case val of
     200 : Result := 1;
     300 : Result := 2;
     400 : Result := 3;
     600 : Result := 4;
     800 : Result := 5;
    1000 : Result := 6;
    1200 : Result := 7;
  else
    Result := 0;
  end; { of case }
  end;

function GetResVal(index: Integer): Integer;
  begin
  Case index of
    1 : Result :=  200;
    2 : Result :=  300;
    3 : Result :=  400;
    4 : Result :=  600;
    5 : Result :=  800;
    6 : Result := 1000;
    7 : Result := 1200;
  else
    Result := Round(ScreenPPCMx * 2.54);
  end; { of case }
  end;

function EnumFontFamExProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
                           FontType: Integer; Data: Pointer): Integer; stdcall;
  begin
  If (FontType = TrueType_FontType) and
     (TStrings(Data).IndexOf(LogFont.lfFaceName) < 0) then
    TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
  end;

procedure TOptionsDlg.ShowCurrentValues;
  var Selected : Integer;
  begin
  HauptFenster.IniFile.LoadMenuConfigNames(CfgList.Items, Selected);
  CfgList.ItemIndex := Selected;
  CfgListChange(Nil);
  LocLinesDynamic  := (DefLocLineStatus and ols_IsDynamic) > 0;
  LocLinesStandard := DefLocLineStatus >= ols_TryStandard;

  EZoomF.Text          := FloatToStrF(ZoomFaktor, ffGeneral, 10, 0);
  SE_PointSize.Value   := PointSize;
  CosysColBox.Selected := DefCosysCol;

  EMouseC.Text   := IntToStr(CatchDist);
  EAngleAcc.Text := FloatToStrF(grad(AngleEpsilon), ffGeneral, 10, 0);
  EDistAcc.Text  := FloatToStrF(DistEpsilon, ffGeneral, 2, 1);
  EOLDist.Text   := FloatToStrF(OLMinDist, ffGeneral, 2, 0);
  ELRUCount.Text := IntToStr(Hauptfenster.LRUList.LRUCount);

  CB_FatCursors.Checked           := Hauptfenster.UseFatCursors;
  CB_ExtPointCmd.Checked          := ExtPointCmd;
  CB_ShowSim.Checked              := SimShow;
  RG_XMLFormat.ItemIndex          := GetRGIndexFrom(XMLOutputFormat);

  CB_InternalLS_Prn.Checked       := PrnNeedsLineSupport;
  CB_InternalCS_Prn.Checked       := PrnNeedsCurvSupport;
  CB_InternalLS_Clipboard.Checked := ClipboardNeedsLineSupport;
  CB_InternalCS_Clipboard.Checked := ClipboardNeedsCurvSupport;
  CB_HatchedFill_Prn.Checked      := PrnKnowsHatchedFillings;
  CB_UserDefBrush_Prn.Checked     := PrnKnowsUserDefinedBrush;
  CB_BMP_Res.Items[0]             := IntToStr(GetResVal(0)) + ' [Screen]';
  CB_BMP_Res.ItemIndex            := GetResIndex(ExportBitmap_dpi);

  CB_AngleOrient.Checked          := SignedAngles;
  CB_AutoNameCol.Checked          := SynchronizeCols;
  CB_PolygonAutoFill.Checked      := PolyFilled;
  CB_AllAreasSigned.Checked       := SignedAreas;
  CB_RightAnglePt.Checked         := RightAnglePt;
  CB_FillAngleSector.Checked      := FillAngleSector;
  CB_FrameMeasures.Checked        := ShowMeasuresFramed;
  CB_NoNamesInConstrText.Checked  := NoNamesInConstrText;
  CB_BezierOLines.Checked         := Local_DefLocLineStyle < 2;
  CB_DynaOLines.Checked           := LocLinesDynamic;
  CB_StandardOLines.Checked       := LocLinesStandard;
  CB_DynaEnvLines.Checked         := EnvLinesDynamic;
  CB_EnvShowCurve.Checked         := EnvShowCurve;
  CB_EnvShowLines.Checked         := EnvShowLines;

  CB_AutoTraceMirrorAxis.Checked   := AutoTraceMirrorAxis;
  CB_AutoTraceMirrorCentre.Checked := AutoTraceMirrorCentre;
  CB_AutoTraceMove.Checked         := AutoTraceMove;
  CB_AutoTraceRotate.Checked       := AutoTraceRotate;
  CB_AutoTraceStretch.Checked      := AutoTraceStretch;

  RGStartWindow.ItemIndex         := StartWindowState;
  RGNewCoordSys.ItemIndex         := NewCosysType;
  ELengthUnit.Text                := DefLengthUnit;
  EAngleUnit.Text                 := DefAngleUnit;
  EAreaUnit.Text                  := DefAreaUnit;
  SpELengthDecimals.Value         := LengthDecimals;
  SpEAngleDecimals.Value          := AngleDecimals;
  SpEAreaDecimals.Value           := AreaDecimals;
  SpEMaxRieCnt.Value              := MaxRiemannCount;
  RG_LineEquationStyle.ItemIndex  := LineEqStyle;

  BB_BasePointDefStyle.Glyph   := PointStyleMenu.Items[Local_DefBasePointStyle].Bitmap;
  BB_CoordPointDefStyle.Glyph  := PointStyleMenu.Items[Local_DefCoordPointStyle].Bitmap;
  BB_ConstrPointDefStyle.Glyph := PointStyleMenu.Items[Local_DefConstrPointStyle].Bitmap;
  BB_NormalLineDefStyle.Glyph  := Nil;
  BB_LocLineDefStyle.Glyph     := Nil;
  LinesMenuPics.GetBitmap(Local_DefNormalLineStyle, BB_NormalLineDefStyle.Glyph);
  Case Local_DefLocLineStyle of
    0 : LinesMenuPics.GetBitmap(0, BB_LocLineDefStyle.Glyph);
    1 : LinesMenuPics.GetBitmap(1, BB_LocLineDefStyle.Glyph);
    2 : LinesMenuPics.GetBitmap(6, BB_LocLineDefStyle.Glyph);
    3 : LinesMenuPics.GetBitmap(7, BB_LocLineDefStyle.Glyph);
  end; { of case }

  PreviewPanel.Font := GlobalDefaultFont;
  Selected := CB_DefaultFontFace.Items.IndexOf(GlobalDefaultFont.Name);
  If Selected >= 0 then
    CB_DefaultFontFace.ItemIndex := Selected
  else begin
    Selected := CB_DefaultFontFace.Items.IndexOf('Arial');
    if Selected >= 0 then
      CB_DefaultFontFace.ItemIndex := Selected
    else
      CB_DefaultFontFace.SelText := 'Arial';
    end;
  Selected := GlobalDefaultFont.Size;
  if Selected < 6 then
    SE_DefaultFontSize.Value := 6
  else if Selected > 60 then
    SE_DefaultFontSize.Value := 60
  else
    SE_DefaultFontSize.Value := Selected;
  end;

procedure TOptionsDlg.FormShow(Sender: TObject);
  var DC      : HDC;
      logFont : TLogFont;
  begin
  { Lokales Menü einrichten }
  AktuelleUserEinstellungenSpeichern1.Enabled := SaveOptionsAllowed;
  LetzteUserEinstellungenWiederLaden1.Enabled := SaveOptionsAllowed;
  NetzwerkOptionen1.Enabled         := UserIsAdmin;
  AlsStandardSpeichern1.Enabled     := UserIsAdmin;
  LizenzDatenAktualisieren1.Enabled := UserIsAdmin;

  { Registerseite "Menükonfiguration" einrichten }
  BtnNewMenuCfg.Enabled  := EditMenuesAllowed;
  BtnEditMenuCfg.Enabled := EditMenuesAllowed;
  BtnDelMenuCfg.Enabled  := EditMenuesAllowed;
  CfgList.Enabled := ChooseMenuAllowed;
  Panel2.Visible  := ChooseMenuAllowed;

  { Default-Werte für die Darstellungs-Optionen setzen }
  Local_DefBasePointStyle   := DefBasePointStyle;
  Local_DefCoordPointStyle  := DefCoordPointStyle;
  Local_DefConstrPointStyle := DefConstrPointStyle;
  Local_DefNormalLineStyle  := DefNormalLineStyle;
  Local_DefLocLineStyle     := DefLocLineStyle;

  { Liste möglicher DefaultFonts laden }
  CB_DefaultFontFace.Items.Clear;
  DC := GetDC(0);
  logFont.lfCharSet := ANSI_CHARSET;
  logFont.lfFaceName := '';
  logFont.lfPitchAndFamily := 0;
  EnumFontFamiliesEx(DC, logFont, @EnumFontFamExProc, Integer(CB_DefaultFontFace.Items), 0);
  ReleaseDC(0, DC);
  CB_DefaultFontFace.Sorted := True;

  { Werte aktualisieren }
  ShowCurrentValues;
  BtnOkay.SetFocus;
  end;

procedure TOptionsDlg.SetNewValues;
  var dblbuf : Double;
      n      : Integer;

  procedure GetValue(E : TEdit; Min, Max : Double; var res : Double);
    begin
    res := AsFloat(E.Text);
    If (res < Min) or (res > Max) then begin
      While Not PageControl1.ActivePage.ContainsControl(E) do
        PageControl1.SelectNextPage(True);
      E.SetFocus;
      Abort;
      end;
    end;

  procedure SetNewMenuCfg;
    begin
    If CfgList.ItemIndex >= 0 then begin
      ActualMenuConfigKey := GetKeyStrFromIndex(CfgList.ItemIndex);
      Hauptfenster.EnableAllCommands;
      DisableCommandsIn(ActualMenuConfigKey);
      MessageBeep(mb_IconHand);
      end;
    Close;
    end;

  begin
  GetValue(EZoomF,       1, 10, dblbuf); ZoomFaktor := dblbuf;
  PointSize   := SE_PointSize.Value;
  DefCosysCol := CosysColBox.Selected;

  GetValue(EMouseC,      1, 25, dblbuf); CatchDist  :=  Round(dblbuf);
  GetValue(EAngleAcc, 1e-5, 10, dblbuf); AngleEpsilon  := bogen(dblbuf);
  GetValue(EDistAcc, 1e-12,  1, dblbuf); DistEpsilon   := dblbuf;
  GetValue(EOLDist,      1, 50, dblbuf); OLMinDist     := dblbuf;
  GetValue(ELRUCount,    0,  9, dblbuf); Hauptfenster.LRUList.LRUCount
                                                       := Round(dblbuf);
  Use_Fat_Cursors     := CB_FatCursors.Checked;
  Hauptfenster.UseFatCursors := Use_Fat_Cursors;
  Hauptfenster.Drawing.IsDoubleBuffered := Double_Buffered;
  ExtPointCmd         := CB_ExtPointCmd.Checked;
  SimShow             := CB_ShowSim.Checked;
  XMLOutputFormat     := GetXOFFrom(RG_XMLFormat.ItemIndex);

  PrnNeedsLineSupport        := CB_InternalLS_Prn.Checked;
  PrnNeedsCurvSupport        := CB_InternalCS_Prn.Checked;
  PrnKnowsHatchedFillings    := CB_HatchedFill_Prn.Checked;
  PrnKnowsUserDefinedBrush   := CB_UserDefBrush_Prn.Checked;
  ClipboardNeedsLineSupport  := CB_InternalLS_Clipboard.Checked;
  ClipboardNeedsCurvSupport  := CB_InternalCS_Clipboard.Checked;
  GetValue(Ed_ScaleX_Clpbrd, 1e-1, 10, dblbuf); ClipboardScaleX := dblbuf;
  GetValue(Ed_Aspect_Clpbrd, 1e-1, 10, dblbuf); ClipboardAspect := dblbuf;
  ExportBitmap_dpi           := GetResVal(CB_BMP_Res.ItemIndex);

  LocLinesDynamic     := CB_DynaOLines.Checked;
  LocLinesStandard    := CB_StandardOLines.Checked;
  EnvLinesDynamic     := CB_DynaEnvLines.Checked;
  EnvShowCurve        := CB_EnvShowCurve.Checked;
  EnvShowLines        := CB_EnvShowLines.Checked;

  SignedAngles        := CB_AngleOrient.Checked;
  SynchronizeCols     := CB_AutoNameCol.Checked;
  PolyFilled          := CB_PolygonAutoFill.Checked;
  RightAnglePt        := CB_RightAnglePt.Checked;
  FillAngleSector     := CB_FillAngleSector.Checked;
  SignedAreas         := CB_AllAreasSigned.Checked;
  ShowMeasuresFramed  := CB_FrameMeasures.Checked;
  NoNamesInConstrText := CB_NoNamesInConstrText.Checked;

  AutoTraceMirrorAxis   := CB_AutoTraceMirrorAxis.Checked;
  AutoTraceMirrorCentre := CB_AutoTraceMirrorCentre.Checked;
  AutoTraceMove         := CB_AutoTraceMove.Checked;
  AutoTraceRotate       := CB_AutoTraceRotate.Checked;
  AutoTraceStretch      := CB_AutoTraceStretch.Checked;

  StartWindowState  := RGStartWindow.ItemIndex;
  NewCosysType      := RGNewCoordSys.ItemIndex;
  DefLengthUnit     := TextFramedBy2Blanks(ELengthUnit.Text);
  DefAngleUnit      := TextFramedBy2Blanks(EAngleUnit.Text);
  DefAreaUnit       := TextFramedBy2Blanks(EAreaUnit.Text);
  LengthDecimals    := SpELengthDecimals.Value;
  AngleDecimals     := SpEAngleDecimals.Value;
  AreaDecimals      := SpEAreaDecimals.Value;
  MaxRiemannCount   := SpEMaxRieCnt.Value;

  LineEqStyle       := RG_LineEquationStyle.ItemIndex;

  DefBasePointStyle   := Local_DefBasePointStyle;
  DefCoordPointStyle  := Local_DefCoordPointStyle;
  DefConstrPointStyle := Local_DefConstrPointStyle;
  DefNormalLineStyle  := Local_DefNormalLineStyle;

  DefLocLineStyle     := Local_DefLocLineStyle;
  // Compose DefLocLineStatus from various variables:
  If DefLocLineStyle < 2 then n := ols_IsSpline else n := 0;
  If LocLinesDynamic then n := n OR ols_IsDynamic;
  DefLocLineStatus := n;
  Hauptfenster.Drawing.NewLocLineStatus := DefLocLineStatus;

  n := CB_DefaultFontFace.ItemIndex;
  GlobalDefaultFont.Name := CB_DefaultFontFace.Items[n];
  GlobalDefaultFont.Size := SE_DefaultFontSize.Value;
  Hauptfenster.Drawing.StartFont.Assign(GlobalDefaultFont);

  SetNewMenuCfg;
  end;

procedure TOptionsDlg.PageControl1Change(Sender: TObject);
  begin
  Case PageControl1.ActivePageIndex of
    0 : HelpContext := idh_opt_start;
    1 : HelpContext := idh_opt_darst;
    2 : HelpContext := idh_opt_meas;
    3 : HelpContext := idh_opt_intern;
    4 : HelpContext := idh_opt_menu;
    5 : HelpContext := idh_opt_kons;
    6 : HelpContext := idh_opt_export;
    7 : HelpContext := idh_opt_map;
    8 : HelpContext := idh_opt_olines;
  else
    HelpContext := cmd_Options;
  end; { of case }
  end;

procedure TOptionsDlg.OkayClick(Sender: TObject);
  begin
  try
    SetNewValues;
    ModalResult := mrOk;
  except
    MessageDlg(MyOptMsg[0], mtError, [mbOk], 0);
  end;
  end;


{=============== Lokales Menü ========================}

procedure TOptionsDlg.LoadStandardClick(Sender: TObject);
  begin
  If Hauptfenster.IniFile.LoadOptions('STANDARD') then begin
    Local_DefBasePointStyle   := DefBasePointStyle;
    Local_DefCoordPointStyle  := DefCoordPointStyle;
    Local_DefConstrPointStyle := DefConstrPointStyle;
    Local_DefNormalLineStyle  := DefNormalLineStyle;
    Local_DefLocLineStyle     := DefLocLineStyle;
    ShowCurrentValues;
    MessageDlg(MyOptMsg[4], mtInformation, [mbOk], 0);
    end
  else
    MessageDlg(MyOptMsg[2], mtError, [mbOk], 0);
  end;

procedure TOptionsDlg.LoadUserClick(Sender: TObject);
  begin
  If Hauptfenster.IniFile.LoadOptions('USER') and
     Hauptfenster.IniFile.LoadUserCols then begin
    Local_DefBasePointStyle   := DefBasePointStyle;
    Local_DefCoordPointStyle  := DefCoordPointStyle;
    Local_DefConstrPointStyle := DefConstrPointStyle;
    Local_DefNormalLineStyle  := DefNormalLineStyle;
    Local_DefLocLineStyle     := DefLocLineStyle;
    ShowCurrentValues;
    MessageDlg(MyOptMsg[5], mtInformation, [mbOk], 0);
    end
  else
    MessageDlg(MyOptMsg[3], mtError, [mbOk], 0);
  end;

procedure TOptionsDlg.SaveUserClick(Sender: TObject);
  begin
  try
    SetNewValues;
    If Hauptfenster.IniFile.SaveOptions('USER') and
       Hauptfenster.IniFile.SaveUserCols then
      MessageDlg(MyOptMsg[6], mtInformation, [mbOk], 0)
    else
      MessageDlg(MyOptMsg[7], mtError, [mbOk], 0);
  except
    MessageDlg(MyOptMsg[0], mtError, [mbOk], 0);
  end; { of try }
  end;

procedure TOptionsDlg.AlsStandardspeichern1Click(Sender: TObject);
  begin
  If MessageDlg(MyMess[40], mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    If Not HauptFenster.IniFile.SaveOptions('STANDARD') then
      MessageDlg(MyMess[32], mtError, [mbOk], 0)
    else
      MessageDlg(MyMess[38], mtInformation, [mbOk], 0);
  end;

procedure TOptionsDlg.LizenzDatenAktualisieren1Click(Sender: TObject);
  begin
  If IsShareWare or
     (MessageDlg(MyStartMsg[15], mtWarning,
                 [mbYes, mbNo, mbHelp], cmd_Register) = mrNo) then begin
    ModalResult := mrCancel;
    PostMessage(Hauptfenster.Handle, cmd_ExternCommand,
                cmd_Register, LongInt(0));
    end;
  end;


{====== Hilfsroutinen zu einzelnen Optionen ========}

procedure TOptionsDlg.CB_BezierOLinesClick(Sender: TObject);
  begin
  If CB_BezierOLines.Checked then
    If Local_DefLocLineStyle > 1 then
      Local_DefLocLineStyle := Local_DefLocLineStyle - 2
    else
  else
    If Local_DefLocLineStyle < 2 then
      Local_DefLocLineStyle := Local_DefLocLineStyle + 2;
  ShowCurrentValues;
  end;

procedure TOptionsDlg.DefaultFontChange(Sender: TObject);
  begin
  PreviewPanel.Font.Name := CB_DefaultFontFace.Items[CB_DefaultFontFace.ItemIndex];
  PreviewPanel.Font.Size := SE_DefaultFontSize.Value;
  PreviewPanel.Invalidate;
  end;

{====== MenuKonfiguration: Interne Hilfsroutinen =======}

procedure TOptionsDlg.DisableCommandsIn(key: String);
  var s         : String;
      num, code,
      i         : Integer;

  procedure look4digits(var st: String);
    begin
    While (Length(st) > 0) and
          Not CharInSet(st[1], ['0'..'9']) do
      Delete(st, 1, 1);
    end;

  begin
  S := HauptFenster.IniFile.LoadMenuConfigData(key);
  look4digits(S);
  While Length(S) > 0 do begin
    i := 1;
    While (i < Length(S)) and CharInSet(S[i+1], ['0'..'9']) do Inc(i);
    Val(Copy(S, 1, i), num, code);
    If code = 0 then
      Hauptfenster.DisableCommand(num)
    else begin
      MessageDlg(MyOptMsg[8], mtError, [mbOk], 0);
      Exit;
      end;
    Delete(S, 1, i);
    look4digits(S);
    end;
  end;

procedure TOptionsDlg.NetzwerkOptionen1Click(Sender: TObject);
  var NetOptionsDlg : TNetOptionsDlg;
      Old_UOFIED    : Boolean;
      NIFName       : String;
      OIF           : TIniFile;

  function GetNewIniFName : String;
    var dir : String;
    begin
    Result := '';
    If UserOptFileInExeDir then
      Result := ExtractFileDir(Application.ExeName) + '\edg_user.ini'
    else begin
      dir := GetActUsersAppDataFolder('DynaGeo');
      If Length(dir) > 0 then
        Result := dir + '\edg_user.ini';
      end;
    end;

  begin
  Old_UOFIED := UserOptFileInExeDir;
  NetOptionsDlg := TNetOptionsDlg.Create(Self);
  NetOptionsDlg.ShowModal;
  NetOptionsDlg.Free;
  Repaint;
  If UserOptFileInExeDir <> Old_UOFIED then begin
    OIF     := Hauptfenster.IniFile.PrivatIF;
    NIFName := GetNewIniFName;
    If Length(NIFName) > 0 then
      try
        Hauptfenster.IniFile.PrivatIF := TIniFile.Create(NIFName);
        If Hauptfenster.IniFile.SaveOptions('User') then begin
          MessageDlg(MyMess[144], mtInformation, [mbOK], 0);
          OIF.Free;
          end
        else begin
          MessageDlg(MyMess[145], mtError, [mbOk], 0);
          IF Hauptfenster.IniFile.PrivatIF <> OIF then begin
            Hauptfenster.IniFile.PrivatIF.Free;
            Hauptfenster.IniFile.PrivatIF := OIF;
            end;
          end;
      except
        MessageDlg(MyMess[145], mtError, [mbOk], 0);
        Hauptfenster.IniFile.PrivatIF := OIF;
      end
    else
      MessageDlg(MyMess[145], mtError, [mbOk], 0);
    end;
  ModalResult := mrOk;
  end;

procedure TOptionsDlg.CfgListChange(Sender: TObject);
  begin
  With CfgList do begin
    BtnDelMenuCfg.Enabled  := EditMenuesAllowed and
                              (ItemIndex = Pred(Items.Count)) and
                              (ItemIndex >= FirstMenuCfg2Edit);
    BtnEditMenuCfg.Enabled := EditMenuesAllowed and
                              (ItemIndex >= FirstMenuCfg2Edit);
    end;
  end;

{ ============ Menu-Konfiguration-Ereignisse ===============}

procedure TOptionsDlg.NewMenuCfgClick(Sender: TObject);
  var EditMenuConfigWin: TEditMenuConfigWin;
  begin
  EditMenuConfigWin := TEditMenuConfigWin.Create(Self);
  With EditMenuConfigWin do begin
    LoadCfgData(HauptFenster.IniFile.GetNewKeyStr(True));
    If ShowModal = mrOk then begin
      CfgList.Items.Add(Edit1.Text);
      CfgList.ItemIndex := Pred(CfgList.Items.Count);
      CfgListChange(Sender);
      end;
    Release;
    end;
  end;

procedure TOptionsDlg.EditMenuCfgClick(Sender: TObject);
  var EditMenuConfigWin: TEditMenuConfigWin;
      key : String;
  begin
  If CfgList.ItemIndex < FirstMenuCfg2Edit then Exit;
  EditMenuConfigWin := TEditMenuConfigWin.Create(Self);
  With EditMenuConfigWin do begin
    key := GetKeyStrFromIndex(CfgList.ItemIndex);
    EditMenuConfigWin.LoadCfgData(key);
    If ShowModal = mrOk then
      CfgListChange(Sender);
    Release;
    end;
  PageControl1.ActivePageIndex := 4;
  PageControl1.ActivePage.SetFocus;
  end;

procedure TOptionsDlg.DelMenuCfgClick(Sender: TObject);
  var key : String;
  begin
  key := GetKeyStrFromIndex(CfgList.ItemIndex);
  Hauptfenster.IniFile.KillMenuConfig(key);
  CfgList.Items.Delete(CfgList.ItemIndex);
  CfgList.ItemIndex := 0;
  CfgListChange(Sender);
  end;

{====== Menükonfiguration: Öffentliche Methoden ========}

procedure TOptionsDlg.RealizeActualMenuCfg(AtOnce: Boolean = False);
  begin
  If Length(ActualMenuConfigKey) > 0 then
    DisableCommandsIn(ActualMenuConfigKey);
  //If AtOnce then
    //HauptFenster.Affin.Strecke;
  end;


{ ============ Registerkarte Internes ===============}

procedure TOptionsDlg.BtnExpertOptsClick(Sender: TObject);
  var ExpertOptWin : TExpertOptWin;
  begin
  If (MessageDlg(MyMess[148], mtWarning, [mbYes, mbNo], 0) = mrYes) then begin
    ExpertOptWin := TExpertOptWin.Create(Self);
    ExpertOptWin.ShowModal;
    ExpertOptWin.Release;
    end;
  end;

{ ============ Registerkarte Darstellung ===============}

{ ------------ Point Style -----------------------------}

procedure TOptionsDlg.BB_BasePointDefStyleClick(Sender: TObject);
  var pos : TPoint;
  begin
  PointStyleEditor := BB_BasePointDefStyle;
  With PointStyleEditor do begin
    pos := Point(left + Width Div 2, top + Height Div 2);
    end;
  pos := (PointStyleEditor.Parent as TControl).ClientToScreen(pos);
  PointStyleMenu.Popup(pos.x, pos.y);
  end;

procedure TOptionsDlg.BB_CoordPointDefStyleClick(Sender: TObject);
  var pos : TPoint;
  begin
  PointStyleEditor := BB_CoordPointDefStyle;
  With PointStyleEditor do begin
    pos := Point(left + Width Div 2, top + Height Div 2);
    end;
  pos := (PointStyleEditor.Parent as TControl).ClientToScreen(pos);
  PointStyleMenu.Popup(pos.x, pos.y);
  end;

procedure TOptionsDlg.BB_ConstrPointDefStyleClick(Sender: TObject);
  var pos : TPoint;
  begin
  PointStyleEditor := BB_ConstrPointDefStyle;
  With PointStyleEditor do begin
    pos := Point(left + Width Div 2, top + Height Div 2);
    end;
  pos := (PointStyleEditor.Parent as TControl).ClientToScreen(pos);
  PointStyleMenu.Popup(pos.x, pos.y);
  end;

procedure TOptionsDlg.PointStyleClick(Sender: TObject);
  var n : Integer;
  begin
  n := (Sender as TMenuItem).MenuIndex;
  PointStyleEditor.Glyph := PointStyleMenu.Items[n].Bitmap;
  If PointStyleEditor = BB_BasePointDefStyle then
    Local_DefBasePointStyle := n
  else If PointStyleEditor = BB_CoordPointDefStyle then
    Local_DefCoordPointStyle := n
  else
    Local_DefConstrPointStyle := n;
  end;

{ --------------- NormalLine Style ------------------ }

procedure TOptionsDlg.BB_NormalLineDefStyleClick(Sender: TObject);
  var pos : TPoint;
  begin
  With BB_NormalLineDefStyle do begin
    pos := Point(left + Height, top + Height Div 2);
    end;
  pos := (BB_NormalLineDefStyle.Parent as TControl).ClientToScreen(pos);
  LineStyleMenu.Popup(pos.x, pos.y);
  end;

procedure TOptionsDlg.LineStyleMenu_MeasureItem(Sender: TObject; ACanvas: TCanvas;
  var Width, Height: Integer);
  begin
  Width  := 60;
  Height := 20;
  end;

procedure TOptionsDlg.LineStyleMenu_DrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
  begin
  With ACanvas do begin
    Pen.Width   := 1;
    Pen.Style   := psClear;
    Brush.Style := bsSolid;
    If Selected then
      Brush.Color := clSkyBlue  // statt clHighLight;
    else
      Brush.Color := clBtnFace;
    With ARect do begin
      Inc(Left, 2); Dec(Right, 2);
      Rectangle(Left, Top, Right, Bottom);
      end;
    LinesMenuPics.Draw(ACanvas, ARect.left + 5, ARect.top + 2,
                       TMenuItem(Sender).MenuIndex);
    end;
  end;

procedure TOptionsDlg.LineStyleMenuClick(Sender: TObject);
  var n : Integer;
  begin
  n := (Sender as TMenuItem).MenuIndex;
  BB_NormalLineDefStyle.Glyph := Nil;
  LinesMenuPics.GetBitmap(n, BB_NormalLineDefStyle.Glyph);
  Local_DefNormalLineStyle := n;
  end;

{ ----------- LocLine Style ----------------------- }

procedure TOptionsDlg.BB_LocLineDefStyleClick(Sender: TObject);
  var pos : TPoint;
  begin
  With BB_LocLineDefStyle do begin
    pos := Point(left + Height, top + Height Div 2);
    end;
  pos := (BB_LocLineDefStyle.Parent as TControl).ClientToScreen(pos);
  LocLineStyleMenu.Popup(pos.x, pos.y);
  end;

procedure TOptionsDlg.LocLineStyleMenu_DrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
  var n : Integer;
  begin
  With ACanvas do begin
    Pen.Width   := 1;
    Pen.Style   := psClear;
    Brush.Style := bsSolid;
    If Selected then
      Brush.Color := clAqua      // statt clHighLight;
    else
      Brush.Color := clBtnFace;
    With ARect do begin
      Inc(Left, 2); Dec(Right, 2);
      Rectangle(Left, Top, Right, Bottom);
      end;
    Case TMenuItem(Sender).MenuIndex of
      1 : n := 1;
      2 : n := 6;
      3 : n := 7;
    else
      n := 0;
    end;
    LinesMenuPics.Draw(ACanvas, ARect.left + 5, ARect.top + 2, n);
    end;
  end;

procedure TOptionsDlg.LocLineStyleMenuClick(Sender: TObject);
  var n : Integer;
  begin
  Local_DefLocLineStyle := TMenuItem(Sender).MenuIndex;
  Case Local_DefLocLineStyle of
    1 : n := 1;
    2 : n := 6;
    3 : n := 7;
  else
    n := 0;
  end;
  BB_LocLineDefStyle.Glyph := Nil;
  LinesMenuPics.GetBitmap(n, BB_LocLineDefStyle.Glyph);
  CB_BezierOLines.Checked := Local_DefLocLineStyle < 2;
  end;


{========= Lokales Spickel-Tool ========================}

function EnglishVersionWanted: Boolean;
{ Liefert TRUE genau dann, wenn entweder
    1. noch keine INI-Datei vorhanden ist, aber schon eine ENG-Datei
    2. schon eine INI-Datei vorhanden ist, in der im Abschnitt [Lizenz]
           der Eintrag "Sprache=ENG" steht.
  In allen anderen Fällen liefert die Funktion FALSE, und es bleibt bei
  der deutschen Oberfläche.                                             }
  var fn   : String;
      inif : TIniFile;
      L_Id : String;
  begin
  fn := ChangeFileExt(Application.ExeName, '.ini');
  if FileExists(fn) then begin
    inif := TIniFile.Create(fn);
    try
      Result := False;
      L_Id := UpperCase(inif.ReadString('Lizenz', 'Sprache', 'DEU'));
      Result := L_Id = 'ENG';
    finally
      FreeAndNil(inif);
    end;
    end
  else begin
    fn := ChangeFileExt(Application.ExeName, '.eng');
    Result := FileExists(fn);
    end;
  end;

{========= Initialisierungen ===========================}

initialization

  ASCInit('MFHG6VXEMdoJ5ZJEfRrG4JbIWRYAo3nHh41');
     { Initialisiert die Übersetzungstabelle in der Unit "ascrypt" }
  StartTime         := Now;
  FirstMenuCfg2Edit := 5;     { Kompatibilität zu 2.4 und früher ! }

  LinesMenuPics := TImageList.CreateSize(60, 15);
  With LinesMenuPics do begin
    ResourceLoad(rtBitmap, 'MENU_LINE_THIN', clWhite);       { 00 }
    ResourceLoad(rtBitmap, 'MENU_LINE_THICK', clWhite);      { 01 }
    ResourceLoad(rtBitmap, 'MENU_LINE_FAT', clWhite);        { 02 }
    ResourceLoad(rtBitmap, 'MENU_LINE_DASHED', clWhite);     { 03 }
    ResourceLoad(rtBitmap, 'MENU_LINE_DOTTED', clWhite);     { 04 }
    ResourceLoad(rtBitmap, 'MENU_LINE_DASHDOT', clWhite);    { 05 }
    ResourceLoad(rtBitmap, 'MENU_LINE_POINTS', clWhite);     { 06 }
    ResourceLoad(rtBitmap, 'MENU_LINE_FATPOINTS', clWhite);  { 07 }
    end;

  If EnglishVersionWanted then begin
    EuklidLanguage := 'ENG';
    InitializeLanguage(EuklidLanguage);
    end;

finalization
  LinesMenuPics.Free;
end.



