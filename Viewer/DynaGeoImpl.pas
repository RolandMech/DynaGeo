unit DynaGeoImpl;

interface

{$IFDEF NO_PLATFORMWARNINGS}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, Variants, DynaGeoX3_TLB, StdVcl, StdCtrls, ExtCtrls,
  URLMon, Menus, ComCtrls, FileIO, ToolWin, ImgList, Registry,
  Declar, GlobVars, Utility, GeoTypes, GeoMakro, GeoTransf,
  TBaum, CmdProc, ToolBarProc;

type
  TDynaGeoX = class(TActiveForm, IDynaGeoX, IPersistPropertyBag, IBindStatusCallBack)
    DrawWin: TPaintBox;
    MainMenu: TPopupMenu;
    Zurcksetzen1: TMenuItem;
    About: TMenuItem;
    LogoZeigen1: TMenuItem;
    Zeichnungvergrern1: TMenuItem;
    Zeichnungverkleinern1: TMenuItem;
    N2: TMenuItem;
    ButtonImages: TImageList;
    ContextMenu: TPopupMenu;
    ColorDlg: TColorDialog;
    LinesMenu: TPopupMenu;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N32: TMenuItem;
    N51: TMenuItem;
    ShapeMenu: TPopupMenu;
    GefllterKreis1: TMenuItem;
    GeflltesQuadrat1: TMenuItem;
    HohlerKreis1: TMenuItem;
    HohlesQuadrat1: TMenuItem;
    Kreuzaufrecht1: TMenuItem;
    Kreuzdiagonal1: TMenuItem;
    PatternMenu: TPopupMenu;
    Voll1: TMenuItem;
    KeinMuster1: TMenuItem;
    GestricheltOW1: TMenuItem;
    GestricheltNS1: TMenuItem;
    GestricheltNWSO1: TMenuItem;
    GestricheltNOSW1: TMenuItem;
    Kariertvertikalhorizontal1: TMenuItem;
    Kariertdiagonal1: TMenuItem;
    UserBitMap1: TMenuItem;
    N3: TMenuItem;
    Objektlschen1: TMenuItem;
    LetzteLschungwiderrufen1: TMenuItem;
    AlleObjekteAnzeigen1: TMenuItem;
    SelectMenu: TPopupMenu;
    SaveDialog1: TSaveDialog;
    Speichern1: TMenuItem;
    Logo: TImage;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ImgIcon: TImage;
    MakrosMenu: TPopupMenu;
    procedure ActiveFormCreate(Sender: TObject);
    procedure DrawWinPaint(Sender: TObject);
    procedure Zuruecksetzen1Click(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure DrawWinMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DrawWinMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawWinMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LogoZeigen1Click(Sender: TObject);
    procedure Zeichnungvergrern1Click(Sender: TObject);
    procedure Zeichnungverkleinern1Click(Sender: TObject);
    procedure ActiveFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActiveFormDestroy(Sender: TObject);
    procedure ToolButtonClick(Sender: TObject);
    procedure LinesMenuDrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
    procedure LinesMenuMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width,
      Height: Integer);
    procedure AttribMenuClick(Sender: TObject);
    procedure Objektlschen1Click(Sender: TObject);
    procedure LetzteLschungwiderrufen1Click(Sender: TObject);
    procedure AlleObjekteAnzeigen1Click(Sender: TObject);
    procedure Speichern1Click(Sender: TObject);
    procedure MainMenuPopup(Sender: TObject);
    procedure LogoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolBar1CustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure ToolBar1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawWinDblClick(Sender: TObject);
  private
    { Private-Deklarationen }
    Sized,
    InsideIE,
    FShowToolbar,
    FShowLogo    : Boolean;
    err_code     : Integer;
    DataFileName,
    ExportFileName,          { mit Pfad }
    HTMLPageName,
    DynaGeoXVersion,
    DynaGeoXTitle,
    ErrorMsg     : String;
    MousedObj    : TGeoObj;
    CmdEx        : TCmdExecuter;
    FEvents      : IDynaGeoXEvents;
    LastShiftState : TShiftState;
    MapMenu        : TMenuItem;
    function  GetShowLogo: Boolean;
    procedure SetShowLogo(NewVal: Boolean);
    procedure SetShowToolbar(NewVal: Boolean);
    procedure RetrieveOCXVersionData;
    procedure ActivateEvent(Sender: TObject);
    procedure ClickEvent(Sender: TObject);
    procedure CreateEvent(Sender: TObject);
    procedure DblClickEvent(Sender: TObject);
    procedure DeactivateEvent(Sender: TObject);
    procedure DestroyEvent(Sender: TObject);
    procedure DrawWinFirstPaint(Sender: TObject);
    procedure KeyPressEvent(Sender: TObject; var Key: Char);
    procedure ResizeEvent(Sender: TObject);
    procedure PaintEvent(Sender: TObject);
    function  ContainingBrowserWebAddress(obj: IUnknown): String;
    function  LoadDrawing: Integer;
    function  LoadDrawingFromLocalFile: Integer;
    procedure SpyOut(msg: String);
    procedure InitializeMakroMenu(MakList: TList);
    procedure AddMappingMenu(isNew: Boolean);
    procedure ShowPopupMenu(MousePos: TPoint);
    procedure OnMakroMenuClick(Sender: TObject);
    procedure TryLoading(var Msg: TMEssage); message cmd_TryLoading;
    procedure ProcessPopupCommands(var Msg: TMessage); message cmd_PopupCommand;
    procedure ContinueCommand(var Msg: TMessage); message cmd_Continue;
    procedure AdjustToolButton(var Msg: TMessage); message cmd_AdjToolBtn;
    procedure RunAnimation(var Msg: TMessage); message cmd_RunAnimation;
    procedure JumpLink(var Msg: TMessage); message cmd_JumpLink;

  protected
    { IDynaGeoX }
    procedure DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage); override;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    function Get_Active: WordBool; safecall;
    function Get_AutoScroll: WordBool; safecall;
    function Get_AutoSize: WordBool; safecall;
    function Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;
    function Get_Caption: WideString; safecall;
    function Get_Color: OLE_COLOR; safecall;
    function Get_Cursor: Smallint; safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    function Get_DropTarget: WordBool; safecall;
    function Get_Enabled: WordBool; safecall;
    function Get_Font: IFontDisp; safecall;
    function Get_HelpFile: WideString; safecall;
    function Get_KeyPreview: WordBool; safecall;
    function Get_PixelsPerInch: Integer; safecall;
    function Get_PrintScale: TxPrintScale; safecall;
    function Get_Scaled: WordBool; safecall;
    function Get_Visible: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    procedure _Set_Font(const Value: IFontDisp); safecall;
    procedure AboutBox; safecall;
    procedure Set_AutoScroll(Value: WordBool); safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    procedure Set_Cursor(Value: Smallint); safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    procedure Set_DropTarget(Value: WordBool); safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    procedure Set_Font(var Value: IFontDisp); safecall;
    procedure Set_HelpFile(const Value: WideString); safecall;
    procedure Set_KeyPreview(Value: WordBool); safecall;
    procedure Set_PixelsPerInch(Value: Integer); safecall;
    procedure Set_PrintScale(Value: TxPrintScale); safecall;
    procedure Set_Scaled(Value: WordBool); safecall;
    procedure Set_Visible(Value: WordBool); safecall;

    { IPersistPropertyBag }
    function IPersistPropertyBag.GetClassID = PersistPropertyBagGetClassID;
    function IPersistPropertyBag.InitNew = PersistPropertyBagInitNew;
    function IPersistPropertyBag.Load = PersistPropertyBagLoad;
    function IPersistPropertyBag.Save = PersistPropertyBagSave;
    function PersistPropertyBagInitNew: HResult; stdcall;
    function PersistPropertyBagGetClassID(out classID: TCLSID): HResult; stdcall;
    function PersistPropertyBagLoad(const pPropBag: IPropertyBag;
                                    const pErrorLog: IErrorLog): HResult; stdcall;
    function PersistPropertyBagSave(const pPropBag: IPropertyBag;
                                    fClearDirty: BOOL;
                                    fSaveAllProperties: BOOL): HResult; stdcall;
    { IBindStatusCallback }
    function OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult; stdcall;
    function GetPriority(out pnPriority): HResult; stdcall;
    function OnLowResource(reserved: DWORD): HResult; stdcall;
    function OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
                        szStatusText: LPCWSTR): HResult; stdcall;
    function OnStopBinding( hRes: HResult;
                            szError: LPCWSTR): HResult; stdcall;
    function GetBindInfo(out grfBINDF: DWORD;
                         var pbindinfo: TBindInfo): HResult; stdcall;
    function OnDataAvailable(grfBSCF, dwSize: DWORD;
                             FormatEtc: PFormatEtc;
                             stgmed: PStgMedium): HResult; stdcall;
    function OnObjectAvailable(const iid: TGUID;
                               punk: IUnknown): HResult; stdcall;
    { Diverses }
    procedure IDynaGeoX._Set_Font = IDynaGeoX__Set_Font;
    procedure IDynaGeoX.Set_Font = IDynaGeoX_Set_Font;
    procedure IDynaGeoX__Set_Font(var Value: IFontDisp); safecall;
    procedure IDynaGeoX_Set_Font(const Value: IFontDisp); safecall;
    function  Get_DataFile: WideString; safecall;
    procedure Set_DataFile(const Value: WideString); safecall;
    function  GetDataFile: WideString;
    procedure SetDataFile(const Value: WideString);
  public
    procedure Initialize; override;
    property  ShowLogo: Boolean read GetShowLogo write SetShowLogo;
    property  ShowToolbar: Boolean read FShowToolbar write SetShowToolbar;
  published
    procedure MapObjClick(Sender: TObject);
    property  DataFile: WideString read GetDataFile write SetDataFile;
  end;


implementation

uses ComObj, ComServ, Shdocvw, About1, MathLib, PropPage;

{$R *.DFM}

resourcestring

  DesignTimeMsg1  = '(wird zur Laufzeit eine Zeichnung aus der Datei';
  DesignTimeMsg2  = ' laden.)';
  DesignTimeMsg3  = '(Noch keine Zeichnung gewählt!)';

  
{ TDynaGeoX }

procedure TDynaGeoX.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
  begin
  DefinePropertyPage(Class_DGXPropPage1);
  end;

procedure TDynaGeoX.EventSinkChanged(const EventSink: IUnknown);
  begin
  FEvents := EventSink as IDynaGeoXEvents;
  end;

procedure TDynaGeoX.Initialize;
  begin
  inherited Initialize;
  OnActivate     := ActivateEvent;
  OnClick        := ClickEvent;
  OnCreate       := CreateEvent;
  OnDblClick     := DblClickEvent;
  OnDeactivate   := DeactivateEvent;
  OnDestroy      := DestroyEvent;
  OnKeyPress     := KeyPressEvent;
  OnPaint        := PaintEvent;
  OnResize       := ResizeEvent;
  LastShiftState := [];
  end;

function TDynaGeoX.Get_Active: WordBool;
  begin
  Result := Active;
  end;

function TDynaGeoX.Get_AutoScroll: WordBool;
  begin
  Result := AutoScroll;
  end;

function TDynaGeoX.Get_AutoSize: WordBool;
  begin
  Result := AutoSize;
  end;

function TDynaGeoX.Get_AxBorderStyle: TxActiveFormBorderStyle;
  begin
  Result := Ord(AxBorderStyle);
  end;

function TDynaGeoX.Get_Caption: WideString;
  begin
  Result := WideString(Caption);
  end;

function TDynaGeoX.Get_Color: OLE_COLOR;
  begin
  Result := OLE_COLOR(Color);
  end;

function TDynaGeoX.Get_Cursor: Smallint;
  begin
  Result := Smallint(Cursor);
  end;

function TDynaGeoX.Get_DoubleBuffered: WordBool;
  begin
  Result := DoubleBuffered;
  end;

function TDynaGeoX.Get_DropTarget: WordBool;
  begin
  Result := DropTarget;
  end;

function TDynaGeoX.Get_Enabled: WordBool;
  begin
  Result := Enabled;
  end;

function TDynaGeoX.Get_Font: IFontDisp;
  begin
  GetOleFont(Font, Result);
  end;

function TDynaGeoX.Get_HelpFile: WideString;
  begin
  Result := WideString(HelpFile);
  end;

function TDynaGeoX.Get_KeyPreview: WordBool;
  begin
  Result := KeyPreview;
  end;

function TDynaGeoX.Get_PixelsPerInch: Integer;
  begin
  Result := PixelsPerInch;
  end;

function TDynaGeoX.Get_PrintScale: TxPrintScale;
  begin
  Result := Ord(PrintScale);
  end;

function TDynaGeoX.Get_Scaled: WordBool;
  begin
  Result := Scaled;
  end;

function TDynaGeoX.Get_Visible: WordBool;
  begin
  Result := Visible;
  end;

function TDynaGeoX.Get_VisibleDockClientCount: Integer;
  begin
  Result := VisibleDockClientCount;
  end;

function TDynaGeoX.Get_DataFile: WideString;
  begin
  Result := DataFileName;
  end;

procedure TDynaGeoX._Set_Font(const Value: IFontDisp);
  begin
  SetOleFont(Font, Value);
  end;

procedure TDynaGeoX.AboutBox;
  var pt : TPoint;
  begin
  pt := ClientToScreen(Point(Width Div 2, Height Div 2));
  ShowDynaGeoXAbout(pt.x, pt.y, DynaGeoXVersion);
  end;

procedure TDynaGeoX.ActivateEvent(Sender: TObject);
  begin
  if FEvents <> nil then
    FEvents.OnActivate;
  end;

procedure TDynaGeoX.ClickEvent(Sender: TObject);
  begin
  if FEvents <> nil then
    FEvents.OnClick;
  end;

procedure TDynaGeoX.CreateEvent(Sender: TObject);
  begin
  if FEvents <> nil then
    FEvents.OnCreate;
  end;

procedure TDynaGeoX.DblClickEvent(Sender: TObject);
  begin
  if FEvents <> nil then
    FEvents.OnDblClick;
  end;

procedure TDynaGeoX.DeactivateEvent(Sender: TObject);
  begin
  if FEvents <> nil then
    FEvents.OnDeactivate;
  end;

procedure TDynaGeoX.DestroyEvent(Sender: TObject);
  { Der Aufruf von ActiveFormDestroy funktioniert nur dann sicher, wenn das
    ThreadingModel = tmSingle ist und wenn AutoObjectFactory.Create mit
    Instancing = ciSingleInstance aufgerufen wird. Da beides nötig ist,
    um bei mehreren parallel aktiven DynaGeoX-Instanzen in allen auch die
    Kontextmenüs haben zu können, wage ich es, diesen Aufruf so stehen zu
    lassen, um Aufräumarbeiten zu ermöglichen. Dies wird aber nur so gemacht,
    wenn sicher ist, dass DynaGeoX im IE läuft. Wahrscheinlich ist dies aber
    auch noch nicht ganz der gute Stil.
    BTW, wieso ist FEvents immer gleich NIL?  }
  begin
  If InsideIE then
    ActiveFormDestroy(Sender);  // Kritisch !!!
  if FEvents <> nil then
    FEvents.OnDestroy
  end;

procedure TDynaGeoX.KeyPressEvent(Sender: TObject; var Key: Char);
  var TempKey: Smallint;
  begin
  TempKey := Smallint(Key);
  if FEvents <> nil then
    FEvents.OnKeyPress(TempKey);
  Key := Char(TempKey);
  end;

procedure TDynaGeoX.PaintEvent(Sender: TObject);
  begin
  if FEvents <> nil then
    FEvents.OnPaint
  end;

procedure TDynaGeoX.ResizeEvent(Sender: TObject);
  begin
  Application.ProcessMessages;
  DrawWin.SetBounds(ToolBar1.Width, 0,
                    ClientWidth - ToolBar1.Width, ClientHeight);
  If ToolBar1.Width > 0 then begin
    Logo.Top := ClientHeight - Logo.Height;
    Logo.Visible := True;
    end
  else begin
    Logo.Top := ClientHeight;
    Logo.Visible := False;
    end;
  ToolBar1.Height := Logo.Top;
  If (CmdEx <> nil) and (CmdEx.GeoListe <> nil) then
    CmdEx.GeoListe.WindowRect := DrawWin.ClientRect;
  If FEvents <> nil then
    FEvents.OnResize
  end;

procedure TDynaGeoX.Set_AutoScroll(Value: WordBool);
  begin
  AutoScroll := Value;
  end;

procedure TDynaGeoX.Set_AutoSize(Value: WordBool);
  begin
  AutoSize := Value;
  end;

procedure TDynaGeoX.Set_AxBorderStyle(Value: TxActiveFormBorderStyle);
  begin
  AxBorderStyle := TActiveFormBorderStyle(Value);
  end;

procedure TDynaGeoX.Set_Caption(const Value: WideString);
  begin
  Caption := TCaption(Value);
  end;

procedure TDynaGeoX.Set_Color(Value: OLE_COLOR);
  begin
  Color := TColor(Value);
  end;

procedure TDynaGeoX.Set_Cursor(Value: Smallint);
  begin
  Cursor := TCursor(Value);
  end;

procedure TDynaGeoX.Set_DoubleBuffered(Value: WordBool);
  begin
  DoubleBuffered := Value;
  end;

procedure TDynaGeoX.Set_DropTarget(Value: WordBool);
  begin
  DropTarget := Value;
  end;

procedure TDynaGeoX.Set_Enabled(Value: WordBool);
  begin
  Enabled := Value;
  end;

procedure TDynaGeoX.Set_Font(var Value: IFontDisp);
  begin
  SetOleFont(Font, Value);
  end;

procedure TDynaGeoX.Set_HelpFile(const Value: WideString);
  begin
  HelpFile := String(Value);
  end;

procedure TDynaGeoX.Set_KeyPreview(Value: WordBool);
  begin
  KeyPreview := Value;
  end;

procedure TDynaGeoX.Set_PixelsPerInch(Value: Integer);
  begin
  PixelsPerInch := Value;
  end;

procedure TDynaGeoX.Set_PrintScale(Value: TxPrintScale);
  begin
  PrintScale := TPrintScale(Value);
  end;

procedure TDynaGeoX.Set_Scaled(Value: WordBool);
  begin
  Scaled := Value;
  end;

procedure TDynaGeoX.Set_Visible(Value: WordBool);
  begin
  Visible := Value;
  end;

procedure TDynaGeoX.Set_DataFile(const Value: WideString);
  begin
  If DataFileName <> Value then begin
    DataFileName := Value;
    If CmdEx <> Nil then
      CmdEx.GeoTimer.InitLoading;
    end;
  end;

{======= Doppelte Buchführung, macht DataFile persistent ======}

function  TDynaGeoX.GetDataFile: WideString;
  begin
  Result := Get_DataFile;
  end;

procedure TDynaGeoX.SetDataFile(const Value: WideString);
  begin
  Set_DataFile(Value);
  end;


{======= IPersistPropertyBag ==================================}

function TDynaGeoX.PersistPropertyBagLoad(const pPropBag: IPropertyBag;
                                          const pErrorLog: IErrorLog): HResult;
  var v   : OleVariant;
      DFN : String;   { "D"ata"F"ile"N"ame;  28.03.04: ist case-sensitiv !!! }
  begin
  if pPropBag.Read('DataFile', v, pErrorLog) = S_OK then begin
    InsideIE     := True;
    DFN          := String(v);      { 28.03.04: AnsiLowerCase() entfernt !!! }
    HTMLPageName := ContainingBrowserWebAddress(ComObject);
    If Length(HTMLPageName) > 0 then
      DataFile := ExtractURLPathFrom(HTMLPageName) +
                  ExtractURLNameFrom(DFN);
    end
  else
    DataFile := '';
  result := S_OK;
  end;

function TDynaGeoX.PersistPropertyBagSave(const pPropBag: IPropertyBag;
                                          fClearDirty,
                                          fSaveAllProperties: BOOL): HResult;
  begin
  result := S_OK;
  end;

function TDynaGeoX.PersistPropertyBagGetClassID(out classID: TCLSID): HResult;
  begin
  Result := S_FALSE;
  try
    classID := CLASS_DynaGeoX;
    Result := S_OK;
  except
  end;
  end;

function TDynaGeoX.PersistPropertyBagInitNew: HResult;
  begin
  result := S_FALSE;
  try
    result := S_OK;
  except
  end;
  end;


{======= IBindStatusCallback ==================================}

function TDynaGeoX.OnStartBinding(dwReserved: DWORD;
                                  pib: IBinding): HResult;
  begin
  Result := S_OK;
  end;

function TDynaGeoX.GetPriority(out pnPriority): HResult;
  begin
  Result := S_OK;
  end;

function TDynaGeoX.OnLowResource(reserved: DWORD): HResult;
  begin
  Result := S_OK;
  end;

function TDynaGeoX.OnProgress(ulProgress, ulProgressMax,
                              ulStatusCode: DWORD;
                              szStatusText: LPCWSTR): HResult;
  begin
  Result := S_OK;
  end;

function TDynaGeoX.OnStopBinding(hRes: HResult;
                                 szError: LPCWSTR): HResult;
  begin
  Result := S_OK;
  end;

function TDynaGeoX.GetBindInfo(out grfBINDF: DWORD;
                               var pbindinfo: TBindInfo): HResult;
  begin
  Result := S_OK;
  end;

function TDynaGeoX.OnDataAvailable(grfBSCF, dwSize: DWORD;
                                   FormatEtc: PFormatEtc;
                                   stgmed: PStgMedium): HResult;
  begin
  Result := S_OK;
  end;

function TDynaGeoX.OnObjectAvailable(const iid: TGUID;
                                     punk: IUnknown): HResult;
  begin
  Result := S_OK;
  end;


procedure TDynaGeoX.IDynaGeoX__Set_Font(var Value: IFontDisp);
  begin
  SetOleFont(Font, Value);
  end;

procedure TDynaGeoX.IDynaGeoX_Set_Font(const Value: IFontDisp);
  begin
  SetOleFont(Font, Value);
  end;


{======= Mein Code ============================================}

{------- Interne Routinen -------------------------------------}

procedure TDynaGeoX.RetrieveOCXVersionData;
  var reg      : TRegistry;
      filename : String;
      n, i     : Integer;
  begin
  filename        := '';
  DynaGeoXTitle   := 'DynaGeoX  ';
  DynaGeoXVersion := '2.6.0.142';   // Dummy-Eintrag, falls was schief geht
  reg := TRegistry.Create(KEY_READ);
  try
    reg.RootKey := HKEY_CLASSES_ROOT;
    If reg.OpenKeyReadOnly
         ('CLSID\{2EF98DE5-183F-11D4-83EC-EC6A1DB6E213}\InprocServer32') then
      begin
      filename := reg.ReadString('');
      reg.CloseKey;
      If Length(filename) > 0 then begin
        DynaGeoXVersion := FullVersionString(filename);
        n := 0;
        i := 0;
        While (n < 2) and (i < Length(DynaGeoXVersion)) do begin
          i := i + 1;
          If DynaGeoXVersion[i] = '.' then
            n := n + 1;
          end;
        If n >= 2 then
          DynaGeoXTitle := DynaGeoXTitle + Copy(DynaGeoXVersion, 1, Pred(i));
        end;
      end;
  finally
    reg.Free;
    IsActiveX    := True;
    AXVersionStr := DynaGeoXVersion;
  end; { of try }
  end;

function TDynaGeoX.ContainingBrowserWebAddress(obj: IUnknown): String;
  var site    : IOleClientSite;
      browser : IWebBrowserApp;
      srvcpro : IServiceProvider;
  begin
  Result := '';
  OleCheck((obj as IOleObject).GetClientSite(site));
  If site <> Nil then begin
    OleCheck(site.QueryInterface(IServiceProvider, srvcpro));
    OleCheck(srvcpro.QueryService(IWebBrowserApp, IWebBrowserApp, browser));
    Result := browser.LocationURL;
    end;
  end;

procedure TDynaGeoX.SetShowLogo(NewVal: Boolean);
  begin
  If NewVal then
    If CmdEx.GeoListe <> Nil then begin
      CmdEx.GeoListe.LogoPic := Logo;
      FShowLogo := True;
      DrawWin.Invalidate;
      end
    else     // Keine Änderung !
  else begin
    If CmdEx.GeoListe <> Nil then
      CmdEx.GeoListe.LogoPic := Nil;
    FShowLogo := False;
    DrawWin.Invalidate;
    end;
  If FShowLogo then begin
    Logo.Top := ClientHeight - Logo.Height;
    ToolBar1.Height := Logo.Top;
    Logo.Visible    := True;
    end
  else begin
    Logo.Visible    := False;
    ToolBar1.Height := ClientHeight;
    end;
  end;

function TDynaGeoX.GetShowLogo: Boolean;
  begin
  Result := FShowToolBar and FShowLogo;
  end;

procedure TDynaGeoX.SetShowToolbar(NewVal: Boolean);
  begin
  If NewVal then begin
    FShowToolbar := True;
    SetShowLogo(True);
    ToolBar1.Visible := True;
    ToolBar1.Width := 50;
    InitializeToolCommands(ToolBar1, CmdEx.GeoListe.CmdString);
    end
  else begin
    FShowToolbar := False;
    SetShowLogo(False);
    ToolBar1.Visible := False;
    ToolBar1.Width := 0;
    ResizeEvent(Self);
    end;
  end;

procedure TDynaGeoX.ContinueCommand(var Msg: TMessage);
  begin
  CmdEx.ExecuteCommand(Msg.WParam, Msg.LParam);
  end;

procedure TDynaGeoX.RunAnimation(var Msg: TMessage);
  begin
  Application.ProcessMessages;
  If Msg.WParam in [cmd_RunAnimaFD, cmd_RunAnimaBK] then
    CmdEx.RunAnimation
  else
    CmdEx.Reset2DragMode;
  end;

procedure TDynaGeoX.JumpLink(var Msg: TMessage);
  var serverpath,
      newtarget,
      target  : String;
      site    : IOleClientSite;
      browser : IWebBrowserApp;
      srvcpro : IServiceProvider;
      p       : Array[1..4] of OleVariant;
      i       : Integer;
  begin
  Case Msg.WParam of
    idh_LinkForward : target := CmdEx.GeoListe.LinkForward;
    idh_LinkBack    : target := CmdEx.GeoListe.LinkBack;
  else
    target := TGComment(CmdEx.Selected).GetLinkAddressFromTag(Msg.WParam);
  end;
  If Length(target) > 0 then begin
    If LowerCase(ExtractFileExt(target)) = '.geo' then begin
      newtarget := ChangeFileExt(target, '.html');
      replace('\', '/', newtarget);
      end;
    OleCheck((ComObject as IOleObject).GetClientSite(site));
    If site <> Nil then begin
      OleCheck(site.QueryInterface(IServiceProvider, srvcpro));
      OleCheck(srvcpro.QueryService(IWebBrowserApp, IWebBrowserApp, browser));
      serverpath := ExtractURLPathFrom(browser.LocationURL);
      If Length(serverpath) > 0 then begin
        newtarget := MergeURLPathAndRelFileName(serverpath, newtarget);
//        ShowMessage('Gegebener Link : ' + target + ' '#13#10#10 +
//                    'Errechnetes Link-Ziel : ' + newtarget);
        For i := 1 to 4 do p[i] := NULL;
        browser.Navigate(newtarget, p[1], p[2], p[3], p[4]);
        end;
      end;
    end;
  end;

procedure TDynaGeoX.SpyOut(msg: String);
  var f: TextFile; s: String;
  begin
  {$I-}
  AssignFile(f, 'C:\TEMP\DGXDebug.txt');
  if (not FileExists('C:\TEMP\DGXDebug.txt')) then
    Rewrite(f)  //create
  else
    Append(f);
  if ioresult = 0 then begin
    s := msg;
    if s = '-' then   // separator
      s := '-------------------------------------------------------';
    if s = '=' then   // separator
      s := '=======================================================';
    if (s <> '') and CharInSet(s[1], ['-', '=', '!']) then
      Delete(s, 1, 1)
    else
      s := TimeToStr(now) + ' : ' + s;
    Writeln(f, s);
    Flush(f);
    CloseFile(f);
    end;
  {$I+}
  end;


{--------------- Fenster-Lebenszyklus -----------------------}

procedure TDynaGeoX.ActiveFormCreate(Sender: TObject);
  var ScreenPPIx : Integer;
  begin
  RetrieveOCXVersionData;
  Sized            := False; // veranlasst die korrekte Initialisierung für
                            // Größe und Position der Komponenten zur Laufzeit
  DrawWin.OnPaint  := DrawWinFirstPaint;
  GlobalDefaultFont.Assign(Font);
  GlobalDefaultFont.Size := 10;
  ScreenPPIx := GetDeviceCaps(DrawWin.Canvas.Handle, LOGPIXELSX);
  ScreenPPCMx := ScreenPPIx / 2.54;
  ScreenPPCMy := ScreenPPCMx;
  act_PixelPerXcm := ScreenPPCMx;
  act_PixelPerYcm := ScreenPPCMy;
  scr_TwipsPerPixel := 1440 / ScreenPPIx;

  ReplaceColor(Logo.Picture.Bitmap, clYellow, ToolBar1.Color);
  Logo.Picture.Bitmap.TransparentColor := clWhite;
  Logo.Transparent := True;

  Double_Buffered  := True;    // Gepufferte Grafik-Ausgabe (in: GlobVars.pas)
  InsideIE         := False;
  FShowLogo        := True;
  FShowToolbar     := True;
  ErrorMsg         := '';
  CmdEx            := TCmdExecuter.Create(Handle, DrawWin, ToolBar1);
  end;


procedure TDynaGeoX.ActiveFormDestroy(Sender: TObject);
  begin
  DrawWin.Tag := -1;
  If CmdEx.Modus in [cmd_RunAnimaFD, cmd_RunAnimaBK] then
    CmdEx.Reset2DragMode;
  CmdEx.FreeGeoListe;
  CmdEx.Free;
  end;


{-------------- Fenster-Komponenten -----------------------------------}

procedure TDynaGeoX.LogoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  begin
  If CmdEx.GeoListe <> Nil then
    If (x > 9) and (x < 39) and
       (y > 7) and (y < 38) and
       (CmdEx.Modus = cmd_Drag) and
       (Not CmdEx.GeoListe.ShowingCRText) then
      If ssCtrl in Shift then
        ShowLogo := Not ShowLogo
      else
        AboutClick(Sender)
    else
      If y > 43 then begin
        If (ssCtrl in Shift) and // (ssAlt in Shift) and
           (CmdEx.GeoListe.CRNr > 0) then
          CmdEx.GeoTimer.InitShowCRMsg(CmdEx.GeoListe);
        If ssShift in Shift then
          DrawWin.Invalidate
        else
          CmdEx.GeoListe.DrawFirstObjects(CmdEx.GeoListe.LastValidobjIndex, True);
        end;
  end;


procedure TDynaGeoX.ToolButtonClick(Sender: TObject);

  function GetMakroIndex: Integer;
    begin
    If (CmdEx.GeoListe.MakroList = Nil) or
       (CmdEx.GeoListe.MakroList.Count = 0) then
      Result := -1
    else if CmdEx.GeoListe.MakroList.Count = 1 then
      Result := 0
    else
      Result := 1;
    end;

  var pu : String;
      pt : TPoint;
  begin
  Case TToolButton(Sender).Tag of
    cmd_SaveAs    : Speichern1Click(Sender);
    cmd_RunMakro  : Case GetMakroIndex of
                     -1 : CmdEx.Reset2DragMode;
                      0 : CmdEx.StartMakro(0);
                      1 : With TToolButton(Sender) do begin
                            pu := Hint;
                            Hint := '';
                            CmdEx.Modus := cmd_ChooseMakro;
                            pt := DrawWin.ClientToScreen
                                     (Point(- Width Div 2, Top + Height Div 2));
                            MakrosMenu.Popup(pt.X, pt.Y);
                            Hint := pu;
                            end;
                    end; { of case }
    cmd_GRichtTerm: If CmdEx.ReadLinesAngle then
                      CmdEx.Modus := cmd_GRichtTerm
                    else
                      CmdEx.Reset2DragMode;
    cmd_MCreate   : If CmdEx.ReadCirclesRadius then
                      CmdEx.Modus := cmd_MCreate
                    else
                      CmdEx.Reset2DragMode;
  else
    If (TToolButton(Sender).Tag = cmd_MeasureDist) and
       (ssAlt in LastShiftState) then
      CmdEx.Modus := cmd_MeasureSL
    else
      CmdEx.Modus := TToolButton(Sender).Tag;
    If CmdEx.Modus in [cmd_MCreate, cmd_NumberObj,
                       cmd_TermObj, cmd_Graph] then
      CmdEx.ExecuteCommand(0, 0);
    If (Not (CmdEx.Modus in [cmd_RunAnimaFD, cmd_StopAnima, cmd_Drag])) and
       (CmdEx.GeoListe <> Nil) then
      CmdEx.GeoTimer.InitObjBlinking(CmdEx.GeoListe);
  end; { of case }
  end;

procedure TDynaGeoX.ToolBar1CustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
  begin
  If Not ShowLogo then
    Sender.Canvas.Draw(5, ToolBar1.ClientHeight - 34, ImgIcon.Picture.Icon);
  end;

procedure TDynaGeoX.ToolBar1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  begin
  If (y > ToolBar1.ClientHeight - 34) and
     (x > 5) and (x < 37) and
     (CmdEx.Modus = cmd_Drag) and
     ((CmdEx.GeoListe = Nil) or
      (Not CmdEx.GeoListe.ShowingCRText)) then
    If ssCtrl in Shift then
      ShowLogo := Not ShowLogo
    else
      AboutClick(Sender);
  end;


{------------ Makro-Menü ----------------------------------------}

procedure TDynaGeoX.InitializeMakroMenu(MakList: TList);
  var MenuItem : TMenuItem;
      i        : Integer;
  begin
  MakrosMenu.Items.Clear;
  If MakList.Count > 0 then
    If MakList.Count = 1 then begin
      For i := 0 to Pred(ToolBar1.ButtonCount) do
        If ToolBar1.Buttons[i].Tag = cmd_RunMakro then
          ToolBar1.Buttons[i].Hint := TMakro(MakList[0]).Name;
      end
    else
      For i := 0 to Pred(MakList.Count) do begin
        MenuItem := TMenuItem.Create(MakrosMenu);
        MenuItem.Caption := TMakro(MakList[i]).Name;
        MenuItem.OnClick := OnMakroMenuClick;
        MakrosMenu.Items.Add(MenuItem);
        end;
  end;

procedure TDynaGeoX.OnMakroMenuClick(Sender: TObject);
  var n : Integer;
  begin
  n := MakrosMenu.Items.IndexOf(Sender as TMenuItem);
  If n >= 0 then
    CmdEx.StartMakro(n)
  else
    CmdEx.Reset2DragMode;
  end;

{------------ Zeichnung laden -----------------------------------}

procedure TDynaGeoX.TryLoading(var Msg: TMessage);
  var res : Integer;
  begin
  If Length(DataFileName) > 0 then
    Try
      res := LoadDrawing;
      If res < 0 then begin              { Fehler beim Laden }
        ErrorMsg := MyFileMsg[21];
        If res <> -3 then
          CmdEx.GeoTimer.InitLoading       { neuer Versuch ! }
        else begin
          err_code := 8;
          ErrorMsg := Format(MyFileMsg[ 6], [DataFileName]); { Datei nicht gefunden }
          DrawWinPaint(Self);
          end;
        end
      else begin                         { Daten erfolgreich geladen }
        ShowToolBar := Length(CmdEx.GeoListe.CmdString) > 0;
        InitializeMakroMenu(CmdEx.GeoListe.MakroList);
        CmdEx.GeoListe.WindowRect := DrawWin.ClientRect;
        ErrorMsg := '';
        end;
    except
      ErrorMsg := MyFileMsg[21];
    end;
  end;

function TDynaGeoX.LoadDrawing: Integer;
  { Ergebnis:  0 : Erfolgreich
              -1 : Datei nicht gefunden
              -3 : Daten fehlerhaft  }
  var LocalFile    : String;
      LocalFileBuf : Array[0..1024] of Char;
      res          : Integer;
      n            : DWord;
  begin
  If Length(DataFileName) > 0 then
    If (Pos('http:', DataFileName) > 0) or
       (Pos('file:', DataFileName) > 0) then  { Datei im Web !!! }
      try
        n := SizeOf(LocalFileBuf);
        FillChar(LocalFileBuf[0], n, 0);
        res := URLDownloadToCacheFile(IUnknown(VCLComObject),
                                      PChar(DataFileName),
                                      LocalFileBuf,
                                      n - 1, 0, Nil);
        If res = S_OK then begin
          LocalFile := StrPas(LocalFileBuf);
          If FileExists(LocalFile) then begin
            CmdEx.LocalFileName := LocalFile;
            Result := LoadDrawingFromLocalFile;
            end
          else begin
            CmdEx.LocalFileName := '';
            Result := -1;
            end;
          end
        else
          Result := -1;
      finally
        // Achtung! Nur vom IE neu angelegte Pufferdateien löschen!
        //          Bei lokalem Zugriff ("file:///....") nicht !!!
        If (Pos('http:', DataFileName) > 0) and FileExists(Localfile) then
          DeleteFile(LocalFile);
      end { of try }
    else begin                                     { Datei lokal !!! }
      CmdEx.LocalFileName := DataFileName;
      Result := LoadDrawingFromLocalFile;
      end
  else
    Result := -1;
  end;

(*
// Version mit eigener lokaler Datei im Temp-Verzeichnis:
function TDynaGeoX.LoadDrawing: Integer;
  { Ergebnis:  0 : Erfolgreich
              -1 : Datei nicht gefunden
              -3 : Daten fehlerhaft  }
  var LocalFile    : String;
      LocalFileBuf : Array[0..1024] of Char;
      res          : Integer;
      n            : DWord;
  begin
  If Length(DataFileName) > 0 then
    If (Pos('http:', DataFileName) > 0) or
       (Pos('file:', DataFileName) > 0) then  { Datei im Web !!! }
      try
        n := SizeOf(LocalFileBuf);
        FillChar(LocalFileBuf[0], n, 0);
        GetTempPath(Pred(SizeOf(LocalFileBuf)), LocalFileBuf);
        LocalFile := StrPas(LocalFileBuf) + 'edg000';
        Repeat
          Increment(LocalFile)
        until Not FileExists(LocalFile + '.geo');
        LocalFile := LocalFile + '.geo';
        res := URLDownloadToFile(IUnknown(VCLComObject),
                                 PChar(DataFileName),
                                 PChar(LocalFile),
                                 0, Nil);
        If res = S_OK then begin
          If FileExists(LocalFile) then begin
            CmdEx.LocalFileName := LocalFile;
            Result := LoadDrawingFromLocalFile;
            end
          else begin
            CmdEx.LocalFileName := '';
            Result := -1;
            end;
          end
        else
          Result := -1;
      finally
        If FileExists(Localfile) then
          DeleteFile(LocalFile);
      end { of try }
    else begin                                     { Datei lokal !!! }
      CmdEx.LocalFileName := DataFileName;
      Result := LoadDrawingFromLocalFile;
      end
  else
    Result := -1;
  end;
*)

function TDynaGeoX.LoadDrawingFromLocalFile: Integer;
  { Nur im IE wird eine externe Pufferdatei *permanent* angelegt, weil nur
    dort gewährleistet ist, dass diese Datei beim Schließen des Fensters
    auch wirklich wieder gelöscht wird.
    Außerhalb des IE wird die Pufferdatei gleich nach dem einlesen wieder
    gelöscht. Damit ist der erneute Download der Datei erforderlich, wenn
    die Zeichnung in den Originalzustand zurückgesetzt werden soll.

    27.03.04: Permanente Pufferdatei auch im IE abgeschafft, weil dies:
              1. Schwierigkeiten (Ladehemmungen) bei mehreren parallel offenen
                 DynaGeoX-Fenstern verursachte und
              2. ohnehin nicht verträglich ist mit der abzusehenden Erweiterung
                 auf externe Bilddateien (PNG-Support für Hintergrund-Bilder)
    Mithin wird nun direkt nach dem Laden eine lokal angelegte Pufferdatei
    gleich wieder gelöscht, so dass zum Neu-Laden der Zeichnung nun auch ein
    neuer Download fällig ist. Geht leider nicht anders!                     }

  begin
  If (Length(CmdEx.LocalFileName) > 0) then
    If FileExists(CmdEx.LocalFileName) then begin
      Screen.Cursor    := crHourGlass;
      DrawWin.Align    := alNone;
      DrawWin.Visible  := False;
      Application.ProcessMessages;
      Update;
      err_code := CmdEx.LoadGeoFile(DrawWin.ClientRect);
      DrawWin.Visible  := True;
      Screen.Cursor    := crDefault;
      Application.ProcessMessages;   { Damit DrawWin.ClientRect gesetzt wird ! }
      Case err_code of
        0 : begin
            ErrorMsg := '';
            CmdEx.RealizeNewFile(DrawWin.ClientRect);
            end;
        1 : ErrorMsg := MyFileMsg[17]; { Größenkorrektur mißlungen }
        2 : ErrorMsg := MyFileMsg[22]; { Falsche Links, Reparaturversuch }
        4 : ErrorMsg := Format(MyFileMsg[16], [DataFileName]); { Unbekanntes Format }
        8 : ErrorMsg := Format(MyFileMsg[ 6], [DataFileName]); { Datei nicht gefunden }
      else
        ErrorMsg := MyFileMsg[23]; { mehrere Probleme beim Laden }
      end; { of case }
      CmdEx.LocalFileName := '';   { 27.03.04: Jetzt immer direkt löschen !!! }
      If err_code = 0 then begin
        Result := 0;
        CmdEx.GeoListe.IsDoubleBuffered := True;
        end
      else
        Result := -3;
      DrawWin.Invalidate;
      end
    else begin
      CmdEx.LocalFileName := '';
      ErrorMsg := Format(MyFileMsg[ 6], [DataFileName]); { Datei nicht gefunden }
      Result := -1;
      end
  else begin
    ErrorMsg := MyFileMsg[25];  { Falscher Dateiname }
    Result := -1;
    end;
  end;


{-------------- Bildschirm-Ausgabe ---------------------------------}

procedure TDynaGeoX.DrawWinFirstPaint(Sender: TObject);
  begin
  If Not Sized then begin
    ResizeEvent(Sender);
    Sized := True;   // damit's nur *einmal* passiert !
    end;
  If (CmdEx.GeoListe = Nil) or
     (CmdEx.GeoListe.Count = 0) then
    CmdEx.GeoTimer.InitLoading
  else begin
    CmdEx.GeoListe.WindowRect := DrawWin.ClientRect;
    DrawWin.OnPaint := DrawWinPaint;
    Invalidate;
    end;
  end;


procedure TDynaGeoX.DrawWinPaint(Sender: TObject);
  var OldSize : Integer;
  begin
  If (CmdEx.GeoListe <> Nil) and
     (CmdEx.GeoListe.Count > 0) then
    with CmdEx.GeoListe do
      DrawFirstObjects(LastValidObjIndex, True)
  else begin { GeoListe = Nil ! }
    If (Length(DataFile) > 0) and
       (err_code = 0) then
      CmdEx.GeoTimer.InitLoading;
    If CmdEx.GeoListe = Nil then with DrawWin.Canvas do
      If Length(ErrorMsg) > 0 then begin
        ShowLogo := False;
        TextOut(10, 10, ErrorMsg);
        end
      else
        If Not InsideIE then begin   { Objekt-Identifizierung zur Design-Zeit }
          ToolBar1.Width := 0;
          OldSize := Font.Size;
          Font.Size := 18;
          TextOut(10, 10, DynaGeoXTitle);
          Font.Size := 12;
          If Length(DataFileName) > 0 then begin
            TextOut(10,  60, DesignTimeMsg1);
            TextOut(20,  85, DataFileName);
            TextOut(10, 110, DesignTimeMsg2);
            end
          else
            TextOut(10, 60, DesignTimeMsg3);
          Font.Size := OldSize;
          end;
    end;
  end;


procedure TDynaGeoX.LinesMenuDrawItem(Sender: TObject; ACanvas: TCanvas;
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


procedure TDynaGeoX.LinesMenuMeasureItem(Sender: TObject; ACanvas: TCanvas;
  var Width, Height: Integer);
  begin
  Width  := 80;
  Height := 20;
  end;


procedure TDynaGeoX.AttribMenuClick(Sender: TObject);
  begin
  CmdEx.ProcessPopupObj(MousedObj, TMenuItem(Sender).MenuIndex);
  end;


procedure TDynaGeoX.AdjustToolButton(var Msg: TMessage);
  begin
  Case Msg.WParam of
    cmd_Drag            : AdjustAnimationButton(24, 215);
    cmd_RunAnimaFD,
    cmd_RunAnimaBK      : AdjustAnimationButton(25, 216);
  end; { of case }
  end;


procedure TDynaGeoX.AddMappingMenu(isNew: Boolean);
  var mapMI : TMenuItem;
      i     : Integer;
  begin
  For i := 0 to CmdEx.GeoListe.LastValidObjIndex do with CmdEx.GeoListe do
    If TGeoObj(Items[i]) is TGTransformation then begin
      If isNew then begin
        MapMenu := NewSubMenu(cme_mapobj, 0, 'MapMenu', []);
        MainMenu.Items.Insert(6, MapMenu);
        isNew := False;
        end;
      mapMI := TMenuItem.Create(MapMenu);
      mapMI.Caption := TGTransformation(Items[i]).GetInfo;
      mapMI.OnClick := MapObjClick;
      mapMI.Tag     := i;     // Index der Abbildung in der GeoListe !
      MapMenu.Add(mapMI);
      end;
  end;

procedure TDynaGeoX.MainMenuPopup(Sender: TObject);
  const nr    : Array [0..6] of Integer = (1, 3, 4, 5, 7, 8, 10);
  var   no    : Array [0..6] of Integer;
        isNew : Boolean;
        i     : Integer;
  begin
  For i := 0 to 6 do no[i] := nr[i];
  If Assigned(MapMenu) then begin
    MapMenu.Clear;
    isNew := False;
    For i := 4 to 6 do Inc(no[i]);
    end
  else
    isNew := True;
  If CmdEx.GeoListe <> Nil then begin
    For i := 0 to 6 do  // Alle Befehle bearbeiten, die eine Zeichnung voraussetzen
      MainMenu.Items[no[i]].Enabled := True;
    LetzteLschungwiderrufen1.Enabled :=
      CmdEx.GeoListe.Count > Succ(CmdEx.GeoListe.LastValidObjIndex);
    AlleObjekteAnzeigen1.Enabled :=
      CmdEx.GeoListe.HiddenObjCount > 0;
    If ShowToolbar then
      If ShowLogo then
        LogoZeigen1.Caption := MyMess[54]
      else
        LogoZeigen1.Caption := MyMess[53]
    else
      LogoZeigen1.Enabled := False;
    AddMappingMenu(isNew);
    end
  else
    For i := 0 to 6 do  // Alle Befehle bearbeiten, die eine Zeichnung voraussetzen
      MainMenu.Items[no[i]].Enabled := False;
  end;


procedure TDynaGeoX.ShowPopupMenu(MousePos: TPoint);
  { Es wird sichergestellt, dass der Modus nicht cmd_Drag ist, während ein
    Kontextmenü aufgeklappt ist. Andernfalls würde beim Kontextmenü eines
    Basispunktes dieser zur Maus verzogen, wenn der Benutzer außerhalb des
    Kontextmenüs klickt, um dieses abzubrechen. }
  var i : Integer;
  begin
  CmdEx.Modus := cmd_ContextMenu;
  MousedObj := CmdEx.GetMousedObject(MousePos.X, MousePos.Y, ccAnyGeoObj);
  MousePos  := DrawWin.ClientToScreen(MousePos);
  If MousedObj = Nil then begin            { Kein Objekt dicht bei der Maus }
    If CmdEx.GeoListe <> Nil then begin
      Objektlschen1.Enabled :=
        Toolbar1.Visible and (CmdEx.GeoListe.Count > 5);
      LetzteLschungwiderrufen1.Enabled :=
        CmdEx.GeoListe.Count > Succ(CmdEx.GeoListe.LastValidObjIndex);
      AlleObjekteAnzeigen1.Enabled :=
        (CmdEx.GeoListe.HiddenObjCount > 0) or
        (TGeoObj(CmdEx.GeoListe.Items[0]).IsVisible = False);
      end;
    MainMenu.Popup(MousePos.X, MousePos.Y);
    end
  else begin                        { Ein Objekt dicht bei der Maus gefunden }
    MousedObj.LoadContextMenuEntriesInto(ContextMenu);
    For i := Pred(ContextMenu.Items.Count) DownTo 0 do
      If Not((ContextMenu.Items[i].Caption = '-') or
             (ContextMenu.Items[i].Tag in ViewerPopup_Commands)) then
        ContextMenu.Items.Delete(i);
    ContextMenu.Popup(MousePos.X, MousePos.Y);
    end;
  end;


procedure TDynaGeoX.ProcessPopupCommands(var Msg: TMessage);
  var MenuPos : TPoint;
  begin
  CmdEx.Modus := Msg.WParam;
  Case CmdEx.Modus of
    cmd_NameObj,
    cmd_EditComment,
    cmd_EditTerm,
    cmd_EditRange,
    cmd_EditRadius,
    cmd_EditCoords,
    cmd_EditAngle,
    cmd_EditFunktion,
    cmd_ToggleVis,
    cmd_BindP2L,
    cmd_ReleaseP,
    cmd_EditLocLineStyle,
    cmd_EditLocLineDyna,
    cmd_EditLocLineCurve,
    cmd_EditLocLineStnd,
    cmd_SetDotPt        : CmdEx.ProcessPopupObj(MousedObj);

    cmd_EditColour      : If ColorDlg.Execute then
                            CmdEx.ProcessPopupObj(MousedObj, Integer(ColorDlg.Color));
    cmd_EditLineStyle   : begin
                          MenuPos := DrawWin.ClientToScreen(CmdEx.LastMousePos);
                          LinesMenu.Popup(MenuPos.X, MenuPos.Y);
                          end;
    cmd_EditPointStyle  : begin
                          MenuPos := DrawWin.ClientToScreen(CmdEx.LastMousePos);
                          ShapeMenu.Popup(MenuPos.X, MenuPos.Y);
                          end;
    cmd_EditPattern     : begin
                          MenuPos := DrawWin.ClientToScreen(CmdEx.LastMousePos);
                          PatternMenu.Popup(MenuPos.X, MenuPos.Y);
                          end;
  else
    MessageDlg(MyMess[26], mtError, [mbOk], 0);
    CmdEx.Reset2DragMode;
  end; { of case }
  end;


{--------- Maus und Tastatur ------------------------------}

procedure TDynaGeoX.DrawWinMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
  begin
  LastShiftState := Shift;
  CmdEx.MouseMoveProc(Shift, X, Y);
  end;


procedure TDynaGeoX.DrawWinMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  begin
  LastShiftState := Shift;
  Case Integer(Button) of
   mbLeft  : CmdEx.MouseDownProc(Button, Shift, X, Y);
   mbRight : If CmdEx.Modus = cmd_Drag then
               ShowPopupMenu(Point(X, Y))
             else
               CmdEx.Reset2DragMode;
  end; { of case }
  end;


procedure TDynaGeoX.DrawWinMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  begin
  LastShiftState := Shift;
  CmdEx.MouseUpProc(Button, Shift, X, Y);
  end;


procedure TDynaGeoX.DrawWinDblClick(Sender: TObject);
  begin
  CmdEx.DoubleClickProc(Sender);
  end;


procedure TDynaGeoX.ActiveFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
  LastShiftState := Shift;
  Case Key of
    Ord('G')   : ZeichnungVergrern1Click(Sender);
    Ord('K')   : ZeichnungVerkleinern1Click(Sender);
    vk_Add     : CmdEx.KeyPressedProc('+', Shift);
    vk_Subtract: CmdEx.KeyPressedProc('-', Shift);
    vk_Multiply: CmdEx.KeyPressedProc('*', Shift);
    vk_Escape  : CmdEx.Break2DragMode;
  else
    Key := 0;
  end; { of case }
  end;


{------- Menü-Befehle ----------------------------------------}

procedure TDynaGeoX.Zuruecksetzen1Click(Sender: TObject);
  var isDrag : Boolean;
  begin
  isDrag := CmdEx.Modus <= cmd_ContextMenu;
  CmdEx.Break2DragMode;
  If isDrag then begin
    LoadDrawing;
    ShowToolbar := Length(CmdEx.GeoListe.CmdString) > 0;
    ExportFileName := '';
    end;
  DrawWin.Invalidate;
  end;


procedure TDynaGeoX.Speichern1Click(Sender: TObject);
  begin
  SaveDialog1.FileName := ExportFileName;
  If SaveDialog1.Execute then begin
    ExportFileName := ChangeFileExt(SaveDialog1.FileName, '.geo');
    GeoXMLFileSave(ExportFileName, CmdEx.GeoListe, Nil,
                   XMLOutputFormat);
    end;
  CmdEx.Reset2DragMode;
  end;


procedure TDynaGeoX.AlleObjekteAnzeigen1Click(Sender: TObject);
  var i : Integer;
  begin
  With CmdEx.GeoListe do
    For i := 0 to LastValidObjIndex do
      If TGeoObj(Items[i]).DataValid then
        TGeoObj(Items[i]).ShowsAlways := True;
  CmdEx.Reset2DragMode;
  end;


procedure TDynaGeoX.Objektlschen1Click(Sender: TObject);
  begin
  CmdEx.Modus := cmd_DelObj;
  end;


procedure TDynaGeoX.MapObjClick(Sender: TObject);
  begin
  If Sender is TMenuItem then begin
    CmdEx.LastMapping := CmdEx.GeoListe.Items[(Sender as TMenuItem).Tag];
    CmdEx.Modus := cmd_MapObj; 
    end
  else
    CmdEx.Reset2DragMode;
  end;


procedure TDynaGeoX.LetzteLschungwiderrufen1Click(Sender: TObject);
  begin
  CmdEx.Reset2DragMode;
  With CmdEx.GeoListe do
    If Count > Succ(LastValidObjIndex) then begin
      RevalidateObject(Items[Succ(LastValidObjIndex)]);
      DrawWin.Invalidate;
      end;
  end;


procedure TDynaGeoX.Zeichnungvergrern1Click(Sender: TObject);
  begin
  CmdEx.Reset2DragMode;
  CmdEx.GeoListe.RescaleDrawing(1.5);
  DrawWin.Invalidate;
  end;


procedure TDynaGeoX.Zeichnungverkleinern1Click(Sender: TObject);
  begin
  CmdEx.Reset2DragMode;
  CmdEx.GeoListe.RescaleDrawing(0.66666);
  DrawWin.Invalidate;
  end;


procedure TDynaGeoX.LogoZeigen1Click(Sender: TObject);
  begin
  CmdEx.Reset2DragMode;
  ShowLogo := Not ShowLogo;
  end;


procedure TDynaGeoX.AboutClick(Sender: TObject);
  begin
  CmdEx.Reset2DragMode;
  AboutBox;
  end;


{-------- Initialisierung -------------------------------------- }



Initialization
  If Application.Handle = 0 then      { Offenbar  }
    Application.CreateHandle;         { unnötig ? }
  TActiveFormFactory.Create(
    ComServer,
    TActiveFormControl,
    TDynaGeoX,
    Class_DynaGeoX,
    1,
    '',
    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
    tmSingle);
    // ThreadingModel = tmSingle statt: tmApartment! Ermöglicht Kontextmenüs
    // im 2. IE-Fenster, selbst unter WinXP, wenn dafür zusätzlich "innen"
    // beim Aufruf von AutoObjectFactory.Create der Parameter Instancing
    // auf ciSingleInstance gesetzt wird !!! 
end.
