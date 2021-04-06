Unit MainWin;

interface

{$IFDEF NO_PLATFORMWARNINGS}
  {$WARN UNIT_PLATFORM OFF}
{$ENDIF}

uses
  Windows, Messages, Classes, SysUtils, Graphics, Controls, Forms, Dialogs,
  Menus, Tabs, Buttons, StdCtrls, ComCtrls, ExtCtrls, Printers, Clipbrd,
  ImgList, ToolWin, ActiveX, SHDocVw, ShlObj, ScktComp, XmlDom, ExtDlgs,
  Math, PngImage, HTMLHelpViewer, Generics.Collections,

  MathLib, Declar, GlobVars, TBaum, Utility, FileIO, FileIO2, FileIO3,
  GeoTypes, GeoMakro, IniFDlg, WertEing, KonstEing, KoordEing, TermEdit,
  NameDlg, OkayWin, ConstrWin, CoordWin, PrnCfg, AboutWin, RegWin,
  SelectWin, CommentWin, MakHelpEdit, MakHelpShow, SysMem, FileProp,
  SpeedBtnData, TermForm, Preview, RangeEdit, QuantPoint,
  HTMLDynaGeoXSettings, HTMLDynaGeoJSettings,
  DragDrop, OleCtrls, AniParams, GeoHelper, GeoEvents,
  GeoImage, GeoVerging, GeoLocLines, GeoConic, GeoTransf, FormatText,
  GeoGroup, GroupWin, MemberWin, SelectXCmd, OKCheckConfWin, AppEvnts,
  AssAffAbb_1, AssAffAbb_2, AssAffAbb_2a, AssAffAbb_2b, AssAffAbb_2c,
  AssAffAbb_2d, AssAffAbb_2e, AssAffAbb_3, AssAffAbb_3a, AssAffAbb_3b,
  EditMappingWin, ValidateResultWin, AskUser1, RiemannSum, WerteTabelle,
  XMLIntf, XMLDoc, msxmldom, MyWebWin, MagnGlassWin,
  GameAngles1Dlg, GameAngles2Dlg;
  //DynaGeoReg;


type
  THauptfenster = class(TForm)
    MainMenu: TMainMenu;
    DateiMenu: TMenuItem;
    BearbeitenMenu: TMenuItem;
    Neu1: TMenuItem;
    N10: TMenuItem;
    Laden1: TMenuItem;
    Speichern1: TMenuItem;
    Speichernunter1: TMenuItem;
    Druckeroptionen1: TMenuItem;
    Drucken1: TMenuItem;
    N2: TMenuItem;
    Ende1: TMenuItem;
    EinenKonstruktionsschrittzurck1: TMenuItem;
    LetzteLschungwiderrufen1: TMenuItem;
    Kopieren1: TMenuItem;
    N3: TMenuItem;
    Objektbenennen1: TMenuItem;
    Objektversteckenanzeigen1: TMenuItem;
    Objektlschen1: TMenuItem;
    KonstruierenMenu: TMenuItem;
    MakroMenu: TMenuItem;
    VerschiedenesMenu: TMenuItem;
    HilfeMenu: TMenuItem;
    Index1: TMenuItem;
    HilfezumAktuellenBefehl: TMenuItem;
    N19: TMenuItem;
    Grundlagen1: TMenuItem;
    DasEuklidFenster1: TMenuItem;
    TastaturundMaus1: TMenuItem;
    Lizenzbedingungen1: TMenuItem;
    Registrierung1: TMenuItem;
    UeberEuklid1: TMenuItem;
    Rckblende1: TMenuItem;
    KonstruktionsText1: TMenuItem;
    TextBox: TMenuItem;
    Schnitt1: TMenuItem;
    Mittelpunkt1: TMenuItem;
    N11: TMenuItem;
    Strecke1: TMenuItem;
    NeuesMakroerstellen1: TMenuItem;
    Makrobeschreibungeditieren1: TMenuItem;
    VorhandenesMakrolschen1: TMenuItem;
    Makroladen1: TMenuItem;
    Makrospeichern1: TMenuItem;
    N16: TMenuItem;
    TabSet1: TTabSet;
    Punkt1: TMenuItem;
    PunktaufeinerLinie1: TMenuItem;
    PunktmitKoordinatenxy1: TMenuItem;
    N17: TMenuItem;
    Geradeaufziehen1: TMenuItem;
    Kreislinieaufziehen1: TMenuItem;
    Dreieck1: TMenuItem;
    NEck1: TMenuItem;
    StreckefesterLnge1: TMenuItem;
    N12: TMenuItem;
    Geradedurch2Punkte1: TMenuItem;
    Mittelsenkrechte1: TMenuItem;
    Winkelhalbierende1: TMenuItem;
    Parallele1: TMenuItem;
    SenkrechteLot1: TMenuItem;
    GeradeinbestimmtemWinkel1: TMenuItem;
    N14: TMenuItem;
    KreisdurchMittelpunktundKreispunkt1: TMenuItem;
    KreismitbestimmtemRadius1: TMenuItem;
    MessenMenu: TMenuItem;
    Abstndemessen1: TMenuItem;
    Winkelweitemessen1: TMenuItem;
    TermeEingabe1: TMenuItem;
    Koordinatensystem1: TMenuItem;
    Punktfixieren1: TMenuItem;
    PunktaufGitterpunktschieben1: TMenuItem;
    Punktfixierungaufheben1: TMenuItem;
    N9: TMenuItem;
    Einstellungen1: TMenuItem;

    LoadGeoFile: TOpenDialog;
    SaveGeoFile: TSaveDialog;
    StatusBar1: TStatusBar;
    PaintBox1: TPaintBox;
    LoadMakFile: TOpenDialog;
    SaveMakFile: TSaveDialog;
    N13: TMenuItem;
    N6: TMenuItem;
    Kreisbogen1: TMenuItem;
    Strahl1: TMenuItem;
    N20: TMenuItem;
    PatternsMenu: TPopupMenu;
    KeinMuster1: TMenuItem;
    Voll1: TMenuItem;
    GestricheltNS1: TMenuItem;
    GestricheltOW1: TMenuItem;
    GestricheltNWSO1: TMenuItem;
    GestricheltNOSW1: TMenuItem;
    Kariertvertikalhorizontal1: TMenuItem;
    Kariertdiagonal1: TMenuItem;
    UserBitMap1: TMenuItem;
    ShapeMenu: TPopupMenu;
    GefllterKreis1: TMenuItem;
    GeflltesQuadrat1: TMenuItem;
    HohlerKreis1: TMenuItem;
    HohlesQuadrat1: TMenuItem;
    Kreuzaufrecht1: TMenuItem;
    Kreuzdiagonal1: TMenuItem;
    ActColorDialog: TColorDialog;
    LinesMenu: TPopupMenu;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    Winkelbogen1: TMenuItem;
    N25: TMenuItem;
    N27: TMenuItem;
    FlaecheindenVordergrundholen1: TMenuItem;
    Ortslinieaufzeichnen1: TMenuItem;
    PunktanLiniebinden1: TMenuItem;
    BindungeinesPunkteslsen1: TMenuItem;
    N5: TMenuItem;
    ZeichnungEditieren1: TMenuItem;
    ZeichnungVergroessern1: TMenuItem;
    ZeichnungVerkleinern1: TMenuItem;
    Zeichenblattverschieben1: TMenuItem;
    N7: TMenuItem;
    DruckbildVorschau1: TMenuItem;
    ContextMenu: TPopupMenu;
    Abbilden1: TMenuItem;
    MI_MirrorAxisObj: TMenuItem;
    N8: TMenuItem;
    MI_MoveObj: TMenuItem;
    MI_MirrorCentreObj: TMenuItem;
    MI_RotateObj: TMenuItem;
    MI_MirrorPtAtCircle: TMenuItem;
    Vektor1: TMenuItem;
    Zahlobjekterstellen1: TMenuItem;
    Objektzentrischstrecken1: TMenuItem;
    N31: TMenuItem;
    HTMLDynaGeoXExport: TMenuItem;
    HTMLDynaGeoJExport: TMenuItem;
    N32: TMenuItem;
    N51: TMenuItem;
    MnuZoomReset1: TMenuItem;
    AlleverborgenenObjekteanzeigen1: TMenuItem;
    N33: TMenuItem;
    VorhandeneTextboxeditieren1: TMenuItem;
    TextboxanObjektbinden1: TMenuItem;
    BindungeinerTextboxlsen1: TMenuItem;
    Animation1: TMenuItem;
    N34: TMenuItem;
    Kreuzdiagonaldnn1: TMenuItem;
    Kreuzaufrechtdnn1: TMenuItem;
    HohlerKreisdnn1: TMenuItem;
    HohlesQuadratdnn1: TMenuItem;
    ImportPicture: TMenuItem;
    N35: TMenuItem;
    Streckeeinschieben1: TMenuItem;
    Basisobjekteblinken1: TMenuItem;
    ZeichnungNeuZeichnen1: TMenuItem;
    Objektegruppieren1: TMenuItem;
    NeueGruppe1: TMenuItem;
    AffineAbbildungdefinieren1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    AbbildungaufObjAnwenden1: TMenuItem;
    MappingsMenu: TPopupMenu;
    N26: TMenuItem;
    AutorenWerkzeuge1: TMenuItem;
    Copyright: TMenuItem;
    CorrectnessCheck: TMenuItem;
    ViewerCommands: TMenuItem;
    KorrektheitsPrfung1: TMenuItem;
    FunktionsSchaubild1: TMenuItem;
    Tangente1: TMenuItem;
    AreaBelowCurve: TMenuItem;
    Kegelschnitte1: TMenuItem;
    N1: TMenuItem;
    EllipseF: TMenuItem;
    EllipseS: TMenuItem;
    EllipseK: TMenuItem;
    ParabelF: TMenuItem;
    ParabelT: TMenuItem;
    HyperbelF: TMenuItem;
    HyperbelA: TMenuItem;
    Kegelschnitt5P: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    DynaHelp: TMenuItem;
    N37: TMenuItem;
    N18: TMenuItem;
    Flcheninhaltmessen1: TMenuItem;
    N38: TMenuItem;
    PolzugegebenerPolaren1: TMenuItem;
    PolarezugegebenemPol1: TMenuItem;
    Ansicht1: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N4: TMenuItem;
    N15: TMenuItem;
    Geodreieckanzeigenverbergen1: TMenuItem;
    RiemannSummen1: TMenuItem;
    RegulresNEck1: TMenuItem;
    AbbildungEditieren1: TMenuItem;
    PunktinfreienBasispunktverwandeln1: TMenuItem;
    ZweiPunktezusammenfhren1: TMenuItem;
    N41: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    Gitterpunkt1: TMenuItem;
    Einhuellendeaufzeichnen1: TMenuItem;
    Kurven1: TMenuItem;
    N36: TMenuItem;
    SpeedBar: TNotebook;
    SB_FileNew: TSpeedButton;
    SB_FileLoad: TSpeedButton;
    SB_FileSave: TSpeedButton;
    SB_FilePrint: TSpeedButton;
    SB_Undo: TSpeedButton;
    SB_UndoUndo: TSpeedButton;
    SB_NameObj: TSpeedButton;
    SB_HideObj: TSpeedButton;
    SB_EraseObj: TSpeedButton;
    SB_BindPoint2Line: TSpeedButton;
    SB_ReleasePoint: TSpeedButton;
    SB_Action: TSpeedButton;
    SB_TextBox: TSpeedButton;
    SB_Image: TSpeedButton;
    SB_Scroll_1L: TSpeedButton;
    SB_Scroll_1R: TSpeedButton;
    SB_CheckSolution: TSpeedButton;
    SB_SetSquare: TSpeedButton;
    SB_BasePoint: TSpeedButton;
    SB_CoordPoint: TSpeedButton;
    SB_PointOnLine: TSpeedButton;
    SB_Intersection: TSpeedButton;
    SB_MidPoint: TSpeedButton;
    SB_ShortLine: TSpeedButton;
    SB_FixLine: TSpeedButton;
    SB_MidLine: TSpeedButton;
    SB_LongLine: TSpeedButton;
    SB_Perpendicular: TSpeedButton;
    SB_ParallelLine: TSpeedButton;
    SB_PerpBisector: TSpeedButton;
    SB_Bisector: TSpeedButton;
    SB_XAngleLine: TSpeedButton;
    SB_CircleArc: TSpeedButton;
    SB_Circle: TSpeedButton;
    SB_XCircle: TSpeedButton;
    SB_Triangle: TSpeedButton;
    SB_Polygon: TSpeedButton;
    SB_Vector: TSpeedButton;
    SB_Scroll_2L: TSpeedButton;
    SB_Scroll_2R: TSpeedButton;
    SB_MirrorAxisObj: TSpeedButton;
    SB_MoveObj: TSpeedButton;
    SB_DefineAffinMap: TSpeedButton;
    SB_RotateObj: TSpeedButton;
    SB_MirrorCentreObj: TSpeedButton;
    SB_MapObj: TSpeedButton;
    SB_StretchObj: TSpeedButton;
    SB_MirrorPtAtCircle: TSpeedButton;
    SB_Scroll_3L: TSpeedButton;
    SB_Scroll_3R: TSpeedButton;
    SB_MakeTrace: TSpeedButton;
    SB_Conic: TSpeedButton;
    SB_Graph: TSpeedButton;
    SB_Tangente: TSpeedButton;
    SB_GraphArea: TSpeedButton;
    SB_EllipseF: TSpeedButton;
    SB_EllipseS: TSpeedButton;
    SB_EllipseK: TSpeedButton;
    SB_ParabelF: TSpeedButton;
    SB_ParabelT: TSpeedButton;
    SB_HyperbelA: TSpeedButton;
    SB_Scroll_4L: TSpeedButton;
    SB_Scroll_4R: TSpeedButton;
    SB_HyperbelF: TSpeedButton;
    SB_Polare: TSpeedButton;
    SB_Pol: TSpeedButton;
    SB_MakeEnvelop: TSpeedButton;
    SB_LineStyle: TSpeedButton;
    SB_PointShape: TSpeedButton;
    SB_ObjColour: TSpeedButton;
    SB_Patterns: TSpeedButton;
    SB_FillArea: TSpeedButton;
    SB_CutArea: TSpeedButton;
    SB_EditObj: TSpeedButton;
    SB_FillColour: TSpeedButton;
    SB_Scroll_5L: TSpeedButton;
    SB_Scroll_5R: TSpeedButton;
    SB_CoordSys: TSpeedButton;
    SB_FixAPoint: TSpeedButton;
    SB_ClipPoint2Grid: TSpeedButton;
    SB_UnfixAPoint: TSpeedButton;
    SB_MeasureDist: TSpeedButton;
    SB_MeasureAngle: TSpeedButton;
    SB_TermObj: TSpeedButton;
    SB_NumberObj: TSpeedButton;
    SB_Scroll_6L: TSpeedButton;
    SB_Scroll_6R: TSpeedButton;
    SB_MeasureArea: TSpeedButton;
    SB_AniOptions: TSpeedButton;
    SB_AniFastBK: TSpeedButton;
    SB_AniGoBK: TSpeedButton;
    SB_AniStop: TSpeedButton;
    SB_AniGoFD: TSpeedButton;
    SB_AniFastFD: TSpeedButton;
    SB_Scroll_7L: TSpeedButton;
    SB_Scroll_7R: TSpeedButton;
    SB_Glass: TSpeedButton;
    FunktionenLupeeinausschalten1: TMenuItem;
    SpielWinkel1: TMenuItem;
    SpielWinkelmitdemGeodreieckmessen1: TMenuItem;
    N42: TMenuItem;
    PolynomFunktiondurchgegebenePunkte1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormIdle(Sender: TObject; var Done: Boolean);
    procedure FormInvalidate(Sender: TObject);
    procedure Neu1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure Ende1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Laden1Click(Sender: TObject);
    procedure Speichernunter1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ObjectBlinkTimer(Sender: TObject);
    procedure Punkt1Click(Sender: TObject);
    procedure PunktaufeinerLinie1Click(Sender: TObject);
    procedure SB_IntersectionClick(Sender: TObject);
    procedure SB_MirrorAxisObjClick(Sender: TObject);
    procedure SB_MidPointClick(Sender: TObject);
    procedure SB_ShortLineClick(Sender: TObject);
    procedure SB_MidLineClick(Sender: TObject);
    procedure SB_LongLineClick(Sender: TObject);
    procedure SB_PerpendicularClick(Sender: TObject);
    procedure SB_ParallelLineClick(Sender: TObject);
    procedure SB_PerpBisectorClick(Sender: TObject);
    procedure SB_BisectorClick(Sender: TObject);
    procedure SB_CircleClick(Sender: TObject);
    procedure Einstellungen1Click(Sender: TObject);
    procedure SB_FixLineClick(Sender: TObject);
    procedure Speichern1Click(Sender: TObject);
    procedure SB_XCircleClick(Sender: TObject);
    procedure SB_XAngleLineClick(Sender: TObject);
    procedure SB_PolygonClick(Sender: TObject);
    procedure SB_TriangleClick(Sender: TObject);
    procedure SB_NameObjClick(Sender: TObject);
    procedure SB_HideObjClick(Sender: TObject);
    procedure SB_EraseObjClick(Sender: TObject);
    procedure SB_BindPoint2LineClick(Sender: TObject);
    procedure SB_ReleasePointClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure SB_FilePrintClick(Sender: TObject);
    procedure SB_UndoClick(Sender: TObject);
    procedure SB_UndoUndoClick(Sender: TObject);
    procedure SB_MakeTraceClick(Sender: TObject);
    procedure KonstruktionsText1Click(Sender: TObject);
    procedure ZeichnungEditieren1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Koordinatensystem1Click(Sender: TObject);
    procedure WinkelbogenClick(Sender: TObject);
    procedure Abstndemessen1Click(Sender: TObject);
    procedure Winkelweitemessen1Click(Sender: TObject);
    procedure Punktfixieren1Click(Sender: TObject);
    procedure PunktaufGitterpunktschieben1Click(Sender: TObject);
    procedure Punktfixierungaufheben1Click(Sender: TObject);
    procedure Geradeaufziehen1Click(Sender: TObject);
    procedure Kreislinieaufziehen1Click(Sender: TObject);
    procedure SB_TermObjClick(Sender: TObject);
    procedure Zeichnungverschieben1Click(Sender: TObject);
    procedure ZeichnungVergroessern1Click(Sender: TObject);
    procedure ZeichnungVerkleinern1Click(Sender: TObject);
    procedure Rckblende1Click(Sender: TObject);
    procedure Druckeroptionen1Click(Sender: TObject);
    procedure Kopieren1Click(Sender: TObject);
    procedure Index1Click(Sender: TObject);
    procedure Grundlagen1Click(Sender: TObject);
    procedure DasEuklidFenster1Click(Sender: TObject);
    procedure TastaturundMaus1Click(Sender: TObject);
    procedure Lizenzbedingungen1Click(Sender: TObject);
    procedure HilfezumAktuellenBefehlClick(Sender: TObject);
    procedure TabSet1DrawTab(Sender: TObject; TabCanvas: TCanvas; R: TRect;
      Index: Integer; Selected: Boolean);
    procedure UeberEuklid1Click(Sender: TObject);
    procedure Registrierung1Click(Sender: TObject);
    procedure TextBoxClick(Sender: TObject);
    procedure NeuesMakroerstellen1Click(Sender: TObject);
    procedure Makrobeschreibungeditieren1Click(Sender: TObject);
    procedure VorhandenesMakrolschen1Click(Sender: TObject);
    procedure Makroladen1Click(Sender: TObject);
    procedure Makrospeichern1Click(Sender: TObject);
    procedure PunktmitKoordinatenxy1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer;
                            var AllowChange: Boolean);
    procedure TabSet1Click(Sender: TObject);
    procedure SB_CircleArcClick(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
                            Panel: TStatusPanel; const Rect: TRect);
    procedure Area2ForegroundClick(Sender: TObject);

    procedure LinesMenuMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width,
                             Height: Integer);
    procedure LinesMenuDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
                             Selected: Boolean);
    procedure SB_PatternsClick(Sender: TObject);
    procedure SB_PointShapeClick(Sender: TObject);
    procedure SB_LineStyleClick(Sender: TObject);
    procedure SB_ColourClick(Sender: TObject);
    procedure ChangePatternClick(Sender: TObject);
    procedure ChangeShapeClick(Sender: TObject);
    procedure ChangeLineStyleClick(Sender: TObject);
    procedure ClearInitialDirs(Sender: TObject);
    procedure DruckbildVorschau1Click(Sender: TObject);
    procedure SB_VectorClick(Sender: TObject);
    procedure SB_MoveObjClick(Sender: TObject);
    procedure SB_DefineAffinMapClick(Sender: TObject);
    procedure SB_RotateObjClick(Sender: TObject);
    procedure SB_MirrorCentreObjClick(Sender: TObject);
    procedure SB_MirrorPtAtCircleClick(Sender: TObject);
    procedure SB_NumberObjClick(Sender: TObject);
    procedure SB_StretchObjClick(Sender: TObject);
    procedure HTMLDynaGeoXExportClick(Sender: TObject);
    procedure HTMLDynaGeoJExportClick(Sender: TObject);
    procedure SB_RunMakroClick(Sender: TObject);
    procedure ZeichnungReset1Click(Sender: TObject);
    procedure AlleverborgenenObjekteanzeigen1Click(Sender: TObject);
    procedure VorhandeneTextboxeditieren1Click(Sender: TObject);
    procedure TextboxanObjektbinden1Click(Sender: TObject);
    procedure SB_FillAreaClick(Sender: TObject);
    procedure SB_EditObjClick(Sender: TObject);
    procedure SB_CutAreaClick(Sender: TObject);
    procedure BindungeinerTextboxlsen1Click(Sender: TObject);
    procedure SB_AniOptionsClick(Sender: TObject);
    procedure SB_AniFastFDBKClick(Sender: TObject);
    procedure SB_AnimateClick(Sender: TObject);
    procedure SB_AniStopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SB_AniStopClick(Sender: TObject);
    procedure SB_ConicClick(Sender: TObject);
    procedure ImportPictureClick(Sender: TObject);
    procedure SB_Scroll_LeftClick(Sender: TObject);
    procedure SB_Scroll_RightClick(Sender: TObject);
    procedure StreckeEinschiebenClick(Sender: TObject);
    procedure Basisobjekteblinken1Click(Sender: TObject);
    procedure ZeichnungNeuZeichnen1Click(Sender: TObject);
    procedure NeueGruppeClick(Sender: TObject);
    procedure AlteGruppeClick(Sender: TObject);
    procedure StatusBar1Resize(Sender: TObject);
    procedure StatusBar1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StatusBar1DblClick(Sender: TObject);
    procedure StatusBar1Click(Sender: TObject);
    procedure SB_GraphClick(Sender: TObject);
    procedure SB_TangenteClick(Sender: TObject);
    procedure SB_EllipseFClick(Sender: TObject);
    procedure SB_EllipseSClick(Sender: TObject);
    procedure SB_EllipseKClick(Sender: TObject);
    procedure SB_ParabelFClick(Sender: TObject);
    procedure SB_HyperbelFClick(Sender: TObject);
    procedure SB_HyperbelAClick(Sender: TObject);
    procedure SB_ParabelTClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
    procedure FirstIdle(Sender: TObject; var Done: Boolean);
    procedure SB_MapObjClick(Sender: TObject);
    procedure AbbildungaufObjAnwenden1Click(Sender: TObject);
    procedure SB_GraphAreaClick(Sender: TObject);
    procedure SB_CheckSolutionClick(Sender: TObject);
    procedure CopyrightClick(Sender: TObject);
    procedure ViewerCommandsClick(Sender: TObject);
    procedure CorrectnessCheckClick(Sender: TObject);
    procedure SB_PolareClick(Sender: TObject);
    procedure SB_MeasureAreaClick(Sender: TObject);
    procedure SB_PolClick(Sender: TObject);
    procedure Abbilden1Click(Sender: TObject);
    procedure SB_SetSquareClick(Sender: TObject);
    procedure RiemannSummen1Click(Sender: TObject);
    procedure RegulresNEck1Click(Sender: TObject);
    procedure AbbildungEditieren1Click(Sender: TObject);
    procedure PunktinfreienBasispunktverwandeln1Click(Sender: TObject);
    procedure ZweiPunktezusammenfhren1Click(Sender: TObject);
    procedure Gitterpunkt1Click(Sender: TObject);
    procedure SB_MakeEnvelopClick(Sender: TObject);
    procedure SB_GlassClick(Sender: TObject);
    procedure SpielWinkel1Click(Sender: TObject);
    procedure SpielWinkel2Click(Sender: TObject);
    procedure TB_ZoomSliderChange(Sender: TObject);
    procedure SB_PolynomClick(Sender: TObject);

  private
    { Private-Deklarationen }
    OleDragDrop     : TOleDragDrop;
    GeoTimer        : TGeoTimer;
    AutoLoadStr     : String;
    ToolBMPs        : TImageList;
    Last2Show,
    FModus,         { falls = 0 : ZugModus (Normalfall !)  }
    PrevModus,
    Last_XM,
    Last_YM,
    LastHintTextNum,
    LastLVOIndex,
    AffinMapSubVers,
    MaCmdNum        : Integer;
    AffAssPos       : TPoint;
    BackUpDrawing   : TGeoObjListe;
    Angles1Dlg      : TAngles1Dlg;
    Angles2Dlg      : TAngles2Dlg;

    FUseFatCursors  : Boolean;
    FSelStatus      : Integer;
    FSelRect        : TRect;
    PreselectedObj,
    FLastSelectedObj: TGeoObj;
    FLastMapping    : TGTransformation;
    FLastAutoTrace  : Boolean;
    LastMouseButton : TMouseButton;
    LastShiftState  : TShiftState;

    SpacePressed,   { siehe Bemerkung in FormKeyDown ! }
    DoubleClicked,
    ZoomKeyActive,
    CoSysWasInvisible,
    BackInvalid     : Boolean;

    WertEingabe     : TWertEingabeDlg;
    KonstEingabe    : TKonstEingabeDlg;
    KoordEingabe    : TKoordEingabeDlg;
    OkayButton      : TOkayButton;
    CoordDlg        : TCoordDlg;
    PrinterCfgDlg   : TPrinterCfgDlg;
    AboutBox        : TAboutBox;
    SelectDlg       : TSelectDlg;
    TextWin         : TTextWin;
    MakHelpDlg      : TMakHelpDlg;
    MakHelpWin      : TMakHelpWin;
    HTMLDynaGeoXDlg : THTMLDynaGeoXDataForm;
    HTMLDynaGeoJDlg : THTMLDynaGeoJDataForm;
    RangeEditWin    : TRangeEditWin;
    EditGroupWin    : TEditGroupWin;
    QuantPtWin      : TQuantPtWin;
    AniParamsWin    : TAniParamsWin;
    RiemannWin      : TRiemannForm;
    FunkTabelle     : TFunkTableWin;
    FileProps       : TFileProps;
    EditOptions     : TOptionsDlg;
    TermEdit        : TTermEditDlg;
    SpBtnDataList   : TSpBtnDataList;
    TempStream      : TMemoryStream;
    TempStrings     : TStrings;

    function  GetContextHelpIndex : Integer;
    function  UserWants2Break4(new_Mode : Integer) : Boolean;
    function  UserWants2SkipDrawing: Boolean;
    function  FillSelectList(X, Y: Integer; iExp_Type: Integer = ccDragableObj): TGeoObj;
    function  IsAltCmd(Sender: TObject): Boolean;
    function  GetCaption(s: String): String;
    function  InitInputList (new_mode: Integer; SpdBtn: TObject;
                             Check: Boolean = True;
                             SwitchToolBar: Boolean = True): Boolean;
    procedure RearrangeWindowObjects;
    procedure RebuildGroupMenu;
    procedure Check4MagnGlass;
    procedure DoLoadGeoFile(fname: String);
    function  DoSaveGeoFile(DataFile: String; Check4JExp : Boolean = False): Integer;
    procedure ShowSelectionFrame;
    procedure DeleteSelectionFrame;
    procedure SetUseFatCursors(newVal: Boolean);
    procedure SetLSO(newObj: TGeoObj);
    procedure ShowCopyrightMsg;
    procedure ShowMousePosLogCoords(mx, my : Integer);
    procedure ShowHTMLHint(s: String);
    procedure ShowErrorMsg(err_nr : Integer; s: String = '');
    procedure SelectStartObject;
    procedure ProcessGeoObject;
    procedure ProcessNewLocLines;
    procedure ProcessPopupCommands(var Msg: TMessage); message cmd_PopupCommand;
    procedure ProcessExternCommands(var Msg: TMessage); message cmd_ExternCommand;
    procedure OnGroupWinClose(var Msg: TMessage); message cmd_CloseEdGroup;
    procedure RefreshCursor;
    procedure JumpLink(link: String);
    procedure AdjustToolMode(new_Mode: Integer);
    procedure RefreshEditGlyph(Button: TSpeedButton; Index: Integer);
    procedure ChangeColourGlyph(ColBtn: TSpeedButton; NewCol: TColor);
    procedure RefreshMappingMenus;
    procedure ShowPopupNearButton(Menu: TPopupMenu; Button: TSpeedButton);
    procedure GetActGraphToolsFrom(GO: TGeoObj);
    function  ChooseMakroNum: Integer;

  public
    { Public-Deklarationen }
    IniFile         : TMyIniFile;
    Drawing         : TGeoObjListe;
    Start           : TObjPtrList;
    Selected        : TList;
    LicDataPath,
    LangPath,
    ActGeoFileName  : String;
    LastValueWStr   : Array [0..5] of WideString;
    TPt             : Array[1..4] of Record x, y: Double; end;   { "Temporäre Punkte" ! }
    ActiveTermWin   : TTermForm;
    ActPopupObj     : TGeoObj;
    AddMemberWin    : TAddMemberWin;
    LRUList         : TLRUList;
    //Affin           : TAffin;
    SysMemWin       : TSysMemWin;
    NameEdit        : TObjNameDlg;
    ConstrTextWin   : TConstrTextWin;
    MagnGlassWin    : TMyMagnGlassWin;
    MagnGlassFrame  : TGZoomFrame;
    LastSpeedButton : TSpeedButton;
    AutoRepeat      : Boolean;
    MakroNum,
    FillStyleStartIndex,
    LineStyleStartIndex,
    PointStyleStartIndex,
    PotStartIndex   : Integer;

    procedure LoadOLEDroppedFile(fname: String);
    procedure LoadLRUFile(Sender: TObject);
    procedure Reset2DragMode;
    procedure RefreshAnimationButtons;
    procedure RefreshCheckButtons;
    procedure RefreshSpecialImageButtons;
    procedure RefreshMakroMenu;
    procedure ShowMyHint(HintId: Integer);
    procedure RecordTraceClick;
    procedure RecordEnvelopClick;
    procedure DisableCommand(cmd: Integer);
    procedure DisableCmdsThatBotherGames;
    procedure RestorePreviousCmdSet;
    procedure EnableAllCommands;
    procedure SetNewMakroMode(NMM: Integer);
    property  Modus: Integer read FModus;
    property  SelRect: TRect read FSelRect;
    property  SelStatus: Integer read FSelStatus;
    property  UseFatCursors: Boolean read FUseFatCursors write SetUseFatCursors;
    property  LastSelectedObj: TGeoObj read FLastSelectedObj write SetLSO;
  end;

var
  Hauptfenster : THauptfenster;

implementation

{$R *.DFM}

uses debuglog;

{ ============ Start und Ende ================}

procedure THauptfenster.FormCreate(Sender: TObject);
  var GlobalIniPath : String;

  procedure SetPaths;
    var pu : WideString;
    begin
    pu := Application.ExeName;
    GlobalIniPath := ChangeFileExt(pu, '.ini');
    If Not FileExists(GlobalIniPath) then begin
      UserIsAdmin  := True;     { hoffentlich ! }
      AutoRegister := True;     { Veranlaßt später die Suche nach Lizenzdaten }
      end;
    pu := Application.ExeName;
    LangPath := ChangeFileExt(pu, '.DEU');
    Application.HelpFile := GetValidCHMFile(ChangeFileExt(pu, '.chm'));
    If Not FileExists(Application.Helpfile) then begin
      MessageDlg(Format(MyStartMsg[11], [Application.HelpFile]),
                 mtInformation, [mbOk], 0);
      SpyOut('Error: Help file "%s" not found!', [Application.HelpFile]);
      end;
    ActGeoFileName := MyFileMsg[12] + '.GEO';
    end; {of SetPaths }


  procedure ProcessParams;
    { Der Parameter "/debug" wird in der Initialisierung
      der Unit "debuglog" erkannt und ausgewertet.        }
    var pu       : String;
        param_nr : Integer;
    begin { of ProcessParams }
    param_nr := 1;
    AutoLoadStr := '';
    While param_nr <= Paramcount do begin
      pu := ParamStr(param_nr);
      DeleteChars('"=', pu);
      If Length(pu) >= 2 then
        If pu[1] = '/' then
          Case UpCase(pu[2]) of        { Case wegen leichter Erweiterbarkeit }
            'R' : begin                { auf andere Kommandozeilenparameter  }
                  AutoRegister := True;
                  LicDataPath  := '';
                  If Length(pu) > 2 then begin
                    Delete(pu, 1, 2);
                    While (Length(pu) > 0) and (pu[1] = ' ') do
                      Delete(pu, 1, 1);
                    While param_nr < ParamCount do begin
                      Inc(param_nr);
                      pu := pu + ' ' + ParamStr(param_nr);
                      end;
                    If Length(pu) > 0 then
                      LicDataPath := IncludeTrailingPathDelimiter(pu);
                    end;
                  end;
          end  { of case }
        else
          If Length(AutoLoadStr) > 0 then
            AutoLoadStr := AutoLoadStr + ' ' + pu
          else
            AutoLoadStr := pu;
      Inc(param_nr);
      end;

    If Length(AutoLoadStr) > 0 then begin
      AutoLoadStr := ExpandUNCFileName(AutoLoadStr);
      If Not FileExists(AutoLoadStr) then
        AutoLoadStr := '';
      end;

    //Affin := TAffin.Create;
    end; { of ProcessParams }


  procedure InitRegData;
    var dc   : Char;
        s    : AnsiString;
        ds   : String;
        res  : Integer;
    begin
    If IniFile.LoadLicenceDataFromDGLFile or
       IniFile.LoadLicenceDataFromINIFile then begin
      s := RegData;
      RegData := DecodeRegString(s);
      end
    else If Length(LicDataPath) > 0 then begin
      res := mrOk;
      ds := ExtractFileDrive(LicDataPath);
      if Length(ds) > 0 then begin
        dc := ds[1];
        If CharInSet(Upcase(dc), ['A', 'B']) then { Diskettenlaufwerk testen! }
          While (res = mrOk) and
                Not DriveHoldsReadableData(dc) do begin
            MessageBeep(mb_IconHand);
            res := MessageDlg(Format(MyStartMsg[12], [dc]),
                              mtWarning, mbOKCancel, 0);
            end;
        end;
      If (res = mrOk) and          { Dateien in LicDataPath sind lesbar ! }
         IniFile.CopyLicenceDataFile(LicDataPath) and { DGL -> lokale DGL }
         IniFile.LoadLicenceDataFromDGLFile then begin { RegData einlesen }
        s := RegData;                          { Daten kopieren und ...   }
        RegData := DecodeRegString(s);         {     ... dekodieren !     }
        end;
      end;
    end;


  procedure InitRessources;

    procedure SafeLoadCursor(Num: Integer; CName: String);
      var CursorHandle : HCursor;
      begin
      CursorHandle := LoadCursor(HInstance, PWideChar(CName));
      If CursorHandle <> 0 then
        Screen.Cursors[Num] := CursorHandle
      else
        MessageDlg(Format(MyStartMsg[18], [CName]), mtError, [mbOk], 0);
      end;

    begin
    SafeLoadCursor(Hand_Cursor,     'HAND');
    SafeLoadCursor(Help_Cursor,     'HILFEPFEIL');
    SafeLoadCursor(Input_Cursor,    'KREUZ');
    SafeLoadCursor(Catch_Cursor,    'KREUZKREIS');
    SafeLoadCursor(Drag_Cursor,     'ZANGE');
    SafeLoadCursor(PickUp_Cursor,   'PIPETTE');
    SafeLoadCursor(Hand_FatCursor,  'HANDFETT');
    SafeLoadCursor(Input_FatCursor, 'KREUZFETT');
    SafeLoadCursor(Catch_FatCursor, 'KREUZKREISFETT');
    FUseFatCursors := False;

    ToolBMPs := TImageList.CreateSize(32, 32);
    With ToolBMPs do begin
      Masked := False;

      ResourceLoad(rtBitmap, 'PATSOLID', clWhite);         { 00 }
      ResourceLoad(rtBitmap, 'PATCLEAR', clWhite);         { 01 }
      ResourceLoad(rtBitmap, 'PATHORIZONTAL', clWhite);    { 02 }
      ResourceLoad(rtBitmap, 'PATVERTICAL', clWhite);      { 03 }
      ResourceLoad(rtBitmap, 'PATFDIAGONAL', clWhite);     { 04 }
      ResourceLoad(rtBitmap, 'PATBDIAGONAL', clWhite);     { 05 }
      ResourceLoad(rtBitmap, 'PATCROSS', clWhite);         { 06 }
      ResourceLoad(rtBitmap, 'PATDIAGCROSS', clWhite);     { 07 }
      ResourceLoad(rtBitmap, 'PATUSERDEF', clWhite);       { 08 }
      ResourceLoad(rtBitmap, 'PATSOLID', clWhite);         { 09 }

      ResourceLoad(rtBitmap, 'SHAPEFCIRCLE', clWhite);     { 10 }
      ResourceLoad(rtBitmap, 'SHAPEFSQUARE', clWhite);     { 11 }
      ResourceLoad(rtBitmap, 'SHAPEHCIRCLE', clWhite);     { 12 }
      ResourceLoad(rtBitmap, 'SHAPEHSQUARE', clWhite);     { 13 }
      ResourceLoad(rtBitmap, 'SHAPECROSS', clWhite);       { 14 }
      ResourceLoad(rtBitmap, 'SHAPEDCROSS', clWhite);      { 15 }
      ResourceLoad(rtBitmap, 'SHAPEHCIRCLETHIN', clWhite); { 16 }
      ResourceLoad(rtBitmap, 'SHAPEHSQUARETHIN', clWhite); { 17 }
      ResourceLoad(rtBitmap, 'SHAPECROSSTHIN', clWhite);   { 18 }
      ResourceLoad(rtBitmap, 'SHAPEDCROSSTHIN', clWhite);  { 19 }

      ResourceLoad(rtBitmap, 'LINESOLID', clWhite);        { 20 }
      ResourceLoad(rtBitmap, 'LINETHICK', clWhite);        { 21 }
      ResourceLoad(rtBitmap, 'LINEFAT', clWhite);          { 22 }
      ResourceLoad(rtBitmap, 'LINEDASH', clWhite);         { 23 }
      ResourceLoad(rtBitmap, 'LINEDOT', clWhite);          { 24 }
      ResourceLoad(rtBitmap, 'LINEDASHDOT', clWhite);      { 25 }

      ResourceLoad(rtBitmap, 'COLOURPOT2', clWhite);       { 26 }
      ResourceLoad(rtBitmap, 'COLOURPOT', clWhite);        { 27 }
      ResourceLoad(rtBitmap, 'BLACKPOT', clWhite);         { 28 }
      end;
    FillStyleStartIndex := 0;
    PointStyleStartIndex := 10;
    LineStyleStartIndex := 20;
    PotStartIndex := 26;
    SpBtnDataList := TSpBtnDataList.Create;
    end;  { of InitRessources }

  begin { of FormCreate }
  SpyOut('Internal module initializations done successfully', []);

  {$IFOPT R+} { Beta-Test-Version }
  ReportMemoryLeaksOnShutdown := True;   // False;
  {$ELSE}     { Ge-UPX-te End-Version für den Normal-User }
  ReportMemoryLeaksOnShutdown := False;
  {$ENDIF}

  SpacePressed      := False;
  DoubleClicked     := False;
  CoSysWasInvisible := False;
  BackInvalid       := False;
  AutoRegister      := False;
  PaintBox1.Align   := alClient;
  GlobalDefaultFont.Assign(PaintBox1.Font); { Standardwert, der nur wirksam
     wird, wenn in der Initialisierungsdatei noch kein Font eingetragen ist. }

  ScreenPPCMx        := GetDeviceCaps(PaintBox1.Canvas.Handle, LOGPIXELSX) / 2.54;
  ScreenPPCMy        := GetDeviceCaps(PaintBox1.Canvas.Handle, LOGPIXELSY) / 2.54;
  act_PixelPerXcm    := ScreenPPCMx;
  act_PixelPerYcm    := ScreenPPCMy;
  scr_TwipsPerPixel  := 1440 / (ScreenPPCMx * 2.54);

  GeoFileVersion  := Copy(EuklidLogo, 8, 3);

  SetPaths;        { setzt AutoRegister ("/R") auf TRUE, wenn noch   }
                   {   kein IniFile existiert                        }
  ProcessParams;   { setzt (falls verfügbar) LicDataPath (für "/R")  }
                   {   und initialisiert Affin (ruft Affin.create)   }
  SpyOut('  CHM Path = %s', [Application.HelpFile]);

  Drawing     := TGeoObjListe.Create(Handle, PaintBox1.Canvas, PaintBox1.ClientRect);
  Drawing.GroupList.Initialize(Handle, AlteGruppeClick, StatusBar1.ClientHeight);
  LRUList     := TLRUList.Create(DateiMenu, Ende1.MenuIndex - 1, 4, LoadLRUFile);
  GeoTimer    := TGeoTimer.GeoCreate(Self, Handle, Drawing);
  TempStrings := TStringList.Create;

  IniFile := TMyIniFile.Create(GlobalIniPath);
  If Not FileExists(GlobalIniPath) then begin
    MessageDlg(Format(MyStartMsg[19], [GlobalIniPath]), mtError, [mbOk], 0);
    Halt(1);
    end;


  //InitRegData;     { liest RegData aus der DGL-Datei ein, notfalls   }
                     { auch aus der DYNAGEO.INI                        }
  InitRessources;    { darin tief vergraben : Affin.Init()             }
  OleInitialize(NIL);
  OleDragDrop := TOleDragDrop.Create();
  RegisterDragDrop(Handle, OleDragDrop);

  SpeedBar.PageIndex  := Tabset1.TabIndex;
  TabSet1.TabHeight   := TabSet1.Height;
  TabSet1.Font.Height    := - TabSet1.Height * 3 div 4;
  StatusBar1.Font.Height := - StatusBar1.Height * 2 div 3;

  FSelStatus := 0;
  FModus     := 0;
  PrevModus  := 0;
  Selected := TList.Create;
  Start    := TObjPtrList.Create(True);

  SpyOut('Creating child forms.....', []);
  EditOptions     := TOptionsDlg.Create(Self);
  WertEingabe     := TWertEingabeDlg.Create(Self);
  KonstEingabe    := TKonstEingabeDlg.Create(Self);
         { ruft in FormCreate die Prozedur Affin.Gerade auf,
           den 1. von 3 Tests der Lizenzdaten in RegData    }
  KoordEingabe    := TKoordEingabeDlg.Create(Self);
  TermEdit        := TTermEditDlg.Create(Self);
  TempStream      := TMemoryStream.Create;
  NameEdit        := TObjNameDlg.Create(Self);
  With NameRenderWin do begin
    X := NameEdit.FormatEdit1.Width;
    Y := NameEdit.FormatEdit1.Height;
    end;

  OkayButton      := TOkayButton.Create(Self);
  ConstrTextWin   := TConstrTextWin.CreateP(Self);
  CoordDlg        := TCoordDlg.Create(Self);
  HTMLDynaGeoXDlg := THTMLDynaGeoXDataForm.Create(Self);
  HTMLDynaGeoJDlg := THTMLDynaGeoJDataForm.Create(Self);
  RangeEditWin    := TRangeEditWin.Create(Self);
  QuantPtWin      := TQuantPtWin.Create(Self);
  AniParamsWin    := TAniParamsWin.Create(Self);
  RiemannWin      := TRiemannForm.Create(Self);

  EditOptions.RealizeActualMenuCfg(True);
         { ruft Affin.Strecke auf, den 2. von
           3 Tests der Lizenzdaten in RegData }

  If SaveOptionsAllowed or UserIsAdmin then begin
    IniFile.LoadLRUList(LRUList);
    If LRUList.Count > 0 then begin
      LoadGeoFile.InitialDir := ExtractFilePath(LRUList[0]);
      SaveGeoFile.InitialDir := ExtractFilePath(LRUList[0]);
      end;
    end;

  PrinterCfgDlg := TPrinterCfgDlg.Create(Self);
  AboutBox      := TAboutBox.Create(Self);
  SelectDlg     := TSelectDlg.Create(Self);
  TextWin       := TTextWin.Create(Self);
  MakHelpDlg    := TMakHelpDlg.Create(Self);
  MakHelpWin    := TMakHelpWin.Create(Self);
  FileProps     := TFileProps.Create(Self);
  EditGroupWin  := TEditGroupWin.Create(Self);
  AddMemberWin  := TAddMemberWin.Create(Self);

  SysMemWin     := TSysMemWin.Create(Self);

  Case StartWindowState of
    0 : { behält die Standardwerte bei };
    1 : WindowState := wsMaximized;
    2 : SetBounds(StartLinks, StartOben, StartBreite, StartHoehe);
  end; { of case }

  Neu1Click(Nil); { erzeugt neue Drawing-Liste und }
         { ruft Affin.Punkt auf, den 3. von 3 Tests der Lizenzdaten
           in RegData; dort wird Affin.Ok gesetzt, das den Wert von
           Affin.IsRegged (= Not IsShareware!) bestimmt.            }
  Caption := GetCaption(MyStartMsg[8] + ActGeoFileName + MyStartMsg[9]);
  Application.Title := Caption;
  ShowMyHint(0);
  ChangeColourGlyph(SB_ObjColour,  ToolObjColour   );
  ChangeColourGlyph(SB_FillColour, ToolFillColour  );
  RefreshEditGlyph (SB_Patterns,   FillStyleStartIndex + ToolFillStyleNum);

  Application.ProcessMessages; { Nötig? Jedenfalls nicht schädlich! }
                               { Oder etwa doch?                    }
 
  //IsShareWare := (Not Affin.IsRegged) or   { Hier wird das Ergebnis der }
  //               (Not LicenceIsRunning);   {   Lizenzprüfung abgeholt   }
  //If Not IsShareWare then
  //  HilfeMenu.Remove(Registrierung1);

  UseFatCursors  := Use_Fat_Cursors; { Aus globalen Daten übernehmen ! }
  SpyOut('MainWin created successfully', []);
  SpyOut('-', ['']);
  end;


{ ======== ApplicationEvents ============================================= }

procedure THauptfenster.ApplicationEvents1Activate(Sender: TObject);
  begin
  If Assigned(Drawing) then
    Drawing.IsDoubleBuffered := Double_Buffered;
  Invalidate;
  end;

procedure THauptfenster.ApplicationEvents1Deactivate(Sender: TObject);
  begin
  If Assigned(Drawing) then
    Drawing.IsDoubleBuffered := False;
  end;


{ ========= Zugriffsmethoden für Properties ============================== }

procedure THauptFenster.SetUseFatCursors(newVal: Boolean);
  begin
  If newVal <> UseFatCursors then
    If newVal then begin
      Hand_Cursor  := 7;
      Input_Cursor := 8;
      Catch_Cursor := 9;
      FUseFatCursors := TRUE;
      end
    else begin
      Hand_Cursor  := 1;
      Input_Cursor := 3;
      Catch_Cursor := 4;
      FUseFatCursors := FALSE;
      end;
  end;

procedure THauptFenster.SetLSO(newObj: TGeoObj);
  begin
  If LastSelectedObj <> newObj then begin
    If Modus = cmd_Drag then
      GeoTimer.Reset(Drawing);
    FLastSelectedObj := newObj;
    end;
  end;

{ ============ Hilfsfunktionen ==================== }

function THauptFenster.GetCaption(s: String): String;
  begin
{$IFOPT R+}
  Result := '[ Beta ' + FullVersionString(Application.ExeName) + ' ]  ' + s
{$ELSE}
  Result := s;
{$ENDIF}
  end;

procedure THauptfenster.Check4MagnGlass;
  var i, mgIndex : Integer;
      iCenterPt  : TGPoint;
  begin
  mgIndex := -1;
  for i := 5 to Drawing.LastValidObjIndex do
    if TGeoObj(Drawing.Items[i]) is TGZoomFrame then
      mgIndex := i;
  if mgIndex < 0 then begin  // Eventuelle Reste früherer Lupen entsorgen
    MagnGlassFrame := Nil;
    // Drawing.GetLogSlider.ShowsAlways := False;
    if Assigned(MagnGlassWin) then begin
      MagnGlassWin.Close;
      FreeAndNil(MagnGlassWin);
      end
    else
      MagnGlassWin := Nil;
    end
  else begin                 // Lupen-Einrichtung vervollständigen
    Drawing.GetLogSlider.ShowsAlways := True;
    MagnGlassFrame := TGeoObj(Drawing.Items[mgIndex]) as TGZoomFrame;
    iCenterPt      := TGeoObj(MagnGlassFrame.Parent[0]) as TGPoint;
    MagnGlassWin   := TMyMagnGlassWin.CreateWD(Self, iCenterPt,
                            MagnGlassFrame.MGWin_dx, MagnGlassFrame.MGWin_dy);
    MagnGlassWin.visible := True;
    end;
  RefreshSpecialImageButtons;
  end;

procedure THauptFenster.DoLoadGeoFile(fname: String);
  { Erwartet in fname den vollen Pfad zu einer existierenden
    GEO- oder I2G-Datei und versucht, diese zu laden         }
  var ValTabData : TValTabData;
      starttime  : Cardinal;
      buf, ext   : String;
      res        : Integer;

  function ReadDataFromXMLFile: Integer;
    begin
    If (ext = '.GEO') or (ext = '.GEOX') then
      Result := GEOXMLFileLoad (fname, Drawing, ValTabData)
    else
    if ((ext = '.I2G') or (ext = '.ZIP')) then
      Result := I2GXMLFileLoad (fname, Drawing, ValTabData)
    else
      Result := 4;  // Fehler : Unbekanntes Format !
    end;

  procedure PolishNewGeoObjList;
    begin
    With Drawing do begin
      InitScale(e1x, e2y, WindowOrigin, PaintBox1.ClientRect);
      GroupList.Initialize(Handle, AlteGruppeClick, StatusBar1.ClientHeight);
      end;
    ShowCopyrightMsg;
    If Assigned(ValTabData) then begin
      FunkTabelle := TFunkTableWin.CreateWXMLD(Self, Drawing, ValTabData);
      If ValTabData.vis then
        FunkTabelle.Show;
      end;
    if (fname <> '.\Winkel_01.geo') and
       (fname <> '.\Winkel_02.geo') then begin
      ActGeoFileName := fname;
      Caption := GetCaption(MyStartMsg[8] + ActGeoFileName + MyStartMsg[9]);
      LRUList.AddItem(ActGeoFileName);
      Application.Title := Caption;
      end;
    RearrangeWindowObjects;
    Drawing.IsDirty := (ext = '.I2G') or // Legt die Konvertierung ins GEO-Format nahe!
                       (Drawing.OldAngleTermCount > 0);
    end;

  begin
  SpyOut('DoLoadGeoFile starts loading %s', [fname]);
  starttime := GetTickCount;     // Nur zur Zeitmessung beim Debuggen !
  try
    buf := '';
    Screen.Cursor := crHourGlass;
    StatusBar1.Panels[1].Text :=
      '  ' + Format(MyFileMsg[5], [fname]);
    Application.ProcessMessages;   // Fenster restaurieren lassen !
    if MagnGlassWin <> Nil then begin
      MagnGlassWin.Release;
      MagnGlassWin := Nil;
      end;
    ValTabData := Nil;
    if FunkTabelle <> Nil then begin
      FunkTabelle.Release;
      FunkTabelle := Nil;
      end;
    ext := UpperCase(ExtractFileExt(fname));
    res := ReadDataFromXMLFile;
    if res > 0 then  { Fehler ==> alte Zeichnung wird beibehalten ! }
      Case res of
         1 : buf := MyFileMsg[17];                { Größenkorrektur mißlungen }
         2 : buf := MyFileMsg[14];          { Falsche Links, Reparaturversuch }
         4 : buf := Format(MyFileMsg[16], [fname]);      { Unbekanntes Format }
         8 : buf := Format(MyFileMsg[6], [fname]);     { Datei nicht gefunden }
        16 : buf := MyFileMsg[23];                     { Kein Header gefunden }
        32 : buf := MyFileMsg[24];               { Kein Programmname gefunden }
        64 : buf := Format(MyFileMsg[28], [fname]);       { XML-Parser-Fehler }
       128 : buf := Format(MyFileMsg[32], [fname]);{ Datenfehler in der Datei }
       256 : buf := MyFileMsg[33];                  { Mysteriöser Dateifehler }
      else
        buf := MyFileMsg[15];                   { mehrere Probleme beim Laden }
      end { of case }
    else begin              { res <= 0  ==>   Abs(res) nicht geladene Objekte }
      PolishNewGeoObjList;  { ruft GeoObj.AfterLoading() auf ! }
      Check4MagnGlass;      { Wenn ein TGZoomFrame-Objekt vorhanden ist, wird }
                            { auch ein entsprechendes TMyMagnGlassWin-Objekt  }
                            { hergestellt.                                    }
      if res < 0 then
        buf := Format(MyFileMsg[34], [abs(res)]);
      end;
    If Length(buf) > 0 then
       MessageDlg(buf, mtError, [mbOk], 0);
  finally
    RefreshMakroMenu;
    RefreshMappingMenus;
    RefreshAnimationButtons;
    RefreshCheckButtons;
    RefreshSpecialImageButtons;
    StatusBar1Resize(Nil);
    Drawing.Repaint;
    Screen.Cursor := crDefault;
    FreeAndNil(ValTabData);
  end; { of try }
  SpyOut('DoLoadGeoFile is ready after %6.3f sec.', [(GetTickCount - starttime)/1000]);

  If Drawing.OldAngleTermCount > 0 then
    MessageDlg(MyFileMsg[37], mtInformation, [mbOk], 0);
  end; { of DoLoadGeoFile }


function THauptfenster.DoSaveGeoFile(DataFile: String; Check4JExp : Boolean = False): Integer;
  var ValTabData : TValTabData;
      PngStream  : TMemoryStream;

  procedure PushValueListWinData;
    var n, i : Integer;
    begin
    ValTabData.vis  := FunkTabelle.Visible;
    ValTabData.xmin := FunkTabelle.Edit1.Text;
    ValTabData.xmax := FunkTabelle.Edit2.Text;
    ValTabData.dx   := FunkTabelle.Edit3.Text;
    For i := 0 to Pred(FunkTabelle.FunkLB.Items.Count) do
      If FunkTabelle.FunkLB.Checked[i] then begin
        n := Drawing.GetGeoObjByName(FunkTabelle.FunkLB.Items[i]).GeoNum;
        If Length(ValTabData.marked) > 0 then
          ValTabData.marked := ValTabData.marked + ' ' + IntToStr(n)
        else
          ValTabData.marked := IntToStr(n);
        end;
    ValTabData.rect := FunkTabelle.BoundsRect;
    end;

  procedure LoadPicInto(PStream: TStream);
    var R      : TRect;
        BMP    : TBitmap;
        PngObj : TPngImage;
    begin
    R := PaintBox1.ClientRect;
    BMP := TBitmap.Create;
    PngObj := TPngImage.Create;
    try
      BMP.Width  := Pred(PaintBox1.ClientWidth );
      BMP.Height := Pred(Paintbox1.ClientHeight);
      Drawing.Copy2Bitmap(BMP, Point(0, 0));
      PngObj.Assign(BMP);
      PngObj.SaveToStream(PStream);
      PStream.Position := 0;
    finally
      PngObj.Free;
      BMP.Free;
    end; { of try }
    end;

  begin
  PaintBox1.Repaint;
  If Assigned(FunkTabelle) then begin
    ValTabData := TValTabData.Create;
    PushValueListWinData;
    end
  else
    ValTabData := Nil;
  If UpperCase(ExtractFileExt(DataFile)) = '.GEO' then
    Result := GeoXMLFileSave(DataFile, Drawing, ValTabData,
                             XMLOutputFormat, Check4JExp)
  else begin  //  I2G - Format!
    PngStream := TMemoryStream.Create;
    try
      LoadPicInto(PngStream);
      Result := I2GXMLFileSave(DataFile, Drawing, ValTabData, PngStream);
    finally
      PngStream.Free;
    end; { of try }
    end;
  ValTabData.Free;
  end;


{ ============== Hauptfenster-Methoden ========================= }

procedure THauptfenster.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  var // Msg,
      fname : String;
      // rt,
      i : Integer;
      // BrowserWin : TBrowserWin;
  begin
  CanClose := False;
  If Drawing.AnimationRunning then begin
    FModus         := cmd_Drag;     //  statt(?) Reset2DragMode;
    AppShouldClose := UserWants2SkipDrawing;
    end
  else begin
    If AppShouldClose or UserWants2SkipDrawing then begin
      { Neue Makros zum Exportieren anbieten }
      For i := 0 to Pred(Drawing.MakroList.Count) do
        If TMakro(Drawing.MakroList[i]).NotYetSaved and
           (MessageDlg(Format(MyMakMsg[19], [TMakro(Drawing.MakroList[i]).Name]),
                       mtWarning, [mbYes, mbNo], 0) = mrYes) and
           SaveMakFile.Execute then begin
          fname := SaveMakFile.FileName;
          If UpperCase(ExtractFileExt(fname)) <> '.MAK' then
            fname := ChangeFileExt(SaveMakFile.Filename, '.mak');
          MakXMLFileSave(fname, Drawing, i);
          TMakro(Drawing.MakroList[i]).NotYetSaved := False;
          end;

      { Shareware-Daten aktualisieren; gekillt 04.01.2016 }
      (*
      If IsShareWare then
        If SW_DaysLeft > 0 then begin
          SpyOut('SWDaysLeft = %d', [SW_DaysLeft]);
          If SW_DaysLeft < 100 then begin  { Normale Shareware }
            rt := IniFile.SaveRunTime;
            If rt >= 0 then         { Erfolgreich in INI-Datei geschrieben    }
              Msg := Format(MyStartMsg[22] + MyStartMsg[10], [rt, SW_DaysLeft])
            else                    { Kein Schreibzugriff auf die INI-Datei ? }
              Msg := Format(MyStartMsg[10], [SW_DaysLeft]);
            end
          else                             { Unbegrenzte Shareware auf CD }
            Msg := MyStartMsg[28];
          MessageDlg(Msg, mtInformation, [mbOK], 0);
          end
        else begin
          { Im "else"-Fall gibt's wenig zu tun, Message wurde schon angezeigt!
            Stattdessen zeigen wir das Bestellformular von der DynaGeo-Site:  }
          BrowserWin := TBrowserWin.CreateWD(Paintbox1,
                            'http://www.dynageo.de/auto_order.html');
          BrowserWin.ShowModal;
          BrowserWin.Free;
          end
      else
        IniFile.SaveSetupDefaults; { Führt nach dem Erlöschen einer tempo-
                                     rären Lizenz zu 60 Shareware-Tagen ab
                                     dem Ende der Gültigkeit dieser Lizenz. }
      *)

      CanClose := True;
      end;
    end;
  end;

procedure THauptfenster.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
  Action := caFree;  // 19.02.11 Defaultwert caHide überschrieben,
                     //          um Speicherfehler zu vermeiden.
  SpyOut('Prog state 12 = %8x %8x', [GetStatusCtrl(1), GetStatusCtrl(2)]);
  SpyOut('-', ['']);

  OleUnInitialize;
  OleDragDrop.Free;
  If SaveOptionsAllowed or UserIsAdmin then
    With IniFile do begin
      SaveOptions('USER');
      SaveUserCols;
      IniFile.SaveLRUList(LRUList);
      end;
  FreeAndNil(LRUList);

  SpyOut('Releasing child forms.....', []);
  if Assigned(MagnGlassWin) then
    MagnGlassWin.FormClose(Self, Action);
  If Assigned(FunkTabelle) then
    FunkTabelle.Release;
  RiemannWin.Release;
  AniParamsWin.Release;
  QuantPtWin.Release;
  RangeEditWin.Release;
  HTMLDynaGeoJDlg.Release;
  HTMLDynaGeoXDlg.Release;
  AddMemberWin.Release;
  EditGroupWin.Release;
  SysMemWin.Release;
  FileProps.Release;
  MakHelpWin.Release;
  MakHelpDlg.Release;
  TextWin.Release;
  SelectDlg.Release;
  AboutBox.Release;
  PrinterCfgDlg.Release;
  CoordDlg.Release;
  ConstrTextWin.Release;
  OkayButton.Release;
  NameEdit.Release;
  //FreeAndNil(Affin);
  FreeAndNil(TempStream);
  TermEdit.Release;
  KoordEingabe.Release;
  KonstEingabe.Release;
  WertEingabe.Release;
  EditOptions.Release;
  FreeAndNil(IniFile);
  FreeAndNil(TempStrings);
  SpyOut('All child forms successfully released', []);

  FreeAndNil(ToolBMPs);
  FreeAndNil(Selected);
  FreeAndNil(Start);
  FreeAndNil(Drawing);
  FreeAndNil(SpBtnDataList);
  FreeAndNil(GeoTimer);

  PaintBox1.OnDblClick := Nil;
  PaintBox1.OnMouseDown := Nil;
  PaintBox1.OnMouseMove := Nil;
  PaintBox1.OnMouseUp := Nil;
  PaintBox1.OnPaint := Nil;

  SpyOut('MainWin successfully released', []);
  end;

procedure THauptfenster.FormPaint(Sender: TObject);
  begin
  If IsStartUp then begin { nach der 1. Darstellung des Hauptfensters  }
    IsStartUp := False;
    AffAssPos := Point(Self.Left + Self.Width - 452, Self.Top  + 45);
    If Length(AutoLoadStr) > 0 then begin
      If Length(ExtractFilePath(AutoLoadStr)) = 0 then
        AutoLoadStr := ExpandUNCFileName(AutoLoadStr);
      DoLoadGeoFile(AutoLoadStr);
      AutoLoadStr := '';
      ShowMyHint(0);
      end;
    PaintBox1.Invalidate;
    end;
  end;

procedure THauptfenster.ShowMousePosLogCoords(mx, my : Integer);
  var spot_x,
      spot_y  : Double;
  begin
  if Assigned(Drawing) then begin
    Drawing.GetLogCoords(mx, my, spot_x, spot_y);
    StatusBar1.Panels[0].Text :=
          '  '  + FloatToStrF(spot_x, ffFixed, 10, 2) +
          ' : ' + FloatToStrF(spot_y, ffFixed, 10, 2);
    end;
  end;

procedure THauptfenster.FormShow(Sender: TObject);
  begin
  If IsStartUp then begin
    {
    If Not AutoRegister then
      AboutBox.ShowModal;
    If Not IsShareware then
      Affin.polygon(MyDragCursor, MyPickCursor,
                    MyZoomCursor, MyStopCursor);
    // PaintBox1.Update;
    }
    end;
  PaintBox1.Update;
  end;

procedure THauptfenster.FormResize(Sender: TObject);
  begin
  If Assigned(SpBtnDataList) then
    SpBtnDataList.ResizeSpeedBar(SpeedBar.Width);
  Self.SpeedBar.Invalidate;
  If Assigned(Drawing) then with Drawing do begin
    ResetDragList;
    WindowRect := PaintBox1.ClientRect;
    If (LastValidObjIndex < Count) and
       (LastValidObjIndex >= 4) then begin  // Dann gibt's zumindest ein CoSys!
      UpdateAllObjects;
      DrawFirstObjects(LastValidObjIndex);
      end;
    end;
  end;

procedure THauptfenster.FirstIdle(Sender: TObject; var Done: Boolean);
  var skip : Boolean;
  begin  { of FirstIdle }
  If Not Visible then Exit;
  ApplicationEvents1.OnIdle := FormIdle;   { Normal-Zustand herstellen }
  skip := False;

{$IFOPT R+} { Beta-Test-Version }
  {
  If Now > EncodeDate(2016, 12, 31) then begin
    MessageDlg(MyStartMsg[6], mtError, [mbOk], 0);
    skip := True;
    end;
  }
{$ELSE}
  {
  If Not FileCheckSumIsOk(Application.ExeName) then begin
    MessageDlg(MyFileMsg[7], mtError, [mbOk], 0);
    skip := True;
    end;
 }
{$ENDIF}

  If (Not skip) then
    If Not IniFile.IsUpTodate then begin
      MessageDlg(MyStartMsg[27], mtError, [mbOk], 0);
      skip := True;
      end;

  If (Not skip) and
     (EuklidLanguage <> 'DEU') then begin
    LangPath := ChangeFileExt(LangPath, '.' + EuklidLanguage);
    If Not FileExists(LangPath) then begin
      MessageDlg('Wrong language version!', mtError, [mbOk], 0);
      Skip := True;
      end;
    end;

  If (Not Skip) and
     (Not AutoRegister) and
     IsShareWare then begin
    SW_DaysLeft := 60; // IniFile.TimeCheck;
                       // ShareWareNag killed 04.01.2016
    SpyOut('SWDaysLeft = %d', [SW_DaysLeft]);
    Case SW_DaysLeft of
       0,
      -1 : { Shareware-Test-Zeit abgelaufen }
           If UserIsAdmin then begin
             If MessageDlg(MyStartMsg[20],
                           mtInformation,
                           [mbYes, mbNo], 0) = mrYes then
               Registrierung1Click(Self);
             Skip := IsShareWare;
             end
           else begin
             MessageDlg(MyStartMsg[23], mtInformation, [mbOk], 0);
             Skip := True;
             end;
      -2 : begin          { Crack-Versuch ? }
           MessageDlg(MyStartMsg[21], mtError, [mbOk], 0);
           Skip := True;
           end;
      -3 : begin          { CD-Version auf falscher CD }
           MessageDlg(MyStartMsg[29], mtError, [mbOk], 0);
           Skip := True;
           end;
    else
      MyPickCursor  := #$D6;
      MyCatchCursor := #$3C;
    end; { of case }
    end; { of then }

  If Skip then begin
    AppShouldClose := True;    { Aussteigen !!! }
  (*
  else begin
    If IsShareWare then
      If Not AutoRegister then
        If SW_DaysLeft = 1007 then  // CD-Viewer-Spezial-Version (Eder, Widl, Heime)
          MessageDlg(MyStartMsg[28], mtInformation, [mbOK], 0)
        else
          LizenzBedingungen1Click(TabSet1)
      else
    else
      Affin.dreieck(MyMoveCursor, MyHelpCursor,
                    MyInputCursor, MyCatchCursor);

    if EuklidLanguage <> 'DEU' then
      InitShortCuts(EuklidLanguage);
  *)
    SpyOut('Prog state 01 = %8x %8x', [LizenzNr, GetStatusCtrl(1)]);
    Update;
    end;
  end; { of FirstIdle }

procedure THauptfenster.FormIdle(Sender: TObject; var Done: Boolean);
  begin
  If BackInvalid and
     (((Modus = cmd_Drag) and (OLineMode = 0)) or
      (Modus in [cmd_MoveName, cmd_EditDraw, cmd_ToggleVis, cmd_Slide])) then begin
    PaintBox1Paint(Sender);
    BackInvalid := False;
    end;
  If AppShouldClose and Not AboutBox.Visible then begin
    AppShouldClose := False;
    Application.Terminate;   // statt: Close;  ( Warum auch immer! )
    end;
  end;

procedure THauptfenster.FormInvalidate(Sender: TObject);
  begin
  If Assigned(PaintBox1) then
    PaintBox1.Invalidate;
  end;

procedure THauptfenster.PaintBox1Paint(Sender: TObject);
  begin
  if Assigned(Drawing) then
    If Modus = cmd_ShowGrowth then
      Drawing.DrawFirstObjects(Last2Show, Last2Show <= 5)
    else
      Drawing.DrawFirstObjects(Drawing.LastValidObjIndex, True);
  end;

{ ============ Werkzeugleisten - Hilfsprozeduren ============== }

procedure THauptfenster.AdjustToolMode(new_Mode: Integer);
  { Schaltet auf diejenige Tool-Leiste um, die den ToolButton zum neuen
    Befehl enthält; gibt es keinen solchen Button, wird nicht umgeschaltet.
    Außerdem sichert die Prozedur, dass der zum Befehl gehörende
    SpeedButton gedrückt wird bzw. gedrückt bleibt.                        }
  var NewBar : Integer;
  begin
  NewBar := SpBtnDataList.GetToolPageFromCommand(new_Mode);
  If NewBar >= 0 then begin
    TabSet1.TabIndex := NewBar; { PROBLEM: Ruft indirekt Reset2DragMode auf ! }
    LastSpeedButton := SpBtnDataList.GetSpeedBtnFromCommand(new_Mode);
    end;
  If LastSpeedButton <> Nil then
    LastSpeedButton.Down := True;
  end;

procedure THauptfenster.TabSet1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
  var FillStyle : TBrushStyle;
  begin
  If SpacePressed then
    AllowChange := False
  else
    AllowChange := UserWants2Break4(cmd_Drag);
  SpacePressed := False;
  If AllowChange and (NewTab = index_EditDraw) then begin
    If Drawing.HasEmptyBorders then begin
      Drawing.GetFreeFillPattern(ToolFillColour, FillStyle);
      ToolFillStyleNum := Integer(FillStyle);
      RefreshEditGlyph(SB_Patterns, FillStyleStartIndex + ToolFillStyleNum);
      end;
    ChangeColourGlyph(SB_FillColour, ToolFillColour);
    ChangeColourGlyph(SB_ObjColour,  ToolObjColour );
    end;
  end;

procedure THauptfenster.TabSet1Click(Sender: TObject);
  begin
  AutoRepeat := False;   { Automatischer Abbruch der AutoRepeat-Funktion }
  Reset2DragMode;
  SpeedBar.PageIndex := Tabset1.TabIndex;
  end;

procedure THauptfenster.TabSet1DrawTab(Sender: TObject;
                          TabCanvas: TCanvas; R: TRect;
                          Index: Integer; Selected: Boolean);
  begin
  With TabCanvas do begin
    If Selected then begin
      Font.Color := GetTextCol(clBlack, TabSet1.SelectedColor);   { früher: clBlack }
      TextOut(R.left, R.top, TabSet1.Tabs[Index]);
      end
    else begin
      Font.Color := GetTextCol(clWhite, TabSet1.UnselectedColor); { früher: clWhite }
      TextOut(R.left, R.top + 2, TabSet1.Tabs[Index]);
      end;
    end;
  end;

procedure THauptfenster.LinesMenuMeasureItem(Sender: TObject; ACanvas: TCanvas;
  var Width, Height: Integer);
  begin
  Width  := 80;
  Height := 20;
  end;

procedure THauptfenster.LinesMenuDrawItem(Sender: TObject; ACanvas: TCanvas;
                                          ARect: TRect; Selected: Boolean);
  begin
  With ACanvas do begin
    Pen.Width   := 1;
    Pen.Style   := psClear;
    Brush.Style := bsSolid;
    If Selected then begin
      Brush.Color := clHighLight;
      Pen.Color   := clHighLightText;
      end
    else begin
      Brush.Color := clBtnFace;
      Pen.Color   := clBlack;
      end;
    With ARect do begin
      Inc(Left, 3); Dec(Right, 3);
      Rectangle(Left, Top, Right, Bottom);
      end;

    Case TMenuItem(Sender).MenuIndex of
      0 : Pen.Style := psSolid;
      1 : begin
          Pen.Style := psSolid;
          Pen.Width := 3;
          end;
      2 : begin
          Pen.Style := psSolid;
          Pen.Width := 5;
          end;
      3 : Pen.Style := psDash;
      4 : Pen.Style := psDot;
      5 : Pen.Style := psDashDot;
    end;
    With ARect do begin
      MoveTo(Left  + 5, Pred(Top) + (Bottom - Top) div 2);
      LineTo(Right - 6, Pred(Top) + (Bottom - Top) div 2);
      end;
    end;
  end;

procedure THauptfenster.ShowPopupNearButton(Menu: TPopupMenu; Button: TSpeedButton);
  var spot : TPoint;
  begin
  With Button do begin
    spot.x := Left + Width Div 2;
    spot.y := Top + Height Div 2;
    end;
  spot := SpeedBar.ClientToScreen(spot);
  Menu.Popup(spot.x, spot.y);
  end;

procedure THauptfenster.SB_LineStyleClick(Sender: TObject);
  begin
  ShowPopupNearButton(LinesMenu, TSpeedButton(Sender));
  end;

procedure THauptfenster.SB_PatternsClick(Sender: TObject);
  begin
  ShowPopupNearButton(PatternsMenu, TSpeedButton(Sender));
  end;

procedure THauptfenster.SB_PointShapeClick(Sender: TObject);
  begin
  ShowPopupNearButton(ShapeMenu, TSpeedButton(Sender));
  end;

procedure THauptfenster.SB_ColourClick(Sender: TObject);
  begin
  If Sender = SB_FillColour then
    ActColorDialog.Color := ToolFillColour
  else
    ActColorDialog.Color := ToolObjColour;
  If ActColorDialog.Execute then
    If Sender = SB_FillColour then begin
      ToolFillColour := ActColorDialog.Color;
      ChangeColourGlyph(SB_FillColour, ToolFillColour);
      InitInputList(cmd_FillArea, Sender);
      end
    else begin
      ToolObjColour := ActColorDialog.Color;
      ChangeColourGlyph(SB_ObjColour, ToolObjColour);
      InitInputList(cmd_EditDraw, Sender);
      end
  else
    Reset2DragMode;
  end;

procedure THauptfenster.ChangeColourGlyph(ColBtn: TSpeedButton; NewCol: TColor);
  var PotBMP,
      ColPotBMP : TBitmap;
      Rect      : TRect;
  begin
  ColPotBMP := TBitMap.Create;
  ColPotBMP.Width   := 32;
  ColPotBMP.Height  := 32;
  If NewCol <> clBlack then begin
    PotBMP := TBitMap.Create;
    PotBMP.Width   := 32;
    PotBMP.Height  := 32;
    Rect := Bounds(0, 0, 32, 32);
    ToolBMPs.GetBitmap(PotStartIndex + 1, PotBMP);
    If ColDist(NewCol, PotBMP.TransparentColor) < 32 then
      ToolBMPs.GetBitmap(PotStartIndex, PotBMP);
    With ColPotBMP.Canvas do begin
      Brush.Color := NewCol;
      Brush.Style := bsSolid;
      BrushCopy(Rect, PotBMP, Rect, clWhite);
      Refresh;
      end;
    PotBMP.Free;
    end
  else
    ToolBMPs.GetBitMap(PotStartIndex + 2, ColPotBMP);
  ColBtn.Glyph := ColPotBMP;
  ColBtn.Repaint;
  ColPotBMP.Free;
  end;

procedure THauptFenster.RefreshEditGlyph(Button: TSpeedButton; Index: Integer);
  var BMP : TBitmap;
  begin
  BMP := TBitMap.Create;
  BMP.Width  := 32;
  BMP.Height := 32;
  ToolBMPs.GetBitmap(Index, BMP);
  Button.Glyph := BMP;
  Button.Repaint;
  BMP.Free;
  end;

procedure THauptfenster.ChangeLineStyleClick(Sender: TObject);
  begin
  ToolLineStyleNum := TMenuItem(Sender).MenuIndex;
  RefreshEditGlyph(SB_LineStyle, LineStyleStartIndex + ToolLineStyleNum);
  If Modus = cmd_EditLineStyle then begin
    With TGLine(ActPopupObj) do
      SetGraphTools(ToolLineStyleNum, 0, 0, MyColour);
    Drawing.Repaint;
    Reset2DragMode;
    end
  else
    InitInputList(cmd_EditDraw, Sender);
  end;

procedure THauptfenster.ChangeShapeClick(Sender: TObject);
  begin
  ToolPointStyleNum := TMenuItem(Sender).MenuIndex;
  RefreshEditGlyph(SB_PointShape, PointStyleStartIndex + ToolPointStyleNum);
  If Modus = cmd_EditPointStyle then begin
    With TGPoint(ActPopupObj) do
      SetGraphTools(0, ToolPointStyleNum, 0, MyColour);
    Drawing.Repaint;
    Reset2DragMode;
    end
  else
    InitInputList(cmd_EditDraw, Sender);
  end;

procedure THauptfenster.ChangePatternClick(Sender: TObject);
  begin
  ToolFillStyleNum := TMenuItem(Sender).MenuIndex;
  RefreshEditGlyph(SB_Patterns, FillStyleStartIndex + ToolFillStyleNum);
  If Modus = cmd_EditPattern then begin
    With TGPolygon(ActPopupObj) do
      SetGraphTools(0, 0, ToolFillStyleNum, MyColour);
    Drawing.Repaint;
    Reset2DragMode;
    end
  else
    InitInputList(cmd_FillArea, Sender);
  end;

procedure THauptfenster.GetActGraphToolsFrom(GO: TGeoObj);
  var ActColour : TColor;
  begin
  GO.GetGraphTools(ToolLineStyleNum, ToolPointStyleNum, ToolFillStyleNum, ActColour);
  RefreshEditGlyph(SB_LineStyle, LineStyleStartIndex + ToolLineStyleNum);
  RefreshEditGlyph(SB_PointShape, PointStyleStartIndex + ToolPointStyleNum);
  RefreshEditGlyph(SB_Patterns, FillStyleStartIndex + ToolFillStyleNum);
  If GO is TGArea then begin
    ToolFillColour := ActColour;
    ChangeColourGlyph(SB_FillColour, ToolFillColour);
    InitInputList(cmd_FillArea, SB_FillArea);
    end
  else begin
    ToolObjColour := ActColour;
    ChangeColourGlyph(SB_ObjColour, ToolObjColour);
    InitInputList(cmd_EditDraw, SB_EditObj);
    end;
  end;

procedure THauptfenster.RefreshAnimationButtons;
  var vis : Boolean;
  begin
  If Drawing.AnimationPossible then
    If TabSet1.Tabs.Count < Succ(index_Animation) then
      TabSet1.Tabs.Add(MyStartMsg[26])
    else
  else
    If TabSet1.Tabs.Count = Succ(index_Animation) then
      TabSet1.Tabs.Delete(index_Animation);

  vis := Drawing.AnimationSource <> Nil;
  SB_AniFastBK.Visible := vis;
  SB_AniGoBK.Visible   := vis;
  SB_AniStop.Visible   := vis;
  SB_AniGoFD.Visible   := vis;
  SB_AniFastFD.Visible := vis;
  end;

procedure THauptfenster.RefreshCheckButtons;
  var CCO : TGCheckControl;
  begin
  CCO := Drawing.CheckControl as TGCheckControl;
  If Assigned(CCO) and (Length(CCO.VTermStr) > 0) then begin  // Werkzeug-Button
    SB_CheckSolution.Visible := True;
    SB_CheckSolution.Enabled := True;
    end
  else begin
    SB_CheckSolution.Visible := False;
    SB_CheckSolution.Enabled := False;
    end;
  KorrektheitsPrfung1.Enabled := SB_CheckSolution.Enabled;  // Menü-Item
  end;

procedure THauptfenster.RefreshSpecialImageButtons;
  var SQO : TGeoObj;
  begin
  If Abs(act_PixelPerXcm - act_PixelPerYcm) < epsilon then begin
    SB_SetSquare.Enabled := True;
    SB_Setsquare.Down    := Drawing.HasSetsquare(SQO);
    Geodreieckanzeigenverbergen1.Enabled := True;
    end
  else begin
    If Drawing.HasSetsquare(SQO) then
      Drawing.FreeObject(SQO);
    SB_SetSquare.Down    := False;
    SB_SetSquare.Enabled := False;
    Geodreieckanzeigenverbergen1.Enabled := False;
    end;
  If Abs(act_PixelPerXcm - act_PixelPerYcm) < epsilon then begin
    SB_Glass.Enabled := True;
    SB_Glass.Visible := True;
    If (MagnGlassWin <> Nil) or (Modus = cmd_MagnGlass) then begin
      SB_Glass.Down         := True;
      // TB_ZoomSlider.Visible := True;
      end
    else begin
      SB_Glass.Down         := False;
      // TB_ZoomSlider.Visible := False;
      end
    end
  else begin
    SB_Glass.Enabled      := False;
    // TB_ZoomSlider.Visible := False;
    end;
  end;

procedure THauptfenster.SB_Scroll_LeftClick(Sender: TObject);
  begin
  SpBtnDataList.ScrollLeft(TabSet1.TabIndex);
  end;

procedure THauptfenster.SB_Scroll_RightClick(Sender: TObject);
  begin
  SpBtnDataList.ScrollRight(TabSet1.TabIndex);
  end;

procedure THauptfenster.RefreshMappingMenus;
  var nmi,
      nmi2 : TMenuItem;
      i    : Integer;
  begin
  { Zunächst lokales Menü des "Abbildung anwenden"-Knopfes aktualisieren: }
  nmi := Nil;
  MappingsMenu.Items.Clear;
  For i := 0 to Drawing.LastValidObjIndex do
    If TGeoObj(Drawing.Items[i]) is TGTransformation then begin
      nmi := TMenuItem.Create(MappingsMenu);
      nmi.Caption := HTMLKillAllTags(TGTransformation(Drawing[i]).GetInfo);
      nmi.Tag := TGTransformation(Drawing[i]).GeoNum;
      nmi.OnClick := AbbildungaufObjAnwenden1Click;
      MappingsMenu.Items.Add(nmi);
      end;
  SB_MapObj.Enabled := nmi <> Nil;
  SB_MapObj.Visible := nmi <> Nil;

  { Dann die Untermenüs im Hauptmenü "Abbilden" aktualisieren: }
  nmi  := Nil;
  nmi2 := Nil;
  AbbildungAufObjAnwenden1.Clear;
  AbbildungEditieren1.Clear;
  For i := 0 to Drawing.LastValidObjIndex do
    If TGeoObj(Drawing.Items[i]) is TGTransformation then begin
      nmi := TMenuItem.Create(AbbildungaufObjAnwenden1);
      nmi.Caption := HTMLKillAllTags(TGTransformation(Drawing[i]).GetInfo);
      nmi.Tag := TGTransformation(Drawing[i]).GeoNum;
      nmi.OnClick := AbbildungaufObjAnwenden1Click;
      AbbildungAufObjAnwenden1.Add(nmi);
      If TGeoObj(Drawing.Items[i]) is TGMatrixMap then begin  // hier keine Kreis-Spiegelung!
        nmi2 := TMenuItem.Create(AbbildungEditieren1);
        nmi2.Caption := HTMLKillAllTags(TGTransformation(Drawing[i]).GetInfo);
        nmi2.Tag := TGTransformation(Drawing[i]).GeoNum;
        nmi2.OnClick := AbbildungEditieren1Click;
        AbbildungEditieren1.Add(nmi2);
        end;
      end;
  AbbildungAufObjAnwenden1.Enabled := nmi <> Nil;
  AbbildungEditieren1.Enabled := nmi2 <> Nil;
  end;

procedure THauptfenster.Abbilden1Click(Sender: TObject);
  begin
  RefreshMappingMenus;
  end;


{ ================ Gruppen-Verwaltung ===================== }

procedure THauptfenster.NeueGruppeClick(Sender: TObject);
  var NG : TGeoGroup;  { "N"eue "G"ruppe }
  begin
  NG := TGeoGroup.Create(Drawing, Drawing.GroupList.GetFreeGroupId, AlteGruppeClick);
  InitInputList(cmd_EditGroup, Nil);
  EditGroupWin.InitWith(Handle, Drawing, NG);
  EditGroupWin.Show;
  end;

procedure THauptfenster.AlteGruppeClick(Sender: TObject);
  var s : String;
      n : Integer;
  begin
  s := (Sender as TMenuItem).Caption;
  DeleteChars('&', s);
  n := 0;
  While (n < Drawing.GroupList.Count) and
        (s <> TGeoGroup(Drawing.GroupList.Items[n]).comment) do
    n := n + 1;
  If n < Drawing.GroupList.Count then begin
    InitInputList(cmd_EditGroup, Nil);
    EditGroupWin.InitWith(Handle, Drawing, Drawing.GroupList[n]);
    EditGroupWin.Show;
    end
  else   { Gruppe nicht gefunden }
    MessageDlg(Format(MyMess[78], [s]), mtError, [mbOk], 0);
  end;

procedure THauptfenster.OnGroupWinClose(var Msg: TMessage);
  begin
  Case Msg.WParam of
    mrYes : begin
            InitInputList(cmd_group, Nil);
            GeoTimer.InitObjBlinking(Drawing);
            AddMemberWin.Show;
            end;
    mrOk  : begin  { Schließen ohne Objektbestand zu ändern }
            StatusBar1.Invalidate;
            Reset2DragMode;
            end;
  else
    Reset2DragMode;
  end; { of case }
  end;

procedure THauptFenster.RebuildGroupMenu;
  var LMI : TMenuItem;
      n   : Integer;
  begin
  If Assigned(ObjekteGruppieren1) then begin
    While ObjekteGruppieren1.Count > 2 do
      ObjekteGruppieren1.Delete(0);
    If ObjekteGruppieren1.Count = 1 then
      ObjekteGruppieren1.Insert(0, NewLine);
    For n := Pred(Drawing.GroupList.Count) DownTo 0 do
      ObjekteGruppieren1.Insert(0, TGeoGroup(Drawing.GroupList[n]).MenuItem);
    LMI := TMenuItem(ObjekteGruppieren1.Items[0]);
    If LMI.IsLine then begin
      ObjekteGruppieren1.Delete(0);
      LMI.Free;
      end;
    end;
  end;


{======= StatusBar - Verwaltung ================================}

procedure THauptfenster.StatusBar1Resize(Sender: TObject);
  var n : Integer;
  begin
  If Assigned(Drawing) then begin
    n := Drawing.GroupList.GetIconsWidth;
    If n > 0 then
      n := n + 6 + StatusBar1.Height;
    StatusBar1.Panels[2].Width := n;
    end
  else
    StatusBar1.Panels[2].Width := 0;
  With Statusbar1 do begin
    Panels[1].Width := SpeedBar.ClientWidth - Panels[0].Width - Panels[2].Width;
    Invalidate;
    end;
  end;

procedure THauptfenster.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
  { Hier muß nur Code für die Ausgabe ins 2. und 3. Feld stehen
    (Index 1 und 2), da bei Ausgaben ins erste Feld (Index 0)
    diese Routine garnicht aufgerufen wird:
    StatusBar1.Panels[0].Style = gsText !!!   }

  var FT : TFormatText;
      Sel: TSelection;
      HintFont : TFormatFont;
      HintRect : TRect;
      i : Integer;
  begin
  If Panel = StatusBar1.Panels[1] then
    If Modus = cmd_ShowGrowth then begin
      HintRect := Rect;
      HintRect.Left := HintRect.Left + 4;
      HintRect.Top  := HintRect.Top - 1;
      FT := TFormatText.Create(TempStrings, HintRect, StatusBar.Canvas);
      HintFont := TFormatFont.Create(StatusBar1.Font);
      try
        Sel.Start := Point(0,  0);
        Sel.Ende  := Point(0, FT.CharactersInLine(0));
        FT.ChangeFont(Sel, HintFont, [fcSize]);
        FT.Paint;
      finally
        HintFont.Free;
        FT.Free;
      end; { of try }
      end;
  If Panel = StatusBar1.Panels[2] then begin
    If Drawing.GroupList.Count > 0 then
      For i := 0 to Pred(Drawing.GroupList.Count) do
        TGeoGroup(Drawing.GroupList[i]).DrawIt(StatusBar.Canvas, Rect, i);
    end;
  end;

procedure THauptfenster.StatusBar1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  var n : Integer;
  begin
  Statusbar1.Tag := -1;
  For n := 0 to Pred(Drawing.GroupList.Count) do
    If TGeoGroup(Drawing.GroupList[n]).IsMoused(X, Y) then
      StatusBar1.Tag := n;
  If Statusbar1.Tag >= 0 then
    GeoTimer.InitShowGroupName(Statusbar1.Tag);
  end;

procedure THauptfenster.StatusBar1Click(Sender: TObject);
  begin
  If StatusBar1.Tag >= 0 then
    Drawing.GroupList.ToggleGroupVis(StatusBar1.Tag);
  Drawing.DrawFirstObjects(Drawing.LastValidObjIndex, True);
  end;

procedure THauptfenster.StatusBar1DblClick(Sender: TObject);
  begin
  { später }
  end;

{ =========== Interne Hilfsprozeduren ============ }

procedure THauptfenster.ClearInitialDirs(Sender: TObject);
  begin
  If Sender is TOpenDialog then
    TOpenDialog(Sender).InitialDir := ''
  else
  If Sender is TSaveDialog then
    TSaveDialog(Sender).InitialDir := '';
  end;

function THauptFenster.GetContextHelpIndex : Integer;
  var mpos,
      wndmpos : TPoint;
      GCHI,
      i       : Integer;
      SB      : TSpeedButton;

  function TabSetHelpId : Integer;
    begin
    Case TabSet1.TabIndex of
      0 : Result := idh_tool_main;
      1 : Result := idh_tool_constr;
      2 : Result := idh_tool_map;
      3 : Result := idh_tool_curv;
      4 : Result := idh_tool_form;
      5 : Result := idh_tool_meas;
      6 : Result := idh_tool_ani;
    else
      Result := idh_helpcontents;
    end; { of case }
    end;

  begin
  GCHI := idh_helpcontents;   { Default-Wert }
  If Modus > 10 then
    GCHI := Modus
  else begin  { also im Zugmodus (im Wesentlichen) ! }
    GetCursorPos(mpos);
    wndmpos := SpeedBar.ScreenToClient(mpos);
    If PtInRect(SpeedBar.ClientRect, wndmpos) then begin
      GCHI := TabSetHelpId;
      For i := Pred(ComponentCount) downto 0 do
        If (Components[i] Is TSpeedButton) then begin
          SB := TSpeedButton(Components[i]);
          With SpBtnDataList do
            If SB.Visible and
               (GetToolPageFromSpeedBtn(SB) = SpeedBar.PageIndex) and
               (wndmpos.x > SB.left) and
               (wndmpos.x < SB.left + SB.width) then
              GCHI := GetHelpIdFromSpeedBtn(SB);
          end;
      end
    else
      If PtInRect(TabSet1.ClientRect, TabSet1.ScreenToClient(mpos)) then
        GCHI := TabSetHelpId;
    end;
  GetContextHelpIndex := GCHI;
  end;

procedure THauptfenster.ShowSelectionFrame;
  begin
  If SelStatus = 3 then with PaintBox1.Canvas do begin
    Pen.Mode    := pmNotXOR;
    Pen.Color   := clRed;
    Pen.Style   := psDash;
    Brush.Style := bsClear;
    With FSelRect do
      Rectangle(Left, Top, Right, Bottom);
    Pen.Mode    := pmCopy;
    end;
  end;

procedure THauptfenster.DeleteSelectionFrame;
  begin
  If FSelStatus = 3 then
    PaintBox1.Invalidate;
  FSelStatus  := 0;
  end;

procedure THauptfenster.ShowCopyrightMsg;
  begin
  If (Drawing <> Nil) then
    If (Drawing.CRText <> Nil) and
       (Drawing.CRText.Count > 0) then begin
      Drawing.ShowingCRText := True;
      Drawing.DrawFirstObjects(-1, True);
{$IFOPT R+} { für Beta-Test-Version }
      Wait( 500);
{$ELSE}     { für endgültige Edition }
      Wait(4000);
{$ENDIF}
      Drawing.ShowingCRText := False;
      Drawing.UpdateAllObjects;
      Drawing.DrawFirstObjects(Drawing.LastValidObjIndex, True);
      end
    else
      Drawing.UpdateAllObjects;
  end;

procedure THauptfenster.RearrangeWindowObjects;
  { 06.04.2012 : Aufgrund eines Bug-Reports von Martin Heime (Programmierer
                 von Eder/Widl) wurde ein Test hinzugefügt, ob das Fenster-
    Handle schon gültig ist, so dass bei Windows Daten des Fensters abge-
    fragt werden können. Speziell beim Doppelklick auf eine GEO-Datei
    scheint i.A. das Handle noch nicht verfügbar zu sein. In diesem Fall
    wird auf das Umordnen der Objekte im aktuellen Fenster verzichtet.     }
  var WinRect,
      ScrRect : TRect;
      AMCWidth,    {A_ctive M_onitor C_lient Width  }
      AMCHeight,   {A-ctive M_onitor C_lient Height }
      n   : Integer;
  begin
  if (Handle > 0) and (Handle < $FFFFFFFF) then begin    {*}
    With Screen.MonitorFromWindow(Handle) do begin
      AMCWidth  := WorkAreaRect.Right - WorkAreaRect.Left;
      AMCHeight := WorkAreaRect.Bottom - WorkAreaRect.Top;
      end;
    AMCWidth  := AMCWidth  - (Width  - PaintBox1.ClientWidth );
    AMCHeight := AMCHeight - (Height - PaintBox1.ClientHeight);
    WinRect := PaintBox1.ClientRect;
    ScrRect := Rect(0, 0, Pred(AMCWidth), Pred(AMCHeight));
    WinRect := Shrink(WinRect, 10);
    ScrRect := Shrink(ScrRect, 10);
    n := Drawing.CountWinObjsOutside(WinRect, ScrRect);
    If n > 0 then begin               { Objekte außerhalb des Fullscreen-Fenster }
      MessageDlg(MyMess[48], mtInformation, [mbOk], 0);
      Drawing.MoveWinObjsInside(ScrRect);
      Drawing.Repaint;
      end
    else if n < 0 then     { Objekte außerhalb des aktuellen Fensters, aber für  }
      MessageDlg(MyMess[49], mtInformation, [mbOk], 0); { Fullscreen erreichbar !}
    end;
  end;


procedure THauptfenster.DisableCommand(cmd : Integer);
  var i  : Integer;
      SB : TSpeedButton;
  begin
  If UserIsAdmin and (cmd = cmd_Options) then
    Exit;  { Für Administratoren keine verriegelten Menü-Konfigurationen !
             Hier bleiben die "Einstellungen" *immer* zugänglich !         }
  For i := 0 to Pred(ComponentCount) do
    If (Components[i] Is TMenuItem) then
      with TMenuItem(Components[i]) do
        If HelpContext = cmd then
          Enabled := False
        else
    else
    If (Components[i] Is TSpeedButton) then begin
      SB := TSpeedButton(Components[i]);
      If SpBtnDataList.GetCommandFromSpeedBtn(SB) = cmd then
        SB.Enabled := False;
      end;
  end;

procedure THauptfenster.EnableAllCommands;
  var i : Integer;
  begin
  For i := Pred(ComponentCount) downto 0 do
    If (Components[i] Is TMenuItem) then
      TMenuItem(Components[i]).Enabled := True
    else
    If (Components[i] Is TSpeedButton) then
      TSpeedButton(Components[i]).Enabled := True;
  RefreshCheckButtons;
  end;

procedure THauptfenster.DisableCmdsThatBotherGames;
  var i, j, k,
      cmd    : Integer;
      write  : Boolean;
  begin
  // Clear the array C2DAPG ('C'ommands'2D'elete'A'fter'P'laying'G'ames)
  for i := 0 to Length(C2DAPG) - 1 do
    C2DAPG[i] := 0;
  // Register the actual command configuration by writing all disabled commands
  //   into the array C2DAPG ('C'ommands'2D'elete'A'fter'P'laying'G'ames)
  j := 0;
  For i := Pred(ComponentCount) downto 0 do begin
    // Get the commandIds of disabled commands from the form's components
    cmd := 0;
    If ( (Components[i] Is TMenuItem) and (not TMenuItem(Components[i]).Enabled) ) then
      cmd := TMenuItem(Components[i]).HelpContext
    else
    if ( (Components[i] Is TSpeedButton) and (not TSpeedButton(Components[i]).Enabled) ) then
      cmd := SpBtnDataList.GetCommandFromSpeedBtn(TSpeedButton(Components[i]));
    // Verify that the command is not registered already
    write := True;
    for k := j-1 downto 0 do
      if C2DAPG[k] = cmd then write := False;
    // Write the command into the list that will be used to restore
    //   the old command configuration after the end of the game
    if write then begin
      C2DAPG[j] := cmd;
      j := j + 1;
      end;
    end;
  // Switch to the temporary command configuration for games; this is stored
  //    in the Array C2DBPG ('C'ommand'2D'elete'B'efore'P'laying'G'ames)
  EnableAllCommands;
  for i := 0 to 35 do
    DisableCommand(C2DBPG[i]);
  end;

procedure THauptfenster.RestorePreviousCmdSet;
  var i, cmd : Integer;
  begin
  EnableAllCommands;
  for i := 0 to 99 do begin
    cmd := C2DAPG[i];
    if (cmd > 0) and (cmd < 500) then
      DisableCommand(cmd);
    C2DAPG[i] := 0; // Reset the processed items (just to be on the safe side)
    end;
  end;

function  THauptfenster.IsAltCmd(Sender: TObject): Boolean;
  begin
  Result := (Sender is TSpeedButton) and (ssAlt in LastShiftState);
  end;

procedure THauptfenster.ShowMyHint(HintId : Integer);
  var msg : String;
      i,
      MCN : Integer;
  begin
  LastHintTextNum := HintId;
  If HintId >= 0 then begin
    if (HintId = 0) then begin
      if (Angles1Dlg <> Nil) then       // Game01 is running...
        msg := MyHint[114]
      else if (Angles2Dlg <> Nil) then  // Game02 is running...
        msg := MyHint[115]
      else
        msg := MyHint[0]       // This is the normal case.
      end
    else
      if (PreselectedObj <> Nil) then  // Preselected object registered
        msg := msg + Format(MyHint[60], [PreselectedObj.Name])
      else
        msg := MyHint[HintId]; // This is the normal case.
    end
  else begin   { Hinweise zur Laufzeit von Makros: HintId < 0 }
    MCN := Succ(MaCmdNum);
    For i := 0 to MaCmdNum do
      If TMakroCmd(TMakro(Drawing.MakroList[MakroNum]).Items[i]).CmdType < 0 then
        Dec(MCN);
    msg := IntToStr(MCN);
    Case HintId of
      -1 : msg := msg + MyMakMsg[0] + MyMakMsg[1];  { Punkt                 }
      -2 : msg := msg + MyMakMsg[0] + MyMakMsg[2];  { Strecke               }
      -3 : msg := msg + MyMakMsg[0] + MyMakMsg[3];  { Gerade (oder Strecke) }
      -4 : msg := msg + MyMakMsg[0] + MyMakMsg[4];  { Kreis                 }
      -5 : begin                                    { Polygon               }
           i := TMakroCmd(TMakro(Drawing.MakroList[MakroNum]).Items[MaCmdNum]).ProtoTyp.Parent.Count;
           msg := msg + MyMakMsg[0] + Format(MyMakMsg[5], [i])
           end;
      -6 : msg := msg + MyMakMsg[0] + MyMakMsg[6];  { Kegelschnitt          }
      -7 : msg := msg + MyMakMsg[0] + MyMakMsg[7];  { Zahlobjekt            }
    end; { of case }
    end;
  StatusBar1.Panels[1].Text := '  ' + msg;
  end;

procedure THauptfenster.ShowHTMLHint(s: String);
  begin
  TempStrings.Clear;
  TempStrings.Add(MyHint[22] + s);
  StatusBar1.Repaint;
  end;

procedure THauptfenster.Reset2DragMode;
  var rep_cmd, n : Integer;
  begin
  SpBtnDataList.UpperAllButtons;    { Alle Knöpfe deaktivieren          }
  If (Modus = cmd_Drag) and
     (OLineMode = 0)then Exit;      { Unnötige Doppel-Aufrufe vermeiden }
  GeoTimer.Reset(Drawing);  { vorsichtshalber immer, um in den Objekten }
                            { das IsBlinking-Flag sicher zu löschen     }
  If LastSpeedButton = Nil then
    LastSpeedButton := SpBtnDataList.GetSpeedBtnFromCommand(Modus);

  If OLineMode > 0 then begin
    With Drawing do
      While (TGeoObj(Items[LastValidObjIndex]) is TGLocLine) and
            (TGLocLine(Items[LastValidObjIndex]).Points.Count <= 2) do
        FreeObject(Items[LastValidObjIndex]);
    OkayButton.Hide;
    SB_MakeTrace.Down := False;
    PaintBox1Paint(Self);
    OLineMode := 0;
    end;

  If MakroMode > 0 then begin
    With Drawing.MakroList do
      If Count > MakroMenu.Count - 6 then
        Remove(Last);
    OkayButton.Hide;
    Drawing.EraseMakMarks;
    Drawing.DrawFirstObjects(Drawing.LastValidObjIndex, True);
    MakroMode := 0;
    end
  else
  If SelObjHover then begin  // bei eingeschaltetem Hover-Effekt :
    Drawing.EraseMakMarks;   //    alle Markierungen löschen !
    Drawing.DrawFirstObjects(Drawing.LastValidObjIndex, True);
    end;

  If ActiveTermWin <> Nil then begin
    With ActiveTermWin do
      if Visible then
        Hide;
    ActiveTermWin := Nil;
    end;

  If Modus = cmd_MarkRect then
    ShowSelectionFrame
  else
    DeleteSelectionFrame;

  PrevModus     := Modus;
  FModus        := cmd_Drag;
  Screen.Cursor := crDefault;
  ActPopupObj   := Nil;
  PaintBox1.Canvas.Pen.Mode := pmCopy;  { vorsichtshalber !!! }

  Case PrevModus of
    cmd_ShowGrowth : begin
                     Drawing.HideHiddenObjects;
                     Last2Show := -1;
                     StatusBar1.Panels[1].Style := psText;
                     Drawing.Repaint;
                     end;
    cmd_ToggleVis  : begin
                     Drawing.HideHiddenObjects;
                     Drawing.Repaint;
                     end;
    cmd_EditGroup,
    cmd_Group      : If Modus = cmd_Drag then begin  // Fehlerhafte Gruppe löschen
                       If (EditGroupWin.ActGroup <> Nil) and
                          (EditGroupWin.ActGroup.MemberCount = 0) then begin
                         n := Drawing.GroupList.IndexOf(EditGroupWin.ActGroup);
                         If n >= 0 then
                           Drawing.GroupList.Delete(n);
                         StatusBar1.Invalidate;
                         end;
                       Drawing.Repaint;
                       end;
    cmd_EditDraw,
    cmd_FillArea,
    cmd_CutArea,
    cmd_BindTBox2Obj,
    cmd_ReleaseTBox,
    cmd_DCreate,
    cmd_RepeatMapping,
    cmd_Image      : Drawing.Repaint;
    cmd_NEckReady  : begin
                     PrevModus := cmd_NCreate;
                     Drawing.DrawFirstObjects(Drawing.LastValidObjIndex);
                     end;
    cmd_GraphArea,
    cmd_Riemann    : begin
                     Drawing.Repaint;
                     If CoSysWasInvisible then begin
                       CoSysWasInvisible := False;
                       If MessageDlg(MyMess[129], mtConfirmation,
                                     [mbYes, mbNo], 0) = mrYes then begin
                         For n := 0 to 2 do
                           TGeoObj(Drawing.Items[n]).ShowsAlways := False;
                         Drawing.Repaint;
                         end;
                       end;
                     end;
    cmd_DefineAffin,
    cmd_DefAffReady: begin
                     If (FLastMapping = Nil) and
                        (LastLVOIndex > 0) then begin      // Rollback
                       While Drawing.LastValidObjIndex > LastLVOIndex do
                         with Drawing do begin
                           TGeoObj(Items[LastValidObjIndex]).Free;
                           Delete(LastValidObjIndex);
                           Dec(LastValidObjIndex);
                           end;
                       end;
                     LastLVOIndex := 0;
                     Drawing.Repaint;
                     end;
    cmd_MagnGlass:   RefreshSpecialImageButtons;
  end; { of case }

  If Assigned(MagnGlassWin) then begin
    MagnGlassWin.RefreshBuffer;
    MagnGlassWin.Invalidate;
    end;

  ShowMyHint(0);            { Erst hier !     }
  Cursor := crArrow;

  If LastSpeedButton <> Nil then begin
    rep_cmd := SpBtnDataList.GetCommandFromSpeedBtn(LastSpeedButton);
    If AutoRepeat and      { Dies muß stets die letzte Anweisung bleiben ! }
      (rep_cmd in Repeatable_Commands) then begin
      LastSpeedButton.Down := True;
      If rep_cmd in [cmd_MirrorAxisObj..cmd_RepeatMapping] then begin
        PrevModus := cmd_RepeatMapping;     { AutoRepeat fortschreiben }
        InitInputList(cmd_RepeatMapping, Nil, False, False);
        end
      else
        LastSpeedButton.Click;   { Normalfall der Befehls-Wiederholung }
      end
    else begin
      LastSpeedButton := Nil;
      AutoRepeat := False;
      end;
    end
  else
    AutoRepeat := False;
  LastSelectedObj := Nil;
  end; { of Reset2DragMode }


function THauptfenster.UserWants2SkipDrawing: Boolean;
  begin
  Result := True;
  If (Drawing.IsDirty) and
     (Drawing.LastValidObjIndex > 5) then
    Case MessageDlg(MyFileMsg[13], mtConfirmation, mbYesNoCancel, 0) of
      mrYes    : begin                   { Falls der Benutzer das     }
                 Speichern1Click(Nil);   { Speichern abbricht, bleibt }
                 Result :=               { die Zeichnung vorsichts-   }
                   Not Drawing.IsDirty;  { halber erhalten ! 30.01.00 }
                 end;
      mrCancel : Result := False;
    end;
  end;


function THauptfenster.UserWants2Break4(new_Mode : Integer) : Boolean;
  var decider : Integer;

  procedure Ask4Break(s: String);
    begin
    If MessageDlg(s, mtWarning, [mbYes, mbNo], 0) = mrYes then
      Result := True;
    end;

  begin
  If new_Mode = Modus then
    Result := True
  else begin
    Result := False;
    decider := Modus;
    If (Modus = cmd_Drag) and
       (OLineMode > 0) then
      decider := cmd_MakeLocLine;

    Case decider of
      cmd_Drag,               { Immer kommentarlos abbrechen }
      cmd_BindP2L,
      cmd_EditDraw    : Result := True;
      cmd_ShowGrowth  : begin { Nur Meldung, dann immer abbrechen }
                        MessageDlg(MyMess[21], mtInformation,
                                   [mbOk], cmd_ShowGrowth);
                        Result := True;
                        end;
      cmd_EditGroup   : If new_Mode = cmd_Group then
                          Result := True;
      cmd_Group       : ;     { Wechsel immer ablehnen ! }
      cmd_MakeLocLine : Ask4Break(MyMess[81] + MyMess[80]);  { Nachfragen ! }
      cmd_NCreate     : Ask4Break(MyMess[82] + MyMess[80]);
      cmd_RunMakro    : Ask4Break(MyMess[83] + MyMess[80]);
      cmd_DefMakro    : Ask4Break(MyMess[84] + MyMess[80]);
    else
      If Start.Count > 0 then
        Ask4Break(MyMess[79] + MyMess[80])
      else
        Result := True;
    end; { of case }

    SpBtnDataList.UpperAllButtons;
    If Result then begin { Falls Wechsel zum neuen Befehl: .....  }
      Reset2DragMode;    { 08.04.03: ergänzt für definierten Ausgangszustand }
      LastSpeedButton := SpBtnDataList.GetSpeedBtnFromCommand(new_Mode);
      end
    else                 { Andernfalls: alten Befehl beibehalten !}
      LastSpeedButton := SpBtnDataList.GetSpeedBtnFromCommand(Modus);
    If LastSpeedButton <> Nil then
      LastSpeedButton.Down := True;
    end;
  end;


procedure THauptfenster.JumpLink(link: String);
  var LinkPath: String;
  begin
  Reset2DragMode;
  If UserWants2SkipDrawing then begin
    Drawing.IsDirty := False;
    LinkPath := MergeFilePathAndRelFileName(ExtractFilePath(ActGeoFileName), link);
    If FileExists(LinkPath) then
      DoLoadGeoFile(LinkPath)
    else
      If MessageDlg(Format(MyFileMsg[6], [link]) + MyFileMsg[29],
                    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
        { Trägt nur den Dateinamen ins Datei-Dialog-Formular  ein
          und ruft dann den Datei-Dialog auf. }
        LoadGeoFile.FileName := ExtractFileName(link);
        Laden1Click(Nil);
        end;
    end;
  end;


{ ============= Objekt-Auswahl =========================== }

function THauptfenster.InitInputList(new_mode: Integer; SpdBtn: TObject;
                                     Check: Boolean = True;
                                     SwitchToolBar: Boolean = True) : Boolean;
  var index : Integer;

  procedure AdjustMakroRunParams;
    var MC : TMakroCmd;
    begin                          { Falls ein Makro ausgeführt werden soll, werden }
    MC := TMakroCmd(TMakro(Drawing.MakroList[MakroNum])[MaCmdNum]);
    While MC.CmdType < 0 do begin  { die Daten des nächsten einzugebenden Start-    }
      Inc(MaCmdNum);               { objekts aus dem aktuellen Makro....            }
      MC := TMakroCmd(TMakro(Drawing.MakroList[MakroNum]).Items[MaCmdNum]);
      end;                         { ... in die InitInput-Liste übertragen.         }
    if MC.ObjType.InheritsFrom(TGNumberObj) then begin
      InitModeList[index,1] := ccNumberObj;
      InitModeList[index,5] :=  -7; end else
    If MC.ObjType.InheritsFrom(TGConic) then begin
      InitModeList[index,1] := ccConic;
      InitModeList[index,5] :=  -6; end else
    If MC.ObjType.InheritsFrom(TGPolygon) then begin
      InitModeList[index,1] := ccAnyPoly;
      InitModeList[index,5] :=  -5; end else
    If MC.ObjType.InheritsFrom(TGCircle) then begin
      InitModeList[index,1] := ccCircle;
      InitModeList[index,5] :=  -4; end else
    If MC.ObjType.InheritsFrom(TGLongLine) then begin
      InitModeList[index,1] := ccStraightLine;
      InitModeList[index,5] :=  -3; end else
    If MC.ObjType.InheritsFrom(TGShortLine) then begin
      InitModeList[index,1] := ccShortLine;
      InitModeList[index,5] :=  -2; end else
    If MC.ObjType.InheritsFrom(TGPoint) then begin
      InitModeList[index,1] := ccAnyPoint;
      InitModeList[index,5] :=  -1; end
    else
      InitModeList[index,5] :=  -15
    end;

  procedure AdjustCheckSolutionParams;
    var VarL : TStringList;
        CCO  : TGCheckControl;
        n, i : Integer;
    begin
    For i := 1 to 3 do
      InitModeList[index, i] := 0;     // Alle Einträge löschen
    CCO  := Drawing.CheckControl as TGCheckControl;
    VarL := TStringList.Create;
    try
      VarL.Text := CCO.VVars;
      n := 3;                                  // höchstens !
      If VarL.Count < 3 then n := VarL.Count;  // genau !
      For i := 1 to n do
        InitModeList[index, i] := GetValidationVarType(VarL.ValueFromIndex[i-1]);
    finally
      VarL.Free;
    end;
    end;

  procedure InitializeStartList;
    var k : Integer;
    begin
    With Start do begin
      Clear;
      k := 0;
      While (k < 3) and
            (InitModeList[index, Succ(k)] > 0) do Inc(k);
      ExpectedCount := k;
      IL_Line       := index;
      IL_Row        := 1;
      ExpectedType  := InitModeList[IL_Line, IL_Row];
      If (ExpectedCount > 1) or
         (Modus in [cmd_RunMakro, cmd_NCreate,
                    cmd_Conic, cmd_ParabelT]) then
        GeoTimer.InitObjBlinking(Drawing);
      end;
    end;

  begin
  Result := False;
  PreselectedObj := Nil;
  Drawing.LockAllImages;
  If (Not Check) or UserWants2Break4(new_Mode) then begin
    index := 0;
    While (index <= MaxModeListIndex) and
          (InitModeList[index,0] <> new_mode) do Inc(index);
    If index > MaxModeListIndex then
      MessageDlg(MyMess[26], mtError, [mbOK], 0)
    else begin
      Last2Show := Drawing.LastValidObjIndex;
      FModus := cmd_Drag;  { Diese Zuweisung....
           .... verhindert das (asynchrone!) Rücksetzen der Startliste.
           Dies ist nötig für Kontext-Menü-Befehle, die eine teilweise
           Vorbelegung der Startliste brauchen. Der folgende Befehl ruft
           indirekt Reset2DragMode auf, das in diesem Fall aber gleich
           wieder verlassen wird, weil DynaGeo nun glaubt, dass der
           DragMode schon aktiv ist.           Letzte Änderung: 08.04.03 }
      If SwitchToolBar then
        AdjustToolMode(new_Mode);
      FModus := new_Mode;
      AutoRepeat := (AutoRepeat and (Modus = PrevModus)) or
                    ((SpdBtn Is TSpeedButton) and
                     (GetKeyState(vk_Shift) < 0) and
                     (Modus In Repeatable_Commands));
      DeleteSelectionFrame;

      Case new_mode of
        cmd_RunMakro: AdjustMakroRunParams;
        cmd_CheckSol: AdjustCheckSolutionParams;
      end;

      ShowMyHint(InitModeList[index, 5]);
      Selected.Clear;
      InitializeStartList;
      Result := True;
      end;
    end;
  end;

procedure THauptFenster.RefreshCursor;
  var changed : Boolean;
      i       : Integer;
  begin
  If Screen.Cursor = crHourGlass then Exit;
  Screen.Cursor   := crDefault;
  Case Modus of
    cmd_Drag       : If (Selected <> Nil) and (Selected.Count > 0) then  { Objekt selektiert }
                       Cursor := TGeoObj(Selected.First).GetMatchingCursor(Point(Last_XM, Last_YM))
                     else                        { kein Objekt selektiert }
                       If (LastShiftState <> []) and
                          (ssShift in LastShiftState) then
                         Cursor := Hand_Cursor   { für den Slide-Modus ! }
                       else
                         Cursor := crArrow;
    cmd_Slide,
    cmd_MoveName   : Cursor := Hand_Cursor;
    cmd_PCreate    : If ExtPointCmd and (LastSelectedObj <> Nil) and (LastSelectedObj is TGLine) then
                       Cursor := Catch_Cursor
                     else
                       Cursor := Input_Cursor;
    cmd_RunAnimaBK,
    cmd_RunAnimaFD,
    cmd_ShowGrowth,
    cmd_AdjNumObj  : Cursor := crArrow;
    cmd_EditDraw   : If Selected.Count > 0 then
                       If (LastShiftState <> []) and
                          (ssAlt in LastShiftState) then
                         Cursor := PickUp_Cursor
                       else
                         Cursor := Catch_Cursor
                     else
                       Cursor := Input_Cursor;
    cmd_FillArea   : If Selected.Count > 0 then
                       If (LastShiftState <> []) and
                          (ssAlt in LastShiftState) then
                         If TGeoObj(Selected.First) is TGArea then
                           Cursor := PickUp_Cursor
                         else
                           Cursor := Input_Cursor
                       else
                         Cursor := Catch_Cursor
                     else
                       Cursor := Input_Cursor;
  else
    if Selected.Count > 0 then
      Cursor := Catch_Cursor
    else
     { Das folgende deaktivierte Code-Fragment würde den Eingabe-Cursor zum
       Catch-Cursor umschalten, wenn ein Punkt erwartet wird und die Maus
       auf eine Linie zeigt. Dann könnte der neu erzeugte Basispunkt gleich
       automatisch an diese Linie gebunden werden. Siehe SelectStartObject !   }
     {
      If (Modus in Construct_Commands) and
         (Start.ExpectedType in [ccAnyPoint, ccPointOrVector, ccPointOrShortLn]) and
         (LastSelectedObj <> Nil) and (LastSelectedObj is TGLine) then
        Cursor := Catch_Cursor
      else
     }
      Cursor := Input_Cursor;
  end; { of case }

  { Hover-Effekt : }
  If SelObjHover and (Modus in Hover_Commands) then begin
    changed := False;
    For i := Drawing.LastValidObjIndex DownTo 0 do  // Alle Hovers löschen
      If (TGeoObj(Drawing.Items[i]) <> LastSelectedObj) and
         (TGeoObj(Drawing.Items[i]).IsMakMarked) then begin
        TGeoObj(Drawing.Items[i]).IsMakMarked := False;
        changed := True;
        end;
    If (Selected.Count > 0) and (Modus > cmd_Drag) then begin
      If Not LastSelectedObj.IsMakMarked then begin
        LastSelectedObj.IsMakMarked := True;
        changed := True;
        end;
      If (Modus = cmd_Schnitt) and ExtPointCmd and
         (Selected.Count > 1) and Not TGeoObj(Selected[1]).IsMakMarked then begin
        TGeoObj(Selected[1]).IsMakMarked := True;
        changed := True;
        end;
      end;
    If changed then
      Drawing.DrawFirstObjects(Drawing.LastValidObjIndex, True);
    end;
  end;


function THauptfenster.FillSelectList(X, Y: Integer;
                                      iExp_Type: Integer = ccDragableObj): TGeoObj;
  { füllt die Selected-Liste nur mit den "gemausten"
    Objekten vom erwarteten Typ in absteigender Priorität      }
  var exp_type,
      i, k     : Integer;
      LSO,
      LUMO,                { "L_ast U_nexpected M_oused O_bjekt" }
      LaMO     : TGeoObj;  { "La_st M_oused O_bject" }

  function NoSelfReference : Boolean;
    begin
    If LaMO is TGTermObj then
      Result := LaMO <> ActPopupObj
    else
      Result := True;
    end;

  begin
  LUMO := Nil;
  LSO  := LastSelectedObj;
  if Selected = Nil then begin
    Result := Nil;
    Exit;
    end;

  Selected.Clear;    { alle Einträge der Selected-Liste löschen  }
  If Drawing.IndexOf(LSO) < 0 then
    LSO := Nil;      { ungültiges LSO vermeiden, sonst ASV !!!   }

  If Modus <= cmd_MoveName then
    exp_type := iExp_Type { Dann kann man im Normalfall Basis-Objekte     }
  else                    {   verziehen oder Namen bzw. Maße verschieben. }
    exp_type := Start.ExpectedType;

  Drawing.LastMousePos := Point(X, Y);
  For i := Drawing.LastValidObjIndex downto 0 do
    If TGeoObj(Drawing.Items[i]).IsVisible and { Objekte bei der Maus suchen ... }
       TGeoObj(Drawing.Items[i]).IsNearMouse then begin
      LaMO := TGeoObj(Drawing.Items[i]);
      If LaMO.IsCompatibleWith(exp_type) and
         NoSelfReference then begin
        k := Selected.Count;                     { ... und erwartete        }
        While (k > 0) and                        {     Objekte einordnen !  }
              LaMO.IsPriorTo(TGeoObj(Selected.Items[Pred(k)]).ClassType) do
          Dec(k);
        Selected.Insert(k, LaMO);
        end
      else
        If (LUMO = Nil) or                       { Unerwartete Objekte...   }
           LaMO.IsPriorTo(LUMO.ClassType) then   { ... merken !             }
          LUMO := LaMO;
      end;

  If Selected.Count > 0 then    { Wenn ein passendes Objekt gefunden wurde und }
    If LSO <> Selected.Items[0] then begin   { es ist nicht das aktuelle, dann }
      LSO := Selected.Items[0];          { wird das neue Objekt zurückgegeben. }
      end
    else                                 { Wird nur wieder das schon aktive    }
      { nothing to do !!! }              { gefunden, bleibt LSO unverändert.   }
  else                          { Wird kein passendes Objekt gefunden, dann }
    LSO := LUMO;                      { wird eventuell das bei der Maus     }
  Result := LSO;                      { stehende unpassende zurückgegeben.  }
  end;


procedure THauptFenster.SelectStartObject;
  var i, err          : Integer;
      Pt              : TPoint;
      p               : TGeoObj;
      OldExpectedType : Integer;

  function IsDecidedByHover: Boolean;
    { Setzt voraus, dass in Selected mehr als 1 Objekt eingetragen ist ! }
    var i : Integer;
    begin
    If SelObjHover and (Modus in Hover_Commands) then begin
      Result := TGeoObj(Selected[0]).IsPriorTo(TGeoObj(Selected[1]).ClassType);
      if Result then begin
         for i := 0 to Pred(Selected.Count) do
           if TGeoObj(Selected[i]).InheritsFrom(TGPolygon) then
             Result := False;
         end;
      end
    else
      Result := False;
    end;

  procedure choose_selected_obj;
    var i : Integer;
    begin
    If (Selected.Count > 1) and
       ((Modus = cmd_EditDraw) or
        (Modus = cmd_ToggleVis)) then begin   { Auswahlautomatik !!!        }
      i := Pred(Selected.Count);             {  siehe: TGeoObj.IsPriorTo() }
      While i > 0 do begin
        If TGeoObj(Selected.Items[i]).IsPriorTo
             (TGeoObj(Selected.Items[i-1]).ClassType) then
          Selected.Delete(i-1);
        Dec(i);     { hinterläßt eine monoton steigende Liste,      }
        end;        {   aber i. A. keine streng monoton steigende ! }
      If Selected.Count > 1 then begin
        i := 1;
        While i < Selected.Count do begin
          If TGeoObj(Selected.Items[i-1]).IsPriorTo
               (TGeoObj(Selected.Items[i]).ClassType) then
            Selected.Delete(i)
          else
            Inc(i);
          end;
        end;  { hinterläßt nur die Einträge mit der kleinsten TypOrdnung }
      end;

    If (Selected.Count > 1) and  { bei Mehrfachauswahl ohne Entscheidung }
       (Not IsDecidedByHover) then begin      {  durch den Hover-Effekt: }
      Pt := PaintBox1.ClientToScreen(Point(Last_XM + 6, Last_YM + 6));
      SelectDlg.LoadObjList(Pt.X, Pt.Y);
      If SelectDlg.ShowModal = mrOk then   { Auswahl-Liste !      }
        If SelectDlg.SelectedItem > 0 then
          Selected.ExChange(0, SelectDlg.SelectedItem)
        else
          { Nothing to do ! }
      else
        Selected.Clear;
      end;
    end; { end of choose_selected_obj }

  procedure GetNextExpectedType;
    begin
    With Start do begin
      Inc(IL_Row);
      If (IL_Row <= 3) and
         (InitModeList[IL_Line, IL_Row] > 0) then
        ExpectedType := InitModeList[IL_Line, IL_Row]
      else
        ExpectedType := 0;
      end;
    end;

  begin { of SelectStartObject }
  OldExpectedType := Start.ExpectedType;
  If Selected.Count = 0 then   { Falls kein Objekt selektiert ist:  }
    If (Modus in Construct_Commands) and  { Wird ein Basis-Punkt erwartet, }
       (Start.ExpectedType in             { diesen erzeugen und einfügen.  }
          [ccAnyPoint, ccPointOrVector,
           ccPointOrShortLn, ccPointOrAngle]) then begin
      p := TGPoint.Create(Drawing, Last_XM, Last_YM, True);
      Drawing.InsertObject(p, err);

      { Bei "Erweiterter Funktionalität des Punkt-Befehls könnte auch noch
        eine automatische Bindung an eine Linie durchgeführt werden -
        allerdings keine Schnittpunkt-Erzeugung, weshalb wir auch auf die
        Bindung vorerst verzichten! Will man sie aktivieren, müssen die
        vorstehenden 2 Zeilen durch den folgenden Code ersetzt werden :    }
      {
      If ExtPointCmd and (LastSelectedObj <> Nil) and
         (LastSelectedObj is TGLine) then begin
        p := TGPoint.Create(Drawing, Last_XM, Last_YM, False);
        Drawing.InsertObject(p, err);
        p.BecomesChildOf(LastSelectedObj);
        Drawing.DraggedObj := p;
        p.UpdateParams;
        p.ShowsAlways := True;
        end
      else begin
        p := TGPoint.Create(Drawing, Last_XM, Last_YM, True);
        Drawing.InsertObject(p, err);
        end;
      }
      { Außerdem sollte in RefreshCursor die Detektierung der Träger-
        Linie für den neuen Basispunkt eingeschaltet werden.              }

      Start.AddBlinking(p, GeoTimer.Enabled);
      GetNextExpectedType;
      end
    else
  else begin                   { Falls Objekt(e) selektiert sind:   }
    choose_selected_obj;               { Objekt aus der Select-Liste auswählen; falls ein }
    If Selected.Count > 0 then begin   { gültiges Objekt zurückgegeben wird, wird es in   }
      p := Selected.Items[0];          { die Liste der Start-Objekte eingetragen:         }
      if (Start.ExpectedType = ccPointOrShortLn) and { dabei gegebenenfalls eine Strecke  }
         (p.InheritsFrom(TGShortLine)) then begin    { durch zwei Punkte oder .........   }
        for i := 0 to 1 do
          Start.AddBlinking(p.Parent.List[i], GeoTimer.Enabled);
        Inc(Start.IL_Row);
        end
      else
      if (Start.ExpectedType = ccPointOrAngle) and   { ....... einen Winkel durch drei    }
         (p.InheritsFrom(TGAngle)) then begin        { Punkte ersetzen.                   }
        for i := 0 to 2 do
          Start.AddBlinking(p.Parent.List[i], GeoTimer.Enabled);
        Inc(Start.IL_Row, 2);
        end
      else                             { Normalerweise jedoch kommt das selektierte  }
        Start.AddBlinking(p, GeoTimer.Enabled);  { Objekt selbst in die Start-Liste! }
      GetNextExpectedType;
      end
    else begin
      Selected.Clear;
      RefreshCursor;
      end;
    end;
  If (OldExpectedType = ccPointOrArc) and
     (TGeoObj(Start.Items[Pred(Start.Count)]).ClassType = TGArc) then
    with Start do begin
      AddBlinking(TGeoObj(Items[Pred(Count)]).Parent[2], GeoTimer.Enabled);
      ExpectedType := 0;
      Inc(IL_Row);
      end;
  end;  { of SelectStartObject }


{ ============== Objekt-Bearbeitung ======================== }

procedure THauptFenster.ShowErrorMsg(err_nr : Integer; s: String = '');
  begin
  Case err_nr of
      0,    { Kein Fehler ! }
    // Objekt-Management-Fehler :
      1,    { derzeit nicht verwendet !!! }
      5 : ; { Objekt schon als gelöschtes Objekt vorhanden; keine Meldung ! }
      2 : MessageDlg(MyMess[16], mtInformation, [mbOk], 0);  { Objekt existiert schon }
      3 : MessageDlg(MyMess[27], mtError, [mbOk], 0);        { Falscher Objekttyp     }
      4 : MessageDlg(MyMess[47], mtInformation, [mbOk], 0);  { Objekt wieder sichtbar }
    // Datei-Schreib-Fehler :
    200 : ; { kein Fehler ! }
    201 : MessageDlg(Format(MyFileMsg[9], [s]), mtError, [mbOk], 0);
    202 : MessageDlg(Format(MyFileMsg[9] + MyFileMsg[25], [s]), mtError, [mbOk], 0);
    203 : MessageDlg(Format(MyFileMsg[9] + MyFileMsg[30], [s]), mtError, [mbOk], 0);
    204 : MessageDlg(Format(MyFileMsg[31], [s]), mtWarning, [mbOk], 0);
  else
    MessageDlg(MyMess[87], mtError, [mbOk], 0);
  end;
  If err_nr <> 0 then
    PaintBox1.Invalidate;
  end;

procedure THauptfenster.ProcessGeoObject;
  var ErrNum,
      NextCmd : Integer;

  function valid_objects_selected: Integer;
    { übergibt:  0  :  Eingabeobjekte sind gültig;
                 1  :  Mindestens 2 Eingabeobjekte sind identisch;
                 3  :  Ein Pointer ist ungültig !                  }
    var k  : Integer;
    begin { of valid_objects_selected }
    Result := 0;
    If Not (Modus in [cmd_NCreate, cmd_RotateObj, cmd_MoveObj]) then begin
      If (Start.Count >= 2) and
         (Start.Items[0] = Start.Items[1]) and
         (Start.Items[0] <> Nil) then
        Result := 1;
      If (Start.Count >= 3) and
         ((Start.Items[0] = Start.Items[2]) or
          (Start.Items[1] = Start.Items[2])) and
         (Start.Items[2] <> Nil) then
        Result := 1;
      For k := 0 to Pred(Start.Count) do
        If Start.Items[k] = Nil then
          valid_objects_selected := 3;
      end;
    end;  { of valid_objects_selected }

  function MapObj(GO: TGeoObj): TGeoObj;
    begin
    If GO is TGArea then
      Result := TGeoObj(GO.Parent[0])
    else
      Result := GO;
    end;

  procedure EditComment(GO: TGComment);
    begin
    GO.HideDisplay;           //   ==> Editieren !
    TextWin.ActComment := GO;
    TextWin.ExtendedFuncs := GO.IsDynamic;
    TextWin.ShowModal;
    If TextWin.ActComment = Nil then     // Leeres Textobjekt, also löschen,
      Drawing.FreeObject(GO)
    else                         //   andernfalls anzeigen !
      GO.ShowsAlways := True;
    Drawing.Repaint;
    end;

  procedure NameObject(GO: TGeoObj);
    begin
    ShowMyHint(49);
    If (GO.ClassType = TGArea) or  { Falls eine Füllung oder ein Name    }
       (GO is TGName) then         { angeklickt wurde, wird das gefüllte }
      GO := GO.Parent[0];          { oder das benannte Objekt editiert.  }
    If GO is TGComment then        { Doppelklick auf Textbox .....       }
      EditComment(GO as TGComment)
    else
      If Not (GO is TGTextObj) then   { .... oder auf Geo-Objekt }
        with NameEdit do begin
          ActObj := GO;
          ShowModal;
          end;
    end;

  procedure DelGeoObj(GO: TGeoObj);
    var CCO    : TGCheckControl;
        MI     : TGDoubleIntersection;
        mess   : String;
        i, n,
        Result : Integer;
    begin
    If (GO.ClassType = TGOrigin) or
       (GO.ClassType = TGaugePoint) or
       (GO.ClassType = TGAxis) then begin
      Result := MessageDlg(MyMess[41], mtConfirmation, [mbYes, mbNo], 0);
      If Result = id_Yes then begin
        For i := 0 to 2 do
          TGeoObj(Drawing.Items[i]).ShowsAlways := False;
        With Drawing do
          For i := 0 to Pred(Count) do
            If TGeoObj(Items[i]) is TGCoordPt then
              ConvertCoord2BasePt(TGeoObj(Items[i]));
        end;
      end
    else begin
      GO.IsMarked := True;
      n := Drawing.MarkedObjCount;
      If n > 1 then begin
        CCO := Drawing.CheckControl as TGCheckControl;
        If Assigned(CCO) and CCO.IsMarked then
          If n > 2 then
            mess := MyMess[123]
          else
            mess := MyMess[122]
        else
          mess := MyMess[1];
        Result := MessageDlg(mess, mtWarning, [mbYes, mbNo], 0);
        end
      else
        Result := mrYes;
      GO.IsMarked := False;
      If Result = mrYes then begin
        If (GO is TGOLLongLine) or   { Ortslinien stets komplett löschen }
           (GO is TGOLCircle) then
          GO := TGeoObj(GO.Parent[0]);
        Selected.Clear;           { 17.11.01 : Eingefügt wegen ASV nach  }
        LastSelectedObj := Nil;   {   dem Löschen eines Objektnamens     }
        If (GO is TGFunktion) or  { 25.02.07 : Liste der "hart" zu       }
           (GO is TGFixLine) or   {   löschenden Objekte ergänzt wg.     }
           (GO is TGName) or      {   Fehler beim Löschen von Graphen    }
           ((GO is TGLocLine) and (Not TGLocLine(GO).IsDynamic)) then
          Drawing.FreeObject(GO)  { Diese speziellen Objekte total löschen. }
        else begin                        { Bei anderen Objekten :       }
          if GO is TGIntersectPt then     { -- 07.05.13 : Spezialbehand- }
            MI := GO.Parent[0]            {      lung für Schnittpunkte  }
          else
            MI := nil;
          Drawing.InvalidateObject(GO);   { -- "Rückgängig" ermöglichen  }
          if (MI <> nil) and (MI.Children.Count = 0) then
            Drawing.InvalidateObject(MI); { -- 07.05.13 : Leere Multi-   }
          end;                            {      Intersect-Objs löschen  }
        end;
      end;
    RefreshAnimationButtons;
    RefreshMappingMenus;
    RefreshCheckButtons;
    RefreshSpecialImageButtons;
    If Assigned(FunkTabelle) then
      FunkTabelle.UpdateData;
    Drawing.Repaint;
    end;

  procedure EditDrawing(Obj2Edit: TGeoObj);
    var NO        : TGName;
        old_AR    : Boolean;
        ActColour : TColor;
    begin
    If ssAlt in LastShiftState then
      GetActGraphToolsFrom(Obj2Edit)
    else with Obj2Edit do begin
      If Obj2Edit is TGArea then
        ActColour := ToolFillColour
      else
        ActColour := ToolObjColour;
      SetGraphTools(ToolLineStyleNum, ToolPointStyleNum,
                    ToolFillStyleNum, ActColour);
      If SynchronizeCols and
         HasNameObj(NO) and
         Not (Obj2Edit is TGPolygon) then
        NO.MyColour := MyColour;

      BackInvalid := True;
      end;
    old_AR := AutoRepeat;
    InitInputList(cmd_EditDraw, Nil);
    AutoRepeat := old_AR;
    end;

  procedure ToggleObjVis(GO: TGeoObj);
    { 25.06.2012 : Bisher konnten Namensobjekte nicht verborgen werden;
                   stattdessen wurden sie gleich komplett gelöscht. Auf-
      grund eines entsprechenden Bugreports von Herrn Elschenbroich wurde
      das explizite Verbergen von Namensobjekten ab der Version 3.7 ver-
      suchsweise zugelassen.                                             }
    var NO  : TGName;
    begin
    Drawing.HideHiddenObjects;
    BackInvalid := Not GO.IsVisible;
    If GO.ClassType = GeoImage.TGSetsquare then begin { Geodreieck         }
      Drawing.FreeObject(GO);
      SB_Setsquare.Down := False;
      end
    else begin                                        { "Normale" Objekte: }
      GO.ShowsAlways := Not GO.ShowsAlways;           { ....umschalten !   }
      NO := Nil;
      If GO.HasNameObj(NO) then begin
        if Drawing.IndexOf(NO) > Drawing.LastValidObjIndex then
          Drawing.RevalidateObject(NO);
        NO.ShowsAlways := GO.ShowsAlways;
        end;
      if (GO is TGName) and (GO.ShowsAlways) then
        TGeoObj(GO.Parent[0]).ShowsAlways := True;
//    If GO is TGName then
//      If GO.ShowsAlways then
//        TGeoObj(GO.Parent[0]).ShowsAlways := True
//      else
//        Drawing.InvalidateObject(GO);    { Namensobjekt komplett löschen }
      end;
    end;

  procedure InitLocLine (P : TGPoint);
    var NLL : TGLocLine;
    begin
    NLL := TGLocLine.Create(Drawing, P);       { neue Ortslinie erzeugen ...  }
    Drawing.InsertObject(NLL, ErrNum);         { ... und in Liste einfügen    }
    GeoTimer.InitObjBlinking(Drawing);
    P.InitBlinking(True);
    If OLineMode = 2 then begin                   { Mehrere erzeugende Punkte }
      OkayButton.Caption := MyMess[2];
      OkayButton.Show;                            {   in einem Zug            }
      InitInputList (cmd_MakeLocLine, Nil, False);
      end
    else
      RecordTraceClick;                           { Aufzeichnung starten      }
    end;

  procedure InitEnvelop (SL : TGStraightLine);
    var NEL : TGEnvelopLine;
    begin
    NEL := TGEnvelopLine.Create(Drawing, SL);  { neue Einhüllende erzeugen ...}
    Drawing.InsertObject(NEL, ErrNum);         { ... und in Liste einfügen    }
    GeoTimer.InitObjBlinking(Drawing);
    SL.InitBlinking(True);
    If OLineMode = 2 then begin                   { Mehrere erzeugende Punkte }
      OkayButton.Caption := MyMess[2];
      OkayButton.Show;                            {   in einem Zug            }
      InitInputList (cmd_MakeLocLine, Nil, False);
      end
    else
      RecordEnvelopClick;                         { Aufzeichnung starten      }
    end;

  procedure IntersectObjects (GO1, GO2: TGeoObj);
    { Falls bei den Startobjekten ein Kreis oder ein Kegelschnitt dabei ist,
      wird als 2. Parameter stets dieser Kreis oder Kegelschnitt übergeben;
      der 1. Parameter kann eine Gerade bzw. Strecke sein, oder aber auch
      ein Kreis oder ein Kegelschnitt.                                     }
    var ISec   : TGeoObj;
        ErrNum1,
        ErrNum2,
        n, i   : Integer;
    begin
    If (GO1 is TGConic) or (GO2 is TGConic) then begin  // mindestens 1 Kegelschnitt !
      If not (GO2 is TGConic) then begin
        ISec := GO1; GO1 := GO2; GO2 := ISec;  // ISec als Tauschpuffer missbraucht !
        end;          // Jetzt ist immer der 2. Parameter ein Kegelschnitt !
      If (GO1 is TGConic) or (GO1 is TGCircle) then begin
        ISec := TGQuadIntersection.Create(Drawing, GO1, GO2);
        n := 4;
        end
      else begin      // Schnitt von Kegelschnitt mit einer geraden Linie !
        ISec := TGDoubleIntersection.Create(Drawing, GO1, GO2);
        n := 2;
        end;
      If ISec.Parent.Count < n + 2 then begin
        ISec := Drawing.InsertObject(ISec, ErrNum);
        { Die folgende Schleife stellt nur die wirklich benötigten
          Schnittpunkt-Objekte her und vermeidet doppelte Punkte. }
        For i := 1 to n + 2 - ISec.Parent.Count do
          Drawing.InsertObject(TGIntersectPt.Create(Drawing, ISec, i-1, True), ErrNum);
        { Schon vorhandene Punkte werden sichtbar geschaltet.     }
        For i := 2 to Pred(ISec.Parent.Count) do
          (TGeoObj(ISec.Parent[i]) as TGPoint).ShowsAlways := True;
        end
      else begin
        For i := 2 to Pred(ISec.Parent.Count) do
          (TGeoObj(ISec.Parent[i]) as TGPoint).ShowsAlways := True;
        ISec.Free;
        end;
      end
    else  // also doch kein Kegelschnitt dabei !
    If (GO1 is TGCircle) or (GO2 is TGCircle) then begin
      If (GO2 is TGCircle) then  { Kreis als 2. Parameter ! }
        ISec := TGDoubleIntersection.Create(Drawing, GO1, GO2)
      else  // GO2 ist also eine gerade Linie und GO1 ein Kreis !
        ISec := TGDoubleIntersection.Create(Drawing, GO2, GO1);
      Case ISec.Parent.Count of
        2 : begin
            { Wenn das DoublePt-Objekt nur 2 Eltern hat,
              dann werden zwei (neue) Schnittpunkte erzeugt. }
            ISec := Drawing.InsertObject(ISec, ErrNum);
            Drawing.InsertObject(TGIntersectPt.Create(Drawing, ISec, 0, True), ErrNum1);
            Drawing.InsertObject(TGIntersectPt.Create(Drawing, ISec, 1, True), ErrNum2);
            If (ErrNum1 = 0) or (ErrNum2 = 0) then
              ErrNum := 0
            else
              If ErrNum1 > ErrNum2 then  { Mindestens eines der Objekte existiert schon! }
                ErrNum := ErrNum1
              else
                ErrNum := ErrNum2;
            end;
        3 : begin
            { Gibt es einen 3. Elter, dann ist einer der Schnittpunkte mit
              dem Kreis schon als definierender Punkt auf dieser Kreislinie
              vorhanden. In diesem Fall braucht man nur noch einen zusätz-
              lichen Schnittpunkt, der immer brav die Rolle des "anderen"
              Schnittpunktes spielen muss.                                  }
            ISec := Drawing.InsertObject(ISec, ErrNum);
            Drawing.InsertObject(TGIntersectPt.Create(Drawing, ISec, 0, True),
                                 ErrNum);
            { Der schon vorhandene Schnittpunkt wird sichtbar geschaltet.   }
            (TGeoObj(ISec.Parent[2]) as TGPoint).ShowsAlways := True;
            end;
        4 : begin
            { Gibt es sogar 4 Eltern, sind beide Schnittpunkte schon als
              definierende Punkte der beiden zu schneidenden Linien
              vorhanden. Sie werden sichtbar geschaltet; das Schnitt-Objekt
              wird gelöscht.                                                }
            For i := 2 to Pred(ISec.Parent.Count) do
              (TGeoObj(ISec.Parent[i]) as TGPoint).ShowsAlways := True;
            ISec.Free;
            end;
      end; { of case }
      end
    else  // Schnitt zweier gerader Linien !
      Drawing.InsertObject(TGLxLPt.Create(Drawing, GO1, GO2, True),
                           ErrNum);   { Andernfalls werden 2 Geraden  }
    end;                              { bzw. Strecken übergeben.      }


  procedure CreateFixLine(GP1, GP2 : TGPoint; iLength: Double);
    var BP        : TGPoint;   { Buffer Point }
        dx, dy, dr: Double;
        wx, wy    : Integer;

    function no_circle (pP1, pP2 : TGPoint) : BOOLEAN;
      { 17.06.2008 : Prüfung auf gebundene Punkte verschärft, so dass
                     jetzt ein Endpunkt einer Strecke fester Länge nicht
        mehr fälschlicherweise für einen gebundenen Punkt gehalten wird. }
      var TL : TGLine;
      begin
      no_circle := False;
      pP1.IsFlagged := True;
      If pP2.IsFlagged then
        If (pP2.ClassType = TGPoint) and     { P2 ist ein gebundener  }
           (pP2.IsLineBound(TL)) then begin  {     Basispunkt  **     }
          pP1.IsFlagged := False;
          pP2.Stops2BeChildOf(TL);           { Bindung versuchsweise lösen }
          pP1.IsFlagged := True;
          If Not pP2.IsFlagged then begin    { Immer noch Zirkel ? }
            MessageDlg(MyMess[3], mtInformation, [mbOk], 0);
            no_circle := True;               { Falls nein : ungebunden lassen ! }
            end
          else
            pP2.BecomesChildOf(TL);          { Falls ja : wieder binden ! }
          end
        else
      else
        no_circle := True;
      pP1.IsFlagged := False;
      end;

    begin
    dx := GP2.X - GP1.X;
    dy := GP2.Y - GP1.Y;
    dr := SQRT(SQR(dx) + SQR(dy));
    If dr < DistEpsilon then begin
      MessageDlg(MyMess[4], mtError, [mbOk], 0);
      Exit;
      end
    else with Drawing do begin
      If (GP2.ClassType <> TGPoint) and (GP1.ClassType = TGPoint) then begin
        BP  := GP1; GP1 := GP2; GP2 := BP;  { Typen anordnen: Falls Basispunkt da, }
        end;                                {    dann ist GP2 ein Basispunkt !     }
      If (GP2.ClassType = TGPoint) and      { Falls mindestens *ein* Endpunkt ein Basispunkt ist }
         ((GP2.Parent.Count = 0) or         { der nicht an einen anderen Punkt "gebunden" ist:   }
          (Not (TGeoObj(GP2.Parent.List[0]) is TGPoint) )) then
        If no_circle(GP1, GP2) and
           no_circle(GP2, GP1) then begin     { Test auf zirkuläre Verwandtschaft                }
          InsertObject(TGFixLine.Create(Drawing, GP1, GP2, iLength, True), ErrNum); { erzeugen.. }
          TGFixLine(Items[LastValidObjIndex]).AdjustFriendlyLinks;       { .. und Links setzen ! }
          // 20.11.10  Geändert wegen Bugmeldung v. Uwe Reuther:
          //           GP1 statt GP2 weil bei der Erzeugung einer Strecke fester Länge in
          //           Version 3.5 effektiv die beiden Endpunkte ihre Rollen getauscht haben.
          FillDragList(GP1);
          Drawing.GetWinCoords(GP1.X, GP1.Y, wx, wy);
          // 2ß.11.10  Ende v. Bugfix
          DragObjects(wx, wy, False);       { Ein Endpunkt wird in die richtige Distanz gezogen; }
          Drawing.ResetDragList;
          If Not TGeoObj(Items[LastValidObjIndex]).DataValid then { ist er gebunden, kann dabei  }
            MessageDlg(MyMess[5], mtError, [mbOk], 0);      { die neue Strecke ungültig werden!  }
          end
        else                                  { Fehlermeldung wegen zirkulärer Verwandtschaft    }
          if MessageDlg(MyMess[6], mtError, [mbYes, mbNo], 0) = id_Yes then
            Drawing.InsertObject(TGShortLine.Create(Drawing, GP1, GP2, True), ErrNum)
          else
      else begin  { andernfalls wird an der aktuellen Mausposition ein neuer Basispunkt erzeugt. }
        GP2 := InsertObject(TGPoint.Create(Drawing, Last_XM, Last_YM, True), ErrNum) as TGPoint;
        InsertObject(TGFixLine.Create(Drawing, GP1, GP2, iLength, True), ErrNum);   { Erzeugen.. }
        TGFixLine(Items[LastValidObjIndex]).AdjustFriendlyLinks;         { .. und Links setzen ! }
        FillDragList(GP2);
        Drawing.GetWinCoords(GP2.X, GP2.Y, wx, wy);
        DragObjects(wx, wy, False);         { Der 2. Endpunkt wird in die richtige Distanz  }
        Drawing.ResetDragList;              {   gezogen. Er ist hier stets frei beweglich ! }
        end;
      end;
    end;


  procedure MakePolygon;
    { Der aktuelle Eckpunkt darf nur als letzter (!) in der Start-Liste
      vorkommen. Falls er zusätzlich mit einer Nummer 1 < n < Count-1
      vorkommt, gibt's eine Fehlermeldung. Falls er zusätzlich als erster
      (also mit n = 0) vorkommt und schon mindestens 3 gültige Ecken
      registriert sind, wird das Polygon geschlossen.
      Überarbeitet 26.07.99: wg. BugReport Matthias Taulien;
      überarbeitet 07.10.03: wg. BugReport Dietmar Viertel.
      überarbeitet 05.06.05: "NoSegmentYet" vermeidet doppelte Polygonkanten! }

    function NoSegmentYet(p1, p2: TGPoint): Boolean;
      var i : Integer;
      begin
      Result := True;
      i := Drawing.LastValidObjIndex;
      While Result and (i >= 0) do
        If (TGeoObj(Drawing.Items[i]) is TGShortLine) and
           (TGShortLine(Drawing.Items[i]).Parent.IndexOf(p1) >= 0) and
           (TGShortLine(Drawing.Items[i]).Parent.IndexOf(p2) >= 0) then
          Result := False
        else
          i := i - 1;
      end;

    var dummy   : Integer;
        Polygon : TGeoObj;
    begin
    With Start do
      If (Count > 3) and
         (Last = First) then begin  { Schließen }
        Drawing.InsertObject(TGShortLine.Create(Drawing, Items[Count-2], Items[Count-1], True), dummy);
        Polygon := Drawing.InsertObject(TGPolygon.Create(Drawing, Start, True), ErrNum);
        If PolyFilled then
          Drawing.InsertObject(TGArea.Create(Drawing, TGLine(Polygon), True, True), ErrNum);
        Clear;
        If Modus = cmd_NCreate then
          FModus := cmd_NEckReady;
        end
      else begin                    { Erweitern }
        If Count > 1 then { Der letzte eingegebene Punkt ist nicht der erste!  }
          { Wenn der letzte Punkt wirklich nur als Letzter in der Startliste
            vorkommt und noch keine Strecke vom vorletzten zum letzten Eckpunkt
            existiert, dann wird eine entsprechende Seite erzeugt.             }
          If IndexOf(Last) = Count-1 then
            If NoSegmentYet(Items[Count-2], Items[Count-1]) then
              Drawing.InsertObject(TGShortLine.Create(Drawing, Items[Count-2],
                                                      Items[Count-1], True),
                                   dummy)
            else         { Nichts zu tun! Kante existiert schon! }
          else begin  { Der letzte Punkt kommt mehrfach in der Startliste vor: }
            Dec(ExpectedCount);
            Delete(Count-1);
            MessageDlg(MyMess[15], mtError, [mbOk], 0);      { Fehlermeldung ! }
            end;
        Inc(ExpectedCount);
        ExpectedType := ccAnyPoint;
        GeoTimer.InitObjBlinking(Drawing);
        end;
    end;

  procedure MakeRegPoly;
    var LPt,                // "L"ast "P"oint
        NPt,                // "N"ext "P"oint
        NPoly : TGeoObj;
        n,                  // Anzahl der Ecken
        i     : Integer;
    begin
    n := Abs(Round(StrToFloat(LastValueWStr[0])));
    If n < 100 then begin
      NPoly := Drawing.InsertObject(TGRegPoly.Create(Drawing, Start.Items[0], Start.Items[1], n, False),
                                    ErrNum);
      If ErrNum = 0 then begin  // Nur bei neuem Polygon Ecken und Seiten hinzufügen !
        Drawing.InsertObject(TGShortLine.Create(Drawing, Start.Items[0], Start.Items[1], True),
                             ErrNum);
        LPt := Start.Items[1];
        For i := 2 to Pred(n) do begin
          NPt := Drawing.InsertObject(TGVertexPt.Create(Drawing, NPoly, i, True),
                                      ErrNum);
          Drawing.InsertObject(TGShortLine.Create(Drawing, LPt, NPt, True),
                               ErrNum);
          LPt := NPt;
          end;
        Drawing.InsertObject(TGShortLine.Create(Drawing, LPt, Start.Items[0], True),
                             ErrNum);
        If PolyFilled then
          Drawing.InsertObject(TGArea.Create(Drawing, TGLine(NPoly), True, True), ErrNum);
        end;
      end
    end;

  procedure CreateTriangle;
    var i  : Integer;
    begin
    Start.Add(Start.First);
    For i := 1 to 3 do with Drawing do
      InsertObject(TGShortLine.Create(Drawing, Start.Items[Pred(i)],
                                      Start.Items[i], True), ErrNum);
    MakePolygon;
    end;

  procedure CreateCircleSLR;
    var ts : String;
    begin
    ts := 'd(' + TGeoObj(Start.Items[0]).Name + ';' +
                 TGeoObj(Start.Items[1]).Name + ')';
    Drawing.InsertObject(TGXCircle.Create(Drawing, Start.Items[2], ts, True),
                         ErrNum);
    end;

  procedure MakeConic;
    begin
    With Start do
      If Count < 5 then begin
        Inc(ExpectedCount);
        ExpectedType := ccAnyPoint;
        GeoTimer.InitObjBlinking(Drawing);
        end
      else begin
        Drawing.InsertObject(TGConic.Create(Drawing,  Start[0], Start[1],
                                            Start[2], Start[3], Start[4], True),
                             ErrNum);
        FModus := cmd_NEckReady;
        end;
    end;

  procedure MakeBezierParabola;
    { 2011-11-17: Fehlermeldung von Herrn Prof. Profke ("Profke_Parabel.geo"):
                  Liegt einer der eingegebenen Parabelpunkte auf mehreren
      geraden Linien, dann nimmt DynaGeo nicht immer die gemeinte Tangenten-
      richtung, sondern erwischt oft eine falsche. Daher wurde die Heuristik
      zum Erraten der gemeinten Tangentenrichtung komplett entfernt.        }
    begin
    With Start do
      If Count < 4 then begin
        Inc(ExpectedCount);
        If Odd(Count) then
          ExpectedType := ccStraightLine
        else begin
          ExpectedType := ccAnyPoint;
          ShowMyHint(90);
          end;
        GeoTimer.InitObjBlinking(Drawing);
        end
      else begin
        Drawing.InsertObject(TGParabelT.Create(Drawing, Start[0], Start[2],
                                               Start[1], Start[3], True),
                             ErrNum);
        FModus := cmd_NEckReady;
        end;
    end;

  procedure BringPoly2Front(Area: TGArea);
    var i : Integer;
    begin
    With Drawing do begin
      i := IndexOf(Area);
      If i >= 0 then begin
        Move(i, LastValidObjIndex);
        Drawing.SortObjects;
        Drawing.Repaint;
        end;
      end;
    end;

  procedure StartBasicLongLine;
    begin
    TPt[1].x := Last_XM;
    TPt[1].y := Last_YM;
    TPt[2].x := TPt[1].x;
    TPt[2].y := TPt[1].y;
    PaintBox1.Canvas.Pen.Mode := pmNotXOR;
    end;

  procedure StartBasicCircle;
    begin
    TPt[1].x := Last_XM;
    TPt[1].y := Last_YM;
    TPt[2].x := 0;
    TPt[2].y := 0;
    PaintBox1.Canvas.Pen.Mode := pmNotXOR;
    end;

  procedure CreateGRicht;
    var pS1, pVP,
        pOP      : TGPoint;
        NGO      : TGeoObj;

    procedure CheckOrientation;
      var xop, yop, dx, dy,
          vSide, iAngle : Double;
          TestBaum      : TTBaum;
      begin
      TestBaum := TTBaum.Create(Drawing, Rad);
      try
        TestBaum.BuildTree(LastValueWStr[0]);
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
          LastValueWStr[0] := TestBaum.source_str;
          end;
      finally
        TestBaum.Free;
      end; { of try }
      end;

    begin
    pS1 := Start[0];
    pVP := Start[1];
    If Start.Count >= 3 then pOP := Start[2]
    else                     pOP := Nil;
    If pOP <> Nil then begin  { Orientierungspunkt vorhanden ?  }
      CheckOrientation;
      If Drawing.LastValidObjIndex > Last2Show then begin
        pOP.ShowsAlways := False;
        Drawing.FreeObject(pOP);
        end;
      end;
    Last2Show := -1;
    If Modus = cmd_GRichtTerm then
      NGO := TGXLine.Create(Drawing, pS1, pVP, LastValueWStr[0], True)
    else
      NGO := TGXRay.Create(Drawing, pS1, pVP, LastValueWStr[0], True);
    Drawing.InsertObject(NGO, ErrNum);
    end;

  procedure MakeBisector;
    var BS : TGeoObj;
    begin
    If Modus = cmd_WHalb then
      Drawing.InsertObject(TGWHalb.Create(Drawing, Start.Items[0], Start.Items[1], Start.Items[2], True), ErrNum)
    else begin
      BS := Drawing.InsertObject(TGWHalb.Create(Drawing, Start.Items[0], Start.Items[1], Start.Items[2], False), ErrNum);
      Drawing.InsertObject(TGSenkr.Create(Drawing, Start.Items[1], BS, True), ErrNum);
      end;
    end;

  procedure MakeOrthogonalLine;
    var OG,             // "O"rthogonale "G"erade
        FP : TGeoObj;   // "F"uss-"P"unkt
    begin
    If Modus = cmd_Lot then
      Drawing.InsertObject(TGSenkr.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum)
    else begin
      OG := Drawing.InsertObject(TGSenkr.Create(Drawing, Start.Items[0], Start.Items[1], False), ErrNum);
      FP := Drawing.InsertObject(TGLxLPt.Create(Drawing, Start.Items[1], OG, True), ErrNum);
      Drawing.InsertObject(TGShortLine.Create(Drawing, Start.Items[0], FP, True), ErrNum);
      end;
    end;

  procedure MakeTangentOrNormal;
    var PO   : TGPoint;
        TL   : TGLine;
        n, i : Integer;
    begin
    PO := Start.Items[0];
    If Start.Count = 1 then begin   // Automatisches Ergänzen versuchen
      TL := Nil;
      If PO.IsLineBound(TL) then
        Start.Add(TL)
      else begin
        n := 0;
        For i := 0 to Pred(PO.Children.Count) do
          If ((TGeoObj(PO.Children[i]) is TGCurve) or
              (TGeoObj(PO.Children[i]) is TGCircle)) and
             (PO.IsIncidentWith(PO.Children[i])) then begin
            TL := PO.Children[i];
            n := n + 1;
            end;
        If n = 1 then
          Start.Add(TL);
        end;
      end;
    If Start.Count < 2 then begin   // Keine Kurve erkennbar
      Start.ExpectedCount := 2;
      Start.ExpectedType := ccCurveWithTans;
      If Modus = cmd_Tangente then
        ShowMyHint(96)
      else
        ShowMyHint(97);
      MakroMode := 1; { Missbräuchliche, aber zielführende Verwendung: }
      end             {    verhindert Reset2DragMode !                 }
    else begin                      // Punkt und Kurve klar
      MakroMode := 0; { Damit auf jeden Fall Reset2DragMode erreichbar wird. }
      if Modus = cmd_Tangente then
        Drawing.InsertObject(TGTangent.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum)
      else            { Dann muss Modus = cmNormale sein.              }
        Drawing.InsertObject(TGNormal.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      end;
    end;

  procedure CreateVergingLine;
    begin
    Drawing.InsertObject(TGVergingLine.Create (Drawing, LastValueWStr[0],
                           Start.Items[0], Start.Items[1], Start.Items[2], True),
                         ErrNum);
    end;

  procedure ReleasePoint (pP : TGPoint);
    var Tangent: TGTangent;
        DoIt : Boolean;
        i : Integer;
    begin
    If (pP <> Nil) and
       (pP.ClassType = TGPoint) and
       (pP.Parent.Count > 0) and
       (TGeoObj(pP.Parent.List[0]) is TGLine) then begin
      DoIt    := False;
      Tangent := Nil;
      For i := 0 to Pred(pP.Children.Count) do
        If TGeoObj(pP.Children[i]) is TGTangent then
          Tangent := pP.Children[i];
      If Tangent <> Nil then begin
        Tangent.IsMarked := True;
        If MessageDlg(Format(MyMess[96], [pP.Name, pP.Name]),
                      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
          Tangent.IsMarked := False;
          Selected.Clear;
          LastSelectedObj := Nil;
          Drawing.FreeObject(Tangent);   { Total löschen !!! }
          DoIt := True;
          end
        else
          Tangent.IsMarked := False;
        end
      else
        DoIt := True;
      If DoIt then begin
        i := Drawing.LastValidObjIndex;
        While i > 4 do begin
          If TGeoObj(Drawing[i]) is TGLocLine then
            TGLocLine(Drawing[i]).CheckOLState(pP);
          i := i - 1;
          end;
        pP.Stops2BeChildOf(pP.Parent.List[0]);
        pP.CheckChildLinesCBDI;
        end;
      RefreshAnimationButtons;
      end;
    end;

  procedure BindPointToLine (pP: TGPoint; pL : TGParentObj);
    var ok : Boolean;
    begin
    If pP <> Nil then begin
      pP.IsFlagged := True;          { überprüft, ob die Linie von dem zu bindenden Punkt }
      ok := Not pL.IsFlagged;        {   bzw. von einem von dessen "Freunden" abstammt;   }
      pP.IsFlagged := False;         {   in diesem Fall kann ein "Abstammungszirkel" ent- }
      If Not ok then                 {   stehen, also ist die Bindung dann unzulässig !   }
        MessageDlg(MyMess[8], mtError, [mbOk], 0)
      else                           { Falls der Punkt über eine Strecke fester Länge an  }
        If (pP.Parent.Count > 0) and { einen Nicht-Basis-Punkt gebunden ist:              }
           ((TGeoObj(pP.Parent.List[0]) is TGPoint) and  { keine Bindung mehr zulässig !  }
            (TGeoObj(pP.Parent.List[0]).ClassType <> TGPoint)) then
          MessageDlg(MyMess[43], mtInformation, [mbOk], 0)
        else with Drawing, pP do begin
          ReleasePoint(pP);   { Wenn alle Hürden genommen sind, wird eine eventuell vorhandene }
          BecomesChildOf(pL); { alte Bindung aufgelöst und die gewünschte neue geknüpft.       }
          SortObjects;        { Sorgt für die korrekte Objekt-Reihenfolge. 06.08.2002 }
          FillDragList(pP);
          DragObjects(Last_XM, Last_YM, False);
          ResetDragList;
          CheckChildLinesCBDI;
          RefreshAnimationButtons;
          end;
      end;
    end;

  procedure InitPointOnLine (pLine: TGParentObj);
    var pPoint : TGPoint;
    begin
    pPoint := Drawing.InsertObject(TGPoint.Create(Drawing, Last_XM, Last_YM, True), ErrNum) as TGPoint;
    BindPointToLine(pPoint, pLine);
    end;

  procedure ConvertPt2FreeBasePt(Pt : TGPoint);
    var newPt   : TGPoint;
        nameStr : WideString;
        err,
        n       : Integer;
    begin
    If Pt.ClassType = TGPoint then
      ReleasePoint(Pt)
    else begin
      newPt := TGPoint.Create(Drawing, Pt.scrx, Pt.scry, True);
      newPt.AdoptChildrenOf(Pt);
      n := Drawing.IndexOf(Pt);
      Drawing.InsertObject(newPt, err, Succ(n));
      nameStr := Pt.Name;
      If Pt.ClassType = TGIntersectPt then begin
        Pt.ShowsAlways := False;
        Pt.SetNewName(Pt.GetUniqueName('P'));
        end
      else
        Drawing.InvalidateObject(Pt);
      newPt.SetNewName(nameStr);
      end;
    end;

  procedure CombinePoints(SourcePt, TargetPt: TGPoint);
    var NO : TGName;
    begin
    If SourcePt.IsAncestorOf(TargetPt) then
      MessageDlg(Format(MyMess[140], [TargetPt.Name, SourcePt.Name]),
                 mtWarning, [mbOk], 0)
    else begin
      If SourcePt.HasNameObj(NO) then
        Drawing.InvalidateObject(NO);
      TargetPt.AdoptChildrenOf(SourcePt);
      If SourcePt.ClassType = TGIntersectPt then
        SourcePt.ShowsAlways := False
      else
        Drawing.InvalidateObject(SourcePt);
      Drawing.UpdateAllDescendentsOf(TargetPt);
      PaintBox1.Repaint;
      end;
    end;

  procedure MakePoint;
    begin
    If ExtPointCmd then begin
      Start.ExpectedType := ccAnyLine;
      FillSelectList(Last_XM, Last_YM);
      Case Selected.Count of
        0 : Drawing.InsertObject(TGPoint.Create(Drawing, Last_XM, Last_YM, True), ErrNum);
        1 : InitPointOnLine (Selected[0]);
        2 : IntersectObjects(Selected[0], Selected[1]);
      else
        MessageDlg(Format(MyMess[110], [Selected.Count]), mtInformation, [mbOk], 0);
      end; { of case }
      end
    else
      Drawing.InsertObject(TGPoint.Create(Drawing, Last_XM, Last_YM, True), ErrNum);
    end;

  procedure MakeLatticePt;
      begin
      end;

  procedure BindTBox2Obj(Comment: TGComment; GO: TGParentObj);
    begin
    With Comment do begin
      While Parent.Count > 0 do
        Stops2BeChildOf(Parent[0]);
      BecomesChildOf(GO);
      end;
    Drawing.SortObjects;
    end;

  procedure ReleaseTBox(Comment: TGComment);
    begin
    With Comment do
      If Parent.Count > 0 then begin
        While Parent.Count > 0 do
          Stops2BeChildOf(Parent[0]);
        end
      else
        MessageDlg(MyMess[42], mtInformation, [mbOk], 0);
    end;

  procedure ShowAngleWidth (P1, S, P2: TGeoObj);
    var WO,              { WinkelObjekt    }
        WMO : TGeoObj;   { WinkelMaßObjekt }
    begin
    WO  := Drawing.InsertObject(TGAngle.Create(Drawing, P1, S, P2, True), ErrNum);
    WMO := Drawing.InsertObject(TGAngleWidth.Create(Drawing, TGAngle(WO), True), ErrNum);
    If Not WMO.DataValid then begin
      Drawing.FreeObject(WMO);
      MessageDlg(MyMess[11], mtError, [mbOk], 0);
      end;
    end;

  procedure ShowAreaSize (GO: TGeoObj);
    var FO : TGArea;
    begin
    If GO is TGIntArea then
      Drawing.InsertObject(TGAreaSize.Create(Drawing, GO, True), ErrNum)
    else
      If GO is TGArea then
        If TGLine(GO.Parent[0]).IsClosedLine then
          Drawing.InsertObject(TGAreaSize.Create(Drawing, GO, True), ErrNum)
        else
          MessageDlg(MyMess[142], mtError, [mbOk], 0)
      else begin
        If (GO is TGLine) and (GO as TGLine).IsClosedLine then begin
          If Not (GO as TGLine).IsFilled(FO) then
            FO := Drawing.InsertObject(TGArea.Create(Drawing, GO as TGLine, True, GO.IsReversed),
                                       ErrNum) as TGArea;
          Drawing.InsertObject(TGAreaSize.Create(Drawing, FO, True), ErrNum);
          end
        else
          MessageDlg(MyMess[126], mtError, [mbOk], 0);
        end;
    end;


  procedure AddMeasure2Term (GO: TGeoObj);
    begin
    If GO.IsCompatibleWith(ccMeasureObj) then
      ActiveTermWin.AddObj2Term(GO);
    ActiveTermWin.SetFocus;
    end;


  procedure Add2Makro(GO: TGeoObj);
    var pm     : TMakro;
    begin
    pm := Drawing.MakroList.Last;
    With GO do begin
      IsMakMarked := True;
      If MakroMode = 2 then IsFlagged := True;
      end;
    Case MakroMode of
      1 : begin                          { Startobjekte registrieren }
          pm.RegisterStartObj(GO);
          If pm.MakroStatus = 0 then begin
            InitInputList(cmd_DefMakro, Nil, False);
            end
          else begin
            pm.ShowErrorMsg(MaCmdNum);
            Reset2DragMode;
            end
          end;
      2 : begin                          { Zielobjekte registrieren }
          pm.RegisterTargetObj(GO);
          If pm.MakroStatus = 0 then begin
            InitInputList(cmd_DefMakro, Nil, False);
            end
          else begin
            pm.ShowErrorMsg(MaCmdNum);
            Case pm.MakroStatus of
              -1 : MessageDlg(MyMakMsg[26], mtError, [mbOk], 0);
              -2 : MessageDlg(MyMakMsg[27], mtError, [mbOk], 0);
            else
              MessageDlg(MyMakMsg[21], mtError, [mbOk], 0);
            end; { of case }
            Reset2DragMode;
            end;
          end;
    end; { of case }
    end;

  procedure ExecuteMakro(GO: TGeoObj);
    var PM     : TMakro;
        PMC    : TMakroCmd;
    begin
    GO.SetAsStartObject4MacroRun(MakroNum, MaCmdNum);
    PM := Drawing.MakroList.Items[MakroNum];
    If PM.MakroStatus < 0 then begin
      PM.ShowErrorMsg(MaCmdNum);
      MakroMode := 0;
      end
    else begin
      Repeat
        Inc(MaCmdNum);
        PMC := PM.Items[MaCmdNum];
      until PMC.CmdType >= 0;                     { Implizite Startobjekte übergehen.       }

      If PMC.CmdType = 0 then                     { Falls ein StartObjekt bearbeitet wird : }
        InitInputList(cmd_RunMakro, Nil, False)   {   Eingabe vorbereiten !                 }
      else begin                                  { andernfalls:                            }
        PM.RunIt(MakroNum);                       {   Makrobefehle ausführen                }
        If PM.MakroStatus < 0 then
          PM.ShowErrorMsg(MaCmdNum);
        MakroMode := 0;
        end;
      end;
    end;


  procedure MakeMappedObj(map_type: Integer;
                          OriObj, MapDefObj1, MapDefObj2: TGeoObj;
                          withTraces: Boolean);

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
           zuvor erzeugt und schon *vor* dem Aufruf von MakeMappedObj in
           FLastMapping vermerkt worden sein. Siehe oben, Fall "map_type = 0"!}

      var newMap : TGTransformation;
          err, n : Integer;
      begin
      If map_type > 0 then begin
        If map_type = mapTranslation then       // Verschiebung normalisieren !
          MapDefObj1 := TGVector(MapDefObj1).GetAncestorVector;
        n := IndexOfTransformationIn(Drawing, map_type, MapDefObj1, MapDefObj2);
        If n >= 0 then
          FLastMapping := Drawing[n]
        else begin
          If map_type = mapInversion then
            newMap := TGInversion.Create(Drawing, MapDefObj1)
          else if map_type <= mapSimilarity then
            newMap := TGSimiliarity.Create(Drawing, map_type, MapDefObj1, MapDefObj2)
          else begin
            SpyOut('Falscher Aufruf von "SetMapping" mit affinem Map-Typ: %d !', [map_type]);
            newMap := Nil;  Halt(1);       // Das sollte nie(!) passieren !!!
            end;
          FLastAutoTrace := withTraces;
          FLastMapping := Drawing.InsertObject(newMap, err) as TGTransformation;
          If FLastMapping = newMap then    // Neu erzeugte Abbildungen in die
            RefreshMappingMenus;           //   Abbildungen-Menüs eintragen.
          end;
        end
      else
        map_type := FLastMapping.MapType;
      end;

    procedure ShowTrace(Pt, BPt : TGPoint);
      var s      : TGeoObj;
          n, err : Integer;
      begin
      n := Drawing.LastValidObjIndex;
      s := Nil;
      Case map_type of
        mapReflectionLine, mapReflectionPoint, mapDilation, mapInversion:
          s := Drawing.InsertObject(TGShortLine.Create(Drawing, Pt, BPt, False), err);
        mapTranslation:
          s := Drawing.InsertObject(TGVector.Create(Drawing, Pt, BPt, False), err);
        mapRotation:
          s := Drawing.InsertObject(TGArc.Create(Drawing, Pt, FLastMapping.Parent[0], BPt,
                                                 (FLastMapping as TGSimiliarity).IsReverse,
                                                 False), err);
      end;  // Für affine Abbildungen: keine Spuren erzeugen !
      If (Drawing.LastValidObjIndex > n) and (s <> Nil) then begin
        s.MyPenStyle  := psDot;
        s.ShowsAlways := True;
        end;
      end;

    procedure CreateMappedPoint;
      var p : TGPoint;
      begin
      p := TGMappedPoint.Create(Drawing, OriObj, FLastMapping, OriObj.IsVisible);
      p := Drawing.InsertObject(p, ErrNum) as TGPoint;
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
            p1 := TGMappedPoint.Create(Drawing, OriObj.Parent[0], FLastMapping, TGeoObj(OriObj.Parent[0]).IsVisible);
            p1 := Drawing.InsertObject(p1, ErrNum) as TGPoint;
            p2 := TGMappedPoint.Create(Drawing, OriObj.Parent[1], FLastMapping, TGeoObj(OriObj.Parent[1]).IsVisible);
            p2 := Drawing.InsertObject(p2, ErrNum) as TGPoint;
            Drawing.InsertObject(TGMSenkr.Create(Drawing, p1, p2, OriObj.IsVisible), ErrNum);
            If withTraces then begin
              ShowTrace(OriObj.Parent[0], p1);
              ShowTrace(OriObj.Parent[1], p2);
              end;
            end
          else  // Alle anderen Geraden-Typen
            Drawing.InsertObject(TGMappedLine.Create(Drawing, OriObj, FLastMapping, OriObj.IsVisible), ErrNum)
        else begin
          Assert((OriObj.Parent.Count = 2) and
                 (TGeoObj(OriObj.Parent[0]) is TGPoint) and
                 (TGeoObj(OriObj.Parent[1]) is TGPoint),
                 'Objekt kann wegen ungeeigneter Eltern nicht gespiegelt werden.');
          p1 := TGMappedPoint.Create(Drawing, OriObj.Parent[0], FLastMapping, TGeoObj(OriObj.Parent[0]).IsVisible);
          p1 := Drawing.InsertObject(p1, ErrNum) as TGPoint;
          p2 := TGMappedPoint.Create(Drawing, OriObj.Parent[1], FLastMapping, TGeoObj(OriObj.Parent[1]).IsVisible);
          p2 := Drawing.InsertObject(p2, ErrNum) as TGPoint;
          If OriObj is TGVector then
            Drawing.InsertObject(TGVector.Create(Drawing, p1, p2, True), ErrNum)
          else if OriObj is TGShortLine then
            Drawing.InsertObject(TGShortLine.Create(Drawing, p1, p2, True), ErrNum)
          else if OriObj is TGHalfLine then
            Drawing.InsertObject(TGHalfLine.Create(Drawing, p1, p2, True), ErrNum);
          If withTraces then begin
            ShowTrace(OriObj.Parent[0], p1);
            ShowTrace(OriObj.Parent[1], p2);
            end;
          end;
        end
      else begin // Spezialfall  Inversion am Kreis
        if OriObj is TGLongLine then
          Drawing.InsertObject(TGMappedCircle.Create(Drawing, OriObj, FLastMapping, OriObj.IsVisible), ErrNum)
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
      If map_type <= mapSimilarity then    // Kongruenz- und Ähnlichkeits-Abbildungen
        if OriObj.ClassType = TGCircle then begin  // Kreis durch Mittelpunkt und Kreispunkt
          p1 := TGMappedPoint.Create(Drawing, OriObj.Parent[0], FLastMapping, TGeoObj(OriObj.Parent[0]).IsVisible);
          Drawing.InsertObject(p1, ErrNum);
          p2 := TGMappedPoint.Create(Drawing, OriObj.Parent[1], FLastMapping, TGeoObj(OriObj.Parent[1]).IsVisible);
          Drawing.InsertObject(p2, ErrNum);
          NMC := Drawing.InsertObject(TGMappedCircle.Create(Drawing, OriObj, FLastMapping, True),
                                      ErrNum) as TGCircle;
          If (ErrNum = 0) and PolyFilled and TGCircle(OriObj).IsFilled(FO) then
            Drawing.InsertObject(TGArea.Create(Drawing, NMC, True, True), ErrNum);
          end
        else if OriObj is TGArc then begin        // Kreisbogen
          p1 := TGMappedPoint.Create(Drawing, OriObj.Parent[0], FLastMapping, TGeoObj(OriObj.Parent[0]).IsVisible);
          p1 := Drawing.InsertObject(p1, ErrNum) as TGPoint;
          p2 := TGMappedPoint.Create(Drawing, OriObj.Parent[1], FLastMapping, TGeoObj(OriObj.Parent[1]).IsVisible);
          p2 := Drawing.InsertObject(p2, ErrNum) as TGPoint;
          p3 := TGMappedPoint.Create(Drawing, OriObj.Parent[2], FLastMapping, TGeoObj(OriObj.Parent[2]).IsVisible);
          p3 := Drawing.InsertObject(p3, ErrNum) as TGPoint;
          revers := TGArc(OriObj).IsReversed xor FLastMapping.IsReversing;
          Drawing.InsertObject(TGArc.Create(Drawing, p2, p1, p3, revers, True), ErrNum);
          If withTraces then begin
            ShowTrace(OriObj.Parent[0], p1);
            ShowTrace(OriObj.Parent[1], p2);
            ShowTrace(OriObj.Parent[2], p3);
            end;
          end
        else begin                                // alle anderen Kreissorten
          NMC := Drawing.InsertObject(TGMappedCircle.Create(Drawing, OriObj, FLastMapping, True),
                                      ErrNum) as TGCircle;
          If (ErrNum = 0) and PolyFilled and TGCircle(OriObj).IsFilled(FO) then
            Drawing.InsertObject(TGArea.Create(Drawing, NMC, True, True), ErrNum);
          end
      else if map_type <= mapAffineMapMat then begin  // Affine Abbildungen
        Drawing.InsertObject(TGMappedConic.Create(Drawing, OriObj as TGLine, FLastMapping, True),
                             ErrNum);
        end
      else          // d.h. map_type = mapInversion, also: Inversion am Kreis
        If OriObj.ClassType <> TGArc then begin
          NMC := Drawing.InsertObject(TGMappedCircle.Create(Drawing, OriObj, FLastMapping, True),
                                      ErrNum) as TGCircle;
          If (ErrNum = 0) and PolyFilled and
             (OriObj.ClassType <> TGArc) and
             (TGCircle(OriObj).IsFilled(FO)) then
            Drawing.InsertObject(TGArea.Create(Drawing, NMC, True, True), ErrNum);
          end
        else
          MessageDlg(MyMess[70], mtError, [mbOk], 0);
      end;

    procedure CreateMappedPolygon;
      var PList  : TList;
          OV, NV : TGPoint;    { "O"riginal "V"ertex,  "N"ew "V"ertex }
          NPO    : TGPolygon;
          NRPO   : TGRegPoly;
          FO     : TGArea;     { 'F'ill 'O'bject }
          i      : Integer;
      begin
      If map_type <> mapInversion then
        If OriObj.ClassType = TGPolygon then begin  // Urbild ist ein "normales" Polygon
          PList := TList.Create;
          For i := 0 to Pred(OriObj.Parent.Count) do begin
            OV := Drawing.InsertObject(TGMappedPoint.Create(Drawing, OriObj.Parent[i], FLastMapping, True),
                                       ErrNum) as TGPoint;
            If withTraces then
              ShowTrace(OriObj.Parent[i], OV);
            PList.Add(OV);
            end;
          PList.Add(PList.Items[0]);
          For i := 1 to Pred(PList.Count) do
            Drawing.InsertObject(TGShortLine.Create(Drawing, PList[Pred(i)], PList[i], True), ErrNum);
          NPO := Drawing.InsertObject(TGPolygon.Create(Drawing, PList, True),
                                      ErrNum) as TGPolygon;
          NPO.IsReversed := OriObj.IsReversed xor FLastMapping.IsReversing;
          If (ErrNum in [0, 5]) and     { ErrNum "5" ergänzt 27.06.06 wg. Kittel-Problem }
             PolyFilled and TGPolygon(OriObj).IsFilled(FO) then
            Drawing.InsertObject(TGArea.Create(Drawing, NPO, True, True), ErrNum);
          PList.Free;
          end
        else begin  // Urbild ist ein reguläres Polygon
          If map_type <= mapSimilarity then begin // Bild ist auch regulär
            NRPO := Drawing.InsertObject(TGMappedRegPoly.Create(Drawing, OriObj as TGRegPoly, FLastMapping),
                                        ErrNum) as TGRegPoly;
            PList := TList.Create;
            For i := 0 to Pred(NRPO.VCount) do begin
              NV := Drawing.InsertObject(TGVertexPt.Create(Drawing, NRPO, i, True),
                                         ErrNum) as TGPoint;
              PList.Add(NV);
              end;
            PList.Add(PList.Items[0]);
            For i := 1 to Pred(PList.Count) do
              Drawing.InsertObject(TGShortLine.Create(Drawing, PList[Pred(i)], PList[i], True),
                                   ErrNum);
            PList.Free;
            end
          else begin  // Bild ist nicht notwendigerweise regulär
            PList := TList.Create;
            For i := 0 to 1 do begin
              NV := Drawing.InsertObject(TGMappedPoint.Create(Drawing, OriObj.Parent[i], FLastMapping, True),
                                         ErrNum) as TGPoint;
              PList.Add(NV);
              end;
            For i := 2 to Pred((OriObj as TGRegPoly).VCount) do begin
              OV := Drawing.InsertObject(TGVertexPt.Create(Drawing, OriObj, i, False),
                                         ErrNum) as TGPoint;
              NV := Drawing.InsertObject(TGMappedPoint.Create(Drawing, OV, FLastMapping, True),
                                         ErrNum) as TGPoint;
              PList.Add(NV);
              end;
            PList.Add(PList.Items[0]);
            For i := 1 to Pred(PList.Count) do
              Drawing.InsertObject(TGShortLine.Create(Drawing, PList[Pred(i)], PList[i], True), ErrNum);
            Drawing.InsertObject(TGPolygon.Create(Drawing, PList, True),
                                 ErrNum);
            PList.Free;
            end
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
          MC := TGMappedConic.Create(Drawing, OriObj as TGConic, FLastMapping, OriObj.IsVisible)
        else if OriObj is TGLocLine then
          MC := TGMappedLocLine.Create(Drawing, OriObj as TGLocLine, FLastMapping);
        If MC <> Nil then
          Drawing.InsertObject(MC, ErrNum)
        else
          MessageDlg(MyMess[70], mtError, [mbOk], 0);
        end
      else
        MessageDlg(MyMess[70], mtError, [mbOk], 0);
      end;

    procedure CreateMappedImage;
      begin
      If map_type in [mapReflectionLine..mapAffineMapMat] then
        Drawing.InsertObject(TGMappedImage.Create(Drawing, OriObj as TGImage, FLastMapping, OriObj.IsVisible), ErrNum)
      else
        MessageDlg(MyMess[70], mtError, [mbOk], 0);
      end;

    begin { of MakeMappedObj }
    SetMapping;
    If FLastMapping <> Nil then begin
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



  procedure ConvertBase2CoordPt(GO: TGeoObj);
    var n : Integer;
    begin
    n := Drawing.IndexOf(GO);
    Drawing.ConvertBase2CoordPt(GO);
    If n >= 0 then
      LastSelectedObj := Drawing.Items[n];
    TGPoint(LastSelectedObj).CheckChildLinesCBDI;
    n := Selected.IndexOf(GO);
    If n >= 0 then
      Selected.Items[n] := LastSelectedObj;
    Drawing.UpdateAllDescendentsOf(LastSelectedObj);
    GO.Free;
    end;

  procedure ClipToGrid (GP: TGeoObj);
    var GC  : TGeoObj;
        Num : Integer;
    begin
    Num := GP.GeoNum;
    If GP.ClassType = TGPoint then
      ConvertBase2CoordPt(GP);
    GC := Drawing.GetObj(Num);
    If GC.ClassType = TGXPoint then begin
      TGXPoint(GC).Clip2Grid;
      Drawing.DragObjects(Last_XM, Last_YM, False);
      end;
    end;

  procedure ConvertCoord2BasePt(GO: TGeoObj);
    var n : Integer;
    begin
    If TGPoint(GO).IsInLoopOfCLSegments then
      MessageDlg(Format(MyMess[92], [GO.Name]), mtWarning, [mbOk], 0)
    else begin
      n := Drawing.IndexOf(GO);
      Drawing.ConvertCoord2BasePt(GO);
      If n >= 0 then
        LastSelectedObj := Drawing.Items[n];
      With TGPoint(LastSelectedObj) do begin
        CheckFriendlyLinks;
        CheckChildLinesCBDI;
        end;
      n := Selected.IndexOf(GO);
      If n >= 0 then
        Selected.Items[n] := LastSelectedObj;
      Drawing.UpdateAllDescendentsOf(LastSelectedObj);
      GO.Free;
      end;
    end;

  procedure EditTermDisp;
    begin
    If ActPopupObj = Nil then
      ActPopupObj := LastSelectedObj;
    TGTermObj(ActPopupObj).SetNewTerm(LastValueWStr[0]);
    Reset2DragMode;
    end;

  procedure FillArea(FillObj: TGeoObj; OrientPt: TGPoint);
    var nx, ny : Double;
        ori    : Boolean;
        newFS  : TBrushStyle;
        newFObj: TGArea;
    begin
    If (FillObj is TGLongLine) and           { Orientierungspunkt benötigt ! }
       (Start.ExpectedCount < 2) then begin
      GeoTimer.InitObjBlinking(Drawing);
      FillObj.InitBlinking(True);
      ShowMyHint(71);
      Start.ExpectedCount := 2;
      Start.ExpectedType  := ccAnyPoint;    { unbedingt ccAnyPoint! }
      end
    else begin                              { andernfalls :         }
      If ssAlt in LastShiftState then
        If FillObj is TGArea then
          Self.GetActGraphToolsFrom(FillObj)
        else  { nix machen }
      else begin
        Start.ExpectedCount := -1;  { verursacht Neu-Initialisierung  }
        If FillObj is TGLongLine then begin
          nx := TGLongLine(FillObj).Y1 - TGLongLine(FillObj).Y2;
          ny := TGLongLine(FillObj).X2 - TGLongLine(FillObj).X1;
          ori := (OrientPt.X - TGLongLine(FillObj).X1) * nx +
                 (OrientPt.Y - TGLongLine(FillObj).Y1) * ny >= 0;
          If Drawing.LastValidObjIndex > Last2Show then begin
            OrientPt.ShowsAlways := False;    { Orientierungspunkt kann nun   }
            Drawing.FreeObject(OrientPt);     {   wieder gelöscht werden      }
            end;
          end
        else if FillObj is TGArc then
          ori := Not (FillObj as TGArc).IsReversed
        else
          ori := True;
        If FillObj is TGArea then
          TGArea(FillObj).SetGraphTools(ToolLineStyleNum, ToolPointStyleNum,
                                        ToolFillStyleNum, ToolFillColour)
        else
          If TGLine(FillObj).IsFilled(newFObj) then
            TGArea(newFObj).SetGraphTools(ToolLineStyleNum, ToolPointStyleNum,
                                          ToolFillStyleNum, ToolFillColour)

          else begin
            newFObj := TGArea.Create(Drawing, TGLine(FillObj), True, ori);
            newFObj := Drawing.InsertObject(newFObj, ErrNum) as TGArea;
            newFObj.SetGraphTools(ToolLineStyleNum, ToolPointStyleNum,
                                  ToolFillStyleNum, ToolFillColour);
            Last2Show := -1;
            end;

       { Ist die folgende Automatik nicht überflüssig / kontraproduktiv ?
         Falls sie gelöscht wird: Hilfe anpassen !!! }

        If Drawing.HasEmptyBorders then begin
          Drawing.GetFreeFillPattern(ToolFillColour, newFS);
          ToolFillStyleNum := Integer(newFS);
          RefreshEditGlyph(SB_Patterns, FillStyleStartIndex + ToolFillStyleNum);
          ChangeColourGlyph(SB_FillColour, ToolFillColour);
          end;

        end;
      end;
    end;

  procedure CutArea(ExArea: TGArea; CutLine: TGLine; OrientPt: TGPoint);
    var wx, wy : Integer;
    begin
    Drawing.GetWinCoords(OrientPt.X, OrientPt.Y, wx, wy);
    ExArea.CutAtLine(CutLine, Point(wx, wy));
    If Drawing.LastValidObjIndex > Last2Show then begin
      OrientPt.ShowsAlways := False;
      Drawing.FreeObject(OrientPt);
      end;
    Last2Show := -1;
    Start.ExpectedCount := -1;  { verursacht Neu-Initialisierung  }
    end;

  procedure ToggleGroupMembershipOf(GO: TGeoObj);
    var NameObj: TGName;
    begin
    GO.IsGrouped := Not GO.IsGrouped;
    If GO.HasNameObj(NameObj) then
      NameObj.IsGrouped := GO.IsGrouped;
    Drawing.IsDirty := True;
    InitInputList(cmd_Group, Nil);
    end;


  procedure AffAssProc;

    const MaxASMLIndex   = 26;
          AffSubModeList : Array [0..MaxASMLIndex, 0..1] of Integer =
                ((10, ccStraightLine), (11, ccAnyPoint), (12, ccAnyPoint),
                 (20, ccStraightLine), (21, ccAnyPoint), (22, ccAnyPoint),
                 (30, ccStraightLine), (31, ccAnyPoint), (32, ccAnyPoint),
                 (40, ccStraightLine), (41, ccAnyPoint), (42, ccAnyPoint),
                 (50, ccStraightLine), (51, ccStraightLine),
                 (52, ccAnyPoint), (53, ccAnyPoint),
                 (60, ccAnyPoint), (61, ccAnyPoint), (62, ccAnyPoint),
                 (63, ccAnyPoint), (64, ccAnyPoint),
                 (70, ccAnyPoint), (71, ccAnyPoint), (72, ccAnyPoint),
                 (73, ccAnyPoint), (74, ccAnyPoint), (75, ccAnyPoint));

    var net, n,                  { "N"ext "E"xpected "T"ype            }
        err : Integer;
        lpi : TGLine;            { "L"ocus of "P"ossible "I"magePoints }
        nm  : TGTransformation;  { "N"ew "M"apping                     }
        GO  : TGeoObj;
        ps  : String;            { "P"atch "S"tring                    }

    function GetExpType(mo: Integer): Integer;
      var i : Integer;
      begin
      Result := -1;
      i      := -1;
      Repeat
        i := i + 1;
      until (i > MaxASMLIndex) or (AffSubModeList[i, 0] = mo);
      If i <= MaxASMLIndex then
        Result := AffSubModeList[i, 1];
      end;

    procedure ProcessLPI;
      var err : Integer;
      begin
      If Drawing.IndexOf(lpi) < 0 then
        lpi := Drawing.InsertObject(lpi, err) as TGLine;
      lpi.MyPenStyle := psDash;
      lpi.MyColour := clRed;
      lpi.ShowsAlways := True;
      lpi.IsBlinking  := True;
      Inc(Start.ExpectedCount);
      Start.Add(lpi);     //  fügt lpi als Start[2] hinzu
      PaintBox1Paint(Self);
      end;

    procedure AdjustImagePt;
      var npt : TGPoint;         { "N"ew "P"oint }
          TL  : TGLine;
          AUD : TAskUser1Dlg;
      begin
      If Not TGPoint(Start[3]).IsIncidentWith(Start[2]) then  // = Not {"liegt immer drauf"} !
        If TGeoObj(Start[3]).ClassType = TGPoint then   // ist Basispunkt
          If Not (TGPoint(Start[3]).IsLineBound(TL) and (TL = Start[2])) then
            BindPointToLine(Start[3], Start[2])   // gegebenenfalls binden !
          else
        else begin  // ist kein Basispunkt, also User fragen!
          AUD := TAskUser1Dlg.Create(Self);
          try
            AUD.ShowModal;
            Case AUD.Selected of
             0 : ;      // Nix tun, sondern vorhandenen Punkt verwenden !
             1 : begin  // Neuen Basispunkt erzeugen und an Linie binden !
                 npt := TGPoint.Create(Drawing, TGeoObj(Start[3]).X, TGeoObj(Start[3]).Y, True);
                 Start[3] := Drawing.InsertObject(npt, err);
                 BindPointToLine(Start[3], Start[2]);
                 end;
             2 : AffinMapSubVers := -1;  // Abbruch
            end; { of case }
          finally
            AUD.Free;
          end; { of try }
          end;
      end;

    function GetParallel(pt, dir: TGeoObj): TGLine;
      var tg : TGStraightLine;    // "T"est-"G"erade
          TL : TGLine;            // "T"räger-"L"inie
          i  : Integer;
      begin
      Result := Nil;
      i := 0;
      While (Result = Nil) and (i <= Drawing.LastValidObjIndex) do begin
        If TGeoObj(Drawing.Items[i]) is TGStraightLine then begin
          tg := TGStraightLine(Drawing.Items[i]);
          If (tg <> dir) and
             (tg.IsParallelTo(dir as TGStraightLine)) and
             ((pt as TGPoint).IsIncidentWith(dir as TGStraightLine) or
              ((pt as TGPoint).IsLineBound(TL) and (TL = tg))) then
            Result := tg;
          end;
        i := i + 1;
        end;
      If Result = Nil then
        Result := TGParall.Create(Drawing, pt, dir, False);
      end;

    function ReflectedParallel : TGLine;
      var mp : TGPoint;         { "M"irror "P"oint }
          r  : TGSimiliarity;   { "R"eflection     }
          err, n : Integer;
      begin
      n := IndexOfTransformationIn(Drawing, mapReflectionLine, Start[0], Nil);
      If n >= 0 then
        r := Drawing[n]
      else begin
        r := TGSimiliarity.Create(Drawing, mapReflectionLine, Start[0], Nil);
        Drawing.InsertObject(r, err);
        end;
      mp := TGMappedPoint.Create(Drawing, Start[1], r, False);
      mp := Drawing.InsertObject(mp, err) as TGPoint;
      Result := GetParallel(mp, Start[0]);
      end;

    var AA3  : TAffAbb_3_Dlg;
        AA3a : TAffAbb_3a_Dlg;
        AA3b : TAffAbb_3b_Dlg;

    begin { of AffAssProc }
    nm := Nil;
    Case AffinMapSubVers of    // Eingegebenes Objekt verarbeiten
      11 : begin
           lpi := GetParallel(Start[1], Start[0]);
           ProcessLPI;
           end;
      12 : begin
           AdjustImagePt;
           If AffinMapSubVers > 0 then
             nm := TGAffinMapping.CreateAxAff(Drawing, mapSheer,
                                              Start[0], Start[1], Start[3]);
           end;
      21 : begin
           lpi := TGSenkr.Create(Drawing, Start[1], Start[0], False);
           ProcessLPI;
           end;
      22 : begin
           AdjustImagePt;
           If AffinMapSubVers > 0 then
             nm := TGAffinMapping.CreateAxAff(Drawing, mapOrthAxDilation,
                                              Start[0], Start[1], Start[3]);
           end;
      31 : begin
           lpi := ReflectedParallel;
           ProcessLPI;
           end;
      32 : begin
           AdjustImagePt;
           If AffinMapSubVers > 0 then
             nm := TGAffinMapping.CreateAxAff(Drawing, mapSheerReflection,
                                              Start[0], Start[1], Start[3]);
           end;
      42 : nm := TGAffinMapping.CreateAxAff
                   (Drawing, mapAxAffinMapping, Start[0], Start[1], Start[2]);
      53 : nm := TGAffinMapping.CreateEuler
                   (Drawing,  Start[0], Start[1], Start[2], Start[3]);
      64 : nm := TGAffinMapping.CreateAffRot
                   (Drawing, Start[0], Start[1], Start[2], Start[3], Start[4]);
      75 : nm := TGAffinMapping.CreateGen3PP
                   (Drawing, Start[0], Start[1], Start[2], Start[3], Start[4], Start[5]);
      80 : If ActiveTermWin <> Nil then begin
             AddMeasure2Term(Start.Items[0]);
             Exit;  // Überspringt den hier obsoleten Code weiter unten !
             end;
      81 : nm := TGAffinMapping.CreateGenTerms
                   (Drawing, LastValueWStr[0], LastValueWStr[1], LastValueWStr[2],
                             LastValueWStr[3], LastValueWStr[4], LastValueWStr[5]);
    end;
    net := GetExpType(AffinMapSubVers + 1);
    If net > 0 then begin      // Weiterschalten zum nächsten Schritt
      Inc(AffinMapSubVers);
      Inc(Start.ExpectedCount);
      Start.ExpectedType  := net;
      With ActiveTermWin as TAffAbb_2_Dlg do
        VisState := VisState + 1;
      end
    else begin    // *Nach* der Erstellung einer neuen affinen Abbildung
      ps := (ActiveTermWin as TAffAbb_2_Dlg).PatchStr;
      ActiveTermWin.Close;
      FreeAndNil(ActiveTermWin);
      If Assigned(nm) and nm.DataValid then   // Abbildung okay und
        If Not Drawing.ExistObject(nm, GO) then begin // noch nicht vorhanden
          FLastMapping := Drawing.InsertObject(nm, err) as TGTransformation;
          RefreshMappingMenus;
          AA3 := TAffAbb_3_Dlg.Create(Self);
          AA3.Left := AffAssPos.X;
          AA3.Top  := AffAssPos.Y;
          AA3.InitTexts(ps);
          n := AA3.ShowModal;
          AA3.Free;
          If n = mrOk then
            NextCmd := cmd_MapObj;
          end
        else begin                                  // Abbildung schon vorhanden
          AA3b := TAffAbb_3b_Dlg.Create(Self);
          AA3b.Left := AffAssPos.X;
          AA3b.Top  := AffAssPos.Y;
          AA3b.InitTexts(ps);
          AA3b.ShowModal;
          AA3b.Free;
          FreeAndNil(nm);
          FLastMapping := Nil;
          end
      else
        if AffinMapSubVers > 0 then begin     // Abbildung fehlerhaft
          AA3a := TAffAbb_3a_Dlg.Create(Self);
          AA3a.Left := AffAssPos.X;
          AA3a.Top  := AffAssPos.Y;
          AA3a.InitTexts(ps);
          n := AA3a.ShowModal;
          AA3a.Free;
          If n = mrOk then begin         // bisher ungenutzter Spezialfall
            FLastMapping := Drawing.InsertObject(nm, err) as TGTransformation;
            RefreshMappingMenus;
            end
          else begin                     // Normalfall
            FreeAndNil(nm);
            FLastMapping := Nil;
            end;
          end;
      FModus := cmd_DefAffReady; // *Nach* der Erstellung: raus!
      end;
    end;  { of AffAssProc }

  procedure MakeGraphArea;
    var NIA: TGIntArea;
        i  : Integer;
    begin
    If Start.Count < 4 then begin   // Liste ergänzen
      Start.ExpectedType  := ccFunktionOrAxis;
      Start.ExpectedCount := 4;
      If Start.Count = 3 then ShowMyHint(94);
      MakroMode := 1;     // Missbräuchliche, aber zielführende Verwendung:
      end                 //   verhindert Reset2DragMode !
    else begin
      If TGeoObj(Start[3]) is TGFunktion then
        NIA := TGIntArea.Create(Drawing, Start[0], Start[3], Start[1], Start[2])
      else
        NIA := TGIntArea.Create(Drawing, Start[0], Nil, Start[1], Start[2]);
      Drawing.InsertObject(NIA, ErrNum);
      For i := 1 to 2 do
        If (TGeoObj(Start[i]).ClassType = TGPoint) and
           (TGPoint(Start[i]).Parent.Count = 0) then begin
          Last_XM := TGPoint(Start[i]).scrx;
          Last_YM := TGPoint(Start[i]).scry;
          BindPointToLine(Start[i], TGeoObj(Drawing.Items[1]) as TGAxis);
          end;
      MakroMode := 0;
      end;
    end;

  procedure MakeRiemannArea;
    var NRO : TGRiemannArea;    // "N"ew "R"iemann "O"bject
        ORO : TGeoObj;          // "O"ther "R"iemann "O"bject
        rt, n,
        i   : Integer;
    begin
    If Length(LastValueWStr[0]) = 0 then begin
      Start.SaveState;
      ShowMyHint(106);
      RiemannWin.EditTerm.HTMLTextAsString := IntToStr(4);
      RiemannWin.Show;
      end
    else begin
      Start.RestoreState;
      If LastValueWStr[1] = '0' then
        rt := 1
      else
        rt := 0;
      NRO := TGRiemannArea.Create(Drawing, Start[0], Start[1], Start[2], rt, LastValueWStr[0]);
      If (rt > 0) and NRO.HasSibling(ORO) then
        n := Drawing.IndexOf(ORO)
      else
        n := -1;
      Drawing.InsertObject(NRO, ErrNum, n);
      For i := 1 to 2 do
        If (TGeoObj(Start[i]).ClassType = TGPoint) and
           (TGPoint(Start[i]).Parent.Count = 0) and
           (TGPoint(Start[i]).Quant < epsilon) then begin
          Last_XM := TGPoint(Start[i]).scrx;
          Last_YM := TGPoint(Start[i]).scry;
          BindPointToLine(Start[i], TGeoObj(Drawing.Items[1]) as TGAxis);
          end;
      Reset2DragMode;
      end;
    end;

  procedure CheckSolution;
    var ZielObj   : Array of TGeoObj;
        GoOn      : Boolean;
        CCO       : TGCheckControl;
        VVSL      : TStringList;   // "V"alidation "V"ariables "S"tring "L"ist
        ValResDlg : TValidationResultWin;
        VarCount,
        res, i    : Integer;
    begin
    CCO  := Drawing.CheckControl as TGCheckControl;
    VVSL := TStringList.Create;
    try
      VVSL.Text := CCO.VVars;
      VarCount  := VVSL.Count;
      If Start.Count < VarCount then begin  // Während der Zielobjekt-Eingabe
        If GeoTimer.Status = 0 then
          GeoTimer.InitObjBlinking(Drawing);
        TGeoObj(Start.Last).IsBlinking := True;
        Start.ExpectedType  := GetValidationVarType(VVSL.ValueFromIndex[Start.Count]);
        Start.ExpectedCount := Start.ExpectedCount + 1;
        MakroMode := 1;        // Missbräuchliche, aber zielführende Verwendung:
        end                    // Verhindert Reset2DragMode !
      else begin  // Jetzt sind alle Zielobjekte da !
        MakroMode := 0;        // Rest2DragMode wieder zulassen
        Screen.Cursor := crHourGlass;
        GeoTimer.Reset(Drawing);
        Drawing.DrawFirstObjects(Drawing.LastValidObjIndex);
        SetLength(ZielObj, Start.Count);
        For i := 0 to Pred(Start.Count) do
          ZielObj[i] := Start[i];
        res := Drawing.CheckSolution(ZielObj);
        Screen.Cursor := crDefault;
        Case res of
          0 : begin                   // Alles okay, Zeichung korrekt !
              GoOn := Length(Drawing.LinkForward) > 0;
              ValResDlg := TValidationResultWin.CreateWD(PaintBox1, True, GoOn);
              With ValResDlg do begin
                ShowModal;
                GoOn := GoOn and CB_GoToNext.Checked;
                end;
              ValResDlg.Release;
              If GoOn then
                JumpLink(Drawing.LinkForward);
              end;
          1 : begin                   // Fehler in Korrektheits-Bedingung
              Drawing.SimClose;
              MessageDlg(MyMess[111],
                         mtError, [mbOk], cmd_CheckSol);
              end;
          2 : begin                   // Zeichnung nicht korrekt
              GoOn := Length(Drawing.LinkBack) > 0;
              ValResDlg := TValidationResultWin.CreateWD(PaintBox1, False, GoOn);
              With ValResDlg do begin
                ShowModal;
                GoOn := CB_GoToNext.Enabled and CB_GoToNext.Checked;
                end;
              ValResDlg.Release;
              If GoOn then begin
                Drawing.SimClose;
                JumpLink(Drawing.LinkBack);
                end
              else begin
                Drawing.SimDrag(True, 1);  // Zurück in Anfangslage !
                Drawing.SimClose;
                end;
              end;
        end; { of case }
        end; { of else }
    finally
      ZielObj := Nil;
      VVSL.Free;
    end;
    end;  { of CheckSolution }

  procedure EditMap;
    var ActMapping: TGMatrixMap;
    begin
    If (FLastMapping <> Nil) and (FLastMapping is TGMatrixMap) then begin
      ActMapping := FLastMapping as TGMatrixMap;
      ActMapping.SetMatrixStr(0, 0, LastValueWStr[0]);
      ActMapping.SetMatrixStr(0, 1, LastValueWStr[1]);
      ActMapping.SetMatrixStr(1, 0, LastValueWStr[2]);
      ActMapping.SetMatrixStr(1, 1, LastValueWStr[3]);
      ActMapping.SetMatrixStr(2, 0, LastValueWStr[4]);
      ActMapping.SetMatrixStr(2, 1, LastValueWStr[5]);
      ActMapping.UpdateParams;
      Drawing.UpdateAllDescendentsOf(ActMapping);
      end;
    end;

  procedure MakeIPolynomFunction;
    var npt, apt: TGPoint;  // 'n'ew_'p'oin't', 'a'ctual_'p'oin't'
        pl      : TList<TGPoint>;  // 'p'oint_'l'ist
        noDPt   : Boolean;  // 'No_D'ouble_'P'oin't'
        i       : Integer;
    begin
    noDPt := True;
    npt := TGeoObj(Start.Last) as TGPoint;
    for i := 0 to Start.Count - 2 do begin
      apt := TGeoObj(Start.Items[i]) as TGPoint;
      if Abs(apt.X - npt.X) < mathlib.epsilon then
        noDPt := False
      else
        apt.IsBlinking := True; // apt.InitBlinking(True);
      end;
    if noDPt then begin
      npt.InitBlinking(true);
      Inc(Start.ExpectedCount);
      Start.ExpectedType := ccAnyPoint;
      GeoTimer.InitObjBlinking(Drawing);
      end
    else begin
      pl := TList<TGPoint>.Create;
      try
        for i := 0 to Start.Count - 2 do begin
          npt := TGeoObj(Start.Items[i]) as TGPoint;
          pl.Add(npt);
          end;
        Drawing.InsertObject(TGIPolynomFkt.Create(Drawing, pL), ErrNum);
      finally
        pL.Free;
      end; // of try
      Reset2DragMode;
      Drawing.UpdateAllObjects;
      Drawing.Repaint;
      end; // of else begin
    end;

  procedure BuildMagnGlass;
    var frPtLi, frPtRe : TGeoObj;
        LogSlider     : TGLogSlider;
    begin
    LogSlider := Drawing.GetLogSlider;
    MagnGlassFrame := TGZoomFrame.Create(Drawing, Start.Items[0], LogSlider, 0, 0);
    Drawing.InsertObject(MagnGlassFrame, ErrNum);
    frPtLi := Drawing.InsertObject(TGFramePt.Create(Drawing, MagnGlassFrame, true), ErrNum);
    frPtRe := Drawing.InsertObject(TGFramePt.Create(Drawing, MagnGlassFrame, false), ErrNum);
    MagnGlassFrame.SetFramePt(frPtLi as TGFramePt);
    MagnGlassFrame.SetFramePt(frPtRe as TGFramePt);
    MagnGlassWin := TMyMagnGlassWin.CreateWD(Self, Start.Items[0], 500, 50);
    MagnGlassWin.visible := True;
    RefreshSpecialImageButtons;
    end;

  begin { of ProcessGeoObject }
  If (OLineMode = 0) and (MakroMode = 0) and (GeoTimer.Enabled) and
     (Not(Modus in [cmd_DefineAffin, cmd_NCreate, cmd_Conic, cmd_group,
                    cmd_CheckSol, cmd_GraphArea, cmd_Riemann, cmd_EditMap])) then
    GeoTimer.Reset(Drawing);

  NextCmd := -1;             { Erst mal keinen Folgebefehl einschalten! }
  ErrNum := valid_objects_selected;
  If ErrNum = 0 then begin   { okay : selektierte Objekte sind gültig.  }
    Case Modus of
      cmd_Drag,
      cmd_Game02,
      cmd_EditLineStyle,
      cmd_EditPointStyle : ;  { Nix zu tun. }

      cmd_ToggleVis  : ToggleObjVis(Start.Items[0]);
      cmd_Area2ForeGr: BringPoly2Front(Start.Items[0]);
      cmd_NameObj    : NameObject(Start.Items[0]);
      cmd_DelObj     : DelGeoObj(Start.Items[0]);
      cmd_EditDraw   : EditDrawing(Start.Items[0]);

      cmd_PCreate    : MakePoint;  // Wegen "Smart Point Command" (automatische Schnittpunkte bzw. Bindung an Linien)
      cmd_LatticePt  : Drawing.InsertObject(TGPoint.CreateAsLatticePt(Drawing, Last_XM, Last_YM, True), ErrNum);
      cmd_SCreate    : Drawing.InsertObject(TGShortLine.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      cmd_Vector     : Drawing.InsertObject(TGVector.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      cmd_GCreate    : Drawing.InsertObject(TGLongLine.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      cmd_KCreate    : Drawing.InsertObject(TGCircle.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      cmd_Circle3P   : Drawing.InsertObject(TGCircle3P.Create(Drawing, Start.Items[0], Start.Items[1], Start.Items[2], True), ErrNum);
      cmd_MCreate    : If ActiveTermWin <> Nil then
                         AddMeasure2Term(Start.Items[0])
                       else
                         Drawing.InsertObject(TGXCircle.Create(Drawing, Start.Items[0], LastValueWStr[0], True), ErrNum);
      cmd_CircleSLR  : CreateCircleSLR;
      cmd_Arc        : Drawing.InsertObject(TGArc.Create(Drawing, Start.Items[0], Start.Items[1], Start.Items[2], False, True), ErrNum);
      cmd_DCreate    : CreateTriangle;
      cmd_NCreate    : MakePolygon;
      cmd_RegPoly    : MakeRegPoly;
      cmd_Conic      : MakeConic;
      cmd_EllipseF   : Drawing.InsertObject(TGEllipseF.Create(Drawing, Start.Items[0], Start.Items[1], Start.Items[2], True), ErrNum);
      cmd_EllipseS   : Drawing.InsertObject(TGEllipseS.Create(Drawing, Start.Items[0], Start.Items[1], Start.Items[2], True), ErrNum);
      cmd_EllipseK   : Drawing.InsertObject(TGEllipseK.Create(Drawing, Start.Items[0], Start.Items[1], Start.Items[2], True), ErrNum);
      cmd_ParabelF   : Drawing.InsertObject(TGParabelF.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      cmd_ParabelT   : MakeBezierParabola;
      cmd_HyperbelF  : Drawing.InsertObject(TGHyperbelF.Create(Drawing, Start.Items[0], Start.Items[1], Start.Items[2], True), ErrNum);
      cmd_HyperbelA  : Drawing.InsertObject(TGHyperbelA.Create(Drawing, Start.Items[0], Start.Items[1], Start.Items[2], True), ErrNum);
      cmd_RCreate    : StartBasicLongLine;
      cmd_FCreate    : StartBasicCircle;
      cmd_LCreate    : CreateFixLine(Start.Items[0], Start.Items[1], TPt[1].x);
      cmd_PtCoord,
      cmd_EditRadius,
      cmd_EditAngle,
      cmd_EditCoords,
      cmd_EditLength,
      cmd_EditFunktion,
      cmd_EditRieIntCount,
      cmd_Graph       : If ActiveTermWin <> Nil then
                          AddMeasure2Term(Start.Items[0]);

      cmd_EditGroup   : If ActiveTermWin <> Nil then
                          if Start.Count > 0 then
                            AddMeasure2Term(Start.Items[0])
                          else
                            ActiveTermWin.SetFocus;

      cmd_EditComment : EditComment(Start.Items[0]);
      cmd_BindTBox2Obj: BindTBox2Obj(Start.Items[0], Start.Items[1]);
      cmd_ReleaseTBox : ReleaseTBox(Start.Items[0]);

      cmd_PonLine     : InitPointOnLine(Start.Items[0]);
      cmd_Schnitt     : IntersectObjects(Start.Items[0], Start.Items[1]);
      cmd_Mitte       : Drawing.InsertObject(TGMiddlePt.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);

      cmd_MirrorAxisObj  : MakeMappedObj(mapReflectionLine, MapObj(Start.Items[0]), Start.Items[1], Nil, AutoTraceMirrorAxis);
      cmd_MirrorCentreObj: MakeMappedObj(mapReflectionPoint, MapObj(Start.Items[0]), Start.Items[1], Nil, AutoTraceMirrorCentre);
      cmd_MoveObj        : MakeMappedObj(mapTranslation, MapObj(Start.Items[0]), Start.Items[1], Nil, AutoTraceMove);
      cmd_RotateObj      : MakeMappedObj(mapRotation, MapObj(Start.Items[0]), Start.Items[1], Start.Items[2], AutoTraceRotate);
      cmd_StretchObj     : MakeMappedObj(mapDilation, MapObj(Start.Items[0]), Start.Items[1], Start.Items[2], AutoTraceStretch);
      cmd_MirrorCircleObj: MakeMappedObj(mapInversion, Start.Items[0], Start.Items[1], Nil, False);
      cmd_MapObj,
      cmd_RepeatMapping  : MakeMappedObj(0, MapObj(Start.Items[0]), Nil, Nil, FLastAutoTrace);

      cmd_Strahl     : Drawing.InsertObject(TGHalfLine.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      cmd_MSenkr     : Drawing.InsertObject(TGMSenkr.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      cmd_WHalb,
      cmd_WHalbKomp  : MakeBisector;
      cmd_Lot,
      cmd_LotStrecke : MakeOrthogonalLine;
      cmd_Parall     : Drawing.InsertObject(TGParall.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      cmd_Tangente,
      cmd_Normale    : MakeTangentOrNormal;
      cmd_Polare     : Drawing.InsertObject(TGPolare.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      cmd_Pol        : Drawing.InsertObject(TGPol.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      cmd_Chordal    : Drawing.InsertObject(TGChordal.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      cmd_Polynom    : MakeIPolynomFunction;

      cmd_GRichtTerm,
      cmd_SRichtTerm : If ActiveTermWin <> Nil then AddMeasure2Term(Start.Items[0])
                       else CreateGRicht;
      cmd_EditTerm   : If ActiveTermWin <> Nil then AddMeasure2Term(Start.Items[0])
                       else EditTermDisp;
      cmd_Verging    : If ActiveTermWin <> Nil then AddMeasure2Term(Start.Items[0])
                       else CreateVergingLine;

      cmd_Group      : ToggleGroupMembershipOf(Start.Items[0]);

      cmd_DefMakro   : Add2Makro(Start.Items[0]);
      cmd_RunMakro   : ExecuteMakro(Start.Items[0]);

      cmd_BlinkBaseObj : ;
      cmd_MakeLocLine  : InitLocLine(Start.Items[0]);
      cmd_MakeEnvelop  : InitEnvelop(Start.Items[0]);
      cmd_BindP2L      : BindPointToLine(Start.Items[0], Start.Items[1]);
      cmd_ReleaseP     : ReleasePoint(Start.Items[0]);
      cmd_Pt2BasePt    : ConvertPt2FreeBasePt(Start.Items[0]);
      cmd_CombinePts   : CombinePoints(Start.Items[0], Start.Items[1]);

      cmd_MarkAngle    : Drawing.InsertObject(TGAngle.Create(Drawing, Start.Items[0], Start.Items[1], Start.Items[2], True), ErrNum);
      cmd_MeasureAngle : ShowAngleWidth(Start.Items[0], Start.Items[1], Start.Items[2]);
      cmd_MeasureDist,
      cmd_MeasureSL    : Drawing.InsertObject(TGDistLine.Create(Drawing, Start.Items[0], Start.Items[1], True), ErrNum);
      cmd_MeasureArea  : ShowAreaSize(Start.Items[0]);
      cmd_TermInput    : AddMeasure2Term(Start.Items[0]);
      cmd_TermObj      : If ActiveTermWin <> Nil then AddMeasure2Term(Start.Items[0]);

      cmd_FixPt        : ConvertBase2CoordPt(Start.Items[0]);
      cmd_Clip2Grid    : ClipToGrid(Start.Items[0]);
      cmd_UnfixPt      : ConvertCoord2BasePt(Start.Items[0]);

      cmd_FillArea     : If Start.Count > 1 then FillArea(Start.Items[0], Start.Items[1])
                         else                    FillArea(Start.Items[0], Nil);
      cmd_CutArea      : CutArea(Start.Items[0], Start.Items[1], Start.Items[2]);
      cmd_GraphArea    : MakeGraphArea;
      cmd_Riemann      : If ActiveTermWin <> Nil then
                           AddMeasure2Term(Start.Items[0])
                         else
                           MakeRiemannArea;
      cmd_DefineAffin  : AffAssProc;
      cmd_EditMap      : If ActiveTermWin <> Nil then
                           AddMeasure2Term(Start.Items[0])
                         else
                           EditMap;
      cmd_GeoGroup     : ;
      cmd_CheckSol     : CheckSolution;
      cmd_MagnGlass    : BuildMagnGlass;

    else
      MessageDlg(MyMess[14], mtInformation, [mbOk], 0);
    end; { of case }
    end;  { of if   }

  ShowErrorMsg(ErrNum);

  If (Modus in EditBar_Commands) and
     (Start.ExpectedCount >= 0) then
    Drawing.Repaint
  else
    If (Not(Modus in NoReset_Commands)) and
       (ActiveTermWin = Nil) and
       (OLineMode = 0) and
       (MakroMode = 0) then begin
      Reset2DragMode;
      Case NextCmd of
        cmd_MapObj : InitInputList(cmd_MapObj, SB_MapObj);
      end; { of case }
      end;
  end;  { of ProcessGeoObject }


procedure THauptFenster.ProcessNewLocLines;
  var SLTyp   : Integer;
      LL      : TGLocLine;
      EL      : TGEnvelopLine;
      i       : Integer;
  begin
  For i := Succ(LastLVOIndex) to Drawing.LastValidObjIndex do
    if TGeoObj(Drawing.Items[i]) is TGEnvelopLine then begin
      EL := TGEnvelopLine(Drawing.Items[i]);
      If (EL.points.Count >= 3) and
         (EL.Parent.Count > 0) and
         (EL.Parent.First <> EL.Parent.Last) then begin
        EL.IsDynamic := EnvLinesDynamic;
        EL.ShowCurve := EnvShowCurve;
        EL.IsSpline  := True;
        EL.ShowLines := EnvShowLines;
        end
      else begin
        EL.IsDynamic := False;
        EL.ShowCurve := False;
        EL.IsSpline  := False;
        EL.ShowLines := False;
        end;
      end
    else
    If TGeoObj(Drawing.Items[i]) is TGLocLine then begin
      LL := TGLocLine(Drawing.Items[i]);
      If (LL.Points.Count >= 3) and           { genügend Punkte vorhanden   }
         (LL.Parent.Count > 0) and            {         ..... und ....      }
         (LL.Parent.First <> LL.Parent.Last) and { Zug-Pkt <> Generator-Pkt }
          Not TraceOnly then begin
        LL.IsSpline  := Drawing.NewLocLineStatus and ols_IsSpline > 0;
        LL.IsDynamic := (Drawing.NewLocLineStatus and ols_IsDynamic > 0) and   { Dynamische Ortslinie   }
                        TGeoObj(LL.Parent.First).IsDynamicLocLineControl;
        Drawing.DrawFirstObjects(Drawing.LastValidObjIndex, True);  { killt
                      Elschenbroich's "Artefakte" (siehe EMail vom 20.02.04 }
        If LocLinesStandard and LL.Check4StandardLine(SLTyp) then
          If (SLTyp = ols_IsStraightLine) and
             (MessageDlg(MyMess[17], mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
            LL.IsStraightLine := True
          else
          If (SLTyp = ols_IsCircle) and
             (MessageDlg(MyMess[18], mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
            LL.IsCircle := True
          else
          If (SLTyp = ols_IsConic) and
             (MessageDlg(MyMess[153], mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
            LL.IsConic := True;
        end
      else begin
        LL.IsDynamic := False;                  { Statische Spur         }
        LL.IsSpline  := Drawing.NewLocLineStatus and ols_IsSpline > 0;
        end;
      end;
  Drawing.KillLocLineDoubles;
  Drawing.AutoUpdateLocLines;
  LastLVOIndex := 0;
  end;


{========== Popup-Menu-Befehle bearbeiten =============}

procedure THauptfenster.ProcessPopupCommands(var Msg: TMessage);
  var spot    : TPoint;
      NewObj,
      DrObj   : TGeoObj;
      NO      : TGName;
      px, py  : String;
      err,
      SLChCnt,
      SLTyp   : Integer;
  begin
  If Modus > cmd_ContextMenu then
    Assert(ActPopupObj <> Nil, 'ActPopupObj = Nil!');
  FModus := msg.WParam;
  Case Modus of
    cmd_Update:
        begin
        Drawing.UpdateAllObjects;
        Drawing.DrawFirstObjects(Drawing.LastValidObjIndex, True);
        Reset2DragMode;
        end;

    cmd_sw2contds:
        begin
        If Drawing.DragStrategy = 0 then begin
          Drawing.DragStrategy := 1;
          Drawing.UpdateAllObjects;
          Drawing.Repaint;
          end;
        Reset2DragMode;
        end;

    cmd_sw2detds:
        begin
        If Drawing.DragStrategy = 1 then begin
          Drawing.DragStrategy := 0;
          Drawing.UpdateAllObjects;
          Drawing.Repaint;
          end;
        Reset2DragMode;
        end;

    cmd_BlinkBaseObj:
        begin
        GeoTimer.InitBaseObjBlinking(Drawing);
        ShowMyHint(65);
        end;

    cmd_NameObj,
    cmd_ToggleVis,
    cmd_ReleaseP,
    cmd_FixPt,
    cmd_UnFixPt:
        begin
        Start.Clear;
        Start.Add(ActPopupObj);
        ProcessGeoObject;
        Drawing.Repaint;
        Reset2DragMode;
        end;

    cmd_BindP2L:
        begin
        InitInputList(cmd_BindP2L, Nil, False);
        With Start do begin
          Add(ActPopupObj);
          Inc(IL_Row);
          ExpectedType := InitModeList[IL_Line, IL_Row];
          ShowMyHint(76);
          end;
        end;

    cmd_SetDotPt:
        begin
        px := FloatToStr(ActPopupObj.GetValue(gv_x));
        py := FloatToStr(ActPopupObj.GetValue(gv_y));
        NewObj := TGXPoint.Create(Drawing, px, py, True);
        NewObj.MyBrushStyle := bsClear;
        NewObj.MyColour := clRed;
        Drawing.InsertObject(NewObj, err);
        Reset2DragMode;
        end;

    cmd_EditColour:
        begin
        If ActColorDialog.Execute then begin
          ActPopupObj.MyColour := ActColorDialog.Color;
          If SynchronizeCols and
             ActPopupObj.HasNameObj(NO) and
             Not (ActPopupObj is TGPolygon) then
            NO.MyColour := ActColorDialog.Color;
          If ActPopupObj is TGArea then begin
            ToolFillColour := ActColorDialog.Color;
            ChangeColourGlyph(SB_FillColour, ToolFillColour);
            end
          else begin
            ToolObjColour := ActColorDialog.Color;
            ChangeColourGlyph(SB_ObjColour, ToolObjColour);
            end;
          end;
        PaintBox1Paint(Self);
        Reset2DragMode;
        end;

    cmd_EditPointStyle:
        begin
        spot := PaintBox1.ClientToScreen(Point(Last_XM, Last_YM));
        ShapeMenu.Popup(spot.x, spot.y);
        end;

    cmd_EditLineStyle:
        begin
        spot := PaintBox1.ClientToScreen(Point(Last_XM, Last_YM));
        LinesMenu.Popup(spot.x, spot.y);
        end;

    cmd_EditPattern:
        begin
        spot := PaintBox1.ClientToScreen(Point(Last_XM, Last_YM));
        PatternsMenu.Popup(spot.x, spot.y);
        end;

    cmd_EditRadius:
        If Msg.LParam = 0 then
          with WertEingabe do begin
            Caption     := MyMess[35];
            HelpContext := cmd_MCreate;
            Edit1.HTMLTextAsString := TGXCircle(ActPopupObj).rTerm.GetHTMLString;
            InitInputList(cmd_EditRadius, Nil, False);
            Self.ShowMyHint(23);
            Show;
            end
        else begin
          TGXCircle(ActPopupObj).SetNewRadius(LastValueWStr[0]);
          Drawing.SortObjects;
          Drawing.UpdateAllDescendentsOf(ActPopupObj);
          Drawing.Repaint;
          Reset2DragMode;
          end;

    cmd_EditAngle:
        If Msg.LParam = 0 then begin
          with WertEingabe do begin
            Caption     := MyMess[36];
            HelpContext := cmd_GRichtTerm;
            Edit1.HTMLTextAsString := TGXLine(ActPopupObj).wTerm.GetHTMLString;
            InitInputList(cmd_EditAngle, Nil, False);
            Self.ShowMyHint(27);
            Show;
            end;
          end
        else begin
          TGXLine(ActPopupObj).SetNewAngle(LastValueWStr[0]);
          Drawing.SortObjects;
          Drawing.UpdateAllDescendentsOf(ActPopupObj);
          Drawing.Repaint;
          Reset2DragMode;
          end;

    cmd_EditCoords,
    cmd_EditXCoord:
        If Msg.LParam = 0 then begin
          If ActPopupObj is TGXPoint then
            with KoordEingabe do begin
              HelpContext := cmd_PtCoord;
              Edit1.HTMLTextAsString := (ActPopupObj as TGXPoint).XTerm.GetHTMLString;
              Edit2.HTMLTextAsString := (ActPopupObj as TGXPoint).YTerm.GetHTMLString;
              InitInputList(cmd_EditCoords, Nil, False);
              Show;
              end
          else
            with WertEingabe do begin
              Caption := MyMess[141];
              Edit1.HTMLTextAsString := Float2Str(TGPoint(ActPopupObj).X, 4);
              HelpContext := cmd_PtCoord;
              InitInputList(cmd_EditXCoord, Nil, False);
              Show;
              end;
          end
        else begin
          TGPoint(ActPopupObj).SetNewCoords(LastValueWStr[0], LastValueWStr[1]);
          Drawing.SortObjects;
          Drawing.UpdateAllDescendentsOf(ActPopupObj);
          Drawing.Repaint;
          Reset2DragMode;
          end;

    cmd_EditFunktion:
        If Msg.LParam = 0 then begin
          ShowMyHint(81);
          with WertEingabe do begin
            Caption := MyMess[95];
            Edit1.HTMLTextAsString := (ActPopupObj as TGFunktion).GetHTMLString;
            HelpContext := cmd_Graph;
            InitInputList(cmd_EditFunktion, Nil);
            Show;
            end;
          end
        else begin
          TGFunktion(ActPopupObj).TermString := LastValueWStr[0];
          Drawing.UpdateAllDescendentsOf(ActPopupObj);
          If Assigned(FunkTabelle) then
            FunkTabelle.UpdateData;
          Drawing.Repaint;
          Reset2DragMode;
          end;

    cmd_ShowFunkTable:
        begin
        If FunkTabelle = Nil then
          FunkTabelle := TFunkTableWin.CreateWD(Self, ActPopupObj as TGFunktion)
        else
          FunkTabelle.InitWD(ActPopupObj as TGFunktion);
        FunkTabelle.Show; // statt ShowModal;
        Reset2DragMode;
        end;

    cmd_EditLength:
        begin
        TPt[1].x := TGFixLine(ActPopupObj).MyLength;    // nicht: / act_pixelPerCentimeter;
        If KonstEingabe.ShowModal = mrOk then begin
          TGFixLine(ActPopupObj).MyLength := TPt[1].x;  // nicht: * act_pixelPerCentimeter;
          If TGeoObj(ActPopupObj.Parent[0]).ClassType = TGPoint then
            DrObj := ActPopupObj.Parent[1]
          else
            DrObj := ActPopupObj.Parent[0];
          Drawing.FillDragList(DrObj);
          Drawing.UpdateAllDescendentsOf(DrObj);
          Drawing.Repaint;
          end;
        Reset2DragMode;
        end;

    cmd_EditLocLineStyle:
        begin
        If ActPopupObj is TGLocLine then begin
          with ActPopupObj do
            If MyLineWidth > 1 then
              MyLineWidth := 1
            else
              MyLineWidth := 3;
          Drawing.Repaint;
          end;
        Reset2DragMode;
        end;

    cmd_EditLocLineDyna:
        begin
        If ActPopupObj is TGLocLine then
          with ActPopupObj as TGLocLine do
            If IsDynamic then
              IsDynamic := False
            else
              IsDynamic := TGeoObj(Parent[0]).IsDynamicLocLineControl;
        Drawing.Repaint;
        Reset2DragMode;
        end;

    cmd_EditLocLineStnd:
        begin
        If (ActPopupObj is TGOLLongLine) or
           (ActPopupObj is TGOLCircle) or
           (ActPopupObj is TGOLConic) then
          ActPopupObj := TGeoObj(ActPopupObj.Parent[0]);
        If ActPopupObj is TGLocLine then begin
          with ActPopupObj as TGLocLine do
            If IsStandardLine then begin
              SLChCnt := SLChildrenCount;
              If (SLChCnt = 0) or
                 (MessageDlg(MyMess[107], mtConfirmation, [mbYes, mbNo],
                             idh_locline_standard) = mrYes) then begin
                IsStraightLine := False;
                IsCircle := False;
                IsConic := False;
                ShowsAlways := True;
                LastSelectedObj := Nil;
                Drawing.Repaint;
                If SLChCnt = 0 then
                  MessageDlg(MyMess[108], mtInformation, [mbOk], idh_locline_standard);
                end;
              end
            else
              If Check4StandardLine(SLTyp) then begin
                If SLTyp = ols_IsStraightLine then
                  IsStraightLine := True
                else
                If SLTyp = ols_IsCircle then
                  IsCircle := True
                else
                If SLTyp = ols_IsConic then
                  IsConic := True;
                MessageDlg(MyMess[106], mtInformation, [mbOk], idh_locline_standard);
                end
              else
                MessageDlg(MyMess[105], mtWarning, [mbOk], idh_locline_standard);
          end;
        Drawing.Repaint;
        Reset2DragMode;
        end;

    cmd_EditLocLineCurve:
        begin
        If ActPopupObj is TGLocLine then
          with ActPopupObj as TGLocLine do begin
            IsSpline := Not IsSpline;
            BackInvalid := True;
            end;
        Reset2DragMode;
        end;

    cmd_EditEnvLines:
        begin
        if ActPopupObj is TGEnvelopLine then
          with ACtPopupObj as TGEnvelopLine do begin
            ShowLines := Not ShowLines;
            BackInvalid := True;
            end;
        Reset2DragMode;
        end;

    cmd_EditEnvCurve:
        begin
        if ActPopupObj is TGEnvelopLine then
          with ACtPopupObj as TGEnvelopLine do begin
            ShowCurve := Not ShowCurve;
            BackInvalid := True;
            end;
        Reset2DragMode;
        end;

    cmd_EditRange:
        begin
        If (ActPopupObj is TGNumberObj) then begin
          RangeEditWin.ShowModal;
          ActPopupObj.Redraw;
          Drawing.UpdateAllDescendentsOf(ActPopupObj);
          Drawing.Repaint;
          end;
        Reset2DragMode;
        end;

    cmd_ShowSlider:
        begin
        If (ActPopupObj is TGNumberObj) then begin
          TGNumberObj(ActPopupObj).MyShape := 1;
          Drawing.Repaint;
          end;
        Reset2DragMode;
        end;

    cmd_ShowCounter:
        begin
        if (ActPopupObj is TGNumberObj) then begin
          TGNumberObj(ActPopupObj).MyShape := 2;
          Drawing.Repaint;
          end;
        Reset2DragMode;
        end;

    cmd_EditTerm:
        begin
        ShowMyHint(27);
        with TermEdit do begin
          HelpContext := cmd_EditTerm;
          EditTerm.HTMLTextAsString := (ActPopupObj as TGTermObj).GetHTMLString;
          InitInputList(cmd_EditTerm, Nil, False);
          Show;
          end;
        end;

    cmd_EditRieIntCount:
        begin
        If Msg.LParam = 0 then begin
          ShowMyHint(106);
          with WertEingabe do begin
            Caption := MyMess[133];
            Edit1.HTMLTextAsString := (ActPopupObj as TGRiemannArea).IntervalStr;
            HelpContext := cmd_Riemann;
            InitInputList(cmd_EditRieIntCount, Nil, False);
            Show;
            end;
          end
        else begin
          With TGRiemannArea(ActPopupObj) do begin
            SetNewIntCountTerm(LastValueWStr[0]);
            UpdateParams;
            end;
          Drawing.UpdateAllDescendentsOf(ActPopupObj);
          Drawing.Repaint;
          Reset2DragMode;
          end;
        end;

    cmd_Switch2LowerSum:
        begin
        TGRiemannArea(ActPopupObj).RiemannType := 0;
        Drawing.UpdateAllDescendentsOf(ActPopupObj);
        Drawing.Repaint;
        Reset2DragMode;
        end;

    cmd_Switch2UpperSum:
        begin
        TGRiemannArea(ActPopupObj).RiemannType := 1;
        Drawing.UpdateAllDescendentsOf(ActPopupObj);
        Drawing.Repaint;
        Reset2DragMode;
        end;

    cmd_BindTBox2Obj:
        begin
        InitInputList(cmd_BindTBox2Obj, Nil, False);
        With Start do begin
          Add(ActPopupObj);
          Inc(IL_Row);
          ExpectedType := InitModeList[IL_Line, IL_Row];
          end;
        ShowMyHint(68);
        end;

     cmd_ReleaseTBox:
        begin
        With ActPopupObj do
          While Parent.Count > 0 do
            Stops2BeChildOf(Parent[0]);
        Reset2DragMode;
        end;

     cmd_QuantP:
        begin
        If (ActPopupObj.ClassType = TGPoint) and
           ((ActPopupObj.Parent.Count = 0) or
            (TGeoObj(ActPopupObj.Parent[0]) is TGFunktion)) then
          QuantPtWin.ShowModal
        else
          MessageDlg(MyMess[27], mtError, [mbOk], 0);
        Reset2DragMode;
        end;

     cmd_ImageEdit:
        begin
        With ActPopupObj as TGImage do begin
          IsLocked := Not IsLocked;
          Drawing.Repaint;
          end;
        Reset2DragMode;
        end;

     cmd_hideName:
        begin
        ActPopupObj.ShowNameInNameObj := False;
        Drawing.Repaint;
        Reset2DragMode;
        end;

     cmd_NoData:
        begin
        ActPopupObj.ShowDataInNameObj := False;
        Drawing.Repaint;
        Reset2DragMode;
        end;

     cmd_AddData:
        begin
        ActPopupObj.ShowDataInNameObj := True;
        Drawing.Repaint;
        Reset2DragMode;
        end;

    cmd_SecantSlopes:
        begin
        MagnGlassFrame.ShowSecants := Not MagnGlassFrame.ShowSecants;
        Drawing.Repaint;
        Reset2DragMode;
        end;

    cmd_SecSlopeFuncs:
        begin
        MagnGlassFrame.ShowSlopeFuncs := Not MagnGlassFrame.ShowSlopeFuncs;
        Drawing.Repaint;
        Reset2DragMode;
        end;

    cmd_CurvatureCircle:
        begin
        MagnGlassFrame.ShowCurvatureCircle := Not MagnGlassFrame.ShowCurvatureCircle;
        Drawing.Repaint;
        Reset2DragMode;
        end;

    cmd_CurvatureParabo:
        begin
        MagnGlassFrame.ShowCurvatureParabola := Not MagnGlassFrame.ShowCurvatureParabola;
        Drawing.Repaint;
        Reset2DragMode;
        end;
  else
    MessageDlg(MyMess[26], mtError, [mbOk], 0);
    Reset2DragMode;
  end; { of case }
  end;


{ =========== Externe Befehle bearbeiten =========}

procedure THauptfenster.ProcessExternCommands(var Msg: TMessage);
  var RegisterDlg : TRegisterDlg;
      err  : Integer;
      newO : TGeoObj;
      newF : TGFunktion;
      R    : TRect;
  begin
  err := 0;
  Case Msg.WParam of    // Gruppen-Aufgaben zuerst !
    cmd_Group        :  begin
                        GeoTimer.Reset(Drawing);
                        Reset2DragMode;
                        end;
    cmd_GroupsChanged:  begin
                        If Msg.LParam and 1 > 0 then
                          RebuildGroupMenu;
                        If Msg.LParam and 2 > 0 then
                          StatusBar1Resize(Nil);
                        If Msg.LParam and 4 > 0 then
                          Statusbar1.Invalidate;
                        Drawing.UpdateGroupVisibility;
                        end;
    cmd_GroupShowName:  begin
                        TGeoGroup(Drawing.GroupList[Msg.LParam]).PaintName
                          (Drawing.ActCanvas, Drawing.WindowRect);
                        end;
    cmd_GroupHideName:  begin
                        R := Drawing.GroupList.HideName(Msg.LParam, Drawing.ActCanvas);
                        R.BottomRight := ClientRect.BottomRight;
                        InvalidateRect(Handle, @R, False);
                        Reset2DragMode;
                        end;
    cmd_MappingChanged: RefreshMappingMenus;
  else
    FModus := Msg.WParam;
    Case Modus of
      cmd_Drag     : If Msg.LParam = cmd_AnimaParams then begin
                       RefreshAnimationButtons;
                       If Drawing.AnimationSource = Nil then
                         TabSet1.TabIndex := 0
                       else
                         TabSet1.TabIndex := index_Animation;
                       Reset2DragMode;
                       end
                     else begin
                       Drawing.RescaleDrawing(1);
                       If Msg.LParam = 0 then   { Normal-Fall }
                         PaintBox1Paint(Self)
                       else                     { LParam = 1  }
                         Drawing.Repaint;
                       end;
      cmd_PtCoord  : begin
                     newO := Drawing.InsertObject(TGXPoint.Create(Drawing,
                                          LastValueWStr[0], LastValueWStr[1],
                                          True), err);
                     newO.MyBrushStyle := bsClear;
                     Reset2DragMode;
                     end;
      cmd_TermObj  : begin
                     newO := TGTermObj.Create(Drawing, LastValueWStr[0], '',
                                              Msg.LParam = 1, True);
                     If IsAngleTerm(Drawing, LastValueWStr[0]) and
                        (MessageDlg(MyMess[152], mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
                       TGTermObj(newO).OutFormat := 1;
                     Drawing.InsertObject(newO, err);
                     Reset2DragMode;
                     end;
      cmd_Graph    : begin
                     newF := TGFunktion.Create(Drawing, LastValueWStr[0]);
                     If newF.IsTrigWithBigVariation then
                       MessageDlg(MyMess[138], mtWarning, [mbHelp, mbOk], idh_graph_varproblem);
                     newO := Drawing.InsertObject(newF, err);
                     newO.ShowsAlways := True;
                     If Assigned(FunkTabelle) then
                       FunkTabelle.UpdateData;
                     Reset2DragMode;
                     end;
      cmd_Register : begin
                     RegisterDlg := TRegisterDlg.Create(Self);
                     try
                       If RegisterDlg.ShowModal = mrOk then begin
                         MessageDlg(MyStartMsg[14], mtInformation, [mbOk], 0);
                         Reset2DragMode;
                         Application.Terminate;
                         end
                       else
                         Reset2DragMode;
                     finally
                       RegisterDlg.Release;
                     end;
                     end;
      cmd_NameObj  : If Drawing.IndexOf(LastSelectedObj) >= 0 then begin
                       Start.Clear;
                       Start.Add(LastSelectedObj);
                       ProcessGeoObject;
                       Reset2DragMode;
                       end
                     else
                       LastSelectedObj := Nil;
      cmd_verging  : begin
                     InitInputList(cmd_verging, Nil);
                     end;
      cmd_AdjNumObj: begin
                     LastSelectedObj := TGeoObj(Msg.LParam);
                     end;
      cmd_DefineAffin :
                     begin
                     Inc(AffinMapSubVers);
                     ProcessGeoObject;
                     end;
      cmd_Riemann,
      cmd_EditMap :  begin
                     ActiveTermWin := Nil;
                     If Msg.LParam > 0 then
                       ProcessGeoObject
                     else
                       Reset2DragMode;
                     end;
      cmd_CloseFunkTable :
                     begin
                     if Assigned(FunkTabelle) then
                       try
                         FunkTabelle.Close;
                         FunkTabelle.Release;
                       finally
                         FunkTabelle := Nil;
                       end;
                     Reset2DragMode;
                     end;
      cmd_ExitGame02:
                     begin
                     FreeAndNil(Drawing);
                     Drawing       := BackUpDrawing;
                     BackUpDrawing := Nil;
                     Angles2Dlg    := Nil;
                     RestorePreviousCmdSet;
                     Invalidate;
                     RefreshSpecialImageButtons;
                     ShowMyHint(0); // Zugmodus-Meldung setzen
                     Reset2DragMode;
                     end;
    end; { of inner case }
  end; { of outer case }
  ShowErrorMsg(err);
  end;


{ =========== Tastatur =========== }

procedure THauptfenster.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  { Achtung! Die im Menü vereinbarten Shortcuts (wie z.B. "Strg S" für
             "Datei speichern") werden auf Formularebene verarbeitet und
    führen daher *nicht* zu einem Aufruf von FormKeyDown! Hier werden da-
    her nur zusätzliche Shortcuts (wie z.B. "F2" als Ersatz für "Strg S")
    oder Reaktionen auf Tastatureingaben in sehr speziellen Situationen
    verarbeitet.                                                         }

  procedure ShowNext;
    var s : String;
    begin
    s := '';
    Repeat
      Repeat
        Inc(Last2Show);
      until (Last2Show > Drawing.LastValidObjIndex) or
            (TGeoObj(Drawing.Items[Last2Show]).IsVisible);
      If Last2Show <= Drawing.LastValidObjIndex then begin
        s := TGeoObj(Drawing.Items[Last2Show]).GetInfo;
        If Length(s) > 0 then begin
          ShowHTMLHint(s);
          PaintBox1Paint(Self);
          end;
        end
      else begin
        MessageBeep(mb_IconHand);
        Reset2DragMode;
        end;
    until (Length(s) > 0) or (Last2Show > Drawing.LastValidObjIndex);
    end;

  procedure ShowMakroCmds(Makro: TMakro);
    var SL : TStringList;
    begin
    SL := TStringList.Create;
    TMakro(Drawing.MakroList.Last).GetCmdList(SL);
    Drawing.DrawTempText(SL, 12, 20, 20);
    SL.Free;
    end;

  procedure RepeatLastCmd;
    begin
    If (Modus = cmd_Drag) and
       (PrevModus in Repeatable_Commands) then begin
      If PrevModus = cmd_ToggleVis then
        Drawing.MakeHiddenObjectsTempVisible;
        InitInputList(PrevModus, Nil);
        end;
    end;

  begin { of FormKeyDown }
  LastShiftState := Shift + ssMouse * LastShiftState;
  // SpacePressed := key = vk_Space;
    { Traurigerweise notwendige Gewaltkonstruktion, um zu verhindern,
      daß im Zugmodus nach einem Druck auf die Leertaste automatisch
      in den Zeichnung-editieren-Modus umgeschaltet wird. Irgend eine
      unselige interne Automatik interpretiert das Leerzeichen als
      Signal für TabSet1, nun TabIndex auf 2 zu setzen. Sollte der
      Übeltäter je gefunden werden, ist die Variable SpacePressed
      überflüssig.                                                    }
  Case Key of
    // Allgemeiner Abbruch
    vk_Escape  : begin
                 AutoRepeat := False;
                 Reset2DragMode;
                 Drawing.Repaint;
                 end;

    // Rückblende weiterschalten
    vk_Return  : If Modus = cmd_ShowGrowth then
                   ShowNext;

    // Zeichung verschieben
    vk_Shift   : If Modus = cmd_Drag then begin
                   InitInputList(cmd_Slide, Nil);
                   RefreshCursor;
                   end;

    // Alternativen für einige Menü-ShortCuts
    vk_F2      : Speichern1Click(Sender);
    vk_F3      : RepeatLastCmd;
    vk_F5      : Drawing.Repaint;

    // Animations-Steuerung
    vk_Add     : If Modus in [cmd_RunAnimaFD, cmd_RunAnimaBK] then
                   Drawing.AnimationSource.ChangeAniSpeed(1.500);
    vk_Subtract: If Modus in [cmd_RunAnimaFD, cmd_RunAnimaBK] then
                   Drawing.AnimationSource.ChangeAniSpeed(0.666);
    vk_Multiply: If Modus in [cmd_RunAnimaFD, cmd_RunAnimaBK] then begin
                   If Modus = cmd_RunAnimaFD then begin
                     FModus := cmd_RunAnimaBK;
                     SB_AniGoFD.Down := False;
                     SB_AniGoBK.Down := True;
                     end
                   else begin
                     FModus := cmd_RunAnimaFD;
                     SB_AniGoBK.Down := False;
                     SB_AniGoFD.Down := True;
                     end;
                   Application.HandleMessage;
                   end;

    Word('X')  : If (ssCtrl in Shift) and (Modus in [cmd_Drag, cmd_Slide])
                        and ZoomKeyActive then begin
                   If (ssShift in Shift) then
                     Drawing.RescaleCoordSys(act_PixelPerXcm * ZoomFaktor, act_PixelPerYcm)
                   else
                     Drawing.RescaleCoordSys(act_PixelPerXcm / ZoomFaktor, act_PixelPerYcm);
                   Drawing.Repaint;
                   ZoomKeyActive := False;   // verhindert Dauerfeuer !
                   end;
    Word('Y')  : If (ssCtrl in Shift) and (Modus in [cmd_Drag, cmd_Slide])
                        and ZoomKeyActive then begin
                   If (ssShift in Shift) then
                     Drawing.RescaleCoordSys(act_PixelPerXcm, act_PixelPerYcm * ZoomFaktor)
                   else
                     Drawing.RescaleCoordSys(act_PixelPerXcm, act_PixelPerYcm / ZoomFaktor);
                   Drawing.Repaint;
                   ZoomKeyActive := False;   // verhindert Dauerfeuer !
                   end;
    Word('W'),
    Word('R')  : If (ssCtrl in Shift) then
                   RepeatLastCmd;

    // Geheimnis: Quelltext des letzten Makros anschauen
    Word('M')  : If (ssCtrl in Shift) and
                    (Drawing.MakroList.Count > 0) then
                   ShowMakroCmds(Drawing.MakroList.Last);

    vk_Control,
    vk_LWin,
    vk_RWin    : ;
  else { of case }
    If Not (ssAlt in Shift) then
      MessageBeep(mb_IconHand);
  end; { of case }
  RefreshCursor;
  end; { of FormKeyDown }


procedure THauptfenster.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  begin
  LastShiftState := Shift + ssMouse * LastShiftState;
  Case Key of
    vk_Shift : begin
               If (Modus = cmd_Slide) and
                  Not(ssLeft in LastShiftState) then begin
                 Screen.Cursor := crDefault;  { aktiviert die lokale }
                 Reset2DragMode;              { Cursorsteuerung !!!! }
                 end;
               RefreshCursor;
               end;
    vk_Space : key := 0;
    Word('X'),
    Word('Y'): ZoomKeyActive := True;  { aktiviert Zoomen per Tasten }
  end;
  end;


{ ========== Mouse ====================== }

procedure THauptfenster.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  var key  : Word;
      P    : TPoint;
      ttag : Integer;

  function LSO_is_valid: Boolean;
    { Hier (und nur hier) wird PreselectedObj gesetzt.
      Gelöscht wird es ebenfalls hier, und darüberhinaus in
      InitInputList, also auch bei der Auswahl irgend eines Befehls. }
    var n : Integer;
    begin
    Result := True;
    n := -1;
    if Selected <> Nil then
      n := Selected.IndexOf(PreselectedObj);
    If n < 0 then begin  { Kein Objekt gültig vorselektiert ! }
      PreselectedObj := Nil;
      If SeveralObjsPossible(Selected) then begin
        LastSelectedObj := Nil;
        P := PaintBox1.ClientToScreen(Point(X + 6, Y + 6));
        SelectDlg.LoadObjList(P.X, P.Y); { bei Vieldeutigkeit: Auswahlliste !!! }
        If SelectDlg.ShowModal = mrOk then begin
          If SelectDlg.SelectedItem > 0 then
            Selected.ExChange(0, SelectDlg.SelectedItem);
          PreselectedObj := Selected.Items[0];
          end;
        Result := False;
        end;
      end
    else begin           { Vorselektiertes Objekt gültig ! }
      LastSelectedObj := PreselectedObj;
      PreselectedObj := Nil;
      end;
    ShowMyHint(0);
    end;

  begin
  If DoubleClicked then begin    { Überflüssiges Ereignis abfangen }
    DoubleClicked := False;
    Exit;
    end;

  Last_XM := X;                  { Input-Stati merken }
  Last_YM := Y;
  LastMouseButton := Button;
  LastShiftState  := Shift;
  If Drawing.IndexOf(LastSelectedObj) < 0 then
    LastSelectedObj := Nil;

  RefreshCursor;
  If ssLeft in Shift then begin   { Linke Maustaste gedrückt }
    DeleteSelectionFrame;

    Drawing.ResetDragList(Modus <> cmd_Group);
    If (Modus = cmd_Drag) and (ssShift in Shift) then begin
      InitInputList(cmd_Slide, Nil);
      if Selected <> Nil then
        Selected.Clear;
      LastSelectedObj := Nil;
      RefreshCursor;
      end
    else
      LastSelectedObj := FillSelectList(X, Y); { Objekte bei der Maus suchen }
    If (Modus = cmd_Drag) and LSO_is_valid then begin
      Drawing.LastMousePos := Point(X, Y);   {Mausposition an Drawing melden }
      Drawing.FillDragList(LastSelectedObj); { Zugliste überarbeiten }
      If LastSelectedObj <> Nil then begin   { Ein Objekt ist selektiert }
        If OLineMode = 3 then begin          { Ortslinienmodus hochschalten }
          OLineMode  := 4;
          Shift := Shift - [ssShift];
          end
        else
        if (LastSelectedObj is TGNumberObj) and
           (LastSelectedObj.LastDist < -1.5) then
          FModus := cmd_AdjNumObj
        else
        if (LastSelectedObj is TGTextObj) then
          if LastSelectedObj is TGComment then begin
            ttag := TGComment(LastSelectedObj).GetLinkTagFromWinPos(Point(Last_XM, Last_YM));
            Case ttag of
               0 : FModus := cmd_MoveName;
            1000 : TGComment(LastSelectedObj).Expand;
            1001 : TGComment(LastSelectedObj).Collapse;
             { Hier die Behandlungsroutinen für alle anderen "special cases"
               (z.B. für Spezial-Buttons in Textboxen) ergänzen ! }
            end; { of case / else }
            end
          else
            FModus := cmd_MoveName;
        end
      else                      { kein Objekt ist selektiert }
        FModus := cmd_MarkRect;
      end;
    If Modus > cmd_Drag then begin
      If (Modus = cmd_MakeLocLine) and
         (ssShift in Shift) then
        OLineMode := 2;
      Case Modus of
        cmd_MoveName    : If (TGeoObj(LastSelectedObj) is TGTextObj) then
                            TGTextObj(LastSelectedObj).InitMoving(X, Y);
        cmd_MarkRect    : with FSelRect do begin      { Markierungsrahmen initialisieren    }
                            FSelStatus:= 1;
                            Left:= X;  Top:= Y;
                            end;
        cmd_ShowGrowth  : begin
                          key := vk_Return;
                          FormKeyDown(Sender, key, Shift);
                          end;
        cmd_Schnitt     : If (Start.Count = 0) and
                             (Selected.Count = 2) and ExtPointCmd then begin
                            Start.AddBlinking(Selected[0], False);
                            Start.AddBlinking(Selected[1], False);
                            ProcessGeoObject;
                            end
                          else begin
                            If Start.Count < Start.ExpectedCount then
                              SelectStartObject;
                            If Start.Count = Start.ExpectedCount then
                              ProcessGeoObject;
                            end;
        cmd_RunAnimaFD,
        cmd_RunAnimaBK  : Reset2DragMode;
        cmd_AdjNumObj   : GeoTimer.InitNumberAdjust(TGNumberObj(LastSelectedObj));
        cmd_BlinkBaseObj,
        cmd_Slide       : ;
      else
        If Start.Count < Start.ExpectedCount then
          SelectStartObject;
        If Start.Count = Start.ExpectedCount then
          ProcessGeoObject;
      end; { of case }
      end; { of IF Modus > cmd_Drag }
    end; { of IF ssLeft.... }

  If ssRight in Shift then        { Rechte Maustaste gedrückt }
    If (Modus = cmd_Drag) and
       (OLineMode = 0) and (MakroMode = 0) and
       (Angles1Dlg = Nil) and (Angles2Dlg = Nil) then
      If LastSelectedObj = Nil then begin      { Kontextmenü für die  }
        ContextMenu.Items.Clear;               {   Zeichnung anzeigen }
        AddPopupMenuItemTo(ContextMenu, cme_Update, Drawing.CME_PopupClick, cmd_Update);
        AddPopupMenuItemTo(ContextMenu, cme_BlinkBO, Drawing.CME_PopupClick, cmd_BlinkBaseObj);
        AddPopupMenuItemTo(ContextMenu, cme_CoordSys, Koordinatensystem1Click, cmd_CoordSys);
        AddPopupMenuItemTo(ContextMenu, '-', Nil, 0);
        AddPopupMenuItemTo(ContextMenu, cme_ZoomIn, ZeichnungVergroessern1Click, cmd_zoomin);
        AddPopupMenuItemTo(ContextMenu, cme_ZoomReset, ZeichnungReset1Click, cmd_zoomreset);
        AddPopupMenuItemTo(ContextMenu, cme_ZoomOut, ZeichnungVerkleinern1Click, cmd_zoomout);
        P := PaintBox1.ClientToScreen(Point(X, Y));
        ContextMenu.Popup(P.X, P.Y);
        end
      else begin
        LastSelectedObj := FillSelectList(X, Y, ccAnyGeoObj);
        If SeveralObjsPossible(Selected) then begin
          P := PaintBox1.ClientToScreen(Point(X + 6, Y + 6));
          SelectDlg.LoadObjList(P.X, P.Y); { bei Vieldeutigkeit: Auswahlliste !!! }
          If SelectDlg.ShowModal = mrOk then
            If SelectDlg.SelectedItem > 0 then begin
              Selected.ExChange(0, SelectDlg.SelectedItem);
              LastSelectedObj := Selected.Items[0];
              end
            else
              { Nothing to do ! }
          else begin
            Selected.Clear;
            LastSelectedObj := Nil;
            end;
          end;
        If LastSelectedObj <> Nil then begin
          ActPopupObj := LastSelectedObj;
          ActPopupObj.LoadContextMenuEntriesInto(ContextMenu);
          P := PaintBox1.ClientToScreen(Point(X, Y));
          ContextMenu.Popup(P.X, P.Y);
          end;
        end
    else begin
      key := vk_Escape;   { Zurück in den Zug-Modus ! }
      FormKeyDown(Sender, key, []);
      end;
  end; { of FormMouseDown }


procedure THauptfenster.FormDblClick(Sender: TObject);
  { behandelt nur den Doppelklick mit der
    linken (d.h. primären) Maustaste !! }
  var Msg    : TMessage;
      ttag   : Integer;
      nfname : String;     // "n"ew "f"ile "name"
  begin
  If (Modus = cmd_Drag) and
     (LastSelectedObj <> Nil) then
    If (LastSelectedObj.ClassType = TGNumberObj) and
       (TGNumberObj(LastSelectedObj).LastDist < -1.5) then
      DoubleClicked := False
    else begin
      DoubleClicked := True;
      If LastSelectedObj is TGTermObj then begin
        ActPopupObj := LastSelectedObj;
        msg.WParam := cmd_EditTerm;
        ProcessPopupCommands(msg)
        end
      else if LastSelectedObj is TGComment then begin
        ttag := TGComment(LastSelectedObj).GetLinkTagFromWinPos(Point(Last_XM, Last_YM));
        Case ttag of
           0 : if (Not TGComment(LastSelectedObj).IsDynamic) then begin  // editieren
                 InitInputList(cmd_NameObj, Nil, True, False);
                 Start.Clear;
                 Start.Add(LastSelectedObj);
                 ProcessGeoObject;
                 end;
        1000 : ;  // Nichts zu tun, da schon als Einfach-Klick abgearbeitet !
        1001 : ;  // Nichts zu tun, da schon als Einfach-Klick abgearbeitet !
         { Hier die Behandlungsroutinen für alle anderen "special cases"
           (z.B. für weitere Spezial-Buttons in Textboxen) ergänzen ! }
        else              // Doppelklick auf einen Link
          nfname := TGComment(LastSelectedObj).GetLinkAddressFromTag(ttag);
          JumpLink(nfname);
        end; { of case - else }
        end { of elseif LastSelectedObj is TGComment }
      else begin { Namen editieren }
        InitInputList(cmd_NameObj, Nil, True, False);
        LastSelectedObj := FillSelectList(Last_XM, Last_YM);
        If LastSelectedObj <> Nil then begin
          Start.Clear;
          Start.Add(LastSelectedObj);
          ProcessGeoObject;
          PaintBox1.Invalidate;
          end
        else
          Reset2DragMode;
        end;
      end
  else   // Modus <> cmd_Drag !
    If (Modus = cmd_NCreate) and
       (Start.Count > 0) then begin
      DoubleClicked := True;
      Start.Add(Start.Items[0]);
      ProcessGeoObject;
      end
    else
      DoubleClicked := False;
  end; { of FormMouseDoubleClick }


procedure THauptfenster.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  begin
  LastShiftState := Shift;
  ShowMousePosLogCoords(X, Y);
  If Assigned(GeoTimer) and (GeoTimer.Status = cmd_GroupShowName) then
    GeoTimer.Reset(Drawing);

  If Not(ssLeft in Shift) then begin { Linke Maustaste nicht gedrückt }
    If (Modus = cmd_Drag) and
       (ssShift in Shift) then begin
      InitInputList(cmd_Slide, Nil);
      RefreshCursor;
      end;
    LastSelectedObj := FillSelectList(X, Y);
    If Modus in [cmd_MoveName, cmd_AdjNumObj] then
      Reset2DragMode;
    end
  else                               { Linke Maustaste gedrückt }
    Case Modus of
      cmd_Drag     : If (Not (ssShift in Shift)) and
                        (Selected.Count > 0) and
                        (Drawing.DragList.IndexOf(LastSelectedObj) >= 0) then begin   { Objekt selektiert }
                       try
                         Drawing.DragObjects(X, Y, ssCtrl in Shift);
                         If Assigned(FunkTabelle) then
                           FunkTabelle.UpdateData;
                         if Assigned(MagnGlassWin) then
                           MagnGlassWin.RefreshBuffer;
                       except
                         Drawing.ResetDragList;
                       end;
                       BackInvalid := True;
                       end;
      cmd_MoveName : If Selected.Count > 0 then begin
                       Drawing.DragObjects(X, Y, False);
                       BackInvalid := True;
                       end
                     else
                       Reset2DragMode;
      cmd_RCreate  : If Sqr(X - TPt[1].x) +        { Basis-Gerade aufziehen }
                       Sqr(Y - TPt[1].y) > 25 then with PaintBox1.Canvas do begin
                      Pen.Width := 1;
                      Pen.Style := psDash;
                      Pen.Color := clGray;
                      If Sqr(TPt[2].x - TPt[1].x) + Sqr(TPt[2].y - TPt[1].y) > 25 then begin
                        MoveTo (Round(TPt[1].x), Round(TPt[1].y));
                        LineTo (Round(TPt[2].x), Round(TPt[2].y));
                        end;
                      TPt[2].x := X;
                      TPt[2].y := Y;
                      MoveTo (Round(TPt[1].x), Round(TPt[1].y));
                      LineTo (Round(TPt[2].x), Round(TPt[2].y));
                      end;
      cmd_FCreate  : IF Sqr(X - TPt[1].x) +        { Basis-Kreis aufziehen  }
                       Sqr(Y - TPt[1].y) > 25 then with PaintBox1.Canvas do begin
                      Pen.Width := 1;
                      Pen.Style := psDash;
                      Pen.Color := clGray;
                      Brush.Style := bsClear;
                      If Sqr(TPt[2].x - TPt[1].x) + Sqr(TPt[2].y - TPt[1].y) > 25 then
                        Ellipse (Round(TPt[1].x - TPt[2].x),
                                 Round(TPt[1].y - TPt[2].x),
                                 Round(TPt[1].x + TPt[2].x),
                                 Round(TPt[1].y + TPt[2].x));
                      TPt[2].x := Sqrt(Sqr(X - TPt[1].x) + Sqr(Y - TPt[1].y));
                      Ellipse (Round(TPt[1].x - TPt[2].x),
                               Round(TPt[1].y - TPt[2].x),
                               Round(TPt[1].x + TPt[2].x),
                               Round(TPt[1].y + TPt[2].x));
                      end;
      cmd_MarkRect : If FSelStatus > 0 then with FSelRect, PaintBox1.Canvas do begin
                       Pen.Mode    := pmNotXOR;
                       Pen.Color   := clRed;
                       Pen.Style   := psDash;
                       Brush.Style := bsClear;
                       If FSelStatus = 2 then begin       { aufziehen }
                         Rectangle(Left, Top, Right, Bottom);
                         Right  := X;
                         Bottom := Y;
                         Rectangle(Left, Top, Right, Bottom);
                         end
                       else
                         If (FSelStatus = 1) and          { 1. Rechteck  zeichnen }
                            (Abs(X - Left) > 10) and
                            (Abs(Y - Top ) > 10) then begin
                           Right  := X;
                           Bottom := Y;
                           Rectangle(Left, Top, Right, Bottom);
                           FSelStatus := 2;
                           end;
                       Pen.Mode := pmCopy;
                       end;
      cmd_Slide    : begin                             { Zeichnung verschieben  }
                     Drawing.Slide(X - Last_XM, Y - Last_YM);
                     Drawing.Repaint;
                     end;
    else
    end; { of case }
  Last_XM := X;
  Last_YM := Y;
  RefreshCursor;
  end; { of FormMouseMove }


procedure THauptfenster.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

  var orgX, orgY : Integer;

  procedure DrawBasicLines;
    var once_more : Boolean;
        err       : Integer;
    begin
    once_more := False;
    With PaintBox1.Canvas do begin
      Pen.Width := 1;
      Pen.Style := psDash;
      Pen.Color := clGray;
      If Modus = cmd_RCreate then begin
        MoveTo (Round(TPt[1].x), Round(TPt[1].y));             { Basis-Gerade erzeugen }
        LineTo (Round(TPt[2].x), Round(TPt[2].y));
        If Sqr(TPt[1].x - X) + Sqr(TPt[1].y - Y) > 25 then
          Drawing.InsertObject(TGBaseLine.Create
                                 (Drawing, Round(TPt[1].x), Round(TPt[1].y), X, Y, True), err)
        else
          once_more := MessageDlg(MyMess[19], mtError, [mbRetry, mbCancel], 0) = idRetry;
        end
      else begin                                                       { Basis-Kreis erzeugen  }
        Ellipse (Round(TPt[1].x - TPt[2].x), Round(TPt[1].y - TPt[2].x),
                 Round(TPt[1].x + TPt[2].x), Round(TPt[1].y + TPt[2].x));
        If Sqr(TPt[1].x - X) + Sqr(TPt[1].y - Y) > 25 then
          Drawing.InsertObject(TGBaseCircle.Create
                                 (Drawing, Round(TPt[1].x), Round(TPt[1].y), X, Y, True), err)
        else
          once_more := MessageDlg(MyMess[20], mtError, [mbRetry, mbCancel], 0) = idRetry;
        end;
      end;
    If not once_more then begin
      PaintBox1.Canvas.Pen.Mode := pmCopy;
      Reset2DragMode;
      PaintBox1.Invalidate;
      end;
    end;

  begin { of FormMouseUp }
  LastShiftState := Shift;
  If Drawing.IndexOf(LastSelectedObj) < 0 then
    LastSelectedObj := Nil;

  Case Modus of
    cmd_Drag     : begin
                   GeoTimer.Reset(Drawing);
                   Drawing.ResetDragList;
                   If OLineMode = 4 then begin
                     ProcessNewLocLines;
                     Reset2DragMode;
                     end
                   else
                     ; //Drawing.AutoUpdateLocLines;
                   Drawing.DrawFirstObjects(Drawing.LastValidObjIndex);
                   end;
    cmd_MoveName : begin
                   TGTextObj(Selected.Items[0]).SetNewRelativPos;
                   Reset2DragMode;
                   end;
    cmd_MarkRect : begin
                   If FSelStatus = 2 then begin  { Wenn ein Auswahlrechteck zu sehen }
                     FSelStatus := 3;            { ist, dann ist es jetzt fertig;    }
                     With FSelRect do begin      { eventuell muß die Orientierung    }
                       If Left > Right then begin      { noch korrigiert werden.    }
                         orgX := Right; Right := Left; Left := orgX; end;
                       If Top > Bottom then begin
                         orgY := Bottom; Bottom := Top; Top := orgY; end;
                       end;
                     end
                   else                         { Andernfalls wird der Modus beendet.    }
                     FSelStatus := 0;
                   PaintBox1.Canvas.Pen.Mode := pmCopy;
                   Reset2DragMode;
                   end;
    cmd_AdjNumObj,
    cmd_Slide    : Reset2DragMode;
    cmd_RCreate,
    cmd_FCreate  : DrawBasicLines;
  end;
  end; { of FormMouseUp }


{ ========== Timer ================= }

procedure THauptfenster.ObjectBlinkTimer(Sender: TObject);
  begin
  Drawing.ToggleBlinkingObjs;
  end;

{ ======= EUKLID-Kommandos ========= }

{ ----- Menue Datei --------- }

procedure THauptfenster.Neu1Click(Sender: TObject);
  var CoSysVis : Boolean;
      old_CST,
      CoSysTyp,
      CoSysX,
      CoSysY   : Integer;
  begin
  If UserWants2Break4(cmd_New) and UserWants2SkipDrawing then begin
    FModus := cmd_New;
    old_CST := -1;
    If (Drawing <> Nil) and (Drawing.Count > 0) then begin
      old_CST := TGOrigin(Drawing.Items[0]).CSType;
      if MagnGlassWin <> Nil then begin
        MagnGlassWin.Close;
        FreeAndNil(MagnGlassWin);
        end;
      end;
    Drawing.Free;                       { Liste löschen           }
    ActGeoFileName := MyFileMsg[12] + '.GEO';
    Caption := GetCaption(MyStartMsg[8] + ActGeoFileName + MyStartMsg[9]);
    Application.Title := Caption;

    GeoFileVersion := Copy(EuklidLogo, 8, 3);

    Drawing := TGeoObjListe.Create(Handle, PaintBox1.Canvas, PaintBox1.ClientRect);  { Liste wieder neu erzeugen }
    CoSysVis := NewCosysType > 0;       { Koordinatensystem-Daten   }
    Case NewCosysType of                {   zusammenstellen         }
      0 : CosysTyp := -1;
      1 : CosysTyp :=  0;
    else
      if old_CST > 0 then
        CosysTyp := old_CST
      else
        CosysTyp :=  1;
    end;
    act_PixelPerXcm := ScreenPPCMx;
    act_PixelPerYcm := ScreenPPCMy;
    CoSysX   := PaintBox1.Width  Div 2;
    CoSysY   := PaintBox1.Height Div 2;
    With Drawing do begin
      InitCoordSys(CoSysX, CoSysY, PaintBox1.ClientRect, CoSysTyp, CoSysVis);
      BackGroundColor := PaintBox1.Color;
      Repaint;
      GroupList.Initialize(Handle, AlteGruppeClick, StatusBar1.ClientHeight);
      MakroList.Clear;
      end;
    Check4MagnGlass;
    RefreshMakroMenu;
    RefreshMappingMenus;
    RefreshAnimationButtons;
    RefreshCheckButtons;
    RefreshSpecialImageButtons;
    FreeAndNil(FunkTabelle);
    StatusBar1Resize(Sender);
    end;
  Reset2DragMode;  { 23.10.02 : Ersetzt die weniger gründliche Anweisung : }
                            //  SB_FileNew.Down := False;
  If Sender = Nil then
    {!!Sl Affin.Punkt;}
  end;

procedure THauptfenster.Laden1Click(Sender: TObject);
  var ActualDir : String;
  begin
  If UserWants2Break4(cmd_Load) and
     UserWants2SkipDrawing and
     LoadGeoFile.Execute then begin
    FModus := cmd_Load;
    DoLoadGeoFile(LoadGeoFile.FileName);   { Macht die Arbeit ! }
    end;
  ActualDir := ExtractFileDir(ActGeoFileName);
  SaveGeoFile.InitialDir := ActualDir;
  LoadGeoFile.InitialDir := ActualDir;
  Reset2DragMode;
  end;

procedure THauptfenster.LoadLRUFile(Sender: TObject);
  var ActualDir : String;
      n         : Integer;
  begin
  n := (Sender as TMenuItem).MenuIndex - LRUList.StartIndex;
  If (n >= 0) and
     (n < LRUList.LRUCount) and
     UserWants2Break4(cmd_Drag) and
     UserWants2SkipDrawing then begin
    If FileExists(LRUList.Strings[n]) then
      DoLoadGeoFile(LRUList.Strings[n]) { Macht die Arbeit ! }
    else
      MessageDlg(Format(MyFileMsg[6], [LRUList.Strings[n]]), mtError, [mbOK], 0);
    end;
  ShowMyHint(0);
  ActualDir := ExtractFileDir(ActGeoFileName);
  SaveGeoFile.InitialDir := ActualDir;
  LoadGeoFile.InitialDir := ActualDir;
  SB_FileLoad.Down := False;
  Application.ProcessMessages;
  end;

procedure THauptFenster.LoadOLEDroppedFile(fname: String);
  begin
  If UserWants2Break4(cmd_Drag) and
     UserWants2SkipDrawing then
    DoLoadGeoFile(fname);               { Macht die Arbeit ! }
  ShowMyHint(0);
  SB_FileLoad.Down := False;
  end;

procedure THauptfenster.Speichern1Click(Sender: TObject);
  var ext : String;
      res : Integer;
  begin
  If UserWants2Break4(cmd_Save) then
    ext := ExtractFileExt(ActGeoFileName);
    If UpperCase(ext) = '.GEOX' then
      If MessageDlg(MyFileMsg[27], mtInformation, [mbOK, mbCancel], 0) = mrOK then begin
        ChangeFileExt(ActGeoFileName, '.geo');
        SpeichernUnter1Click(Sender);
        end
      else
        Reset2DragMode
    else                        // Dateikennung ist ".geo" oder ".i2g"
      If UpperCase(ActGeoFileName) <> UpperCase(MyFileMsg[12] + ext) then begin
        FModus := cmd_Save;
        Screen.Cursor := crHourGlass;
        SaveGeoFile.FileName := ActGeoFileName;
        StatusBar1.Panels[1].Text :=
          '  ' + Format(MyFileMsg[8], [SaveGeoFile.FileName]);
        res := DoSaveGeoFile(ActGeoFileName);
        If res = 0 then
          Drawing.IsDirty := False
        else
          ShowErrorMsg(200 + res, ActGeoFileName);
        Reset2DragMode;
        end
      else
        SpeichernUnter1Click(Sender);
  end;

procedure THauptfenster.SpeichernUnter1Click(Sender: TObject);
  var FileExt, AFN,
      ActualDir  : String;
      R          : TRect;
      res        : Integer;

  function FileTypeClarified: Boolean;
    var FilterExt,
        IlterExt,
        dlgText  : String;
        res      : Integer;
    begin
    Result := True;
    FileExt   := ExtractFileExt(AFN);
    FilterExt := GetSelectedFilterExt(SaveGeoFile.Filter,
                                      SaveGeoFile.FilterIndex, '.geo');
    If FileExt = '' then begin { keine Extension ? }
      FileExt := FilterExt;    { dann: automatisch anhängen !  }
      AFN := ChangeFileExt(AFN, FilterExt);
      end;
    If LowerCase(FileExt) <> LowerCase(FilterExt) then begin
      IlterExt := UpperCase(Copy(FilterExt, 2, Length(FilterExt)));
      dlgText := Format(MyFileMsg[3], [FileExt, FilterExt, IlterExt]);
      res := Application.MessageBox(PWideChar(dlgText), PWideChar(MyFileMsg[18]),
                                    mb_IconQuestion or mb_YesNoCancel);
      Case res of
        mrYes : AFN := ChangeFileExt(AFN, FilterExt);
        mrNo  : ;
      else
        Result := False;
        Exit;
      end;
      end;
    FileExt := LowerCase(ExtractFileExt(AFN));
    AFN     := ChangeFileExt(AFN, FileExt);
    end;

  procedure SelectClipRect;
    begin
    If FSelStatus = 3 then with FSelRect do begin
      R.left  := Succ(Left);
      R.top   := Succ(Top);
      R.right := Pred(Right);
      R.bottom:= Pred(Bottom);
      end
    else with PaintBox1 do begin
      R.left  := 0;
      R.top   := 0;
      R.right := Pred(ClientWidth);
      R.bottom:= Pred(ClientHeight);
      end;
    end;

  begin  { of SpeichernUnter1Click }
  If UserWants2Break4(cmd_SaveAs) and
     SaveGeoFile.Execute then
    try
      FModus := cmd_SaveAs;
      Screen.Cursor := crHourGlass;
      StatusBar1.Panels[1].Text :=
        '  ' + Format(MyFileMsg[8], [SaveGeoFile.FileName]);
      AFN := SaveGeoFile.FileName;
      res := 0;
      If FileTypeClarified then begin
        SelectClipRect;
        If (FileExt = '.bmp') or
           (FileExt = '.png') or
           (FileExt = '.jpg') then begin
          PaintBox1.Repaint;
          res := BMPFileSave(R, AFN, Drawing, ExportBitmap_dpi);
          end
        else
          If (FileExt = '.wmf') or (FileExt = '.emf') then
            res := MetaFileSave(R, AFN, Drawing)
          else
            If (FileExt = '.geo') or (FileExt = '.i2g') then begin
              res := DoSaveGeoFile(AFN);
              If res = 0 then begin
                Drawing.IsDirty := False;
                ActGeoFileName  := AFN;
                LRUList.AddItem(ActGeoFileName);
                caption := GetCaption(MyStartMsg[8] + ActGeoFileName + MyStartMsg[9]);
                Application.Title := caption;
                ActualDir := ExtractFileDir(ActGeoFileName);
                SaveGeoFile.InitialDir := ActualDir;
                LoadGeoFile.InitialDir := ActualDir;
                end;
              end
            else
              res := 4;  // Unbekannter Dateityp !
        end;
      ShowErrorMsg(200 + res, AFN);
    finally
      Reset2DragMode;
    end;
  end;{ of SpeichernUnter1Click }

procedure THauptfenster.HTMLDynaGeoXExportClick(Sender: TObject);
  var DataFile : String;
      res      : Integer;
  begin
  If UserWants2Break4(cmd_SaveDGXHTML) and
     GeoFileAlreadySaved(ActGeoFileName, Drawing.IsDirty) and
     HTMLDynaGeoXDlg.Execute then
    try
      FModus := cmd_SaveDGXHTML;
      Screen.Cursor := crHourglass;
      DataFile      := HTMLDynaGeoXDlg.HTMLFilePath;
      StatusBar1.Panels[1].Text :=
        '  ' + Format(MyFileMsg[8], [DataFile]);
      If HTMLDynaGeoXFileSave(DataFile, HTMLDynaGeoXDlg,
                              Length(Drawing.CmdString) > 0) = 0 then begin
        DataFile := HTMLDynaGeoXDlg.GEOFilePath;
        If SelStatus >= 3 then
          Drawing.Move2UpperLeft(SelRect);
        res := DoSaveGeoFile(DataFile);
        If res = 0 then begin
          ActGeoFileName := DataFile;
          LRUList.AddItem(ActGeoFileName);
          caption := GetCaption(MyStartMsg[8] + ActGeoFileName + MyStartMsg[9]);
          Application.Title := caption;
          end;
        end;
    finally
      ShowMyHint(0);
      Screen.Cursor := crDefault;
    end;
  DeleteSelectionFrame;
  Reset2DragMode;
  Drawing.Repaint;
  end;

procedure THauptfenster.HTMLDynaGeoJExportClick(Sender: TObject);
  var DataFile : String;
      res      : Integer;
  begin
  If UserWants2Break4(cmd_SaveDGJHTML) and
     GeoFileAlreadySaved(ActGeoFileName, Drawing.IsDirty) and
     AllObjectsJExportable(Drawing) and
     HTMLDynaGeoJDlg.Execute then
    try
      FModus := cmd_SaveDGJHTML;
      Screen.Cursor := crHourglass;
      DataFile      := HTMLDynaGeoJDlg.EditTargetPath.Text;
      StatusBar1.Panels[1].Text :=
        '  ' + Format(MyFileMsg[8], [DataFile]);
      If HTMLDynaGeoJFileSave(DataFile, HTMLDynaGeoJDlg,
                              Length(Drawing.CmdString) > 0) = 0 then begin
        DataFile := HTMLDynaGeoJDlg.GEOFilePath;
        If SelStatus >= 3 then
          Drawing.Move2UpperLeft(SelRect);
        res := DoSaveGeoFile(DataFile, True);
        If res = 0 then begin
          ActGeoFileName := DataFile;
          LRUList.AddItem(ActGeoFileName);
          caption := GetCaption(MyStartMsg[8] + ActGeoFileName + MyStartMsg[9]);
          Application.Title := caption;
          end;
        end;
    finally
      ShowMyHint(0);
      Screen.Cursor := crDefault;
    end;
  DeleteSelectionFrame;
  Reset2DragMode;
  Drawing.Repaint;
  end;

procedure THauptfenster.Druckeroptionen1Click(Sender: TObject);
  begin
  If UserWants2Break4(cmd_PrnInit) then begin
    FModus := cmd_PrnInit;
    If PrinterCfgDlg.ShowModal = mrYes then begin  // "Drucken"-Knopf gedrückt
      Reset2DragMode;
      SB_FilePrintClick(Sender);
      Drawing.Repaint;
      end;
    end;
  Reset2DragMode;
  end;


procedure THauptfenster.DruckbildVorschau1Click(Sender: TObject);
  var PreviewDlg : TPrintPreview;
  begin
  If UserWants2Break4(cmd_Preview) then begin
    FModus := cmd_Preview;
    PreViewDlg := TPrintPreview.CreateWithParams
                       (Self, Drawing,
                        prn_UserScaleF, prn_UserBorder);
    PreViewDlg.ShowModal;
    PreViewDlg.Release;
    Reset2DragMode;
    end;
  end;

procedure THauptfenster.SB_FilePrintClick(Sender: TObject);
  { Um Fehlleistungen dummer Druckertreiber durch interne
    Überläufe zu vermeiden, übernimmt EUKLID das Clipping
    von Geraden auf dem Printer.Canvas selbst. 31.08.99 }

  var skf_ppiX, skf_ppiY    : Double;
      org_InternalLineStyle,
      org_InternalCurvStyle : Boolean;
      prn_XPixelPerCm,
      prn_YPixelPerCm       : Double;
      ClipRect              : TRect;

  procedure Adjust(PrintCanvas : TCanvas);
    var prn_XRes,
        prn_YRes,
        prn_XSize,
        prn_YSize,
        rdx, rdy  : Integer;
        ClipRgn : HRgn;
        DC      : THandle;
    begin
    DC := PrintCanvas.Handle;
    SetMapMode(DC, mm_Text);  { Einheit sind die Drucker-Pixel !}
    SetBkMode (DC, Transparent);
    prn_XRes := GetDeviceCaps(DC, HorzRes);  { Größe in Pixeln }
    prn_YRes := GetDeviceCaps(DC, VertRes);
    rdx := Round(prn_XRes * prn_UserBorder / 100);
    rdy := Round(prn_YRes * prn_UserBorder / 100);
    prn_XSize := GetDeviceCaps(DC, HorzSize);  { Größe in Millimetern }
    prn_YSize := GetDeviceCaps(DC, VertSize);
    prn_XPixelPerCm := prn_XRes * 10.0 / prn_XSize;
    prn_YPixelPerCm := prn_YRes * 10.0 / prn_YSize;
    skf_ppiX := prn_UserScaleF * prn_XPixelPerCm / act_pixelPerXcm;
    skf_ppiY := prn_UserScaleF * prn_YPixelPerCm / act_pixelPerYcm;

    With PrintCanvas.Font do begin    { vorsichtshalber, obwohl eigentlich  }
      Assign(GlobalDefaultFont);      { keine Ausgaben mehr mit diesem Font }
      PixelsPerInch := GetDeviceCaps(DC, LogPixelsY);     { gemacht werden. }
      end;
    Case prn_PaperFormat of
      0 : begin  { "Portrait, obere halbe Seite"  }
          rdy := rdy Div 2;
          ClipRgn := CreateRectRgn(rdx, rdy, prn_XRes - rdx, prn_YRes Div 2 - rdy);
          ClipRect := Bounds(0, 0, prn_XRes - 2*rdx, prn_YRes Div 2 - 2*rdy);
          end;
      1 : begin  { "Portrait, ganze Seite"        }
          ClipRgn := CreateRectRgn(rdx, rdy, prn_XRes - rdx, prn_YRes - rdy);
          ClipRect := Bounds(0, 0, prn_XRes - 2*rdx, prn_YRes - 2*rdy);
          end;
    else { eigentlich nur 2 : "Landscape": immer ganze Seite }
      ClipRgn := CreateRectRgn(rdx, rdy, prn_XRes - rdx, prn_YRes - rdy);
      ClipRect := Bounds(0, 0, prn_XRes - 2*rdx, prn_YRes - 2*rdy);
    end; { of case }
    SelectClipRgn(DC, ClipRgn);
    SetViewportOrgEx(DC, rdx, rdy, Nil);
    end;

  begin
  If UserWants2Break4(cmd_Print) then begin
    FModus := cmd_Print;
    Screen.Cursor := crHourGlass;
    org_InternalLineStyle := InternalLineStyle;
    org_InternalCurvStyle := InternalCurvStyle;
    InternalLineStyle     := PrnNeedsLineSupport;
    InternalCurvStyle     := PrnNeedsCurvSupport;
    try
      With Printer do begin
        BeginDoc;
        Adjust(Canvas);
        Drawing.OutputStatus := outPrinter;
        Drawing.WindowRect   := Canvas.ClipRect;
        Drawing.Export_To(Printer.Canvas, ClipRect,
                          prn_UserScaleF * prn_XPixelPerCm / ScreenPPCMx);
        EndDoc;
        end;
    finally
      InternalLineStyle := org_InternalLineStyle;
      InternalCurvStyle := org_InternalCurvStyle;
      Drawing.WindowRect := PaintBox1.ClientRect;
      Drawing.OutputStatus := outScreen;
      Drawing.UpdateAllObjects;
    end; { of try }
    end;
  Reset2DragMode;
  end;

procedure THauptfenster.Ende1Click(Sender: TObject);
  begin
  If UserWants2Break4(cmd_Exit) then begin
    If Not (Modus in [cmd_Drag, cmd_Exit]) then   { Vorsichtshalber; }
      Reset2DragMode;    { sollte aber eigentlich überflüssig sein ! }
    Close;
    end;
  end;

{----- Menü Bearbeiten -------}

procedure THauptfenster.SB_UndoClick(Sender: TObject);
  begin
  If UserWants2Break4(cmd_Undo) then with Drawing do
    If LastValidObjIndex >= 5 then begin
      InvalidateObject(TGeoObj(Drawing.Items[LastValidObjIndex]));
      RefreshSpecialImageButtons;
      Drawing.Repaint;
      end
    else
      MessageDlg(MyMess[44], mtInformation, [mbOk], 0);
  end;

procedure THauptfenster.SB_UndoUndoClick(Sender: TObject);
  var Obj2UnDelete : TGeoObj;
      PrevName     : String;
  begin
  If UserWants2Break4(cmd_UndoUndo) then with Drawing do
    If LastValidObjIndex < Pred(Count) then begin
      Obj2UnDelete := TGeoObj(Drawing.Items[Succ(LastValidObjIndex)]);
      PrevName := Copy(Obj2Undelete.Name, 2, Length(Obj2UnDelete.Name));
      RevalidateObject(Obj2UnDelete);
      If Obj2UnDelete.Name <> PrevName then
        MessageDlg(Format(MyMess[88], [PrevName, Obj2Undelete.Name]),
                   mtInformation, [mbOk], 0);
      Drawing.Repaint;
      end
    else
      MessageDlg(MyMess[45], mtInformation, [mbOk], 0);
  end;

procedure THauptfenster.Kopieren1Click(Sender: TObject);
  var CopyCanvas : TCanvas;
      MyMetaFile : TMetaFile;
      MyBitMap   : TBitmap;
      orgX, orgY,
      dx, dy          : Integer;
      LeftX, TopY,
      RightX, BottomY : Double;
      CRect           : TRect;
  begin
  If UserWants2Break4(cmd_WriteToCB) then begin
    InternalLineStyle := ClipboardNeedsLineSupport;
    InternalCurvStyle := ClipboardNeedsCurvSupport;

    If SelStatus = 3 then begin
      CRect := LTRB_Rect(SelRect);   { Daten holen, dabei gegebenenfalls }
      With CRect do begin            { die Orientierung korrigieren      }
        { Maße des zu kopierenden Bereichs holen }
        orgX  := Succ(Left);
        orgY  := Succ(Top);
        dx := Pred(Right) - Succ(Left);
        dy := Pred(Bottom) - Succ(Top);
        end;
      end
    else with PaintBox1 do begin
      orgX   := 0;
      orgY   := 0;
      dx := Pred(ClientWidth);
      dy := Pred(ClientHeight);
      end;

    Drawing.GetLogCoords(orgX, orgY, LeftX, TopY);
    Drawing.GetLogCoords(orgX + dx, orgY + dy, RightX, BottomY);

    MyMetafile := TMetafile.Create;
    With MyMetafile do begin
      Width  := Round(dx * ClipBoardScaleX);
      Height := Round(dy * ClipBoardScaleX * ClipBoardAspect);
      end;
    CopyCanvas := TMetafileCanvas.CreateWithComment
                   (MyMetafile, 0, 'DynaGeo',
                    Application.Title + ' / ' + ActGeoFileName);
    try
      Drawing.ExportScaled_To(CopyCanvas, outClipboard,
                              LeftX, TopY, RightX, BottomY,
                              ClipBoardScaleX, ClipBoardAspect);
    finally
      CopyCanvas.Free;
    end; { of try }

    MyBitMap := TBitMap.Create;
    MyBitMap.Width  := dx;
    MyBitMap.Height := dy;
    Drawing.Copy2Bitmap(MyBitMap, Point(orgX, orgY));
    // Der folgende Code war ein müder Versuch, die erhöhte Auflösung des
    // Pixelbild-Exports in Bitmap-Dateien auch für den Export ins Clip-
    // Board zu erhalten, was aber so leider nicht funktionierte:
    //
    // Drawing.ExportScaled_To(MyBitMap.Canvas, outClipBoard,
    //                        LeftX, TopY, RightX, BottomY,
    //                        ClipBoardScaleX, ClipBoardAspect);

    With Clipboard do begin
      Open;
      Assign(MyBitMap);
      Assign(MyMetaFile);
      Close;
      end;

    MyBitMap.Free;
    MyMetaFile.Free;
    InternalLineStyle := False;
    InternalCurvStyle := False;
    FSelStatus := 0;
    Drawing.Repaint;
    end;
  end;

procedure THauptfenster.SB_NameObjClick(Sender: TObject);
  begin
  InitInputList(cmd_NameObj, Sender);
  end;

procedure THauptfenster.ZeichnungEditieren1Click(Sender: TObject);
  begin
  If InitInputList(cmd_EditDraw, Nil) then
    Tabset1.TabIndex := index_EditDraw;
  end;

procedure THauptfenster.SB_EraseObjClick(Sender: TObject);
  begin
  InitInputList(cmd_DelObj, Sender);
  end;

procedure THauptfenster.SB_BindPoint2LineClick(Sender: TObject);
  begin
  InitInputList(cmd_BindP2L, Sender);
  end;

procedure THauptfenster.SB_ReleasePointClick(Sender: TObject);
  begin
  InitInputList(cmd_ReleaseP, Sender);
  end;

procedure THauptfenster.PunktinfreienBasispunktverwandeln1Click(Sender: TObject);
  begin
  InitInputList(cmd_Pt2BasePt, Sender);
  end;

procedure THauptfenster.ZweiPunktezusammenfhren1Click(Sender: TObject);
  begin
  InitInputList(cmd_CombinePts, Sender);
  end;

procedure THauptfenster.Area2ForegroundClick(Sender: TObject);
  begin
  InitInputList(cmd_Area2ForeGr, Sender);
  end;

{----- Menü Ansicht -------}

procedure THauptfenster.SB_HideObjClick(Sender: TObject);
  begin
  If IsAltCmd(Sender) then begin
    AlleVerborgenenObjekteAnzeigen1Click(Sender);
    (Sender as TSpeedButton).Down := False;
    Reset2DragMode;
    end
  else
    If InitInputList(cmd_ToggleVis, Sender) then begin
      Drawing.MakeHiddenObjectsTempVisible;
      BackInvalid := True;
      end;
  end;

procedure THauptfenster.AlleverborgenenObjekteanzeigen1Click(Sender: TObject);
  var i : Integer;
  begin
  If Drawing.HiddenObjCount > 0 then begin
    If MessageDlg(MyMess[12], mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      For i := 5 to Pred(Drawing.Count) do
        TGeoObj(Drawing[i]).ShowsAlways := True;
    Drawing.Repaint;
    end
  else
    MessageDlg(MyMess[13], mtInformation, [mbOk], 0);
  end;

// Gruppen-Verwaltung siehe oben in einem eigenen Abschnitt !!!

procedure THauptfenster.BasisObjekteBlinken1Click(Sender: TObject);
  begin
  If UserWants2Break4(cmd_BlinkBaseObj) then begin
    FModus := cmd_BlinkBaseObj;
    ShowMyHint(65);
    GeoTimer.InitBaseObjBlinking(Drawing);
    end;
  end;

procedure THauptfenster.Zeichnungverschieben1Click(Sender: TObject);
  begin
  If UserWants2Break4(cmd_Slide) then begin
    FModus := cmd_Slide;
    ShowMyHint(19);
    RefreshCursor;
    end;
  end;

procedure THauptfenster.ZeichnungVergroessern1Click(Sender: TObject);
  begin
  If UserWants2Break4(cmd_ZoomIn) then begin
    Drawing.RescaleDrawing(ZoomFaktor);
    Drawing.Repaint;
    ShowMousePosLogCoords(Last_XM, Last_YM);
    end;
  end;

procedure THauptfenster.ZeichnungReset1Click(Sender: TObject);
  begin
  If UserWants2Break4(cmd_ZoomReset) then begin
    Drawing.RescaleCoordSys(ScreenPPCMx, ScreenPPCMy);
    Drawing.WindowOrigin := Point(PaintBox1.ClientWidth Div 2,
                                  PaintBox1.ClientHeight Div 2);
    Drawing.Repaint;
    ShowMousePosLogCoords(Last_XM, Last_YM);
    RefreshSpecialImageButtons;
    end;
  end;

procedure THauptfenster.ZeichnungVerkleinern1Click(Sender: TObject);
  begin
  If UserWants2Break4(cmd_ZoomOut) then begin
    Drawing.RescaleDrawing(1/ZoomFaktor);
    Drawing.Repaint;
    ShowMousePosLogCoords(Last_XM, Last_YM);
    end;
  end;

procedure THauptfenster.SB_SetSquareClick(Sender: TObject);
  var SQO     : TGeoObj;
      err_num : Integer;
  begin
  If Drawing.HasSetsquare(SQO) then
    Drawing.FreeObject(SQO)
  else
    Drawing.InsertObject(GeoImage.TGSetSquare.Create(Drawing, True), err_num, 5);
  RefreshSpecialImageButtons;
  Drawing.Repaint;
  end;

procedure THauptfenster.ZeichnungNeuZeichnen1Click(Sender: TObject);
  begin
  Drawing.Repaint;
  Reset2DragMode;
  end;


{---- Zeichnen- und Konstruieren-Menü ----}

procedure THauptfenster.Punkt1Click(Sender: TObject);
  begin
  if IsAltCmd(Sender) then
    InitInputList(cmd_LatticePt, Sender)
  else
    InitInputList(cmd_PCreate, Sender);
  end;

procedure THauptfenster.PunktmitKoordinatenxy1Click(Sender: TObject);
  begin
  If UserWants2Break4(cmd_PtCoord) then
    with KoordEingabe do begin
      HelpContext := cmd_PtCoord;
      // Keine Vorgaben! Alte Werte stehen lassen, falls welche vorhanden sind!
      InitInputList(cmd_PtCoord, Sender);
      Self.ShowMyHint(38);
      Show;
      end;
  end;

procedure THauptfenster.PunktaufeinerLinie1Click(Sender: TObject);
  begin
  InitInputList(cmd_POnLine, Sender);
  end;

procedure THauptfenster.SB_IntersectionClick(Sender: TObject);
  begin
  InitInputList(cmd_Schnitt, Sender);
  end;

procedure THauptfenster.SB_MidPointClick(Sender: TObject);
  begin
  InitInputList(cmd_Mitte, Sender);
  end;

procedure THauptfenster.Gitterpunkt1Click(Sender: TObject);
  begin
  InitInputList(cmd_LatticePt, Sender);
  end;

procedure THauptfenster.SB_ShortLineClick(Sender: TObject);
  begin
  InitInputList(cmd_SCreate, Sender);
  end;

procedure THauptfenster.SB_VectorClick(Sender: TObject);
  begin
  InitInputList(cmd_Vector, Sender);
  end;

procedure THauptfenster.SB_MidLineClick(Sender: TObject);
  begin
  InitInputList(cmd_Strahl, Sender);
  end;

procedure THauptfenster.SB_LongLineClick(Sender: TObject);
  begin
  InitInputList(cmd_GCreate, Sender);
  end;

procedure THauptfenster.SB_PerpendicularClick(Sender: TObject);
  begin
  If IsAltCmd(Sender) then
    InitInputList(cmd_LotStrecke, Sender)
  else
    InitInputList(cmd_Lot, Sender);
  end;

procedure THauptfenster.SB_ParallelLineClick(Sender: TObject);
  begin
  InitInputList(cmd_Parall, Sender);
  end;

procedure THauptfenster.SB_PerpBisectorClick(Sender: TObject);
  begin
  If IsAltCmd(Sender) then
    InitInputList(cmd_Chordal, Sender)
  else
    InitInputList(cmd_MSenkr, Sender);
  end;

procedure THauptfenster.SB_BisectorClick(Sender: TObject);
  begin
  If IsAltcmd(Sender) then
    InitInputList(cmd_WHalbKomp, Sender)
  else
    InitInputList(cmd_WHalb, Sender);
  end;

procedure THauptfenster.SB_CircleClick(Sender: TObject);
  begin
  If IsAltCmd(Sender) then
    InitInputList(cmd_Circle3P, Sender)
  else
    InitInputList(cmd_KCreate, Sender);
  end;

procedure THauptfenster.WinkelbogenClick(Sender: TObject);
  begin
  InitInputList(cmd_MarkAngle, Sender);
  end;

procedure THauptfenster.SB_FixLineClick(Sender: TObject);
  begin
  If UserWants2Break4(cmd_LCreate) then begin
    InitInputList(cmd_LCreate, Sender);
    // Keine Wertvorgabe in KonstEingabe! Alten Wert stehen lassen!
    If KonstEingabe.ShowModal <> mrOk then begin
      AutoRepeat := False;  // Abbruch einer eventuellen Wiederholungs-Schleife
      ShowMyHint(0);
      Reset2DragMode;
      end
    else
      ShowMyHint(26);
    end;
  end;

procedure THauptfenster.SB_XCircleClick(Sender: TObject);
  begin
  If UserWants2Break4(cmd_MCreate) then begin
    If IsAltCmd(Sender) then
      InitInputList(cmd_CircleSLR, Sender)
    else begin
      ShowMyHint(23);
      with WertEingabe do begin
        Caption := MyMess[35];
        Edit1.HTMLTextAsString := Float2Str(2.5, 2);
        HelpContext := cmd_MCreate;
        InitInputList(cmd_MCreate, Sender);
        Show;
        end;
      end;
    end;
  end;

procedure THauptfenster.SB_XAngleLineClick(Sender: TObject);
  var cmd_id : Integer;
  begin
  If IsAltCmd(Sender) then
    cmd_id := cmd_SRichtTerm
  else
    cmd_id := cmd_GRichtTerm;
  If UserWants2Break4(cmd_id) then begin
    ShowMyHint(27);
    with WertEingabe do begin
      Caption := MyMess[36];
      Edit1.HTMLTextAsString := Float2Str(35.0, 1) + '°';
      HelpContext := cmd_id;
      InitInputList(cmd_id, Sender);
      Show;
      end;
    end;
  end;

procedure THauptfenster.Geradeaufziehen1Click(Sender: TObject);
  begin
  InitInputList(cmd_RCreate, Sender);
  end;

procedure THauptfenster.KreisLinieAufziehen1Click(Sender: TObject);
  begin
  InitInputList(cmd_FCreate, Sender);
  end;

procedure THauptfenster.SB_CircleArcClick(Sender: TObject);
  begin
  InitInputList(cmd_Arc, Sender);
  end;

procedure THauptfenster.SB_TriangleClick(Sender: TObject);
  begin
  InitInputList(cmd_DCreate, Sender);
  end;

procedure THauptfenster.SB_PolygonClick(Sender: TObject);
  begin
  If IsAltCmd(Sender) then
    RegulresNEck1Click(Sender)
  else
    InitInputList(cmd_NCreate, Sender);
  end;

procedure THauptfenster.RegulresNEck1Click(Sender: TObject);
  var n : Integer;
  begin
  ShowMyHint(104);
  with WertEingabe do begin
    Caption := MyMess[130];
    Edit1.HTMLTextAsString := IntToStr(5);
    HelpContext := cmd_RegPoly;
    If ShowModal = mrOk then begin
      n := Abs(Round(StrToFloat(LastValueWStr[0])));
      If (n >= 3) and (n <= 100) then
        InitInputList(cmd_RegPoly, Sender)
      else begin
        MessageDlg(MyMess[131], mtError, [mbOk], 0);
        Reset2DragMode;
        end;
      end
    else
      Reset2DragMode;
    end;
  end;

procedure THauptfenster.StreckeEinschiebenClick(Sender: TObject);
  begin
  If UserWants2Break4(cmd_verging) then begin
    InitInputList(cmd_verging, Sender);
    ShowMyHint(25);
    with WertEingabe do begin
      Caption := MyMess[56];
      Edit1.HTMLTextAsString := Float2Str(3.0, 1);
      HelpContext := cmd_verging;
      Show;
      end;
    end;
  end;


{--------- Editieren-Leiste --------------}

procedure THauptfenster.SB_EditObjClick(Sender: TObject);
  begin
  InitInputList(cmd_EditDraw, Sender);
  end;

procedure THauptfenster.SB_FillAreaClick(Sender: TObject);
  begin
  InitInputList(cmd_FillArea, Sender);
  end;

procedure THauptfenster.SB_CutAreaClick(Sender: TObject);
  begin
  InitInputList(cmd_CutArea, Sender);
  end;


{--------- Abbilden-Menü -----------------}

procedure THauptfenster.SB_MirrorAxisObjClick(Sender: TObject);
  begin
  InitInputList(cmd_MirrorAxisObj, Sender);
  end;

procedure THauptfenster.SB_MirrorCentreObjClick(Sender: TObject);
  begin
  InitInputList(cmd_MirrorCentreObj, Sender);
  end;

procedure THauptfenster.SB_MoveObjClick(Sender: TObject);
  begin
  InitInputList(cmd_MoveObj, Sender);
  end;

procedure THauptfenster.SB_RotateObjClick(Sender: TObject);
  begin
  InitInputList(cmd_RotateObj, Sender);
  end;

procedure THauptfenster.SB_StretchObjClick(Sender: TObject);
  begin
  InitInputList(cmd_StretchObj, Sender);
  end;

procedure THauptfenster.SB_MirrorPtAtCircleClick(Sender: TObject);
  begin
  InitInputList(cmd_MirrorCircleObj, Sender);
  end;

procedure THauptfenster.SB_DefineAffinMapClick(Sender: TObject);
  var AffAbb_1_Dlg: TAffAbb_1_Dlg;
      n : Integer;
  begin
  FLastMapping := Nil;
  LastLVOIndex := Drawing.LastValidObjIndex;
  AffAbb_1_Dlg := TAffAbb_1_Dlg.Create(Self);
  AffAbb_1_Dlg.Left := AffAssPos.X;
  AffAbb_1_Dlg.Top  := AffAssPos.Y;
  GeoTimer.InitObjBlinking(Drawing);
  If AffAbb_1_Dlg.ShowModal = mrOk then begin
    n := AffAbb_1_Dlg.TagOfCheckedRB;
    AffAssPos := Point(AffAbb_1_Dlg.Left, AffAbb_1_Dlg.Top);
    AffAbb_1_Dlg.Free;
    InitInputList(cmd_DefineAffin, SB_DefineAffinMap);
    Case n of
      1..3 : begin
             ActiveTermWin := TAffAbb_2_Dlg.Create(Self);
             (ActiveTermWin as TAffAbb_2_Dlg).InitTexts(MyMess[96 + n]);
             end;
      4    : begin
             ActiveTermWin := TAffAbb_2b_Dlg.Create(Self);
             (ActiveTermWin as TAffAbb_2_Dlg).InitTexts(MyMess[100]);
             end;
      5    : begin
             ActiveTermWin := TAffAbb_2a_Dlg.Create(Self);
             (ActiveTermWin as TAffAbb_2_Dlg).InitTexts(MyMess[101]);
             end;
      6    : begin
             ActiveTermWin := TAffAbb_2c_Dlg.Create(Self);
             (ActiveTermWin as TAffAbb_2_Dlg).InitTexts(MyMess[102]);
             end;
      7    : begin
             ActiveTermWin := TAffAbb_2d_Dlg.Create(Self);
             (ActiveTermWin as TAffAbb_2_Dlg).InitTexts(MyMess[103]);
             end;
      8    : begin
             ActiveTermWin := TAffAbb_2e_Dlg.Create(Self);
             (ActiveTermWin as TAffAbb_2_Dlg).InitTexts(MyMess[103]);
             end;
    else
      FreeAndNil(ActiveTermWin);
      Reset2DragMode;
    end;
    If ActiveTermWin <> Nil then begin
      with ActiveTermWin do begin
        Left := AffAssPos.X;
        Top  := AffAssPos.Y;
        Show;
        end;
      AffinMapSubVers := n * 10;
      If AffinMapSubVers in [60..79] then   // Patch für AffinDrehung und allg. Affinität
        Start.ExpectedType := ccAnyPoint;
      end;
    end
  else begin  // Abbruch !!
    AffAbb_1_Dlg.Free;
    Reset2DragMode;
    end;
  end;

procedure THauptfenster.SB_MapObjClick(Sender: TObject);
  begin
  RefreshMappingMenus;
  ShowPopupNearButton(MappingsMenu, SB_MapObj);
  end;

procedure THauptfenster.AbbildungaufObjAnwenden1Click(Sender: TObject);
  var n : Integer;
  begin
  If Sender is TMenuItem then begin
    n := TMenuItem(Sender).Tag;
    FLastMapping := Drawing.GetObj(n) as TGTransformation;
    InitInputList(cmd_MapObj, SB_MapObj);
    end;
  end;

procedure THauptfenster.AbbildungEditieren1Click(Sender: TObject);
  var EditMapWin : TEditMappingDlg;
      n : Integer;
  begin
  If Sender is TMenuItem then begin
    n := TMenuItem(Sender).Tag;
    FLastMapping := Drawing.GetObj(n) as TGTransformation;
    InitInputList(cmd_EditMap, Nil);
    EditMapWin := TEditMappingDlg.CreateWMap(Self, FLastMapping as TGMatrixMap);
    try
      If FLastMapping.MapType = mapAffineMapMat then begin
        ActiveTermWin := EditMapWin;
        EditMapWin.Show;
        end
      else begin
        EditMapWin.ShowModal;
        Reset2DragMode;
        EditMapWin.Release;
        end;
    except
      SpyOut('Error while showing or editing a mapping''s matrix.', []);
    end; { of try }
    end; { of if }
  end;



{----- Kurven - Leiste -------------------}

procedure THauptfenster.SB_MakeTraceClick(Sender: TObject);
  begin
  If InitInputList(cmd_MakeLocLine, Sender) then begin
    AutoRepeat := False;
    TraceOnly  := GetKeyState(vk_menu) < 0;
    LastLVOIndex := Drawing.LastValidObjIndex;
    If GetKeyState(vk_Shift) < 0 then begin
      OkayButton.Caption := MyMess[2];
      OkayButton.Show;
      OLineMode := 2;
      end
    else
      OLineMode := 1;
    end;
  end;

procedure THauptfenster.RecordTraceClick;
  begin
  OLineMode := 3;
  OkayButton.Close;
  GeoTimer.Reset(Drawing);
  ShowMyHint(21);
  PrevModus := cmd_MakeLocLine;
  FModus    := cmd_Drag;
  end;

procedure THauptfenster.SB_MakeEnvelopClick(Sender: TObject);
  begin
  If InitInputList(cmd_MakeEnvelop, Sender) then begin
    AutoRepeat := False;
    TraceOnly  := GetKeyState(vk_menu) < 0;
    LastLVOIndex := Drawing.LastValidObjIndex;
    OLineMode := 1;
    end;
  end;

procedure THauptfenster.RecordEnvelopClick;
  begin
  OLineMode := 3;
  OkayButton.Close;
  GeoTimer.Reset(Drawing);
  ShowMyHint(21);
  PrevModus := cmd_MakeEnvelop;
  FModus    := cmd_Drag;
  end;

procedure THauptfenster.SB_GraphClick(Sender: TObject);
  begin
  If UserWants2Break4(cmd_Graph) then begin
    if IsAltCmd(Sender) then begin
      InitInputList(cmd_Polynom, Sender);
      end
    else begin
      ShowMyHint(81);
      with WertEingabe do begin
        Caption := MyMess[95];
        Edit1.Clear;
        HelpContext := cmd_Graph;
        InitInputList(cmd_Graph, Sender);
        Show;
        end;
      end;
    end;
  end;

procedure THauptfenster.SB_PolynomClick(Sender: TObject);
  begin
  InitInputList(cmd_Polynom, Nil);
  end;


procedure THauptfenster.SB_TangenteClick(Sender: TObject);
  begin
  If IsAltCmd(Sender) then
    InitInputList(cmd_Normale, Sender)
  else
    InitInputList(cmd_Tangente, Sender);
  end;

procedure THauptfenster.SB_GraphAreaClick(Sender: TObject);
  var i : Integer;
  begin
  If Not Drawing.CoSysVisible then begin
    CoSysWasInvisible := True;
    For i := 0 to 2 do
      TGeoObj(Drawing.Items[i]).ShowsAlways := True;
    Drawing.Repaint;
    end;
  If IsAltCmd(Sender) then
    RiemannSummen1Click(Sender)
  else
    InitInputList(cmd_GraphArea, Sender);
  end;

procedure THauptfenster.RiemannSummen1Click(Sender: TObject);
  var i : Integer;
  begin
  For i := 0 to 5 do LastValueWStr[i] := '';
  ShowMyHint(106);
  InitInputList(cmd_Riemann, Sender);
  end;

procedure THauptfenster.SB_EllipseFClick(Sender: TObject);
  begin
  InitInputList(cmd_EllipseF, Sender);
  end;

procedure THauptfenster.SB_EllipseSClick(Sender: TObject);
  begin
  InitInputList(cmd_EllipseS, Sender);
  end;

procedure THauptfenster.SB_EllipseKClick(Sender: TObject);
  begin
  InitInputList(cmd_EllipseK, Sender);
  end;

procedure THauptfenster.SB_ParabelFClick(Sender: TObject);
  begin
  InitInputList(cmd_ParabelF, Sender);
  end;

procedure THauptfenster.SB_ParabelTClick(Sender: TObject);
  begin
  InitInputList(cmd_ParabelT, Sender);
  end;

procedure THauptfenster.SB_HyperbelFClick(Sender: TObject);
  begin
  InitInputList(cmd_HyperbelF, Sender);
  end;

procedure THauptfenster.SB_HyperbelAClick(Sender: TObject);
  begin
  InitInputList(cmd_HyperbelA, Sender);
  end;

procedure THauptfenster.SB_ConicClick(Sender: TObject);
  begin
  InitInputList(cmd_Conic, Sender);
  end;

procedure THauptfenster.SB_PolareClick(Sender: TObject);
  begin
  InitInputList(cmd_Polare, Sender);
  end;

procedure THauptfenster.SB_PolClick(Sender: TObject);
  begin
  InitInputList(cmd_Pol, Sender)
  end;

procedure THauptfenster.SB_GlassClick(Sender: TObject);
  begin
  If MagnGlassWin = Nil then  // No MagnGlass shown yet !!
    InitInputList(cmd_MagnGlass, Sender)   // Sender as TSpeedButton
  else begin        // Kill the already shown MagnGlass !!
    MagnGlassWin.Close;
    MagnGlassWin := Nil;
    Reset2DragMode;
    Drawing.Repaint;
    end;
  RefreshSpecialImageButtons;
  end;



{----- Messen & Rechnen - Leiste ---------}

procedure THauptfenster.Koordinatensystem1Click(Sender: TObject);

  function CosysCanBeEdited: Boolean;
  var msg: String;
      i  : Integer;
    begin
    Result := True;
    If Drawing.CoSysInVisGroup then
      If Drawing.CoSysVisible then begin
        i := TGeoObj(Drawing[0]).Groups;
        msg := Format(MyMess[94], [Drawing.GroupList.GetCommentFrom(i)]);
        MessageDlg(msg, mtInformation, [mbOK], 0)
        end
      else
        if MessageDlg(MyMess[93], mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
          For i := 0 to 2 do
            TGeoObj(Drawing.Items[i]).RevokeFromGroup(-1);
          Drawing.Repaint;
          end
        else
          Result := False;
    end;

  begin  { of Koordinatensystem1Click }
  If UserWants2Break4(cmd_CoordSys) and
     CosysCanBeEdited then begin
    CoordDlg.ShowModal;
    Drawing.Repaint;
    Reset2DragMode;
    end;
  end;   { of Koordinatensystem1Click }


procedure THauptfenster.Punktfixieren1Click(Sender: TObject);
  begin
  InitInputList(cmd_FixPt, Sender);
  end;

procedure THauptfenster.PunktaufGitterpunktschieben1Click(Sender: TObject);
  begin
  InitInputList(cmd_Clip2Grid, Sender);
  end;

procedure THauptfenster.Punktfixierungaufheben1Click(Sender: TObject);
  begin
  InitInputList(cmd_UnfixPt, Sender);
  end;

procedure THauptfenster.Abstndemessen1Click(Sender: TObject);
  begin
  If IsAltCmd(Sender) then
    InitInputList(cmd_MeasureSL, Sender)
  else
    InitInputList(cmd_MeasureDist, Sender);
  end;

procedure THauptfenster.SB_MeasureAreaClick(Sender: TObject);
  begin
  InitInputList(cmd_MeasureArea, Sender);
  end;

procedure THauptfenster.Winkelweitemessen1Click(Sender: TObject);
  begin
  InitInputList(cmd_MeasureAngle, Sender);
  end;

procedure THauptfenster.SB_TermObjClick(Sender: TObject);
  begin
  If UserWants2Break4(cmd_TermObj) then begin
    InitInputList(cmd_TermObj, Sender);
    ShowMyHint(62);
    with WertEingabe do begin
      Caption := MyMess[90];
      Edit1.HTMLTextAsString := '';
      HelpContext := cmd_TermObj;
      Show;
      end;
    end;
  end;

procedure THauptfenster.SB_NumberObjClick(Sender: TObject);
  var ErrNum : Integer;
  begin
  InitInputList(cmd_NumberObj, Sender);
  Drawing.InsertObject(TGNumberObj.Create(Drawing, 180, -3, 1, 5, True), ErrNum);
  RefreshAnimationButtons;
  PaintBox1Paint(Self);
  Reset2DragMode;
  end;


{ ----------------- Animations-Leiste ------------------- }

procedure THauptfenster.SB_AniOptionsClick(Sender: TObject);
  begin
  If Drawing.AnimationPossible then begin
    Start.Clear;
    ShowMyHint(74);
    AniParamsWin.ShowModal;
    Drawing.Repaint;
    end
  else
    MessageDlg(MyMess[24], mtError, [mbOk], 0);
  Reset2DragMode;
  end;

procedure THauptfenster.SB_AniFastFDBKClick(Sender: TObject);
  begin
  FModus := cmd_ResetAnima;
  Drawing.FillDragList(Drawing.AnimationSource);
  Drawing.AnimationRunning := True;
  With Drawing.AnimationSource do
    If Sender = SB_AniFastBK then
      AniValue := AniMinValue
    else
      AniValue := AniMaxValue;
  Drawing.AnimationRunning := False;
  Drawing.GroupList.UpdateConditions;
  Drawing.IsDoubleBuffered := True;
  Drawing.Repaint;
  Reset2DragMode;
  end;

procedure THauptfenster.SB_AnimateClick(Sender: TObject);
  var newMode  : Integer;
  begin
  If Assigned(FunkTabelle) then begin
    FunkTabelle.Close;
    Application.ProcessMessages;
    end;
  TSpeedButton(Sender).Down := True;
  FModus := TSpeedButton(Sender).Tag;
  ShowMyHint(75);

  Drawing.AnimationRunning := True;
  Drawing.IsDoubleBuffered := True;
  Drawing.FillDragList(Drawing.AnimationSource);
  SpeedBar.Repaint;
  Repeat
    newMode := Drawing.Animate(Modus);
    Application.ProcessMessages;
  until Not (newMode in [cmd_RunAnimaFD, cmd_RunAnimaBK]);
  SpeedBar.Repaint;
  Drawing.IsDoubleBuffered := Double_Buffered;
  Drawing.AnimationRunning := False;

  Reset2DragMode;
  If AppShouldClose then begin
    AppShouldClose := False;
    Application.Terminate;
    end;
  end;

procedure THauptfenster.SB_AniStopMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
  Reset2DragMode;
  end;

procedure THauptfenster.SB_AniStopClick(Sender: TObject);
  begin
  SB_AniStop.Down := False;
  end;


{----- Makro-Menü ----------}

procedure THauptfenster.SB_RunMakroClick(Sender: TObject);
  var n : Integer;
  begin
  If Sender is TMenuItem then begin
    n := (Sender as TMenuItem).MenuIndex - 6;
    end
  else
    n := (Sender as TSpeedButton).Tag;
  If (n >= 0) and (n < Drawing.MakroList.Count) then begin
    MaCmdNum  := 0;
    MakroNum  := n;
    If InitInputList(cmd_RunMakro, Sender) then begin
      MakroMode := 1;
      TMakro(Drawing.MakroList[MakroNum]).Reset(Drawing);
      With SB_Action do begin
        Visible := True;
        Enabled := True;
        Tag  := MakroNum;
        Hint := MyMakMsg[25] + TMakro(Drawing.MakroList.Items[MakroNum]).Name;
        end;
      end
    else
      Reset2DragMode;
    end
  else
    MessageDlg(MyMakMsg[38], mtError, [mbOK], cmd_RunMakro);
  end;

procedure THauptfenster.SetNewMakroMode(NMM: Integer);
  var pm  : TMakro;
      buf : String;
      nmi : TMenuItem;  { new menu item }
  begin
  MakroMode := NMM;
  Case MakroMode of
    1 : begin
        buf := IntToStr(Succ(Drawing.MakroList.Count));
        buf := MyMakMsg[34] + buf;
        Drawing.MakroList.Add(TMakro.Create(Drawing, buf, MyMakMsg[35]));
        MakroNum := Pred(Drawing.MakroList.Count);
        With OkayButton do begin
          Caption := MyMakMsg[29];
          Show;
          end;
        GeoTimer.InitObjBlinking(Drawing);
        end;
    2 : begin
        OkayButton.Caption := MyMakMsg[30];
        end;
    3 : begin
        OkayButton.Hide;
        GeoTimer.Reset(Drawing);
        Cursor := crArrow;
        pm := Drawing.MakroList.Last;
        If pm.NewMakroIsOkay then with MakHelpDlg do begin
          Edit1.Text := pm.Name;
          Memo1.Text := pm.HelpText;
          If ShowModal = mrOk then begin
            pm.Name     := Edit1.Text;
            pm.HelpText := Memo1.Text;
            nmi := TMenuItem.Create(Self);
            nmi.caption := pm.Name;
            nmi.OnClick := SB_RunMakroClick;
            MakroMenu.Add(nmi);
            With SB_Action do begin
              Visible := True;
              Enabled := True;
              Tag := Drawing.MakroList.Count - 1;
              Hint := MyMakMsg[25] + pm.Name;
              end;
            MessageDlg(Format(MyMakMsg[31], [pm.Name]),
                       mtInformation, [mbOk], cmd_DefMakro);
            end
          else begin
            Drawing.MakroList.Remove(pm);
            MessageDlg(MyMakMsg[33], mtInformation, [mbOk], cmd_DefMakro);
            end;
          end
        else begin         { ungültiges Makro wird gelöscht }
          pm.ShowErrorMsg(MaCmdNum);
          Drawing.MakroList.Remove(pm);
          end;
        Reset2DragMode;
        end;
  end; { of case }
  end;


function THauptfenster.ChooseMakroNum : Integer;
  var cmn : Integer;
  begin
  case Drawing.MakroList.Count of
    0 : begin
        MessageDlg(MyMakMsg[16], mtInformation, [mbOk], 0);
        cmn := -1;
        end;
    1 : cmn :=  0;
  else
    SelectDlg.LoadMakList;
    If SelectDlg.ShowModal = mrOk then
      cmn := SelectDlg.SelectedItem
    else
      cmn := -1;
  end; { of case }
  ChooseMakroNum := cmn;
  end;

procedure THauptfenster.NeuesMakroErstellen1Click(Sender: TObject);
  begin
  If InitInputList(cmd_DefMakro, Sender) then
    SetNewMakroMode(1);
  end;

procedure THauptfenster.Makrobeschreibungeditieren1Click(Sender: TObject);
  var n  : Integer;
      pm : TMakro;
  begin
  If UserWants2Break4(cmd_EditHlpMakro) then begin
    n := ChooseMakroNum;
    If n >= 0 then with MakHelpDlg do begin
      pm := Drawing.MakroList.Items[n];
      Edit1.Text := pm.Name;
      Memo1.Text := pm.HelpText;
      If ShowModal = mrOk then begin
        pm.Name     := Edit1.Text;
        pm.HelpText := Memo1.Text;
        MakroMenu.Items[n+6].Caption := pm.Name;
        If SB_Action.Tag = n then
          SB_Action.Hint := MyMakMsg[25] + pm.Name;
        Drawing.IsDirty := True;
        end;
      end;
    end;
  end;

procedure THauptfenster.VorhandenesMakrolschen1Click(Sender: TObject);
  var n : Integer;
  begin
  If UserWants2Break4(cmd_DelMakro) then begin
    n := ChooseMakroNum;
    If n >= 0 then begin
      (Drawing.MakroList as TMakroList).DeleteMakro(n);
      MakroMenu.Delete(n + 6);
      Drawing.IsDirty := True;
      end;
    With Hauptfenster.SB_Action do
      If Drawing.MakroList.Count > 0 then
        If Tag >= Drawing.MakroList.Count then begin
          Tag := Drawing.MakroList.Count - 1;
          Hint := MyMakMsg[25] + TMakro(Drawing.MakroList.Last).Name;
          end
        else
      else begin
        Visible := False;
        Enabled := False;
        Tag := -1;
        end;
    end;
  end;

procedure THauptfenster.Makroladen1Click(Sender: TObject);
  var n, i    : Integer;
      msg     : String;
      NewItem : TMenuItem;
  begin
  If UserWants2Break4(cmd_LoadMakro) and
     LoadMakFile.Execute then begin
    n := Drawing.MakroList.Count;
    i := 0;
    msg := '';
    While (msg = '') and                          // bisher keine Fehler
          (i < LoadMakFile.Files.Count) do begin  // noch ein Makro selektiert
      Case MakXMLFileLoad(LoadMakFile.Files[i], Drawing) of
        1 : msg := MyMakMsg[18];
        2 : msg := MyMakMsg[17];
      else  { Alles in Ordnung! }
        NewItem := TMenuItem.Create(Self);
        NewItem.caption := TMakro(Drawing.MakroList.Last).Name;
        NewItem.OnClick := SB_RunMakroClick;
        MakroMenu.Add(NewItem);
        Drawing.IsDirty := True;
        With SB_Action do begin
          Visible := True;
          Enabled := True;
          Tag := Drawing.MakroList.Count - 1;
          Hint := MyMakMsg[25] + TMakro(Drawing.MakroList.Last).Name;
          end;
      end; { of case }
      i := i + 1;
      end; { of while }
    If Length(msg) > 0 then begin
      MessageDlg(Format(msg, [LoadMakFile.Filename]),
                 mtError, [mbOk], 0);
      With Drawing.MakroList do  // Falls beim Laden ein Fehler passierte,
        If Count > n then begin  // aber das Makro trotzdem der Liste hinzu-
          TMakro(Last).Free;     // gefügt wurde, wird das letzte Makro in
          Delete(Pred(Count));   // der Liste gleich wieder gelöscht.
          end;
      end;
    end;
  end;

procedure THauptfenster.Makrospeichern1Click(Sender: TObject);
  var MakNum : Integer;       { neue Version mit automatischer }
      fname  : String;        { Ergänzung der Extension ".MAK" }
  begin
  If UserWants2Break4(cmd_SaveMakro) then begin
    MakNum := ChooseMakroNum;
    If SaveMakFile.Execute then begin
      fname := SaveMakFile.Filename;
      If UpperCase(ExtractFileExt(fname)) <> '.MAK' then
        fname := ChangeFileExt(SaveMakFile.Filename, '.mak');
      If MakXMLFileSave(fname, Drawing, MakNum) > 0 then
        MessageDlg(Format(MyFileMsg[9], [fname]), mtError, [mbOk], 0)
      else
        TMakro(Drawing.MakroList[MakNum]).NotYetSaved := False;
      end;
    end;
  end;

procedure THauptfenster.RefreshMakroMenu;
  var i: Integer;
      NewItem : TMenuItem;
  begin
  SpyOut('  Initial MakroMenu.Count = %d', [MakroMenu.Count]);
  With MakroMenu do
    While Count > 6 do
      Delete(Pred(Count));
  SpyOut('    ... and after deleting: %d', [MakroMenu.Count]);
  For i := 0 to Pred(Drawing.MakroList.Count) do begin
    NewItem := TMenuItem.Create(Self);
    NewItem.caption := TMakro(Drawing.MakroList.Items[i]).Name;
    NewItem.OnClick := SB_RunMakroClick;
    MakroMenu.Add(NewItem);
    SpyOut('  After trying to add "%s" : MakroMenu.Count = %d',
           [NewItem.Caption, MakroMenu.Count]);
    end;
  With SB_Action do
    If Drawing.MakroList.Count > 0 then begin
      Visible := True;
      Enabled := True;
      Tag  := Drawing.MakroList.Count - 1;
      Hint := MyMakMsg[25] + TMakro(Drawing.MakroList.Last).Name;
      end
    else begin
      Visible := False;
      Enabled := False;
      Tag := -1;
      end;
  SpyOut('  Final MakroMenu.Count = %d', [MakroMenu.Count]);
  end;

{----- Verschiedenes-Menü -------------}

procedure THauptfenster.Rckblende1Click(Sender: TObject);
  var s : String;
  begin
  If UserWants2Break4(cmd_ShowGrowth) then
    If Drawing.LastValidObjIndex > 5 then begin
      Reset2DragMode;
      FModus    := cmd_ShowGrowth;
      Last2Show := 4;
      StatusBar1.Panels[1].Style := psOwnerDraw;
      Repeat
        Inc(Last2Show);
        If Last2Show <= Drawing.LastValidObjIndex then
          s := TGeoObj(Drawing.Items[Last2Show]).GetInfo
        else
          s := '';
      until (Last2Show > Drawing.LastValidObjIndex) or
            (TGeoObj(Drawing.Items[Last2Show]).IsVisible and (Length(s) > 0));
      ShowHTMLHint(s);
      StatusBar1.Update;  { Nötig, um den ersten Schritt zu zeigen ! }
      Drawing.DrawFirstObjects(Last2Show, True);
      end
    else
      MessageDlg(MyMess[37], mtInformation, [mbOk], 0);
  end;

procedure THauptfenster.SpielWinkel1Click(Sender: TObject);
  var orgDrawing : TGeoObjListe;
  begin
  if FileExists('.\Winkel_01.geo') then begin
    orgDrawing := Drawing;
    Drawing := TGeoObjListe.Create(Handle, PaintBox1.Canvas, PaintBox1.ClientRect);
    Drawing.InitCoordSys(Paintbox1.ClientWidth div 3, Paintbox1.ClientHeight div 2,
                         Paintbox1.ClientRect, 1, False);
    DoLoadGeoFile('.\Winkel_01.geo');
    ShowMyHint(114);
    DisableCmdsThatBotherGames;
    Invalidate;
    Angles1Dlg := TAngles1Dlg.CreateWD(Self, Drawing);
    InitInputList(cmd_Game01, Nil, False, True);
    ShowMyHint(0);
    try
      Angles1Dlg.ShowModal;
    finally
      FreeAndNil(Angles1Dlg);
    end;
    FreeAndNil(Drawing);
    Drawing := orgDrawing;
    RestorePreviousCmdSet;
    Invalidate;
    end
  else
    MessageDlg(MyMess[155], mtInformation, [mbOK], 0);
  ShowMyHint(0); // Zugmodus-Meldung setzen
  Reset2DragMode;
  end;

procedure THauptfenster.SpielWinkel2Click(Sender: TObject);
  var SS : TGeoObj;
  begin
  if FileExists('.\Winkel_02.geo') then begin
    BackUpDrawing := Drawing;
    Drawing := TGeoObjListe.Create(Handle, PaintBox1.Canvas, PaintBox1.ClientRect);
    Drawing.InitCoordSys(Paintbox1.ClientWidth div 3, Paintbox1.ClientHeight div 2,
                         Paintbox1.ClientRect, 1, False);
    DoLoadGeoFile('.\Winkel_02.geo');
    ShowMyHint(0);
    DisableCmdsThatBotherGames;
    Invalidate;
    Angles2Dlg := TAngles2Dlg.CreateWD(Self, Drawing);
    ShowMyHint(0);
    if Drawing.HasSetsquare(SS) then
      (SS as GeoImage.TGSetSquare).SetResWinHandle(Angles2Dlg.Handle);
    Angles2Dlg.Show;  // Nicht-modales Stay-On-Top-Fenster anzeigen!
    end
  else
    MessageDlg(MyMess[155], mtInformation, [mbOK], 0);
  end;

procedure THauptfenster.KonstruktionsText1Click(Sender: TObject);
  begin
  If UserWants2Break4(cmd_ConstrText) then begin
    DeleteSelectionFrame;
    Reset2DragMode;
    try
      Screen.Cursor := crHourGlass;
      ConstrTextWin.GetTextFromDrawing(Drawing);
    finally
      Screen.Cursor := crDefault;
    end;
    GeoTimer.InitObjBlinking(Drawing);
    ConstrTextWin.ShowModal;
    GeoTimer.Reset(Drawing);
    end;
  end;

procedure THauptfenster.TextBoxClick(Sender: TObject);
  var dyna : Boolean;
  begin
  If UserWants2Break4(cmd_Comment) then begin
    Reset2DragMode;
    dyna := Sender = DynaHelp;
    If dyna then
      FModus := cmd_DynaHelp
    else
      FModus := cmd_Comment;
    ShowMyHint(49);
    TextWin.ActComment := Nil;
    TextWin.ExtendedFuncs := dyna;
    TextWin.ShowModal;
    Drawing.Repaint;
    Reset2DragMode;
    end;
  end;

procedure THauptfenster.VorhandeneTextboxeditieren1Click(Sender: TObject);
  begin
  InitInputList(cmd_EditComment, Sender);
  end;

procedure THauptfenster.TextboxanObjektbinden1Click(Sender: TObject);
  begin
  InitInputList(cmd_BindTBox2Obj, Sender);
  end;

procedure THauptfenster.BindungeinerTextboxlsen1Click(Sender: TObject);
  begin
  InitInputList(cmd_ReleaseTBox, Sender);
  end;

procedure THauptfenster.ImportPictureClick(Sender: TObject);
  var GeoImg : TGImage;
      err    : Integer;
      f_ext  : String;
  begin
  FModus := cmd_Image;
  If OpenPictureDialog1.Execute then begin
    GeoImg := TGImage.Create(Drawing, OpenPictureDialog1.FileName);
    If (GeoImg <> Nil) and GeoImg.HasPic then
      Drawing.InsertObject(GeoImg, err)
    else begin
      GeoImg.Free;
      f_ext := UpperCase(ExtractFileExt(OpenPictureDialog1.FileName));
      MessageDlg(Format(MyFileMsg[38], [f_ext]), mtError, [mbOk], 0);
      end;
    end;
  Reset2DragMode;
  end;

procedure THauptfenster.SB_CheckSolutionClick(Sender: TObject);
  var CCO: TGCheckControl;
  begin
  CCO := Drawing.CheckControl as TGCheckControl;
  If CCO <> Nil then begin
    InitInputList(cmd_CheckSol, SB_CheckSolution);
    If Length(CCO.VHint) > 0 then
      StatusBar1.Panels[1].Text := '  ' + CCO.VHint;
    end
  else
    Reset2DragMode;
  end;

procedure THauptfenster.CopyrightClick(Sender: TObject);
  begin
  If UserWants2Break4(cmd_FileProp) then
    FileProps.ShowModal;
  Reset2DragMode;
  end;

procedure THauptfenster.ViewerCommandsClick(Sender: TObject);
  var SelXCmdDlg : TSelectXCmdForm;
      oldCmdStr,
      newCmdStr  : String;
  begin
  oldCmdStr  := Drawing.CmdString;
  SelXCmdDlg := TSelectXCmdForm.CreateWithCmdStr(Self, oldCmdStr);
  try
    If SelXCmdDlg.ShowModal = mrOK then begin
      newCmdStr := SelXCmdDlg.GetCommands;
      If newCmdStr <> oldCmdStr then begin
        If Length(newCmdStr) > Length(oldCmdstr) then
          MessageDlg(MyMess[52], mtWarning, [mbOK], 0);
        With Drawing do begin
          CmdString := newCmdStr;
          IsDirty   := True;
          end;
        end;
      end;
  finally
    SelXCmdDlg.Release;
  end; { of try }
  end;

procedure THauptfenster.CorrectnessCheckClick(Sender: TObject);
  var CCD    : TConfigOKCheckDlg;
      ErrNum : Integer;
  begin
  CCD := TConfigOKCheckDlg.CreateWD(Self, Drawing, ActGeoFileName);
  try
    If CCD.ShowModal = mrOk then begin
      Drawing.DeleteCorrectnessCheck;
      If Length(CCD.Ed_Term.HTMLTextAsString) > 0 then begin
        Drawing.InsertObject(TGCheckControl.Create
                               (Drawing, CCD.Ed_Term.PlainText[0],
                                CCD.VLEditor.Strings.Text,
                                CCD.Ed_Hint.Text),
                             ErrNum);
        Drawing.LinkBack    := CCD.Ed_LinkFail.Text;
        Drawing.LinkForward := CCD.Ed_LinkSuccess.Text;
        end
      else begin    // Korrektheits-Prüfung komplett löschen !
        Drawing.LinkBack    := '';
        Drawing.LinkForward := '';
        end;
      RefreshCheckButtons;
      end;
  finally
    CCD.Release;
  end; { of try }
  end;

procedure THauptfenster.Einstellungen1Click(Sender: TObject);
  begin
  If UserWants2Break4(cmd_Options) then begin
    DeleteSelectionFrame;
    Reset2DragMode;
    If EditOptions.ShowModal = mrOk then
      With Drawing do begin    { Werte in aktueller Zeichnung updaten ! }
        LengthUnit := DefLengthUnit;
        AreaUnit   := DefAreaUnit;
        AngleUnit  := DefAngleUnit;
        UpdateAllObjects;
        Repaint;
        end;
    end;
  end;

{----- Hilfe-Menü --------}

procedure THauptfenster.Index1Click(Sender: TObject);
  begin
  Application.HelpCommand(Help_Contents, 0);
  end;

procedure THauptfenster.HilfezumAktuellenBefehlClick(Sender: TObject);
  begin
  If Modus = cmd_RunMakro then
    MakHelpWin.ShowModal        { MakroHilfe zeigen ! }
  else
    Application.HelpCommand(Help_Context, GetContextHelpIndex);
  end;

procedure THauptfenster.Grundlagen1Click(Sender: TObject);
  begin
  Application.HelpCommand(Help_Context, cmd_HelpBasics);
  end;

procedure THauptfenster.DasEuklidFenster1Click(Sender: TObject);
  begin
  Application.HelpCommand(Help_Context, cmd_HelpScreen);
  end;

procedure THauptfenster.TastaturundMaus1Click(Sender: TObject);
  begin
  Application.HelpCommand(Help_Context, cmd_HelpKeyMouse);
  end;

procedure THauptfenster.Lizenzbedingungen1Click(Sender: TObject);
  begin
  Application.HelpCommand(Help_Context, cmd_Licence);
  If Sender = TabSet1 then
    MyStopCursor := #$A1;
  end;

procedure THauptfenster.Registrierung1Click(Sender: TObject);
  var RegisterDlg : TRegisterDlg;
  begin
  RegisterDlg := TRegisterDlg.Create(Self);
  Try
    If UserWants2Break4(cmd_Register) and
       (RegisterDlg.ShowModal = mrOk) then begin
      IsShareWare := False;
      HilfeMenu.Remove(Registrierung1);
      MessageDlg(MyStartMsg[14], mtInformation, [mbOk], 0);
      Application.Terminate;
      end;
  finally
    RegisterDlg.Release;
  end;
  end;

procedure THauptfenster.UeberEuklid1Click(Sender: TObject);
  begin
  With AboutBox do begin
    Timer.Enabled := False;
    Button1.Caption := about_okaybtn;
    ShowModal;
    end;
  end;

{ -------- Neues ------------ }

procedure THauptfenster.TB_ZoomSliderChange(Sender: TObject);
  begin
  if MagnGlassWin <> Nil then begin
    Drawing.UpdateAllObjects;
    Drawing.Repaint;
    MagnGlassWin.RefreshBuffer;
    MagnGlassWin.Invalidate;
    end;
  end;


end.
