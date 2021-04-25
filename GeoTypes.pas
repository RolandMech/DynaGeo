unit GeoTypes;

interface

uses Windows, Classes, SysUtils, StrUtils, Graphics, Forms, StdCtrls,
     Controls, ComCtrls, ExtCtrls, WSDLIntf, Math, Dialogs, Menus,
     MathLib, tbaum, Utility, Declar, GlobVars, RTF2HTMLConv,
     FormatEdit, FormatText, GeoGroup, XMLIntf;

type
  TDirection    = (BackMove, NoMove, ForwardMove, VirtualMove);
  TOutputStatus = (outNone, outScreen, outClipboard, outPreview, outPrinter, outFile, outZoom);

  TGeoObjListe  = class;
  TGTextObj     = class;
  TGName        = class;

  TGeoObj = class(TPersistent)
    protected
      FGeoNum,
      FStatus,
      FGroups            : Integer;
      FMyColour          : TColor;
      FName              : WideString;
      FXMLTypeName       : String;
      FMyPenStyle        : TPenStyle;
      FMyBrushStyle      : TBrushStyle;
      FMyLineWidth,
      FMyShape           : Integer;
      FShowDataInNameObj,
      FShowNameInNameObj : Boolean;
      Old_Data           : TDataStack;

      procedure SetMyColour(NewCol: TColor); virtual;
      function  GetName: WideString; virtual;
      function  GetIsVisible: Boolean; virtual;
      function  GetDataCanShow: Boolean;
      procedure SetDataCanShow(flag: Boolean);
      function  GetDataValid: Boolean; virtual;
      procedure SetDataValid(flag: Boolean); virtual;
      function  GetShowsAlways: Boolean; virtual;
      procedure SetShowsAlways(vis: Boolean); virtual;
      function  GetShowsOnlyNow: Boolean; virtual;
      procedure SetShowsOnlyNow(vis: Boolean); virtual;
      function  GetIsFlagged: Boolean; virtual;
      procedure SetIsFlagged(flag: Boolean); virtual;
      function  GetIsGrouped: Boolean; virtual;
      procedure SetIsGrouped(flag: Boolean); virtual;
      function  GetIsMarked: Boolean; virtual;
      procedure SetIsMarked(flag: Boolean); virtual;
      function  GetIsMakMarked: Boolean; virtual;
      procedure SetIsMakMarked(flag: Boolean); virtual;
      function  GetIsReversed: Boolean;
      procedure SetIsReversed(flag: Boolean);
      function  GetIsBlinking: Boolean; virtual;
      procedure SetIsBlinking(flag: Boolean); virtual;
      function  GetWinPos: TPoint; virtual;
      procedure SetWinPos(newVal: TPoint); virtual;
      procedure SetMyShape(newVal: Integer); virtual;
      procedure SetShowNameInNameObj(newVal: Boolean); virtual;
      procedure SetShowDataInNameObj(newVal: Boolean); virtual;
      procedure CME_PopupClick(Sender : TObject); virtual;

      procedure AdoptAllChildrenOf(OldPa: TGeoObj);
      function  DefaultName: WideString; virtual;
      function  ParentLinksAreOkay : Boolean; virtual;
      function  AllParentsUnFlagged: Boolean; virtual;
      function  AllParentsInList(NameList: TStrings): Boolean;
      function  HasSameDataAs(GO: TGeoObj): Boolean; virtual;
      function  DataEquivalent(var data): Boolean; virtual;
      function  GetImplicitMakStartObj(n: Integer): TGeoObj; virtual;
      function  IsVisibleWithoutGroups: Boolean;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); virtual;
      procedure Rescale; virtual;
      procedure UpdateScreenCoords; virtual; abstract;
      procedure VirtualizeCoords; virtual;
      procedure UpdateNameCoordsIn(TextObj: TGTextObj); virtual;
      procedure SetNewNameParamsIn(TextObj: TGTextObj); virtual;
      procedure AdjustGraphTools(todraw : Boolean); virtual;
      procedure DrawIt; virtual; abstract;
      procedure HideIt; virtual; abstract;
      procedure BlinkIt;
      procedure ExportIt; virtual;
      procedure MarkObjAndAncestors;
      procedure Register4Dragging(DragList: TObjPtrList); virtual;
      procedure DragIt; virtual;
      procedure Invalidate; virtual;
      procedure Revalidate; virtual;

    public
      ObjList    : TGeoObjListe;
      Parent     : TObjPtrList;
      Children   : TObjPtrList;
      scrx, scry : Integer;
      X, Y,
      LastDist   : Double;
      flag       : Boolean;

      constructor Create(iObjList: TGeoObjListe; iis_visible : Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); virtual;
      constructor CreateFromBlueprint(iObjList: TGeoObjListe; MakNum, CmdNum: Integer); virtual;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); virtual;
      constructor CreateProtoTypFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); virtual;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); virtual;
      destructor  Destroy; override;
      destructor  FreeBluePrint; virtual;
      function    CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; virtual;
      function    CreateProtoTypNode(DOMDoc: IXMLDocument): IXMLNode; virtual;
      function    CreateI2GElementNode(DOMDoc: IXMLDocument): IXMLNode; virtual;
      function    CreateI2GConstraintNode(DOMDoc: IXMLDocument; ObjNames: TStrings): IXMLNode; virtual;
      procedure   RebuildPointers; virtual;
      procedure   GetDataFromOldMappedObj(OMO: TGeoObj); virtual;
      procedure   AfterLoading(FromXML: Boolean = True); virtual;
      procedure   UpdateParams; virtual; abstract;
      procedure   UpdateV1xObjects; virtual;
      procedure   UpdateOldPrototype; virtual;
      class function IsPriorTo(CompType: TClass): Boolean; virtual;
      function  IsDynamicLocLineControl: Boolean; virtual;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; virtual;
      function  IsNearMouse: Boolean; virtual; abstract;

      procedure BecomesChildOf(GO: TGeoObj); virtual;
      procedure Stops2BeChildOf(GO: TGeoObj); virtual;
      procedure SaveState; virtual;
      procedure RestoreState; virtual;
      procedure RegisterAsMacroStartObject; virtual;
      procedure SetAsStartObject4MacroRun(MakNum, CmdNum: Integer); virtual;
      procedure AddToGroup(GroupMask: Integer); virtual;
      procedure RevokeFromGroup(GroupMask: Integer);
      procedure SetGraphTools(LineStyleNum, PointStyleNum,
                              FillStyleNum: Integer; iColor: TColor); virtual;
      procedure GetGraphTools(var LineStyleNum, PointStyleNum,
                                  FillStyleNum: Integer; var iColor: TColor); virtual;
      procedure Redraw; overload;
      procedure Redraw(Adj: Boolean); overload;
      procedure InitBlinking(OBE: Boolean);

      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); virtual; abstract;

      function  Dist (xm, ym: Double): Double; virtual; abstract;
      function  HasNameObj(var NameObj: TGName): Boolean;
      function  GetUniqueName(s: WideString): WideString;
      function  GetFormattedName: String; virtual;
      function  GetValue(selector: Integer): Double; virtual;
      function  GetMatchingCursor(mpt: TPoint): TCursor; virtual;
      function  IsAncestorOf(GO: TGeoObj): Boolean; virtual;
      procedure InsertNameOf(GO: TGeoObj; var Target: String); overload;
      procedure InsertNameOf(GO: TGeoObj; var Target: WideString); overload;

      procedure InsertMeasureInto(Target: TFormatEdit); virtual;
      procedure PatchName(NewName: WideString);
      procedure SetNewName(NewName: WideString); virtual;
      procedure RebuildTermStrings; virtual;
      function  HasBuggyTerm: Boolean; virtual;
      function  GetDataStr: String; virtual;
      function  GetInfo: String; virtual; abstract;

      property GeoNum: Integer read FGeoNum;
      property XMLTypeName: String read FXMLTypeName;
      property IsVisible: Boolean read GetIsVisible;
      property DataCanShow: Boolean read GetDataCanShow write SetDataCanShow;
      property DataValid: Boolean read GetDataValid write SetDataValid;
      property Status: Integer read FStatus;
      property MyColour: TColor read FMyColour write SetMyColour;
      property MyPenStyle: TPenStyle read FMyPenStyle write FMyPenStyle;
      property MyBrushStyle: TBrushStyle read FMyBrushStyle write FMyBrushStyle;
      property MyLineWidth: Integer read FMyLineWidth write FMyLineWidth;
      property MyShape: Integer read FMyShape write SetMyShape;
      property Name: WideString read GetName;
      property ShowsAlways: Boolean read GetShowsAlways write SetShowsAlways;
      property ShowsOnlyNow: Boolean read GetShowsOnlyNow write SetShowsOnlyNow;
      property IsFlagged: Boolean read GetIsFlagged write SetIsFlagged;
      property IsMarked: Boolean read GetIsMarked write SetIsMarked;
      property IsMakMarked: Boolean read GetIsMakMarked write SetIsMakMarked;
      property IsReversed: Boolean read GetIsReversed write SetIsReversed;
      property IsBlinking: Boolean read GetIsBlinking write SetIsBlinking;
      property IsGrouped: Boolean read GetIsGrouped write SetIsGrouped;
      property WinPos: TPoint read GetWinPos;
      property ShowDataInNameObj: Boolean read FShowDataInNameObj write SetShowDataInNameObj;
      property ShowNameInNameObj: Boolean read FShowNameInNameObj write SetShowNameInNameObj;
      property Groups: Integer read FGroups;
    end;

  TGeoObjClass = class of TGeoObj;
  TGParentObj  = class;
  TGPoint      = class;
  TGNumberObj  = class;
  TGLogSlider  = class;

  TGeoObjListe = class (TList)
    protected
    { Felder für Properties : }
      Fe1x, Fe1y,                    { Einheits-Vektoren in                 }
      Fe2x, Fe2y,                    {   Windows-Pixel-Koordinaten          }
      FPixDist,                      { Pixelrastermaß in Weltkoordinaten    }
      FxMin, FxMax,
      FyMin, FyMax,
      FxLWC, FyLWC,                  { "L"ogical "W"indows "C"enter         }
      FLWrad          : Double;      { "L"ogical "W"orld "rad"ius           }
      FTargetCanvas   : TCanvas;     { Ausgabe-Canvas (wg. IsDoubleBuffered)}
      FAnimationSource: TGParentObj; { Steuerobjekt für Animationen         }
      FDoubleBuffer   : TBitmap;     { Interne Bitmap für Flackerfreiheit   }
      FWindowRect     : TRect;
      FNextGeoNum     : Integer;
      FMouseGoes      : TDirection;
      FIsLoading,
      FDoubleBuffered : Boolean;
      FWindowOrigin   : TPoint;
      FLastMousePos   : TPoint;
      FLastMouseMove  : TPoint;
      FOutPutStatus   : TOutputStatus;
      FActCanvas      : TCanvas;
      FLogo           : TImage;
      FNewLLStatus    : Integer;
      FValidationStr  : String;

    { Weitere interne Variablen, nicht in Properties verpackt :              }

      LogLastMouse_X,                 { Letzte Mausposition                  }
      LogLastMouse_Y,                 {   und                                }
      LogLastMouse_dx,                { letzte Mausbewegung                  }
      LogLastMouse_dy,                {   in logischen Koordinaten           }
      LastQJumpX,                     { Für das Verziehen von Flächen, die   }
      LastQJumpY,                     {   "rastende" Randpunkte haben        }
      yAspect,                        { = Abs( e2y / e1x )                   }
      FFontScale,
      FScale          : Double;       { Faktor ppcm_actCanvas/ppcm_scrCanvas }
      LastGroupVisMask: Integer;      { Letzte verarbeitete Gr-Sichtbarkeit  }
      NameNumList     : TNameNumList; { Datenbank für Standard-Namen         }
      QFA             : T2DimFloatArray; { Puffer für Punkt-Positions-Daten  }
                                         { bei der Korrektheits-Überprüfung  }
      function  GetAniCtrlObjCount: Integer;
      function  GetAniPossible: Boolean;
      function  GetCheckControl: TGeoObj;
      function  GetNewFontScaleFactor: Double;
      function  CalculateNextFreeGeoNum: Integer;
      function  DynaGeoJKnows(Class_TypeName: String): Boolean;
      procedure RebuildAllPointers;
      procedure ActualizeWindowsConstants;
      procedure SetWindowRect(newRect: TRect);
      procedure SetWindowOrigin(newOri: TPoint);
      procedure SetLastMousePos(newPos: TPoint);
      procedure SetAnimationSrc(newAS: TGParentObj);
      procedure SetDoubleBuffered(db: Boolean);
      procedure SetIsLoading(newVal: Boolean);
      procedure SetOutputStatus(nos: TOutputStatus);
      procedure SetNewLLStatus(nv: Integer);
      procedure PatchLocLineParents(old, new: TGeoObj);
      procedure CheckFriendlyLinksOf(Num: Integer);
      procedure UpdObjAndAllDescOf(pGO : TGeoObj);
      procedure FillOutputList(LVOI: Integer; OL: TList);

    public
      DragStrategy,
      LastValidObjIndex,
      OldAngleTermCount : Integer;
      UpdatingLocLine   : TGeoObj;
      IsBlinkOn,
      StoreWithBMPs,
      AnimationRunning  : Boolean;
      dragged_by_mouse  : TGeoObj;     { Das aktuell gezogene Objekt  }
      DragList          : TObjPtrList;        { statt TList }
      GroupList         : TGeoGroupList;      { statt TList }
      MakroList         : TList;  { eigentlich: TMakroList! }
      BackgroundColor   : TColor;
      StartFont         : TFont;
      HostWinHandle     : HWnd;
      LengthUnit,
      AreaUnit,
      AngleUnit,
      CmdString         : String;      { Befehls-String für DynaGeoX  }
      CRNr              : Integer;     { Copyright-Nummer             }
      CRText            : TStringList; { Copyright-Text               }
      IsDirty,
      ShowingCRText     : Boolean;     { Flag für CR-Text-Anzeige     }
      CreationProg,
      CreationVers,
      CreationDate,
      LastEditProg,
      LastEditVers,
      LastEditDate,
      OldValidationCondition,
      OldValidationVars,
      OldValidationHint,
      LinkForward,                     { Links zu anderen Zeichnungen; stets }
      LinkBack          : String;      {    als relative Pfade formulieren ! }

      constructor Create(iHostWinHandle: HWnd; iDrawCanvas: TCanvas; iRect: TRect);
      constructor Load(S: TFileStream; iHostWinHandle: HWnd; iDrawCanvas: TCanvas; iRect: TRect);
      constructor Load32(R: TReader; iHostWinHandle: HWnd; iDrawCanvas: TCanvas; iTempEdit: TFormatEdit; iRect: TRect);
      destructor  Destroy; override;
      procedure TakeCanvasFrom(source: TGeoObjListe);
      procedure AfterLoading(FromXML : Boolean = True);
      constructor CreateFromI2GData(DOMTree: IXMLNode; oldDrawing: TGeoObjListe);
      constructor CreateFromGeoDomData(DOMTree: IXMLNode; oldDrawing: TGeoObjListe; var ValTabData: TValTabData);
      function  CreateHeaderNode(DOMDoc: IXMLDocument): IXMLNode;
      function  CreateWindowNode(DOMDoc: IXMLDocument;
                                 ValTabData: TValTabData): IXMLNode;
      function  CreateObjListNode(DOMDoc: IXMLDocument;
                                  Check4JExp: Boolean): IXMLNode;
      function  Get_XMLTypeName(Class_TypeName: String): String;
      function  Get_ClassName(XML_TypeName: String; var IsDeprecated: Boolean): String;
      function  GetDefAngleMode: AngleModeTyp;
      function  IsOldDegRadProblemVersion: Boolean;

      procedure InitCoordSys(ixs0, iys0: Integer; iNewWinRect: TRect; iType: Integer; iis_visible: Boolean);
      procedure RescaleCoordSys(ppcmX, ppcmY: Double);
      procedure InitAngle1Screen;
      function  LinksOkay: Boolean;
      function  GetObj(Num : Integer): TGeoObj;
      function  GetValidObj(Num : Integer): TGeoObj;
      function  GetGeoObjByName(s: WideString): TGeoObj;
      function  GetGeoObjNumByName(s: WideString): Integer;
      function  GetLogSlider: TGLogSlider;
      function  GetNextGeoNum: Integer;  { Datenquelle für die Eigenschaft TGeoObj.GeoNum ! }
      function  GetUniqueName(s: WideString): WideString;
      function  ExistObject(GO: TGeoObj; var FoundObj: TGeoObj): Boolean;
      function  GetFreePlace4NewNumber: TPoint;
      function  GetFixLineLength (P1num, P2num : TGeoObj): Double;
      function  CountWinObjsOutside(WinRect, ScrRect: TRect): Integer;
      function  CoSysInVisGroup: Boolean;
      function  CoSysVisible: Boolean;
      procedure MoveWinObjsInside(TargetR: TRect);
      procedure Move2UpperLeft(R: TRect);
      procedure GetFreeFillPattern (var col: TColor; var FillStyle: TBrushStyle);
      function  HiddenObjCount: Integer;
      function  NameAlreadyUsed(suggest: String; obj2name: TGeoObj): Boolean;
      function  HasSetsquare(var SQO: TGeoObj): Boolean;
      function  HasEmptyBorders: Boolean;
      procedure MakeHiddenObjectsTempVisible;
      function  HideHiddenObjects: Integer;
      function  MarkedObjCount: Integer;
      function  GroupedObjCount: Integer;
      procedure EraseGroupMarks;
      procedure EraseMakMarks;
      procedure EraseFlags;
      procedure InvalidateObject(GO: TGeoObj);
      procedure RevalidateObject(GO: TGeoObj);
      function  InsertObject(Item: TGeoObj; var err_num: Integer; ins_pos: Integer = -1): TGeoObj;
      procedure SortObjects;
      procedure FreeObject(GO: TGeoObj);
      procedure DeleteCorrectnessCheck;
      function  CollectBuggyTermObjs: String;
      procedure KillBuggyTermObjs;
      procedure KillLocLineDoubles;
      function  KillUnknownObjects : Integer;
      procedure KillInvalidObjects;
      procedure KillAllObjects;
      procedure ConvertCoord2BasePt(GO: TGeoObj);
      procedure ConvertBase2CoordPt(GO: TGeoObj);
      procedure VirtualizeCoords;
      procedure FillDragList(DrObj: TGeoObj);
      procedure ResetDragList(Unflag: Boolean = True);
      procedure ResetAllMarks;
      procedure LockAllImages;
      procedure SimInit;
      procedure SimDrag(ShowSim: Boolean; SimMode: Integer = 0);
      procedure SimClose;
      function  Animate(Mode: Integer): Integer;
      function  LogWinContains(x, y: Double): Boolean;
      function  LogWinKnows(x, y: Double): Integer;
      function  GetMaxCurveLength: Double;
      procedure GetWinCoords(x, y: Double; var wx, wy: Integer);
      procedure GetFWinCoords(x, y: Double; var wx, wy: Double);
      procedure GetLogCoords(x, y: Integer; var lx, ly: Double);
      procedure GetLogWinHorizonEq(var hc: TCoeff6);
      procedure DragObjects(wx, wy: Integer; rotate: Boolean);
      procedure DrawFirstObjects(Last2Draw: Integer; ClearBack: Boolean = False);
      procedure DrawTempText(sl: TStringList; fsize, posx, posy: Integer);
      procedure Repaint;
      procedure Export_To(OutCanvas: TCanvas; ClipRect: TRect; ScaleF: Double);
      procedure ExportScaled_To(OutCanvas: TCanvas; ops: TOutputStatus;
                                x1, y1, x2, y2, scale, aspect: Double);
      procedure ExportZoomed_To(OutCanvas: TCanvas;
                                x1, y1, x2, y2, scale: Double);
      procedure Copy2Bitmap(TargetBMP: TBitmap; UpperLeft: TPoint);
      procedure AutoUpdateLocLines;
      procedure UpdateAllDescendentsOf (GO: TGeoObj);
      procedure UpdateAllLongLines;
      procedure UpdateAllObjects;
      procedure UpdateGroupVisibility;
      procedure RebuildTermStrings;
      procedure Slide(dxm, dym : Integer);
      procedure InitScale(new_ppcmx, new_ppcmy : Double; newOri: TPoint; newRect: TRect);
      procedure RescaleDrawing(k : Double);
      procedure StartBaseObjBlinking(OBE: Boolean);
      procedure ToggleBlinkingObjs;
      procedure EndBlinkingMode;
      procedure CME_PopupClick(Sender : TObject);
      {
      procedure InitMagnGlass(iCenterPt: TGPoint; iRatio: TGNumberObj);
      procedure KillMagnGlass;
      function  HasMagnGlass(): Boolean;
      }
      function  CheckSolution(TargetObj: Array of TGeoObj): Integer;
      function  CanExport2DynaGeoJ(var ExceptList: TList): Boolean;

      property  WindowRect: TRect read FWindowRect write SetWindowRect;
      property  WindowOrigin: TPoint read FWindowOrigin write SetWindowOrigin;
      property  e1x: Double read fe1x;       { Einheitsvektoren in     }
      property  e1y: Double read fe1y;       {   Fensterkoordinaten    }
      property  e2x: Double read fe2x;
      property  e2y: Double read fe2y;
      property  xMin: Double read FxMin;     { Fenstergrenzen in       }
      property  xMax: Double read FxMax;     {   logischen Koordinaten }
      property  yMin: Double read FyMin;
      property  yMax: Double read FyMax;
      property  xCenter: Double read FxLWC;  { Fenstermitte in         }
      property  yCenter: Double read FyLWC;  {   logischen Koordinaten }
      property  PixelDist: Double read FPixDist;  { PixelRastermaß     }
      property  LogWinRadius: Double read FLWrad;
                             { Logischer Radius des kleinsten Kreises, }
                             { der das Fenster vollständig enthält     }
      property  LastMousePos: TPoint read FLastMousePos write SetLastMousePos;
                             { Letzte Mausposition in Fensterkoordinaten;    }
                             { beim Schreiben werden auch die logische Maus- }
                             { position sowie LastMouseMove und MouseGoes    }
                             { aktualisiert                                  }
      property  LastMouseMove: TPoint read FLastMouseMove;
      property  LastLogMouseX: Double read LogLastMouse_X;
      property  LastLogMouseY: Double read LogLastMouse_Y;
      property  LastLogMouseDX: Double read LogLastMouse_dx;
      property  LastLogMouseDY: Double read LogLastMouse_dy;
      property  MouseGoes: TDirection read FMouseGoes write FMouseGoes;
      property  DraggedObj: TGeoObj read dragged_by_mouse write dragged_by_mouse;
      property  AnimationPossible: Boolean read GetAniPossible;
      property  AnimationCtrlObjCount: Integer read GetAniCtrlObjCount;
      property  AnimationSource: TGParentObj read FAnimationSource write SetAnimationSrc;
      property  TargetCanvas: TCanvas read FTargetCanvas;
      property  IsDoubleBuffered: Boolean read FDoubleBuffered write SetDoubleBuffered;
      property  IsLoading: Boolean read FIsLoading write SetIsLoading;
      property  ScaleFactor: Double read FScale;
      property  FontScaleFactor: Double read FFontScale;
      property  OutputStatus: TOutputStatus read FOutPutStatus write SetOutPutStatus;
      property  NewLocLineStatus: Integer read FNewLLStatus write SetNewLLStatus;
      property  ActCanvas: TCanvas read FActCanvas;
      property  DoubleBuffered: Boolean read FDoubleBuffered write SetDoubleBuffered;
      property  DoubleBuffer: TBitmap read FDoubleBuffer;
      property  LogoPic: TImage read FLogo write FLogo;
      property  CheckControl: TGeoObj read GetCheckControl;
    end;

  TGLine = class;
  TGStraightLine = class;

  TGParentObj = class(TGeoObj)
    protected
      FAniStep    : Double;
      FBoundParam : Double;  { Ort eines gebundenen Punktes auf der Trägerlinie }
      function  Boxed(v: Double): Double;
      function  GetAniMinValue: Double; virtual;
      function  GetAniMaxValue: Double; virtual;
      function  GetAniValue: Double; virtual;
      procedure SetAniValue(nav: Double); virtual;
      function  GetWinPosNextTo(_X, _Y: Double): TPoint; virtual;
    public
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  IsLineBound(var TL: TGLine): Boolean; virtual;
      function  CanControlAnimation: Boolean; virtual;
      function  AniCtrlObjName: String; virtual;
      procedure AdoptChildrenOf(GO: TGeoObj);
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      procedure ResetOLCPList(PointList : TVector3List); virtual;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; virtual;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; virtual;
      function  GetRandomParam: Double; virtual;
      function  SetLinePosition(tv: Double): Boolean; virtual;
      procedure SetAniParams(vmin, vact, vmax, vstep: Double); virtual;
      procedure ChangeAniSpeed(sf: Double);
      property  BoundParam: Double read FBoundParam write FBoundParam;
      property  AniStep: Double read FAniStep;
      property  AniValue: Double read GetAniValue write SetAniValue;
      property  AniMaxValue: Double read GetAniMaxValue;
      property  AniMinValue: Double read GetAniMinValue;
    end;

  TGNumber = class(TGParentObj)
    protected
      NumWidth,
      NumHeight : Integer;
      FShowName : Boolean;
      ValRect,
      ObjRect   : TRect;
      procedure VirtualizeCoords; override;
      procedure Rescale; override;
      procedure SetShowName(newval : Boolean);
      procedure SetMyShape(newVal: Integer); override;
      procedure AdjustGraphTools(todraw : Boolean); override;
      procedure ShowCentered(Canvas: TCanvas; v: Double; R: TRect; prec: Integer; Prefix: String = ''); overload;
      procedure ShowCentered(Canvas: TCanvas; valStr: WideString; R: TRect); overload;
    public
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  IsNearMouse: Boolean; override;
      procedure ReDimData; virtual;
      procedure SetNewName(NewName: WideString); override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      procedure InsertMeasureInto(Target: TFormatEdit); override;
      property ShowName: Boolean read FShowName write SetShowName;
    end;

  TGNumberObj = class(TGNumber)
    protected
      valpx,
      valpxmin,
      valpxmax,
      valpy    : Integer;
      FValMin,
      FValue,
      FValMax,
      FQuant   : Double;
      MinRect,
      MaxRect,
      BarRect  : TRect;
      function  DefaultName: WideString; override;
      function  GetAniMinValue: Double; override;
      function  GetAniMaxValue: Double; override;
      function  GetAniValue: Double; override;
      procedure SetAniValue(nav: Double); override;
      procedure SetValue(newValue: Double); virtual;
      procedure Invalidate; override;
      procedure DrawArrowsInto(R: TRect);
      procedure DrawIt; override;
      procedure HideIt; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure SetPositionFromValue; virtual;
      procedure UpdateScreenCoords; override;
    public
      constructor Create(iObjList: TGeoObjListe; iWidth: Integer; iValMin, iValue, iValMax: Double; iis_visible: Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  CreateProtoTypNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      function  GetMatchingCursor(mpt: TPoint): TCursor; override;
      function  Dist (xm, ym: Double): Double; override;
      function  GetValue(selector: Integer): Double; override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  IsDynamicLocLineControl: Boolean; override;
      function  IsLineBound(var TL: TGLine): Boolean; override;
      function  CanControlAnimation: Boolean; override;
      function  AdjustBorders: Boolean;
      function  AdjustValue: Boolean;
      procedure ResetOLCPList(PointList : TVector3List); override;
      procedure UpdateParams; override;
      procedure SaveState; override;
      procedure RestoreState; override;
      function  SetLinePosition(tv: Double): Boolean; override;
      procedure SetAllValues(vmin, vact, vmax, vquant: Double); virtual;
      procedure SetAniParams(vmin, vact, vmax, vstep: Double); override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  GetInfo: String; override;
      property Value: Double read FValue write SetValue;
      property MinValue: Double read FValMin;
      property MaxValue: Double read FValMax;
    end;

  TGLogSlider = class(TGNumberObj)
    protected
      nq : Integer;
      procedure SetValue(newValue: Double); override;
      procedure SetPositionFromValue; override;
      // procedure UpdateScreenCoords; override;
      procedure ExportIt; override;
    public
      {
      constructor Create(iObjList: TGeoObjListe; iWidth: Integer; iValMin, iValue, iValMax: Double; iis_visible: Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      }
      procedure SetAllValues(vmin, vact, vmax, vquant: Double); override;
      function  CanControlAnimation: Boolean; override;
      procedure UpdateParams; override;
    end;

  TGTermObj = class(TGNumber)
    protected
      CommentRect  : TRect;
      MinimalWidth : Integer;
      CommentOutStr,
      FComment     : String;
      FTerm        : TTBaum;
      FValue       : Double;
      FShowTerm    : Boolean;
      FOutFormat   : Integer;  // 0: normal;  1: Gradmaß;  2: Vielfaches von Pi
      function  DefaultName: WideString; override;
      function  GetDeciDigits: Integer;
      function  GetIsVisible: Boolean; override;
      procedure SetDeciDigits(newVal: Integer);
      procedure SetComment(newCStr: String);
      procedure SetShowTerm(newVal: Boolean);
      procedure UpdateScreenCoords; override;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure Invalidate; override;
      procedure Revalidate; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iTermStr, iCommentStr: WideString;
                         iShowTerm, iis_visible: Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      destructor Destroy; override;
      destructor FreeBluePrint; override;
      procedure AfterLoading(FromXML: Boolean = True); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  GetMatchingCursor(mpt: TPoint): TCursor; override;
      function  Dist (xm, ym: Double): Double; override;
      function  IsEstimated: Boolean;
      function  GetValue(selector: Integer): Double; override;
      function  GetValueStr: WideString;
      function  GetTermString: WideString;
      function  GetHTMLString: String;
      procedure SetNewTerm(ts: WideString);
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      procedure ReDimData; override;
      procedure RebuildTermStrings; override;
      function  HasBuggyTerm: Boolean; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  GetInfo: String; override;
      property Value: Double read FValue;
      property Comment: String read FComment write SetComment;
      property DeciDigits: Integer read GetDeciDigits write SetDeciDigits;
      property OutFormat: Integer read FOutFormat write FOutFormat;
      property ShowTerm: Boolean read FShowTerm write SetShowTerm;
    end;

  TGPoint = class(TGParentObj)
    protected
      FQuant,            { Quantisierungsschrittweite     }
      Last_dx,           { enthält den beim letzten Drag- }
      Last_dy : Double;  {   Vorgang zurückgelegten Weg   }
      function  DefaultName: WideString; override;
      function  GetAniMinValue: Double; override;
      function  GetAniMaxValue: Double; override;
      function  GetAniValue: Double; override;
      procedure SetAniValue(nav: Double); override;
      function  GetIsWaiting: Boolean;
      procedure SetIsWaiting(flag: Boolean);
      procedure SetIsFlagged(flag: Boolean); override;
      function  TakeOtherPoint(x1, y1, x2, y2 : Double; FP: TGPoint): Boolean;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      function  IsParentOfCurve: Boolean;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure VirtualizeCoords; override;
      procedure ExportIt; override;
      procedure SetQuant(newVal: Double);
      procedure AdjustGraphTools(todraw: Boolean); override;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure Register4Dragging(DragList: TObjPtrList); override;
    public
      friends    : TObjPtrList;
      constructor Create(iObjList: TGeoObjListe; iX, iY: Double; iis_visible : Boolean);
      constructor CreateAsLatticePt(iObjList: TGeoObjListe; iX, iY: Double; iis_visible : Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor ConvertFromCoordPt(CPt: TGPoint);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      destructor  Destroy; override;
      destructor  FreeBluePrint; override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  CreateI2GElementNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  CreateI2GConstraintNode(DOMDoc: IXMLDocument; ObjNames: TStrings): IXMLNode; override;
      procedure RebuildPointers; override;
      procedure AfterLoading(FromXML: Boolean); override;
      procedure UpdateV1xObjects; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  IsDynamicLocLineControl: Boolean; override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  CanControlAnimation: Boolean; override;
      function  AniCtrlObjName: String; override;
      function  Dist (xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      procedure BecomesChildOf(GO: TGeoObj); override;
      function  IsFriendOf(GO: TGeoObj): Boolean;
      function  IsInLoopOfCLSegments: Boolean;
      function  IsEndOfFixLine: Boolean;
      function  IsIncidentWith(line: TGLine): Boolean; virtual;
      procedure StartFriendshipWith(GO: TGeoObj);
      procedure EndFriendshipWith(GO: TGeoObj);
      procedure CheckChildLinesCBDI;
      procedure CheckFriendlyLinks;
      procedure RejectTemporaryParents;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure RestorePointParams(ppX,  ppY : Double; ppStatus: Integer;
                                   ppdx, ppdy: Double);
      procedure UpdateParams; override;
      procedure UpdateScreenCoords; override;
      procedure SetNewCoords(x_str, y_str: WideString); virtual;
      function  SetLinePosition(tv: Double): Boolean; override;
      function  IsLineBound(var TL: TGLine): Boolean; override;
      function  IsAngleVertex(var ao: TGeoObj) : Boolean;
      function  GetMatchingCursor(mpt: TPoint): TCursor; override;
      procedure DragMove(dx, dy: Double);
      procedure DragRotate(delta, xm, ym: Double);
      procedure SetAniParams(vmin, vact, vmax, vstep: Double); override;
      procedure SetGraphTools(LineStyleNum, PointStyleNum,
                              FillStyleNum: Integer; iColor: TColor); override;
      procedure GetGraphTools(var LineStyleNum, PointStyleNum,
                                  FillStyleNum: Integer; var iColor: TColor); override;
      function  GetDataStr: String; override;
      function  GetInfo: String; override;
      property  Quant: Double read FQuant write SetQuant;
      property  IsWaiting: Boolean read GetIsWaiting write SetIsWaiting;
      property  Lastdx: Double read Last_dx;
      property  Lastdy: Double read Last_dy;
    end;

  TGCoordPt = class(TGPoint)  // veraltet !!!
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
    public
      constructor Create(iObjList: TGeoObjListe; iXc, iYc: Double; iis_visible : Boolean);
      constructor ConvertFromBasePt(BPt: TGPoint);
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      procedure Clip2Grid;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGXPoint = class(TGPoint)
    protected
      function  DataEquivalent(var data):Boolean; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
    public
      XTerm,
      YTerm     : TTBaum;
      constructor Create(iObjList: TGeoObjListe; iXTerm, iYTerm: WideString; iis_visible : Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor ConvertFromBasePt(BPt: TGPoint);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor CreateProtoTypFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      destructor  Destroy; override;
      destructor  FreeBluePrint; override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  CreateProtoTypNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  IsLineBound(var TL: TGLine): Boolean; override;
      function  IsIncidentWith(line: TGLine): Boolean; override;
      procedure AfterLoading(FromXML: Boolean); override;
      procedure UpdateOldPrototype; override;
      procedure Clip2Grid;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      procedure SetNewCoords(x_str, y_str: WideString); override;
      procedure UpdateParams; override;
      procedure RebuildTermStrings; override;
      function  HasBuggyTerm: Boolean; override;
      function  GetInfo: String; override;
    end;

  TGMiddlePt = class(TGPoint)
    public
      constructor Create(iObjList: TGeoObjListe; iP1, iP2: TGeoObj; iis_visible : Boolean);
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGMappedPoint = class(TGPoint)
    protected
      function HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iOriPt, iMapObj: TGeoObj; iis_visible: Boolean);
      procedure GetDataFromOldMappedObj(OMO: TGeoObj); override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGMirrorPt = class(TGPoint)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iP1, iSyZ: TGeoObj; iis_visible : Boolean);
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGMovedPt = class(TGPoint)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iP1, iP2: TGeoObj; iis_visible : Boolean);
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGRotatedPt = class(TGPoint)
    protected
      RotAngle : Double;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iUBP, iMP, iAO: TGeoObj; iis_visible : Boolean);
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGStretchedPt = class(TGPoint)
    protected
      SFactor  : Double;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iUBP, iZP, iSF: TGeoObj; iis_visible : Boolean);
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGDoublePt = class(TGPoint)  // veraltet !!!
    protected
      X_2, Y_2,
      tv1, tv2  : Double;
      scrx_2, scry_2: Integer;
      Status2   : Word;
      function  AllParentsUnFlagged: Boolean; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure VirtualizeCoords; override;
    public
      constructor Create(iObjList: TGeoObjListe; iS1, iS2: TGeoObj; iis_visible : Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  IsIncidentWith(line: TGLine): Boolean; override;
      procedure CheckParent3;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      procedure UpdateScreenCoords; override;
      function  GetInfo: String; override;
    end;

  TGSecondPt = class(TGPoint)  // veraltet !!!
    public
      constructor Create(iObjList: TGeoObjListe; iFirstPt: TGeoObj; iis_visible : Boolean);
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  IsIncidentWith(line: TGLine): Boolean; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGIntersectPt = class(TGSecondPt)
    protected
      function  ParentLinksAreOkay : Boolean; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      PtIndex  : Integer;
      Age      : Double;
      constructor Create(iObjList: TGeoObjListe; iIntersection: TGeoObj;
                         iPtIndex: Integer; iis_visible : Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateFromBlueprint(iObjList: TGeoObjListe; MakNum, CmdNum: Integer); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  IsIncidentWith(line: TGLine): Boolean; override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  GetDisplacement(Pt: TFloatPoint): Double;
      procedure PatchDataFrom(OPt: TGPoint);
      procedure UpdateParams; override;
      procedure SetNameTo(s: String);
      function  GetInfo: String; override;
    end;

  TGLxLPt = class(TGPoint)
    public
      constructor Create(iObjList: TGeoObjListe; iG1, iG2: TGeoObj; iis_visible : Boolean);
      function  CreateI2GConstraintNode(DOMDoc: IXMLDocument; ObjNames: TStrings): IXMLNode; override;
      function  IsIncidentWith(line: TGLine): Boolean; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGPol = class(TGPoint)
    public
      constructor Create(iObjList: TGeoObjListe; iSL, iC: TGeoObj; iis_visible : Boolean);
      function  IsIncidentWith(line: TGLine): Boolean; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGVertexPt = class(TGPoint)
    private
      FPtIndex : Integer;
    public
      constructor Create(iObjList: TGeoObjListe; iPoly: TGeoObj; n : Integer; iis_visible : Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  IsIncidentWith(line: TGLine): Boolean; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure UpdateParams; override;
      procedure UpdateScreenCoords; override;
      function  GetInfo: String; override;
    end;

  TGOrigin = class (TGPoint)
    protected
      BackBMP   : TBitmap;
      BackRect  : TRect;
      BackX1, BackY1,
      BackX2, BackY2,
      dsx, dsy  : Double;
      FCSType,             { Typ des Koord.-Systems :
                                < 0 : kein Koordinatensystem anzeigen
                                  0 : Ursprung und Achsen
                                  1 : Ursprung, Achsen und enges Gitter
                                  2 : Ursprung, Achsen und mittleres Gitter
                                  5 : Ursprung, Achsen und weites Gitter     }
      FGridType : Integer; { Art der Gitter-Darstellung :
                                  0 : kleine Kreuzl
                                  1 : durchgezogene Gitterlinien
                                  2 : punktierte Gitterlinien                }
      function  GetAxisNoNumbers: Boolean;
      procedure SetAxisNoNumbers(newVal: Boolean);
      procedure SetGridType(newVal: Integer);
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure AdjustGraphTools(todraw: Boolean); override;
      procedure ReAdjustGraphTools;
      procedure DrawGrid;
      procedure DrawIt; override;
      procedure HideIt; override;
    public
      constructor Create (iObjList: TGeoObjListe; iX, iY: Double; iCSType: Integer; iis_visible: Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load (S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      destructor  Destroy; override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure AfterLoading(FromXML : Boolean = True); override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  GetMatchingCursor(mpt: TPoint): TCursor; override;
      function  ShowAxis: Boolean;
      procedure ExportBackPic2GeoList;
      procedure UpdateParams; override;
      procedure UpdateScreenCoords; override;
      procedure RegisterAsMacroStartObject; override;
      function  GetInfo: String; override;
      property  AxisNoNumbers: Boolean read GetAxisNoNumbers write SetAxisNoNumbers;
      property  CSType: Integer read FCSType write FCSType;
      property  GridType: Integer read FGridType write SetGridType;
    end;

  TGaugePoint = class (TGPoint)
    protected
      Art : Integer;     { 1 : Eichpunkt auf der x-Achse;
                           2 : Eichpunkt auf der y-Achse  }
      procedure SetIsMarked(flag: Boolean); override;
      procedure DrawIt; override;
      procedure HideIt; override;
    public
      constructor Create (iObjList: TGeoObjListe; Ori, Ax: TGeoObj; iis_visible: Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGArea = class;

  TGLine = class(TGParentObj)
    protected
      sx1, sy1,
      sx2, sy2: Integer;
      F_CCTP,              // "CanCarryTangentPoints"
      F_CBDI  : Boolean;   // "Can Be dragged indirectly"
      function  GetFillHandle(Ori: Boolean): HRgn; virtual;
      function  AllAncestorsAreFreePoints(PList: TObjPtrList = Nil): Boolean; virtual;
      procedure MovePointsOff(var rP1, rP2: TFloatPoint);
      procedure AdjustGraphTools(todraw : Boolean); override;
      procedure VirtualizeCoords; override;
    public
      X1, Y1,
      X2, Y2 : Double;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  IsClosedLine: Boolean; virtual;
      function  Includes(xp, yp: Double): Boolean; virtual;
      function  GetTangentIn(bx, by: Double; var tanCoeff: TVector3): Boolean; virtual;
      function  GetPolOf(polare: TVector3; var px, py: Double): Boolean; virtual;
      function  GetPolareOf(bx, by: Double; var polCoeff: TVector3): Boolean; virtual;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; virtual;
      function  IsFilled(var FO: TGArea): Boolean; virtual;
      function  GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean; virtual; abstract;
      function  GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean; virtual; abstract;
      procedure GetDataVector(var v: TVector3); virtual; abstract;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure Set_CBDI;
      procedure GetGraphTools(var LineStyleNum, PointStyleNum,
                                  FillStyleNum: Integer; var iColor: TColor); override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      property  CanBeDraggedIndirectly: Boolean read F_CBDI;
      property  CanCarryTangentPoints: Boolean read F_CCTP;
    end;

  TGStraightLine = class (TGLine)
    protected
      FHesseEq : TVector3;  // enthält die Geradengleichung in der Form ax + by + c = 0
      function  LineIntersectsWindow: Boolean; virtual;
      function  GetWinPosNextTo(_X, _Y: Double): TPoint; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure VirtualizeCoords; override;
      procedure UpdateScreenCoords; override;
      procedure SetNewNameParamsIn(TextObj: TGTextObj); override;
      procedure UpdateNameCoordsIn(TextObj: TGTextObj); override;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure Invalidate; override;
    public
      constructor Create(iObjList: TGeoObjListe; iP1, iP2 : TGeoObj; iis_visible : Boolean);
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      destructor Destroy; override;
      destructor FreeBluePrint; override;
      procedure GetDataVector(var v: TVector3); override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean; override;
      function  GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean; override;
      procedure RegisterAsMacroStartObject; override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      function  GetNormalizedDirection: TFloatPoint;
      function  GetValue(selector : Integer): Double; override;
      function  GetDataStr: String; override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  LiesParallel(GO: TGSTraightLine): Boolean; overload;
      function  LiesParallel(P1, P2: TGPoint): Boolean; overload;
      function  LiesOrthogonal(GO: TGStraightLine): Boolean; overload;
      function  LiesOrthogonal(P1, P2: TGPoint): Boolean; overload;
      function  IsPerpendicularTo(SL: TGStraightLine): Boolean;
      function  IsParallelTo(SL: TGStraightLine): Boolean;
      function  Includes(xp, yp: Double): Boolean; override;
      property  HesseEq : TVector3 read FHesseEq; // Geradengleichung: ax + by + c = 0
    end;

  TGShortLine = class (TGStraightLine)
    protected
      function  DefaultName: WideString; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      function  GetWinPosNextTo(_X, _Y: Double): TPoint; override;
      procedure SetNewNameParamsIn(TextObj: TGTextObj); override;
      procedure UpdateNameCoordsIn(TextObj: TGTextObj); override;
      procedure UpdateScreenCoords; override;
    public
      procedure ResetOLCPList(PointList : TVector3List); override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  GetValue(selector: Integer): Double; override;
      function  GetDataStr: String; override;
      function  Includes(xp, yp: Double): Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      function  GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean; override;
      function  GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean; override;
      function  Dist (xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  GetInfo: String; override;
    end;

  TGFixLine = class (TGShortLine)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure VirtualizeCoords; override;
      procedure Register4Dragging(DragList: TObjPtrList); override;
      procedure Invalidate; override;
      procedure Revalidate; override;
    public
      MyLength  : Double;
      constructor Create(iObjList: TGeoObjListe; iP1, iP2 : TGeoObj; iLength : Double; iis_visible : Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      destructor  Destroy; override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      procedure AdjustFriendlyLinks;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  GetInfo: String; override;
    end;

  TGVector = class (TGShortLine)
    protected
      X21, Y21,
      X22, Y22,
      dx, dy    : Double;
      sx21, sy21,
      sx22, sy22: Integer;
      function  DefaultName: WideString; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure UpdateScreenCoords; override;
      procedure DrawIt; override;
      procedure HideIt; override;
    public
      constructor Create(iObjList: TGeoObjListe; iP1, iP2 : TGeoObj; iis_visible : Boolean);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  GetValue(selector : Integer) : Double; override;
      function  GetDataStr: String; override;
      function  GetAncestorVector: TGVector;
      procedure BecomesChildOf(GO: TGeoObj); override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGHalfLine = class (TGStraightLine)
    protected
      function  DefaultName: WideString; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      function  GetWinPosNextTo(_X, _Y: Double): TPoint; override;
      procedure UpdateScreenCoords; override;
    public
      procedure ResetOLCPList(PointList : TVector3List); override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetRandomParam: Double; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      function  GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean; override;
      function  GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean; override;
      function  Includes(xp, yp: Double): Boolean; override;
      function  Dist(xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  GetDataStr: String; override;
      function  GetInfo: String; override;
    end;

  TGLongLine = class (TGStraightLine)
    protected
      FReversed27 : Boolean;
      function  DefaultName: WideString; override;
      function  GetFillHandle(Ori: Boolean): HRgn; override;
      procedure VirtualizeCoords; override;
      procedure UpdateScreenCoords; override;
    public
      constructor Create(iObjList: TGeoObjListe; iP1, iP2 : TGeoObj; iis_visible : Boolean);
      function  CreateI2GElementNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  CreateI2GConstraintNode(DOMDoc: IXMLDocument; ObjNames: TStrings): IXMLNode; override;
      function  GetDataStr: String; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  Dist (xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  GetValue(selector: Integer): Double; override;
      function  GetRandomParam: Double; override;
      function  GetInfo: String; override;
      procedure ResetOLCPList(PointList : TVector3List); override;
      property  Reversed27 : Boolean read FReversed27;
    end;

  TGBaseLine = class (TGLongLine)
    protected
      dx, dy : Double;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      function  AllAncestorsAreFreePoints(PList: TObjPtrList = Nil): Boolean; override;
      procedure SetDataValid(flag: Boolean); override;
      procedure VirtualizeCoords; override;
    public
      constructor Create(iObjList: TGeoObjListe; ix1, iy1, ix2, iy2: Integer; iis_visible : Boolean);
      constructor CreateFromHesseEq(iObjList: TGeoObjListe; a, b, c: Double; iis_visible: Boolean);
      constructor CreatePtDir(iObjList: TGeoObjListe; iPt, iDir: TVector3; iis_visible: Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      function  GetMatchingCursor(mpt: TPoint): TCursor; override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      procedure UpdateParams; override;
      procedure RegisterAsMacroStartObject; override;
      function  GetInfo: String; override;
    end;

  TGMirrorLine = class (TGLongLine)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iL, iSym : TGeoObj; iis_visible : Boolean);
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGMirrorLongLine = class (TGBaseLine)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iL, iSym : TGeoObj; iis_visible : Boolean);
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGMovedLongLine = class(TGBaseLine)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iL, iv : TGeoObj; iis_visible : Boolean);
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGRotatedLongLine = class(TGBaseLine)
    protected
      RotAngle : Double;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iL, iMP, iAO: TGeoObj; iis_Visible: Boolean);
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGStretchedLongLine = class(TGBaseLine)
    protected
      SFactor : Double;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iL, iZP, iSF: TGeoObj; iis_Visible: Boolean);
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGMappedLine = class(TGBaseLine)
    protected
      function GetImplicitMakStartObj(n: Integer): TGeoObj; override;
      function HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iOriLn, iMapObj: TGeoObj; iis_visible: Boolean);
      procedure GetDataFromOldMappedObj(OMO: TGeoObj); override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGOLLongLine = class (TGLongLine)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure Invalidate; override;
      procedure Revalidate; override;
    public
      constructor Create(iObjList: TGeoObjListe; iOL : TGeoObj; iis_visible : Boolean);
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  GetInfo: String; override;
    end;

  TGAxis = class (TGBaseLine)
    protected
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure VirtualizeCoords; override;
      procedure SetMyColour(NewCol: TColor); override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      caption : String;
      constructor Create (iObjList: TGeoObjListe; iOri: TGOrigin; idx, idy: Integer; iis_visible: Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      procedure RegisterAsMacroStartObject; override;
      function  IsNearMouse: Boolean; override;
      function  GetInfo: String; override;
      end;

  TGDirLine = class (TGLongLine)     // veraltet !!!
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      function  DataEquivalent(var data): Boolean; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure VirtualizeCoords; override;
    public
      dAngle : Double;
      constructor Create(iObjList: TGeoObjListe; iP1, iSP : TGeoObj; iAngle : Double; iis_visible : Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGMSenkr = class (TGLongLine)
    public
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGWHalb = class (TGLongLine)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iP1, iP2, iP3 : TGeoObj; iis_visible : Boolean);
      procedure AfterLoading(FromXML : Boolean = True); override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGLot = class (TGLongLine)     // veraltet !!!
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure VirtualizeCoords; override;
    public
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGSenkr = class (TGLot)
    protected
      procedure SetNewNameParamsIn(TextObj: TGTextObj); override;
      procedure UpdateNameCoordsIn(TextObj: TGTextObj); override;
    public
      constructor CreateFrom(oldObj: TGLot);
      function  CreateI2GConstraintNode(DOMDoc: IXMLDocument; ObjNames: TStrings): IXMLNode; override;
      procedure UpdateParams; override;
    end;

  TGParall = class (TGLongLine)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure VirtualizeCoords; override;
    public
      function  CreateI2GConstraintNode(DOMDoc: IXMLDocument; ObjNames: TStrings): IXMLNode; override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGTangent = class (TGLongLine)
    public
      constructor Create(iObjList: TGeoObjListe; iP, iL: TGeoObj; iis_visible: Boolean);
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGNormal = class (TGTangent)
    public
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGPolare = class(TGLongLine)
    public
      constructor Create(iObjList: TGeoObjListe; iP, iL: TGeoObj; iis_visible: Boolean);
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGChordal = class(TGMSenkr)
    public
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGXLine = class (TGDirLine)
    protected
      function  DataEquivalent(var data): Boolean; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
    public
      wTerm : TTBaum;
      constructor Create(iObjList: TGeoObjListe; iP1, iSP : TGeoObj; iWTerm : WideString; iis_visible : Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateProtoTypFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      destructor  Destroy; override;
      destructor  FreeBluePrint; override;
      procedure AfterLoading(FromXML: Boolean); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  CreateProtoTypNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure UpdateParams; override;
      procedure UpdateV1xObjects; override;
      procedure UpdateOldPrototype; override;
      procedure SetNewAngle(wStr: WideString);
      procedure RebuildTermStrings; override;
      function  HasBuggyTerm: Boolean; override;
      procedure LoadContextMenuEntriesInto(menu: TPopupMenu); override;
      function  GetInfo: String; override;
    end;

  TGXRay = class(TGXLine)
    protected
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure UpdateScreenCoords; override;
    public
      function GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function Includes(xp, yp: Double): Boolean; override;
      function GetInfo: String; override;
    end;

  TGCircle = class (TGLine)
    protected
      function  DefaultName: WideString; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      function  GetWinPosNextTo(_X, _Y: Double): TPoint; override;
      function  GetFillHandle(Ori: Boolean): HRgn; override;
      function  FixedParentsCount: Integer;
      procedure VirtualizeCoords; override;
      procedure UpdateScreenCoords; override;
      procedure UpdateNameCoordsIn(TextObj: TGTextObj); override;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure SetIsFlagged(flag: Boolean); override;
      procedure SetNewNameParamsIn(TextObj: TGTextObj); override;
    public
      Radius: Double;
      constructor Create(iObjList: TGeoObjListe; iP1, iP2 : TGeoObj; iis_visible : Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      procedure AfterLoading(FromXML : Boolean); override;
      procedure ResetOLCPList(PointList : TVector3List); override;
      procedure GetDataVector(var v: TVector3); override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      procedure GetConicCoeff(var coeff: TCoeff6);
      procedure UpdateParams;  override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  Includes(xp, yp: Double): Boolean; override;
      function  IsPairedWith(pc: TGCircle): Boolean;
      function  IsClosedLine: Boolean; override;
      function  GetTangentIn(bx, by: Double; var tanCoeff: TVector3): Boolean; override;
      function  GetPolOf(polare: TVector3; var px, py: Double): Boolean; override;
      function  GetPolareOf(bx, by: Double; var polCoeff: TVector3): Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      function  IsFilled(var FO: TGArea): Boolean; override;
      function  Dist(xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  GetValue(selector: Integer): Double; override;
      function  GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean; override;
      function  GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean; override;
      procedure RegisterAsMacroStartObject; override;
      procedure SaveState; override;
      procedure RestoreState; override;
      function  GetDataStr: String; override;
      function  GetInfo: String; override;
    end;

  TGBaseCircle = class (TGCircle)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure VirtualizeCoords; override;
    public
      constructor Create(iObjList: TGeoObjListe; ix1, iy1, ix2, iy2 : Integer; iis_visible: Boolean);
      constructor CreateFromMat(iObjList: TGeoObjListe; iMat: Array of Double; iis_visible: Boolean);
      constructor CreatePtRad(iObjList: TGeoObjListe; iPt: TVector3; iRad: Double; iis_visible: Boolean);
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  GetMatchingCursor(mpt: TPoint): TCursor; override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      procedure UpdateParams; override;
      procedure RegisterAsMacroStartObject; override;
      function  GetInfo: String; override;
    end;

  TGOLCircle = class(TGCircle)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure Invalidate; override;
      procedure Revalidate; override;
    public
      constructor Create(iObjList: TGeoObjListe; iOL : TGeoObj; iis_visible: Boolean);
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      procedure UpdateParams; override;
      procedure RegisterAsMacroStartObject; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  GetInfo: String; override;
    end;

  TGFixCircle = class (TGCircle)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      function  DataEquivalent(var data): Boolean; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
    public
      constructor Create(iObjList: TGeoObjListe; iP : TGeoObj; iRadius : Double; iis_visible : Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGXCircle = class (TGFixCircle)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      function  DataEquivalent(var data): Boolean; override;
      procedure VirtualizeCoords; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
    public
      rTerm : TTBaum;
      constructor Create(iObjList: TGeoObjListe; iP : TGeoObj; iRTerm : WideString; iis_visible : Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor CreateProtoTypFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      destructor  Destroy; override;
      destructor  FreeBluePrint; override;
      procedure AfterLoading(FromXML: Boolean); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  CreateProtoTypNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure UpdateParams; override;
      procedure UpdateV1xObjects; override;
      procedure UpdateOldPrototype; override;
      procedure SetNewRadius(rStr: WideString);
      procedure RebuildTermStrings; override;
      function  HasBuggyTerm: Boolean; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  GetInfo: String; override;
    end;

  TGMirrorCircle = class(TGCircle)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iC, iSymZ: TGeoObj; iis_Visible: Boolean);
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGMovedCircle = class(TGCircle)
    protected
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iC, iv: TGeoObj; iis_Visible: Boolean);
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGRotatedCircle = class(TGCircle)
    protected
      RotAngle : Double;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iC, iMP, iAO: TGeoObj; iis_Visible: Boolean);
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGStretchedCircle = class(TGCircle)
    protected
      sFactor : Double;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iC, iZP, iSF: TGeoObj; iis_Visible: Boolean);
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGMappedCircle = class(TGCircle)
    protected
      dv     : TVector3;   // "data vector"
      FIsArc : Boolean;
      function  degenerated : Boolean;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      function  GetImplicitMakStartObj(n: Integer): TGeoObj; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure SetIsArc;
      procedure UpdateScreenCoords; override;
      procedure DrawIt; override;
      procedure HideIt; override;
    public
      constructor Create(iObjList: TGeoObjListe; iOriCirc, iMapObj: TGeoObj; iis_visible: Boolean);
      destructor Destroy; override;
      procedure GetDataFromOldMappedObj(OMO: TGeoObj); override;
      procedure AfterLoading(FromXML : Boolean = True); override;
      function  Dist(xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  Includes(xp, yp: Double): Boolean; override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      procedure GetDataVector(var v: TVector3); override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
      property IsArc: Boolean read FIsArc;
      property IsDegenerated: Boolean read degenerated;
    end;

  TGCircle3P = class(TGMappedCircle)
    protected
      function HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; iP1, iP2, iP3: TGeoObj; iis_visible: Boolean);
      procedure AfterLoading(FromXML : Boolean = True); override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGArc = class(TGCircle)
    protected
      StartAngle,
      EndAngle,
      X3, Y3      : Double;
      function  DefaultName: WideString; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      function  GetRotationAngle: Double;
      function  GetFillHandle(Ori: Boolean): HRgn; override;
      procedure UpdateBorderAngles;
      procedure UpdateNameCoordsIn(TextObj: TGTextObj); override;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure SetNewNameParamsIn(TextObj: TGTextObj); override;
    public
      constructor Create(iObjList: TGeoObjListe; iP1, iP2, iP3 : TGeoObj; iis_reversed, iis_visible : Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure AfterLoading(FromXML: Boolean); override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean; override;
      function  GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean; override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams;  override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  IsClosedLine: Boolean; override;
      function  Includes(xp, yp: Double): Boolean; override;
      function  Dist(xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      function  GetValue(selector: Integer): Double; override;
      function  GetInfo: String; override;
      property  RotationAngle: Double read GetRotationAngle;
    end;

  TGCurve = class(TGLine)
    protected
      IntPointLists : TPointArrays;
    public
      points        : TVector3List;
      destructor Destroy; override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  Dist(xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean; override;
      function  GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean; override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure GetDataVector(var v: TVector3); override;
    end;

  TGArea = class(TGParentObj)
    protected
      PrevHandle,
      Handle   : THandle;
      ops      : String;
      BrushBMP : TBitMap;
      FQuant   : Double;
      function  DefaultName: WideString; override;
      function  InitBrushBMP: TBitMap;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure UpdateScreenCoords; override;
      procedure SetMyColour(newCol: TColor); override;
      procedure SetIsFlagged(flag: Boolean); override;
      procedure AdjustGraphTools(to_draw: Boolean); override;
      procedure Register4Dragging(DragList: TObjPtrList); override;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure DrawLimitLines; virtual;
      procedure CutOffAt(CutLine: TGLine; op: Char);
      procedure Invalidate; override;
      procedure Revalidate; override;
    public
      Orientation : Boolean; { = True für mathematisch positiven Umlaufsinn }
      constructor Create(iObjList: TGeoObjListe; iParent: TGLine;
                         iis_visible: Boolean; iOrientation: Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      destructor  Destroy; override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure AfterLoading(FromXML : Boolean = True); override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams;  override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  Dist(xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  CanBeDragged: Boolean; virtual;
      function  GetValue(selector: Integer): Double; override;
      function  GetMatchingCursor(mpt: TPoint): TCursor; override;
      procedure SetGraphTools(LineStyleNum, PointStyleNum,
                              FillStyleNum: Integer; iColor: TColor); override;
      procedure GetGraphTools(var LineStyleNum, PointStyleNum,
                                  FillStyleNum: Integer; var iColor: TColor); override;
      procedure CutAtLine(CutLine: TGLine; OriP: TPoint);
      procedure LoadContextMenuEntriesInto(menu: TPopupMenu); override;
      procedure RegisterAsMacroStartObject; override;
      function  GetInfo: String; override;
      property  Quant: Double read FQuant;
    end;

  TOLPoint = class (TPersistent)
    public
      x, y   : Double;
      constructor Create (iObjList: TGeoObjListe; ix, iy: Double);
      constructor Load(S: TFileStream);
      constructor Load32(R: TReader);
    end;

  TGAngle = class (TGeoObj)
    protected
      dpX, dpY : Array [1..3] of Double; { Index 1: Punkt auf dem 1. Schenkel }
                                         {       2: Scheitelpunkt   <- iP2num }
                                         {       3: Punkt auf dem 2. Schenkel }
      spX, spY : Array [1..3] of Integer;
      Angle1,             { Winkel zwischen positiver x-Achse und 1. Schenkel }
      Angle2,             { Winkel zwischen positiver x-Achse und 2. Schenkel }
      Radius   : Double;  { War bis 2.4 ein Double! Und ab 2.7 auch wieder!   }
      Reversed : Boolean;
      function  DefaultName: WideString; override;
      procedure SetShowsAlways(vis: Boolean); override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure UpdateScreenCoords; override;
      procedure VirtualizeCoords; override;
      procedure UpdateNameCoordsIn(TextObj: TGTextObj); override;
      procedure AdjustGraphTools(todraw : Boolean); override;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure SetNewNameParamsIn(TextObj: TGTextObj); override;
    public
      constructor Create(iObjList: TGeoObjListe; iP1, iP2, iP3 : TGeoObj; iis_visible : Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure AfterLoading(FromXML : Boolean); override;
      procedure UpdateOldNameData;
      function  GetMatchingCursor(mpt: TPoint): TCursor; override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  Dist(xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  GetValue(selector: Integer): Double; override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  GetInfo: String; override;
    end;

  TGTextObj = class(TGeoObj)
    protected
      FormatText: TFormatText;
      FHTMLText : String;
      RenderWin : TPoint;
      function  LoadMasks : Boolean;
      procedure SetMyColour(NewCol: TColor); override;
      function  GetIsMoving: Boolean; virtual;
      procedure SetIsMoving(flag: Boolean); virtual;
      procedure SetShowsAlways(vis: Boolean); override;
      procedure SetIsMarked(flag: Boolean); override;
      procedure SetWinPos(newVal: TPoint); override;
      function  GetHTMLText: String;
      procedure SetHTMLText(s: String); virtual;
      procedure RenderHTML2BMP; virtual;
      procedure AdjustGraphTools(todraw : Boolean); override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure Register4Dragging(DragList: TObjPtrList); override;
      procedure UpdateNameCoordsIn(TextObj: TGTextObj); override;
      procedure UpdateScreenCoords; override;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure ExportIt; override;
      procedure MoveIt; virtual;
    public
      x_Offset,
      y_Offset   : Integer;
      rConst,
      sConst     : Double;
      OldText    : String;
      BMPText,
      BMPTextOR,
      BMPTextAND : TBitMap;
      OutRect    : TRect;
      constructor Create (iObjList: TGeoObjListe; iis_visible: Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load (S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      destructor  Destroy; override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure AfterLoading(FromXML : Boolean = True); override;
      procedure InitMoving(xm, ym: Integer); virtual;
      procedure SetNewRelativPos; virtual;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  GetMatchingCursor(mpt: TPoint): TCursor; override;
      function  Dist (xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  GetRenderWin: TRect;
      function  GetFontScale(Canvas: TCanvas): Double; virtual;
      procedure GetDataFrom(SEdit: TFormatEdit); virtual;
      procedure UpdateParams; override;
      procedure HideDisplay;
      property IsMoving: Boolean read GetIsMoving write SetIsMoving;
      property HTMLText: String read GetHTMLText write SetHTMLText;
    end;

  TGName = class(TGTextObj)
    protected
      ExportRect : TRect;
      procedure VirtualizeCoords; override;
      procedure SetIsGrouped(flag: Boolean); override;
      procedure SetShowsAlways(nv: Boolean); override;
      procedure Invalidate; override;
      procedure Revalidate; override;
      procedure UpdateScreenCoords; override;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure ExportIt; override;
      function  GetIsVisible: Boolean; override;
      function  DefaultName: WideString; override;
    public
      constructor Create(iObjList: TGeoObjListe; iGO: TGeoObj; irConst, isConst: Double);
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      destructor  Destroy; override;
      procedure RebuildPointers; override;
      procedure AfterLoading(FromXML: Boolean); override;
      procedure BecomesChildOf(GO: TGeoObj); override;
      procedure UpdateParams; override;
      procedure AddToGroup(GroupMask: Integer); override;
      procedure InitMoving(xm, ym: Integer); override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  GetInfo: String; override;
    end;

  TGDistLine = class(TGTextObj)
    protected
      _xm, _ym, _xn, _yn,
      _xs1, _ys1, _xs2, _ys2 : Double;
      _pu                    : String;
      _valid1, _valid2       : Boolean;     { Interne Puffervariablen }
      value,
      X1,  Y1,  X2,  Y2,
      dx,  dy            : Double;
      sx1, sy1, sx2, sy2 : Integer;
      function  GetName: WideString; override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure UpdateScreenCoords; override;
      procedure SetMyColour(NewCol: TColor); override;
      procedure SetIsMarked(flag: Boolean); override;
      procedure AdjustGraphTools(todraw : Boolean); override;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure ExportIt; override;
      procedure MoveIt; override;
    public
      TypComp   : Array [1..2] of Integer;
      constructor Create(iObjList: TGeoObjListe; iObj1, iObj2: TGeoObj; iis_visible: Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure AfterLoading(FromXML : Boolean); override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  Dist(xm, ym: Double): Double; override;
      function  GetValue(selector: Integer): Double; override;
      procedure InitMoving(xm, ym: Integer); override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      procedure SetNewRelativPos; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  GetInfo: String; override;
    end;

  TGAngleWidth = class(TGDistLine)
    protected
      function  GetName: WideString; override;
      procedure UpdateScreenCoords; override;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure MoveIt; override;
    public
      constructor Create(iObjList: TGeoObjListe; iObj: TGeoObj; iis_visible: Boolean);
      procedure AfterLoading(FromXML : Boolean); override;
      procedure UpdateParams; override;
      procedure InitMoving(xm, ym: Integer); override;
      procedure InsertMeasureInto(Target: TFormatEdit); override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  GetValue(selector: Integer): Double; override;
      function  GetFormattedName: String; override;
      function  GetInfo: String; override;
    end;

  TGAreaSize = class(TGAngleWidth)
    protected
      function  GetName: WideString; override;
      procedure UpdateScreenCoords; override;
    public
      constructor Create(iObjList: TGeoObjListe; iObj: TGeoObj; iis_visible: Boolean);
      procedure InsertMeasureInto(Target: TFormatEdit); override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGComment = class(TGTextObj)
    protected
      paraVisNum,
      paraCount : Integer;
      function  DefaultName: WideString; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      function  GetLeadingParas(pc: Integer; s: String): String;
      procedure RenderHTML2BMP; override;
      procedure VirtualizeCoords; override;
      procedure SetHTMLText(s: String); override;
      procedure Rescale; override;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure ExportIt; override;
    public
      constructor Create(iObjList: TGeoObjListe; iColor: Word; iOrg: TPoint);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor Load(S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      procedure AfterLoading(FromXML: Boolean); override;
      procedure BecomesChildOf(GO: TGeoObj); override;
      procedure Stops2BeChildOf(GO: TGeoObj); override;
      procedure GetDataFrom(SEdit: TFormatEdit); override;
      procedure Expand;
      procedure Collapse;
      procedure UpdateParams; override;
      procedure InitMoving(xm, ym: Integer); override;
      procedure SetNewAbsolutePos(newPos: TPoint);
      procedure SetNewRelativPos; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  GetMatchingCursor(mpt: TPoint): TCursor; override;
      function  IsDynamic: Boolean;
      function  GetLinkTagFromWinPos(wpos: TPoint): Integer;
      function  GetLinkAddressFromTag(ltag: Integer): String;
      function  GetInfo: String; override;
    end;



implementation


uses GeoHelper, GeoMakro, GeoImage, GeoConic, GeoLocLines, GeoTransf;


{====== TGeoObjListe ==========================}

constructor TGeoObjListe.Create(iHostWinHandle: HWnd; iDrawCanvas: TCanvas; iRect: TRect);
  begin
  Inherited Create;
  HostWinHandle     := iHostWinHandle;      { nur für Windows-Botschaften  }
  FWindowRect       := iRect;
  FActCanvas        := iDrawCanvas;
  FTargetCanvas     := iDrawCanvas;         { konsistente Initialisierung  }
  FDoubleBuffered   := False;               { konsistente Initialisierung  }
  FNextGeoNum       :=  1; {= kleinste mögliche GeoNummer! 0 ist ungültig! }
  LastValidObjIndex := Pred(Count);         { = -1  für eine leere Liste ! }
  FIsLoading        := False;
  IsBlinkOn         := False;
  DragList          := TObjPtrList.Create(False);
  GroupList         := TGeoGroupList.Create;
  MakroList         := TMakroList.Create;
  LengthUnit        := DefLengthUnit;
  AreaUnit          := DefAreaUnit;
  AngleUnit         := DefAngleUnit;
  BackgroundColor   := clWhite;
  StartFont         := TFont.Create;
  StartFont.Assign(GlobalDefaultFont);     // für alle Fälle !
  DragStrategy      := DefDragStrategy;
  CRText            := TStringList.Create;
  ShowingCRText     := False;

  // Derzeit kann DynaGeoX noch keine neuen Zeichungen erzeugen.
  // Trotzdem ist diese Möglichkeit hier schon mal vorgesehen,
  // um die Methode zukunftssicher zu machen.
  If IsActiveX then begin
    CreationProg  := 'DynaGeoX';
    CreationVers  := AXVersionStr;
    end
  else begin
    CreationProg  := 'EUKLID DynaGeo';
    CreationVers  := FullVersionString(Application.ExeName);
    end;
  DateTimeToString(CreationDate, 'yyyy"-"mm"-"dd"T"hh":"nn":"ss', Now);
  LastEditProg  := CreationProg;
  LastEditVers  := CreationVers;
  LastEditDate  := CreationDate;

  Fe1x := act_pixelPerXcm;
  Fe1y := 0.0;
  Fe2x := 0.0;
  Fe2y := - act_pixelPerYcm;
  FPixDist   := 1/Fe1x;
  FScale     := 1.0;
  FFontScale := 0.0;
  AnimationSource  := Nil;
  AnimationRunning := False;
  OutputStatus     := outScreen;{ setzt auch IsDoubleBuffered und TargetCanvas }
  NewLocLineStatus := -1;       { lädt die Default-Einstellungen }
  end;


constructor TGeoObjListe.Load(S: TFileStream; iHostWinHandle: HWnd; iDrawCanvas: TCanvas; iRect: TRect);
  var typeId, n, i : Integer;
  { typeId(TGeoObjListe) = $95;
    muß von der aufrufenden Prozedur gelesen werden }
  begin
  HostWinHandle := iHostWinHandle;
  IsLoading     := True;
  FActCanvas    := iDrawCanvas;
  Fe1x := act_pixelPerXcm;
  Fe1y := 0.0;
  Fe2x := 0.0;
  Fe2y := - act_pixelPerYcm;
  FPixDist := 1/Fe1x;
  FScale        := 1.0;
  FFontScale    := 0.0;
  FWindowRect   := iRect;
  AnimationSource  := Nil;
  AnimationRunning := False;
  CRText           := TStringList.Create;
  ShowingCRText    := False;
  BackgroundColor  := clWhite;
  StartFont        := TFont.Create;
  StartFont.Assign(GlobalDefaultFont);      // für alle Fälle !

  FNextGeoNum   := ReadOldIntFromStream(S);
  For i := 1 to 6 do
    n := ReadOldIntFromStream(S);
  ReadOldIntFromStream(S);
  ReadOldIntFromStream(S);

  For i := 1 to n do begin
    typeId := ReadOldIntFromStream(S);
    Case typeId of
      153      : Add(TGPoint.Load(S, Self));
      154      : Add(TGMiddlePt.Load(S, Self));
      155      : Add(TGMirrorPt.Load(S, Self));
      156      : Add(TGDoublePt.Load(S, Self));
      157      : Add(TGSecondPt.Load(S, Self));
      158      : Add(TGLxLPt.Load(S, Self));
      159      : Add(TGShortLine.Load(S, Self));
      160      : Add(TGLongLine.Load(S, Self));
      161      : Add(TGMSenkr.Load(S, Self));
      162      : Add(TGLot.Load(S, Self));
      163      : Add(TGParall.Load(S, Self));
      164      : Add(TGBaseLine.Load(S, Self));
      165      : Add(TGCircle.Load(S, Self));
      166      : Add(TGBaseCircle.Load(S, Self));
      167      : Add(TGAngle.Load(S, Self));
      168      : Add(TGWHalb.Load(S, Self));
      170      : Add(TGLocLine.Load(S, Self));
      171,                                    { TGName       }
      172,                                    { TGPointName  }
      173,                                    { TGSLineName  }
      174,                                    { TGLLineName  }
      175,                                    { TGCircleName }
      176      : Add(TGName.Load(S, Self));   { TGAngleName  }
      177      : Add(TGFixCircle.Load(S, Self));
      178      : Add(TGFixLine.Load(S, Self));
      179      : Add(TGDirLine.Load(S, Self));
      180      : Add(TGDistLine.Load(S, Self));
      181      : Add(TGAngleWidth.Load(S, Self));
      182      : Add(TGOrigin.Load(S, Self));
      183      : Add(TGAxis.Load(S, Self));
      184      : Add(TGaugePoint.Load(S, Self));
      185      : Add(TGCoordPt.Load(S, Self));
      186      : Add(TGXCircle.Load(S, Self));
      187      : Add(TGXLine.Load(S, Self));
      188      : Add(TGComment.Load(S, Self));
    else
      raise EStreamError.Create('Unbekannter Objekttyp! '#13#10 +
                                IntToStr(i) + '. Objekt hat Id ' +
                                IntToStr(typeId));
      { Fehlerbehandlung nachrüsten }
    end; { of case }
    end;

  LastValidObjIndex := Pred(Count);   { Die Liste darf keine gelöschten Objekte enthalten ! }
  IsBlinkOn         := False;
  OutputStatus      := outScreen;     { setzt auch IsDoubleBuffered und ActCanvas }
  NewLocLineStatus  := -1;            { lädt die Default-Einstellungen }
  DragList          := TObjPtrList.Create(False);
  GroupList         := TGeoGroupList.Create;
  MakroList         := TMakroList.Create;
  ClearBitmap(FDoubleBuffer, BackGroundColor);  { verträgt auch DoubleBuffer = Nil ! }
  IsDirty           := False;

  ActualizeWindowsConstants;
  RebuildAllPointers;
  end;


constructor TGeoObjListe.Load32(R: TReader; iHostWinHandle: HWnd; iDrawCanvas: TCanvas;
                                iTempEdit: TFormatEdit; iRect: TRect);
  var typName : String;
      typRef  : TGeoObjClass;
  begin
  HostWinHandle := iHostWinHandle;
  IsLoading     := True;
  FActCanvas    := iDrawCanvas;
  FWindowRect   := iRect;
  FScale        := 1.0;
  FFontScale    := 0.0;

  FNextGeoNum      := R.ReadInteger;
  AnimationSource  := Nil;
  AnimationRunning := False;
  CRText           := TStringList.Create;
  ShowingCRText    := False;
  StartFont        := TFont.Create;
  StartFont.Assign(GlobalDefaultFont);
  NewLocLineStatus := -1;       { lädt die Default-Einstellungen }

  If R.NextValue in [vaString, vaLString, vaWString, vaUTF8String] then begin
    typName := R.ReadString;
    FAnimationSource := TGNumberObj(R.ReadInteger);
    end;

  If R.NextValue = vaExtended then begin
    Fe1x := R.ReadFloat;
    Fe1y := R.ReadFloat;
    Fe2x := R.ReadFloat;
    Fe2y := R.ReadFloat;
    FPixDist := R.ReadFloat;
    FWindowOrigin.X := R.ReadInteger;
    FWindowOrigin.Y := R.ReadInteger;
    end
  else begin
    Fe1x := act_pixelPerXcm;
    Fe1y := 0.0;
    Fe2x := 0.0;
    Fe2y := - act_pixelPerYcm;
    FPixDist := 1/Fe1x;
    end;

  ActualizeWindowsConstants;
  BackGroundColor := TColor(R.ReadInteger);

  R.ReadListBegin;
  While Not R.EndOfList do begin
    typName := R.ReadString;
    typRef  := TGeoObjClass(FindClass(typName));
    Add(typRef.Load32(R, Self));
    end;
  R.ReadListEnd;

  LastValidObjIndex := Pred(Count);   { Die Liste darf keine gelöschten Objekte enthalten ! }
  IsBlinkOn         := False;
  OutputStatus      := outScreen;     { Setzt auch IsDoubleBuffered und ActCanvas ! }
  ClearBitmap(FDoubleBuffer, BackGroundColor);  { verträgt auch DoubleBuffer = Nil ! }
  DragList          := TObjPtrList.Create(False);
  GroupList         := TGeoGroupList.Create;
  MakroList         := TMakroList.Create;
  DragStrategy      := DefDragStrategy;
  IsDirty           := False;

  RebuildAllPointers;
  end;

constructor TGeoObjListe.CreateFromI2GData(DOMTree: IXMLNode;
                                           oldDrawing: TGeoObjListe);
  begin
  Inherited Create;
  HostWinHandle := oldDrawing.HostWinHandle;
  FWindowRect   := oldDrawing.WindowRect;
  Fe1x          := oldDrawing.e1x;
  Fe1y          := oldDrawing.e1y;
  Fe2x          := oldDrawing.e2x;
  Fe2y          := oldDrawing.e2y;

  IsBlinkOn     := False;
  OutputStatus  := outScreen;
  CRText        := TStringList.Create;
  DragList      := TObjPtrList.Create(False);
  GroupList     := TGeoGroupList.Create;
  GroupList.Initialize(oldDrawing.GroupList.WinHandle,
                       oldDrawing.GroupList.OnClick,
                       oldDrawing.GroupList.ItemSpace);
  MakroList     := TMakroList.Create;
  LengthUnit    := DefLengthUnit;
  AreaUnit      := DefAreaUnit;
  AngleUnit     := DefAngleUnit;
  DragStrategy  := DefDragStrategy;
  StartFont     := TFont.Create;
  StartFont.Assign(oldDrawing.StartFont);
  BackgroundColor := oldDrawing.BackgroundColor;

//  GetHeaderDataFrom(DOMTree.childNodes.findNode('header', ''));
//  GetWindowDataFrom(DOMTree.childNodes.findNode('windowdata', ''));

  FActCanvas        := oldDrawing.ActCanvas;
  FTargetCanvas     := oldDrawing.ActCanvas;
  FDoubleBuffered   := False;
  oldDrawing.FActCanvas := Nil;
  IsDoubleBuffered  := oldDrawing.IsDoubleBuffered;
  AnimationRunning  := False;
  OutputStatus      := outScreen;

  LastValidObjIndex := -1;
  InitCoordSys(oldDrawing.WindowOrigin.X, oldDrawing.WindowOrigin.Y,
               oldDrawing.WindowRect, -1, True);
  end;

constructor TGeoObjListe.CreateFromGeoDomData(DOMTree: IXMLNode;
                                           oldDrawing: TGeoObjListe;
                                           var ValTabData: TValTabData);
  var DeprecList : TList;

  procedure GetHeaderDataFrom(DOMHeaderData: IXMLNode);
    var CreatorProg, EditorProg, Environment, Validation,
        DomCommands, Links, Copyright : IXMLNode;
        CRTextStr, SignCode : WideString;
    begin
    CreatorProg := DOMHeaderData.childNodes.findNode('created', '');
    If Assigned(CreatorProg) then begin
      CreationProg := CreatorProg.getAttribute('prog_name');
      CreationVers := CreatorProg.getAttribute('prog_version');
      If CreatorProg.hasAttribute('date') then
        CreationDate := CreatorProg.getAttribute('date')
      else
        CreationDate := '';

      EditorProg := DOMHeaderData.ChildNodes.findNode('edited', '');
      If Assigned(EditorProg) then begin
        LastEditProg := EditorProg.getAttribute('prog_name');
        LastEditVers := EditorProg.getAttribute('prog_version');
        if EditorProg.hasAttribute('date') then
          LastEditDate := EditorProg.getAttribute('date')
        else
          LastEditDate := '';
        end
      else begin
        LastEditProg := CreationProg;
        LastEditVers := CreationVers;
        LastEditDate := CreationDate;
        end;
      end;

    Environment := DOMHeaderData.childNodes.findNode('environment', '');
    If Assigned(Environment) then begin
      { "validation" wurde ab 3.0.0.274 abgeschafft; die Daten
        werden nun in einem eigenen TGCheckControl-Objekt abgelegt.
        Der folgende Code stellt die Kompatibilität sicher:          }
      Validation := Environment.ChildNodes.findNode('validation', '');
      If Assigned(Validation) then begin
        OldValidationCondition := Validation.getAttribute('condition');
        OldValidationHint := Validation.getAttribute('hint');
        OldValidationVars := Validation.getAttribute('vartypes');
        end;
      { Ende des Kompatibilitäts-Codes }

      CmdString := '';   // Ist da jemals was zu löschen?
      DomCommands := Environment.childNodes.findNode('commands', '');
      If Assigned(DomCommands) then
        CmdString := literalLine(DomCommands.NodeValue);
      Links := Environment.childNodes.findNode('links', '');
      If Assigned(Links) then begin
        if Links.hasAttribute('forward') then
          LinkForward := Links.getAttribute('forward')
        else
          LinkForward := '';
        if Links.hasAttribute('back') then
          LinkBack    := Links.getAttribute('back')
        else
          LinkBack    := '';
        end;
      end;

      Copyright := DOMHeaderData.childNodes.findNode('copyright', '');
      If Assigned(Copyright) then begin
        CRTextStr := Copyright.NodeValue;
        SignCode  := Copyright.getAttribute('sign_code');
        CRNr      := StrToInt(SignCode) XOR GeoFileCRMask;
        end
      else begin
        CRTextStr := '';
        CRNr      := 0;
        end;
      If Length(CRTextStr) > 0 then begin
        if CRText = Nil then
          CRText := TStringList.Create;
        CRText.Text := CRTextStr;
        end;
    end;

  procedure GetWindowDataFrom(DOMWinData: IXMLNode);
    var colstr             : String;
        org_ScrWidth,
        org_ScrHeight      : Integer;
        org_xMin, org_xMax,
        org_yMin, org_yMax : Double;
        DomBackCol,
        DomFont,
        DomOptions,
        DomValTab,
        DomCommands        : IXMLNode;
    begin
    With DOMWinData.childNodes.findNode('log_window', '') do begin
      org_xMin  := StrToFloat(getAttribute('xmin'));
      org_xMax  := StrToFloat(getAttribute('xmax'));
      org_yMin  := StrToFloat(getAttribute('ymin'));
      org_yMax  := StrToFloat(getAttribute('ymax'));
      end;
    With DOMWinData.childNodes.findNode('scr_window', '') do begin
      org_ScrWidth  := StrToInt(getAttribute('width'));
      org_ScrHeight := StrToInt(getAttribute('height'));
      end;

    BackgroundColor := clWhite;
    DomBackCol := DOMWinData.childNodes.findNode('back_col', '');
    If DomBackCol <> Nil then begin
      colstr := DomBackCol.NodeValue;
      If Length(colstr) > 0 then
        BackgroundColor := StrToInt(colstr);
      end;

    StartFont.Assign(GlobalDefaultFont);  // Initialisierung mit Default-Font !
    DomFont := DOMWinData.childNodes.findNode('startfont', '');
    If DomFont <> Nil then with DomFont do begin
      If HasAttribute('fontname') then
        StartFont.Name := getAttribute('fontname');
      If HasAttribute('fontsize') then
        StartFont.Size := StrToInt(getAttribute('fontsize'));
      If HasAttribute('fontcharset') then
        StartFont.Charset := StrToInt(getAttribute('fontcharset'))
      else
        StartFont.Charset := 1;
      If HasAttribute('attr_bold') and
         (LowerCase(getAttribute('attr_bold')) = 'true') then
        StartFont.Style := StartFont.Style + [fsBold]
      else
        StartFont.Style := StartFont.Style - [fsBold];
      end;

    LengthDecimals   := 3;
    AreaDecimals     := 2;
    AngleDecimals    := 0;
    LengthUnit       := DefLengthUnit;
    AreaUnit         := DefAreaUnit;
    AngleUnit        := DefAngleUnit;
    SignedAngles     := True;
    NewLocLineStatus := DefLocLineStatus;
    DomOptions := DOMWinData.childNodes.findNode('options', '');
    If DomOptions <> Nil then with DomOptions do begin
      If hasAttribute('LengthDecimals') then
        LengthDecimals := StrToInt(getAttribute('LengthDecimals'));
      If hasAttribute('AreaDecimals') then
        AreaDecimals := StrToInt(getAttribute('AreaDecimals'));
      If hasAttribute('AngleDecimals') then
        AngleDecimals := StrToInt(getAttribute('AngleDecimals'));
      If hasAttribute('LengthUnit') then
        LengthUnit := getAttribute('LengthUnit');
      If hasAttribute('AreaUnit') then
        AreaUnit := getAttribute('AreaUnit');
      If hasAttribute('AngleUnit') then
        AngleUnit := getAttribute('AngleUnit');
      If hasAttribute('SignedAngles') then
        SignedAngles := StrToBool(getAttribute('SignedAngles'));
      If hasAttribute('DefLocLineStatus') then
        NewLocLineStatus := StrToInt(getAttribute('DefLocLineStatus'));
      end;

    DomValTab := DOMWinData.childNodes.findNode('ValTabData', '');
    If Assigned(DomValTab) then begin
      If Not Assigned(ValTabData) then ValTabData := TValTabData.Create;
      ValTabData.vis := StrToBool(DomValTab.getAttribute('visible'));
      ValTabData.xmin   := DomValTab.getAttribute('xmin');
      ValTabData.xmax   := DomValTab.getAttribute('xmax');
      ValTabData.dx     := DomValTab.getAttribute('dx');
      ValTabData.marked    := DomValTab.getAttribute('marked');
      ValTabData.rect.Left   := StrToInt(DomValTab.getAttribute('left'));
      ValTabData.rect.Top    := StrToInt(DomValTab.getAttribute('top'));
      ValTabData.rect.Right  := StrToInt(DomValTab.getAttribute('right'));
      ValTabData.rect.Bottom := StrToInt(DomValTab.getAttribute('bottom'));
      end;

    { "commands" wurde ab 3.0.0.274 verlagert in den Header-Abschnitt;
      die folgenden 3 Zeilen wurden hier nur wegen der Kompatibilität
      zu alten Daten beibehalten. }
    DomCommands := DOMWinData.childNodes.findNode('commands', '');
    If DomCommands <> Nil then
      CmdString := DomCommands.nodeValue;

    act_PixelPerXcm := org_ScrWidth  / (org_xMax - org_xMin);
    act_PixelPerYcm := org_ScrHeight / (org_yMax - org_yMin);
    Fe1x :=  act_PixelPerXcm;
    Fe1y :=  0;
    Fe2x :=  0;
    Fe2y := -act_PixelPerYcm;
    FWindowOrigin.X := Round(-org_xMin * Fe1x);
    FWindowOrigin.Y := Round(-org_yMax * Fe2y);

    Self.ActualizeWindowsConstants;
    end;

  procedure GetObjListFrom(DOMObjList: IXMLNode);
    var domObj     : IXMLNode;
        TypName    : String;
        TypRef     : TGeoObjClass;
        NewObj,
        UnknownObj : TGeoObj;
        IsDeprec   : Boolean;
        num        : Integer;
    begin
    domObj := DOMObjList.childNodes.First;
    While domObj <> Nil do begin           // Objektliste aufbauen
      try
        TypName := Get_ClassName(domObj.nodeName, IsDeprec);
        typRef  := TGeoObjClass(FindClass(TypName));
        Assert(typRef <> Nil, 'Unknown type name "' + TypName +'"');
        NewObj  := typRef.CreateFromDomData(Self, domObj);
        Add(NewObj);
        If IsDeprec then
          DeprecList.Add(NewObj);
      except
        UnknownObj := TGUnknown.CreateFromDomData(Self, domObj);
        Add(UnknownObj);
        SpyOut('Unknown type: %s ;    Name: %s', [TypName, UnknownObj.GetName]);
      end;
      LastValidObjIndex := Pred(Count);    // = -1  für eine leere Liste
      domObj := DOMObjList.childNodes.findSibling(domObj, 1);
      end;

    If DOMObjList.hasAttribute('ani_source') then begin  // Animation
      num := StrToInt(DOMObjList.getAttribute('ani_source'));
      FAnimationSource := GetValidObj(num) as TGParentObj;
      If (FAnimationSource <> Nil) and
         (FAnimationSource.AniStep < epsilon) then
        with FAnimationSource do
          SetAniParams(AniMinValue, AniValue, AniMaxValue, DefAniStep);
      end
    else
      AnimationSource := Nil;
    FNextGeoNum := CalculateNextFreeGeoNum;
    end;

  var node : IXMLNode;
      i    : Integer;
  begin
  Inherited Create;
  HostWinHandle := oldDrawing.HostWinHandle;
  FWindowRect   := oldDrawing.WindowRect;
  Fe1x          := oldDrawing.e1x;
  Fe1y          := oldDrawing.e1y;
  Fe2x          := oldDrawing.e2x;
  Fe2y          := oldDrawing.e2y;
  IsLoading     := True;  // nötig oder überflüssig ???
  IsBlinkOn     := False;
  OutputStatus  := outScreen;
  CRText        := TStringList.Create;
  DragList      := TObjPtrList.Create(False);
  GroupList     := TGeoGroupList.Create;
  GroupList.Initialize(oldDrawing.GroupList.WinHandle,
                       oldDrawing.GroupList.OnClick,
                       oldDrawing.GroupList.ItemSpace);
  MakroList     := TMakroList.Create;
  LengthUnit    := DefLengthUnit;
  AreaUnit      := DefAreaUnit;
  AngleUnit     := DefAngleUnit;
  DragStrategy  := DefDragStrategy;
  StartFont     := TFont.Create;  // Initialisierung in GetWindowDataFrom()

  node := DOMTree.ChildNodes.FindNode('header', '');
  if Assigned(node) then
    GetHeaderDataFrom(node);
  node := DOMTree.ChildNodes.FindNode('windowdata', '');
  if Assigned(node) then
    GetWindowDataFrom(node);

  TakeCanvasFrom(oldDrawing);
  OldAngleTermCount := 0;
  DeprecList := TList.Create;
  try
    if Assigned(node) then begin
      node := DOMTree.ChildNodes.FindNode('objlist', '');
      GetObjListFrom(node);
      For i := 0 to Pred(Count) do             { In allen Verwandschaftslisten }
        TGeoObj(Items[i]).RebuildPointers;     {   Handles in Pointer umsetzen }
      For i := 0 to Pred(DeprecList.Count) do
        ConvertOldMappedObj2NewMappingObj(DeprecList[i]);
      DeprecList.Clear;
      end;
  finally
    DeprecList.Free;
  end; { of try }

  node := DOMTree.childNodes.findNode('grouplist', '');
  If node <> Nil then
    GroupList.LoadGroupsFromXML(Self, node);
  AnimationRunning  := False;
  OutputStatus      := outScreen;
  end;


procedure TGeoObjListe.AfterLoading(FromXML : Boolean = True);
  var OldCount,
      i      : Integer;
      error  : Boolean;
      ActObj : TGeoObj;
  begin
  error    := False;
  OldCount := Count;
  { Der folgende Code stellt sicher, dass Namensobjekte in den Children-
    Listen immer als erste aufgeführt werden; außerdem repariert er "alte"
    Dateien, in denen die neue Namens-Verwaltung mit den Eigenschaften
    "ShowNameInNameObj" und "ShowDataInNameObj" noch nicht korrekt geklappt
    hat.
    2011-11-04: Die ursprünglich verwendete Versions-Kontroll-Bedingung
                "If IsEarlierVersionThan(GeoFileVersion, '3.6.0.0') then...."
                wurde entfernt, weil sie zur Folge hatte, dass der Check nur
                bei "alten" Daten durchgeführt wurde [Fehlermeldung vom
                09.09.2011 von Frau Friebe, Datei: Namensproblem1.geo)     }
  For i := 0 to Pred(Count) do begin
    ActObj := TGeoObj(Items[i]);
    ActObj.Children.BringNameObjToListStart;
    if (ActObj.ShowNameInNameObj = False) and
       (ActObj.Children.Count > 0) and
       (TGeoObj(ActObj.Children.Items[0]) is TGName) then
      ActObj.FShowNameInNameObj := True; // TGeoObj(ActObj.Children.Items[k]).DataValid;
    end;
  { Parent-Links auf Gültigkeit überprüfen; falls nötig kann in der Boole'schen
    Funktion [GeoObj-Type].ParentLinksAreOkay() für die einzelnen GeoObj-Typen
    eine strenge Typ-Prüfung nachgerüstet werden, wie dies für TGIntersectPt
    schon geschehen ist. }
  i := 0;
  While i < Count do begin
    ActObj := TGeoObj(Items[i]);
    if ActObj.ParentLinksAreOkay then
      i := i + 1
    else begin
      ActObj.DataValid := False;
      FreeObject(ActObj);
      error := True;
      end;
    end;

  { Spezialprobleme der einzelnen Klassen beackern, wie z.B. die
       Umsetzung alter DEG/RAD-Termbäume ins Only-RAD-Format :    }
  i := -1;
  While i < Pred(Count) do
    try
      i := i + 1;
      TGeoObj(Items[i]).AfterLoading(FromXML);
    except
      TGeoObj(Items[i]).DataValid := False;
      // FreeObject(Items[i]);
      error := True;
    end; { of try }

  IsLoading := False;  { Jetzt ist der Ladevorgang abgeschlossen. }

  { Nun können auch die Bindungsparameter aktualisiert werden,
    sofern die Träger-Objekte schon gültig sind :                 }
  i := 0;
  While i < Count do
    try
      TGeoObj(Items[i]).UpdateParams;
      { Zusätzlich wird bei alten Dateien die Orientierung der
        neu erzeugten Doppelpunkte überprüft und gegebenenfalls
        korrigiert :                                              }
      If (Not FromXML) and  // Nur beim Import ALTER Dateien (vor 2.7 !)
         (TGeoObj(Items[i]) is TGDoubleIntersection) then
        TGDoubleIntersection(Items[i]).CheckOrientation;
      i := i + 1;
    except
      TGeoObj(Items[i]).DataValid := False;
      FreeObject(Items[i]);
      error := True;
    end; { of try }

  { Stellt bei Flächenrändern ein, ob die Fläche als Ganzes verschiebbar ist }
  For i := 0 to Pred(Count) do
    If TGeoObj(Items[i]) is TGLine then
      TGLine(Items[i]).Set_CBDI;

 { Sorgt dafür, dass Winkelnamen "echte Griechen" enthalten  }
  If CreationVers < '3.2.0.10' then
    For i := 0 to Pred(Count) do
      if TGeoObj(Items[i]) is TGAngle then
        TGAngle(Items[i]).UpdateOldNameData;

  If error and (Count < OldCount) then
    MessageDlg(Format(MyStartMsg[30], [IntToStr(Count), IntToStr(OldCount)]),
               mtWarning, [mbOK], 0);

  If FromXML then begin
    If Length(OldValidationCondition) > 0 then begin
      InsertObject(TGCheckControl.Create(Self, OldValidationCondition,
                                         OldValidationVars, OldValidationHint),
                   i);
      OldValidationCondition := '';
      OldValidationVars      := '';
      OldValidationHint      := '';
      end;
    SendMessage(HostWinHandle, cmd_ExternCommand, cmd_GroupsChanged, 3);
    end;
  end;

procedure TGeoObjListe.RebuildAllPointers;
  var i, j : Integer;
      List : TGeoObjListe;
  begin
  List := Self;
  For i := 0 to Pred(Count) do
    with TGeoObj(Items[i]) do begin
      ObjList := List;
      For j := 0 to Pred(Parent.Count) do
        Parent.Items[j] := GetObj(Integer(Parent.Items[j]));
      Parent.Pack;
      For j := 0 to Pred(Children.Count) do
        Children.Items[j] := GetObj(Integer(Children.Items[j]));
      Children.Pack;
      If TGeoObj(Items[i]) is TGPoint then
        with TGPoint(Items[i]) do begin
          For j := 0 to Pred(Friends.Count) do
            Friends.Items[j] := GetObj(Integer(Friends.Items[j]));
          Friends.Pack;
          end;
      end;

  For i := 1 to 2 do         { Achsen sind vom Ursprung "abgeleitet"! }
    If TGeoObj(Items[i]).Parent.Count = 0 then
      TGeoObj(Items[i]).BecomesChildOf(Items[0]);

  If FAnimationSource <> Nil then
    FAnimationSource := TGNumberObj(GetObj(Integer(FAnimationSource)));
  end;


procedure TGeoObjListe.TakeCanvasFrom(source: TGeoObjListe);
  begin
  FActCanvas        := source.ActCanvas;
  FTargetCanvas     := source.ActCanvas;
  FDoubleBuffered   := False;
  source.FActCanvas := Nil;
  IsDoubleBuffered  := source.IsDoubleBuffered;
  end;


function TGeoObjListe.CreateHeaderNode(DOMDoc: IXMLDocument): IXMLNode;
  var created, edited, copyright, environment, commands,
      links : IXMLNode;
      s     : String;
  begin
  Result := DOMDoc.createNode('header');

  created := DOMDoc.createNode('created');
  If Length(CreationProg) = 0 then
    CreationProg := 'EUKLID DynaGeo';
  created.setAttribute('prog_name', CreationProg);
  If Length(CreationVers) = 0 then
    CreationVers := FullVersionString(Application.ExeName);
  If Length(CreationVers) > 0 then
    created.setAttribute('prog_version', CreationVers);
  If (Length(CreationDate) = 0) and
     (CreationVers = FullVersionString(Application.ExeName)) then
    DateTimeToString(CreationDate, 'yyyy"-"mm"-"dd"T"hh":"nn":"ss', Now);
  If Length(CreationDate) > 0 then
    created.setAttribute('date', CreationDate);
  Result.childNodes.add(created);

  edited := DOMDoc.createNode('edited');
  if IsActiveX then begin
    edited.setAttribute('prog_name', 'DynaGeoX');
    edited.setAttribute('prog_version', AXVersionStr);
    end
  else begin
    edited.setAttribute('prog_name', 'EUKLID DynaGeo');
    s := FullVersionString(Application.ExeName);
    edited.setAttribute('prog_version', s);
    end;
  DateTimeToString(s, 'yyyy"-"mm"-"dd"T"hh":"nn":"ss', Now);
  edited.setAttribute('date', s);
  Result.childNodes.add(edited);

  If (CRText <> Nil) and (Length(CRText.Text) > 0) then begin
    copyright := DOMDoc.createNode('copyright');
    copyright.setAttribute('sign_code', IntToStr(CRNr XOR GeoFileCRMask));
    copyright.nodeValue := CRText.Text;
    Result.childNodes.add(copyright);
    end;

  environment := DOMDoc.createNode('environment');
  { Hier wurde früher der Knoten "validation" eingefügt. Seit der
    Version 3.0.0.274 wurden die Daten der Korrektheitsprüfung in
    ein eigenes TGCheckControl-Objekt ausgelagert.                }
  If Length(CmdString) > 0 then begin
    commands := DOMDoc.createNode('commands');
    commands.nodeValue := CmdString;
    environment.childNodes.add(commands);
    end;
  If (Length(LinkForward) > 0) or
     (Length(LinkBack) > 0) then begin
    links := DOMDoc.createNode('links');
    If Length(LinkForward) > 0 then
      links.setAttribute('forward', LinkForward);
    If Length(LinkBack) > 0 then
      links.setAttribute('back', LinkBack);
    environment.childNodes.add(links);
    end;
  If environment.hasChildNodes then
    Result.childNodes.add(environment)
  else
    environment := Nil; // ToDo: Funktioniert das? Versuchsweise so !
  end;


function TGeoObjListe.CreateWindowNode(DOMDoc    : IXMLDocument;
                                       ValTabData: TValTabData ): IXMLNode;
  var log_window, scr_window,
      back_col, val_tab,
      start_font, options : IXMLNode;
  begin
  Result := DOMDoc.createNode('windowdata');

  log_window := DOMDoc.createNode('log_window');
  log_window.setAttribute('xmin', FloatToStr(xmin));
  log_window.setAttribute('xmax', FloatToStr(xmax));
  log_window.setAttribute('ymin', FloatToStr(ymin));
  log_window.setAttribute('ymax', FloatToStr(ymax));
  Result.childNodes.add(log_window);

  scr_window := DOMDoc.createNode('scr_window');
  scr_window.setAttribute('width',  IntToStr(WindowRect.Right - WindowRect.Left));
  scr_window.setAttribute('height', IntToStr(WindowRect.Bottom - WindowRect.Top));
  Result.childNodes.add(scr_window);

  If BackgroundColor <> clWhite then begin
    back_col := DOMDoc.createNode('back_col');
    back_col.nodeValue := '$' + IntToHex(BackgroundColor, 8);
    Result.childNodes.add(back_col);
    end;

  If Assigned(ValTabData) then begin
    val_tab := DOMDoc.createNode('ValTabData');
    val_tab.setAttribute('visible', BoolToStr(ValTabData.vis));
    val_tab.setAttribute('xmin', ValTabData.xmin);
    val_tab.setAttribute('xmax', ValTabData.xmax);
    val_tab.setAttribute('dx', ValTabData.dx);
    val_tab.setAttribute('marked', ValTabData.marked);
    val_tab.setAttribute('left', IntToStr(ValTabData.rect.Left));
    val_tab.setAttribute('top', IntToStr(ValTabData.rect.Top));
    val_tab.setAttribute('right', IntToStr(ValTabData.rect.Right));
    val_tab.setAttribute('bottom', IntToStr(ValTabData.rect.Bottom));
    Result.childNodes.add(val_tab);
    end;

  start_font := DOMDoc.createNode('startfont');
  start_font.setAttribute('fontname', StartFont.Name);
  start_font.setAttribute('fontsize', IntToStr(StartFont.Size));
  If StartFont.Charset <> 1 then
    start_font.setAttribute('fontcharset', IntToStr(Integer(StartFont.Charset)));
  If fsBold in StartFont.Style then
    start_font.setAttribute('attr_bold', LowerCase(BoolToStr(True, True)));
  If fsItalic in StartFont.Style then
    start_font.setAttribute('attr_italic', LowerCase(BoolToStr(True, True)));
  If fsUnderline in StartFont.Style then
    start_font.setAttribute('attr_underline', LowerCase(BoolToStr(True, True)));
  If fsStrikeOut in StartFont.Style then
    start_font.setAttribute('attr_strikeout', LowerCase(BoolToStr(True, True)));
  Result.childNodes.add(start_font);

  options := DOMDoc.createNode('options');
  If LengthDecimals <> 3 then
    options.setAttribute('LengthDecimals', IntToStr(LengthDecimals));
  If AreaDecimals <> 2 then
    options.setAttribute('AreaDecimals', IntToStr(AreaDecimals));
  If AngleDecimals <> 0 then
    options.setAttribute('AngleDecimals', IntToStr(AngleDecimals));
  If LengthUnit <> DefLengthUnit then
    options.setAttribute('LengthUnit', LengthUnit);
  If AreaUnit <> DefAreaUnit then
    options.setAttribute('AreaUnit', AreaUnit);
  If AngleUnit <> DefAngleUnit then
    options.setAttribute('AngleUnit', AngleUnit);
  If Not SignedAngles then
    options.setAttribute('SignedAngles', LowerCase(BoolToStr(False, True)));
  If DefLocLineStyle <> 7 then
    options.setAttribute('DefLocLineStatus', IntToStr(NewLocLineStatus));
  If options.AttributeNodes.Count > 0 then
    Result.childNodes.add(options)
  else
    options := Nil; // ToDo: Geht das? Versuchsweise so implementiert!
  end;


function TGeoObjListe.CreateObjListNode(DOMDoc    : IXMLDocument;
                                        Check4JExp: Boolean    ): IXMLNode;
  procedure MarkAllUnexportableObjs;
    var GO : TGeoObj;
        i  : Integer;
    begin
    ResetAllMarks;
    if Check4JExp then
      For i := 0 to LastValidObjIndex do begin
        GO := Items[i];
        if Not canJexport(GO) then
          GO.IsMarked := True;
        end;
    end;

 var child : IXMLNode;
      GO : TGeoObj;
      i : Integer;
  begin
  SortObjects;  // Damit alle Eltern *vor* ihren Kindern in der Liste stehen !
  Result := DOMDoc.createNode('objlist');
  If AnimationSource <> Nil then
    Result.setAttribute('ani_source', IntToStr(AnimationSource.GeoNum));
  MarkAllUnexportableObjs;
  For i := 0 to LastValidObjIndex do begin
    GO := TGeoObj(items[i]);
    If Not GO.IsMarked then begin
      child := GO.CreateObjNode(DOMDoc);
      If child <> Nil then
        Result.childNodes.add(child);
      end;
    end;
  If Check4JExp then ResetAllMarks;
  end;


{ Für Num < 0 liefern die beiden folgenden Funktion derzeit effektiv
  nur NIL. Der aufgeplusterte "else"-Teil ist für spätere Erweiterungen
  des TGCheckControl-Objekts vorgesehen, bei denen dieses die Zielobjekte
  der Konstruktion zurückliefert. Dazu muss die Implementierung von
  TGCheckControl.GetVarObj() entsprechend erweitert werden. }

function TGeoObjListe.GetObj(Num : Integer): TGeoObj;
  var CCO : TGCheckControl;
      i   : Integer;
  begin
  Result := Nil;
  If Num > 0 then begin
    i := Pred(Count);
    While (i >= 0) and (Result = Nil) do
      If TGeoObj(Items[i]).GeoNum = Num then
        Result := Items[i]
      else
        Dec(i);
    end
  else begin
    CCO := GetCheckControl as TGCheckControl;
    If Assigned(CCO) then
      Result := CCO.GetVarObj(Abs(Num));
    end;
  end;


function TGeoObjListe.GetValidObj(Num : Integer): TGeoObj;
  { Achtung! Der Name der Funktion ist irreführend!
    Es wird genau dann ein Objekt zurückgegeben, wenn unter den Objekten
    der Liste eines gefunden wird, dessen GeoNum mit der übergebenen Num
    übereinstimmt. Ob das Objekt gültig ist oder nicht, spielt dabei
    keine Rolle!                                                        }
  var CCO : TGCheckControl;
      i   : Integer;
  begin
  Result := Nil;
  If Num > 0 then begin
    i := LastValidObjIndex;
    While (i >= 0) and (Result = Nil) do
      If TGeoObj(Items[i]).GeoNum = Num then
        Result := Items[i]
      else
        Dec(i);
    end
  else begin
    CCO := GetCheckControl as TGCheckControl;
    If Assigned(CCO) then
      Result := CCO.GetVarObj(Abs(Num));
    end;
  end;


function TGeoObjListe.GetGeoObjByName(s: WideString): TGeoObj;
  { sucht ein Objekt, das als Namen das erste Wort in s hat;
    führende Leerzeichen werden unterdrückt, nach dem ersten Wort
    *muss* ein "delimiter"-Zeichen kommen, z.B. ein Leerzeichen }
  var mask,
      ns    : WideString;
      NO    : TGName;
      n, i  : Integer;

  begin
  Result := Nil;                   { Kein Objekt gefunden }
  If Length(s) > 0 then begin      { String darf nicht leer sein }
    While CharInSet(s[1], delimiters) do
      System.Delete(s, 1, 1);         { Führende Leerzeichen entfernen }
    If Length(s) > 0 then begin       { String darf nicht leer sein }
      i := 1;
      While (i <= Length(s)) and
             Not CharInSet(s[i], delimiters) do
        Inc(i);                          { Gültige Zeichen abtasten }
      If i <= Length(s) then
        ns := Copy(s, 1, Pred(i))        { Ungültigen Rest abschneiden }
      else
        ns := s;
      i := 0;
      While (i <= LastValidObjIndex) and (Result = Nil) do
        If TGeoObj(Items[i]).Name = ns then   { Passendes Objekt suchen }
          Result := TGeoObj(Items[i])
        else
          Inc(i);
      If Result = Nil then begin
        n    := Length(MyObjTxt[16]) - 2;
        mask := Copy(MyObjTxt[16], 1, n);
        If Pos(mask, s) = 1 then begin
          ns := Copy(s, n + 1, Length(s) - n);
          While (Length(ns) > 0) and (ns[1] = ' ') do System.Delete(ns, 1, 1);
          If Length(ns) > 0 then begin
            For i := Length(ns) downTo 1 do
              If Not IsNameChar(ns[i]) then
                System.Delete(ns, i, 1);
            If Length(ns) > 0 then begin
              NO := Nil;
              i  := 0;
              While (i <= LastValidObjIndex) and (Result = Nil) do
                If TGeoObj(Items[i]).Name = ns then   { Passendes Objekt suchen }
                  Result := TGeoObj(Items[i])
                else
                  Inc(i);
              If Result <> Nil then
                If Result.HasNameObj(NO) then
                  Result := NO
                else
                  Result := Nil;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

function TGeoObjListe.GetGeoObjNumByName(s: WideString): Integer;
  { Liefert die GeoNum desjenigen Objekts der Liste zurück,
    dessen Name am Anfang des Strings s steht. Falls dort jedoch
    ein Variablen-Name der Form "@n" steht mit einer natürlichen
    Zahl "n", dann wird das negative dieser Zahl zurückgegeben.  }
  var GO : TGeoObj;
      zs : String;
  begin
  GO := GetGeoObjByName(s);
  If GO <> Nil then
    Result := GO.GeoNum
  else begin
    Result := 0;   // ungültige Geo-Nummer !
    While (Length(s) > 0) and CharInSet(s[1], delimiters) do
      System.Delete(s, 1, 1);         { Führende Leerzeichen entfernen }
    If (Length(s) > 0) and (s[1] = '@') then begin
      System.Delete(s, 1, 1);
      zs := '';
      While (Length(s) > 0) and CharInSet(s[1], DecimalDigits) do begin
        zs := zs + s[1];
        System.Delete(s, 1, 1);
        end;
      If Length(zs) > 0 then
        Result := - StrToInt(zs);
      end;
    end;
  end;

function TGeoObjListe.GetLogSlider: TGLogSlider;
  var res     : TGLogSlider;
      err_num,
      i       : Integer;
  begin
  res := Nil;
  for i := 0 to LastValidObjIndex do
    if (TGeoObj(items[i]) is TGLogSlider) and
       (TGeoObj(items[i]).Name = 'h') then begin
      res := TGeoObj(items[i]) as TGLogSlider;
      if (res.MinValue < mathLib.epsilon) then
        res := Nil;
      end;
  if res = Nil then begin
    res := TGLogSlider.Create(Self, 150, 0.0001, 1.000, 1.000, true);
    if res <> Nil then begin
      res := Self.InsertObject(res, err_num) as TGLogSlider;
      res.SetNewName('h');
      end;
    end;
  Result := res;
  end;

function  TGeoObjListe.Get_XMLTypeName(Class_TypeName: String): String;
  var i : Integer;
  begin
  i := 0;
  Repeat
    Inc(i);
  until (i > MaxXMLTypeIndex) or (XMLTypeNames[i, 0] = Class_TypeName);
  If i <= MaxXMLTypeIndex then
    Result := XMLTypeNames[i, 1]
  else
    Result := '';
  end;

function  TGeoObjListe.Get_ClassName(XML_TypeName: String; var IsDeprecated: Boolean): String;
  var i : Integer;
  begin
  i := 0;
  Repeat
    Inc(i);
  until (i > MaxXMLTypeIndex) or (XMLTypeNames[i, 1] = XML_TypeName);
  If i <= MaxXMLTypeIndex then begin
    IsDeprecated := i >= DeprTypeIndex;
    Result := XMLTypeNames[i, 0];
    end
  else begin
    IsDeprecated := False;
    Result := '';
    end;
  end;

function TGeoObjListe.GetDefAngleMode: AngleModeTyp;
  begin
  if self.IsOldDegRadProblemVersion then
    Result := Deg
  else
    Result := Rad;
  end;

function TGeoObjListe.CalculateNextFreeGeoNum: Integer;
  var i : Integer;
  begin
  Result := Succ(TGeoObj(Last).GeoNum);
  For i := Pred(Count) downTo 0 do
    If Result <= TGeoObj(Items[i]).GeoNum then
      Result := Succ(TGeoObj(Items[i]).GeoNum);
  end;

function  TGeoObjListe.GetNextGeoNum: Integer;
  { Stellt sicher, dass jede Instanz von TGeoObj in dem
    Datenfeld (F)GeoNum eine eindeutige Kennung erhält. }
  begin
  Result := FNextGeoNum;
  Inc(FNextGeoNum);
  end;

function TGeoObjListe.GetUniqueName(s: WideString): WideString;
 { Der neue Name darf bei *keinem* der aktiven Objekte schon verwendet
   worden sein, -- und seit 15.12.99 auch bei keinem gelöschten ! }
  var pu   : WideString;
      n, i : Integer;
  begin
  If IsLoading then
    n  := NameNumList.GetNextFreeSuffixOf(s)
  else
    n := 1;
  pu := IntToStr(n);
  i  := 0;
  While i < Count do
    If TGeoObj(Items[i]).Name = s + pu then begin
      Inc(n);
      pu := IntToStr(n);
      i  := 0;
      end
    else
      Inc(i);
  If IsLoading then
    NameNumList.SetNextFreeSuffixOf(s, Succ(n));
  Result := s + pu;
  end;


function TGeoObjListe.GetAniCtrlObjCount: Integer;
  var i, n : Integer;
  begin
  n := 0;
  For i := 0 to LastValidObjIndex do
    If (TGeoObj(Items[i]) is TGParentObj) and
       (TGParentObj(Items[i]).CanControlAnimation) then
      Inc(n);
  Result := n;
  end;

function TGeoObjListe.GetAniPossible: Boolean;
  begin
  Result := GetAniCtrlObjCount > 0;
  end;

function TGeoObjListe.GetCheckControl: TGeoObj;
  var i : Integer;
  begin
  Result := Nil;
  For i := LastValidObjIndex downto 5 do
    If TGeoObj(Items[i]) is TGCheckControl then
      Result := ITems[i];
  end;

function TGeoObjListe.GetFreePlace4NewNumber: TPoint;
  var RNew,           { neues Rechteck }
      REx,            { schon existierendes TGNumber-Rechteck }
      RInt : TRect;   { Rechenpuffer }
      n, i : Integer;
  begin
  RNew := Rect(20, 20, 170, 52);   { Standardmaße: 150 x 32 }
  i := 5;
  While i <= LastValidObjIndex do begin
    If TGeoObj(Items[i]) is TGNumber then begin
      REx := TGNumber(Items[i]).ObjRect;
      If IntersectRect(RInt, RNew, REx) then begin
        RNew.Top  := REx.Bottom + 10;  { Neues Rechteck unterhalb des }
        RNew.Bottom := RNew.Top + 32;  {  schon vorhandenen plazieren }
        If RNew.Bottom > WindowRect.Bottom then begin
          n := RNew.Left + 150;
          RNew := Rect(n, 20, n + 150, 52);
          end;
        i := 4;       { Suche nach Überlappungen von vorne beginnen ! }
        end;
      end;
    i := i + 1;
    end;
  Result := RNew.TopLeft;
  end;

function TGeoObjListe.HiddenObjCount: Integer;
  var i : Integer;
  begin
  Result := 0;
  For i := 5 to LastValidObjIndex do
    If TGeoObj(Items[i]).DataValid and
       (Not TGeoObj(Items[i]).IsVisible) then
      Result := Result + 1;
  end;

function TGeoObjListe.ExistObject(GO: TGeoObj; var FoundObj: TGeoObj): Boolean;
  var i : Integer;
  { 06.10.00 : Jetzt: "GO.HasSameDataAs(Items[i])" in der Schleife
               statt: "TGeoObj(Items[i]).HasSameDataAs(GO)" !!!
               Dies wurde nötig durch Probleme mit verschobenen Punkten,
               deren Mehrfacherzeugung verhindert werden sollte.
    10.04.07 : Inzwischen ist es für einige Objekt-Klassen (wie z.B.
               TGRegPoly) absolut nötig, dass die Routine HasSameDataAs()
               stets vom neuen Objekt (also GO) aufgerufen wird. Die Ini-
               tialisierungs-Routinen für neue Objekte (wie GO) verlassen
               sich nun immer darauf, dass die als Argumente übergebenen
               TGeoObj(Items[i]) stets vollständig fertige Objekte sind,
               was auf GO hingegen nicht unbedingt zutreffen muss.       }
  begin
  Result := False;
  i := 0;
  While (i < Count) and (Not Result) do
    If GO.HasSameDataAs(Items[i]) then begin
      Result   := True;
      FoundObj := TGeoObj(Items[i]);
      end
    else
      Inc(i);
  end;

function  TGeoObjListe.DynaGeoJKnows(Class_TypeName: String): Boolean;
  var i : Integer;
  begin
  i := 0;
  Repeat
    Inc(i);
  until (i > MaxXMLTypeIndex) or (XMLTypeNames[i, 0] = Class_TypeName);
  If i <= MaxXMLTypeIndex then
    Result := XMLTypeNames[i, 2] = 'true'
  else
    Result := false;
  end;

function TGeoObjListe.NameAlreadyUsed(suggest: String; obj2name: TGeoObj): Boolean;
  var i : Integer;
  begin
  Result := False;
  For i := 0 to LastValidObjIndex do
    If (TGeoObj(Items[i]).Name = suggest) and
       (obj2name.InheritsFrom(TGeoObj(Items[i]).ClassType) or
        TGeoObj(Items[i]).InheritsFrom(obj2name.ClassType)) then
      Result := True;
  end;

function TGeoObjListe.CoSysVisible: Boolean;
  var i : Integer;
  begin
  Result := True;
  For i := 0 to 2 do
    If Not TGeoObj(Items[i]).IsVisible then
      Result := False;
  end;

function TGeoObjListe.CoSysInVisGroup: Boolean;
  var n, i : Integer;
  begin
  i := 0;
  n := 0;
  While (i <= 2) and (n = 0) do begin
    n := TGeoObj(Items[i]).Groups;
    i := i + 1;
    end;
  Result := n <> 0;
  end;

function TGeoObjListe.HasSetsquare(var SQO: TGeoObj): Boolean;
  var n, i : Integer;
  begin
  n := -1;
  i := 0;
  While (n < 0) and (i < Count) do
    If TGeoObj(Items[i]).ClassType = TGSetsquare then
      n := i
    else
      i := i + 1;
  If n >= 0 then
    SQO := Items[n]
  else
    SQO := Nil;
  Result := n >= 0;
  end;

function TGeoObjListe.HasEmptyBorders: Boolean;
  var i : Integer;

  function HasAreaChild(GO: TGeoObj): Boolean;
    var k : Integer;
    begin
    Result := False;
    For k := 0 to Pred(GO.Children.Count) do
      If TGeoObj(GO.Children.Items[k]) is TGArea then
        Result := True;
    end;

  begin
  Result := False;
  For i := 5 to LastValidObjIndex do
    If (TGeoObj(Items[i]) is TGPolygon) or
       (TGeoObj(Items[i]) is TGCircle) then
      If Not HasAreaChild(Items[i]) then
        Result := True;
  end;


function TGeoObjListe.IsOldDegRadProblemVersion: Boolean;
  begin
  Result := IsEarlierVersionThan(GeoFileVersion, '2.7') or
            ((UpperCase(LastEditProg) = 'EUKLID DYNAGEO') and
             IsEarlierVersionThan(LastEditVers, '3.2.0.240'));
  end;

function TGeoObjListe.GetFixLineLength (P1num, P2num : TGeoObj): Double;
  var i  : Integer;
      pG : TGeoObj;
  begin
  Result := -1;
  For i := 0 to Pred(Count) do begin
    pG := TGeoObj(Items[i]);
    If (pg.ClassType = TGFixLine) and
       ((pG.Parent[0] = P1num) or
        (pG.Parent[0] = P2num)  ) and
       ((pG.Parent[1] = P1num) or
        (pG.Parent[1] = P2num)  ) then begin
      Result := TGFixLine(pG).MyLength;
      Exit;
      end;
    end;
  end;


function TGeoObjListe.CountWinObjsOutside(WinRect, ScrRect: TRect): Integer;
  var nw,  // Anzahl der Zahlobjekte/Textboxen außerhalb des aktuellen Fensters
      ns,  //                 bzw. außerhalb des größtmöglichen Screen-Fensters
      i   : Integer;
      R   : TRect;
  begin
  nw := 0;
  ns := 0;
  For i := 0 to LastValidObjIndex do
    If TGeoObj(Items[i]) is TGNumber then
      If Not IsRectEmpty(TGNumber(Items[i]).ObjRect) then
        If Not IntersectRect(R, ScrRect, TGNumber(Items[i]).ObjRect) then
          Inc(ns)
        else If Not IntersectRect(R, WinRect, TGNumber(Items[i]).ObjRect) then
          Inc(nw)
        else
      else   // nix zu tun ( eigentlich: ungültiges Zahl-Objekt !!! )
    else If TGeoObj(Items[i]) is TGComment then
      If Not IsRectEmpty(TGComment(Items[i]).OutRect) then
        If (TGComment(Items[i]).Parent.Count = 0) and
           Not IntersectRect(R, ScrRect, TGComment(Items[i]).OutRect) then
          Inc(ns)
        else If Not IntersectRect(R, WinRect, TGComment(Items[i]).OutRect) then
          Inc(nw);
  If ns > 0 then
    Result := ns
  else If nw > 0 then
    Result := -nw
  else
    Result := 0;
  end;

procedure TGeoObjListe.Move2UpperLeft(R: TRect);
  var newWO : TPoint;
  begin
  If (R.Left > 0) or (R.Top > 0) then begin
    newWO := WindowOrigin;
    newWO.X := newWO.X - R.Left;
    newWO.Y := newWO.Y - R.Top;
    WindowOrigin := newWO;
    end;
  end;

procedure TGeoObjListe.MoveWinObjsInside(TargetR: TRect);
  var R      : TRect;
      ToLePt : TPoint;
      i      : Integer;
  begin
  For i := 5 to LastValidObjIndex do
    If (TGeoObj(Items[i]) is TGNumber) and
       Not IntersectRect(R, TargetR, TGNumber(Items[i]).ObjRect) then begin
      ToLePt := GetTopLeftOfR2InsideR1(TargetR, TGNumber(Items[i]).ObjRect);
      TGNumber(Items[i]).SetWinPos(ToLePt);
      end
    else
    If (TGeoObj(Items[i]) is TGComment) and
       Not IntersectRect(R, TargetR, TGComment(Items[i]).OutRect) then begin
      ToLePt := GetTopLeftOfR2InsideR1(TargetR, TGComment(Items[i]).OutRect);
      TGNumber(Items[i]).SetWinPos(ToLePt);
      end;
  UpdateAllObjects;
  end;

function TGeoObjListe.LogWinContains(x, y: Double): Boolean;
  { Logische Koordinaten !!! }
  begin
  Result := (x >= xMin) and (x <= xMax) and
            (y >= yMin) and (y <= yMax);
  end;

function TGeoObjListe.LogWinKnows(x, y: Double): Integer;
  { Logische Koordinaten !!!
    Sei d der Abstand des Punktes (x,y) vom Mittelpunkt des aktuellen
    Ausgabefensters, r der Abstand eines Fenstereckpunkts von diesem
    Mittelpunkt.
    Die Funktion liefert
       1  für          d <    r
       0  für     r <= d <  2*r
      -1  für   2*r <= d          }
  var d : Double;
  begin
  d := Hypot(x - FxLWC, y - FyLWC);
  If d < FLWrad then
    Result := 1
  else
    if d < 2 * FLWrad then
      Result := 0
    else
      Result := -1;
  end;

function TGeoObjListe.GetMaxCurveLength: Double;
  begin
  Result := ((FxMax - FxMin) + (FyMax - FyMin)) * 8;
  end;

procedure TGeoObjListe.GetLogWinHorizonEq(var hc: TCoeff6);
  begin
  hc[0] := 1;  hc[1] := 0;  hc[2] := 1;
  hc[3] := -FxLWC;  hc[4] := -FyLWC;
  hc[5] := Sqr(FxLWC) + Sqr(FyLWC) - Sqr(FLWrad);
  end;

procedure TGeoObjListe.GetFWinCoords(x, y: Double; var wx, wy: Double);
  { Wandelt logische Koordinaten in Windows-Fensterkoordinaten    }
  {   mit hoher Genauigkeit (Double!) um                          }
  { Die Achsen müssen parallel zu den Fensterrändern verlaufen !  }
  begin
  wx := WindowOrigin.X + x * e1x;
  wy := WindowOrigin.Y + y * e2y;
  end;

procedure TGeoObjListe.GetWinCoords(x, y: Double; var wx, wy: Integer);
  { Wandelt logische Koordinaten in Windows-Fensterkoordinaten um }
  { Die Achsen müssen parallel zu den Fensterrändern verlaufen !  }
  begin
  wx := SafeRound(WindowOrigin.X + x * e1x);
  wy := SafeRound(WindowOrigin.Y + y * e2y);
  end;

procedure TGeoObjListe.GetLogCoords(x, y: Integer; var lx, ly: Double);
  { Wandelt Windows-Fensterkoordinaten in logische Koordinaten um }
  { Die Achsen müssen parallel zu den Fensterrändern verlaufen !  }
  begin
  lx := ( x - WindowOrigin.X) / e1x;
  ly := ( y - WindowOrigin.Y) / e2y;
  end;

procedure TGeoObjListe.ActualizeWindowsConstants;
  begin
  GetLogCoords(WindowRect.Left, WindowRect.Top, FxMin, FyMax);
  GetLogCoords(WindowRect.Right, WindowRect.Bottom, FxMax, FyMin);
  FxLWC      := (FxMin + FxMax) / 2;
  FyLWC      := (FyMin + FyMax) / 2;
  FLWrad     := Hypot(FxMax - FxLWC, FyMax - FyLWC);
  FScale     := 1.0;
  FFontScale := 0.0;
  FPixDist   := Abs(   1 / Fe1x);
  yAspect    := Abs(Fe2y / Fe1x);  // Relative Größe der y-Einheit in Vielfachen der x-Einheit
  If (FDoubleBuffer <> Nil) and
     (OutputStatus = outScreen) then
    try
      FDoubleBuffer.Width  := WindowRect.Right - WindowRect.Left;
      FDoubleBuffer.Height := WindowRect.Bottom - WindowRect.Top;
    except
      FreeAndNil(FDoubleBuffer);
    end;
  end;

procedure TGeoObjListe.SetWindowOrigin(newOri: TPoint);
  var vx, vy : Double;
      i      : Integer;
  begin
  If (FWindowOrigin.X <> newOri.X) or
     (FWindowOrigin.Y <> newOri.Y) then begin
    FWindowOrigin := newOri;
    ActualizeWindowsConstants;
    For i := 5 to LastValidObjIndex do
      If (TGeoObj(Items[i]) is TGNumber) or
         ((TGeoObj(Items[i]) is TGComment) and
          (TGeoObj(Items[i]).Parent.Count = 0)) then begin
        GetLogCoords(TGeoObj(Items[i]).scrx,
                     TGeoObj(Items[i]).scry,
                     vx, vy);
        TGeoObj(Items[i]).X := vx;
        TGeoObj(Items[i]).Y := vy;
        end;
    UpdateAllObjects;
    end;
  end;

procedure TGeoObjListe.SetWindowRect(newRect: TRect);
  begin
  If (Not EqualRect(WindowRect, newRect)) and
     (Not EqualRect(newRect, Rect(0,0,0,0))) then begin
    FWindowRect := newRect;
    If (OutputStatus = outScreen) and (FDoubleBuffer <> Nil) then
      try
        FDoubleBuffer.Width := newRect.Right - newRect.Left;
        FDoubleBuffer.Height := newRect.Bottom - newRect.Top;
        ClearBitmap(FDoubleBuffer, BackgroundColor);
      except
        FreeAndNil(FDoubleBuffer);
      end;
    ActualizeWindowsConstants;
    UpdateAllObjects;
    end;
  end;

procedure TGeoObjListe.SetAnimationSrc(newAS: TGParentObj);
  begin
  If AnimationSource <> newAS then begin
    FAnimationSource := newAS;
    If (FAnimationSource <> Nil) and
       (FAnimationSource.AniStep < epsilon) then
      with FAnimationSource do
       SetAniParams(AniMinValue, AniValue, AniMaxValue, DefAniStep);
    PostMessage(HostWinHandle, cmd_ExternCommand,
                cmd_Drag, Integer(cmd_AnimaParams));
    end;
  end;

procedure TGeoObjListe.SetDoubleBuffered(db: Boolean);
  begin
  If db <> IsDoubleBuffered then begin
    If db then begin
      Try
        If Not Assigned(FDoubleBuffer) then begin
          FDoubleBuffer := TBitmap.Create;
          FDoubleBuffer.HandleType := bmDDB;
          end;
        FDoubleBuffer.Width := FWindowRect.Right - FWindowRect.Left;
        FDoubleBuffer.Height := FWindowRect.Bottom - FWindowRect.Top;
        FTargetCanvas   := FDoubleBuffer.Canvas;
        FDoubleBuffered := True;
      except
        FreeAndNil(FDoubleBuffer);
        FDoubleBuffered := False;
        FTargetCanvas   := ActCanvas;
      end; { of case }
      end
    else begin
      FreeAndNil(FDoubleBuffer);
      FDoubleBuffered := False;
      FTargetCanvas   := ActCanvas;
      end;
    ActualizeWindowsConstants;
    end;
  end;

procedure TGeoObjListe.SetIsLoading(newVal: Boolean);
  begin
  If IsLoading <> newVal then
    If newVal then begin
      FIsLoading := True;
      NameNumList := TNameNumList.Create;
      end
    else begin
      FIsLoading := False;
      NameNumList.Free;
      NameNumList := Nil;
      end;
  end;

procedure TGeoObjListe.SetOutputStatus(nos: TOutputStatus);
  begin
  If FOutputStatus <> nos then begin
    FOutputStatus    := nos;
    IsDoubleBuffered := (OutputStatus = outScreen) and Double_Buffered;
    If IsDoubleBuffered then
      FTargetCanvas := DoubleBuffer.Canvas
    else
      FTargetCanvas := ActCanvas;
    end;
  end;

procedure TGeoObjListe.SetNewLLStatus(nv: Integer);
  begin
  If nv <> NewLocLineStatus then begin
    If nv < 0 then begin  { Default-Werte aus globalen Variablen laden }
      nv := 0;
      If DefLocLineStyle < 2 then nv := nv + ols_IsSpline;
      If LocLinesDynamic     then nv := nv + ols_IsDynamic;
      If LocLinesStandard    then nv := nv + ols_TryStandard;
      end;
    FNewLLStatus := nv; { Neuen Wert aus nv setzen }
    end;
  end;

procedure TGeoObjListe.InitScale(new_ppcmx, new_ppcmy: Double; newOri: TPoint; newRect: TRect);
  begin
  Fe1x :=   new_ppcmx;
  Fe1y :=   0;
  Fe2x :=   0;
  Fe2y := - Abs(new_ppcmy);
  FWindowOrigin := newOri;
  FWindowRect   := newRect;
  ActualizeWindowsConstants;
  // UpdateAllObjects;  { Nie aktivieren! Führt in 2.7 zu Katastrophen! }
  end;

procedure TGeoObjListe.LockAllImages;
  var i : Integer;
  begin
  For i := 0 to LastValidObjIndex do
    If TGeoObj(Items[i]) is TGImage then
      TGImage(Items[i]).IsLocked := True;
  end;

procedure TGeoObjListe.SetLastMousePos(newPos: TPoint);
  var newLMM : TPoint;
      z      : Integer;
  begin
  newLMM.X := newPos.X - LastMousePos.X;
  newLMM.Y := newPos.Y - LastMousePos.Y;
  z := newLMM.X * LastMouseMove.X + newLMM.Y * LastMouseMove.Y;
  If (Abs(z)) < 0.1 then FMouseGoes := NoMove
  else if z > 0 then FMouseGoes := ForwardMove
  else               FMouseGoes := BackMove;
  FLastMouseMove := newLMM;
  LogLastMouse_dx := LastMouseMove.X / e1x;
  LogLastMouse_dy := LastMouseMove.Y / e2y;
  GetLogCoords(newPos.X, newPos.Y, LogLastMouse_X, LogLastMouse_Y);
  FLastMousePos  := newPos;
  end;

procedure TGeoObjListe.GetFreeFillPattern(var col: TColor; var FillStyle: TBrushStyle);
  var ColNum, i : Integer;
  begin
  ColNum := 2;
  While (ColNum <= 8) and (col <> ColorTable[ColNum]) do
    Inc(ColNum);
  If ColNum > 8 then begin
    ColNum := 2;
    col := ColorTable[ColNum];
    end;
  i := 5;
  FillStyle := bsHorizontal;
  While i <= LastValidObjIndex do
    with TGeoObj(Items[i]) do
      If (InheritsFrom(TGPolygon) or InheritsFrom(TGArea)) and
         (MyColour = ColorTable[ColNum]) and
         (MyBrushStyle = FillStyle) then begin
        If FillStyle < bsDiagCross then
          Inc(FillStyle)
        else begin
          FillStyle := bsHorizontal;
          If ColNum = 0 then
            ColNum := 2       { grau auslassen }
          else
            Inc(ColNum);
          If ColNum > 7 then begin         { Alles schon verbraucht ? }
            col := ColorTable[Random(8)];  { Dann: Zufallsauswahl !   }
            FillStyle := TBrushStyle(2 + Random(6));
            Exit;
            end
          else
            col := ColorTable[ColNum];
          end;
        i := 5;
        end
      else
        Inc(i);
  end;

function TGeoObjListe.LinksOkay: Boolean;
  var LiOk : Boolean;
      n : Integer;

  procedure CheckLinks(item : TGeoObj);
    var i  : Integer;
    begin
    With item do begin
      For i := 0 to 2 do
        If (Parent.Count > i) and    { Nichtexistente Eltern sind fatal.    }
           (Parent[i] = Nil) then    {   Hier gibt es keine Rettung.        }
          LiOk := False;
      For i := Pred(Children.Count) downto 0 do  { Schleife  m u ß  abwärts laufen !!!  }
        If Children.Items[i] = Nil then begin    { Einträge von nichtexistenten Kindern }
          Children.Delete(i);                    {   werden (einfach!) gelöscht.        }
          LiOk := False;
          end;
      Children.Pack;
      end;
    end;

  begin
  LiOk := True;
  For n := 0 to Pred(Count) do CheckLinks(Items[n]);
  LinksOkay := LiOk;
  end;


procedure TGeoObjListe.InitCoordSys(ixs0, iys0: Integer; iNewWinRect: TRect;
                                    iType: Integer; iis_visible: Boolean);
  var i: Integer;
  begin
  InitScale(ScreenPPCMx, ScreenPPCMy ,     { statt act_pixelPerXcm, act_PixelPerYcm,}
            Point(ixs0, iys0), iNewWinRect);
  If (Count = 0) or
     (TGeoObj(Items[0]).ClassType <> TGOrigin) then begin
    i := LastValidObjIndex;
    Insert(0, TGOrigin.Create(Self, 0, 0, iType, iis_visible));
    Insert(1, TGAxis.Create(Self, Items[0], 1, 0, iis_visible));
    Insert(2, TGAxis.Create(Self, Items[0], 0, 1, iis_visible));
    Insert(3, TGaugePoint.Create(Self, Items[0], Items[1], False));
    Insert(4, TGaugePoint.Create(Self, Items[0], Items[2], False));
    LastValidObjIndex := i + 5;
    end
  else
  If (Count <= 5) then begin    { nur bei sonst leerer Zeichnung }
    TGOrigin(Items[0]).X := ixs0;
    TGOrigin(Items[0]).Y := iys0;
    For i := 1 to Pred(Count) do
      TGeoObj(Items[i]).UpdateParams;
    IsDirty := False;
    end;
  end;

procedure TGeoObjListe.RescaleCoordSys(ppcmX, ppcmY: Double);
  var i: Integer;
  begin
  Fe1x :=   ppcmx;
  Fe1y :=   0;
  Fe2x :=   0;
  Fe2y := - Abs(ppcmy);
  ActualizeWindowsConstants;
  act_PixelPerXcm := Abs(e1x);          // vorsichtshalber in globale
  act_PixelPerYcm := Abs(e2y);          // Variablen zurückschreiben !
  For i := 0 to LastValidObjIndex do
    If (TGeoObj(Items[i]) is TGNumber) or
       (TGeoObj(Items[i]) is TGSetSquare) then
      TGNumber(Items[i]).Rescale
    else
      TGeoObj(Items[i]).UpdateParams;
  end;

procedure TGeoObjListe.InitAngle1Screen;
  begin

  end;

procedure TGeoObjListe.FillDragList(DrObj: TGeoObj);
  { 05.06.05 : überarbeitet im Zuge der Renovierung der Zugmöglichkeiten
               für Polygone, die Strecken fester Länge als Kanten haben  }
  var i : Integer;
  begin
  If IndexOf(DrObj) < 0 then
    DrObj := Nil;
  ResetDragList;
  DraggedObj := DrObj;       // In der Liste vermerken !
  If DrObj <> Nil then begin
    If DrObj is TGArea then begin
      LastQJumpX := Quantisized(LastLogMouseX, TGArea(DrObj).Quant);
      LastQJumpY := Quantisized(LastLogMouseY, TGArea(DrObj).Quant);
      end;
    DrObj.Register4Dragging(DragList);
    DragList.SortByDependencies;
    { Offensichtlich unnötige Ortslinien-Updates vermeiden : }
    For i := Pred(DragList.Count) DownTo 0 do
      If (TGeoObj(DragList[i]).ClassType = TGLocLine) and
         (TGLocLine(DragList[i]).OLStatus > 0) and
         ((TGeoObj(DragList[i]).Parent.Count = 0) or
          (TGeoObj(DragList[i]).Parent[0] = DraggedObj)) then
        DragList.Delete(i);
    If DrObj is TGArea then
      DragList.BringFreePointsToListStart;
    DragList.BringSetsquareToListStart;
    end;
  end;

procedure TGeoObjListe.FillOutputList(LVOI: Integer; OL: TList);
  { Füllt die übergebene Liste mit allen Objekten aus der GeoListe,
    und zwar in einer für die Canvas-Ausgabe geeigneten Reihenfolge,
    die eventuelle Überdeckungen vorausschauend berücksichtigt.
    16.02.08 : Koordinatensystem mehr in den Hintergrund gerückt wg.
               Bug-Meldung von Klement (Achsen überdecken Teile des
               Randes einer Riemann-Summen-Fläche)
    14.11.08 : Koordinatensystem *vor* die Füllungen gerückt wg.
               Bug-Meldung von D. Viertel (Füllung verdeckt das
               Koordinatensystem)                                 }
  var SQO, i : Integer;

  procedure Process(GO: TGeoObj);
    begin
    If GO.flag then begin
      OL.Add(GO);
      GO.flag := False;
      end;
    end;

  function NoObjFlagged: Boolean;
    var i : Integer;
    begin
    Result := True;
    For i := 0 to LVOI do
      If TGeoObj(Items[i]).flag then
        Result := False;
    end;

  begin
  OL.Clear;
  SQO := -1;
  for i := 0 to LVOI do                      // Alle Objekte "flag"gen
    TGeoObj(Items[i]).flag := True;

  for i := 5 to LVOI do
    If TGeoObj(Items[i]) is TGImage then     // Hintergrund-Bild(er)
      If TGeoObj(Items[i]) is TGSetSquare then
        SQO := i
      else
        Process(TGeoObj(Items[i]));
  for i := 5 to LVOI do
    If TGeoObj(Items[i]) is TGArea then      // Füllungen
      Process(TGeoObj(Items[i]));
  for i := 5 to LVOI do
    if TGeoObj(Items[i]) is TGZoomFrame then // Zoom-Frame (für die Lupe)
      Process(TGeoObj(Items[i]));
  for i := 0 to 4 do                         // Koordinatensystem
      Process(TGeoObj(Items[i]));
  for i := 5 to LVOI do
    If TGeoObj(Items[i]) is TGAngle then     // Winkelbögen
      Process(TGeoObj(Items[i]));
  for i := 5 to LVOI do
    If (TGeoObj(Items[i]) is TGNumber) or    // Zahl-, Term- und
       (TGeoObj(Items[i]) is TGTextObj) then // ... Text-Objekte
      Process(TGeoObj(Items[i]));
  for i := 5 to LVOI do
    If TGeoObj(Items[i]) is TGLine then      // Alle Linien
      Process(TGeoObj(Items[i]));
  for i := 5 to LVOI do                      // Alle Punkte (... und der Rest,
    If i <> SQO then                         //   den es hoffentlich nie gibt!)
      Process(TGeoObj(Items[i]));
  If SQO > 0 then
    Process(TGeoObj(Items[SQO]));            // Zum Schluss das Geo3eck !

  Assert(NoObjFlagged, 'Unexpected object flag found !');
  end;

procedure TGeoObjListe.ResetDragList(Unflag: Boolean = True);
  var i : Integer;
  begin
  i := 0;
  While i < DragList.Count do begin
    If (IndexOf(DragList[i]) >= 0) and
       (TGeoObj(DragList[i]).ClassType = TGPoint) then
      TGPoint(DragList.Items[i]).RejectTemporaryParents;  { Alle temporären Eltern löschen  }
    Inc(i);
    end;
  DragList.Clear;
  If Unflag then                    { Normalerweise : }
    For i := Pred(Count) downto 0 do  { Alle(!) Objekte "unflagged" setzen ! }
      TGeoObj(Items[i]).IsFlagged := False;
  DraggedObj      := Nil;
  UpdatingLocLine := Nil;
  end;


procedure TGeoObjListe.ResetAllMarks;
  var i : Integer;
  begin
  For i := 0 to LastValidObjIndex do
    TGeoObj(Items[i]).FStatus :=
        TGeoObj(Items[i]).FStatus and Not gs_IsMarked;
  end;


procedure TGeoObjListe.DragObjects(wx, wy: Integer; rotate: Boolean);
  { Parameter :
      (wx|wy) ist die Mausposition in Fensterkoordinaten.
      rotate ist nur für das Ziehen an Füllungen signifikant:
        falls es FALSE ist - was der Normalfall ist, wird eine Verschiebung
        des gezogenen Objekts ausgeführt, andernfalls eine Drehung.

    23.11.03 : Falls IsDoubleBuffered eingeschaltet ist, werden in der
               Schleife nur die verzogenen Objekte neu berechnet; die
    eigentliche Grafikausgabe geschieht dann kompakt in "DrawFirstObjects".
    Dies liefert bei komplexeren Zeichnungen weniger Bildschirmflackern.
    Leichte Performance-Einbußen müssen hingenommen werden, weil stets
    *alle* Objekte neu gezeichnet werden müssen!

    25.03.05 : Parameter rotate hinzugefügt.              }

  var TL            : TGLine;
      n, s, i       : Integer;
      delta, xm, ym : Double;

  procedure GetRotationParams;
    begin
    If DraggedObj.Parent.Count = 1 then begin
      If TGeoObj(DraggedObj.Parent[0]) is TGPolygon then begin
        xm := TGeoObj(DraggedObj.Parent[0]).X;  // Drehpunkt ist der
        ym := TGeoObj(DraggedObj.Parent[0]).Y;  //   Schwerpunkt.
        end
      else if TGeoObj(DraggedObj.Parent[0]) is TGCircle then begin
        xm := TGCircle(DraggedObj.Parent[0]).X1;  // Drehpunkt ist der
        ym := TGCircle(DraggedObj.Parent[0]).Y1;  //   Mittelpunkt.
        end
      else begin
        xm := DraggedObj.X; // Drehpunkt ist der Diagonalenschnittpunkt
        ym := DraggedObj.Y; //    des umschließenden Rechtecks.
        end;
      end
    else begin
      xm := DraggedObj.X;   // Drehpunkt ist der Diagonalenschnittpunkt
      ym := DraggedObj.Y;   //    des umschließenden Rechtecks.
      end;
    If Abs(TGArea(DraggedObj).FQuant) < epsilon then
      delta := signed_angle(LogLastMouse_X - LogLastMouse_dx - xm,
                            LogLastMouse_Y - LogLastMouse_dy - ym,
                            LogLastMouse_X - xm, LogLastMouse_Y - ym)
    else
      delta := 0;  // verhindert die Drehung bei rastenden Trägerpunkten !
    end;

  procedure GetMoveParams;
    var q, q2, xq, yq, dx, dy : Double;
    begin
    q := TGArea(DraggedObj).FQuant;
    If q < epsilon then begin   // Stetiges Gleiten
      xm := LogLastMouse_dx;
      ym := LogLastMouse_dy;
      end
    else begin                  // Quanten-Sprünge
      xq := Quantisized(LogLastMouse_X, q);
      yq := Quantisized(LogLastMouse_Y, q);
      dx := xq - LastQJumpX;
      dy := yq - LastQJumpY;
      q2 := q/2;
      If (Abs(dx) > q2) or
         (Abs(dy) > q2) then begin
        xm := dx;
        ym := dy;
        LastQJumpX := xq;
        LastQJumpY := yq;
        end
      else begin
        xm := 0;
        ym := 0;
        end;
      end;
    end;

  begin { of DragObjects }
  If DragList.Count > 0 then begin
    If DragList.Items[0] = Items[0] then begin
      WindowOrigin := Point(wx, wy);
      SendMessage(HostWinHandle, cmd_ExternCommand, cmd_Drag, 1);
      end
    else begin
      LastMousePos := Point(wx, wy);
      If DraggedObj is TGArea then begin       { 1. Sonderfall:              }
        If rotate then                         { Ziehen an Füllungen         }
          GetRotationParams
        else
          GetMoveParams;
        s := 0;
        While (s < DragList.Count) and
              (TGeoObj(DragList[s]).ClassType = TGPoint) and
              (TGPoint(DragList[s]).Parent.Count = 0) do begin
          If rotate then
            TGPoint(DragList[s]).DragRotate(delta, xm, ym)
          else
            TGPoint(DragList[s]).DragMove(xm, ym);
          s := s + 1;
          end;
        end
      else
        if (OLineMode = 4) and                 { 2. Sonderfall: während der  }
           (DraggedObj is TGPoint) and         { OL-Aufzeichnung Trägerlinie }
           TGPoint(DraggedObj).IsLineBound(TL) then         { nachzeichnen ! }
          TL.DrawIt;

      { Eigentlicher Zugvorgang : }
      If IsDoubleBuffered then begin
        For i := 0 to Pred(DragList.Count) do
          TGeoObj(DragList[i]).UpdateParams;
        GroupList.UpdateConditions;
        DrawFirstObjects(LastValidObjIndex, True);  { zeichnet *immer* neu ! }
        end
      else begin
        For i := 0 to Pred(DragList.Count) do begin
          n := IndexOf(DragList[i]);
          If (n >= 0) and (n <= LastValidObjIndex) then
            TGeoObj(DragList[i]).DragIt;
          end;
        GroupList.UpdateConditions;
        UpdateGroupVisibility;      { löst ein Neuzeichnen aus, wenn sich die }
        end;                        { Sichtbarkeiten dynamisch geändert haben }

      If FLogo <> Nil then                         { Logo anzeigen }
        TargetCanvas.Draw(-50, WindowRect.Bottom - FLogo.Height,
                          FLogo.Picture.Bitmap);

      If IsDoubleBuffered then                     { Ausgabe auf Screen      }
        BitBlt(ActCanvas.Handle, 0, 0, FDoubleBuffer.Width, FDoubleBuffer.Height,
               TargetCanvas.Handle, 0, 0, SRCCopy);
      end;
    end;
  end;  { of DragObjects }


function TGeoObjListe.Animate(Mode: Integer): Integer;
  var newval    : Double;

  function EndLessLoop: Boolean;
    var CL : TGLine;
    begin
    Result := (AnimationSource is TGPoint) and
              (TGPoint(AnimationSource).IsLineBound(CL)) and
              (CL is TGLine) and
              (TGLine(CL).IsClosedLine);
    end;

  begin
  Result := Mode;
  If (DragList.Count = 0) or (DragList[0] <> AnimationSource) then
    Result := cmd_Drag
  else begin
    DraggedObj := Nil;
    With AnimationSource do
      Case Mode of
        cmd_RunAnimaFD: begin
                newval := AniValue + AniStep;
                If newval >= AniMaxValue then
                  If EndLessLoop then
                    newval := newval - (AniMaxValue - AniMinValue)
                  else
                    Result := cmd_Drag;
                AniValue := Boxed(newval);
                end;
        cmd_RunAnimaBK: begin
                newval := AniValue - AniStep;
                If newval <= AniMinValue then
                  If EndLessLoop then
                    newval := newval + (AniMaxValue - AniMinValue)
                  else
                    Result := cmd_Drag;
                AniValue := Boxed(newval);
                end;
      end; { of case }
    GroupList.UpdateConditions;
    Repaint;
    end;
  end;


procedure TGeoObjListe.DrawFirstObjects(Last2Draw: Integer; ClearBack: Boolean = False);

  procedure DrawThoseObjs;
    var OL : TList;
        i  : Integer;
    begin
    OL := TList.Create;
    try
      FillOutputList(Last2Draw, OL);
      For i := 0 to Pred(OL.Count) do
        TGeoObj(OL[i]).DrawIt;
    finally
      OL.Free;
    end;
    end;

  begin
  If IsDoubleBuffered then begin
    If ClearBack then
      ClearBitmap(FDoubleBuffer, BackgroundColor);
    If ShowingCRText then
      DrawTempText(CRText, 12, 10, 10)
    else
      DrawThoseObjs;
    If FLogo <> Nil then
      TargetCanvas.Draw(-50, WindowRect.Bottom - FLogo.Height,
                        FLogo.Picture.Bitmap);
    BitBlt(ActCanvas.Handle, 0, 0, FDoubleBuffer.Width, FDoubleBuffer.Height,
           TargetCanvas.Handle, 0, 0, SRCCopy);
    end
  else begin
    If ClearBack then begin
      TargetCanvas.Brush.Style := bsSolid;
      TargetCanvas.Brush.Color := BackgroundColor;
      TargetCanvas.Pen.Color   := BackgroundColor;
      TargetCanvas.FillRect(WindowRect);
      end;
    If ShowingCRText then
      DrawTempText(CRText, 12, 10, 10)
    else
      DrawThoseObjs;
    If FLogo <> Nil then
      TargetCanvas.Draw(-50, WindowRect.Bottom - FLogo.Height,
                        FLogo.Picture.Bitmap);
    end;
  end;


procedure TGeoObjListe.DrawTempText(sl: TStringList; fsize, posx, posy: Integer);
  var i : Integer;
  begin
  With TargetCanvas do begin
    brush.Color := clWhite;
    brush.Style := bsSolid;
    font.Assign(StartFont);
    font.Size   := - fsize;
    font.Color  := clBlack;
    For i := 0 to Pred(sl.Count) do begin
      TextOut(posx, posy, sl.Strings[i]);
      posy := posy + font.Height;
      end;
    end;
  If IsDoubleBuffered then
    BitBlt(ActCanvas.Handle, 0, 0, FDoubleBuffer.Width, FDoubleBuffer.Height,
           TargetCanvas.Handle, 0, 0, SRCCopy);
  end;


procedure TGeoObjListe.Repaint;
  begin
  DrawFirstObjects(LastValidObjIndex, True);
  end;


function TGeoObjListe.GetNewFontScaleFactor: Double;
  { 31.05.2013 : Andreas Katzengruber meldet im Forum einen Bug: 2 Textboxen,
                 die in der Zeichnung gleiche Fonts verwenden, konnten bei
    skaliertem Export in eine Pixel-Grafik-Datei dort mit verschieden großen
    Fonts dargestellt werden.
    Zur Behebung dieses Missstandes berechnet die vorliegende Routine einen
    gemeinsamen Skalierungsfaktor, der für *alle* Textboxen der aktuellen
    Konstruktion "passt".
    Siehe auch die Änderung in "TGComment.ExportIt"! }

  var accFontScale,            // "accumulated font scale"
      objFontScale : Double;   // "object's font scale"
      actObj       : TGeoObj;  // "actual object"
      i            : Integer;
  begin
  accFontScale := 0;
  for i := 0 to Pred(Count) do begin
    actObj := get(i);
    if (actObj is TGComment) then begin
      ActCanvas.Font.Assign(StartFont);
      objFontScale := TGTextObj(actObj).GetFontScale(ActCanvas);
      if objFontScale > 0 then  // nur positive Werte berücksichtigen!
        if (objFontScale < accFontScale) or (accFontscale <= 0) then
          accFontScale := objFontScale;
      end;
    end;
  Result := accFontScale;
  end;

procedure TGeoObjListe.Export_To(OutCanvas: TCanvas; ClipRect: TRect; ScaleF: Double);
  var old_Canvas             : TCanvas;
      old_e1x, old_e2y,
      old_ppcmx, old_ppcmy   : Double;
      old_WinOri, new_WinOri : TPoint;
      old_WinRect            : TRect;
      old_PtSize, i          : Integer;
      rescale                : Boolean;
      OutList                : TList;

  procedure DrawCross;
    begin
    With OutCanvas, OutCanvas.ClipRect do begin
      Font.Color  := clBlack;
      Font.Height := Round(24 * ScaleF);
      Brush.Style := bsClear;
      TextOut(left + Round(50 * ScaleF),
              top  + Round(20 * ScaleF), ProjectName + ' ' + EuklidVersionString);
      TextOut(left + Round(50 * ScaleF),
              top  + Round(50 * ScaleF), MyStartMsg[25]);
      TextOut(left + Round(50 * ScaleF),
              top  + Round(80 * ScaleF), MyStartMsg[17]);
      Pen.Color := clBlack;
      Pen.Width := 3;
      MoveTo(left  + 5, top    + 5);
      LineTo(right - 5, bottom - 5);
      MoveTo(left  + 5, bottom - 5);
      LineTo(right - 5, top    + 5);
      end;
    end;

  begin
  old_Canvas  := TargetCanvas;
  old_e1x     := e1x;
  old_e2y     := e2y;
  old_WinOri  := WindowOrigin;
  old_WinRect := WindowRect;
  old_PtSize  := PointSize;
  old_ppcmx   := act_pixelPerXcm;
  old_ppcmy   := act_pixelPerYcm;
  rescale     := Abs(ScaleF - 1) > epsilon;
  try
    // Ausgabe-Canvas vorbereiten
    FTargetCanvas := OutCanvas;
    act_pixelPerXcm := act_pixelPerXcm * ScaleF;
    act_pixelPerYcm := act_pixelPerYcm * ScaleF;
    TargetCanvas.Font.Assign(old_Canvas.Font);
    If rescale then begin
      PointSize  := Round(PointSize * ScaleF);
      new_WinOri := Point(Round(old_WinOri.X * ScaleF),
                          Round(old_WinOri.Y * ScaleF));
      InitScale(e1x * ScaleF, e2y * ScaleF, new_WinOri, ClipRect);
      FScale := ScaleF;
      UpdateAllObjects;
      end;
    // Eigentliche Ausgabe
    OutList := TList.Create;
    try
      FillOutputList(LastValidObjIndex, OutList);
      for i := 0 to Pred(OutList.Count) do
        TGeoObj(OutList[i]).ExportIt;
    finally
      OutList.Free;
    end;
    // Shareware-Nag !  Killed in 04.01.2016
    // If IsShareware then
    //  DrawCross;
  finally
    // Ausgabe-Canvas zurücksetzen
    FTargetCanvas := old_Canvas;
    FScale        := 1.0;          // Standardwert
    If rescale then begin
      act_pixelPerXcm := old_ppcmx;
      act_PixelPerYcm := old_ppcmy;
      PointSize := old_PtSize;
      InitScale(old_e1x, old_e2y, old_WinOri, old_WinRect);
      UpdateAllObjects;
      end;
  end; { of try }
  end;

procedure TGeoObjListe.ExportScaled_To(OutCanvas: TCanvas; ops: TOutputStatus;
                                       x1, y1, x2, y2, scale, aspect: Double);
  var old_Canvas               : TCanvas;
      old_e1x, old_e2y,
      old_ppcmx, old_ppcmy     : Double;
      old_WinOri               : TPoint;
      old_WinRect, new_WinRect : TRect;
      old_PtSize, i            : Integer;
      old_ops                  : TOutputStatus;
      OutList                  : TList;

  procedure DrawCross;
    begin
    With OutCanvas, OutCanvas.ClipRect do begin
      Font.Color  := clBlack;
      Font.Height := Round(24 * Scale);
      Brush.Style := bsClear;
      TextOut(left + Round(50 * Scale),
              top  + Round(20 * Scale), ProjectName + ' ' + EuklidVersionString);
      TextOut(left + Round(50 * Scale),
              top  + Round(50 * Scale), MyStartMsg[25]);
      TextOut(left + Round(50 * Scale),
              top  + Round(80 * Scale), MyStartMsg[17]);
      Pen.Color := clBlack;
      Pen.Width := 3;
      MoveTo(left  + 5, top    + 5);
      LineTo(right - 5, bottom - 5);
      MoveTo(left  + 5, bottom - 5);
      LineTo(right - 5, top    + 5);
      end;
    end;

  begin { of ExportScaled_To }
  old_Canvas  := TargetCanvas;
  old_e1x     := e1x;
  old_e2y     := e2y;
  old_WinOri  := WindowOrigin;
  old_WinRect := WindowRect;
  old_PtSize  := PointSize;
  old_ppcmx   := act_pixelPerXcm;
  old_ppcmy   := act_pixelPerYcm;
  old_ops     := OutputStatus;
  try
    // Ausgabe-Canvas vorbereiten
    FOutputStatus := ops;
    FTargetCanvas := OutCanvas;
    TargetCanvas.Font.Assign(old_Canvas.Font);
    With TargetCanvas.Font do
      Size := Round(Size * Scale);
    act_pixelPerXcm := act_pixelPerXcm * Scale;
    act_pixelPerYcm := act_pixelPerYcm * Scale * Aspect;
    PointSize  := Round(PointSize * Scale);
    Fe1x := e1x * Scale;
    Fe2y := e2y * Scale * Aspect;

    GetWinCoords(x1, y1, new_WinRect.Left,  new_WinRect.Top);
    GetWinCoords(x2, y2, new_WinRect.Right, new_WinRect.Bottom);
    SetWindowOrgEx(OutCanvas.Handle, new_WinRect.Left, new_WinRect.Top, nil);
    SetWindowExtEx(OutCanvas.Handle, new_WinRect.Right - new_WinRect.Left,
                                     new_WinRect.Bottom - new_WinRect.Top, nil);
    InitScale(e1x, e2y, WindowOrigin, new_WinRect);
    FScale := Scale * Aspect;    // ermöglicht die Größenanpassung von Fonts
    UpdateAllObjects;

    // Skalierungsfaktor für Fonts feinjustieren
    FFontScale := GetNewFontScaleFactor;

    // Eigentliche Ausgabe
    OutList := TList.Create;
    try
      FillOutputList(LastValidObjIndex, OutList);
      for i := 0 to Pred(OutList.Count) do
        TGeoObj(OutList[i]).ExportIt;
    finally
      OutList.Free;
    end;
    // Shareware-Nag !   Killed 04.01.2016
    // If IsShareware then
    //   DrawCross;
  finally
    // Ausgabe-Canvas zurücksetzen
    FOutputStatus := old_ops;
    FTargetCanvas := old_Canvas;
    FScale        := 1.0;          // Standardwert
    FFontScale    := 0.0;          // Standardwert
    act_pixelPerXcm := old_ppcmx;
    act_PixelPerYcm := old_ppcmy;
    PointSize    := old_PtSize;
    InitScale(old_e1x, old_e2y, old_WinOri, old_WinRect);
    UpdateAllObjects;
  end; { of try }
  end; { of ExportScaled_To }

procedure TGeoObjListe.ExportZoomed_To(OutCanvas: TCanvas;
                                       x1, y1, x2, y2, scale: Double);
  var old_TCanvas, old_ACanvas : TCanvas;
      old_e1x, old_e2y,
      old_ppcmx, old_ppcmy,
      old_LastLogMouseDX,
      old_LastLogMouseDY,
      old_LastLogMouseX,
      old_LastLogMouseY        : Double;
      old_WinOri,
      old_LastMouseMove,
      old_LastMousePos         : TPoint;
      old_WinRect, new_WinRect : TRect;
      i                        : Integer;
      old_ops                  : TOutputStatus;
      aspect                   : Double;
      actGO                    : TGeoObj;
  begin
  old_TCanvas := TargetCanvas;
  old_ACanvas := ActCanvas;
  old_e1x     := e1x;
  old_e2y     := e2y;
  old_LastLogMouseDX := LastLogMouseDX;
  old_LastLogMouseDY := LastLogMouseDY;
  old_LastLogMouseX  := LastLogMouseX;
  old_LastLogMouseY  := LastLogMouseY;
  old_LastMouseMove.X := LastMouseMove.X;
  old_LastMouseMove.Y := LastMouseMove.Y;
  old_LastMousePos.X  := LastMousePos.X;
  old_LastMousePos.Y  := LastMousePos.Y;
  old_WinOri  := WindowOrigin;
  old_WinRect := WindowRect;
  old_ppcmx   := act_pixelPerXcm;
  old_ppcmy   := act_pixelPerYcm;
  old_ops     := OutputStatus;
  aspect      := 1;
  try
    // Ausgabe-Canvas vorbereiten
    FOutputStatus := outZoom;
    FTargetCanvas := OutCanvas;
    FActCanvas    := OutCanvas;
    TargetCanvas.Font.Assign(old_TCanvas.Font);
    act_pixelPerXcm := act_pixelPerXcm * scale;
    act_pixelPerYcm := act_pixelPerYcm * scale * aspect;
    Fe1x := e1x * scale;
    Fe2y := e2y * scale * aspect;

    GetWinCoords(x1, y1, new_WinRect.Left,  new_WinRect.Top);
    GetWinCoords(x2, y2, new_WinRect.Right, new_WinRect.Bottom);
    SetWindowOrgEx(OutCanvas.Handle, new_WinRect.Left, new_WinRect.Top, nil);
    SetWindowExtEx(OutCanvas.Handle, new_WinRect.Right - new_WinRect.Left,
                                     new_WinRect.Bottom - new_WinRect.Top, nil);
    InitScale(e1x, e2y, WindowOrigin, new_WinRect);

    // Die folgende Schleife ersetzt den Aufruf von UpdateAllObjects;
    for i := 0 to LastValidObjIndex do begin
      actGO := Items[i];
      if not (actGO is TGNumber) then
        actGO.UpdateParams;
      end;

    FFontScale := 0;

    // Eigentliche Ausgabe
    for i := 0 to LastValidObjIndex do begin
      actGO := Items[i];
      if not (actGO is TGNumber) then
        actGO.ExportIt;
      end;

  finally
    // Ausgabe-Canvas zurücksetzen
    FOutputStatus    := old_ops;
    FTargetCanvas    := old_TCanvas;
    FActCanvas       := old_ACanvas;
    FScale           := 1.0;          // Standardwert
    FFontScale       := 0.0;          // Standardwert
    act_pixelPerXcm  := old_ppcmx;
    act_PixelPerYcm  := old_ppcmy;
    InitScale(old_e1x, old_e2y, old_WinOri, old_WinRect);
    LogLastMouse_dx  := old_LastLogMouseDX;
    LogLastMouse_dy  := old_LastLogMouseDY;
    LogLastMouse_X   := old_LastLogMouseX;
    LogLastMouse_Y   := old_LastLogMouseY;
    FLastMouseMove.x := old_LastMouseMove.x;
    FLastMouseMove.y := old_LastMouseMove.y;
    FLastMousePos.x  := old_LastMousePos.x;
    FLastMousePos.y  := old_LastMousePos.y;

     // Rücksetzen für die Ausgabe im Hauptfenster
    for i := 0 to LastValidObjIndex do begin
      actGO := Items[i];
      if not (actGO is TGNumber) then
        actGO.UpdateParams;
      end;

  end; { of try }
  end; { of ExportZoomed_To }


procedure TGeoObjListe.Copy2Bitmap(TargetBMP: TBitmap; UpperLeft: TPoint);
  begin
  BitBlt(TargetBMP.Canvas.Handle, 0, 0, TargetBMP.Width, TargetBMP.Height,
         ActCanvas.Handle, UpperLeft.X, UpperLeft.Y, srccopy);
  end;


procedure TGeoObjListe.UpdObjAndAllDescOf (pGO : TGeoObj);
  var i : Integer;
  begin
  With pGO do
    If IsFlagged and
       AllParentsUnflagged then begin
      UpdateParams;
      FStatus := FStatus and Not gs_IsFlagged;
      For i := 0 to Pred(Children.Count) do
        UpdObjAndAllDescOf(Children.Items[i]);
      end;
  end;

procedure TGeoObjListe.UpdateAllDescendentsOf (GO: TGeoObj);
  var i   : Integer;
  begin
  With GO do begin
    IsFlagged := True;   { "flag't" alle Nachkommen ! }
    FStatus := FStatus and Not gs_IsFlagged;
    For i := 0 to Pred(Children.Count) do
      UpdObjAndAllDescOf(Children.Items[i]);
    end;
  end;

procedure TGeoObjListe.UpdateAllLongLines;
  var old_dx, old_dy,
      new_dx, new_dy : Double;
      i : Integer;
  begin
  For i := 0 to Pred(Count) do
    If TGeoObj(Items[i]) is TGLongLine then
      With TGLongLine(Items[i]) do begin
        old_dx := X2 - X1;
        old_dy := Y2 - Y1;
        UpdateParams;
        new_dx := X2 - X1;
        new_dy := Y2 - Y1;
        FReversed27 := old_dx * new_dx + old_dy * new_dy < 0;
        end;
  end;

procedure TGeoObjListe.UpdateAllObjects;
  var i : Integer;
  begin
  For i := 0 to LastValidObjIndex do
    TGeoObj(items[i]).UpdateParams;
  GroupList.UpdateConditions;
  end;

procedure TGeoObjListe.AutoUpdateLocLines;
  var NO : TGName;
      i  : Integer;
  begin
  For i := 0 to LastValidObjIndex do
    If (TGeoObj(Items[i]) is TGLocLine) then
      with TGLocLine(Items[i]) do
        If IsDynamic then begin
          If IsVisible then
            HideIt;
          UpdatingLocLine := TGLocLine(Items[i]);
          AutoUpdate;
          If HasNameObj(NO) then begin
            SetNameRefPtCoords;
            UpdateNameCoordsIn(NO);
            end;
          UpdatingLocLine := Nil;
          If IsVisible then
            DrawIt;
          end;
  end;


procedure TGeoObjListe.UpdateGroupVisibility;
  var changes : Integer;
  begin
  changes := GroupList.VisMaskChanged(LastGroupVisMask);
  If changes <> 0 then begin
    DrawFirstObjects(LastValidObjIndex, True);
    LastGroupVisMask := GroupList.VisMask;
    end;
  end;

procedure TGeoObjListe.StartBaseObjBlinking;
  var i : Integer;
  begin
  For i := 5 to LastValidObjIndex do
    If (TGeoObj(Items[i]).ClassType = TGPoint) or
       (TGeoObj(Items[i]).ClassType = TGBaseLine) or
       (TGeoObj(Items[i]).ClassType = TGBaseCircle) then
      TGeoObj(Items[i]).InitBlinking(OBE);
  end;


procedure TGeoObjListe.ToggleBlinkingObjs;
  var i : Integer;
  begin
  for i := 0 to 4 do
      TGeoObj(Items[i]).BlinkIt;
  for i := 5 to LastValidObjIndex do
    If TGeoObj(Items[i]) is TGArea then
      TGeoObj(Items[i]).BlinkIt;
  for i := 5 to LastValidObjIndex do
    If Not(TGeoObj(Items[i]) is TGPoint) and
       Not(TGeoObj(Items[i]) is TGArea) then
      TGeoObj(Items[i]).BlinkIt;
  for i := 5 to LastValidObjIndex do
    If TGeoObj(Items[i]) is TGPoint then
      TGeoObj(Items[i]).BlinkIt;
  IsBlinkOn := Not IsBlinkOn;
  If IsDoubleBuffered then
    BitBlt(ActCanvas.Handle, 0, 0, FDoubleBuffer.Width, FDoubleBuffer.Height,
           TargetCanvas.Handle, 0, 0, SRCCopy);
  end;


procedure TGeoObjListe.EndBlinkingMode;
  var TGO     : TGeoObj;
      refresh : Boolean;
      i       : Integer;
  begin
  refresh := False;
  For i := 0 to LastValidObjIndex do begin
    TGO := TGeoObj(Items[i]);
    With TGO do
      If IsBlinking then begin
        If Not IsBlinkOn then   { Wenn das Objekt im Augenblick unsichtbar ist:    }
          refresh := True;      { PaintBox-Refresh auslösen! Wegen DoubleBuffering }
        IsBlinking := False;    { genügt es nicht, das Objekt neu zu zeichnen !    }
        end;
    end;
  If refresh then
    Repaint;
  end;


procedure TGeoObjListe.EraseGroupMarks;
  var i : Integer;
  begin
  For i := 0 to Pred(Count) do
    TGeoObj(Items[i]).IsGrouped := False;
  end;


procedure TGeoObjListe.MakeHiddenObjectsTempVisible;
  var TGO : TGeoObj;
      i   : Integer;
  begin
  For i := 0 to LastValidObjIndex do begin
    TGO := TGeoObj(Items[i]);
    With TGO do
      If Not ShowsAlways and
         (ClassType <> TGaugePoint) then begin              { Eichpunkte bleiben verborgen ! }
        ShowsOnlyNow := True;
        DrawIt;
        end;
    end;
  end;


function TGeoObjListe.HideHiddenObjects: Integer;
  var n, i : Integer;

  procedure HHO(TGO: TGeoObj);
    begin
    With TGO do
      If ShowsOnlyNow then begin
        HideIt;
        ShowsOnlyNow := False;
        Inc (n);
        end;
    end;

  begin
  n := 0;
  For i := 0 to Pred(Count) do
    HHO(Items[i]);
  HideHiddenObjects := n;
  end;


function TGeoObjListe.MarkedObjCount: Integer;
  { gibt die Anzahl der markierten nichtgelöschten
    (aktiven) Objekte in der Liste zurück           }
  var i, n : Integer;
  begin
  n := 0;
  for i:= 0 to LastValidObjIndex do
    If TGeoObj(Items[i]).IsMarked then
      Inc(n);
  MarkedObjCount := n;
  end;


function TGeoObjListe.GroupedObjCount: Integer;
  var i, n : Integer;
  begin
  n := 0;
  for i:= 0 to LastValidObjIndex do
    If TGeoObj(Items[i]).IsGrouped then Inc(n);
  GroupedObjCount := n;
  end;

procedure TGeoObjListe.EraseMakMarks;
  var i   : Integer;
  begin
  For i := 0 to LastValidObjIndex do
    With TGeoObj(Items[i]) do
      If IsMakMarked or IsFlagged then begin
        HideIt;
        IsMakMarked := False;
        IsFlagged := False;
        DrawIt;
        end;
  end;

procedure TGeoObjListe.EraseFlags;
  var i : Integer;
  begin
  For i := 0 to LastValidObjIndex do
    With TGeoObj(Items[i]) do
      IsFlagged := False;
  end;


procedure TGeoObjListe.InvalidateObject(GO: TGeoObj);
  var PCh : TGeoObj;
      i   : Integer;

  begin
  If (GO <> Nil) and
     (IndexOf(GO) <= LastValidObjIndex) then begin
    For i := Pred(GO.Children.Count) downto 0 do begin { Alle Nachkommen des zu löschenden   }
                                                       {  Objekts löschen bzw. konvertieren. }
      PCh := GO.Children.Items[i];       { 02.10.95: Nur echt abhängige Objekte löschen,     }
      If PCh.ClassType = TGPoint then    {           nur gebundenen Basispunkte werden       }
        PCh.Stops2BeChildOf(GO)          {              lediglich "entbunden"!               }
      else
        InvalidateObject(PCh);           {   (Vorsicht! Rekursion!)                          }
      end;

    If (GO is TGFunktion) or    { Funktions-Schaubilder, das Geodreieck und Namen werden     }
       (GO is TGSetsquare) or   { sofort endgültig gelöscht; dies gilt auch für Strecken     }
       (GO is TGFixLine) or     { fester Länge: im Nov. 2005 kam ein Bug-Report von Martin   }
       (GO is TGName) then      { Friebe, der durch Rücknahme von Löschungen Polygone        }
      FreeObject(GO)            { erstellte, deren Seiten alle feste Länge hatten  ==>       }
    else begin                  { zirkuläre Verwandtschaften ==> Rekursionskatastrophe!      }
      GO.Invalidate;                     { Objekt soll sich aufs Ungültigwerden vorbereiten. }
      Move(IndexOf(GO),                  { Das Objekt selbst aus der Liste lösen ...         }
           LastValidObjIndex);           {  ... und als ungültiges Objekt wiedereinfügen.    }
      Dec(LastValidObjIndex);            { Nummer des letzten gültigen Objekts justieren !   }
      end;
    IsDirty := True;
    end;
  end;


procedure TGeoObjListe.RevalidateObject(GO: TGeoObj);
  { holt ein einzelnes gelöschtes Objekt "ins Leben zurück"; dabei wird vorausgesetzt:
    Alle Eltern dieses Objekts sind gültige, nichtgelöschte Objekte !
    Ist das Objekt garnicht gelöscht, sondern nur verborgen, dann wird es sichtbar gemacht. }
  var n : Integer;
  begin
  If GO <> Nil then begin
    If IndexOf(GO) <= LastValidObjIndex then { Falls das Objekt schon gültig ist, wird es   }
      GO.ShowsAlways := True                 {   (falls nötig) sichtbar geschaltet.         }
    else begin
      n := IndexOf(GO);
      Move(n,                        { Andernfalls wird es aus der Liste der gelöschten }
           Succ(LastValidObjIndex)); {   Objekte in die der aktiven verschoben.         }
      GO.Revalidate;                 { Das Objekt soll sich aufs         }
      Inc(LastValidObjIndex);        {   Wieder-Gültig-Sein einstellen.  }
      If (GO is TGLocline) and TGLocLine(GO).IsStandardLine then begin
        Move(n + 1, Succ(LastValidObjIndex));
        TGeoObj(Items[n + 1]).Revalidate;
        Inc(LastValidObjIndex);
        end;
      end;
    IsDirty := True;
    end;
  end;


function TGeoObjListe.InsertObject(Item: TGeoObj;
                                   var err_num: Integer;
                                   ins_pos: Integer = -1): TGeoObj;
  { Überschreibt Insert, weil hier die Verwaltung der Variablen
    LastValidObjIndex gemacht werden muß.
    AtInsert darf nicht mehr direkt aufgerufen werden !!!!!!!
    In err_num wird eine Fehlernummer zurückgegeben:
        0  :  Alles okay, das neue Objekt wurde erfolgreich eingefügt.
        2  :  Ein solches wie das zu erzeugende Objekt existiert schon.
        4  :  Das zu erzeugende Objekt existiert schon als verborgenes
              Objekt; es wurde wieder sichtbar gemacht.
        5  :  Das zu erzeugende Objekt existiert schon als gelöschtes
              Objekt; es wurde wieder reaktiviert.                     }
  var EGO : TGeoObj;    { Existing Geometric Object }
  begin
  If ExistObject(Item, EGO) then begin
    If IndexOf(EGO) > LastValidObjIndex then begin  { EGO ist gelöscht }
      RevalidateObject(EGO);
      EGO.ShowsAlways := Item.ShowsAlways;
      err_num := 5
      end
    else                                     { EGO ist gültiges Objekt }
      If Item.ShowsAlways then
        If EGO.IsVisible then
          err_num := 2
        else begin
          EGO.ShowsAlways := True;
          err_num := 4;
          end
      else
        err_num := 2;
    Item.Free;               { löscht das (alte) Objekt vom Bildschirm }
    Item := EGO;
    end
  else begin
    Inc(LastValidObjIndex);
    If ins_pos < 0 then
      Insert(LastValidObjIndex, Item)
    else
      Insert(ins_pos, Item);
    err_num := 0;
    end;
  Item.Redraw;               { zeigt das neu eingefügte Objekt an      }
  IsDirty := True;
  Result  := Item;
  end;


procedure TGeoObjListe.SortObjects;
  { 06.08.2002 : Sichert, daß auch bei einer "Adoption" (Bindung eines
                 Punktes) die Eltern in der Objekt-Liste stets *vor*
                 den Kindern aufgeführt werden. Sortiert gegebenenfalls
                 die Objekte entsprechend um.
    13.10.2002 : Erweitert wegen der durch rekursive Funktionen nun
                 möglichen zirkulären Abhängigkeiten. In einem solchen
                 Fall greift die zusätzliche Bedingung [*] und
                 verhindert die entsprechende Tauschaktion.          }
  var actObj : TGeoObj;
      LastParentIndex,
      ActObjIndex,
      k      : Integer;
  begin
  ActObjIndex := 0;
  While ActObjIndex < Pred(Count) do begin
    actObj := Items[ActObjIndex];
    LastParentIndex := 0;
    For k := 0 to Pred(actObj.Parent.Count) do
      If (IndexOf(actObj.Parent[k]) > LastParentIndex) and
         (Not actObj.IsAncestorOf(actObj.Parent[k])) then   //   [*]
        LastParentIndex := IndexOf(actObj.Parent[k]);
    If LastParentIndex > ActObjIndex then
      Move(ActObjIndex, LastParentIndex)
    else
      Inc(ActObjIndex);
    end;
  end;

procedure TGeoObjListe.FreeObject(GO: TGeoObj);
  { Hier wird die Verwaltung der Variablen LastValidObjIndex erledigt;
    daher darf AtFree nun nicht mehr direkt aufgerufen werden !!
    Es werden alle Nachkommen des übergebenen Objekts Item bearbeitet:
     -- Echt abhängige Objekte werden gelöscht.
     -- Ledigliche gebundene Basispunkte werden nicht gelöscht, sondern
          nur "entbunden".
    Darüberhinaus werden alle Verweise anderer Objekte auf Item gelöscht.

    30.10.95 : [*]  Diese For-Schleife ist nötig, weil man sich nicht drauf
               verlassen kann, dass FreeObject nur nach InvalidateObject
               aufgerufen wird; es dient darüberhinaus auch dazu, irgend-
               welche Objekte zu irgendeiner Zeit sicher zu löschen. Hier
               werden alle Verwandtschaftsbeziehungen des zu löschenden
               Objekts sicher und zuverlässig abgebaut.
    20.01.03 : [**]  Der abschließende Aufruf von DragList.Clear ist wegen
               der harten Löschung von Standard-Ortslinien-Darstellungs-
               objekten nötig !
    13.10.08 : [***] If-Bedingung mehrfach ergänzt: vermeidet ASV trotz
               zirkulärer Bezüge.
    17.04.11 : "try/try..."-Konstruktion hinzugefügt um das Abräumen von
               Objekten betriebssicherer zu machen.                      }

  var P        : TGeoObj;
      i, k     : Integer;
      GOC, GON : String;
  begin
  If GO <> Nil then begin
    GOC := GO.ClassName;
    GON := GO.Name;
    try
      try
        While GO.Children.Count > 0 do begin  { Erst mal alle Kinder verarzten! }
          P := GO.Children[0];
          If IndexOf(P) >= 0 then begin
            P.Stops2BeChildOf(GO);
            If (P <> GO) and (P.ClassName <> 'TGPoint') and  // [***]
               (Not P.IsAncestorOf(GO)) then
              FreeObject(P);                  {   (Vorsicht! Rekursion!)        }
            end
          else
            GO.Children.Delete(0);            { Kinder, die *nicht* in der Liste  }
          end;                                { stehen, werden direkt gestrichen! }

        For i := Pred(Count) DownTo 0 do begin               //  [*]
          P := Items[i];
          If (P.Parent.Count > 0) and
             (P.Parent[0] = GO) then
            P.Parent.Delete(0);               { Alle Bindungen an das zu löschende Objekt auflösen. }
          With P.Children do
            For k := Pred(Count) DownTo 0 do  { In allen Nachkommenlisten alle  }
              If Items[k] = GO then           {   Verweise auf das gelöschte    }
                Remove(Items[k]);             {   Objekt tilgen.                }
          end;
      except
        SpyOut('Error in "TGeoObjListe.FreeObject()" while deleting %s %s.', [GOC, GON]);
      end; { of inner try }
    finally
      k := IndexOf(GO);
      GO.Free;                                { Das Objekt selbst löschen ....  }
      If (k >= 0) and (k < Count) then begin
        If k <= LastValidObjIndex then
          Dec(LastValidObjIndex);
        Delete(k);                            {   und aus der Liste streichen ! }
        end;
    end; { of outer try }
    end; { of if }
  DragList.Clear;                                        //  [**]
  end;

procedure TGeoObjListe.DeleteCorrectnessCheck;
  var i : Integer;
  begin
  i := LastValidObjIndex;
  While i > 0 do
    if TGeoObj(Items[i]).ClassType = TGCheckControl then begin
      FreeObject(Items[i]);
      i := 0;
      end
    else
      i := i - 1;
  end;

procedure TGeoObjListe.KillInvalidObjects;
  { [*] 29.10.95 : Unterdrückt den Versuch des Destruktors "Free",
                   das vermeintlich angezeigte Objekt vom Bildschirm
                   zu löschen.                                        }
  var i   : Integer;
      TGO : TGeoObj;    // "T"emporary "G"eo "O"bject
  begin
  i := 0;
  While i <= LastValidObjIndex do
    If (TGeoObj(Items[i]) is TGTransformation) and
       (TGTransformation(Items[i]).Children.Count = 0) then
      InvalidateObject(Items[i])
    else
      i := i + 1;
  If LastValidObjIndex >= Pred(Count) then Exit;     { Keine ungültigen Objekte vorhanden !       }
  For i := Pred(Count) downto Succ(LastValidObjIndex) do begin { Löschen "von hinten nach vorne"  }
    TGO := TGeoObj(Items[i]);                                  { sichert, daß vor den Eltern die  }
    TGO.FStatus := TGO.FStatus and gs_FreeMask;  { [*] }       { Kinder gelöscht werden !!!!!     }
    FreeObject(TGO);
    end;
  LastValidObjIndex := Pred(Count);                  { Keine ungültigen Objekte mehr vorhanden !  }
  end;


procedure TGeoObjListe.KillAllObjects;
  begin
  KillInvalidObjects;
  While Count > 0 do
    FreeObject(TGeoObj(Items[Pred(Count)]));
  end;


procedure TGeoObjListe.KillLocLineDoubles;
  var ActObj : TGeoObj;
      i      : Integer;
  begin
  ActObj := TGeoObj(Items[LastValidObjIndex]);
  While ActObj <> Nil do begin
    If ActObj is TGLocLine then
      For i := Pred(Count) downto 5 do
        If (Items[i] <> ActObj) and
           TGeoObj(Items[i]).HasSameDataAs(ActObj) then
          FreeObject(Items[i]);
    i := IndexOf(ActObj);
    If i > 0 then
      ActObj := Items[i-1]
    else
      ActObj := Nil;
    end;
  end;

function TGeoObjListe.CollectBuggyTermObjs: String;
  var i : Integer;
  begin
  Result := '';
  For i := 0 to Pred(Count) do
    If TGeoObj(Items[i]).HasBuggyTerm then
      Result := Result + TGeoObj(Items[i]).Name + ', ';
  If Length(Result) > 0 then
    System.Delete(Result, Length(Result) - 1, 2);
  end;

procedure TGeoObjListe.KillBuggyTermObjs;
  var i : Integer;
  begin
  i := 0;
  while i < LastValidObjIndex do begin
    if TGeoObj(Items[i]).HasBuggyTerm then
      FreeObject(Items[i])
    else
      i := i + 1;
    end;
  end;

function TGeoObjListe.KillUnknownObjects : Integer;
  var i : Integer;
  begin
  Result := 0;
  For i := Pred(Count) downto 0 do
    If TGeoObj(Items[i]) is TGUnknown then begin
      If Result = 0 then Result := 1;
      If TGeoObj(Items[i]).Children.Count > 0 then
        If Result = 1 then Result := 2;
      end;
  For i := Pred(Count) downto 0 do
    If TGeoObj(Items[i]) is TGUnknown then
      FreeObject(Items[i]);
  end;

procedure TGeoObjListe.RescaleDrawing(k : Double);
  var NewOri,
      smidpt: TPoint;
      i     : Integer;
  begin
  DraggedObj := Nil;
  With WindowRect do begin
    smidpt.X := Left + (Right - Left) Div 2;
    smidpt.Y := Bottom + (Top - Bottom) Div 2;
    end;
  NewOri.X := smidpt.X + Round(k*(WindowOrigin.X - smidpt.X));
  NewOri.Y := smidpt.Y + Round(k*(WindowOrigin.Y - smidpt.Y));
  InitScale(e1x * k, e2y * k, NewOri, WindowRect);
  act_PixelPerXcm := Abs(e1x);    // in globale Variablen zurückschreiben !
  act_PixelPerYcm := Abs(e2y);
  If Abs(k-1) > epsilon then
    For i := 0 to Pred(Count) do
      TGeoObj(Items[i]).Rescale;
  end;


procedure TGeoObjListe.RebuildTermStrings;
  var i : Integer;
  begin
  For i := 0 to LastValidObjIndex do
    TGeoObj(Items[i]).RebuildTermStrings;
  GroupList.RebuildTermStrings;
  end;


procedure TGeoObjListe.CheckFriendlyLinksOf(Num: Integer);
  var i : Integer;

  procedure CheckLinks(Item: TGFixLine);
    begin
    With Item do
      If (ClassType = TGFixLine) and
         ((TGeoObj(Parent[0]).GeoNum = Num) or
          (TGeoObj(Parent[1]).GeoNum = Num)) then
        AdjustFriendlyLinks;
    end;

  begin
  For i := 0 to Pred(Count) do CheckLinks(Items[i]);
  end;


procedure TGeoObjListe.PatchLocLineParents(old, new: TGeoObj);
  var n, i : Integer;
  begin
  For i := 0 to Pred(Count) do
    If TGeoObj(Items[i]) is TGLocLine then
      with TGLocLine(Items[i]) do begin
        n := Parent.IndexOf(old);
        If n >= 0 then
          Parent.Items[n] := new;
        end;
  end;


procedure TGeoObjListe.ConvertCoord2BasePt(GO: TGeoObj);
  var BP_New : TGPoint;
      n      : Integer;
  begin
  ResetDragList;
  n      := IndexOf(GO);
  BP_New := TGPoint.ConvertFromCoordPt(TGPoint(GO));
  Items[n] := BP_New;
  CheckFriendlyLinksOf(BP_New.GeoNum);
  FillDragList(BP_New);
  PatchLocLineParents(GO, BP_New);
  end;


procedure TGeoObjListe.ConvertBase2CoordPt(GO: TGeoObj);
  var CP_New : TGXPoint;
      n      : Integer;
  begin
  ResetDragList;
  n        := IndexOf(GO);
  CP_New   := TGXPoint.ConvertFromBasePt(TGPoint(GO));
  Items[n] := CP_New;
  FillDragList(CP_New);
  PatchLocLineParents(GO, CP_New);
  end;


procedure TGeoObjListe.VirtualizeCoords;
  { erwartet eine *sortierte* Liste: Kinder stets *nach* den Eltern ! }
  var i : Integer;
      R : TRect;
  begin
  { Zug-Strategie zurücksetzen auf "Reversibel" statt "Stetig" }
  DragStrategy := DefDragStrategy;

  { Erst das Koordinatensystem in Ordnung bringen: }
  If (Count > 0) then
    If TGeoObj(Items[0]) is TGOrigin then begin
      with TGOrigin(Items[0]) do begin
        If Abs(scrx) + Abs(scry) > 0 then
          FWindowOrigin := Point(Round(scrx * ppcm_corrfactor),
                                 Round(scry * ppcm_corrfactor))
        else
          FWindowOrigin := Point(Round(X), Round(Y));
        ActualizeWindowsConstants;
        X := 0;
        Y := 0;
        end;
      For i := 1 to 4 do
        TGeoObj(Items[i]).VirtualizeCoords;
      end
    else begin
      R := WindowRect;
      InitCoordSys((R.Right - R.Left) Div 2, (R.Bottom - R.Top) Div 2,
                   R, 0, True);
      end;

  { Dann die Koordinaten aller Objekte virtualisieren: }
  For i := 5 to Pred(Count) do
    TGeoObj(Items[i]).VirtualizeCoords;
  end;

procedure TGeoObjListe.Slide(dxm, dym : Integer);
  { 25.09.03 : Der Parameter "all" entscheidet darüber, ob auch die am
               Fensterrand orientierten Objekte verschoben werden. Dies
               betrifft Zahl- und Termobjekte sowie ungebundene Textboxen.
               Ergänzt für den GEOX-HTML-Export !
    14.09.06 : Parameter "all" wieder entfernt: am Fensterrand orientierte
               Objekte werden *nie* verschoben !                          }
  begin
  DraggedObj   := Items[0];                  // statt : Nil;   (27.07.05)
  WindowOrigin := Point(WindowOrigin.X + dxm, WindowOrigin.Y + dym);
  end;


procedure TGeoObjListe.CME_PopupClick(Sender : TObject);
  begin
  PostMessage(HostWinHandle, cmd_PopupCommand,
              TMenuItem(Sender).Tag, 0);
  end;

procedure TGeoObjListe.SimInit;
  { Dimensioniert das 2-dimensionale Puffer-Array QFA und speichert die
    Positionsdaten der Basispunkte im aktuellen Zustand der Zeichnung ab.
    17.02.2007 : Korrektes Verziehen von Strecken fester Länge nach-
                 gerüstet; dazu wird eine temporäre Elter-Kind-Beziehung
                 zwischen dem (virtuell) verzogenen Punkt und dem
                 abhängigen Endpunkt eingerichtet.                         }
  var TL : TGLine;
      k,    // Zähler für die benötigten Pufferpakete
      n,    // Index des QFA-Feldes für die Daten des nächsten Basis-Punkts
      i  : Integer;
  begin
  k := 0;
  For i := 5 to LastValidObjIndex do begin
    If (TGeoObj(Items[i]).ClassType = TGPoint) or
       (TGeoObj(Items[i]).ClassType = TGNumberObj) then
      k := k + 1;
    end;
  If (QFA = Nil) or (Length(QFA) <> k) then
    SetLength(QFA, k, 6);
  n := 0;
  For k := 5 to LastValidObjIndex do          // Start-Positionen merken
    If TGeoObj(Items[k]).ClassType = TGPoint then begin
      If TGPoint(Items[k]).IsLineBound(TL) then
        QFA[n, 4] := TGPoint(Items[k]).BoundParam
      else with TGPoint(Items[k]) do begin
        QFA[n, 4] := TGPoint(Items[k]).X;
        QFA[n, 5] := TGPoint(Items[k]).Y;
        For i := 0 to Pred(Friends.Count) do
          If Parent.IndexOf(Friends[i]) < 0 then
            TGeoObj(Friends[i]).BecomesChildOf(TGPoint(Items[k]));
        end;
      n := n + 1;
      end
    else if TGeoObj(Items[k]).ClassType = TGNumberObj then begin
      QFA[n, 4] := TGNumberObj(Items[k]).Value;
      n := n + 1;
      end;
  end;

procedure TGeoObjListe.SimDrag(ShowSim: Boolean; SimMode: Integer = 0);
  { Führt einen Verzieh-Vorgang durch. Dabei entscheidet der Wert von
    SimMode über den tatsächlich durchgeführten Vorgang :
      0  :  Normaler Random-Verzieh-Vorgang von der aktuellen Lage zu
            einem zufällig gewählten Ziel
      1  :  Rückzug aus der aktuellen Lage in die ursprüngliche Ausgangslage;
      2  :  Kurzfassung des bisherigen Zuggeschehens: verzieht die Zeichnung
            von der ursprünglichen Ausgangslage in die derzeit aktuelle ! }
  var fac  : Double;
      TL   : TGLine;
      steps,
      n,       // Index des QFA-Feldes für die Daten des nächsten Basis-Punkts
      k, i : Integer;
  begin
  { Start und Ziel dieses einzelnen Verzieh-Vorgangs definieren : }
  n := 0;
  For k := 5 to LastValidObjIndex do
    If (TGeoObj(Items[k]).ClassType = TGPoint) then begin
      Case SimMode of
        0 : If TGPoint(Items[k]).IsLineBound(TL) then begin
              QFA[n, 0] := TGPoint(Items[k]).BoundParam;  // aktueller Ist-Wert
              QFA[n, 2] := TL.GetRandomParam;         // anvisierter Ziel-Wert
              end
            else with TGPoint(Items[k]) do begin
              QFA[n, 0] := X;                             // aktuelle Ist-Werte
              QFA[n, 1] := Y;                             //    "
              QFA[n, 2] := GetRandom(xMin, xMax);     // anvisierte Ziel-Werte
              QFA[n, 3] := GetRandom(yMin, yMax);     //     "
              end;
        1 : If TGPoint(Items[k]).IsLineBound(TL) then begin
              QFA[n, 0] := TGPoint(Items[k]).BoundParam;  // aktueller Ist-Wert
              QFA[n, 2] := QFA[n, 4];               // restaurierter Start-Wert
              end
            else with TGPoint(Items[k]) do begin
              QFA[n, 0] := X;                             // aktuelle Ist-Werte
              QFA[n, 1] := Y;                             //    "
              QFA[n, 2] := QFA[n, 4];               // restaurierte Start-Werte
              QFA[n, 3] := QFA[n, 5];               //     "
              end;
        2 : If TGPoint(Items[k]).IsLineBound(TL) then begin
              QFA[n, 0] := QFA[n, 4];               // restaurierter Start-Wert
              QFA[n, 2] := TGPoint(Items[k]).BoundParam;  // aktueller Ist-Wert
              end
            else with TGPoint(Items[k]) do begin
              QFA[n, 0] := QFA[n, 4];               // restaurierte Start-Werte
              QFA[n, 1] := QFA[n, 5];               //     "
              QFA[n, 2] := X;                             // aktuelle Ist-Werte
              QFA[n, 3] := Y;                             //    "
              end;
      end; { of case }
      n := n + 1;
      end
    else if TGeoObj(Items[k]).ClassType = TGNumberObj then begin
      Case SimMode of
        0 : With TGNumberObj(Items[k]) do begin
              QFA[n, 0] := Value;                         // aktueller Ist-Wert
              QFA[n, 2] := GetRandom(MinValue, MaxValue); // anvisierter Ziel-Wert
              end;
        1 : With TGNumberObj(Items[k]) do begin
              QFA[n, 0] := Value;                   // aktueller Ist-Wert
              QFA[n, 2] := QFA[n, 4];               // restaurierter Start-Wert
              end;
        2 : With TGNumberObj(Items[k]) do begin
              QFA[n, 0] := QFA[n, 4];               // restaurierter Start-Wert
              QFA[n, 2] := Value;                   // aktueller Ist-Wert
              end;
      end; { of case }
      n := n + 1;
      end;

  { Es folgt die eigentliche Simulation .... }
  If ShowSim then steps := SimSteps
  else            steps := 1;
  For i := 1 to steps do begin
    fac := i / steps;
    n   := 0;
    For k := 5 to LastValidObjIndex do
      If (TGeoObj(Items[k]).ClassType = TGPoint) then begin
        If TGPoint(Items[k]).IsLineBound(TL) then begin
          TGPoint(Items[k]).BoundParam := QFA[n,0] + (QFA[n,2] - QFA[n,0]) * fac;
          TGPoint(Items[k]).UpdateParams;
          end
        else if Not TGPoint(Items[k]).IsEndOfFixLine then
          with TGPoint(Items[k]) do begin
            X := QFA[n,0] + (QFA[n,2] - QFA[n,0]) * fac;
            Y := QFA[n,1] + (QFA[n,3] - QFA[n,1]) * fac;
            TGPoint(Items[k]).UpdateScreenCoords;
            end
        else
          TGPoint(Items[k]).UpdateParams;
        n := n + 1;
        end
      else if TGPoint(Items[k]).ClassType = TGNumberObj then begin
        TGNumberObj(Items[k]).Value := QFA[n,0] + (QFA[n,2] - QFA[n,0]) * fac;
        n := n + 1;
        TGNumberObj(Items[k]).UpdateScreenCoords;
        end
      else
        TGeoObj(Items[k]).UpdateParams;
    { .... mit der optionalen Anzeige: }
    If ShowSim then
      DrawFirstObjects(LastValidObjIndex, True);
    end;
  end;

procedure TGeoObjListe.SimClose;
  { 17.02.2007 : Löst die in SimInit eingerichteten temporären Eltern-Kind-
                 Beziehungen zwischen den Endpunkten der Strecken fester
    Länge wieder auf, führt die Zeichung in den Anfangszustand zurück und
    aktualisiert sie.                                                       }
  var PO   : TGeoObj;
      k, i : Integer;
  begin
  For i := 5 to LastValidObjIndex do
    If (TGeoObj(Items[i]).ClassType = TGPoint) and
       (TGPoint(Items[i]).IsEndOfFixLine) then
      For k := Pred(TGeoObj(Items[i]).Parent.Count) DownTo 0 do begin
        PO := TGeoObj(TGeoObj(Items[i]).Parent[k]);
        If PO is TGPoint then
          TGeoObj(Items[i]).Stops2BeChildOf(PO);
        end;
  SimDrag(False, 1);
  Repaint;
  If Assigned(QFA) then begin
    For i := 0 to High(QFA) do
      QFA[i] := Nil;
    QFA := Nil;
    end;
  end;

function TGeoObjListe.CheckSolution(TargetObj: Array of TGeoObj): Integer;
  { Ermittelt Informationen über die Korrektheit der Konstruktion :
    Result:  |      Bedeutung:
        0    | Konstruktion ist korrekt              <TRUE>
        1    | Fehler in der Korrektheits-Bedingung  <unentscheidbar>
        2    | Konstruktion ist falsch               <FALSE>
        3    | Kein Korrektheits-Check gefunden      <unentscheidbar>   }

  var CCO : TGCheckControl;
  begin
  CCO := CheckControl as TGCheckControl;
  If Assigned(CCO) then
    Result := CCO.CheckSolution(TargetObj)
  else
    Result := 3;
  end;

function TGeoObjListe.CanExport2DynaGeoJ(var ExceptList: TList): Boolean;
  { Liefert genau dann "True", wenn alle Objekte der Zeichnung von DynaGeoJ
    "verstanden" werden können. Andernfalls wird das Ergebnis "false" zurück-
    gegeben sowie in ExceptList eine Liste der "unverstandenen" Objekte.
    ACHTUNG! Auch wenn für ExceptList Nil übergeben wird, zeigt die Variable
             *nach* dem Aufruf in jedem Fall auf eine echte Liste, die aber
             eventuell leer sein kann. Das aufrufende Programm ist selbst für
             die Freigabe dieser Liste verantwortlich. }
  var res : Boolean;
      i : Integer;
  begin
  res := True;
  If ExceptList = Nil then
    ExceptList := TList.Create;
  ExceptList.Clear;
  ResetAllMarks;
  For i := 0 to Pred(Count) do
    if Not DynaGeoJKnows(TGeoObj(Items[i]).ClassName) then begin
      ExceptList.Add(Items[i]);
      res := false;
      end;
  Result := res;
  end;

destructor TGeoObjListe.Destroy;
  { 17.05.11:  Reihenfolge vertauscht:
               erst GeoObjekte freigeben, dann Sekundärlisten löschen!  }
  begin
  If Count > 0 then
    KillAllObjects;
  If Assigned(MakroList) then
    MakroList.Clear;
  MakroList.Free;
  GroupList.Free;
  if Assigned(DragList) then
    DragList.Clear;
  DragList.Free;
  FDoubleBuffer.Free;
  StartFont.Free;
  CRText.Free;
  QFA := Nil;
  Inherited Destroy;
  end;


{--------------------------------------------------}
{ TGeoObj's method implementations:                }
{--------------------------------------------------}

constructor TGeoObj.Create(iObjList: TGeoObjListe; iis_visible : Boolean);
  begin
  Inherited Create;
  ObjList       := iObjList;
  If Assigned(ObjList) then
    FGeoNum     := ObjList.GetNextGeoNum
  else
    FGeoNum     := 0;
  FName         := DefaultName;
  FXMLTypeName  := ObjList.Get_XMLTypeName(Self.ClassName);
  FStatus := gs_Normal;
  If Not iis_visible then
    FStatus := FStatus and Not gs_ShowsAlways;
  FMyColour     := clBlack;   { ist vom Typ TColor (= Teil von Integer) ! }
  FMyPenStyle   := psSolid;   { ist vom Typ TPenStyle ! }
  FMyBrushStyle := bsClear;   { stimmt für transparente oder Linienobjekte }
  FMyShape      := 1;         { stimmt für Basispunkte ! }
  FMyLineWidth  := 1;
  FShowDataInNameObj := False;
  FShowNameInNameObj := False;
  Parent        := TObjPtrList.Create(False);
  Children      := TObjPtrList.Create(False);
  Old_Data      := TDataStack.Create;
  end;

constructor TGeoObj.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  var i : Integer;
  begin
  Inherited Create;
  FStatus  := gs_Normal and Not gs_ShowsAlways; { immer verborgen ! }
  Parent   := TObjPtrList.Create(False);  { Eltern- und Kinderliste }
  Children := TObjPtrList.Create(False);  { einrichten              }

  If GO <> Nil then begin
    FGeoNum       := GO.GeoNum;           { GeoNummer übernehmen,    }
    FName         := GO.FName;            { Name auch !              }
    FMyColour     := GO.MyColour;         { Darstellungsdaten auch ! }
    FMyPenStyle   := GO.FMyPenStyle;
    FMyBrushStyle := GO.FMyBrushStyle;
    FMyShape      := GO.FMyShape;
    FMyLineWidth  := GO.FMyLineWidth;
    FShowDataInNameObj := GO.ShowDataInNameObj;
    FShowNameInNameObj := GO.ShowNameInNameObj;
    For i := 0 to Pred(GO.Parent.Count) do
      If Assigned(GO.ObjList) and (GO.ObjList.IndexOf(GO.Parent[i]) >= 0) then
        Parent.Add(Pointer(TGeoObj(GO.Parent[i]).GeoNum))
      else
        Parent.Add(GO.Parent[i]);
    end
  else begin
    FGeoNum       := iGeoNum;   { neue GeoNummer zuweisen ! }
    FMyColour     := clBlack;   { ist vom Typ TColor (= Teil von Integer) ! }
    FMyPenStyle   := psSolid;   { ist vom Typ TPenStyle ! }
    FMyBrushStyle := bsClear;   { stimmt für transparente oder Linienobjekte }
    FMyShape      := 3;         { stimmt für Nicht-Basispunkte ! }
    FMyLineWidth  := 1;
    FShowDataInNameObj := False;
    FShowNameInNameObj := False;
    end;
  end;

constructor TGeoObj.CreateFromBlueprint(iObjList: TGeoObjListe; MakNum, CmdNum: Integer);
  var ActMakro  : TMakro;
      ActMakCmd : TMakroCmd;
      GO        : TGeoObj;
      i         : Integer;
  begin
  Inherited Create;                       { Objekt erzeugen }
  ObjList := iObjList;
  FGeoNum := ObjList.GetNextGeoNum;
  FName   := DefaultName;                 { neuen eindeutigen Namen holen }
  FStatus := gs_Normal;

  ActMakro  := ObjList.MakroList.Items[MakNum];   { Datenquelle ermitteln }
  ActMakCmd := ActMakro.Items[CmdNum];
  GO        := ActMakCmd.ProtoTyp;

  If ActMakCmd.CmdType < 2 then
    FStatus := FStatus and Not gs_ShowsAlways;
  FMyColour     := GO.MyColour;
  FMyPenStyle   := GO.FMyPenStyle;
  FMyBrushStyle := GO.FMyBrushStyle;
  FMyShape      := GO.FMyShape;
  FMyLineWidth  := GO.FMyLineWidth;
  FShowDataInNameObj := GO.ShowDataInNameObj;
  FShowNameInNameObj := GO.ShowNameInNameObj;

  Parent   := TObjPtrList.Create(False);
  Children := TObjPtrList.Create(False);
  Old_Data := TDataStack.Create;
  For i := 0 to Pred(GO.Parent.Count) do
    BecomesChildOf(ActMakro.GetNewObj(Integer(GO.Parent[i])));

  GetSpecialDataFrom(GO, MakNum);         { Objektspezifische Daten holen }
  UpdateParams;
  DrawIt;
  end;

constructor TGeoObj.Load(S: TFileStream; iObjList: TGeoObjListe);
  const gs_ShowDistLine = $0400;
  var i, n, MyStyle, MyColor : Integer;
      stat : Word;
  begin
  ObjList := iObjList;
  FGeoNum := ReadOldIntFromStream(S);
  ReadOldIntFromStream(S);   { GeoTyp: Dummy !!! }
  FName   := ReadOldStrFromStream(S);
  MyColor  := ReadOldIntFromStream(S);
  MyStyle  := ReadOldIntFromStream(S);
  MyLineWidth := ReadOldIntFromStream(S);
  For i := 1 to 3 do  { überliest MyBrush, MyPen }
    MyShape := ReadOldIntFromStream(S);
  S.Read(stat,  SizeOf(stat));
  FStatus := stat and Not gs_ShowDistLine;
  Parent := TObjPtrList.Create(False);
  For i := 0 to 2 do begin
    n := ReadOldIntFromStream(S);
    If n > 0 then
      Parent.Add(Pointer(n));
    end;
  Children := TObjPtrList.Load(S);
  S.Read(LastDist, SizeOf(LastDist));

  Old_Data      := TDataStack.Create;
  FMyColour     := ColorTable[MyColor];
  MyPenStyle    := TPenStyle(MyStyle);
  MyBrushStyle  := bsClear;
  FShowDataInNameObj := False;
  FShowNameInNameObj := False;
  end;

constructor TGeoObj.Load32(R: TReader; iObjList: TGeoObjListe);
  { 04.08.2008 : Lokale Funktion "ValidName" hierher geholt, weil sie
                 ausschließlich hier gebraucht wird, d.h. veraltet ist. }
  function ValidName(rn: String): String;
    var i : Integer;
    begin
    i := Pos('"', rn);
    While i > 0 do begin
      Delete(rn, i, 1);
      Insert('''''', rn, i);
      i := Pos('"', rn);
      end;
    For i := 1 to Length(rn) do
      If Not CharInSet(rn[i], NameChar) then
        rn[i] := '_';
    Result := rn;
    end;

  var propCol : TColor;
  begin
  ObjList      := iObjList;
  FGeoNum      := R.ReadInteger;
  FName        := ValidName(R.ReadString);
  propCol      := TColor(R.ReadInteger and $00FFFFFF);
  FMyColour    := GetNearestColor(ObjList.ActCanvas.Handle, propCol);
  MyPenStyle   := TPenStyle(R.ReadInteger);
  MyLineWidth  := R.ReadInteger;
  FMyShape     := R.ReadInteger;
  FStatus      := R.ReadInteger;
  Parent       := TObjPtrList.Load32(R);
  Children     := TObjPtrList.Load32(R);
  LastDist     := R.ReadFloat;
  R.ReadFloat;     { Pufferplatz für eventuelle   }
  R.ReadInteger;   { spätere Erweiterungen        }
  MyBrushStyle  := TBrushStyle(R.ReadInteger);
  Old_Data      := TDataStack.Create;
  FShowDataInNameObj := False;
  FShowNameInNameObj := False;
  end;

constructor TGeoObj.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var app, pList: IXMLNode;
      s         : String;
  begin
  ObjList  := iObjList;
  FGeoNum  := StrToInt(DE.getAttribute('id'));
  FName    := DE.getAttribute('name');
  Parent   := TObjPtrList.Create(False);
  Children := TObjPtrList.Create(False);
  Old_Data := TDataStack.Create;

  { Default-Werte für die Darstellung }
  FMyColour     := clBlack;   { = $00000000 }
  FMyPenStyle   := psSolid;   { = 0 }
  FMyLineWidth  := 1;
  FMyShape      := 1;
  FMyBrushStyle := bsClear;   { = 1 }
  FStatus       := gs_Normal;
  FShowDataInNameObj := False;
  FShowNameInNameObj := False;

  { Abweichungen von den Default-Werten einlesen }
  app := DE.childNodes.findNode('appearance', '');
  If app <> Nil then begin
    If app.hasAttribute('color') then
      FMyColour := StrToInt(app.getAttribute('color')) and $00FFFFFF;
    If app.hasAttribute('pen_style') then
      FMyPenStyle := TPenStyle(StrToInt(app.getAttribute('pen_style')));
    If app.hasAttribute('line_width') then
      FMyLineWidth := StrToInt(app.getAttribute('line_width'));
    If app.hasAttribute('shape') then
      FMyShape := StrToInt(app.getAttribute('shape'));
    If app.hasAttribute('brush_style') then
      FMyBrushStyle := TBrushStyle(StrToInt(app.getAttribute('brush_style')));
    If app.hasAttribute('visible') and
       (LowerCase(app.getAttribute('visible')) = 'false') then
      FStatus := FStatus and Not gs_ShowsAlways;
    If app.hasAttribute('groups') then
      FGroups := StrToInt(app.getAttribute('groups'))
    else
      FGroups := 0;
    If app.hasAttribute('add_name2name') then
      FShowNameInNameObj := LowerCase(app.getAttribute('add_name2name')) = 'true';
    If app.hasAttribute('add_data2name') then
      FShowDataInNameObj := LowerCase(app.getAttribute('add_data2name')) = 'true';
    end;

  { Eltern einlesen, soweit vorhanden }
  pList := DE.childNodes.findNode('parents', '');
  If pList <> Nil then begin
    s := pList.nodeValue;
    DeleteChars(#09#10#13, s);  // 09.04.2010: Tabs + Zeilenumbruch-Reste weg !
    Parent.SetGeoNumString(s);
    end;
  { Eine eventuell noch vorhandene Kinder-Liste wird ignoriert. }
  end;

constructor TGeoObj.CreateProtoTypFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  CreateFromDomData(iObjList, DE);
  end;



procedure TGeoObj.GetDataFromOldMappedObj(OMO: TGeoObj);
  { übernimmt die aktuellen Daten aus einem "O"ld "M"apped "O"bject }
  begin
  FName        := OMO.Name;
  FGeoNum      := OMO.GeoNum;
  FMyColour    := OMO.MyColour;
  FMyPenStyle  := OMO.MyPenStyle;
  FMyLineWidth := OMO.MyLineWidth;
  FMyShape     := OMO.MyShape;
  FMyBrushStyle:= OMO.MyBrushStyle;
  FGroups      := OMO.Groups;
  ShowsAlways  := OMO.IsVisible;
  end;

procedure TGeoObj.RebuildPointers;
  { 12.10.2006 :   Rekonstruktion der Children-Listen aus den Parent-Listen;
                   spart die Notwendigkeit des Abspeicherns der eigentlich
                   redundanten Children-Listen ein.                         }
  var i : Integer;
  begin
  Parent.ResolveGeoNums(ObjList);
  For i := 0 to Pred(Parent.Count) do
    TGeoObj(Parent[i]).Children.Add(Self);
  end;

function TGeoObj.ParentLinksAreOkay : Boolean;
  { Überprüft die Parent-Liste eines Geo-Objekts auf Gültigkeit.
    Eine Parent-Liste wird als gültig erachtet, wenn sie:
    a) keine Referenzen auf das Objekt selbst enthält und
    b) alle Referenzen auf solche Objekte zeigen, die auch in
              der TGeoObjListe "ObjList" referenziert werden. }
  var i : Integer;
      pp : TGeoObj;
  begin
  Result := True;   // hoffentlich !
  i := 0;
  While Result and (i < Parent.Count) do begin
    pp := TGeoObj(Parent[i]);
    if (pp = Self) or
       (ObjList.IndexOf(pp) < 0) then
      Result := False;
    i := i + 1;
    end;
  end;

procedure TGeoObj.AfterLoading(FromXML : Boolean = True);
  begin
  end;

function TGeoObj.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var shape,
      parentList   : IXMLNode;
      xmlClassName : String;
      saveShape    : Boolean;
      iv           : Integer;
  begin
  xmlClassName := ObjList.Get_XMLTypeName(ClassName);
  Assert(xmlClassName <> '', 'Unknown xml class name of "' + ClassName + '"');
  If Length(xmlClassName) = 0 then begin
    Result := Nil;
    Exit;
    end;
  Result := DOMDoc.createNode(xmlClassName);
  Result.setAttribute('id', IntToStr(GeoNum));
  Result.setAttribute('name', FName);

  shape := DOMDoc.createNode('appearance');
  saveShape := False;
  If MyColour <> clBlack then begin
    shape.setAttribute('color', '$' + IntToHex(MyColour, 8));
    saveShape := True;
    end;
  If MyPenStyle <> psSolid then begin
    shape.setAttribute('pen_style', IntToStr(Integer(MyPenStyle)));
    saveShape := True;
    end;
  If MyLineWidth <> 1 then begin
    shape.setAttribute('line_width', IntToStr(MyLineWidth));
    saveShape := True;
    end;
  If MyShape <> 1 then begin
    iv := MyShape;
    if iv > 5 then iv := iv - 4;
    shape.setAttribute('shape', IntToStr(iv));
    saveShape := True;
    end;
  If MyBrushStyle <> bsClear then begin
    shape.setAttribute('brush_style', IntToStr(Integer(MyBrushStyle)));
    saveShape := True;
    end;
  If (Assigned(ObjList)) and     // filtert Prototypen raus !
     (Not IsVisibleWithoutGroups) then begin
    shape.setAttribute('visible', 'false');
    saveShape := True;
    end;
  If Groups > 0 then begin
    shape.setAttribute('groups', IntToStr(Groups));
    saveShape := True;
    end;
  If ShowDataInNameObj then begin
    shape.setAttribute('add_data2name', 'true');
    saveShape := True;
    end;
  If ShowNameInNameObj then begin
    shape.setAttribute('add_name2name', 'true');
    saveShape := True;
    end;
  If saveShape then
    Result.childNodes.add(shape);

  If Parent.Count > 0 then begin
    parentList := DOMDoc.createNode('parents');
    parentList.nodeValue := parent.getGeoNumString;
    Result.childNodes.add(parentList);
    end;

// Das Abspeichern der Kinder-Liste wurde kurz vor dem Erscheinen der
//  Version 3.0 deaktiviert. Die Kinder-Liste wurde schon während des
//  Großteils der Beta-Phase beim Einlesen nicht mehr ausgewertet.
{
  If Children.Count > 0 then begin
    childList := DOMDoc.createNode('children');
    childList.childNodes.add(DOMDoc.createTextNode(children.getGeoNumString));
    Result.childNodes.add(childList);
    end;
}
  end;

function TGeoObj.CreatePrototypNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := CreateObjNode(DOMDoc);
  end;

function TGeoObj.CreateI2GElementNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := Nil;
  end;

function TGeoObj.CreateI2GConstraintNode(DOMDoc: IXMLDocument; ObjNames: TStrings): IXMLNode;
  begin
  Result := Nil;
  end;

procedure TGeoObj.UpdateV1xObjects;
  var NO : TGName;
  begin
  If Length(Name) = 0 then
    SetNewName(DefaultName);
  If HasNameObj(NO) then
    SetNewNameParamsIn(NO);
  end;

procedure TGeoObj.UpdateOldPrototype;
  begin
  ObjList := Nil;
  end;

procedure TGeoObj.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  end;

procedure TGeoObj.SaveState;
  begin
  Old_Data.push(@FStatus, SizeOf(FStatus));
  Old_Data.push(@X, SizeOf(X));
  Old_Data.push(@Y, SizeOf(Y));
  Old_Data.push(@scrx, SizeOf(scrx));
  Old_Data.push(@scry, SizeOf(scry));
  end;

procedure TGeoObj.RestoreState;
  begin
  Old_Data.pop(@scry);
  Old_Data.pop(@scrx);
  Old_Data.pop(@Y);
  Old_Data.pop(@X);
  Old_Data.pop(@FStatus);
  end;

procedure TGeoObj.AdoptAllChildrenOf(OldPa: TGeoObj);
  var n  : Integer;
      Ch : TGeoObj;
  begin
  While OldPa.Children.Count > 0 do begin
    Ch := OldPa.Children[0];        { Erstes Kind des alten Elters holen               }
    n := Ch.Parent.IndexOf(OldPa);  { In Kindes Parent-Liste den Eltern-Eintrag suchen }
    If n >= 0 then begin
      Ch.Parent[n] := Self;         { An dieser Stelle den neuen Elter eintragen       }
      Children.Add(Ch);             { Das Kind in der eigenen Kinderliste eintragen... }
      OldPa.Children.Delete(0);     { und aus der Kinderliste des alten Elters löschen }
      end
    else
      raise Exception.Create(MyMess[71]);
    end;
  end;

class function TGeoObj.IsPriorTo(CompType: TClass): Boolean;
  const TypeList : Array [0..14] of TClass =
          (TGSetsquare, TGPoint, TGShortLine, TGCircle, TGAngle, TGLocLine,
           TGStraightLine, TGCurve, TGName, TGNumber, TGTextObj, TGArea,
           TGImage, TGeoObj, TObject);

  function OrdNum(ct: TClass): Integer;
    var i : Integer;
    begin
    i := 0;
    While Not ct.InheritsFrom(TypeList[i]) do Inc(i);
    Result := i;
    end;

  begin
  Result := OrdNum(Self) < OrdNum(CompType);   { Echt kleiner !!!! }
  end;

function TGeoObj.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := ClassGroupId in [ccAnyGeoObj, ccAnyObjNoArea];
  end;

function TGeoObj.IsDynamicLocLineControl: Boolean;
  begin
  Result := false;
  end;

{ TGeoObj - interne Methoden für Eigenschaften }

procedure TGeoObj.SetMyColour(NewCol: TColor);
  begin
  If FMyColour <> NewCol then begin
    If IsVisible then begin
      HideIt;
      FMyColour := NewCol;
      DrawIt;
      end
    else
      FMyColour := NewCol;
    end;
  end;


procedure TGeoObj.SetMyShape(newVal: Integer);
  begin
  If newVal <> FMyShape then
    FMyShape := newVal;
  end;


function TGeoObj.GetName: WideString;
  begin
  Result := FName;
  end;


function  TGeoObj.GetFormattedName: String;
  var NameObj: TGName;
      s : String;
      ne, ns, i : Integer;
  begin
  s := '';
  If HasNameObj(NameObj) then    // von Namen-Objekt holen
    s := NameObj.HTMLText;
  If Length(s) = 0 then begin    // Standard-Formatierung selbst erstellen
    s  := WideString2HTMLString(Name);   // bearbeitet die "Griechen"!
    ne := 0;
    ns := 0;
    i := Length(s);
    While i > 0 do begin
      If CharInSet(s[i], ['0'..'9']) then begin   // Ziffer gefunden
        if ne = 0 then ne := i;
        ns := i;
        end
      else if s[i] = '>' then            // Tag komplett überspringen
        Repeat
          i := i - 1
        until (i = 0) or (s[i] = '<');
      i := i - 1;
      end;
    If ns > 0 then begin                 // Ziffern am Ende tiefstellen!
      Insert('</sub>', s, Succ(ne));
      Insert('<sub>', s, ns);
      end;
    end;
  Result := s;
  end;


function TGeoObj.GetUniqueName(s: WideString): WideString;
  var pu   : WideString;
      n, i : Integer;
  begin               { Der neue Name darf bei *keinem* der aktiven Objekte }
  n  := 1;            {   in der Drawing-Liste schon verwendet worden sein, }
  pu := IntToStr(n);  { und seit 15.12.99 auch bei keinem gelöschten !!!!   }
  i  := 0;
  While i < ObjList.Count do
    If TGeoObj(ObjList.Items[i]).Name = s + pu then begin
      Inc(n);
      pu := IntToStr(n);
      i  := 0;
      end
    else
      Inc(i);
  Result := s + pu;
  end;

procedure TGeoObj.PatchName(NewName: WideString);
  begin
  FName := NewName;
  end;

procedure TGeoObj.SetNewName(NewName : WideString);
  { Ist schon ein Namesobjekt vorhanden wird es verborgen;
    andernfalls wird es für "echte", d.h. benennenswerte
    Geometrie-Objekte erzeugt und verborgen;
    für andere Objekte wird nur der neue Name im Objekt
    selbst gespeichert }
  var ufn : WideString;
      NO  : TGName;   { "N"amens-"O"bjekt }
      err : Integer;
  begin
  ufn := HTMLKillAllTags(NewName);
  If ufn <> FName then begin
    FName := ufn;
    ObjList.RebuildTermStrings;
    end;
  If HasNameObj(NO) then    { Wenn es schon ein Namenobjekt gibt, }
    NO.HideDisplay          {   wird es verborgen                 }
  else begin
    If ClassType.InheritsFrom(TGPoint) then        { Passendes Namen-Objekt erzeugen }
      NO := TGName.Create(ObjList, Self, 0.15, 0)
    else If ClassType.InheritsFrom(TGArc) then
      NO := TGName.Create(ObjList, Self, 0.45, 0.5)
    else If ClassType.InheritsFrom(TGCircle) then
      NO := TGName.Create(ObjList, Self, 0.25, 0.125)
    else If ClassType.InheritsFrom(TGShortLine) then
      NO := TGName.Create(ObjList, Self, -0.3, 0.5)
    else If ClassType.InheritsFrom(TGHalfLine) then
      NO := TGName.Create(ObjList, Self, 0.3, 1.2)
    else If ClassType.InheritsFrom(TGPolygon) then
      NO := TGName.Create(ObjList, Self, 0, 0)
    else If ClassType.InheritsFrom(TGLocLine) then
      NO := TGName.Create(ObjList, Self, 0, -0.15)
    else If ClassType.InheritsFrom(TGLine) then
      NO := TGName.Create(ObjList, Self, 0.3, 2.5)    // ..., -0.3, 0.5)
    else If ClassType.InheritsFrom(TGAngle) then
      NO := TGName.Create(ObjList, Self, 0.7, 0.5)
    else If ClassType.InheritsFrom(TGIntArea) then
      NO := TGName.Create(ObjList, Self, 0, 0)
    else
      NO := Nil;
    If NO <> Nil then begin
      ObjList.InsertObject(NO, err);
      FStatus := FStatus or gs_HasNameObj;  { Flag setzen }
      end;
    end;
  end;


function TGeoObj.HasNameObj(var NameObj: TGName): Boolean;
  var i : Integer;
  begin
  Result := (FStatus and gs_HasNameObj <> 0) and
            (Children.Count > 0);
  NameObj := Nil;
  If Result then begin
    i := 0;
    While (NameObj = Nil) and (i < Children.Count) do
      If TGeoObj(Children[i]) is TGName then
        NameObj := TGName(Children[i])
      else
        i := i + 1;
    end;
  end;


procedure TGeoObj.MarkObjAndAncestors;
  { 10.10.08  Reihenfolge der Markierungsschritte geändert:
              jetzt wird zuerst das Objekt selbst markiert
    und erst danach seine Eltern. Dies vermeidet einen Stack-
    Überlauf beim Checken zirkulärer Verwandtschafts-Bezüge! }
  var i : Integer;
  begin
  If Not IsMarked then begin
    FStatus := FStatus or gs_IsMarked;                // (1)
    For i := 0 to Pred(Parent.Count) do               // (2)
      try
        TGeoObj(Parent.Items[i]).MarkObjAndAncestors;
      except
        SpyOut(Name + ' has invalid parent object.', []);
      end;
    end;
  end;


function TGeoObj.IsAncestorOf(GO: TGeoObj): Boolean;
  begin
  Result := False;
  If GO <> Nil then begin
    ObjList.ResetAllMarks;
    GO.MarkObjAndAncestors;
    If IsMarked then
      Result := True;
    ObjList.ResetAllMarks;
    end;
  end;


function TGeoObj.GetDataValid: Boolean;
  begin
  Result := FStatus and gs_DataValid <> 0;
  end;


procedure TGeoObj.SetDataValid(flag: Boolean);
  begin
  If DataValid <> flag then
    If flag then
      FStatus := FStatus or gs_DataValid
                         or gs_DataCanShow
    else
      FStatus := FStatus and Not gs_DataValid;
  end;


function  TGeoObj.GetIsReversed: Boolean;
  begin
  Result := FStatus and gs_IsReversed > 0;
  end;

procedure TGeoObj.SetIsReversed(flag: Boolean);
  begin
  If flag <> IsReversed then
    If flag then
      FStatus := FStatus or gs_IsReversed
    else
      FStatus := FStatus and Not gs_IsReversed;
  end;

function TGeoObj.GetDataCanShow: Boolean;
  begin
  Result := FStatus and gs_DataCanShow <> 0;
  end;


procedure TGeoObj.SetDataCanShow(flag: Boolean);
  begin
  If DataCanShow <> flag then
    If flag then
      FStatus := FStatus or gs_DataCanShow
    else
      FStatus := FStatus and Not gs_DataCanShow;
  end;


function TGeoObj.GetShowsAlways: Boolean;
  begin
  Result := FStatus and gs_ShowsAlways <> 0;
  end;


procedure TGeoObj.SetShowsAlways(vis: Boolean);
  begin
  If ShowsAlways <> vis then
    If vis then begin
      FStatus := FStatus or gs_ShowsAlways;
      If Not ShowsOnlyNow then
        DrawIt;
      end
    else begin
      If Not ShowsOnlyNow then
        HideIt;
      FStatus := FStatus and Not gs_ShowsAlways;
      end;
  end;


function TGeoObj.GetShowsOnlyNow: Boolean;
  begin
  Result := FStatus and gs_ShowsOnlyNow <> 0;
  end;


procedure TGeoObj.SetShowsOnlyNow(vis: Boolean);
  begin
  If ShowsOnlyNow <> vis then
    If vis then begin
      FStatus := FStatus or gs_ShowsOnlyNow;
      If Not ShowsAlways then
        DrawIt;
      end
    else begin
      If Not ShowsAlways then
        HideIt;
      FStatus := FStatus and Not gs_ShowsOnlyNow;
      end;
  end;


procedure TGeoObj.SetShowNameInNameObj(newVal: Boolean);
  var NO : TGName;
  begin
  if newVal <> FShowNameInNameObj then begin
    FShowNameInNameObj := newVal;
    if (FShowNameInNameObj or FShowDataInNameObj) then
      if not HasNameObj(NO) then
        SetNewName(Name)
      else
    else  // both vars are false !
      if HasNameObj(NO) then
        ObjList.FreeObject(NO);
    end;
  end;

procedure TGeoObj.SetShowDataInNameObj(newVal: Boolean);
  var NO : TGName;
  begin
  if newVal <> FShowDataInNameObj then begin
    FShowDataInNameObj := newVal;
    if (FShowNameInNameObj or FShowDataInNameObj) then
      if not HasNameObj(NO) then
        SetNewName(Name)
      else
    else  // both vars are false !
      if HasNameObj(NO) then
        ObjList.FreeObject(NO);
    end;
  end;


function TGeoObj.GetIsVisible: Boolean;
  { übergibt TRUE genau dann, wenn

    1. die Sichtbarkeitsflags des Objekts dieses als sichtbar und
          gültig kennzeichnen UND
    2. es kein gelöschtes Objekt ist UND
    3. das Objekt entweder *keiner* Gruppe angehört ODER Mitglied
         einer Gruppe ist, die als "sichtbar" deklariert ist.

    Die zweite Bedingung kann dadurch erfüllt sein, daß das Objekt
    gültig ist; sie ist jedoch auch dann erfüllt, wenn das Objekt
    nicht, noch nicht oder nicht mehr in der GeoObject-Liste steht.
    Dies sichert eine korrekte Bearbeitung während der Erzeugung
    und des Verwerfens von Objekten.       }

  begin
  Result := (FStatus >= gs_IsVisible) and
            (ObjList.IndexOf(Self) <= ObjList.LastValidObjIndex) and
            ObjList.GroupList.IsGroupVis(FGroups);
  end;


function TGeoObj.IsVisibleWithoutGroups: Boolean;
  begin
  Result := (ObjList.IndexOf(Self) <= ObjList.LastValidObjIndex) and
            (FStatus and gs_ShowsAlways > 0);
  end;


function TGeoObj.GetIsFlagged: Boolean;
  begin
  Result := FStatus and gs_IsFlagged <> 0;
  end;


procedure TGeoObj.SetIsFlagged(flag: Boolean);
  var i : Integer;
  begin
  If IsFlagged <> flag then begin
    If flag then
      FStatus := FStatus or gs_IsFlagged
    else
      FStatus := FStatus and Not gs_IsFlagged;
    i := Pred(Children.Count);
    While i >= 0 do begin   { Kann nicht durch eine FOR-Schleife ersetzt werden ! }
      If i < Children.Count then
        TGeoObj(Children[i]).IsFlagged := flag;
      Dec(i);
      end;
    end;
  end;


function TGeoObj.GetIsGrouped: Boolean;
  begin
  Result := FStatus and gs_IsGrouped > 0;
  end;


procedure TGeoObj.SetIsGrouped(flag: Boolean);
  var NO : TGName;
  begin
  If IsGrouped <> flag then
    If flag then
      FStatus := FStatus or gs_IsGrouped
    else
      FStatus := FStatus and Not gs_IsGrouped;
  If HasNameObj(NO) then
    NO.IsGrouped := flag;
  end;


function TGeoObj.GetIsMarked: Boolean;
  begin
  Result := FStatus and gs_IsMarked <> 0;
  end;


procedure TGeoObj.SetIsMarked(flag: Boolean);
  var ChildObj : TGeoObj;
      i        : Integer;

  begin
  If IsMarked <> flag then begin
    If flag then
      If IsVisible then begin
        HideIt;
        FStatus := FStatus or gs_IsMarked;
        DrawIt;
        end
      else
        FStatus := FStatus or gs_IsMarked
    else
      If IsVisible then begin
        HideIt;
        FStatus := FStatus and Not gs_IsMarked;
        DrawIt;
        end
      else
        FStatus := FStatus and Not gs_IsMarked;
    i := Pred(Children.Count);
    While i >= 0 do begin               { Kann nicht durch eine FOR-Schleife ersetzt werden ! }
      If i < Children.Count then begin
        ChildObj := TGeoObj(Children.Items[i]);
        If ChildObj.ClassType <> TGPoint then { Versuchsweise nur wirklich abhängige Objekte  }
          ChildObj.IsMarked := flag;          { markieren, keine nur gebundenen Basispunkte ! }
        end;
      Dec(i);
      end;
    ObjList.DrawFirstObjects(ObjList.LastValidObjIndex);
    end;
  end;


function TGeoObj.GetIsMakMarked: Boolean;
  begin
  Result := FStatus and gs_IsMakMarked <> 0;
  end;


procedure TGeoObj.SetIsMakMarked(flag: Boolean);
  begin
  If IsMakMarked <> flag then begin
    If flag then
      If IsVisible then begin
        HideIt;
        FStatus := FStatus or gs_IsMakMarked;
        DrawIt;
        end
      else
        FStatus := FStatus or gs_IsMakMarked
    else
      If IsVisible then begin
        HideIt;
        FStatus := FStatus and Not gs_IsMakMarked;
        DrawIt;
        end
      else
        FStatus := FStatus and Not gs_IsMakMarked;
    ObjList.DrawFirstObjects(ObjList.LastValidObjIndex);
    end;
  end;


function TGeoObj.GetIsBlinking: Boolean;
  begin
  Result := FStatus and (gs_IsBlinking or gs_IsGrouped) <> 0;
  end;


procedure TGeoObj.SetIsBlinking(flag: Boolean);
  begin
  If IsBlinking <> flag then
    If flag then
      FStatus := FStatus or gs_IsBlinking
    else
      FStatus := FStatus and Not gs_IsBlinking;
  end;

function TGeoObj.GetWinPos: TPoint;
  begin
  Result := Point(scrx, scry);
  end;

procedure TGeoObj.SetWinPos(newVal: TPoint);
  begin
  If (newVal.X <> scrx) or (newVal.Y <> scry) then begin
    scrx := newVal.X;
    scry := newVal.Y;
    ObjList.GetLogCoords(scrx, scry, X, Y);
    end;
  end;

{TGeoObj - öffentliche Methoden }

procedure TGeoObj.BecomesChildOf(GO: TGeoObj);
  begin
  If (GO <> Nil) and        { Falls es kein Eltern-Objekt gibt oder "GO" schon }
     (Parent.IndexOf(GO) < 0) then begin       { permanenter Elter ist: raus ! }
    GO.Children.Add(Self);
    Parent.Add(GO);
    end;
  end;

procedure TGeoObj.Stops2BeChildOf(GO: TGeoObj);
  begin
  If (GO <> Nil) then begin  { Falls der Elter garnicht mehr existiert: raus ! }
    while GO.Children.IndexOf(Self) >= 0 do
      GO.Children.Remove(Self);
    while Parent.IndexOf(GO) >= 0 do
      Parent.Remove(GO);
    end;
  end;


procedure TGeoObj.Register4Dragging(DragList: TObjPtrList);
  var i : Integer;
  begin
  i := 0;
  DragList.Insert(0, Self);
  While i < Children.Count do begin
    If DragList.IndexOf(Children.Items[i]) < 0 then
      TGeoObj(Children.Items[i]).Register4Dragging(DragList);
    Inc(i);
    end;
  end;


procedure TGeoObj.RegisterAsMacroStartObject;
  begin
  With TMakro(ObjList.MakroList.Last) do
    AddCmd(TMakroCmd.Create(Self, 0));
  end;


function TGeoObj.GetImplicitMakStartObj(n: Integer): TGeoObj;
  { 05.01.2007 : neu eingeführt, um das Problem der "impliziten Start-
                 objekte" in Makros für die "TGMapped..."-Klassen lösen
    zu können. Diese überschreiben die hier implementierte Standard-
    Version, welche nur ein schon existierendes Elternobjekt zurückgibt. }
  begin
  If (n >= 0) and (n < Parent.Count) then
    Result := Parent[n]
  else
    Result := Nil;
  end;


procedure TGeoObj.SetAsStartObject4MacroRun(MakNum, CmdNum: Integer);
  var aktMakro   : TMakro;
      aktMakCmd  : TMakroCmd;
      implMakCmd : TMakroCmd;
      pid,                      // "p"arent "id"
      i          : Integer;
  begin
  aktMakro := TMakro(ObjList.MakroList[MakNum]);
  aktMakCmd := aktMakro.Items[CmdNum];
  aktMakCmd.pNewObj := Self;
  For i := 0 to Pred(aktMakCmd.ProtoTyp.Parent.Count) do begin
    pid := Integer(aktMakCmd.ProtoTyp.Parent[i]);
    implMakCmd := aktMakro.GetMakroCmdWithProtoTypeId(pid);
    If Assigned(implMakCmd) and (implMakCmd.CmdType = -1) then
      implMakCmd.pNewObj := GetImplicitMakStartObj(i); // Normalerweise: Parent[i];
    end;
  end;


procedure TGeoObj.AddToGroup(GroupMask: Integer);
  begin
  FGroups := FGroups or GroupMask;
  end;


procedure TGeoObj.RevokeFromGroup(GroupMask: Integer);
  begin
  FGroups := FGroups and (Not GroupMask);
  end;


procedure TGeoObj.Invalidate;
  begin
  FName := '_' + FName;
  If IsVisible then HideIt;
  end;


procedure TGeoObj.Revalidate;
  var new_name : String;
  begin
  new_name := Copy(Name, 2, Length(Name));
  If ObjList.NameAlreadyUsed(new_name, Self) then
    new_name := DefaultName;
  FName := new_name;
  IsMarked := False;
  IsFlagged := False;
  IsMakMarked := False;
  UpdateParams;
  If IsVisible then
    DrawIt;
  end;


function TGeoObj.DefaultName: WideString;
  begin
  DefaultName := ObjList.GetUniqueName('go');
  end;


procedure TGeoObj.VirtualizeCoords;
  begin
  scrx := SafeRound(X * ppcm_corrfactor);
  scry := SafeRound(Y * ppcm_corrFactor);
  ObjList.GetLogCoords(scrx, scry, X, Y);
  end;


procedure TGeoObj.Rescale;
  begin
  UpdateParams;
  end;


procedure TGeoObj.UpdateNameCoordsIn(TextObj: TGTextObj);
    { Diese Version ist nur für punktförmige Objekte korrekt }
  begin
  with TextObj do begin
    DataValid := Self.DataValid;
    If DataValid then begin
      X := Self.X + rConst;
      Y := Self.Y + sConst;
      end;
    end;
  end;


procedure TGeoObj.SetNewNameParamsIn(TextObj: TGTextObj);
  begin
  with TextObj do begin
    rConst := X - Self.X;
    sConst := Y - Self.Y;
    end;
  end;


procedure TGeoObj.RebuildTermStrings;
  begin
  end;


function TGeoObj.HasBuggyTerm: Boolean;
  begin
  Result := False;
  end;


procedure TGeoObj.InsertNameOf(GO: TGeoObj; var Target: String);
  var n : Integer;
      NameObj: TGName;
  begin
  n := Pos('?', Target);
  If n > 0 then begin
    Delete(Target, n, 1);
    If GO.HasNameObj(NameObj) then
      Insert(NameObj.HTMLText, Target, n)
    else
      Insert(GO.GetFormattedName, Target, n);
    end;
  end;

procedure TGeoObj.InsertNameOf(GO: TGeoObj; var Target: WideString);
  var n : Integer;
      NameObj: TGName;
  begin
  n := Pos('?', Target);
  If n > 0 then begin
    Delete(Target, n, 1);
    If GO.HasNameObj(NameObj) then
      Insert(NameObj.HTMLText, Target, n)
    else
      Insert(GO.GetFormattedName, Target, n);
    end;
  end;

procedure TGeoObj.InsertMeasureInto(Target: TFormatEdit);
  begin
  Target.Paste(Name);
  end;


procedure TGeoObj.AdjustGraphTools(todraw : Boolean);
  begin
  { setzt nur Pen-Eigenschaften }
  With ObjList.TargetCanvas do begin
    If todraw then
      If ShowsAlways then
        If IsMakMarked then
          If IsFlagged then begin
            Pen.Style := psDash;           { MarkPen }
            Pen.Color := ColorTable[7];
            Pen.Width := 3;
            end
          else begin
            Pen.Style := psSolid;          { BluePen }
            Pen.Color := ColorTable[3];
            Pen.Width := 3;
            end
        else
          If IsMarked then begin
            Pen.Style := psDash;           { MarkPen }
            Pen.Color := ColorTable[7];
            Pen.Width := 3;
            end
          else begin
            Pen.Style := MyPenStyle;       { My Pen }
            Pen.Color := MyColour;
            Pen.Width := max(1, Round(MyLineWidth * ObjList.ScaleFactor));
            end
      else
        If ShowsOnlyNow then begin
          Pen.Style := psDash;             { TempPen }
          Pen.Color := ColorTable[1];
          Pen.Width := 1;
          end
        else begin  { 02.04.05 ergänzt wg. Anzeigeproblemen beim Gruppieren }
          Pen.Style := MyPenStyle;         { My Pen }
          Pen.Color := MyColour;
          Pen.Width := max(1, Round(MyLineWidth * ObjList.ScaleFactor));
          end
    else begin
      Pen.Style := MyPenStyle;  {Am 28.12.99 durch psSolid ersetzt; }
           { am 12.01.00 wieder rückgängig gemacht wg. Pixelresten !}
      Pen.Color := ObjList.BackGroundColor;
      Pen.Width := max(1, Round(MyLineWidth * ObjList.ScaleFactor));
      Brush.Color := Pen.Color;
      end;
    end;
  end;


procedure TGeoObj.SetGraphTools(LineStyleNum, PointStyleNum,
                                FillStyleNum: Integer; iColor: TColor);
  begin
  HideIt;
  MyLineWidth := 1;
  Case LineStyleNum of
    0 : MyPenStyle  := psSolid;
    1 : begin
        MyPenStyle  := psSolid;
        MyLineWidth := 3;
        end;
    2 : begin
        MyPenStyle  := psSolid;
        MyLineWidth := 5;
        end;
    3 : MyPenStyle := psDash;
    4 : MyPenStyle := psDot;
    5 : MyPenStyle := psDashDot;
  end; { of case }
  // MyShape      := 0;    { Ist nicht zielführend !!! }
  MyBrushStyle := TBrushStyle(FillStyleNum);
  MyColour     := iColor;
  DrawIt;
  end;


procedure TGeoObj.GetGraphTools(var LineStyleNum, PointStyleNum,
                                    FillStyleNum: Integer; var iColor: TColor);
  begin
  If MyLineWidth = 3 then
    LineStyleNum := 1
  else
    Case MyPenStyle of
      psDash : LineStyleNum := 2;
      psDot  : LineStyleNum := 3;
    else
      LineStyleNum := 0;
    end; { of case }
  FillStyleNum := Integer(MyBrushStyle);
  iColor := MyColour;
  end;


function TGeoObj.AllParentsUnFlagged: Boolean;
  var i   : Integer;
      APU : Boolean;
  begin
  i   := 0;
  APU := True;
  While (i < Parent.Count) and APU do begin
    If TGeoObj(Parent[i]).IsFlagged then
      APU := False;
    Inc(i);
    end;
  AllParentsUnFlagged := APU;
  end;

function TGeoObj.AllParentsInList(NameList: TStrings): Boolean;
  var i : Integer;
  begin
  Result := True;
  i := 0;
  While Result and (i < Parent.Count) do begin
    If NameList.IndexOf(TGeoObj(Parent[i]).Name) < 0 then
      Result := False
    else
      Inc(i);
    end;
  end;

function TGeoObj.HasSameDataAs(GO: TGeoObj): Boolean;
  { Prüft, ob die Klasse exakt dieselbe ist und ob die Eltern
    (ohne Berücksichtigung der Reihenfolge) übereinstimmen }

  function EqualParents : Boolean;
    var i : Integer;
    begin
    Result := Parent.Count = GO.Parent.Count;
    i := 0;
    While Result and (i < Parent.Count) do begin
      If GO.Parent.IndexOf(Self.Parent[i]) < 0 then
        Result := False;
      Inc(i);
      end;
    end;

  begin
  Result := (GO.ClassType = Self.ClassType) and EqualParents;
  end;


function TGeoObj.DataEquivalent(var data): Boolean;
  begin
  Result := False;
  end;


function TGeoObj.GetMatchingCursor(mpt: TPoint): TCursor;
  begin
  Result := crDefault;  // statt: Drag_Cursor;
  end;


function TGeoObj.GetValue(selector : Integer) : Double;
  begin
  Case selector of
    gv_x   : Result := X;
    gv_y   : Result := Y;
  else
    Result := 0;
  end;
  end;


procedure TGeoObj.Redraw;
  begin
  If ObjList.IsLoading then Exit;
  AdjustGraphTools(True);
  DrawIt;
  With ObjList do begin
    If FLogo <> Nil then
      TargetCanvas.Draw(-50, WindowRect.Bottom - FLogo.Height,
                        FLogo.Picture.Bitmap);
    If IsDoubleBuffered then
      BitBlt(ActCanvas.Handle, 0, 0, FDoubleBuffer.Width, FDoubleBuffer.Height,
             TargetCanvas.Handle, 0, 0, SRCCopy);
    end;
  end;

procedure TGeoObj.Redraw(Adj: Boolean);
  begin
  AdjustGraphTools(Adj);
  DrawIt;
  end;

procedure TGeoObj.DragIt;
  { Sollte zur Steigerung der Effizienz von allen Nachkommen überschrieben werden.
    Die hier ausgeführte Implementierung liefert  einen funktionierenden, aber
    nicht optimierten Zugmodus.                                                        }
  begin
  HideIt;
  UpdateParams;
  DrawIt;
  end;


procedure TGeoObj.BlinkIt;
{ Geändert 28.02.03 : Die frühere Version zeichnete jedes nicht blinkende
                      Objekt nach. Dies führte zu flackernden Füllungen.
  Jetzt hinterlassen die blinkenden Objekte weiße Leerstellen, weshalb man
  sich nun blinkende Füllungen überhaupt nicht mehr erlauben kann. Beim
  Polygon blinkt daher jetzt der Rand - wie beim Kreis ja auch!

  Geändert 15.12.03 : Blinkende Füllungen lassen sich nicht mehr vermeiden,
                      weil der Polygonrand inzwischen komplett unsichtbar ist.
  Daher werden alle nicht-blinkenden Objekte nun wieder nachgezeichnet - wie
  es ursprünglich ja auch schon gewesen war!  }
  begin
  If IsBlinking then
    If ObjList.IsBlinkOn then
      HideIt
    else
      DrawIt
  else
    DrawIt;
  end;


procedure TGeoObj.ExportIt;
  begin
  AdjustGraphTools(True);
  DrawIt;
  end;


procedure TGeoObj.InitBlinking(OBE: Boolean);
  { OBE = "O"bject "B"link "E"nable  }
  var NO : TGName;
  begin
  If OBE then
    If HasNameObj(NO) then begin
      If Not ObjList.IsBlinkOn then begin
        HideIt;
        NO.HideIt;
        end;
      IsBlinking := True;
      NO.IsBlinking := True;
      end
    else begin
      If Not ObjList.IsBlinkOn then
        HideIt;
      IsBlinking := True;
      end;
  end;


function TGeoObj.GetDataStr: String;
  begin
  Result := '';
  end;


procedure TGeoObj.CME_PopupClick(Sender : TObject);
  begin
  PostMessage(ObjList.HostWinHandle, cmd_PopupCommand,
              TMenuItem(Sender).Tag, 0);
  end;


destructor TGeoObj.FreeBluePrint;
  begin
  FreeAndNil(Old_Data);
  FreeAndNil(Children);
  FreeAndNil(Parent);
  ObjList := Nil;
  Inherited Destroy;
  end;


destructor TGeoObj.Destroy;
  { "Destroy" löscht die Bindungen des Objekts an seine Eltern, geht aber davon
    aus, daß keine anderen Objekte ihrerseits an dieses Objekt gebunden sind.

    Solche Bindungen müssen vor dem Aufruf von "Destroy" extern gelöscht worden
    sein. Dies kann z.B. dadurch geleistet werden, daß zu löschende Objekte
    vor dem physikalischen Löschen "invalidiert" werden: die Routine
    "Drawing.InvalidateObject" löscht alle Bindungen an das Objekt. Sie
    löscht darüberhinaus auch das Objekt vom Bildschirm, ohne jedoch seine
    Sichtbarkeitsflags entsprechend zu aktualisieren; dies vereinfacht die
    Reaktivierung des Objekts. Daß "Destroy" trotzdem noch die Sichtbarkeit
    testet und nötigenfalls das Objekt vom Bildschirm löscht, ist für das
    (direkte) Löschen von temporär erzeugten Objekten nötig.

    "Destroy" geht davon aus, daß das Objekt keine Kinder (mehr) hat. Sollte
    dies nicht zutreffen, sind die Kindern  v o r  dem Aufruf von "Destroy"
    extern zu löschen. Da z.B. temporäre Objekte noch gar keine Gelegenheit
    hatten, Kinder zu bekommen, kann das in diesem Fall unterbleiben.

    Wird "Destroy" für ein "invalidiertes" Objekt aufgerufen, müssen zuvor die
    Sichtbarkeitsflags (gs_ShowsAlways und gs_ShowsOnlyNow) aktualisiert,
    d.h. zurückgesetzt werden, damit "HideIt" keinen Unsinn macht.           }

  var n : Integer;
  begin
  If Self <> Nil then begin
    If IsVisible then                  { Falls das Objekt angezeigt wird,     }
      ShowsAlways := False;            { wird es nun vom Bildschirm gelöscht. }
    While Parent.Count > 0 do begin    { Die Bindungen an die Eltern werden   }
      n := ObjList.IndexOf(Parent[0]); { gelöst, aber gaaaanz vorsichtig !!!  }
      If n >= 0 then                   { 09.03.06: n-Manipulata ergänzt wegen }
        Stops2BeChildOf(Parent[0])     {   Trouble mit ur-alten 1.x-Dateien,  }
      else                             {   die Ortslinien enthalten.          }
        Parent.Delete(0);
      end;
    Old_Data.Free;
    Children.Free;
    Parent.Free;
    FName := '';
    Inherited Destroy;
    end;
  end;


{--------------------------------------------------}
{ TGParentObj's method implementations:            }
{--------------------------------------------------}


function TGParentObj.GetAniMinValue: Double;
  begin
  Result := 0;
  end;

function TGParentObj.GetAniMaxValue: Double;
  begin
  Result := 1;
  end;

function TGParentObj.GetAniValue: Double;
  begin
  raise Exception.CreateFmt(MyMess[28], ['GetAniValue']);
  end;

procedure TGParentObj.SetAniValue(nav: Double);
  begin
  raise Exception.CreateFmt(MyMess[28], ['SetAniValue']);
  end;

function TGParentObj.SetLinePosition(tv: Double): Boolean;
  begin
  Result := False;
  end;

procedure TGParentObj.SetAniParams(vmin, vact, vmax, vstep: Double);
  begin
  raise Exception.CreateFmt(MyMess[28], ['SetAniParams']);
  end;

function TGParentObj.CanControlAnimation: Boolean;
  begin
  Result := False;
  end;

function TGParentObj.AniCtrlObjName: String;
  begin
  Result := Name;
  end;

function TGParentObj.Boxed(v: Double): Double;
  begin
  If v > AniMaxValue then
    Result := AniMaxValue
  else if v < AniMinValue then
    Result := AniMinValue
  else
    Result := v;
  end;

procedure TGParentObj.ChangeAniSpeed(sf: Double);
  begin
  sf := Abs(sf);
  If ((sf > 1) and (Abs(AniStep) < 1e-1)) or
     ((sf < 1) and (Abs(AniStep) > 1e-5)) then
    FAniStep := FAniStep * sf;
  end;

function TGParentObj.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  begin
  Result := False;
  end;

function TGParentObj.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  begin
  Result := False;
  end;

function TGParentObj.GetRandomParam: Double;
  { Geht von einer Standard-Parametrisierung über das Intervall [0, 1) aus. }
  begin
  Result := GetRandom(0, 1);
  end;

procedure TGParentObj.ResetOLCPList(PointList : TVector3List);
  begin
  SpyOut('ERROR: Carrier line %s is unable to reset OLCP list.', [Name]);
  end;

procedure TGParentObj.AdoptChildrenOf(GO: TGeoObj);
  { Überträgt alle Kinder aus GO.Children in die eigene Children-Liste,
    aktualisiert die Parent-Einträge in den Kind-Objekten (unter
    Beibehaltung der Reihenfolge!) und löscht die GO.Children-Liste }
  var ch   : TGeoObj;
      n, m : Integer;
  begin
  For n := 0 to Pred(GO.Children.Count) do begin
    ch := GO.Children[n];
    Children.Add(ch);
    m := ch.Parent.IndexOf(GO);
    If m >= 0 then
      ch.Parent[m] := Self
    else
      SpyOut('Fatal relation error: missing parent %s in child %s',
             [GO.Name, ch.Name]);
    end;
  GO.Children.Clear;
  end;

function TGParentObj.GetWinPosNextTo(_X, _Y: Double): TPoint;
  { Implementierung für punktförmige Objekte; in diesem Fall
    werden die übergebenen Koordinaten einfach ignoriert.
    Gilt auch für Polygone und (notfalls) für Ortslinien.  }
  var _sx, _sy : Integer;
  begin
  ObjList.GetWinCoords(X, Y, _sx, _sy);
  Result := Point(_sx + 10, _sy + 10);
  end;

function TGParentObj.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccParentObj, ccNamedObj]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGParentObj.IsLineBound(var TL: TGLine): Boolean;
  begin
  Result := False;
  end;

procedure TGParentObj.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  menu.Items.Clear;    { "Free"d auch die einzelnen Items ! }
  AddPopupMenuItemTo(menu, cme_hide, CME_PopupClick, cmd_ToggleVis);
  if ShowNameInNameObj then begin
    AddPopupMenuItemTo(menu, cme_rename, CME_PopupClick, cmd_NameObj);
    AddPopupMenuItemTo(menu, cme_hidename, CME_PopupClick, cmd_hideName);
    end
  else
    AddPopupMenuItemTo(menu, cme_name, CME_PopupClick, cmd_NameObj);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_col, CME_PopupClick, cmd_EditColour);
  end;


{--------------------------------------------------}
{ TGPoints's method implementations:               }
{--------------------------------------------------}

constructor TGPoint.Create(iObjList: TGeoObjListe; iX, iY: Double; iis_visible : Boolean);
  begin
  Inherited Create (iObjList, False);
  FQuant   := 0;
  friends  := TObjPtrList.Create(False);
  If ClassType = TGPoint then begin
    SetGraphTools(0, DefBasePointStyle, 0, clBlack);
    If ObjList.Count > 0 then begin  { Koordinatensystem vorhanden }
      scrx := SafeRound(iX);
      scry := SafeRound(iY);
      ObjList.GetLogCoords(scrx, scry, X, Y);
      X := Quantisized(X, FQuant);
      Y := Quantisized(Y, FQuant);
      end
    else begin
      X := Quantisized(iX, FQuant);
      Y := Quantisized(iY, FQuant);
      end;
    ObjList.GetWinCoords(X, Y, scrx, scry);
    If iis_visible then
      FStatus := FStatus or gs_ShowsAlways;
    DrawIt;
    end
  else
    SetGraphTools(0, DefConstrPointStyle, 0, clBlack);
  end;

constructor TGPoint.CreateAsLatticePt(iObjList: TGeoObjListe; iX, iY: Double; iis_visible : Boolean);
  var ux, uy : Double;
  begin
  Inherited Create (iObjList, False);
  FQuant   := 1;
  friends  := TObjPtrList.Create(False);
  SetGraphTools(0, DefBasePointStyle, 0, clBlack);
  ObjList.GetLogCoords(Round(iX), Round(iY), ux, uy);
  X := Quantisized(ux, FQuant);
  Y := Quantisized(uy, FQuant);
  ObjList.GetWinCoords(X, Y, scrx, scry);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  DrawIt;
  end;

constructor TGPoint.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  var i : Integer;
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  friends  := TObjPtrList.Create(False);
  If GO = Nil then begin
    X := 0;
    Y := 0;
    end
  else begin
    X := GO.X;
    Y := GO.Y;
    FBoundParam := (GO as TGPoint).BoundParam;
    For i := 0 to Pred((GO as TGPoint).Friends.Count) do
      If TGeoObj((GO as TGPoint).Friends[i]).IsMakMarked then
        Friends.Add(Pointer((TGPoint((GO as TGPoint).Friends[i])).GeoNum));
    end;
  end;

procedure TGPoint.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  FBoundParam := TGPoint(BluePrint).BoundParam;
  friends    := TObjPtrList.Create(False);
  end;

constructor TGPoint.Load(S: TFileStream; iObjList: TGeoObjListe);
  begin
  Inherited Load(S, iObjList);
  S.Read(X, SizeOf(X));
  S.Read(Y, SizeOf(Y));
  friends  := TObjPtrList.Load(S);
  Case MyShape of
    0 : begin   { gefüllter Kreis   }
        MyBrushStyle := bsSolid;
        MyShape      := 0;
        end;
    1 : begin   { hohler Kreis      }
        MyBrushStyle := bsClear;
        MyShape      := 0;
        end;
    2 : begin   { gefülltes Quadrat }
        MyBrushStyle := bsSolid;
        MyShape      := 1;
        end;
    3 : begin   { hohles Quadrat    }
        MyBrushStyle := bsClear;
        MyShape      := 1;
        end;
  end; { of case }
  end;

constructor TGPoint.Load32(R: TReader; iObjList: TGeoObjListe);
  var n : Integer;
      s : String;
  begin
  Inherited Load32(R, iObjList);
  X := R.ReadFloat;
  Y := R.ReadFloat;
  n := R.Position;
  try
    s      := R.ReadString;
    FQuant := R.ReadFloat;
    n      := R.Position;
    try
      s        := R.ReadString;
      FAniStep := R.ReadFloat;
    except
      R.Position := n;
      FAniStep   := 0;
    end;
  except
    R.Position := n;
    FQuant     := 0;
  end;
  FBoundParam := R.ReadFloat;
  friends     := TObjPtrList.Load32(R);
  end;

constructor TGPoint.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var dompos, domfriends : IXMLNode;
  begin
  Inherited CreateFromDomData(iObjList, DE);

  FQuant   := 0;
  FAniStep := 0;
  If DE.hasAttribute('quant') then
    FQuant := StrToFloat(DE.getAttribute('quant'));
  If DE.hasAttribute('ani_step') then
    FAniStep := StrToFloat(DE.getAttribute('ani_step'));

  dompos := DE.childNodes.findNode('position', '');
  X := StrToFloat(dompos.getAttribute('x'));
  Y := StrToFloat(dompos.getAttribute('y'));

  friends := TObjPtrList.Create(False);
  domfriends := DE.childNodes.findNode('friends', '');
  If Assigned(domfriends) then
    friends.SetGeoNumString(domfriends.nodeValue);
  end;

procedure TGPoint.RebuildPointers;
  begin
  Inherited RebuildPointers;
  Friends.ResolveGeoNums(ObjList);
  end;

procedure TGPoint.AfterLoading(FromXML: Boolean);
  var i : Integer;
  begin
  Inherited AfterLoading(FromXML);
  If FromXML and (ClassType = TGPoint) and (Parent.Count > 0) then
    IsWaiting := True;
  { 17.07.06: Folgende Schleife hinzugefügt, um zirkuläre Verwandtschaften beim
              Ziehen von Zeichnungen mit Strecken fester Länge zu vermeiden:
    Freunde dürfen nicht permanent als Kinder oder Eltern eingetragen sein!
    ( "Konstruktion" der 'Gleitstrecken' von Difre im Forum ! )             }
  For i := 0 to Pred(friends.Count) do begin
    Children.Remove(friends[i]);
    Parent.Remove(friends[i]);
    end;
  end;

function TGPoint.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var myPosition, domfriends : IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  If quant > epsilon then                         // else:  = 0 !
    Result.setAttribute('quant', FloatToStr(quant));
  If (ObjList <> Nil) and
     (ObjList.FAnimationSource = Self) then       // else:  = 0 !
    Result.setAttribute('ani_step', FloatToStr(FAniStep));

  myPosition := DOMDoc.createNode('position');
  myPosition.setAttribute('x', FloatToStr(X));
  myPosition.setAttribute('y', FloatToStr(Y));
  Result.childNodes.add(myPosition);

  If friends.Count > 0 then begin
    domfriends := DOMDoc.createNode('friends');
    domfriends.nodeValue := friends.GetGeoNumString;
    Result.childNodes.add(domfriends);
    end;
  end;

function TGPoint.CreateI2GElementNode(DOMDoc: IXMLDocument): IXMLNode;
  var coordNode, valNodeX, valNodeY : IXMLNode;
  begin
  coordNode := DOMDoc.createNode('euclidian_coordinates');
  valNodeX := DOMDoc.createNode('double');
  valNodeX.NodeValue := FloatToStr(X);
  coordNode.childNodes.add(valNodeX);
  valNodeY := DOMDoc.createNode('double');
  valNodeY.NodeValue := FloatToStr(Y);
  coordNode.childNodes.add(valNodeY);
  Result := DOMDoc.createNode('point');
  Result.setAttribute('id', Name);
  Result.childNodes.add(coordNode);
  end;

function TGPoint.CreateI2GConstraintNode(DOMDoc: IXMLDocument;
                                         ObjNames: TStrings): IXMLNode;
  var PtNode,
      P1Node: IXMLNode;
      TL    : TGLine;
  begin
  Result := Nil;
  If AllParentsInList(ObjNames) then begin
    If Parent.Count = 0 then begin        // Freier Basispunkt
      PtNode := DOMDoc.createNode('point');
      PtNode.setAttribute('out', 'true');
      PtNode.nodeValue := Name;
      Result := DOMDoc.createNode('free_point');
      Result.childNodes.add(PtNode);
      end
    else If IsLineBound(TL) then begin    // An Linie gebundener Basispunkt
      PtNode := DOMDoc.createNode('point');
      PtNode.setAttribute('out', 'true');
      PtNode.nodeValue := Name;
      P1Node := DOMDoc.createNode('line');
      P1Node.nodeValue := TGeoObj(Parent[0]).Name;
      Result := DOMDoc.createNode('point_on_line');
      Result.childNodes.add(PtNode);
      Result.childNodes.add(P1Node);
      end;
    end;
  end;

procedure TGPoint.UpdateV1xObjects;
  var TL : TGLine;
  begin
  Inherited UpdateV1xObjects;
  If (ClassType = TGPoint) and
     IsLineBound(TL) then
    TL.GetParamFromCoords(X, Y, FBoundParam);
  end;

constructor TGPoint.ConvertFromCoordPt(CPt: TGPoint);
  var NO : TGName;
      n  : Integer;
  begin
  Inherited Create (CPt.ObjList, CPt.IsVisible);
  friends := TObjPtrList.Create(False);

  n := ObjList.DragList.IndexOf(CPt);
  If n >= 0 then
    ObjList.DragList.Items[n] := Self;

  With CPt do begin
    Stops2BeChildOf(ObjList.Items[4]);
    HideIt;
    ShowsAlways := False;
    end;

  FGeoNum := CPt.GeoNum;                          { GeoNummer übernehmen   }
  CPt.FGeoNum := 30000;
  If CPt.HasNameObj(NO) then begin                { Namens-Objekt wird als Kind   }
    FStatus := FStatus or gs_HasNameObj;          { übernommen (*); hier werden   }
    FShowNameInNameObj := CPt.ShowNameInNameObj;  { nur Verwaltungsdaten verbucht }
    FShowDataInNameObj := CPt.ShowDataInNameObj;
    end;

  X  := CPt.X;
  Y  := CPt.Y;
  scrx := CPt.scrx;
  scry := CPt.scry;
  SetGraphTools(0, DefBasePointStyle,      { Grafik-Attribute setzen }
                0, CPt.MyColour);          { Nur Farbe übernehmen !  }

  AdoptAllChildrenOf(CPt);                 { Kinder übernehmen       }
  FName   := CPt.Name;                     { Name übernehmen         }
  If IsVisible then
    DrawIt;
  end;        { Freunde müssen extern ermittelt und verbucht werden. }

function TGPoint.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('P');
  end;

function TGPoint.CanControlAnimation: Boolean;
  var CL : TGLine;
  begin
  Result := IsLineBound(CL) and
            ((CL is TGShortLine) or
             (CL is TGCircle) or
             (CL is TGPolygon) or
             ((CL is TGConic) and (TGConic(CL).IsClosedLine)));
  end;

function TGPoint.AniCtrlObjName: String;
  var CarrierLine : TGLine;
  begin
  If IsLineBound(CarrierLine) then
    Result := Format(MyMess[7], [Name, CarrierLine.Name])
  else
    Result := '';
  end;

procedure TGPoint.SetAniParams(vmin, vact, vmax, vstep: Double);
  { vmin und vmax werden ignoriert, weil die Bereichsgrenzen
    feste Standardwerte haben (nämlich 0 und 1)              }
  begin
  FAniStep := vstep;
  If (vact >= 0) and (vact <= 1) then
    AniValue := Boxed(vact);
  end;


procedure TGPoint.AdjustGraphTools(todraw : Boolean);
  begin
  Inherited AdjustGraphTools(todraw);
  With ObjList.TargetCanvas do
    If todraw then begin
      Brush.Color := Pen.Color;
      Brush.Style := MyBrushStyle;
      If ShowDataInNameObj then
        Font.Assign(ObjList.StartFont);
      end
    else begin
      Brush.Color := ObjList.BackGroundColor;
      Brush.Style := bsSolid;
      end;
  end;

procedure TGPoint.DrawIt;
  begin
  If IsVisible and (MyColour <> ObjList.BackgroundColor) then
    with ObjList.TargetCanvas do begin
      AdjustGraphTools(True);
      Case MyShape of
        0, 2, 6 : Ellipse(scrx - PointSize,     scry - PointSize,
                          scrx + PointSize + 1, scry + PointSize + 1);
        1, 3, 7 : Rectangle(scrx - PointSize + 1, scry - PointSize + 1,
                            scrx + PointSize,     scry + PointSize);
        4, 8    : draw_cross_on(ObjList.TargetCanvas, act_pixelPerXcm, scrx, scry, PointSize);
        5, 9    : draw_xcross_on(ObjList.TargetCanvas, act_pixelPerXcm, scrx, scry, PointSize);
      end; { of case }
      end;
  end;

procedure TGPoint.HideIt;
  var xn, yn : Integer;
  begin
  If IsVisible and (MyColour <> ObjList.BackgroundColor) then
    with ObjList.TargetCanvas do begin
      AdjustGraphTools(False);
      ObjList.GetWinCoords(X, Y, xn, yn);
      Case MyShape of
        0, 2, 6 : Ellipse(scrx - PointSize,     scry - PointSize,
                          scrx + PointSize + 1, scry + PointSize + 1);
        1, 3, 7 : Rectangle(scrx - PointSize + 1, scry - PointSize + 1,
                            scrx + PointSize,     scry + PointSize);
        4, 8 : draw_cross_on(ObjList.TargetCanvas, act_pixelPerXcm, scrx, scry, PointSize);
        5, 9 : draw_xcross_on(ObjList.TargetCanvas, act_pixelPerXcm, scrx, scry, PointSize);
      end; { of case }
      end;
  end;

function TGPoint.IsDynamicLocLineControl: Boolean;
  var TL : TGLine;
  begin
  Result := (ClassType = TGPoint) and IsLineBound(TL);
  end;

function TGPoint.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  var TL : TGLine;
  begin
  Case ClassGroupId of
    ccAnyPoint, ccPointOrShortLn,
    ccPointOrVector, ccPointOrArc,
    ccPointOrStraightLn, ccDistableObj,
    ccMappableObj, ccMakroDefObj,
    ccPointOrAngle,
    ccPointOrCircle : Result := True;
    ccDragableObj   : Result := (ClassType = TGPoint) and
                                (Not IsLineBound(TL) or Not (TL is TGLocLine) or
                                 TL.DataCanShow);
    ccBasePoint     : Result := (ClassType = TGPoint);
    ccPointWParents : Result := (Parent.Count > 0);
    ccPointWOParents: Result := (Parent.Count = 0);
    ccPointOnCurve  : Result := ((ClassType = TGPoint) and IsLineBound(TL) and
                                 TL.CanCarryTangentPoints) or
                                IsParentOfCurve;
  else
    Result := Inherited IsCompatibleWith(ClassGroupId);
  end { of case }
  end;

function TGPoint.Dist(xm, ym: Double) : Double;
  begin
  LastDist := Hypot(X - xm, Y - ym);
  Dist := LastDist;
  end;

function TGPoint.IsNearMouse: Boolean;
  begin
  Result := Hypot(scrx - ObjList.LastMousePos.X,
                    scry - ObjList.LastMousePos.Y) < CatchDist;
  end;

function TGPoint.GetAniMinValue: Double;
  begin
  Result := 0;
  end;

function  TGPoint.GetAniMaxValue: Double;
  var CL : TGLine;
  begin
  Result := 1;    { korrekt für Bindung an Kreis und Strecke }
  If IsLineBound(CL) and
     (CL is TGPolygon) then        { Extrawurst für Polygone }
    Result := CL.Parent.Count;
  end;

function  TGPoint.GetAniValue: Double;
  begin
  Result := BoundParam;
  end;

procedure TGPoint.SetAniValue(nav: Double);
  { Setzt voraus, dass in der übergeordneten GeoObjListe (ObjList) schon
    die DragList mit diesem Punkt und seinen Kindern gefüllt wurde.
    Nur dann wird die Zeichnung automatisch korrekt aktualisiert.   }
  var i : Integer;
  begin
  nav := Boxed(nav);
  If nav <> BoundParam then begin
    If IsVisible then HideIt;
    SetLinePosition(nav);
    UpdateScreenCoords;
    If IsVisible then DrawIt;
    For i := 1 to Pred(ObjList.DragList.Count) do
      TGeoObj(ObjList.DragList[i]).UpdateParams;
    end;
  end;

procedure TGPoint.SetIsFlagged(flag: Boolean);
  var i     : Integer;
  begin
  If flag <> IsFlagged then begin
    Inherited SetIsFlagged(flag);
    i := Pred(Friends.Count);
    While i >= 0 do begin      { Kann nicht durch eine FOR-Schleife ersetzt werden ! }
      If i < Friends.Count then
        TGeoObj(Friends[i]).IsFlagged := flag;
      Dec(i);
      end;
    end;
  end;

procedure TGPoint.SetQuant(newVal: Double);
  begin
  If Abs(FQuant - newVal) > epsilon then
    FQuant := newVal;
  end;

procedure TGPoint.SetIsWaiting(flag: Boolean);
  begin
  If IsWaiting <> flag then
    If flag then
      FStatus := FStatus or gs_IsWaiting
    else
      FStatus := FStatus and (Not gs_IsWaiting);
  end;

function TGPoint.GetIsWaiting: Boolean;
  begin
  Result := FStatus and gs_IsWaiting > 0;
  end;

procedure TGPoint.BecomesChildOf(GO: TGeoObj);
  begin
  If (GO <> Nil) and                      { Falls es kein Eltern-Objekt gibt oder  }
     (Parent.IndexOf(GO) < 0) then begin  { GO schon permanenter Elter ist: raus ! }
    GO.Children.Add(Self);
    If (ClassType = TGPoint) and  { Bei Basispunkten, die an eine Linie   }
       (GO is TGLine) then          { gebunden sind, wird diese Linie     }
      Parent.Insert(0, GO)          { als *erster* Elter eingefügt;       }
    else                          { andernfalls wird der neue Elter       }
      Parent.Add(GO);               { hinten angehängt.                   }
    end;
  end;

procedure TGPoint.CheckChildLinesCBDI;
  var i : Integer;
  begin
  i := 0;
  While i < Children.Count do begin
    If TGeoObj(Children[i]) is TGLine then
      TGLine(Children[i]).Set_CBDI;
    i := i + 1;
    end;
  end;

procedure TGPoint.CheckFriendlyLinks;
  var i : Integer;
  begin
  i := 0;
  While i < Children.Count do begin
    If TGeoObj(Children[i]) is TGFixLine then
      TGFixLine(Children[i]).AdjustFriendlyLinks;
    i := i + 1;
    end;
  end;


function TGPoint.IsFriendOf(GO: TGeoObj): Boolean;
  var IFO : Boolean;
      i   : Integer;
  begin
  IFO := False;
  For i := 0 to Pred(Friends.Count) do
    If Friends.Items[i] = GO then
      IFO := True;
  IsFriendOf := IFO;
  end;


function TGPoint.IsInLoopOfCLSegments: Boolean;
  { Ist dieser Punkt ein Eckpunkt in einem Ring aus Strecken fester Länge?
    ( CLSegments = "C"onstant "L"ength "Segments" )                        }

  function CountCLSegments(takeAll: Boolean) : Integer;
    var n, i : Integer;
    begin
    n := 0;
    For i := 0 to Pred(Children.Count) do begin
      If (TGeoObj(Children[i]) is TGFixLine) and
         (takeAll or TGeoObj(Children[i]).IsFlagged) then
        n := n + 1;
      end;
    Result := n;
    end;

  function GetCLSegmentChild(nr: Integer): Integer;
    var n, i: Integer;
    begin
    Result := -1;
    n := 0;
    i := 0;
    While i < Children.Count do begin
      If TGeoObj(Children[i]) is TGFixLine then begin
        n := n + 1;
        If n = nr then begin
          Result := i;
          Exit;
          end;
        end;
      i := i + 1;
      end;
    end;

  var actCLS : TGFixLine;
      actFPt : TGPoint;
      CLS_Count, n, i : Integer;

  begin { of IsInLoopOfCLSegments }
  Result := False;
  CLS_Count := CountCLSegments(True);    { Zähle alle!          }
  If CLS_Count > 1 then begin
    FStatus := FStatus or gs_IsFlagged;
    For i := 1 to CLS_Count do begin
      n := GetCLSegmentChild(i);
      actCLS := Children[n];
      If actCLS.Parent[0] = Self then
        actFPt := actCLS.Parent[1]
      else
        actFPt := actCLS.Parent[0];
      actFPt.IsFlagged := True;
      n := CountCLSegments(False);       { nur die ge-Flag-ten! }
      actFPt.IsFlagged := False;
      If n > 1 then begin
        Result := True;
        FStatus := FStatus and Not gs_IsFlagged;
        Exit;
        end;
      end; { of for }
    FStatus := FStatus and Not gs_IsFlagged;
    end { of outer if }
  else
    Result := False;
  end;  { of IsInLoopOfCLSegments }

function TGPoint.IsEndOfFixLine: Boolean;
  var i : Integer;
  begin
  Result := False;
  If (ClassType = TGPoint) and (Parent.Count > 0) then
    For i := 0 to Pred(Friends.Count) do
      If Parent.IndexOf(Friends[i]) >= 0 then
        Result := True;
  end;

function TGPoint.IsIncidentWith(line: TGLine): Boolean;
  { Liefert genau dann TRUE, wenn aufgrund der Verwandtschaftsverhältnisse
    zweifelsfrei feststeht, dass dieser Punkt stets auf der Linie "line"
    liegt.
    Achtung !!! Selbst wenn die Funktion "FALSE" liefert, kann möglicher-
                weise trotzdem Inzidenz vorliegen, z.B. bei einem gespie-
                gelten Punkt, der auf einer gespiegelten Geraden liegt!
    28.11.09 :  Der Fall der definierenden Punkte wurde überarbeitet. Statt
                umfangreicher Fallunterscheidungen nach Linien-Klassen wird
                nun die virtuelle Funktion TGLine.GetParentPointOnSelf()
                benutzt, um den aktuellen Punkt mit allen in Frage kommen-
                den Elternpunkten der Linie zu vergleichen.                }
  var ppt : TGPoint;
      i   : Integer;
  begin
  Result := False;
  If (ClassType = TGPoint) and (Parent.Count = 1) and
     (Parent[0] = line) then  //  Punkt ist an die Linie gebunden !
    Result := True
  else begin                  // Ist der Punkt Elter der Linie und
    i := 1;                   //   läuft sie durch ihn hindurch ?
    Repeat
      ppt := line.GetParentPointOnSelf(i);
      if ppt = Self then
        Result := True
      else
        i := i + 1;
    until (ppt = Nil) or Result;
    end;
  end;

procedure TGPoint.StartFriendshipWith(GO: TGeoObj);
  begin
  If (GO <> Nil) and
     (friends.IndexOf(GO) < 0) then begin
    friends.Add(GO);
    TGPoint(GO).friends.Add(Self);
    end;
  end;

procedure TGPoint.EndFriendshipWith(GO: TGeoObj);
  begin
  If (GO <> Nil) and
     (friends.IndexOf(GO) >= 0) then begin
    friends.Remove(GO);
    TGPoint(GO).friends.Remove(Self);
    If Children.IndexOf(GO) >= 0 then
      (TGPoint(GO)).Stops2BeChildOf(Self);
    If Parent.IndexOf(GO) >= 0 then
      Stops2BeChildOf(GO);
    end;
  end;

procedure TGPoint.RejectTemporaryParents;
  var i : Integer;
  begin
  For i := Pred(Parent.Count) downTo 0 do
    If Friends.IndexOf(Parent[i]) >= 0 then
      Stops2BeChildOf(Parent[i]);
  end;

procedure TGPoint.SetGraphTools(LineStyleNum, PointStyleNum,
                                FillStyleNum: Integer; iColor: TColor);
  var WasVisible: Boolean;
  begin
  wasVisible  := IsVisible;
  ShowsAlways := False;

  MyPenStyle := psSolid;       { LineStyleNum ignorieren }
  if PointStyleNum > 5 then
    MyShape := PointStyleNum - 4
  else
    MyShape := PointStyleNum;
  MyColour   := iColor;
  If (PointStyleNum < 2) or (PointStyleNum > 5) then
    MyLineWidth := 1
  else
    MyLineWidth := 3;
  If MyShape < 2 then
    MyBrushStyle := bsSolid    { FillStyleNum ignorieren }
  else
    MyBrushStyle := bsClear;

  ShowsAlways := wasVisible;
  end;

function TGPoint.GetMatchingCursor(mpt: TPoint): TCursor;
  begin
  If ClassType = TGPoint then
    Result := Drag_Cursor
  else
    Result := Inherited GetMatchingCursor(mpt);
  end;

procedure TGPoint.GetGraphTools(var LineStyleNum, PointStyleNum,
                                    FillStyleNum: Integer; var iColor: TColor);
  begin
  PointStyleNum := MyShape;
  iColor        := MyColour;
  If (MyShape >= 2) and (MyLineWidth = 3) then
    LineStyleNum := 1;
  end;

function TGPoint.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  If ClassType = TGPoint then
    Result := False            { Basispunkte sind immer unterschiedlich !}
  else
    Result := Inherited HasSameDataAs(GO);
  end;

function TGPoint.IsParentOfCurve: Boolean;
  { Sucht in der eigenen Kinder-Liste, ob es eine Kurve gibt,
    die von diesem Punkte abhängt.                             }
  var i : Integer;
  begin
  Result := False;
  i := 0;
  While (Not Result) and (i < Children.Count) do
    If ( (TGeoObj(Children[i]) is TGCurve) or
         (TGeoObj(Children[i]) is TGCircle) ) and
       ( IsIncidentWith(Children[i])   ) then
      Result := True
    else
      i := i + 1;
  end;

function TGPoint.IsLineBound(var TL : TGLine) : Boolean;
  var i : Integer;
  begin
  TL     := Nil;
  Result := False;
  If ClassType = TGPoint then begin
    i  := 0;
    While (Not Result) and (i < Parent.Count) do
      If (TGeoObj(Parent[i]) is TGLine) or
         (TGeoObj(Parent[i]) is TGPolygon) then begin
        TL := Parent[i];
        Result := True;
        end
      else
        Inc(i);
    end;
  end;

function TGPoint.IsAngleVertex(var ao: TGeoObj) : Boolean;
  var i  : Integer;
      go : TGeoObj;
  begin
  Result := False;
  for i := 0 to Pred(Children.Count) do begin
    go := TGeoObj(Children.Items[i]);
    if (go is TGAngle) and (go.Parent.Items[1] = Self) then begin
      ao := go;
      Result := True;
      end;
    end;
  end;

procedure TGPoint.VirtualizeCoords;
  var TL : TGLine;
  begin
  Inherited VirtualizeCoords;
  If (ClassType = TGPoint) and
     DataValid and IsLineBound(TL) then
    TL.GetParamFromCoords(X, Y, FBoundParam);
  end;

procedure TGPoint.DragMove(dx, dy: Double);
  begin
  HideIt;
  X := X + dx;
  Y := Y + dy;
  UpdateScreenCoords;
  DrawIt;
  end;

procedure TGPoint.DragRotate(delta, xm, ym: Double);
  var rdx, rdy : Double;
  begin
  HideIt;
  RotateVector2ByAngle(X-xm, Y-ym, delta, rdx, rdy);
  X := xm + rdx;
  Y := ym + rdy;
  UpdateScreenCoords;
  DrawIt;
  end;

procedure TGPoint.UpdateParams;
  var TP, TQ : TGPoint;        { "TrägerPunkt" }
      CL     : TGLine;         { "CarrierLine" }
      i      : Integer;
      xm, ym, dx, dy, s, r, r2,
      S1x, S1y, S2x, S2y,
      old_x, old_y         : Double;
      S1_valid, S2_valid   : Boolean;

  function CannotStopWaiting: Boolean;
    begin
    Assert(Parent.Count > 0, 'Free Point called CannotStopWaiting !');
    If TGLine(Parent[0]).DataValid then begin
      TGLine(Parent[0]).GetParamFromCoords(X, Y, FBoundParam);
      If TGLine(Parent[0]) is TGShortLine then
        If BoundParam < 0 then                   // Punkte an
          FBoundParam := 0                       // Strecken
        else if BoundParam > 1 then              // anklemmen
          FBoundParam := 1;                      // falls nötig
      IsWaiting := False;
      Result := False;
      end
    else begin
      DataValid := False;
      Result := True;
      end;
    end;

  begin
  If IsWaiting and CannotStopWaiting then   // IsWaiting kann nur TRUE sein,
    Exit;                                   // wenn der Punkt gebunden ist !

  DataValid := True;        { Nehmen wir mal an .... }
  old_x := X;
  old_y := Y;
  TP := Nil; TQ := Nil; CL := Nil;
  If Parent.Count = 0 then  { freier Basispunkt }
    if ObjList.DraggedObj = Self then begin
      X := Quantisized(ObjList.LogLastMouse_X, FQuant);
      Y := Quantisized(ObjList.LogLastMouse_Y, FQuant);
      end
    else
      { Nix zu tun !!! }
  else begin                { gebundener und/oder befreundeter Basispunkt      }
    If (ObjList.DraggedObj = Self) and { Der Punkt selbst wird gezogen...}
       (ObjList.UpdatingLocLine = Nil) then begin
      xm := ObjList.LogLastMouse_X;
      ym := ObjList.LogLastMouse_Y;
      end
    else begin                         { Die Trägerlinie oder ein Freund }
      xm := X;                         { wird gezogen...                 }
      ym := Y;
      end;

    i := 0;
    While i < Parent.Count do
      If Not TGeoObj(Parent.Items[i]).DataValid then begin { Alle Ahnen gültig?}
        DataValid := False;          { Falls nicht: Punkt ungültig machen!     }
        Exit;                        { Dies verhindert (u.a.) Reste gebundener }
        end                          {     Punkte mit ungültiger Trägerlinie.  }
      else begin
        If TGeoObj(Parent.Items[i]) is TGPoint then
          If TP = Nil then
            TP := Parent.Items[i]
          else
            TQ := Parent.Items[i]
        else
        If TGeoObj(Parent.Items[i]) is TGLine then
          CL := Parent.Items[i];
        Inc(i);
        end;

    If TP <> Nil then begin    { Punkt ist FixLine-Endpunkt...        }
      { TP ist der (erste) andere Endpunkt,
        es kann zusätzlich noch eine Bindung vorliegen }
      r := ObjList.GetFixLineLength(Self, TP);

      If Parent.Count = 1 then                        {   ...und ist frei                    }
        If r > 0.0 then begin
          dx := xm - TP.X;
          dy := ym - TP.Y;
          s := Hypot(dx, dy);
          If s > DistEpsilon then begin
            s := r / s;
            X := TP.X + s * dx;
            Y := TP.Y + s * dy;
            end;
          end
        else
      else begin                                      {   ...und ist gebunden......          }
        If CL <> Nil then begin                       { .... an eine Linie .....             }
          DataValid := CL.GetLinePtWithDistFrom(TP, r, X, Y);
          end
        else                                          { .... oder an einen anderen Punkt     }
        If TQ <> Nil then begin                       {  (dann gehen (mindestens) 2 Strecken }
          r2 := ObjList.GetFixLineLength(Self, TQ);   {  fester Länge von diesem Punkt aus!).}
          IntersectCircles(TP.X, TP.Y, r, TQ.X, TQ.Y, r2,
                           S1x, S1y, S2x, S2y, S1_valid, S2_valid);
          If S1_valid then begin
            If S2_valid then begin
              If TakeOtherPoint(S1x, S1y, S2x, S2y, TP) then
                IsReversed := Not IsReversed;
              If IsReversed then begin
                X := S2x;
                Y := S2y;
                end
              else begin
                X := S1x;
                Y := S1y;
                end;
              end;
            end
          else
            DataValid := False;
          end
        else                                          { Andernfalls: ERROR !                 }
          DataValid := False;
        end;
      end

    else                       { Punkt ist kein FixLine-Endpunkt     }
      If CL <> Nil then                 {   ... an eine Linie gebunden        }
        If ObjList.DraggedObj <> Self then
          CL.GetCoordsFromParam(BoundParam, X, Y)
        else
          CL.GetLinePtWithMinMouseDist(xm, ym, Quant, X, Y)
      else
        DataValid := False;             { Andernfalls:  ERROR !                }

    If DataValid and           { TV-Daten bereitstellen    }
//       (ObjList.DraggedObj = Self) and
       (CL <> Nil) then
      CL.GetParamFromCoords(X, Y, FBoundParam)
    end;                      { gebundener und/oder befreundeter Basispunkt }

  Last_dx := X - old_x;
  Last_dy := Y - old_y;
  UpdateScreenCoords;
  end;

procedure TGPoint.UpdateScreenCoords;
  begin
  If DataValid then begin
    DataCanShow := ObjList.LogWinContains(X, Y);
    ObjList.GetWinCoords(X, Y, scrx, scry);
    end;
  end;

procedure TGPoint.ExportIt;
  var TL : TGLine;
  begin
  If IsLineBound(TL) then
    UpdateScreenCoords;
  Inherited ExportIt;
  end;

procedure TGPoint.SaveState;
  begin
  If ClassType = TGPoint then begin
    Parent.SaveState;           { Elternliste sichern      }
    RejectTemporaryParents;     { Temporäre Eltern löschen }
    end;
  Inherited SaveState;
  With Old_Data do begin
    push(@Parent.Count, SizeOf(Parent.Count));
    push(@BoundParam, SizeOf(BoundParam));
    push(@Last_dx, SizeOf(Last_dx));
    push(@Last_dy, SizeOf(Last_dy));
    push(@FStatus, SizeOf(FStatus));
    end;
  end;

procedure TGPoint.RestoreState;
  var opc, k  : Integer;
  begin
  With Old_Data do begin
    pop(@FStatus);
    pop(@Last_dy);
    pop(@Last_dx);
    pop(@BoundParam);
    pop(@opc);
    end;
  Inherited RestoreState;
  If ClassType = TGPoint then begin
    Parent.RestoreState;              { Elternliste wiederherstellen... }
    For k := opc to Pred(Parent.Count) do   { ...und Links restaurieren }
      BecomesChildOf(TGeoObj(Parent.Items[k]));
    end;
  end;

procedure TGPoint.RestorePointParams(ppX, ppY: Double;
                                     ppStatus: Integer;
                                     ppdx, ppdy: Double);
  begin
  X := ppX;
  Y := ppY;
  FStatus := ppStatus;
  Last_dx := ppdx;
  Last_dy := ppdy;
  end;

function TGPoint.SetLinePosition(tv: Double): Boolean;
  var TL : TGLine;
      i  : Integer;
  begin
  TL := Nil;
  For i := 0 to Pred(Parent.Count) do
    If TGeoObj(Parent[i]) is TGLine then
      TL := Parent.Items[i];
  If (TL <> Nil) and
     TL.GetCoordsFromParam(tv, X, Y) then begin
    FBoundParam := tv;
    Result := True;
    end
  else
    Result := False;
  end;


procedure TGPoint.SetNewCoords(x_str, y_str: WideString);
  var NO : TGName;
      TL : TGLine;
      term : TTBaum;
  begin
  If IsLineBound(TL) and (TL is TGFunktion) then begin
    HideIt;
    term := TTBaum.Create(Self.ObjList, rad);
    try
      term.BuildTree(x_str);
      If term.is_okay then begin
        term.Calculate(1, X);
        TGFunktion(TL).GetFunctionValue(X, Y);
        TL.GetParamFromCoords(X, Y, FBoundParam);
        UpdateParams;
        end;
    finally
      term.Free;
    end; {of try }
    DrawIt;
    If HasNameObj(NO) then
      UpdateNameCoordsIn(NO);
    end;
  end;


procedure TGPoint.Register4Dragging(DragList: TObjPtrList);
  begin
  Inherited Register4Dragging(DragList);
  Last_dx := 0;
  Last_dy := 0;
  end;


function TGPoint.TakeOtherPoint(x1, y1, x2, y2 : Double; FP: TGPoint): Boolean;
  var pu,
      d12, d22,
      ds1, ds2,   { (> 0) <==> die Winkeländerung des Wegs < 90° }
      Last_dr2  : Double;
      OEPt      : TGPoint;
      i         : Integer;

  begin
  If IsReversed then begin
    pu := x1; x1 := x2; x2 := pu;
    pu := y1; y1 := y2; y2 := pu;
    end;
  Last_dr2 := Sqr(Last_dx) + Sqr(Last_dy);
  d12 := Sqr(x1-X) + Sqr(y1-Y);
  d22 := Sqr(x2-X) + Sqr(y2-Y);
  If (ObjList.DragStrategy = 1) and
     (Last_dr2 > epsilon) then begin
    ds1 := (x1 - X) * Last_dx + (y1 - Y) * Last_dy;
    ds2 := (x2 - X) * Last_dx + (y2 - Y) * Last_dy;
    If (d22 < 100 * d12) then
      If (ds1 < 0) then
        Result := (ObjList.MouseGoes = ForwardMove) and  (ds2 > 0)
      else { ds1 > 0 }
        Result := (ObjList.MouseGoes = BackMove   ) and  (ds2 < 0)
    else
      Result := False;
    end
  else
    Result := d22 < d12;

  { 19.03.2002 :  Der folgende Code wurde eingebaut, um zu verhindern,
    daß zwei verschiedene Strecken fester Länge aufeinander fallen und
    identisch werden. Der Anlaß war die Konstruktion eines Ellipsenzirkels
    aus zwei Strecken fester Länge.
    Der übergebene Punkt FP ist der Punkt am anderen Ende derjenigen
    Strecke fester Länge, die von Self ausgeht. Wenn von FP noch eine
    *zweite* Strecke fester Länge ausgeht, dann wird darauf geachtet, daß
    [Self, FP] nicht mit dieser zweiten Strecke zusammenfällt.
    Im übrigen liefert der Ellipsenzirkel aus zwei Strecken fester Länge
    *keine* dynamische Ellipse, weil der Zugpunkt nicht an eine Linie
    gebunden ist.                                                         }

  If FP.Children.Count > 1 then
    For i := 0 to Pred(FP.Children.Count) do
      If (TGeoObj(FP.Children[i]) is TGFixLine) and
         (TGFixLine(FP.Children[i]).Parent.IndexOf(Self) < 0) then begin
        With TGFixLine(FP.Children[i]).Parent do begin
          If IndexOf(FP) = 0 then
            OEPt := Items[1]
          else
            OEPt := Items[0];
          end;
        d12 := Hypot(x1 - OEPt.X, y1 - OEPt.Y);
        d22 := Hypot(x2 - OEPt.X, y2 - OEPt.Y);
        If ((d22 < DistEpsilon) or (d12 < DistEpsilon)) and
           (d22 > d12) then
          Result := Not Result;
        end;
  end;


procedure TGPoint.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  var TL : TGLine;
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, cme_ptform, CME_PopupClick, cmd_EditPointStyle);
  If ShowDataInNameObj then
    AddPopupMenuItemTo(menu, cme_hidecoords, CME_PopupClick, cmd_NoData)
  else
    AddPopupMenuItemTo(menu, cme_showcoords, CME_PopupClick, cmd_AddData);
  If ClassType = TGPoint then begin   // Nur für Basispunkte !
    AddPopupMenuItemTo(menu, '-', Nil, 0);
    If IsLineBound(TL) then
      AddPopupMenuItemTo(menu, cme_ptfree, CME_PopupClick, cmd_ReleaseP)
    else
      AddPopupMenuItemTo(menu, cme_ptbind, CME_PopupClick, cmd_BindP2L);
    If Parent.Count = 0 then
      AddPopupMenuItemTo(menu, cme_ptfix, CME_PopupClick, cmd_FixPt);
    If (Friends.Count = 0) and
       ((Parent.Count = 0) or (TGeoObj(Parent[0]) is TGFunktion)) then
      AddPopupMenuItemTo(menu, cme_ptquant, CME_PopupClick, cmd_QuantP);
    If Assigned(TL) then
      If TL is TGFunktion then
        AddPopupMenuItemTo(menu, cme_xedit, CME_PopupClick, cmd_EditXCoord)
      else
    else begin // point is not line bound !
      AddPopupMenuItemTo(menu, '-', Nil, 0);
      AddPopupMenuItemTo(menu, cme_setdotpt, CME_PopupClick, cmd_SetDotPt);
      end;
    end;
  end;

function TGPoint.GetDataStr: String;
  begin
  Result := ' (' + Float2Str(X, 2) + ' | ' + Float2Str(Y, 2) + ') ';
  end;

function TGPoint.GetInfo: String;
  begin
  If Parent.Count > 0 then begin
    Result := MyObjTxt[35];
    InsertNameOf(Self, Result);
    InsertNameOf(TGeoObj(Parent[0]), Result);
    end
  else begin
    Result := MyObjTxt[0];
    InsertNameOf(Self, Result);
    end;
  end;

destructor TGPoint.Destroy;
  begin
  FreeAndNil(Friends);
  IsFlagged := False;
  Inherited Destroy;
  end;

destructor TGPoint.FreeBluePrint;
  begin
  FreeAndNil(Friends);
  IsFlagged := False;
  inherited FreeBluePrint;
  end;

{--------------------------------------------------}
{ TGCoordPt's method implementations:              }
{--------------------------------------------------}

constructor TGCoordPt.Create(iObjList: TGeoObjListe; iXc, iYc: Double; iis_visible : Boolean);
  var pGO : TGeoObj;
  begin
  Inherited Create(iObjList, iXc, iXc, False);
  pGO := TGeoObj(ObjList.Items[4]);
  BecomesChildOf(pGO);
  UpdateParams;
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  DrawIt;
  end;

constructor TGCoordPt.ConvertFromBasePt(BPt: TGPoint);
  var OtherPt : TGPoint;
      is_vis  : Boolean;
      n       : Integer;
  begin
  Inherited Create(BPt.ObjList, BPt.X, BPt.Y, False);   { Koordinaten übernehmen }

  n := ObjList.DragList.IndexOf(BPt);
  If n >= 0 then
    ObjList.DragList.Items[n] := Self;

  FGeoNum := BPt.GeoNum;                   { GeoNummer übernehmen    }
  BPt.FGeoNum := 30000;
  FStatus := BPt.Status;                   { Status übernehmen       }
  BecomesChildOf(TGeoObj(ObjList.Items[4]));
  SetGraphTools(0, DefConstrPointStyle,    { Grafik-Attribute setzen }
                0, BPt.MyColour);          { Nur Farbe übernehmen !  }

  AdoptAllChildrenOf(BPt);                 { Kinder übernehmen       }
  With BPt do begin                        { Freunde ebenfalls als   }
    is_vis := ShowsAlways;                 {     Kinder übernehmen   }
    HideIt;
    ShowsAlways := False;
    While Friends.Count > 0 do begin
      OtherPt := Friends[0];
      EndFriendShipWith(OtherPt);
      OtherPt.BecomesChildOf(Self);
      end;
    end;
  ShowsAlways := is_vis;                   { Sichtbarkeit übernehmen }
  FName := BPt.Name;                       { Name übernehmen         }
  end;

constructor TGCoordPt.Load(S: TFileStream; iObjList: TGeoObjListe);
  var Xc, Yc : Double;
  begin
  Inherited Load(S, iObjList);
  S.Read(Xc, SizeOf(Xc));
  S.Read(Yc, SizeOf(Yc));
  end;

constructor TGCoordPt.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  R.SkipValue;  //  Xc := R.ReadFloat;
  R.SkipValue;  //  Yc := R.ReadFloat;
  end;

function TGCoordPt.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccCoordPoint, ccPointWOParents]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGCoordPt.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := False;
  end;

procedure TGCoordPt.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  BecomesChildOf(TGeoObj(ObjList.Items[4]));
  end;

procedure TGCoordPt.UpdateParams;
  begin
  UpdateScreenCoords;
  end;

procedure TGCoordPt.Clip2Grid;
  begin
  HideIt;
  X := Round(X);
  Y := Round(Y);
  UpdateParams;
  DrawIt;
  end;

function TGCoordPt.GetInfo: String;
  var arg : Array [0..1] of String;
  begin
  arg[0] := Float2Str(X, 3);
  arg[1] := Float2Str(Y, 3);
  Result := Format(MyObjTxt[1], [arg[0], arg[1]]);
  InsertNameOf(Self, Result);
  end;



{--------------------------------------------------}
{ TGXPoint's method implementations:               }
{--------------------------------------------------}

constructor TGXPoint.Create(iObjList: TGeoObjListe; iXTerm, iYTerm: WideString;
                            iis_visible: Boolean);
  begin
  Inherited Create(iObjList, 0, 0, False);
  XTerm := TTBaum.Create(ObjList, Rad);
  XTerm.BuildTree(iXTerm);
  XTerm.BuildString;
  YTerm := TTBaum.Create(ObjList, Rad);
  YTerm.BuildTree(iYTerm);
  YTerm.BuildString;
  BecomesChildOf(ObjList.Items[0]); { Ist nötig für korrekten Zugmodus! }
  XTerm.RegisterTermParentsIn(Self);
  YTerm.RegisterTermParentsIn(Self);
  If XTerm.is_const and YTerm.is_const then
    SetGraphTools(0, DefCoordPointStyle, 0, MyColour)
  else
    SetGraphTools(0, DefConstrPointStyle, 0, MyColour);
  UpdateParams;
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  DrawIt;
  end;

constructor TGXPoint.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  inherited CreateBluePrintOf(GO, iGeoNum);
  XTerm := TTBaum.CopyFrom(TGXPoint(GO).XTerm);
  YTerm := TTBaum.CopyFrom(TGXPoint(GO).YTerm);
  XTerm.Drawing := Nil;
  YTerm.Drawing := Nil;
  end;

constructor TGXPoint.ConvertFromBasePt(BPt: TGPoint);
  var OtherPt : TGPoint;
      NO      : TGName;
      is_vis  : Boolean;
  begin
  Inherited Create(BPt.ObjList, 0, 0, False);
  X := BPt.X;                              { Koordinaten übernehmen       }
  Y := BPt.Y;
  scrx := BPt.scrx;
  scry := BPt.scry;
  XTerm := TTBaum.Create(ObjList, Rad);
  XTerm.BuildTree(FloatToStr(X));
  XTerm.BuildString;
  YTerm := TTBaum.Create(ObjList, Rad);
  YTerm.BuildTree(FloatToStr(Y));
  YTerm.BuildString;
  BecomesChildOf(ObjList.Items[0]);        { nötig für korrekten Zugmodus  }

  FGeoNum      := BPt.GeoNum;              { GeoNummer übernehmen          }
  BPt.FGeoNum  := 30000;
  If BPt.HasNameObj(NO) then begin         { Namens-Objekt wird als Kind   }
    FStatus := FStatus or gs_HasNameObj;          { übernommen (*); hier werden   }
    FShowNameInNameObj := BPt.ShowNameInNameObj;  { nur Verwaltungsdaten verbucht }
    FShowDataInNameObj := BPt.ShowDataInNameObj;
    end;
  SetGraphTools(0, DefCoordPointStyle,     { Grafik-Attribute setzen }
                0, BPt.MyColour);          { Nur Farbe übernehmen !  }

  AdoptAllChildrenOf(BPt);                 { Kinder übernehmen       }
  With BPt do begin                        { Freunde ebenfalls als   }
    is_vis := ShowsAlways;                 {     Kinder übernehmen   }
    HideIt;
    ShowsAlways := False;
    While Friends.Count > 0 do begin
      OtherPt := Friends[0];
      EndFriendShipWith(OtherPt);
      OtherPt.BecomesChildOf(Self);
      end;
    end;
  ShowsAlways := is_vis;                   { Sichtbarkeit übernehmen }
  FName := BPt.Name;                       { Name übernehmen         }
  end;

constructor TGXPoint.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  inherited Load32(R, iObjList);
  XTerm := TTBaum.Load32(ObjList, R);
  YTerm := TTBaum.Load32(ObjList, R);
  end;

constructor TGXPoint.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  { 09.03.2011 : Bugmeldung von Prof. Roth, distributivgesetz.geo (erstellt
                 mit v2.7) lässt sich nicht mehr öffnen. Ursache waren Null-
    strings als Sourcen für die y-Terme von Punkten mit bestimmten Koordi-
    naten. Die hier folgenden Ausnahmebehandlungen (try..except..end)
    sollten das Problem beheben.                                           }
  var s : WideString;
      posNode : IXMLNode;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  posNode := DE.childNodes.findNode('position', '');
  If posNode <> Nil then with posNode do begin
    try
      if hasAttribute('x_term') then
        s := getAttribute('x_term')
      else
        if hasAttribute('x') then
          s := getAttribute('x')
        else
          s := '';
      if ( Length(s) > 0 ) then begin
        s := literalLine(s);
        if Length(s) = 0 then
          s := '0';
        end
      else
        s := '0';
    except
      s := FloatToStr(X);
    end;
    XTerm := TTBaum.Create(ObjList, ObjList.GetDefAngleMode);
    XTerm.source_str := s;

    try
      if hasAttribute('y_term') then
        s := getAttribute('y_term')
      else
        if hasAttribute('y') then
          s := getAttribute('y')
        else
          s := '';
      if Length(s) > 0 then begin
        s := literalLine(s);
        if Length(s) = 0 then
          s := '0';
        end
      else
        s := '0';
    except
      s := FloatToStr(Y);
    end;
    YTerm := TTBaum.Create(ObjList, ObjList.GetDefAngleMode);
    YTerm.source_str := s;
    end;
  end;

constructor TGXPoint.CreateProtoTypFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var s : WideString;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  With DE.childNodes.findNode('position', '') do begin
    If hasAttribute('x_term') then
      s := literalLine(getAttribute('x_term'))
    else
      s := FloatToStr(X);
    XTerm := TTBaum.Create(iObjList, Rad);
    XTerm.fgeonum_str := s;
    If hasAttribute('y_term') then
      s := literalLine(getAttribute('y_term'))
    else
      s := FloatToStr(Y);
    YTerm := TTBaum.Create(iObjList, Rad);
    YTerm.fgeonum_str := s;
    end;
  end;

function TGXPoint.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var position: IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  position := Result.childNodes.findNode('position', '');
  XTerm.BuildString;
  YTerm.BuildString;
  position.setAttribute('x_term', maskDelimiters(XTerm.source_str));
  position.setAttribute('y_term', maskDelimiters(YTerm.source_str));
  end;

function TGXPoint.CreatePrototypNode(DOMDoc: IXMLDocument): IXMLNode;
  var position: IXMLNode;
      s       : WideString;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  position := Result.childNodes.findNode('position', '');
  s := CDATACompatible(XTerm.GeoNumString);
  position.setAttribute('x_term', s);
  s := CDATACompatible(YTerm.GeoNumString);
  position.setAttribute('y_term', s);
  end;

procedure TGXPoint.AfterLoading(FromXML: Boolean);
  begin
  Inherited AfterLoading(FromXML);
  XTerm.UpdateDegSourceAndBuildTree(XTerm.source_str, False);
  YTerm.UpdateDegSourceAndBuildTree(YTerm.source_str, False);
  end;

procedure TGXPoint.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  FreeAndNil(XTerm);
  XTerm := TTBaum.CreateFromGeoNumString
                    ((BluePrint as TGXPoint).XTerm.GeoNumString, MakNum, ObjList);
  If XTerm.Status = tbOkay then
    XTerm.RegisterTermParentsIn(Self);
  FreeAndNil(YTerm);
  YTerm := TTBaum.CreateFromGeoNumString
                    ((BluePrint as TGXPoint).YTerm.GeoNumString, MakNum, ObjList);
  If YTerm.Status = tbOkay then
    YTerm.RegisterTermParentsIn(Self);
  end;

function TGXPoint.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  var TL : TGLine;
  begin
  If ClassGroupId = ccPointOnCurve then
    Result := IsLineBound(TL)
  else
    Result := (ClassGroupId in [ccCoordPoint, ccPointWOParents]) or
              Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGXPoint.IsLineBound(var TL: TGLine): Boolean;
  { 25.01.10 : Diese Funktion löst das Newton-Problem von Günther Weber!
               Ein XPoint ist genau dann an einen Funktionsgraphen gebunden,
    wenn sein YTerm eine Referenz auf ein entsprechendes Funktions-Objekt
    ist, das an derjenigen Stelle x auszuwerten ist, die der XTerm angibt.

    12.02.12 : Zusätzliche Prüfung auf Nil-Pointer eingebaut [**] wegen
               Fehlermeldung von Andreas Begasse vom 06.02.12
    08.02.13 : Fatalen "Schreibfehler" behoben:
               "YTerm.baum.token = 41"  ==> "...token = 49"  !!!
               Bis Version 3.6 war "41" das Token für ein Funktionsobjekt!
               Ab 3.7 wird dafür das neue Token "49" verwendet, wobei das
               alte Token ("41") nun für die Ermittlung der Steigung einer
               Funktion an einer Stelle benutzt wird.                      }

  var n : Array[1..4] of Integer;
  begin
  TL := Nil;
  Result := False;
  If (YTerm.baum <> Nil) and
     (YTerm.baum.token = 49) and  // Direkte(!) Referenz auf Funktions-Objekt
     (YTerm.baum.right_ch.right_ch <> Nil) and     //   [**]
     ((YTerm.baum.right_ch.right_ch.token = 1) or  // mit Argument "x" oder
      (Yterm.baum.right_ch.right_ch.IsEqual(XTerm.baum))) then begin // XTerm!
    YTerm.baum.right_ch.Read4Int(n[1], n[2], n[3], n[4]);
    TL := ObjList.GetObj(n[1]) as TGLine;
    Result := TL <> Nil;
    end
  end;

function TGXPoint.IsIncidentWith(line: TGLine): Boolean;
  var TL : TGLine;
  begin
  TL     := Nil;
  Result := IsLineBound(TL) and (TL = line);
  end;

function TGXPoint.DataEquivalent(var data): Boolean;
  var vbaum_x,
      vbaum_y  : TTBaum;
      vb_x,
      vb_y,
      vbaumstr : String;
      ts       : Integer;  { "Trennstelle" }
  begin
  vbaumstr := String(data);
  ts := Pos('|', vbaumstr);
  If ts > 0 then begin
    vb_x := Copy(vbaumstr, 1, Pred(ts));
    vb_y := Copy(vbaumstr, Succ(ts), Length(vbaumstr));
    vBaum_x := TTBaum.Create(ObjList, Rad);
    vBaum_y := TTBaum.Create(ObjList, Rad);
    try
      vBaum_x.BuildTree(vb_x);
      vBaum_y.BuildTree(vb_y);
      If (vBaum_x.Status = tbOkay) and
         (vBaum_y.Status = tbOkay) then
        Result := XTerm.HasSameDataAs(vbaum_x) and
                  YTerm.HasSameDataAs(vbaum_y)
      else
        Result := False;
    finally
      vBaum_x.Free;
      vBaum_y.Free;
    end;
    end
  else
    Result := False;
  end;

function TGXPoint.HasSameDataAs(GO: TGeoObj): Boolean;
  var term : String;
  begin
  term := XTerm.source_str + '|' + YTerm.source_str;
  Result := (GO.ClassType = TGXPoint) and
            (TGXPoint(GO).DataEquivalent(term));
  end;

procedure TGXPoint.Clip2Grid;
  begin
  SetNewCoords(IntToStr(Round(X)), IntToStr(Round(Y)));
  end;

procedure TGXPoint.UpdateParams;
  var px, py : Double;
  begin
  DataValid := False;
  XTerm.Calculate(0, px);
  If XTerm.is_okay then begin
    YTerm.Calculate(px, py);
    If YTerm.is_okay then begin
      X := px;
      Y := py;
      DataValid := True;
      UpdateScreenCoords;
      end;
    end;
  end;

procedure TGXPoint.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_xyedit, CME_PopupClick, cmd_EditCoords);
  AddPopupMenuItemTo(menu, cme_xyfree, CME_PopupClick, cmd_UnFixPt)
  end;

procedure TGXPoint.SetNewCoords(x_str, y_str: WideString);
  var NO : TGName;
  begin
  HideIt;
  XTerm.UnregisterTermParentsIn(Self);
  YTerm.UnregisterTermParentsIn(Self);
  XTerm.BuildTree(x_str);
  YTerm.BuildTree(y_str);
  XTerm.RegisterTermParentsIn(Self);
  YTerm.RegisterTermParentsIn(Self);
  UpdateParams;
  DrawIt;
  If HasNameObj(NO) then
    UpdateNameCoordsIn(NO);
  end;

procedure TGXPoint.UpdateOldPrototype;
  begin
  Inherited UpdateOldPrototype;
  XTerm.ConvertSource2GeoNumString;
  YTerm.ConvertSource2GeoNumString;
  end;

procedure TGXPoint.RebuildTermStrings;
  begin
  HideIt;
  XTerm.BuildString;
  YTerm.BuildString;
  DrawIt;
  end;

function TGXPoint.HasBuggyTerm: Boolean;
  begin
  If XTerm.status = tbEmpty then
    XTerm.BuildTree(XTerm.source_str);
  If YTerm.status = tbEmpty then
    YTerm.BuildTree(YTerm.source_str);
  Result := (XTerm.status <= tbCompError) or (YTerm.status <= tbCompError);
  end;

destructor TGXPoint.Destroy;
  begin
  XTerm.UnregisterTermParentsIn(Self);
  YTerm.UnregisterTermParentsIn(Self);
  FreeAndNil(XTerm);
  FreeAndNil(YTerm);
  Inherited Destroy;
  end;

destructor TGXPoint.FreeBluePrint;
  begin
  FreeAndNil(XTerm);
  FreeAndNil(YTerm);
  inherited FreeBluePrint;
  end;

function TGXPoint.GetInfo: String;
  var sx, sy : String;
  begin
  sx := XTerm.GetHTMLString;
  sy := YTerm.GetHTMLString;
  Result := Format(MyObjTxt[54], [sx, sy]);
  InsertNameOf(Self, Result);
  end;


{--------------------------------------------------}
{ TGMappedPoint's method implementations:          }
{--------------------------------------------------}

constructor TGMappedPoint.Create(iObjList: TGeoObjListe;
                                 iOriPt, iMapObj: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, 0, 0, False);
  BecomesChildOf(iOriPt);
  BecomesChildOf(iMapObj);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

procedure TGMappedPoint.GetDataFromOldMappedObj(OMO: TGeoObj);
  begin
  Inherited GetDataFromOldMappedObj(OMO);
  With OMO as TGPoint do begin
    Self.X := X;
    Self.Y := Y;
    end;
  end;

function TGMappedPoint.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGMappedPoint) and
            (Parent[0] = GO.Parent[0]) and
            (Parent[1] = GO.Parent[1]);
  end;

procedure TGMappedPoint.UpdateParams;
  var OPt, IPt: TFloatPoint;
  begin
  If TGeoObj(Parent[0]).DataValid and
     TGeoObj(Parent[1]).DataValid then begin
    With TGPoint(Parent[0]) do begin
      OPt.x := X;
      OPt.y := Y;
      end;
    If TGTransformation(Parent[1]).GetMappedPoint(OPt, IPt) then begin
      X := IPt.x;
      Y := IPt.y;
      DataValid := True;
      UpdateScreenCoords;
      end
    else
      DataValid := False;
    end
  else
    DataValid := False;
  end;

function TGMappedPoint.GetInfo: String;
  var s1, s2 : String;
  begin
  s1 := MyObjTxt[44];
  InsertNameOf(Self, s1);
  InsertNameOf(TGeoObj(Parent[0]), s1);
  s2 := TGTransformation(Parent[1]).GetLinkableInfo;
  Result := s1 + s2;
  end;


{--------------------------------------------------}
{ TGArea's method implementations:                 }
{--------------------------------------------------}

constructor TGArea.Create(iObjList: TGeoObjListe; iParent: TGLine;
                          iis_visible: Boolean; iOrientation: Boolean);
  begin
  Inherited Create(iObjList, iis_visible);
  Orientation := iOrientation;
  BrushBMP    := InitBrushBMP;
  ObjList.GetFreeFillPattern(FMyColour, FMyBrushStyle);
  If iParent <> Nil then begin
    BecomesChildOf(iParent);
    UpdateParams;
    end;
  end;

constructor TGArea.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  BrushBMP := InitBrushBMP;
  ReadBitMapDataByReader(R, BrushBMP);
  Orientation := R.ReadBoolean;
  ops := R.ReadString;
  replace('&', '*', ops);
  Handle := 0;
  end;

destructor TGArea.Destroy;
  begin
  If IsVisible then
    ShowsAlways := False;
  If Handle <> 0 then begin
    DeleteObject(Handle);
    Handle := 0;
    end;
  BrushBMP.Free;
  Inherited Destroy;
  end;

constructor TGArea.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var domOri,
      domOps : IXMLNode;
      s      : String;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  BrushBMP := InitBrushBMP;
  If DE.hasAttribute('brush_bmp') then begin
    s := DE.getAttribute('brush_bmp');
    LoadBMPFromString(s, BrushBMP);
    end;

  domOri := DE.childNodes.findNode('orientation', '');
  If domOri <> Nil then begin
    s := LowerCase(domOri.nodeValue);
    DeleteChars(#09#10#13, s);
    Orientation := s = 'true';
    end
  else
    Orientation := False;

  domOps := DE.childNodes.findNode('operators', '');
  If (domOps <> Nil) and (domOps.IsTextElement) then begin
    ops := domOps.Text;
    DeleteChars(#09#10#13, ops);
    end
  else
    ops := '';
  end;

function TGArea.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var domOri, domOps : IXMLNode;
      s : String;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  If MyShape = 2 then begin
    PackBMPIntoString(BrushBMP, s);
    Result.setAttribute('brush_bmp', s);
    end;

  If ClassType = TGArea then begin
    domOri := DOMDoc.createNode('orientation');
    domOri.nodeValue := LowerCase(BoolToStr(Orientation, True));
    Result.childNodes.add(domOri);

    If Length(ops) > 0 then begin
      domOps := DOMDoc.createNode('operators');
      domOps.nodeValue := ops;
      Result.childNodes.add(domOps);
      end;
    end;
  end;

procedure TGArea.AfterLoading(FromXML : Boolean = True);
  var i : Integer;
  begin
  Inherited AfterLoading(FromXML);
  If (Not FromXML) and (Parent.Count > 0) then begin
    If TGeoObj(Parent[0]) is TGMSenkr then
      Orientation := Not Orientation;
    For i := 1 to Pred(Parent.Count) do
      If TGeoObj(Parent[i]) is TGMSenkr then begin
        If ops[i] = '*' then
          ops[i] := '-'
        else if ops[i] = '-' then
          ops[i] := '*';
        end;
    end;
  end;

function TGArea.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  If ClassGroupId = ccDragableObj then
    If TGeoObj(Parent[0]) is TGStraightLine then         { Halbebenen vor  }
      Result := False        { dem Verziehen bewahren; sie sind "zu groß"  }
    else
      Result := CanBeDragged { Rand prüfen     }
  else
    Result := (ClassGroupId in [ccArea, ccAnyGeoObj, ccBorderOrArea]) or
              ((ClassGroupId in [ccMappableObj, ccMakroDefObj]) and (Parent.Count = 1));
  end;

function TGArea.GetValue(selector: Integer): Double;
  var BL : TGLine;
  begin
  Case selector of
    gv_area : If Parent.Count = 1 then begin
                BL := TGLine(Parent[0]);
                If BL.DataValid and BL.IsClosedLine then
                  Result := BL.GetValue(gv_area)
                else
                  Result := Abs(GetRegionSize(Handle)/(ObjList.e1x * ObjList.e2y))
                end
              else
                Result := Abs(GetRegionSize(Handle)/(ObjList.e1x * ObjList.e2y));
  else
    Result := Inherited GetValue(selector);
  end;
  end;

function TGArea.GetMatchingCursor(mpt: TPoint): TCursor;
  var i  : Integer;
      cm : Boolean;   { "c"an "m"ove }
  begin
  cm := TGLine(Parent[0]).CanBeDraggedIndirectly;
  i := 1;
  While cm and (i < Parent.Count) do begin
    cm := cm and TGLine(Parent[i]).CanBeDraggedIndirectly;
    Inc(i);
    end;
  If cm then
    Result := Drag_Cursor
  else
    Result := Inherited GetMatchingCursor(mpt);
  end;

function TGArea.InitBrushBMP : TBitMap;
  begin
  Result := TBitMap.Create;
  With Result do begin
    Width  := 8;
    Height := 8;
    Transparent     := True;
    TransparentMode := tmAuto;
    end;
  end;

procedure TGArea.SetGraphTools(LineStyleNum, PointStyleNum,
                               FillStyleNum: Integer; iColor: TColor);
  begin
  HideIt;
  MyLineWidth := 1;
  MyPenStyle  := psClear;
  Case FillStyleNum of
    1 : begin                      { Keine Füllung }
        MyBrushStyle := bsClear;
        MyShape := 0;
        end;
    8 : begin                      { Zufallsmuster }
        MyBrushStyle := bsSolid;
        MyShape := 2;
        end;
  else
    MyBrushStyle := TBrushStyle(FillStyleNum);
    MyShape := 1;
  end; { of case }
  MyColour := iColor;
  DrawIt;
  end;

procedure TGArea.GetGraphTools(var LineStyleNum, PointStyleNum,
                                   FillStyleNum: Integer; var iColor: TColor);
  begin
  If MyShape = 2 then    { Zufallsmuster }
    FillStyleNum := 8
  else                   { irgend eine oder auch keine Füllung }
    FillStyleNum := Integer(MyBrushStyle);
  iColor := MyColour;
  end;

procedure TGArea.SetIsFlagged(flag: Boolean);
  begin
  If ObjList.DraggedObj = Self then
    TGeoObj(Parent[0]).IsFlagged := flag;
  Inherited SetIsFlagged(flag);
  end;

procedure TGArea.SetMyColour(NewCol: TColor);
  var i, j : Integer;
  begin
  FMyColour := NewCol;
  If MyShape = 2 then with BrushBMP do begin
    For i := 0 to 7 do
      For j := 0 to 7 do
        If Random(100) <= 15 then
          Canvas.Pixels[i, j] := MyColour
        else
          Canvas.Pixels[i, j] := ObjList.BackgroundColor;
    Canvas.Pixels[0, 7] := ObjList.BackgroundColor;
    end;
  end;


procedure TGArea.AdjustGraphTools(to_draw: Boolean);
  procedure ChangeBrushColourTo(newCol: TColor);
    var i : Integer;
    begin
    With BrushBMP do begin
      i := 0;
      While (i < 64) and
            (Canvas.Pixels[i Mod 8, i Div 8] = ObjList.BackgroundColor) do
        Inc(i);
      If Canvas.Pixels[i Mod 8, i Div 8] <> newCol then begin
        Canvas.Pixels[i Mod 8, i Div 8] := newCol;
        Inc(i);
        While i < 64 do begin
          If Canvas.Pixels[i Mod 8, i Div 8] <> ObjList.BackgroundColor then
            Canvas.Pixels[i Mod 8, i Div 8] := newCol;
          Inc(i);
          end;
        end;
      end;
    end;

  begin
  With ObjList.TargetCanvas do
    If to_draw then begin
      Inherited AdjustGraphTools(True);  { Setzt Pen.Color ! }
      Brush.Color := Pen.Color;
      If MyShape = 2 then begin    { User-defined Brush ! }
        If (ObjList.OutputStatus in [outPreview, outPrinter]) and
           (Not PrnKnowsUserDefinedBrush) then
          If PrnKnowsHatchedFillings then
            Brush.Style := bsDiagCross
          else
            Brush.Style := bsSolid
        else begin
          ChangeBrushColourTo(Pen.Color);
          Brush.BitMap:= BrushBMP;
          end;
        end
      else                         { Standard-Brush ! }
        If (ObjList.OutputStatus in [outPreview, outPrinter]) and { Drucken von }
           (MyBrushStyle > bsClear) and            { gestrichelter Füllung, aber}
           (Not PrnKnowsHatchedFillings) then      { der Drucker kann's nicht ! }
          Brush.Style := bsSolid
        else
          Brush.Style := MyBrushStyle;
      end
    else begin
      Inherited AdjustGraphTools(False);
      Brush.Color := ObjList.BackgroundColor;
      Brush.Style := bsSolid;
      end;
  end;

function TGArea.HasSameDataAs(GO: TGeoObj): Boolean;

  function AllFollowingParentsAreEqual: Boolean;
    var i, j : Integer;
    begin
    Result := GO.Parent.Count = Parent.Count;
    If Result then
      For i := 1 to Pred(Parent.Count) do begin
        j := GO.Parent.IndexOf(Parent[i]);
        If (j < 0) or (TGArea(GO).ops[j] <> ops[i]) then begin
          Result := False;
          Exit;
          end;
        end;
    end;

  begin
  Result := (GO is TGArea) and
            (Orientation = TGArea(GO).Orientation) and
            (Parent[0] = GO.Parent[0]) and
            AllFollowingParentsAreEqual;
  end;

function TGArea.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('F_');
  end;

function TGArea.Dist(xm, ym: Double): Double;
  var _sx, _sy : Integer;
  begin
  Result := 1.0e300;
  If DataValid then begin
    ObjList.GetWinCoords(xm, ym, _sx, _sy);
    If PtInRegion(Handle, _sx, _sy) then
      Result := 0;
    end;
  end;

function TGArea.IsNearMouse: Boolean;
  begin
  Result := DataValid and
            PtInRegion(Handle, ObjList.LastMousePos.X, ObjList.LastMousePos.Y);
  end;

function TGArea.CanBeDragged: Boolean;
  var PL : TObjPtrList;
      nq : Double;
      i  : Integer;
  begin
  Result := True;
  PL := TObjPtrList.Create(False);
  try
    For i := 0 to Pred(Parent.Count) do
      Result := Result and TGLine(Parent[i]).AllAncestorsAreFreePoints(PL);
    FQuant := -1;
    i  :=  0;
    While Result and (i < PL.Count) do begin
      nq := TGPoint(PL[i]).Quant;
      If FQuant < -0.5 then
        FQuant := nq
      else
        Result := Abs(FQuant - nq) < epsilon;
      i := i + 1;
      end;
    If FQuant < 0 then FQuant := 0;   // nur vorsichtshalber
  finally
    PL.Free;
  end; { of try }
  end;

procedure TGArea.Register4Dragging(DragList: TObjPtrList);
  var AAPCMF : Boolean;   { "A"ll "A"ncestor "P"oints "C"an "M"ove "F"ree }
      PList  : TObjPtrList;
      ActPa  : TGLine;
      i, k   : Integer;
  begin
  If ObjList.DraggedObj = Self then begin
    AAPCMF := True;
    i := -1;
    While AAPCMF and (i < Pred(Parent.Count)) do begin
      i := i + 1;
      If Not TGLine(Parent[i]).CanBeDraggedIndirectly then
        AAPCMF := False;
      end;
    If AAPCMF then begin
      PList := TObjPtrList.Create(False);
      try
        For i := 0 to Pred(Parent.Count) do begin
          ActPa := Parent[i];
          For k := 0 to Pred(ActPa.Parent.Count) do
            PList.Add(ActPa.Parent[k])
          end;
        DragList.Add(Self);
        For i := 0 to Pred(PList.Count) do
          TGeoObj(PList.Items[i]).Register4Dragging(DragList);
        DragList.Remove(Self);
      finally
        PList.Free;
      end;
      end;
    end;
  Inherited Register4Dragging(DragList);
  end;

procedure TGArea.SaveState;
  begin
  Old_Data.push(@FStatus, SizeOf(FStatus));
  end;

procedure TGArea.RestoreState;
  begin
  Old_Data.pop(@FStatus);
  UpdateScreenCoords;
  end;

procedure TGArea.UpdateParams;
  begin
  UpdateScreenCoords;
  end;

procedure TGArea.UpdateScreenCoords;
  var i        : Integer;
      SRHandle : HRgn;
      R        : TRect;
  begin
  If Handle <> 0 then begin
    DeleteObject(Handle);
    Handle := 0;
    end;
  If TGeoObj(Parent[0]).DataValid then begin
    Handle := TGLine(Parent[0]).GetFillHandle(Orientation);
    DataValid := Handle > 0;
    If DataValid and (Parent.Count > 1) then
      For i := 1 to Pred(Parent.Count) do
        If DataValid and TGLine(Parent[i]).DataValid then begin
          SRHandle := TGLine(Parent[i]).GetFillHandle(True);
          If (SRHandle > 0) then begin
            Case ops[i] of
              '+' : CombineRgn(Handle, Handle, SRHandle, RGN_OR);
              '-' : CombineRgn(Handle, Handle, SRHandle, RGN_DIFF);
              '*' : CombineRgn(Handle, Handle, SRHandle, RGN_AND);
            else
              DataValid := False;
            end;
            DeleteObject(SRHandle);
            end
          else begin
            DataValid := False;
            DeleteObject(Handle);
            Handle := 0;
            end;
          end;
    If Handle > 0 then begin
      SRHandle := CreateRectRgnIndirect(ObjList.WindowRect);
      If CombineRgn(Handle, Handle, SRHandle, RGN_AND) = ERROR then begin
        DataValid := False;
        DeleteObject(Handle);
        Handle := 0;
        end
      else
        If TGLine(Parent[0]).IsClosedLine then begin
          X := TGLine(Parent[0]).GetValue(gv_x);
          Y := TGLine(Parent[0]).GetValue(gv_y);
          end
        else
          begin  { In (X;Y) einen Schätzwert für den Schwerpunkt ablegen }
          GetRgnBox(Handle, R);
          If (R.Left < R.Right) and (R.Top < R.Bottom) then
            ObjList.GetLogCoords((R.Left + R.Right) Div 2,
                                 (R.Top + R.Bottom) Div 2, X, Y);
          end;
      DeleteObject(SRHandle);
      end;
    end { of if }
  else
    DataValid := False;
  end;

procedure TGArea.DrawIt;
  var oldHandle : THandle;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    oldHandle := SelectObject(ObjList.TargetCanvas.Handle, ObjList.TargetCanvas.Brush.Handle);
    FillRgn(ObjList.TargetCanvas.Handle, Handle, ObjList.TargetCanvas.Brush.Handle);
    SelectObject(ObjList.TargetCanvas.Handle, oldHandle);
    end;
  end;

procedure TGArea.HideIt;
  var oldHandle : THandle;
  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    oldHandle := SelectObject(ObjList.TargetCanvas.Handle, ObjList.TargetCanvas.Brush.Handle);
    FillRgn(ObjList.TargetCanvas.Handle, Handle, ObjList.TargetCanvas.Brush.Handle);
    SelectObject(ObjList.TargetCanvas.Handle, oldHandle);
    end;
  end;

procedure TGArea.DrawLimitLines;
  begin
  end;

procedure TGArea.CutOffAt(CutLine: TGLine; op: Char);
  var is_vis : Boolean;
  begin
  is_vis := IsVisible;
  If is_vis then HideIt;
  BecomesChildOf(CutLine);
  ops := ops + op;
  UpdateScreenCoords;
  If is_vis then DrawIt;
  end;

procedure TGArea.CutAtLine(CutLine: TGLine; OriP: TPoint);
  var CutLineRgn : HRgn;
  begin
  CutLineRgn := CutLine.GetFillHandle(True);
  If PtInRegion(CutLineRgn, OriP.x, OriP.y) then
    CutOffAt(CutLine, '*')
  else
    CutOffAt(CutLine, '-');
  DeleteObject(CutLineRgn);
  end;

procedure TGArea.Invalidate;
  var i : Integer;
  begin
  For i := 0 to Pred(Parent.Count) do
    TGeoObj(Parent[i]).Children.Remove(Self);
  Inherited Invalidate;
  end;

procedure TGArea.Revalidate;
  var i : Integer;
  begin
  For i := 0 to Pred(Parent.Count) do
    TGeoObj(Parent[i]).Children.Add(Self);
  UpdateScreenCoords;
  Inherited Revalidate;
  end;

procedure TGArea.LoadContextMenuEntriesInto(menu: TPopupMenu);
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, cme_fillstyle, CME_PopupClick, cmd_EditPattern);
  end;

procedure TGArea.RegisterAsMacroStartObject;
  begin
  If Parent.Count = 1 then
    TGeoObj(Parent[0]).RegisterAsMacroStartObject;
  end;

function TGArea.GetInfo: String;
  var s : String;
      i : Integer;
  begin
  If Parent.Count = 1 then
    s := ' ? '
  else begin
    s := '';
    For i := 0 to Parent.Count - 2 do
      s := s + ' ?,';
    Delete(s, Length(s), 1);
    s := s + id_and + '? ';
    end;
  For i := 0 to Pred(Parent.Count) do
    InsertNameOf(TGeoObj(Parent[i]), s);
  Result := Format(MyObjTxt[59], [s]);
  InsertNameOf(Self, Result);
  end;


{--------------------------------------------------}
{ TGLine's method implementations:                 }
{--------------------------------------------------}


constructor TGLine.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var domPos: IXMLNode;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  F_CBDI := False;  // Standardwert
  F_CCTP := False;

  If Not(self is TGConic) then begin
    domPos := DE.childNodes.findNode('position', '');
    If domPos <> Nil then begin      // wegen Ortslinien !
      X1 := StrToFloat(dompos.getAttribute('x1'));
      Y1 := StrToFloat(dompos.getAttribute('y1'));
      if domPos.hasAttribute('x2') then
        X2 := StrToFloat(dompos.getAttribute('x2'));
      if domPos.hasAttribute('y2') then
        Y2 := StrToFloat(dompos.getAttribute('y2'));
      end;
    end;
  end;

function TGLine.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var position: IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  If not (Self is TGConic) then begin
    position := DOMDoc.createNode('position');
    position.setAttribute('x1', FloatToStr(X1));
    position.setAttribute('y1', FloatToStr(Y1));
    position.setAttribute('x2', FloatToStr(X2));
    position.setAttribute('y2', FloatToStr(Y2));
    Result.childNodes.add(position);
    end;
  end;

function TGLine.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccAnyLine, ccDistableObj, ccMappableObj]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGLine.IsClosedLine: Boolean;
  begin
  Result := False;
  end;

function TGLine.GetTangentIn(bx, by: Double; var tanCoeff: TVector3): Boolean;
  begin
  Result := False;
  end;

function TGLine.GetPolOf(polare: TVector3; var px, py: Double): Boolean;
  begin
  Result := False;
  end;

function TGLine.GetPolareOf(bx, by: Double; var polCoeff: TVector3): Boolean;
  begin
  Result := False;
  end;

function TGLine.GetParentPointOnSelf(nr: Integer): TGPoint;
  { Liefert den nr-ten Punkt aus der Elternliste, der auf der
    Kurve selbst liegt, oder Nil. Dabei startet nr mit 1.     }
  begin
  Result := Nil;
  end;

function TGLine.AllAncestorsAreFreePoints(PList: TObjPtrList = Nil): Boolean;
  { Gibt TRUE zurück, falls alle Elternpunkte frei bewegliche Basispunkte
                      sind; in diesem Fall wird zusätzlich in PList eine
                      Liste dieser Punkte zurückgegeben.
    Gibt FALSE zurück, wenn auch nur *ein* gebundener oder abhängiger
                      Elternpunkt gefunden wurde. Dann wird PList geleert. }
  var i : Integer;
  begin
  Result := True;
  i := 0;
  While Result and (i < Parent.Count) do begin
    If TGeoObj(Parent[i]).ClassType = TGPoint then
      If TGeoObj(Parent[i]).Parent.Count = 0 then begin
        If PList <> Nil then
          PList.Add(Parent[i]);
        end
      else
        Result := False
    else
      Result := False;
    i := i + 1;
    end;
  If Not Result then
    If PList <> Nil then
      PList.Clear;
  end;

function TGLine.IsFilled(var FO: TGArea): Boolean;
  begin
  Result := False;
  FO     := Nil;
  end;

function TGLine.GetFillHandle(Ori: Boolean): HRgn;
  begin
  Result := 0;
  end;

procedure TGLine.MovePointsOff(var rP1, rP2: TFloatPoint);
  { Errechnet aus den definierenden Punkten (X1|Y1) und (X2|Y2) der Geraden
    Geradenpunkte (rX1|ry1) und (rX2|rY2) außerhalb des sichtbaren Fensters;
    hinterläßt außerdem in (X|Y) einen Punkt, der entweder im sichtbaren
    Fenster liegt oder derjenige Punkt der Geraden ist, der den kleinsten
    Abstand zur aktuellen Fenstermitte hat. Mit Hilfe dieses Punktes kann
    dann entschieden werden, ob die Gerade sichtbar ist oder nicht.       }
  var dx, dy, dr: Double;
  begin
  dx := X2 - X1;
  dy := Y2 - Y1;
  dr := Hypot(dx, dy);
  If dr < DistEpsilon then
    DataValid := False      { Zu dicht benachbarte Punkte }
  else begin                { definieren keine Gerade !   }
    if ObjList.LogWinKnows(X1, Y1) = 1 then begin
      X := X1;  Y := Y1; end
    else
      If ObjList.LogWinKnows(X2, Y2) = 1 then begin
        X := X2;  Y := Y2; end
      else
        If Not GetPedalPoint (X1, Y1, X2, Y2,
                              ObjList.xCenter, ObjList.yCenter,
                              X, Y) then begin
          DataValid := False;
          Exit;
          end;
    dr  := 2.2 * ObjList.LogWinRadius / dr;
    dx  := dx * dr;
    dy  := dy * dr;
    rP1.X := X - dx; {(x1neu - X) = k * (x1alt - x2alt)  mit k > 0, usw. }
    rP1.Y := Y - dy; { sonst wird die Orientierung umgedreht !           }
    rP2.X := X + dx;
    rP2.Y := Y + dy;
    end;
  end;

procedure TGLine.AdjustGraphTools(todraw : Boolean);
  begin
  Inherited AdjustGraphTools(todraw);
  ObjList.TargetCanvas.Brush.Style := bsClear;
  end;

procedure TGLine.Set_CBDI;
  begin
  F_CBDI := AllAncestorsAreFreePoints;
  end;

procedure TGLine.GetGraphTools(var LineStyleNum, PointStyleNum,
                                   FillStyleNum: Integer; var iColor: TColor);
  begin
  Case MyPenStyle of
    psSolid   : If MyLineWidth = 1 then
                  LineStyleNum := 0
                else
                  If MyLineWidth = 3 then
                    LineStyleNum := 1
                  else
                    LineStyleNum := 2;
    psDash    : LineStyleNum := 3;
    psDot     : LineStyleNum := 4;
    psDashDot : LineStyleNum := 5;
  end; {of case }
  iColor := MyColour;
  end;

procedure TGLine.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, cme_linestyle, CME_PopupClick, cmd_EditLineStyle);
  If ShowDataInNameObj then
    if Self is TGVector then
      AddPopupMenuItemTo(menu, cme_hidecoords, CME_PopupClick, cmd_NoData)
    else
      AddPopupMenuItemTo(menu, cme_hideequation, CME_PopupClick, cmd_NoData)
  else
    If Self is TGVector then
      AddPopupMenuItemTo(menu, cme_showcoords, CME_PopupClick, cmd_AddData)
    else
      AddPopupMenuItemTo(menu, cme_showequation, CME_PopupClick, cmd_AddData);
  end;

function TGLine.Includes(xp, yp: Double): Boolean;
  { Gibt Auskunft darüber, ob der übergebene Punkt auf der aktuellen Linie
    liegt, indem der Abstand des Punktes zu dieser Linie gemessen und
    bewertet wird. Die Bewertung hängt vom jeweiligen Typ der Linie ab,
    weil die Messgenauigkeit für die Abstände sehr unterschiedlich ist. }
  begin
  Result := False;
  end;

procedure TGLine.SaveState;
  begin
  Inherited SaveState;
  With Old_Data do begin
    push(@X1, SizeOf(X1));
    push(@Y1, SizeOf(Y1));
    push(@X2, SizeOf(X2));
    push(@Y2, SizeOf(Y2));
    push(@sx1, SizeOf(sx1));
    push(@sy1, SizeOf(sy1));
    push(@sx2, SizeOf(sx2));
    push(@sy2, SizeOf(sy2));
    end;
  end;

procedure TGLine.RestoreState;
  begin
  With Old_Data do begin
    pop(@sy2);
    pop(@sx2);
    pop(@sy1);
    pop(@sx1);
    pop(@Y2);
    pop(@X2);
    pop(@Y1);
    pop(@X1);
    end;
  Inherited RestoreState;
  end;

procedure TGLine.VirtualizeCoords;
  begin
  Inherited VirtualizeCoords;   { vorsichtshalber ! }
  sx1 := SafeRound(X1 * ppcm_corrfactor);
  sy1 := SafeRound(Y1 * ppcm_corrfactor);
  ObjList.GetLogCoords(sx1, sy1, X1, Y1);
  sx2 := SafeRound(X2 * ppcm_corrfactor);
  sy2 := SafeRound(Y2 * ppcm_corrfactor);
  ObjList.GetLogCoords(sx2, sy2, X2, Y2);
  end;


{--------------------------------------------------}
{ TGStraightLine's method implementations:         }
{--------------------------------------------------}

constructor TGStraightLine.Create(iObjList : TGeoObjListe;
                                  iP1, iP2 : TGeoObj; iis_visible : Boolean);
  {  Nie mehr ändern !!!  Winkelhalbierenden-Chaos !!! ( April/Mai 2006 )  }
  begin
  Inherited Create(iObjList, False);
  SetGraphTools(DefNormalLineStyle, 0, 0, clBlack);
  FHesseEq := TVector3.Create(0, 0, 0);
  If iP1 <> Nil then begin
    BecomesChildOf (iP1);
    If iP2 <> Nil then begin
      BecomesChildOf (iP2);
      Set_CBDI;
      UpdateParams;
      If iis_visible then begin
        ShowsAlways := True;
        DrawIt;
        end;
      end;
    end;
  end;


constructor TGStraightLine.Load(S: TFileStream; iObjList: TGeoObjListe);
  begin
  Inherited Load(S, iObjList);
  S.Read(X1, SizeOf(X1));
  S.Read(Y1, SizeOf(Y1));
  S.Read(X2, SizeOf(X2));
  S.Read(Y2, SizeOf(Y2));
  F_CCTP   := False;
  FHesseEq := TVector3.Create(0, 0, 0);
  end;


constructor TGStraightLine.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  X1 := R.ReadFloat;
  Y1 := R.ReadFloat;
  X2 := R.ReadFloat;
  Y2 := R.ReadFloat;
  F_CCTP   := False;
  FHesseEq := TVector3.Create(0, 0, 0);
  end;


constructor TGStraightLine.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  FHesseEq := TVector3.Create(0, 0, 0);
  end;


destructor TGStraightLine.Destroy;
  begin
  FHesseEq.Free;
  Inherited Destroy;
  end;


destructor TGStraightLine.FreeBluePrint;
  begin
  FHesseEq.Free;
  inherited FreeBluePrint;
  end;


procedure TGStraightLine.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  FHesseEq := TVector3.Create(0, 0, 0);
  end;

procedure TGStraightLine.VirtualizeCoords;
  begin
  Inherited VirtualizeCoords;
  GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
  end;


function TGStraightLine.LineIntersectsWindow: Boolean;
  { 11.06.09 :  Überarbeitet, um dem Fall "xf is NAN" aus dem Weg zu gehen.
                Gleichzeitig den Aufruf im Falle "Not DataValid" geregelt:
                jetzt wird in diesem Fall stets FALSE zurückgegeben.      }
  function RunsThrough: Boolean;
    var xf, yf : Double;
    begin
    Result := GetPedalPoint(X1, Y1, X2, Y2,
                  ObjList.xCenter, ObjList.yCenter, xf, yf) and
              ObjList.LogWinContains(xf, yf) and
              Self.Includes(xf, yf);
    end;

  begin
  if DataValid then
    Result := ObjList.LogWinContains(X1, Y1) or
              ObjList.LogWinContains(X2, Y2) or
              RunsThrough
  else
    Result := False;
  end;


function TGStraightLine.GetDataStr: String;
  var a, b, c,         // Normalenform : ax + by = c
      m   : Double;
      rz  : Char;
      n   : Integer;
  begin
  a := Y1 - Y2;
  b := X2 - X1;
  c := Y1*X2 - X1*Y2;

  Result := '';
  If (Self is TGLongLine) and
     (LineEqStyle = 0) then     // y = mx + c  anstreben !
    If Abs(b) > Epsilon then begin  // Gerade mit endlicher Steigung
      m := -a/b;
      c :=  c/b;
      If c < 0 then begin
        c := - c;
        rz := '-';
        end
      else
        rz := '+';
      Result := '{ y = ';
      If Abs(m) > epsilon then begin
        Result := Result + Float2Str(m, 2) + ' x ';
        If Abs(c) > epsilon then
          Result := Result + rz + ' ' + Float2Str(c, 2) + ' }'
        else
          Result := Result + '}';
        end
      else begin
        If rz = '-' then
          Result := Result + rz;
        Result := Result + Float2Str(c, 2) + ' }';
        end;
      end
    else                            // Senkrechte Gerade
      If Abs(a) > epsilon then
        Result := '{ x = ' + Float2Str(c/a, 2) + ' }';

  If Length(Result) = 0 then begin
    n := 0;
    If a < 0 then Inc(n);
    If b < 0 then Inc(n);
    If c < 0 then Inc(n);
    If n > 1 then begin
      a := - a;  b := - b; c := - c;
      end;
    If b < 0 then begin
      b  := -b;
      rz := '-'
      end
    else
      rz := '+';
    Result := '{ ' + Float2Str(a, 2) + ' x ' + rz + ' ' +
                     Float2Str(b, 2) + ' y = ' +
                     Float2Str(c, 2) + ' }';
    end;
  end;

procedure TGStraightLine.SaveState;
  begin
  Inherited SaveState;
  With Old_Data do begin
    push(@FHesseEq.X, SizeOf(Double));
    push(@FHesseEq.Y, SizeOf(Double));
    push(@FHesseEq.Z, SizeOf(Double));
    push(@FHesseEq.tag, SizeOf(Integer));
    end;
  end;

procedure TGStraightLine.RestoreState;
  begin
  With Old_Data do begin
    pop(@FHesseEq.tag);
    pop(@FHesseEq.Z);
    pop(@FHesseEq.Y);
    pop(@FHesseEq.X);
    end;
  Inherited RestoreState;
  end;

function TGStraightLine.GetNormalizedDirection: TFloatPoint;
  begin
  GetNormalizedDirFromHesseEq(FHesseEq, Result);
  end;

function TGStraightLine.GetValue(selector : Integer) : Double;
  var dir : TFloatPoint;
  begin
  Case selector of
    gv_slope : begin
               GetNormalizedDirFromHesseEq(FHesseEq, dir);
               if Abs(dir.x) > mathlib.epsilon then
                 Result := dir.y / dir.x
               else
                 Result := NaN;
               end;
  else
    Result := Inherited GetValue(selector);
  end;
  end;

function TGStraightLine.GetLinePtWithMinMouseDist(xm, ym, quant: Double;
                  var px, py: Double): Boolean;
  begin
  Result := GetPedalPoint(X1, Y1, X2, Y2, xm, ym, px, py);
  end;

function TGStraightLine.GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean;
  var T1x, T1y, T2x, T2y : Double;
      v1, v2 : Boolean;
  begin
  IntersectCircleWithLine(EP.X, EP.Y, r, X1, Y1, X2, Y2, T1x, T1y, T2x, T2y, v1, v2);
  If v2 and
     ( (Not v1) or
       (Hypot(T1x - px, T1y - py) > Hypot(T2x - px, T2y - py)) ) then begin
    px := T2x;
    py := T2y;
    end
  else begin
    px := T1x;
    py := T1y;
    end;
  Result := v1 or v2;
  end;

procedure TGStraightLine.GetDataVector(var v: TVector3);
  begin
  v.Assign(FHesseEq);
  end;

procedure TGStraightLine.DrawIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                 sx1, sy1, sx2, sy2, MyPenStyle);
    end;
  end;

procedure TGStraightLine.HideIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                 sx1, sy1, sx2, sy2, MyPenStyle);
    end;
  end;

procedure TGStraightLine.UpdateParams;
  var p1, p2    : TGPoint;
  begin
  DataValid := False;
  p1 := TGPoint(Parent[0]);
  If (p1 <> Nil) and p1.DataValid then begin
    X1 := p1.X;
    Y1 := p1.Y;
    p2 := TGPoint(Parent[1]);
    If (p2 <> Nil) and p2.DataValid then begin
      X2 := p2.X;
      Y2 := p2.Y;
      DataValid := GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
      UpdateScreenCoords;
      end;
    end;
  end;

procedure TGStraightLine.UpdateScreenCoords;
  var fx, fy : Double;
  begin
  If DataValid then begin
    GetPedalPoint(X1, Y1, X2, Y2,
                  ObjList.xCenter, ObjList.yCenter, fx, fy);
    DataCanShow := ObjList.LogWinKnows(fx, fy) = 1;
    If DataCanShow then begin
      ObjList.GetWinCoords(X1, Y1, sx1, sy1);
      ObjList.GetWinCoords(X2, Y2, sx2, sy2);
      end;
    end;
  end;

procedure TGStraightLine.SetNewNameParamsIn(TextObj: TGTextObj);
  var dx, dy,
      xp, yp,
      dr    : Double;
  begin
  with TextObj do begin
    dx := X2 - X1;
    dy := Y2 - Y1;
    dr := Hypot(dx, dy);
    If dr > DistEpsilon then begin
      dx := dx / dr;
      dy := dy / dr;
      GetPedalPoint(X1, Y1, X2, Y2, X, Y, xp, yp);
      If Abs(dx) > Abs(dy) then
        sConst := (xp - X1) / dx
      else
        sConst := (yp - Y1) / dy;
      rConst := ((X - X1) * dy - (Y - Y1) * dx);
      end;
    end;
  end;

procedure TGStraightLine.UpdateNameCoordsIn(TextObj: TGTextObj);
  var dx, dy, dr, fx, fy : Double;
  begin
  with TextObj do begin
    DataValid := Self.DataValid;
    If DataValid then begin
      dx := X2 - X1;
      dy := Y2 - Y1;
      dr := Hypot(dx, dy);
      If dr > DistEpsilon then begin
        dx := dx / dr;              // Richtungsvektor normieren
        dy := dy / dr;
        fx  := X1 + sConst * dx;    // Punkt auf der Geraden entlang schieben,
        fy  := Y1 + sConst * dy;
        X := fx + dy * rConst;      // Punkt orthogonal zur Geraden weg schieben
        Y := fy - dx * rConst;
        end
      else begin
        X := X1 + 0.2;
        Y := Y1 + 0.2;
        end;
      end;
    end;
  end;

function TGStraightLine.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  { Parameter-Bereich 0..1, sofern P(px|py) zwischen den
    definierenden Punkten Parent[0] und Parent[1] liegt }
  begin
  Result := GetTV(X1, Y1, X2, Y2, px, py, param);
  end;

function TGStraightLine.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  If DataValid then begin
    px := X1 + param*(X2 - X1);
    py := Y1 + param*(Y2 - Y1);
    Result := True;
    end;
  end;

function TGStraightLine.GetWinPosNextTo(_X, _Y: Double): TPoint;
  { Implementierung für LongLines; notfalls auch für HalfLines tauglich }
  var _sx, _sy : Double;
      ix, iy   : Integer;
  begin
  GetPedalPoint(X1, Y1, X2, Y2, _X, _Y, _sx, _sy);
  If Includes(_sx, _sy) then
    ObjList.GetWinCoords(_sx, _sy, ix, iy)
  else begin
    GetPedalPoint(X1, Y1, X2, Y2, 0, 0, _sx, _sy);
    If Includes(_sx, _sy) then
      ObjList.GetWinCoords(_sx, _sy, ix, iy)
    else
      ObjList.GetWinCoords(_X, _Y, ix, iy);
    end;
  Result := Point(ix, iy);
  end;

function TGStraightLine.LiesParallel(GO: TGSTraightLine): Boolean;
  var nd2 : TFloatPoint;
  begin
  nd2    := GO.GetNormalizedDirection;
  Result := Abs(FHesseEq.X * nd2.x + FHesseEq.Y * nd2.y) < epsilon
  end;

function TGStraightLine.LiesParallel(P1, P2: TGPoint): Boolean;
  var dx, dy : Double;
  begin
  dx := P2.X - P1.X;
  dy := P2.Y - P1.Y;
  Result := Abs(dx * FHesseEq.X + dy * FHesseEq.Y) < epsilon;
  end;

function TGStraightLine.LiesOrthogonal(GO: TGStraightLine): Boolean;
  var nd1, nd2 : TFloatPoint;
  begin
  nd1    := GetNormalizedDirection;
  nd2    := GO.GetNormalizedDirection;
  Result := Abs(nd1.x * nd2.x + nd1.y * nd2.y) < epsilon
  end;

function TGStraightLine.LiesOrthogonal(P1, P2: TGPoint): Boolean;
  var dx, dy : Double;
      nd     : TFloatPoint;
  begin
  dx := P2.X - P1.X;
  dy := P2.Y - P1.Y;
  nd := GetNormalizedDirection;
  Result := Abs(dx * nd.x + dy * nd.y) < epsilon;
  end;

function TGStraightLine.IsPerpendicularTo(SL: TGStraightLine): Boolean;
  { Liefert nur dann TRUE, wenn aufgrund der Verwandtschaftsverhältnisse
    feststeht, dass die aktuelle Linie immer orthogonal zu GO liegen wird,
    andernfalls FALSE.
    Achtung: Auch wenn FALSE geliefert wird, kann strikte Orthogonalität
             vorliegen (, z.B. durch Spiegelung an einer 45°-Geraden).  }
  begin
  Result := ((Self is TGLot) and (Parent[1]    = SL)  ) or
            ((SL   is TGLot) and (SL.Parent[1] = Self)) or
            ((Self is TGMSenkr) and (TGPoint(Parent[0]).IsIncidentWith(SL))
                                and (TGPoint(Parent[1]).IsIncidentWith(SL))) or
            ((SL is TGMSenkr) and (TGPoint(SL.Parent[0]).IsIncidentWith(Self))
                              and (TGPoint(SL.Parent[1]).IsIncidentWith(Self)));
  end;

function TGStraightLine.IsParallelTo(SL: TGStraightLine): Boolean;
  { Liefert nur dann TRUE, wenn aufgrund der Verwandtschaftsverhältnisse
    feststeht, dass die aktuelle Linie immer parallel zu SL liegen wird,
    sonst FALSE.
    Achtung: Auch im FALSE-Fall kann strikte Parallelität vorliegen.    }
  var TG : TGStraightLine;   // "T"est-"G"erade
      i  : Integer;
  begin
  Result := ((Self is TGParall) and (Parent[1] = SL)) or
            ((SL is TGParall) and (SL.Parent[1] = Self));
  If Not Result then begin
    i := 0;
    While (Not Result) and (i < ObjList.LastValidObjIndex) do begin
      If TGeoObj(ObjList.Items[i]) is TGStraightLine then begin
        TG := TGStraightLine(ObjList.Items[i]);
        If TG.IsPerpendicularTo(Self) and
           TG.IsPerpendicularTo(SL) then
          Result := True;
        end;
      i := i + 1;
      end;
    end;
  end;

function TGStraightLine.Includes(xp, yp: Double): Boolean;
  { Version für Geraden; bei Strecken und Halbgeraden müssen
    zusätzliche Bedingungen geprüft werden.                    }
  begin
  Result := Abs(FHesseEq.X * xp + FHesseEq.Y * yp + FHesseEq.Z) < DistEpsilon;
  end;


function TGStraightLine.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccStraightLine, ccPointOrStraightLn,
                              ccSimpleLine, ccMakroDefObj]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

procedure TGStraightLine.RegisterAsMacroStartObject;
  var i : Integer;
  begin
  With TMakro(ObjList.MakroList.Last) do begin
    For i := 0 to Pred(Parent.Count) do
      AddCmd(TMakroCmd.Create(Parent[i], -1));
    AddCmd(TMakroCmd.Create(Self, 0));
    end;
  end;

procedure TGStraightLine.Invalidate;
  var P : TGeoObj;
      i : Integer;
  begin
  For i := Pred(ObjList.Count) DownTo 0 do begin
    P := ObjList.Items[i];
    If (P.ClassType = TGPoint) and
       (P.Parent.Count > 0) and
       (P.Parent[0] = Self) then
      P.Parent.Remove(Self);    { Alle Bindungen an das gelöschte Objekt auflösen.   }
    end;
  Inherited Invalidate;
  end;


{--------------------------------------------------}
{  TGShortLine's method implementations:           }
{--------------------------------------------------}

function TGShortLine.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccShortLine, ccPointOrShortLn]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGShortLine.GetValue(selector: Integer): Double;
  begin
  Case selector of
    gv_x   : Result := (X1+X2)/2;
    gv_y   : Result := (Y1+Y2)/2;
    gv_val,
    gv_len : If DataValid then
               Result := Hypot(X2-X1, Y2-Y1)
             else
               Result := 0;
  else
    Result := 0;
  end; { of case }
  end;

function TGShortLine.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr in [1, 2] then
    Result := Parent[Pred(nr)]
  else
    Result := Nil;
  end;

function TGShortLine.GetLinePtWithMinMouseDist(xm, ym, quant: Double;
                  var px, py: Double): Boolean;
  var s : Double;
  begin
  if Inherited GetLinePtWithMinMouseDist(xm, ym, quant, px, py) then begin
    If (Not Includes(px, py)) and
       (GetTV(X1, Y1, X2, Y2, px, py, s)) then
      If s < 0.5 then begin
        px := X1;            { Punkt ganz an den Streckenanfang....    }
        py := Y1;
        end
      else begin
        px := X2;            { ...bzw. ganz ans Streckenende schieben! }
        py := Y2;
        end;
    Result := True;
    end
  else
    Result := False;
  end;

function TGShortLine.GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean;
  var T1x, T1y, T2x, T2y : Double;
      v1, v2 : Boolean;
  begin
  IntersectCircleWithLine(EP.X, EP.Y, r, X1, Y1, X2, Y2, T1x, T1y, T2x, T2y, v1, v2);
  If v1 then v1 := Includes(T1x, T1y);
  If v2 then v2 := Includes(T2x, T2y);
  If v2 and
     ( (Not v1) or
       (Hypot(T1x - px, T1y - py) > Hypot(T2x - px, T2y - py)) ) then begin
    px := T2x;
    py := T2y;
    end
  else begin
    px := T1x;
    py := T1y;
    end;
  Result := v1 or v2;
  end;

procedure TGShortLine.ResetOLCPList(PointList : TVector3List);
  begin
  PointList.Reset2StandardList(0.0001, 0.9999, 25);
  end;

function TGShortLine.Dist (xm, ym: Double): Double;
  begin
  LastDist := DistPt2ShortLn (X1, Y1, X2, Y2, xm, ym);
  Result := LastDist;
  end;

function TGShortLine.IsNearMouse: Boolean;
  begin
  Result := DistPt2ShortLn(sx1, sy1, sx2, sy2,
                           ObjList.LastMousePos.X,
                           ObjList.LastMousePos.Y) < CatchDist;
  end;

function TGShortLine.GetDataStr: String;
  var s1, s2 : String;
  begin
  s1 := Inherited GetDataStr;
  IF Length(s1) > 0 then begin
    If Abs(X2 - X1) > Abs(Y2 - Y1) then
      s2 := ';  ' + Float2Str(Min(X1, X2), 2) + klgl +
            'x' + klgl + Float2Str(Max(X1, X2), 2)
    else
      s2 := ';  ' + Float2Str(Min(Y1, Y2), 2) + klgl +
            'y' + klgl + Float2Str(Max(Y1, Y2), 2);
    Insert(s2, s1, Length(s1) - 1);
    end;
  Result := s1;
  end;

function TGShortLine.GetInfo: String;
  begin
  Result := MyObjTxt[2];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;

function TGShortLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (ClassType = GO.ClassType) and
            same2Obj(GO.Parent[0], GO.Parent[1], Parent[0], Parent[1]);
  end;

function TGShortLine.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('s');
  end;

function TGShortLine.Includes(xp, yp: Double): Boolean;
  var tv : Double;
  begin
  If Inherited Includes(xp, yp) then begin
    tv := -1;
    Result := GetTV(X1, Y1, X2, Y2, xp, yp, tv) and
            (tv >= - DistEpsilon) and (tv <= 1 + DistEpsilon);
    end
  else
    Result := False;
  end;

function TGShortLine.GetWinPosNextTo(_X, _Y: Double): TPoint;
  var ix, iy   : Integer;
  begin
  ObjList.GetWinCoords((X1 + X2)/2, (Y1 + Y2)/2, ix, iy);
  Result := Point(ix, iy);
  end;

procedure TGShortLine.SetNewNameParamsIn(TextObj: TGTextObj);
  var dx, dy,
      xp, yp,
      dr    : Double;
  begin
  with TextObj do begin
    dx := X2 - X1;
    dy := Y2 - Y1;
    dr := Hypot(dx, dy);
    If dr > DistEpsilon then begin
      dx := dx / dr;
      dy := dy / dr;
      GetPedalPoint(X1, Y1, X2, Y2, X, Y, xp, yp);
      GetParamFromCoords(xp, yp, sConst);
      rConst := ((X - X1) * dy - (Y - Y1) * dx);
      end;
    end;
  end;

procedure TGShortLine.UpdateNameCoordsIn(TextObj: TGTextObj);
  var dx, dy, dr, fx, fy : Double;
  begin
  with TextObj do begin
    DataValid := Self.DataValid;
    If DataValid then begin
      dx := X2 - X1;
      dy := Y2 - Y1;
      dr := Hypot(dx, dy);
      If dr > DistEpsilon then begin
        dx := dx / dr;              // Richtungsvektor normieren
        dy := dy / dr;
        GetCoordsFromParam(sConst, fx, fy);    // Fusspunkt auf Strecke setzen,
        X := fx + dy * rConst;      // dann orthogonal zur Strecke weg schieben
        Y := fy - dx * rConst;
        end
      else begin
        X := X1 + 0.2;
        Y := Y1 + 0.2;
        end;
      end;
    end;
  end;

procedure TGShortLine.UpdateScreenCoords;
  begin
  If DataValid then begin
    DataCanShow := LineIntersectsWindow;
    If DataCanShow then begin
      ObjList.GetWinCoords(X1, Y1, sx1, sy1);
      ObjList.GetWinCoords(X2, Y2, sx2, sy2);
      end;
    end;
  end;


{--------------------------------------------------}
{  TGFixLine's method implementations:             }
{    veralteter Typ, ersetzt durch TGXLine         }
{--------------------------------------------------}


constructor TGFixLine.Create(iObjList: TGeoObjListe; iP1, iP2: TGeoObj; iLength : Double; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, iP1, iP2, iis_visible);
  MyLength := iLength;
  { Freunde werden durch die Methode AdjustFriendlyLinks verbucht.
    Diese muß "von außen" aufgerufen werden; sie kann nicht aus dem
    Konstruktor heraus aufgerufen werden, weil Self noch nicht in
    der Drawing.Liste verbucht ist! }
  end;

constructor TGFixLine.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  If GO = Nil then
    MyLength := 1
  else
    MyLength := TGFixLine(GO).MyLength;
  end;

constructor TGFixLine.Load(S: TFileStream; iObjList: TGeoObjListe);
  begin
  Inherited Load(S, iObjList);
  S.Read(MyLength, SizeOf(MyLength));
  end;

constructor TGFixLine.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  MyLength := R.ReadFloat;
  end;

constructor TGFixLine.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var nvs : String;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  nvs := DE.childNodes.findNode('length', '').nodeValue;
  if Length(nvs) > 0 then begin
    DeleteChars(#09#10#13, nvs);  // 09.04.2010 :  Tabs + Zeilenumbruch-Reste
    MyLength := StrToFloat(nvs);  //               killen !
    end
  else
    MyLength := 0;
  end;

function TGFixLine.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var domLen : IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  domLen := DOMDoc.createNode('length');
  domLen.nodeValue := FloatToStr(MyLength);
  Result.childNodes.add(domLen);
  end;

procedure TGFixLine.AdjustFriendlyLinks;
  var pP1, pP2 : TGPoint;
  begin
  pP1 := TGPoint(Parent[0]);
  pP2 := TGPoint(Parent[1]);
  pP1.Stops2BeChildOf(Parent[1]);  { Alle eventuellen Eltern-Kindverhältnisse auflösen. }
  pP2.Stops2BeChildOf(Parent[0]);

  If (pP1.ClassType = TGPoint) and
     (pP2.ClassType = TGPoint) then begin   { Sind beide Eltern Basispunkte,     }
    If Not pP1.IsFriendOf(Parent[1]) then   {   werden sie befreundet.           }
      pP1.StartFriendshipWith(Parent[1]);
    end
  else begin
    pP2.EndFriendshipWith(pP1);         { Eventuell bestehende Freundschaft   }
    If pP2.ClassType = TGPoint then     {   kündigen und durch entsprechendes }
      pP2.BecomesChildOf(pP1)           {   Eltern-Kind-Verhältnis ersetzen.  }
    else
      If pP1.ClassType = TGPoint then
        pP1.BecomesChildOf(pP2);
    end;
  end;

procedure TGFixLine.Register4Dragging(DragList: TObjPtrList);
  { Die Prozedur tut überhaupt nur etwas, wenn die Strecke selbst noch nicht
    in DragList registriert ist. Wenn eine Fläche gezogen wird und die Strecke
    zum Rand der Fläche gehört, wird nur die Strecke selbst in die Liste
    eingetragen. In diesem Fall stehen nämlich beide Endpunkte schon als
    Flächenecken in der DragList.
    Wenn schon einer der beiden Strecken-Endpunkte in der DragList steht und
    der andere ein freier Basispunkt ist, dann wird er zum temporären Kind
    des schon eingetragenen Endpunkts gemacht und *vor* der Strecke in die
    DragList eingetragen.
  }
  var p0, p1 : TGPoint;
  begin
  If DragList.IndexOf(Self) < 0 then begin  // Falls selbst noch nicht registriert:
    If (ObjList.DraggedObj.ClassType <> TGArea) or // Falls keine Fläche gezogen wird
       (Not IsAncestorOf(ObjList.DraggedObj)) then begin  // 01.07.06: ergänzt
      p0 := TGPoint(Parent[0]);                  // wegen 3D-Figur-1.geo - Bug
      p1 := TGPoint(Parent[1]);
      If DragList.IndexOf(p0) >= 0 then
        If p1.ClassType = TGPoint then begin
          p1.BecomesChildOf(p0);
          DragList.Add(Self);
          p1.Register4Dragging(DragList);
          DragList.Remove(Self);
          end
        else
      else
      If DragList.IndexOf(p1) >= 0 then
        If p0.ClassType = TGPoint then begin
          p0.BecomesChildOf(p1);
          DragList.Add(Self);
          p0.Register4Dragging(DragList);
          DragList.Remove(Self);
          end;
      end;
    Inherited Register4Dragging(DragList);
    end;
  end;

function TGFixLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := Inherited HasSameDataAs(GO) and
            (TGFixLine(GO).MyLength = Self.MyLength);
  end;

procedure TGFixLine.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  MyLength := (BluePrint as TGFixLine).MyLength;
  end;

procedure TGFixLine.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@MyLength, SizeOf(MyLength));
  end;

procedure TGFixLine.RestoreState;
  begin
  Old_Data.pop(@MyLength);
  Inherited RestoreState;
  end;

procedure TGFixLine.UpdateParams;
  var p1, p2 : TGPoint;
      adist  : Double;
  begin
  DataValid := False;
  p1 := TGPoint(Parent[0]);
  If (p1 <> Nil) and (p1.DataValid) then begin
    X1 := p1.X;
    Y1 := p1.Y;
    p2 := TGPoint(Parent[1]);
    If (p2 <> Nil) and (p2.DataValid) then begin
      X2 := p2.X;
      Y2 := p2.Y;
      GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
      adist := Hypot(X2 - X1, Y2 - Y1);
      DataValid := Abs(adist - MyLength) * act_PixelPerXcm < 0.05;
        // Toleriere höchstens ein halbes Pixel Abstandsfehler !
        // Wird gebraucht beim Import von Zeichnungen, die auf anderen
        // Rechnern hergestellt wurden. Andererseits ist hier keine strenge
        // Qualitätskontrolle mehr nötig, weil die Endpunkte der Strecke
        // sich schon auf den korrekten Abstand geeinigt haben.
      UpdateScreenCoords;
      end;
    end;
  end;

procedure TGFixLine.VirtualizeCoords;
  begin
  Inherited VirtualizeCoords;
  If DataValid then
    MyLength := Hypot(X2 - X1, Y2 - Y1)    { ergänzt 04.09.03 }
  else
    MyLength := MyLength * ppcm_corrfactor / ObjList.e1x;
  end;

procedure TGFixLine.Invalidate;
  var pP1, pP2 : TGPoint;
  begin
  If Parent.Count > 1 then begin
    pP1 := TGPoint(Parent[0]);
    pP2 := TGPoint(Parent[1]);
    pP1.Stops2BeChildOf(Parent[1]);         { Alle eventuellen Eltern-Kindverhältnisse auflösen. }
    pP2.Stops2BeChildOf(Parent[0]);
    If pP1.IsFriendOf(Parent[1]) then
      pP1.EndFriendshipWith(Parent[1]);
    end;
  Inherited Invalidate;
  end;

procedure TGFixLine.Revalidate;
  var GMBP   : TGPoint;
      wx, wy : Integer;
  function GetMostBoundParent: TGeoObj;
    var p1, p2 : TGeoObj;
    begin
    p1 := Parent[0];
    p2 := Parent[1];
    If p1.ClassType = TGPoint then
      If p2.ClassType = TGPoint then
        If p1.Parent.Count = 0 then
          GetMostBoundParent := p2
        else
          GetMostBoundParent := p1
      else
        GetMostBoundParent := p2
    else
      GetMostBoundParent := p1;
    end;

  begin
  AdjustFriendlyLinks;
  GMBP := TGPoint(GetMostBoundParent);
  With ObjList do begin
    FillDragList(GMBP);
    GetWinCoords(GMBP.X, GMBP.Y, wx, wy);
    DragObjects(wx, wy, False);
    end;
  Inherited Revalidate;
  end;

procedure TGFixLine.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_length, CME_PopupClick, cmd_EditLength);
  end;

function TGFixLine.GetInfo: String;
  var arg : String;
  begin
  arg := Float2Str(MyLength, 3);
  Result := Format(MyObjTxt[3], [arg]);
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;

destructor TGFixLine.Destroy;
  begin
  TGPoint(Parent[0]).EndFriendShipWith(Parent[1]);
  Inherited Destroy;
  end;


{--------------------------------------------------}
{  TGVector's method implementations:              }
{--------------------------------------------------}

constructor TGVector.Create(iObjList: TGeoObjListe; iP1, iP2 : TGeoObj; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, iP1, iP2, iis_visible);
  end;

constructor TGVector.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  X21 := R.ReadFloat;     { überflüssige Variablen !! }
  Y21 := R.ReadFloat;
  X22 := R.ReadFloat;
  Y22 := R.ReadFloat;
  dx  := R.ReadFloat;
  dy  := R.ReadFloat;
  end;

function TGVector.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccVector, ccPointOrVector]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGVector.HasSameDataAs(GO: TGeoObj): Boolean;
  var i : Integer;
  begin
  If (GO is TGVector) and (Parent.Count = GO.Parent.Count) then begin
    Result := True;
    i := 0;
    While Result and (i < Parent.Count) do
      If GO.Parent[i] <> Parent[i] then
        Result := False
      else
        i := i + 1;
    end
  else
    Result := False;
  end;

function TGVector.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('v');
  end;

function TGVector.GetDataStr: String;
  begin
  Result := '(' + Float2Str(X2 - X1, 2) + ' | ' + Float2Str(Y2 - Y1, 2) + ')';
  end;

function TGVector.GetValue(selector : Integer) : Double;
  begin
  Case selector of
    gv_x   : Result := dx;
    gv_y   : Result := dy;
  else
    Result := Inherited GetValue(selector);
  end;
  end;

function TGVector.GetAncestorVector: TGVector;
  var Map : TGTransformation;
  begin
  If (Parent.Count = 2) then
    if TGeoObj(Parent[1]) is TGVector then
      Result := TGVector(Parent[1]).GetAncestorVector
    else begin // Parent[1] ist ein Punkt !!
      Result := Self;
      If (TGeoObj(Parent[1]) is TGMappedPoint) and
         (TGeoObj(Parent[1]).Parent[0] = Parent[0]) and
         (TGeoObj(TGeoObj(Parent[1]).Parent[1]) is TGTransformation) then begin
        Map := TGeoObj(Parent[1]).Parent[1];
        If Map.MapType = mapTranslation then
          Result := TGVector(Map.Parent[0]).GetAncestorVector;
        end;
      end
  else  // Nur bei ungeschlechtlicher Vektor-Vermehrung, also: Nullvektor!
    Result := Self;
  end;

procedure TGVector.BecomesChildOf(GO: TGeoObj);
  begin
  While (GO is TGVector) and
        (TGeoObj(GO.Parent[1]) is TGVector) do
    GO := GO.Parent[1];
  Inherited BecomesChildOf(GO);
  end;

procedure TGVector.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@sx21, SizeOf(sx21));
  Old_Data.push(@sy21, SizeOf(sy21));
  Old_Data.push(@sx22, SizeOf(sx22));
  Old_Data.push(@sy22, SizeOf(sy22));
  Old_Data.push(@X21, SizeOf(X21));
  Old_Data.push(@Y21, SizeOf(Y21));
  Old_Data.push(@X22, SizeOf(X22));
  Old_Data.push(@Y22, SizeOf(Y22));
  Old_Data.push(@dx, SizeOf(dx));
  Old_Data.push(@dy, SizeOf(dy));
  end;

procedure TGVector.RestoreState;
  begin
  Old_Data.pop(@dy);
  Old_Data.pop(@dx);
  Old_Data.pop(@Y22);
  Old_Data.pop(@X22);
  Old_Data.pop(@Y21);
  Old_Data.pop(@X21);
  Old_Data.pop(@sy22);
  Old_Data.pop(@sx22);
  Old_Data.pop(@sy21);
  Old_Data.pop(@sx21);
  Inherited RestoreState;
  end;

procedure TGVector.UpdateParams;
  var p1 : TGPoint;
      p2 : TGeoObj;  // kann Punkt oder Vektor sein !
  begin
  p1 := TGPoint(Parent[0]);
  If Parent.Count = 2 then
    p2 := Parent[1]
  else
    p2 := p1;         { Bei ungeschlechtlicher Vermehrung ...        }
  DataValid := p1.DataValid and
               p2.DataValid;
  If DataValid then begin
    X1 := p1.X;
    Y1 := p1.Y;
    If p2 is TGPoint then begin   { Dann ist der Vektor ein durch    }
      X2 := TGPoint(p2).X;        {   zwei Punkte festgelegter       }
      Y2 := TGPoint(p2).Y;        {   "freier" Vektor                }
      dx := X2 - X1;              {   ( oder ein Nullvektor )        }
      dy := Y2 - Y1;
      end
    else begin                    { Dann ist der Vektor eine weitere }
      dx := TGVector(p2).dx;      {   Instanz eines anderen "Mutter- }
      dy := TGVector(p2).dy;      {   Vektors", der als 2. Elter     }
      X2 := X1 + dx;              {   abgespeichert ist              }
      Y2 := Y1 + dy;
      end;
    GetHesseEqFromPtAndDir(X1, Y1, dx, dy, FHesseEq);
    UpdateScreenCoords;
    end;
  end;

procedure TGVector.UpdateScreenCoords;
  var dr, dx0, dy0,
      fx, fy      : Double;
  begin
  Inherited UpdateScreenCoords;   { berechnet (sx1, sy1) und (sx2, sy2) }
  If DataCanShow then begin
    dr := Hypot(dx, dy);    { Stützpunkte für die Pfeilspitze berechnen }
    If dr > epsilon then begin
      dx0 := dx / dr * 0.4 * act_pixelPerXcm;
      dy0 := dy / dr * 0.4 * act_pixelPerYcm;
      fx  := sx2 - dx0;
      fy  := sy2 + dy0;
      dx0 := dx0 * 0.3;
      dy0 := dy0 * 0.3;
      sx21 := Round(fx + dy0);
      sy21 := Round(fy + dx0);
      sx22 := Round(fx - dy0);
      sy22 := Round(fy - dx0);
      end
    else begin
      sx21 := sx2; sy21 := sy2;
      sx22 := sx2; sy22 := sy2;
      end;
    end;
  end;

procedure TGVector.DrawIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm, sx1, sy1, sx2,  sy2,  MyPenStyle);
    draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm, sx2, sy2, sx21, sy21, MyPenStyle);
    draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm, sx2, sy2, sx22, sy22, MyPenStyle);
    end;
  end;

procedure TGVector.HideIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm, sx1, sy1, sx2,  sy2,  MyPenStyle);
    draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm, sx2, sy2, sx21, sy21, MyPenStyle);
    draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm, sx2, sy2, sx22, sy22, MyPenStyle);
    end;
  end;

function TGVector.GetInfo: String;
  begin
  If Parent.Count > 1 then
    If TGeoObj(Parent[1]) is TGPoint then begin
      Result := MyObjTxt[46];  // Vector from one TGPoint to another TGPoint
      InsertNameOf(Self, Result);
      InsertNameOf(TGeoObj(Parent[0]), Result);
      InsertNameOf(TGeoObj(Parent[1]), Result);
      end
    else begin // Parent[1] is supposed to be a TGVector
      Result := MyObjTxt[47];  // ==> another vector instance
      InsertNameOf(Self, Result);
      InsertNameOf(TGeoObj(Parent[1]), Result);
      end
  else begin  // Parent[0] is supposed to be a single TGPoint
    Result := MyObjTxt[115];   // ==> this is a "null vector"
    InsertNameOf(Self, Result);
    end;
  end;


{--------------------------------------------------}
{  TGHalfLine's method implementations:            }
{--------------------------------------------------}

function TGHalfLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO is TGHalfLine) and
            (Parent[0] = GO.Parent[0]) and
            (Parent[1] = GO.Parent[1]);
  end;

function TGHalfLine.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('h');
  end;

function TGHalfLine.Dist (xm, ym: Double): Double;
  var xf, yf, tv : Double;
  begin  { of Dist }
  GetPedalPoint(X1, Y1, X2, Y2, xm, ym, xf, yf);
  If GetTV(X1, Y1, X2, Y2, xf, yf, tv) then
    If tv >= 0 then
      LastDist := Hypot(xm - xf, ym - yf)
    else
      LastDist := Hypot(xm - X1, ym - Y1)
  else
    LastDist := 1.0e300;
  Dist := LastDist;
  end;   { of Dist }

function TGHalfLine.IsNearMouse: Boolean;
  begin
  If (ObjList.LastMousePos.X - sx1) * (sx2 - sx1) +
     (ObjList.LastMousePos.Y - sy1) * (sy2 - sy1) >= 0 then
    Result := DistPt2Line(sx1, sy1, sx2, sy2,
                          ObjList.LastMousePos.X,
                          ObjList.LastMousePos.Y) < CatchDist
  else
    Result := Hypot(ObjList.LastMousePos.X - sx1,
                    ObjList.LastMousePos.Y - sy1) < CatchDist;
  end;

function TGHalfLine.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr in [1, 2] then
    Result := Parent[Pred(nr)]
  else
    Result := Nil;
  end;

function TGHalfLine.Includes(xp, yp: Double): Boolean;
  var xP1, yP1, tv : Double;
  begin
  If Inherited Includes(xp, yp) then begin
    xP1 := TGPoint(Parent[1]).X;
    yP1 := TGPoint(Parent[1]).Y;
    tv  := -1;
    Result := GetTV(X1, Y1, xP1, yP1, xp, yp, tv) and (tv >= -DistEpsilon);
    end
  else
    Result := False;
  end;

function TGHalfLine.GetWinPosNextTo(_X, _Y: Double): TPoint;
  { Implementierung für HalfLines }
  var _sx, _sy : Double;
      ix, iy   : Integer;
  begin
  GetPedalPoint(X1, Y1, X2, Y2, _X, _Y, _sx, _sy);
  If Includes(_sx, _sy) then
    ObjList.GetWinCoords(_sx, _sy, ix, iy)
  else
    ObjList.GetWinCoords(X1, Y1, ix, iy);
  Result := Point(ix, iy);
  end;

function TGHalfLine.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  { Parameter-Bereich 0..1, sofern P(px|py) zwischen den
    definierenden Punkten Parent[0] und Parent[1] liegt }
  var e_rv : TFloatPoint;
  begin
  e_rv := GetNormalizedDirection;
  Result := GetTV(X1, Y1, X1 + e_rv.x, Y1 + e_rv.y, px, py, param);
  end;

function TGHalfLine.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var e_rv : TFloatPoint;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  If DataValid then begin
    e_rv := GetNormalizedDirection;
    px := X1 + param * e_rv.x;
    py := Y1 + param * e_rv.y;
    Result := True;
    end;
  end;

function TGHalfLine.GetRandomParam: Double;
  begin
  Result := Abs(ui2gt(GetRandom(0, 1)));
  end;

function TGHalfLine.GetLinePtWithMinMouseDist(xm, ym, quant: Double;
                  var px, py: Double): Boolean;
  var s : Double;
  begin
  if Inherited GetLinePtWithMinMouseDist(xm, ym, quant, px, py) then begin
    If (Not Includes(px, py)) and
       (GetTV(X1, Y1, X2, Y2, px, py, s)) and
       (s < 0) then begin
      px := X1;            { Punkt ganz an den Strahlanfang....    }
      py := Y1;
      end;
    Result := True;
    end
  else
    Result := False;
  end;

function TGHalfLine.GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean;
  var T1x, T1y, T2x, T2y : Double;
      v1, v2 : Boolean;
  begin
  IntersectCircleWithLine(EP.X, EP.Y, r, X1, Y1, X2, Y2, T1x, T1y, T2x, T2y, v1, v2);
  If v1 then v1 := Includes(T1x, T1y);
  If v2 then v2 := Includes(T2x, T2y);
  If v2 and
     ( (Not v1) or
       (Hypot(T1x - px, T1y - py) > Hypot(T2x - px, T2y - py)) ) then begin
    px := T2x;
    py := T2y;
    end
  else begin
    px := T1x;
    py := T1y;
    end;
  Result := v1 or v2;
  end;

procedure TGHalfLine.UpdateScreenCoords;
  var rX2, rY2 : Double;

  procedure MoveSecondPointOff;
    var dr   : Double;
        e_rv : TFloatPoint;
    begin
    If DataValid then begin
      if ObjList.LogWinKnows(X1, Y1) = 1 then begin
        X := X1;  Y := Y1; end
      else
        If ObjList.LogWinKnows(X2, Y2) = 1 then begin
          X := X2;  Y := Y2; end
        else
          If Not GetPedalPoint (X1, Y1, X2, Y2,
                                ObjList.xCenter, ObjList.yCenter,
                                X, Y) then begin
            DataValid := False;
            Exit;
            end;
      dr   := 3.0 * ObjList.LogWinRadius;
      e_rv := GetNormalizedDirection;
      rX2  := X + e_rv.x * dr;
      rY2  := Y + e_rv.y * dr;
      end;
    end;

  begin
  If DataValid then begin
    MoveSecondPointOff;
    DataCanShow := DataValid and LineIntersectsWindow;
    If DataCanShow then begin
      ObjList.GetWinCoords( X1,  Y1, sx1, sy1);
      ObjList.GetWinCoords(rX2, rY2, sx2, sy2);
      end;
    end;
  end;

procedure TGHalfLine.ResetOLCPList(PointList : TVector3List);
  var ax, ay, bx, by, p : Double;
      v1, v2            : Boolean;
  begin
  ax := X1; ay := Y1;
  bx := X2; by := Y2;
  With ObjList do
    IntersectCircleWithLine(xCenter, yCenter, LogWinRadius,
                            X1, Y1, X2, Y2,
                            ax, ay, bx, by, v1, v2);
  If v2 then
    GetParamFromCoords(bx, by, p)
  else
    p := -1;
  If (p <= 0) and v1 then
    GetParamFromCoords(ax, ay, p);
  If p > 0 then
    PointList.Reset2StandardList(0.0001, p, 40)
  else
    PointList.Reset2StandardList(0.0001, 3.0, 40);
  end;

function TGHalfLine.GetDataStr: String;
  var s1, s2 : String;
  begin
  s1 := Inherited GetDataStr;
  IF Length(s1) > 0 then begin
    If Abs(X2 - X1) > Abs(Y2 - Y1) then
      If X2 > X1 then
        s2 := ';  x' + grgl + Float2Str(X1, 2)
      else
        s2 := ';  x' + klgl + Float2Str(X1, 2)
    else
      If Y2 > Y1 then
        s2 := ';  y' + grgl + Float2Str(Y1, 2)
      else
        s2 := ';  y' + klgl + Float2Str(Y1, 2);
    Insert(s2, s1, Length(s1) - 1);
    end;
  Result := s1;
  end;

function TGHalfLine.GetInfo: String;
  begin
  Result := MyObjTxt[41];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;


{--------------------------------------------------}
{  TGLongLine's method implementations:            }
{--------------------------------------------------}

constructor TGLongLine.Create(iObjList: TGeoObjListe; iP1, iP2: TGeoObj; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, iP1, iP2, iis_visible);
  end;

function TGLongLine.CreateI2GElementNode(DOMDoc: IXMLDocument): IXMLNode;
  var coordNode, valNodeX, valNodeY, valNodeZ : IXMLNode;
  begin
  coordNode := DOMDoc.createNode('homogeneous_coordinates');
  valNodeX := DOMDoc.createNode('double');
  valNodeX.nodeValue := FloatToStr(HesseEq.X);
  coordNode.childNodes.add(valNodeX);
  valNodeY := DOMDoc.createNode('double');
  valNodeY.nodeValue := FloatToStr(HesseEq.Y);
  coordNode.childNodes.add(valNodeY);
  valNodeZ := DOMDoc.createNode('double');
  valNodeZ.nodeValue := FloatToStr(HesseEq.Z);
  coordNode.childNodes.add(valNodeZ);
  Result := DOMDoc.createNode('line');
  Result.setAttribute('id', Name);
  Result.childNodes.add(coordNode);
  end;

function TGLongLine.CreateI2GConstraintNode(DOMDoc: IXMLDocument;
                                            ObjNames: TStrings): IXMLNode;
  var LnNode,
      P1Node,
      P2Node: IXMLNode;
  begin
  Result := Nil;
  If AllParentsInList(ObjNames) then begin
    LnNode := DOMDoc.createNode('line');
    LnNode.setAttribute('out', 'true');
    LnNode.nodeValue := Name;
    P1Node := DOMDoc.createNode('point');
    P1Node.nodeValue := TGeoObj(Parent[0]).Name;
    P2Node := DOMDoc.createNode('point');
    P2Node.nodeValue := TGeoObj(Parent[1]).Name;
    Result := DOMDoc.createNode('line_through_two_points');
    Result.childNodes.add(LnNode);
    Result.childNodes.add(P1Node);
    Result.childNodes.add(P2Node);
    end;
  end;

function TGLongLine.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccBorderLine, ccBorderOrArea]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGLongLine.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('g');
  end;

function TGLongLine.GetDataStr: String;
  begin
  Result := Inherited GetDataStr;
  end;

procedure TGLongLine.UpdateScreenCoords;
  var rP1, rP2 : TFloatPoint;
  begin
  If DataValid then begin
    MovePointsOff(rP1, rP2);
    DataCanShow := DataValid and (ObjList.LogWinKnows(X, Y) = 1);
    If DataCanShow then begin
      ObjList.GetWinCoords(rP1.X, rP1.Y, sx1, sy1);
      ObjList.GetWinCoords(rP2.X, rP2.Y, sx2, sy2);
      end;
    end;
  end;

procedure TGLongLine.VirtualizeCoords;
  begin
  Inherited VirtualizeCoords;
  If Parent.Count >= 2 then begin
    X1 := TGeoObj(Parent[0]).X;
    Y1 := TGeoObj(Parent[0]).Y;
    X2 := TGeoObj(Parent[1]).X;
    Y2 := TGeoObj(Parent[1]).Y;
    end;
  DataValid := GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
  end;

function TGLongLine.Dist (xm, ym: Double): Double;
  begin
  LastDist := DistPt2Line(X1, Y1, X2, Y2, xm, ym);
  Dist     := LastDist;
  end;

function TGLongLine.IsNearMouse: Boolean;
  begin
  Result := DistPt2Line(sx1, sy1, sx2, sy2,
                        ObjList.LastMousePos.X,
                        ObjList.LastMousePos.Y) < CatchDist;
  end;

function TGLongLine.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr in [1, 2] then
    Result := Parent[Pred(nr)]
  else
    Result := Nil;
  end;

function TGLongLine.GetValue(selector: Integer): Double;
  begin
  Result := Inherited GetValue(selector);
  end;

function TGLongLine.GetRandomParam: Double;
  begin
  Result := ui2gt(GetRandom(-1, 1));
  end;

function TGLongLine.GetFillHandle(Ori: Boolean): HRgn;
  var VList : TFloatPointList;
      PList : Array [0..4] of TPoint;
      n, i  : Integer;
  begin
  If Ori then
    GetLeftSideWindowPolygon(X1, Y1, X2, Y2,
                             ObjList.xMin, ObjList.yMin,
                             ObjList.xMax, ObjList.yMax,
                             VList)
  else
    GetLeftSideWindowPolygon(X2, Y2, X1, Y1,
                             ObjList.xMin, ObjList.yMin,
                             ObjList.xMax, ObjList.yMax,
                             VList);
  n := Length(VList);
  If n > 0 then begin
    For i := 0 to Pred(n) do
      ObjList.GetWinCoords(VList[i].x, VList[i].y,
                           PList[i].X, PList[i].Y);
    Result := CreatePolygonRgn(PList, n, PolyFillMode);
    end
  else
    Result := 0;
  end;

procedure TGLongLine.ResetOLCPList(PointList : TVector3List);
  var ax, ay, bx, by,
      p1, p2        : Double;
      v1, v2        : Boolean;
  begin
  ax := X1; ay := Y1;
  bx := X2; by := Y2;
  With ObjList do
    IntersectCircleWithLine(xCenter, yCenter, LogWinRadius,
                            X1, Y1, X2, Y2,
                            ax, ay, bx, by, v1, v2);
  If v1 and v2 then begin
    GetParamFromCoords(ax, ay, p1);
    GetParamFromCoords(bx, by, p2);
    PointList.Reset2StandardList(p1, p2, 50);
    end
  else
    PointList.Reset2StandardList(-1, 2, 50);
  end;

function TGLongLine.GetInfo: String;
  begin
  Result := MyObjTxt[4];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;


{-------------------------------------------}
{ TGMirrorLine's Methods Implementation     }
{-------------------------------------------}

{ Veraltetes Objekt, inzwischen ersetzt durch TGMirrorLongLine;
  wird aber aus Gründen der Rückwärts-Kompatibilität noch gebraucht!
    (Fehlermeldung von Kristine Friebe vom Januar 2001)               }

constructor TGMirrorLine.Create(iObjList: TGeoObjListe; iL, iSym : TGeoObj; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, iL, iSym, iis_visible);
  FName   := DefaultName;
  end;

function TGMirrorLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGMirrorLine) and
            (GO.Parent[0] = Parent[0]) and
            (GO.Parent[1] = Parent[1]);
  end;

procedure TGMirrorLine.UpdateParams;
  var LFx, LFy : Double;
  begin
  DataValid := TGeoObj(Parent[0]).DataValid and
               TGeoObj(Parent[1]).DataValid;
  If DataValid then begin
    If TGeoObj(Parent[1]) is TGStraightLine then
      GetPedalPoint(TGStraightLine(Parent[1]).X1, TGStraightLine(Parent[1]).Y1,
                    TGStraightLine(Parent[1]).X2, TGStraightLine(Parent[1]).Y2,
                    TGStraightLine(Parent[0]).X1, TGStraightLine(Parent[0]).Y1,
                    LFx, LFy)
    else begin
      LFx := TGPoint(Parent[1]).X;
      LFy := TGPoint(Parent[1]).Y;
      end;
    X1 := 2 * LFx - TGStraightLine(Parent[0]).X1;
    Y1 := 2 * LFy - TGStraightLine(Parent[0]).Y1;
    If TGeoObj(Parent[1]) is TGStraightLine then
      GetPedalPoint(TGStraightLine(Parent[1]).X1, TGStraightLine(Parent[1]).Y1,
                    TGStraightLine(Parent[1]).X2, TGStraightLine(Parent[1]).Y2,
                    TGStraightLine(Parent[0]).X2, TGStraightLine(Parent[0]).Y2,
                    LFx, LFy)
    else begin
      LFx := TGPoint(Parent[1]).X;
      LFy := TGPoint(Parent[1]).Y;
      end;
    X2 := 2 * LFx - TGStraightLine(Parent[0]).X2;
    Y2 := 2 * LFy - TGStraightLine(Parent[0]).Y2;
    GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
    UpdateScreenCoords;
    end;
  end;

function TGMirrorLine.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;


{-------------------------------------------}
{ TGMirrorLongLine's Methods Implementation }
{-------------------------------------------}

constructor TGMirrorLongLine.Create(iObjList: TGeoObjListe; iL, iSym : TGeoObj; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, 0, 0, 20, 20, False);
  BecomesChildOf(iL);
  BecomesChildOf(iSym);
  UpdateParams;
  If iis_visible then begin
    ShowsAlways := True;
    DrawIt;
    end;
  end;

function TGMirrorLongLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := ((GO.ClassType = TGMirrorLongLine) or
             (GO.ClassType = TGMirrorLine)) and
            (GO.Parent[0] = Parent[0]) and
            (GO.Parent[1] = Parent[1]);
  end;

procedure TGMirrorLongLine.UpdateParams;
  var LFx, LFy : Double;
  begin
  DataValid := TGeoObj(Parent[0]).DataValid and
               TGeoObj(Parent[1]).DataValid;
  If DataValid then begin
    If TGeoObj(Parent[1]) is TGStraightLine then
      GetPedalPoint(TGStraightLine(Parent[1]).X1, TGStraightLine(Parent[1]).Y1,
                    TGStraightLine(Parent[1]).X2, TGStraightLine(Parent[1]).Y2,
                    TGStraightLine(Parent[0]).X1, TGStraightLine(Parent[0]).Y1,
                    LFx, LFy)
    else begin
      LFx := TGPoint(Parent[1]).X;
      LFy := TGPoint(Parent[1]).Y;
      end;
    X1 := 2 * LFx - TGStraightLine(Parent[0]).X1;
    Y1 := 2 * LFy - TGStraightLine(Parent[0]).Y1;
    If TGeoObj(Parent[1]) is TGStraightLine then
      GetPedalPoint(TGStraightLine(Parent[1]).X1, TGStraightLine(Parent[1]).Y1,
                    TGStraightLine(Parent[1]).X2, TGStraightLine(Parent[1]).Y2,
                    TGStraightLine(Parent[0]).X2, TGStraightLine(Parent[0]).Y2,
                    LFx, LFy)
    else begin
      LFx := TGPoint(Parent[1]).X;
      LFy := TGPoint(Parent[1]).Y;
      end;
    X2 := 2 * LFx - TGStraightLine(Parent[0]).X2;
    Y2 := 2 * LFy - TGStraightLine(Parent[0]).Y2;
    GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
    UpdateScreenCoords;
    end;
  end;

function TGMirrorLongLine.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;


{-------------------------------------------}
{ TGMovedLongLine's Methods Implementation  }
{-------------------------------------------}

constructor TGMovedLongLine.Create(iObjList: TGeoObjListe; iL, iv: TGeoObj;
  iis_visible: Boolean);
  begin
  Inherited Create(iObjList, 0, 0, 20, 20, False);
  BecomesChildOf(iL);
  BecomesChildOf(iv);
  UpdateParams;
  If iis_visible then begin
    ShowsAlways := True;
    DrawIt;
    end;
  end;

function TGMovedLongLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGMovedLongLine) and
            (GO.Parent[0] = Parent[0]) and
            (GO.Parent[1] = Parent[1]);
  end;

procedure TGMovedLongLine.UpdateParams;
  var PL : TGStraightLine;
      PV : TGVector;
  begin
  DataValid := TGeoObj(Parent[0]).DataValid and
               TGeoObj(Parent[1]).DataValid;
  If DataValid then begin
    PL := TGStraightLine(Parent[0]);
    PV := TGVector(Parent[1]);
    X1 := PL.X1 + PV.dx;
    Y1 := PL.Y1 + PV.dy;
    X2 := PL.X2 + PV.dx;
    Y2 := PL.Y2 + PV.dy;
    GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
    UpdateScreenCoords;
    end;
  end;

function TGMovedLongLine.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;

{-------------------------------------------}
{ TGRotatedLongLine's Methods Implementation}
{-------------------------------------------}

constructor TGRotatedLongLine.Create(iObjList: TGeoObjListe; iL, iMP, iAO: TGeoObj; iis_Visible: Boolean);
  begin
  Inherited Create(iObjList, 0, 0, 20, 20, False);
  BecomesChildOf(iL);         { Urbild-Linie }
  BecomesChildOf(iMP);        { Mittelpunkt der Drehung }
  BecomesChildOf(iAO);        { Argument-Objekt }
  UpdateParams;
  If iis_visible then begin
    ShowsAlways := True;
    DrawIt;
    end;
  end;

function TGRotatedLongLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGRotatedLongLine) and
            (GO.Parent[0] = Parent[0]) and
            (GO.Parent[1] = Parent[1]) and
            (GO.Parent[2] = Parent[2]);
  end;

procedure TGRotatedLongLine.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@RotAngle, SizeOf(RotAngle));
  end;

procedure TGRotatedLongLine.RestoreState;
  begin
  Old_Data.pop(@RotAngle);
  Inherited RestoreState;
  end;

procedure TGRotatedLongLine.UpdateParams;
  var UL     : TGStraightLine;  { Urbild-Linie }
      DP     : TGPoint;         { Drehpunkt    }
      dx, dy : Double;
  begin
  DataValid := TGeoObj(Parent[0]).DataValid and
               TGeoObj(Parent[1]).DataValid;
  If DataValid then begin
    UL := TGStraightLine(Parent[0]);
    DP := TGPoint(Parent[1]);
    RotAngle := TGeoObj(Parent[2]).GetValue(gv_val);
    dx := UL.X1 - DP.X;
    dy := UL.Y1 - DP.Y;
    RotateVector2ByAngle(dx, dy, RotAngle, dx, dy);
    X1 := DP.X + dx;
    Y1 := DP.Y + dy;
    dx := UL.X2 - DP.X;
    dy := UL.Y2 - DP.Y;
    RotateVector2ByAngle(dx, dy, RotAngle, dx, dy);
    X2 := DP.X + dx;
    Y2 := DP.Y + dy;
    GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
    UpdateScreenCoords;
    end;
  end;

function TGRotatedLongLine.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;


{--------------------------------------------------}
{ TGStretchedLongLine's Methods Implementation     }
{--------------------------------------------------}


constructor TGStretchedLongLine.Create(iObjList: TGeoObjListe; iL, iZP,
  iSF: TGeoObj; iis_Visible: Boolean);
  begin
  Inherited Create(iObjList, 0, 0, 1, 1, False);
  BecomesChildOf(iL);        { Urbild-Linie }
  BecomesChildOf(iZP);       { Zentrumspunkt }
  BecomesChildOf(iSF);       { Streckfaktor }
  UpdateParams;
  If iis_visible then begin
    ShowsAlways := True;
    DrawIt;
    end;
  end;

function TGStretchedLongLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGStretchedLongLine) and
            (GO.Parent[0] = Parent[0]) and
            (GO.Parent[1] = Parent[1]) and
            (GO.Parent[2] = Parent[2]);
  end;

function TGStretchedLongLine.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;

procedure TGStretchedLongLine.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@SFactor, SizeOf(SFactor));
  end;

procedure TGStretchedLongLine.RestoreState;
  begin
  Old_Data.pop(@SFactor);
  Inherited RestoreState;
  end;

procedure TGStretchedLongLine.UpdateParams;
  var UL     : TGStraightLine;  { Urbild-Linie }
      ZP     : TGPoint;         { Zentrum      }
      dx, dy : Double;
  begin
  DataValid := TGeoObj(Parent[0]).DataValid and
               TGeoObj(Parent[1]).DataValid;
  If DataValid then begin
    UL := TGStraightLine(Parent[0]);
    ZP := TGPoint(Parent[1]);
    sFactor := TGeoObj(Parent[2]).GetValue(gv_val);
    dx := UL.X1 - ZP.X;
    dy := UL.Y1 - ZP.Y;
    X1 := ZP.X + sFactor * dx;
    Y1 := ZP.Y + sFactor * dy;
    dx := UL.X2 - ZP.X;
    dy := UL.Y2 - ZP.Y;
    X2 := ZP.X + sFactor * dx;
    Y2 := ZP.Y + sFactor * dy;
    GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
    UpdateScreenCoords;
    end;
  end;


{-------------------------------------------}
{ TGMappedLine's Methods Implementation     }
{-------------------------------------------}

constructor TGMappedLine.Create(iObjList: TGeoObjListe; iOriLn, iMapObj: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, 0, -10, 10, -10, False);
  BecomesChildOf(iOriLn);
  BecomesChildOf(iMapObj);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

procedure TGMappedLine.GetDataFromOldMappedObj(OMO: TGeoObj);
  begin
  Inherited GetDataFromOldMappedObj(OMO);
  With OMO as TGLongLine do begin
    Self.X1 := X1;
    Self.Y1 := Y1;
    Self.X2 := X2;
    Self.Y2 := Y2;
    end;
  end;

function  TGMappedLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = ClassType) and
            (Parent[0] = GO.Parent[0]) and
            (Parent[1] = GO.Parent[1]);
  end;

function TGMappedLine.GetImplicitMakStartObj(n: Integer): TGeoObj;
  { 05.01.2007 : neu eingeführt, um das Problem der "impliziten Start-
                 objekte" in Makros zu lösen. Sollte nur mit n = 0 oder
                 n = 1 aufgerufen werden.
    Dann wird bei der Urbild-Geraden nachgefragt, welches ihre Träger-
    punkte sind. Das zurückgegebene Punkt-Objekte wird derselben Abbildung
    unterzogen, die Self erzeugt (hat). Das erzeugte Bild wird als
    Ergebnis zurückgegeben.                                                }
  var piso : TGPoint;  // "P"arent's "I"mplicit "S"tart "O"bject
      err  : Integer;
  begin
  If (n = 0) or (n = 1) then begin
    piso := TGeoObj(Parent[0]).GetImplicitMakStartObj(n) as TGPoint;
    Result := ObjList.InsertObject(TGMappedPoint.Create(ObjList, piso, Parent[1], False),
                                   err);
    end
  else
    Result := Nil;
  end;

function TGMappedLine.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  Result := Nil;
  end;

procedure TGMappedLine.UpdateParams;
  var OL_v, ML_v : TVector3;
      dir        : TFloatPoint;
  begin
  If TGeoObj(Parent[0]).DataValid and
     TGeoObj(Parent[1]).DataValid then begin
    OL_v := TVector3.Create(0, 0, 0);
    ML_v := TVector3.Create(0, 0, 0);
    try
      TGStraightLine(Parent[0]).GetDataVector(OL_v);

      If TGTransformation(Parent[1]).GetMappedLine(OL_v, ML_v) then begin
        FHesseEq.Assign(ML_v);
        GetPedalPoint(FHesseEq, 0, 0, X1, Y1);
        GetNormalizedDirFromHesseEq(FHesseEq, dir);
        dx := dir.x;
        dy := dir.y;
        X2 := X1 + dx;
        Y2 := Y1 + dy;
        DataValid := True;
        UpdateScreenCoords;
        end
      else
        DataValid := False;
    finally
      OL_v.Free;
      ML_v.Free;
    end;
    end
  else
    DataValid := False;
  end;

function  TGMappedLine.GetInfo: String;
  var s1, s2 : String;
  begin
  s1 := MyObjTxt[42];
  InsertNameOf(Self, s1);
  InsertNameOf(TGeoObj(Parent[0]), s1);
  s2 := TGTransformation(Parent[1]).GetLinkableInfo;
  Result := s1 + s2;
  end;


{-------------------------------------------}
{ TGChordaleLine's Methods Implementation   }
{-------------------------------------------}

procedure TGChordal.UpdateParams;
  var _x1, _y1, _r1,
      _x2, _y2, _r2,
      _dx, _dy,
      _ld, _c   : Double;
      FP1, FP2  : TFloatPoint;
  begin
  DataValid := False;
  If TGeoObj(Parent[0]).DataValid and
     TGeoObj(Parent[1]).DataValid then begin
    If TGeoObj(Parent[0]) is TGCircle then begin
      _x1 := TGCircle(Parent[0]).X1;
      _y1 := TGCircle(Parent[0]).Y1;
      _r1 := TGCircle(Parent[0]).Radius;
      end
    else begin  // Parent[0] is TGPoint
      _x1 := TGPoint(Parent[0]).X;
      _y1 := TGPoint(Parent[0]).Y;
      _r1 := 0;
      end;
    If TGeoObj(Parent[1]) is TGCircle then begin
      _x2 := TGCircle(Parent[1]).X1;
      _y2 := TGCircle(Parent[1]).Y1;
      _r2 := TGCircle(Parent[1]).Radius;
      end
    else begin  // Parent[1] is TGPoint
      _x2 := TGPoint(Parent[1]).X;
      _y2 := TGPoint(Parent[1]).Y;
      _r2 := 0;
      end;
    _dx := _x1 - _x2;
    _dy := _y1 - _y2;
    _ld := Hypot(_dx, _dy);
    If _ld > epsilon then begin
      _c := 0.5 * (Sqr(_r1) - Sqr(_r2) - _dx * (_x1 + _x2) - _dy * (_y1 + _y2));
      FHesseEq.Assign(_dx/_ld, _dy/_ld, _c/_ld, 0);
      If Get2PointsFromHesseEq(FHesseEq, FP1, FP2) then begin
        X1 := FP1.x;  Y1 := FP1.y;
        X2 := FP2.x;  Y2 := FP2.y;
        DataValid := True;
        UpdateScreenCoords;
        end;
      end;
    end;
  end;

function TGChordal.GetInfo: String;
  begin
  Result := MyObjTxt[93];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;


{-------------------------------------------}
{ TGOLLongLine's Methods Implementation     }
{-------------------------------------------}

constructor TGOLLongLine.Create(iObjList: TGeoObjListe; iOL : TGeoObj; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, iOL, Nil, False);
  MyColour := TGeoObj(Parent[0]).MyColour;
  MyPenStyle := TGeoObj(Parent[0]).MyPenStyle;
  MyLineWidth := TGeoObj(Parent[0]).MyLineWidth;
  Set_CBDI;
  UpdateParams;
  If iis_visible then begin
    ShowsAlways := True;
    DrawIt;
    end;
  end;

function TGOLLongLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGOLLongLine) and
            (GO.Parent[0] = Self.Parent[0]);
  end;

function TGOLLongLine.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  Result := Nil;
  end;

function TGOLLongLine.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var dx, dy, db,
      xf, yf : Double;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  dx := X2 - X1;
  dy := Y2 - Y1;
  db := Hypot(dx, dy);
  If DataValid and (db > DistEpsilon) then begin
    dx := dx / db;
    dy := dy / db;
    If GetPedalPoint(X1, Y1, X2, Y2, 0, 0, xf, yf) then begin
      px := xf + param * dx;
      py := yf + param * dy;
      Result := True;
      end
    end;
  end;

function TGOLLongLine.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var dx, dy, db,
      xf, yf : Double;
  begin
  Result := False;
  dx := X2 - X1;
  dy := Y2 - Y1;
  db := Hypot(dx, dy);
  If DataValid and (db > DistEpsilon) then begin
    dx := dx / db;
    dy := dy / db;
    If GetPedalPoint(X1, Y1, X2, Y2, 0, 0, xf, yf) then begin
      If Abs(dx) > Abs(dy) then
        param := (px - xf) / dx
      else
        param := (py - yf) / dy;
      Result := True;
      end;
    end;
  end;

procedure TGOLLongLine.Invalidate;
  var P: TGeoObj;
  begin
  P := Parent[0];
  Stops2BeChildOf(Parent[0]);
  Parent.Add(P);
  Inherited Invalidate;
  end;

procedure TGOLLongLine.Revalidate;
  var p  : TGeoObj;
  begin
  p := TGeoObj(Parent[0]);
  Parent.Remove(p);    { Elter zunächst aus der Parent-Liste entfernen, }
  BecomesChildOf(p);
  Inherited Revalidate;
  end;

procedure TGOLLongLine.UpdateParams;
  var pt, dir : TVector3;
      odx, ody,
      qual    : Double;
      PLL     : TGLocLine;
  begin
  DataValid := False;
  PLL := TGLocLine(Parent[0]);
  If PLL.DataValid then begin
    pt  := TVector3.Create(0, 0, 0);
    dir := TVector3.Create(0, 0, 0);
    try
      If BestLineApprox(PLL.points, qual, pt, dir) and
         (qual > LocSL_LineLimit) then begin
        odx := X2 - X1;   { Alte Steigung merken ! }
        ody := Y2 - Y1;
        X1 := pt.X;
        Y1 := pt.Y;
        { Orientierungs-Umkehr vermeiden : }
        If dir.X * odx + dir.Y * ody < 0 then begin
          X2 := X1 - dir.X;
          Y2 := Y1 - dir.Y;
          end
        else begin
          X2 := X1 + dir.X;
          Y2 := Y1 + dir.Y;
          end;
        GetHesseEqFromPtAndDir(X1, Y1, X2 - X1, Y2 - Y1, FHesseEq);
        DataValid := True;
        UpdateScreenCoords;
        end;
      PLL.ShowsAlways := Not DataValid;
    finally
      dir.Free;
      pt.Free;
    end;
    end;
  end;

procedure TGOLLongLine.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_locstnd, CME_PopupClick,
                     cmd_EditLocLineStnd, True);
  end;

function TGOLLongLine.GetInfo: String;
  begin
  If DataValid then
    Result := MyObjTxt[40]
  else
    Result := MyObjTxt[61];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  end;


{-------------------------------------------}
{ TGBaseLine's Methods Implementation       }
{-------------------------------------------}

constructor TGBaseLine.Create(iObjList: TGeoObjListe; ix1, iy1, ix2, iy2: Integer; iis_visible : Boolean);
  begin
  Inherited Create (iObjList, Nil, Nil, False);
  If ClassType = TGBaseLine then begin   // statt: "... <> TGAxis" (26.02.06)
    ObjList.GetLogCoords(ix1, iy1, X1, Y1);
    ObjList.GetLogCoords(ix2, iy2, X2, Y2);
    dx := X2 - X1;
    dy := Y2 - Y1;
    FStatus := FStatus or gs_DataValid;  { DataValid bleibt immer TRUE !}
    GetHesseEqFromPtAndDir(X1, Y1, dx, dy, FHesseEq);
    UpdateScreenCoords;
    If iis_visible then
      ShowsAlways := True;      { Dies ruft automatisch "DrawIt" auf !  }
    end;
  end;

constructor TGBaseLine.CreateFromHesseEq(iObjList: TGeoObjListe; a, b, c: Double; iis_visible: Boolean);
  var P1, P2 : TFloatPoint;
  begin
  Inherited Create(iObjList, Nil, Nil, False);
  FHesseEq.Assign(a, b, c);
  FHesseEq.DivBy(Hypot(a, b));
  If Get2PointsFromHesseEq(HesseEq, P1, P2) then begin
    X1 := P1.x;
    Y1 := P1.y;
    X2 := P2.x;
    Y2 := P2.y;
    dx := X2 - X1;
    dy := Y2 - Y1;
    FStatus := FStatus or gs_DataValid;  { DataValid bleibt immer TRUE !}
    UpdateScreenCoords;
    If iis_visible then
      ShowsAlways := True;      { Dies ruft automatisch "DrawIt" auf !  }
    end
  else
    FStatus := FStatus and Not gs_DataValid;
  end;

constructor TGBaseLine.CreatePtDir(iObjList: TGeoObjListe; iPt, iDir: TVector3; iis_visible: Boolean);
  begin
  Inherited Create (iObjList, Nil, Nil, iis_visible);
  X1 := iPt.X;
  Y1 := iPt.Y;
  dx := iDir.X;
  dy := iDir.Y;
  X2 := X1 + dx;
  Y2 := Y1 + dy;
  FStatus := FStatus or gs_DataValid;  { DataValid bleibt immer TRUE !}
  GetHesseEqFromPtAndDir(X1, Y1, dx, dy, FHesseEq);
  UpdateScreenCoords;
  DrawIt;
  end;

constructor TGBaseLine.Load(S: TFileStream; iObjList: TGeoObjListe);
  begin
  Inherited Load(S, iObjList);
  S.Read(dx, SizeOf(dx));
  S.Read(dy, SizeOf(dy));
  end;

constructor TGBaseLine.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  dx := R.ReadFloat;
  dy := R.ReadFloat;
  GetHesseEqFromPtAndDir(X1, Y1, dx, dy, FHesseEq);
  end;

constructor TGBaseLine.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  dx := X2 - X1;
  dy := Y2 - Y1;
  GetHesseEqFromPtAndDir(X1, Y1, dx, dy, FHesseEq);
  end;

procedure TGBaseLine.SetDataValid(flag: Boolean);
  { Basisgeraden sind *immer* gültig ! }
  begin
  If DataValid <> True then
    FStatus := FStatus or gs_DataValid
                       or gs_DataCanShow;
  end;

function TGBaseLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := False;
  end;

function TGBaseLine.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := ((ClassGroupId = ccDragableObj) and
             (Self.ClassType = TGBaseLine )) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGBaseLine.GetMatchingCursor(mpt: TPoint): TCursor;
  begin
  If ClassType = TGBaseLine then
    Result := Drag_Cursor
  else
    Result := Inherited GetMatchingCursor(mpt);
  end;

function TGBaseLine.AllAncestorsAreFreePoints(PList: TObjPtrList = Nil): Boolean;
  begin
  Result := False;
  end;

function TGBaseLine.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  Result := Nil;
  end;

procedure TGBaseLine.VirtualizeCoords;
  begin
  ObjList.GetLogCoords(SafeRound(X1 * ppcm_corrfactor),
                       SafeRound(Y1 * ppcm_corrfactor), X1, Y1);
  ObjList.GetLogCoords(SafeRound(X2 * ppcm_corrfactor),
                       SafeRound(Y2 * ppcm_corrfactor), X2, Y2);
  dy := - dy;
  GetHesseEqFromPtAndDir(X1, Y1, dx, dy, FHesseEq);
  DataValid := True;
  end;

procedure TGBaseLine.UpdateParams;
  begin
  If ObjList.DraggedObj = Self then begin
    X1 := ObjList.LogLastMouse_X;
    Y1 := ObjList.LogLastMouse_Y;
    X2 := X1 + dx;
    Y2 := Y1 + dy;
    GetHesseEqFromPtAndDir(X1, Y1, dx, dy, FHesseEq);
    end;
  UpdateScreenCoords;
  end;

function TGBaseLine.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var dx, dy, db,
      xf, yf : Double;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  dx := X2 - X1;
  dy := Y2 - Y1;
  db := Hypot(dx, dy);
  If DataValid and (db > DistEpsilon) then begin
    dx := dx / db;
    dy := dy / db;
    If GetPedalPoint(X1, Y1, X2, Y2, 0, 0, xf, yf) then begin
      px := xf + param * dx;
      py := yf + param * dy;
      Result := True;
      end;
    end;
  end;

function TGBaseLine.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var dx, dy, db,
      xf, yf : Double;
  begin
  Result := False;
  dx := X2 - X1;
  dy := Y2 - Y1;
  db := Hypot(dx, dy);
  If DataValid and (db > DistEpsilon) then begin
    dx := dx / db;
    dy := dy / db;
    IF GetPedalPoint(X1, Y1, X2, Y2, 0, 0, xf, yf) then begin
      If Abs(dx) > Abs(dy) then
        param := (px - xf) / dx
      else
        param := (py - yf) / dy;
      Result := True;
      end;
    end;
  end;

procedure TGBaseLine.RegisterAsMacroStartObject;
  begin
  TMakro(ObjList.MakroList.Last).AddCmd(TMakroCmd.Create(Self, 0));
  end;

function TGBaseLine.GetInfo: String;
  begin
  Result := MyObjTxt[5];
  InsertNameOf(Self, Result);
  end;


{-------------------------------------------}
{ TGDirLine's Methods Implementation        }
{-------------------------------------------}

constructor TGDirLine.Create(iObjList: TGeoObjListe; iP1, iSP: TGeoObj; iAngle : Double; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, iP1, iSP, False);
  dAngle  := iAngle;
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

constructor TGDirLine.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  If GO = Nil then
    dAngle := 0.1
  else
    dAngle := TGDirLine(GO).dAngle;
  end;

procedure TGDirLine.GetSpecialDataFrom(Blueprint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  dAngle := (BluePrint as TGDirLine).dAngle;
  end;

constructor TGDirLine.Load(S: TFileStream; iObjList: TGeoObjListe);
  begin
  Inherited Load(S, iObjList);
  S.Read(dAngle, SizeOf(dAngle));
  end;

constructor TGDirLine.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  dAngle := R.ReadFloat;
  end;

function TGDirLine.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var alpha : Double;
      angle : IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  If ClassType = TGDirLine then begin
    angle := DOMDoc.createNode('term');
    alpha := grad(dAngle);   // Umwandeln ins Gradmaß, BugReport vom 05.04.06
    angle.nodeValue := FloatToStr(alpha);
    Result.childNodes.add(angle);
    end;
  end;

function TGDirLine.HasSameDataAs(GO: TGeoObj): Boolean;
  var L : Double;
  begin
  L := TGDirLine(GO).dAngle;
  Result := (GO.ClassType = TGDirLine) and
            (GO.Parent[0] = Self.Parent[0]) and
            (GO.Parent[1] = Self.Parent[1]) and
            (DataEquivalent(L));
  end;

procedure TGDirLine.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@dAngle, SizeOf(dAngle));
  end;

procedure TGDirLine.RestoreState;
  begin
  Old_Data.pop(@dAngle);
  Inherited RestoreState;
  end;

procedure TGDirLine.VirtualizeCoords;
  begin
  Inherited VirtualizeCoords;
  dAngle := -dAngle;
  end;

procedure TGDirLine.UpdateParams;
  var P1, SP : TGPoint;
      sn     : Double;
  begin
  P1 := TGPoint(Parent[0]);
  SP := TGPoint(Parent[1]);
  If (P1 <> Nil) and (SP <> Nil) and
     P1.DataValid and SP.DataValid then begin
    X1 := SP.X;
    Y1 := SP.Y;
    sn := slope_angle(P1.X - SP.X, P1.Y - SP.Y) + dAngle;  // - statt + ???
    X2 := X1 + cos (sn);
    Y2 := Y1 + sin (sn);
    GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
    DataValid := True;
    UpdateScreenCoords;
    end
  else
    DataValid := False;
  end;

function TGDirLine.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var dx, dy, db : Double;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  dx := X2 - X1;
  dy := Y2 - Y1;
  db := Sqrt(Sqr(dx) + Sqr(dy));
  If DataValid and (db > DistEpsilon) then begin
    dx := dx / db;
    dy := dy / db;
    px := TGPoint(Parent[1]).X + param * dx;
    py := TGPoint(Parent[1]).Y + param * dy;
    Result := True;
    end;
  end;

function TGDirLine.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var dx, dy, db : Double;
  begin
  Result := False;
  dx := X2 - X1;
  dy := Y2 - Y1;
  db := Hypot(dx, dy);
  If DataValid and (db > DistEpsilon) then begin
    dx := dx / db;
    dy := dy / db;
    If Abs(dx) > Abs(dy) then
      param := (px - TGPoint(Parent[1]).X) / dx
    else
      param := (py - TGPoint(Parent[1]).Y) / dy;
    Result := True;
    end;
  end;

function TGDirLine.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr = 1 then
    Result := Parent[1]
  else
    Result := Nil;
  end;

function TGDirLine.DataEquivalent(var data): Boolean;
  begin
  DataEquivalent := Abs(Double(data) - dAngle) < AngleEpsilon;
  end;

function TGDirLine.GetInfo: String;
  var arg : String;
  begin
  arg := Float2Str(grad(dAngle), 3);
  Result := Format(MyObjTxt[6], [arg]);
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;


{-------------------------------------------}
{ TGCircle's Methods Implementation         }
{-------------------------------------------}

constructor TGCircle.Create(iObjList: TGeoObjListe; iP1, iP2: TGeoObj; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, iis_visible);
  F_CCTP := True;
  SetGraphTools(DefNormalLineStyle, 0, 0, clBlack);
  If ClassType = TGCircle then begin
    BecomesChildOf (iP1);
    BecomesChildOf (iP2);
    UpdateParams;
    DrawIt;
    F_CBDI := TGPoint(iP1).Parent.Count + TGPoint(iP2).Parent.Count = 0;
    end;
  end;

constructor TGCircle.Load(S: TFileStream; iObjList: TGeoObjListe);
  begin
  Inherited Load(S, iObjList);
  S.Read(X1, SizeOf(X1));
  S.Read(Y1, SizeOf(Y1));
  S.Read(X2, SizeOf(X2));
  S.Read(Y2, SizeOf(Y2));
  S.Read(Radius, SizeOf(Radius));
  MyBrushStyle := bsClear;
  F_CCTP       := True;
  end;

constructor TGCircle.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  X1 := R.ReadFloat;
  Y1 := R.ReadFloat;
  X2 := R.ReadFloat;
  Y2 := R.ReadFloat;
  Radius := R.ReadFloat;
  F_CCTP := True;
  end;

constructor TGCircle.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var rad_node : IXMLNode;
      rad_str : String;
      n       : Integer;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  Radius := 0;
  rad_node := DE.childNodes.findNode('radius', '');
  if (rad_node <> Nil) and (rad_node.IsTextElement) then begin
    rad_str := literalLine(rad_node.Text);
    val(rad_str, Radius, n);
    If n <> 0 then
      Radius := 0;
    end;
  F_CCTP := True;
  end;

procedure TGCircle.AfterLoading(FromXML: Boolean);
  begin
  Inherited AfterLoading(FromXML);
  If ClassType = TGCircle then
    F_CBDI := TGPoint(Parent[0]).Parent.Count +
              TGPoint(Parent[1]).Parent.Count = 0;
  end;

function TGCircle.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var DOMRadius: IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  DOMRadius := DOMDoc.createNode('radius');
  DOMRadius.nodeValue := FloatToStr(Radius);
  Result.childNodes.add(DOMRadius);
  end;

function TGCircle.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  { Parameter-Bereich 0..1, Bereichs-Überschreitungen werden effektiv
                            in das Einheits-Intervall zurückgemappt  }
  var phi    : Double;
      sinphi,
      cosphi : Extended;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  phi := Slope_Angle(TGPoint(Parent[1]).X - X1,
                     TGPoint(Parent[1]).Y - Y1) + 2 * Pi * param;
  SinCos(phi, sinphi, cosphi);
  px := X1 + Radius * cosphi;
  py := Y1 + Radius * sinphi;
  Result := True;
  end;

function TGCircle.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  { Parameter-Bereich 0..1 }
  var xp1, yp1 : Double;
  begin
  Result := True;
  With TGPoint(Parent[1]) do begin
    xp1 := X;
    yp1 := Y;
    end;
  param := Unsigned_Angle(xp1 - X1, yp1 - Y1,
                          px  - X1, py  - Y1) / (2 * pi);
  end;

function TGCircle.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGCircle) and
            (GO.Parent[0] = Self.Parent[0]) and
            (GO.Parent[1] = Self.Parent[1]);
  end;

function TGCircle.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('k');
  end;

function TGCircle.GetWinPosNextTo(_X, _Y: Double): TPoint;
  var _sx, _sy, slen : Double;
      ix, iy         : Integer;
  begin
  _sx  := _X - X1; _sy := _Y - Y1;
  slen := Hypot(_sx, _sy);
  ObjList.GetWinCoords(X1 + Radius * _sx / slen,
                       Y1 + Radius * _sy / slen, ix, iy);
  Result := Point(ix, iy);
  end;

function TGCircle.GetValue(selector: Integer): Double;
  begin
  If DataValid then
    Case selector of
      gv_x      : Result := X1;
      gv_y      : Result := Y1;
      gv_len    : Result := 2 * pi * Radius;   { Umfang }
      gv_radius : Result := Radius;
      gv_area   : If SignedAreas and IsReversed then
                    Result := - pi * SQR(Radius)
                  else
                    Result :=   pi * SQR(Radius);
    else
      Result    := 0;
    end  { of case }
  else { of if }
    Result := 0;
  end;

function TGCircle.FixedParentsCount: Integer;
  var n, i : Integer;
  begin
  n := 0;
  For i := 0 to Pred(Parent.Count) do
    If TGeoObj(Parent[i]) is TGPoint then
      If TGPoint(Parent[i]).ClassType = TGPoint then begin  { Basispunkte,   }
        If (TGPoint(Parent[i]).Parent.Count > 0) or         { die nicht ganz }
           (TGpoint(Parent[i]).friends.Count > 0) then      {   frei sind    }
          n := n + 1;
        end
      else              { alle anderen Punkt-Sorten }
        n := n + 1;
  Result := n;
  end;

function TGCircle.GetLinePtWithMinMouseDist(xm, ym, quant: Double;
                  var px, py: Double): Boolean;
  var dx, dy, s : Double;
  begin
  dx := xm - X1;  { x-mouse minus x-Mittelpunkt ! }
  dy := ym - Y1;  { y-mouse minus y-Mittelpunkt ! }
  s := Hypot(dx, dy);
  If s > DistEpsilon then begin
    s  := Radius / s;
    px := X1 + s * dx;
    py := Y1 + s * dy;
    Result := True;
    end
  else
    Result := False;
  end;

function TGCircle.GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean;
  var T1x, T1y, T2x, T2y : Double;
      v1, v2 : Boolean;
  begin
  IntersectCircles(EP.X, EP.Y, r, X1, Y1, Radius, T1x, T1y, T2x, T2y, v1, v2);
  If v2 and
     ( (Not v1) or
       (Hypot(T1x - px, T1y - py) > Hypot(T2x - px, T2y - py)) ) then begin
    px := T2x;
    py := T2y;
    end
  else begin
    px := T1x;
    py := T1y;
    end;
  Result := v1 or v2;
  end;

procedure TGCircle.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@Radius, SizeOf(Radius));
  end;

procedure TGCircle.RestoreState;
  begin
  Old_Data.pop(@Radius);
  Inherited RestoreState;
  end;

procedure TGCircle.VirtualizeCoords;
  begin
  Inherited VirtualizeCoords;
  Radius := Hypot(X2 - X1, Y2 - Y1);
  end;

procedure TGCircle.SetIsFlagged(flag: Boolean);
  var TL : TGLine;
      i  : Integer;
  begin
  If (ObjList.DraggedObj is TGArea) and
     (ObjList.DraggedObj.Parent[0] = Self) then
    For i := 0 to Pred(Parent.Count) do
      If (TGeoObj(Parent[i]).ClassType = TGPoint) and
         (Not TGPoint(Parent[i]).IsLineBound(TL)) and
         (TGPoint(Parent[i]).friends.Count = 0) then
        TGPoint(Parent[i]).IsFlagged := flag;
    Inherited SetIsFlagged(flag);
  end;

procedure TGCircle.GetDataVector(var v: TVector3);
  begin
  v.X := X1;
  v.Y := Y1;
  v.Z := Radius;
  v.tag := 1;
  end;

procedure TGCircle.GetConicCoeff(var coeff: TCoeff6);
  begin
  coeff[0] := 1;
  coeff[1] := 0;
  coeff[2] := 1;
  coeff[3] := -X1;
  coeff[4] := -Y1;
  coeff[5] := Sqr(X1) + Sqr(Y1) - Sqr(Radius);
  end;

procedure TGCircle.UpdateParams;
  var p1, p2 : TGPoint;
  begin
  DataValid := False;
  p1 := TGPoint(Parent[0]);
  If (p1 <> Nil) and p1.DataValid then begin
    X1 := p1.X;
    Y1 := p1.Y;
    p2 := TGPoint(Parent[1]);
    If (p2 <> Nil) and p2.DataValid then begin
      X2 := p2.X;
      Y2 := p2.Y;
      DataValid := True;
      end;
    end;
  If DataValid then
    Radius := Hypot(X2 - X1, Y2 - Y1);
  UpdateScreenCoords;
  end;

procedure TGCircle.UpdateScreenCoords;
  var dm: Double;
  begin
  If ObjList.LogWinContains(X1, Y1) then
    DataCanShow := Radius < 2.2 * ObjList.LogWinRadius
  else begin
    dm := Hypot(X1 - ObjList.xCenter, Y1 - ObjList.yCenter);
    DataCanShow := Abs(Radius - dm) <= 1.1 * ObjList.LogWinRadius;
    end;
  If DataCanShow then begin
    ObjList.GetWinCoords(X1, Y1, sx1, sy1);
    ObjList.GetWinCoords(X2, Y2, sx2, sy2);
    end;
  end;

procedure TGCircle.UpdateNameCoordsIn(TextObj: TGTextObj);
  var pixrad : Double;
  begin
  With TextObj do begin
    DataValid := Self.DataValid;
    If DataValid then begin
      pixrad := Radius + rConst;
      X := X1 + pixrad * cos(sConst);
      Y := Y1 + pixrad * sin(sConst);
      end;
    end;
  end;

procedure TGCircle.SetNewNameParamsIn(TextObj: TGTextObj);
  begin
  TextObj.rConst := Hypot(TextObj.X - X1, TextObj.Y - Y1) - Radius;
  TextObj.sConst := slope_angle(TextObj.X - X1, TextObj.Y - Y1);
  end;

procedure TGCircle.DrawIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    draw_circle_on(ObjList.TargetCanvas, act_pixelPerXcm, sx1, sy1,
                   Radius * ObjList.e1x, Radius * ObjList.e2y,
                   MyPenStyle);
    end;
  end;

procedure TGCircle.HideIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    draw_circle_on(ObjList.TargetCanvas, act_pixelPerXcm, sx1, sy1,
                   Radius * ObjList.e1x, Radius * ObjList.e2y,
                   MyPenStyle);
    end;
  end;

function TGCircle.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccCircle, ccBorderLine, ccCurveWithTans,
                              ccConicOrCircle, ccBorderOrArea, ccSimpleLine,
                              ccPointOrCircle, ccMakroDefObj]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGCircle.IsClosedLine: Boolean;
  begin
  Result := True;
  end;

function TGCircle.Includes(xp, yp: Double): Boolean;
  begin
  Result := Abs(Hypot(xp - X1, yp - Y1) - Radius) < DistEpsilon;
  end;

function TGCircle.IsPairedWith(pc: TGCircle): Boolean;
  { Liefert genau dann True, wenn entweder:
    -- der Mittelpunkt von Self definierender Peripherie-Punkt von pc und
       der Mittelpunkt von pc definierender Peripherie-Punkt von Self ist
       (Fall der "Zwei-Kreis-Figur")
    oder aber
    -- der Mittelpunkt von Self ein Schnittpunkt von pc mit einem anderen
       Kreis dc ist, und dann der Mittelpunkt von pc definierender Peri-
       pherie-Punkt von dc und der Mittelpunkt von dc definierender Peri-
       pherie-Punkt von pc ist (Fall der "Drei-Kreis-Figur")             }

  function PairedIntersection(DI: TGDoubleIntersection): Boolean;
    begin
    Result := TGCircle(DI.Parent[1]).IsPairedWith(DI.Parent[0]);
    end;

  begin { of IsPairedWith }
  If (ClassType = TGCircle) and (pc.ClassType = TGCircle) then
    Result := ((Parent[0] = pc.Parent[1]) and
               (Parent[1] = pc.Parent[0])) or
              ((TGeoObj(Parent[0]) is TGIntersectPt) and
               PairedIntersection(TGeoObj(Parent[0]).Parent[0]))
  else
    Result := False;
  end;  { of IsPairedWith }


function TGCircle.GetTangentIn(bx, by: Double; var tanCoeff: TVector3): Boolean;
  var dr : Double;
  begin
  Result := True;
  If Dist(bx, by) > DistEpsilon then begin
    dr := Hypot(bx - X1, by - Y1);
    If dr > epsilon then begin
      bx := X1 + (bx - X1) * Radius / dr;
      by := Y1 + (by - Y1) * Radius / dr;
      end
    else
      Result := False;
    end;
  If Result then begin
    tanCoeff.X := bx - X1;     // Normalenvektor zeigt nach außen !
    tanCoeff.Y := by - Y1;
    tanCoeff.Z := -tanCoeff.X * bx - tanCoeff.Y * by;
    end;
  end;


function TGCircle.GetPolOf(polare: TVector3; var px, py: Double): Boolean;
  var coeff: TCoeff6;
  begin
  GetConicCoeff(coeff);
  Result := GetPolFromPolareAndConic(polare, coeff, px, py);
  end;


function TGCircle.GetPolareOf(bx, by: Double; var polCoeff: TVector3): Boolean;
  var coeff: TCoeff6;
  begin
  GetConicCoeff(coeff);
  Result := GetPolareFromPolAndConic(bx, by, coeff, polCoeff);
  end;

function TGCircle.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If (ClassType = TGCircle) and (nr = 1) then
    Result := Parent[1]
  else
    Result := Nil;
  end;

function TGCircle.IsFilled(var FO: TGArea): Boolean;
  var i : Integer;
  begin
  Result := False;
  FO := Nil;
  For i := 0 to Pred(Children.Count) do
    If (TGeoObj(Children[i]) is TGArea) and
       (TGArea(Children[i]).Parent.Count = 1) then begin
      Result := True;
      FO := Children[i];
      end;
  end;

function TGCircle.GetFillHandle(Ori: Boolean): HRgn;
  var _sx1, _sy1, _sx2, _sy2 : Integer;
  begin
  ObjList.GetWinCoords(X1 - Radius, Y1 + Radius, _sx1, _sy1);
  ObjList.GetWinCoords(X1 + Radius, Y1 - Radius, _sx2, _sy2);
  Result := CreateEllipticRgn(_sx1 + 1, _sy1 + 1, _sx2, _sy2);
  end;

function TGCircle.Dist(xm, ym: Double): Double;
  begin
  LastDist := Abs(Hypot(X1 - xm, Y1 - ym) - Radius);
  Dist := LastDist;
  end;

function TGCircle.IsNearMouse: Boolean;
  var mr, k,
      qx, qy : Double;
      sqx, sqy : Integer;
  begin
  If Abs(ObjList.yAspect - 1) < epsilon then
    Result := Abs(Hypot(ObjList.LastMousePos.X - sx1,
                        ObjList.LastMousePos.Y - sy1) - Radius * ObjList.e1x) < CatchDist
  else begin
    Result := False;
    mr := Hypot(ObjList.LogLastMouse_X - X1, ObjList.LogLastMouse_Y - Y1);
    If mr > epsilon then begin
      k  := Radius / mr;
      qx := X1 + (ObjList.LogLastMouse_X - X1) * k;
      qy := Y1 + (ObjList.LogLastMouse_Y - Y1) * k;
      ObjList.GetWinCoords(qx, qy, sqx, sqy);
      Result := Hypot(ObjList.LastMousePos.X - sqx,
                      ObjList.LastMousePos.Y - sqy) < CatchDist;
      end
    end;
  end;

procedure TGCircle.ResetOLCPList(PointList : TVector3List);
  begin
  PointList.Reset2StandardList(ParamEpsilon, 1-ParamEpsilon, 40);
  end;

procedure TGCircle.RegisterAsMacroStartObject;
  begin
  With TMakro(ObjList.MakroList.Last) do begin
    AddCmd(TMakroCmd.Create(Parent[0], -1));   { nur Mittelpunkt }
    AddCmd(TMakroCmd.Create(Self, 0));
    end;
  end;

function TGCircle.GetDataStr: String;
  var sxm, sym : String;
  begin
  If X1 >= 0 then
    sxm := '- ' + Float2Str(X1, 2)
  else
    sxm := '+ ' + Float2Str(-X1, 2);
  If Y1 >= 0 then
    sym := '- ' + Float2Str(Y1, 2)
  else
    sym := '+ ' + Float2Str(-Y1, 2);
  Result := '{ (x ' + sxm + ')² + (y ' + sym + ')² = ' +
            Float2Str(Radius, 2) + '² }';
  end;

function TGCircle.GetInfo: String;
  begin
  Result := MyObjTxt[7];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;


{-------------------------------------------}
{ TGBaseCircle's Methods Implementation     }
{-------------------------------------------}

constructor TGBaseCircle.Create(iObjList: TGeoObjListe; ix1, iy1, ix2, iy2 : Integer; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, False);
  ObjList.GetLogCoords(ix1, iy1, X1, Y1);
  ObjList.GetLogCoords(ix2, iy2, X2, Y2);
  Radius := Hypot(X2 - X1, Y2 - Y1);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateScreenCoords;
  DrawIt;
  end;

constructor TGBaseCircle.CreateFromMat(iObjList: TGeoObjListe; iMat: Array of Double; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, False);
  If GetCircleDataFromMat(iMat, X1, Y1, Radius) then begin
    FStatus := FStatus and gs_DataValid;
    If iis_visible then
      FStatus := FStatus or gs_ShowsAlways;
    UpdateScreenCoords;
    DrawIt;
    end
  else
    FStatus := FStatus and Not gs_DataValid;
  end;

constructor TGBaseCircle.CreatePtRad(iObjList: TGeoObjListe; iPt: TVector3; iRad: Double; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, False);
  X1 := iPt.X;
  Y1 := iPt.Y;
  Radius := iRad;
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateScreenCoords;
  DrawIt;
  end;

function TGBaseCircle.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  { Parameter-Bereich 0..1 }
  var sinphi, cosphi : Extended;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  SinCos(2 * Pi * param, sinphi, cosphi);
  px := X1 + Radius * cosphi;
  py := Y1 + Radius * sinphi;
  Result := True;
  end;

function TGBaseCircle.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  { Parameter-Bereich 0..1 }
  begin
  param := Unsigned_Angle(1, 0, px - X1, py - Y1) / (2 * pi);
  Result := True;
  end;

function TGBaseCircle.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId = ccDragableObj) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGBaseCircle.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := False;
  end;

function TGBaseCircle.GetMatchingCursor(mpt: TPoint): TCursor;
  begin
  Result := Drag_Cursor;
  end;

procedure TGBaseCircle.VirtualizeCoords;
  var pixRadius : Double;
  begin
  pixRadius := Radius * ppcm_corrfactor;
  Inherited VirtualizeCoords;
  Radius := pixRadius / ObjList.e1x;
  end;

procedure TGBaseCircle.UpdateParams;
  begin
  If ObjList.DraggedObj = Self then begin
    X1 := X1 + ObjList.LastLogMouseDX;
    Y1 := Y1 + ObjList.LastLogMouseDY;
    X2 := X1 + Radius;
    Y2 := Y1;
    end;
  UpdateScreenCoords;
  end;

procedure TGBaseCircle.RegisterAsMacroStartObject;
  begin
  With TMakro(ObjList.MakroList.Last) do
    AddCmd(TMakroCmd.Create(Self, 0));
  end;

function TGBaseCircle.GetInfo: String;
  begin
  Result := MyObjTxt[8];
  InsertNameOf(Self, Result);
  end;


{-------------------------------------------}
{ TGOLCircle's Methods Implementation       }
{-------------------------------------------}

constructor TGOLCircle.Create(iObjList: TGeoObjListe; iOL : TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, iis_visible);
  BecomesChildOf (iOL);
  MyColour := TGeoObj(Parent[0]).MyColour;
  MyPenStyle := TGeoObj(Parent[0]).MyPenStyle;
  MyLineWidth := TGeoObj(Parent[0]).MyLineWidth;
  UpdateParams;
  DrawIt;
  end;

function TGOLCircle.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGOLCircle) and
            (GO.Parent[0] = Self.Parent[0]);
  end;

function TGOLCircle.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  { Parameter-Bereich 0..1 }
  var sinphi,
      cosphi : Extended;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  SinCos(2 * Pi * param, sinphi, cosphi);
  px := X1 + Radius * cosphi;
  py := Y1 + Radius * sinphi;
  Result := True;
  end;

function TGOLCircle.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  { Parameter-Bereich 0..1 }
  begin
  param := Unsigned_Angle(1, 0, px  - X1, py  - Y1) / (2 * pi);
  Result := True;
  end;

procedure TGOLCircle.Invalidate;
  var P: TGeoObj;
  begin
  P := Parent[0];
  Stops2BeChildOf(Parent[0]);
  Parent.Add(P);
  Inherited Invalidate;
  end;

procedure TGOLCircle.Revalidate;
  var p  : TGeoObj;
  begin
  p := TGeoObj(Parent[0]);
  Parent.Remove(p);    { Elter zunächst aus der Parent-Liste entfernen, }
  BecomesChildOf(p);
  Inherited Revalidate;
  end;

procedure TGOLCircle.UpdateParams;
  var MPt    : TVector3;
      OLrad,
      qual  : Double;
      PLL   : TGLocLine;
  begin
  DataValid := False;
  PLL := TGLocLine(Parent[0]);
  If PLL.DataValid then begin
    MPt  := TVector3.Create(0, 0, 0);
    try
      If BestCircleApprox(PLL.points, qual, MPt, OLrad) and
         (qual > LocSL_CircleLimit) then begin;
        X1 := MPt.X;
        Y1 := MPt.Y;
        Radius := OLrad;
        X2 := X1 + Radius;
        Y2 := Y1;
        DataValid := True;
        UpdateScreenCoords;
        end;
      PLL.ShowsAlways := Not DataValid;
    finally
      MPt.Free;
    end;
    end;
  end;

procedure TGOLCircle.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_locstnd, CME_PopupClick,
                     cmd_EditLocLineStnd, True);
  end;

procedure TGOLCircle.RegisterAsMacroStartObject;
  begin
  With TMakro(ObjList.MakroList.Last) do
    AddCmd(TMakroCmd.Create(Self, 0));
  end;

function TGOLCircle.GetInfo: String;
  begin
  If DataValid then
    Result := MyObjTxt[39]
  else
    Result := MyObjTxt[60];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  end;


{-------------------------------------------}
{ TGFixCircle's Methods Implementation      }
{   veralteter Typ; ersetzt durch TGXCircle }
{-------------------------------------------}

constructor TGFixCircle.Create(iObjList: TGeoObjListe; iP : TGeoObj; iRadius : Double; iis_visible : Boolean);
  begin
  Inherited Create (iObjList, Nil, Nil, False);
  BecomesChildOf(iP);
  Radius  := iRadius;
  X2 := 0.0;
  Y2 := 0.0;
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

constructor TGFixCircle.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  If GO = Nil then
    Radius := 1.0
  else
    Radius := TGFixCircle(GO).Radius;
  end;


function TGFixCircle.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  { Parameter-Bereich 0..1 }
  var sinphi, cosphi : Extended;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  SinCos(2 * Pi * param, sinphi, cosphi);
  px := X1 + Radius * cosphi;
  py := Y1 + Radius * sinphi;
  Result := True;
  end;

function TGFixCircle.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  { Parameter-Bereich 0..1 }
  begin
  param := Unsigned_Angle(1, 0, px - X1, py - Y1) / (2 * pi);
  Result := True;
  end;

function TGFixCircle.HasSameDataAs(GO: TGeoObj): Boolean;
  var L : Double;
  begin
  L := Radius;
  Result := (GO.ClassType = TGFixCircle) and
            (GO.Parent[0] = Self.Parent[0]) and
            (DataEquivalent(L));
  end;

procedure TGFixCircle.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  Radius := (BluePrint as TGFixCircle).Radius;
  end;

procedure TGFixCircle.UpdateParams;
  var p  : TGPoint;
  begin
  p := TGPoint(Parent[0]);
  If (p <> Nil) and (p.DataValid) then begin
    X1 := p.X;
    Y1 := p.Y;
    X2 := X1 + Radius;
    Y2 := Y1;
    DataValid := True;
    UpdateScreenCoords;
    end
  else
    DataValid := False;
  end;

function TGFixCircle.DataEquivalent(var data): Boolean;
  begin
  DataEquivalent := Abs(Double(data) - Radius) < DistEpsilon;
  end;

function TGFixCircle.GetInfo: String;
  var arg : String;
  begin
  arg := Float2Str(Radius, 3);
  Result := Format(MyObjTxt[9], [arg]);
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  end;


{-------------------------------------------}
{ TGMirrorCircle's Methods Implementation   }
{-------------------------------------------}

constructor TGMirrorCircle.Create(iObjList: TGeoObjListe; iC, iSymZ: TGeoObj; iis_Visible: Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, iis_visible);
  BecomesChildOf(iC);
  BecomesChildOf(iSymZ);
  UpdateParams;
  DrawIt;
  end;

function TGMirrorCircle.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGMirrorCircle) and
            (GO.Parent[0] = Parent[0]) and
            (GO.Parent[1] = Parent[1]);
  end;

procedure TGMirrorCircle.UpdateParams;
  var PC         : TGCircle;     { ParentCircle }
      CoSx, CoSy : Double;       { Center Of Symmetry }
  begin
  DataValid := TGeoObj(Parent[0]).DataValid and
               TGeoObj(Parent[1]).DataValid;
  If DataValid then begin
    PC := TGCircle(Parent[0]);
    If TGeoObj(Parent[1]) is TGStraightLine then
      GetPedalPoint(TGStraightLine(Parent[1]).X1, TGStraightLine(Parent[1]).Y1,
                    TGStraightLine(Parent[1]).X2, TGStraightLine(Parent[1]).Y2,
                    PC.X1, PC.Y1, CoSx, CoSy)
    else begin
      CoSx := TGPoint(Parent[1]).X;
      CoSy := TGPoint(Parent[1]).Y;
      end;
    X1 := 2 * CoSx - PC.X1;
    Y1 := 2 * CoSy - PC.Y1;
    Radius := PC.Radius;
    UpdateScreenCoords;
    end;
  end;

function TGMirrorCircle.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;


{-------------------------------------------}
{ TGMovedCircle's Methods Implementation    }
{-------------------------------------------}

constructor TGMovedCircle.Create(iObjList: TGeoObjListe; iC, iv: TGeoObj; iis_Visible: Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, iis_visible);
  BecomesChildOf(iC);        { circle to move }
  BecomesChildOf(iv);        { vector of movement }
  UpdateParams;
  DrawIt;
  end;

function TGMovedCircle.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGMovedCircle) and
            (GO.Parent[0] = Parent[0]) and
            (GO.Parent[1] = Parent[1]);
  end;

procedure TGMovedCircle.UpdateParams;
  var PC : TGCircle;     { ParentCircle }
      PV : TGVector;     { ParentVector }
  begin
  DataValid := TGeoObj(Parent[0]).DataValid and
               TGeoObj(Parent[1]).DataValid;
  If DataValid then begin
    PC := TGCircle(Parent[0]);
    PV := TGVector(Parent[1]);
    X1 := PC.X1 + PV.dx;
    Y1 := PC.Y1 + PV.dy;
    Radius := PC.Radius;
    UpdateScreenCoords;
    end;
  end;

function TGMovedCircle.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;


{-------------------------------------------}
{ TGRotatedCircle's Methods Implementation  }
{-------------------------------------------}

constructor TGRotatedCircle.Create(iObjList: TGeoObjListe; iC, iMP, iAO: TGeoObj; iis_Visible: Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, iis_visible);
  BecomesChildOf(iC);        { Abzubildender Kreis }
  BecomesChildOf(iMP);       { Dreh-Mittelpunkt }
  BecomesChildOf(iAO);       { Argument-Objekt }
  UpdateParams;
  DrawIt;
  end;

function TGRotatedCircle.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGRotatedCircle) and
            (GO.Parent[0] = Parent[0]) and
            (GO.Parent[1] = Parent[1]) and
            (GO.Parent[2] = Parent[2]);
  end;

procedure TGRotatedCircle.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@RotAngle, SizeOf(RotAngle));
  end;

procedure TGRotatedCircle.RestoreState;
  begin
  Old_Data.pop(@RotAngle);
  Inherited RestoreState;
  end;

procedure TGRotatedCircle.UpdateParams;
  var UK : TGCircle;     { Urbild-Kreis }
      DP : TGPoint;      { Drehpunkt    }
      dx, dy : Double;
  begin
  DataValid := TGeoObj(Parent[0]).DataValid and
               TGeoObj(Parent[1]).DataValid;
  If DataValid then begin
    UK := TGCircle(Parent[0]);
    DP := TGPoint(Parent[1]);
    RotAngle := TGeoObj(Parent[2]).GetValue(gv_val);
    dx := UK.X1 - DP.X;
    dy := UK.Y1 - DP.Y;
    RotateVector2ByAngle(dx, dy, RotAngle, dx, dy);
    X1 := DP.X + dx;
    Y1 := DP.Y + dy;
    Radius := UK.Radius;
    UpdateScreenCoords;
    end;
  end;

function TGRotatedCircle.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;


{------------------------------------------------}
{ TGStretchedCircle's Methods Implementation     }
{------------------------------------------------}

constructor TGStretchedCircle.Create(iObjList: TGeoObjListe; iC, iZP,
  iSF: TGeoObj; iis_Visible: Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, iis_Visible);
  BecomesChildOf(iC);      { Abzubildender Kreis }
  BecomesChildOf(iZP);     { Zentrumspunkt der Streckung }
  BecomesChildOf(iSF);     { Streckfaktor }
  UpdateParams;
  DrawIt;
  end;

function TGStretchedCircle.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGStretchedCircle) and
            (GO.Parent[0] = Parent[0]) and
            (GO.Parent[1] = Parent[1]) and
            (GO.Parent[2] = Parent[2]);
  end;

function TGStretchedCircle.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;

procedure TGStretchedCircle.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@sFactor, SizeOf(sFactor));
  end;

procedure TGStretchedCircle.RestoreState;
  begin
  Old_Data.pop(@sFactor);
  Inherited RestoreState;
  end;

procedure TGStretchedCircle.UpdateParams;
  var UK : TGCircle;     { Urbild-Kreis }
      ZP : TGPoint;      { Zentrum      }
      dx, dy : Double;
  begin
  DataValid := TGeoObj(Parent[0]).DataValid and
               TGeoObj(Parent[1]).DataValid;
  If DataValid then begin
    UK := TGCircle(Parent[0]);
    ZP := TGPoint(Parent[1]);
    sFactor := TGeoObj(Parent[2]).GetValue(gv_val);
    dx := UK.X1 - ZP.X;
    dy := UK.Y1 - ZP.Y;
    X1 := ZP.X + sFactor * dx;
    Y1 := ZP.Y + sFactor * dy;
    Radius := sFactor * UK.Radius;
    UpdateScreenCoords;
    end;
  end;


{-------------------------------------------}
{ TGMappedCircle's Methods Implementation   }
{-------------------------------------------}

constructor TGMappedCircle.Create(iObjList: TGeoObjListe; iOriCirc, iMapObj: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, False);
  dv := TVector3.Create(0, 0, 0, 1);
  If iOriCirc <> Nil then begin
    BecomesChildOf(iOriCirc);
    BecomesChildOf(iMapObj);
    SetIsArc;
    IsReversed := iOriCirc.IsReversed xor (iMapObj as TGTransformation).IsReversing;
    If iis_visible then
      FStatus := FStatus or gs_ShowsAlways;
    UpdateParams;
    DrawIt;
    end;
  end;

destructor TGMappedCircle.Destroy;
  begin
  dv.Free;
  Inherited Destroy;
  end;

procedure TGMappedCircle.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  dv := TVector3.Create(0, 0, 0);
  If Parent.Count = 2 then begin
    SetIsArc;
    IsReversed := TGCircle(Parent[0]).IsReversed xor (TGTransformation(Parent[1])).IsReversing;
    end;
  end;

procedure TGMappedCircle.GetDataFromOldMappedObj(OMO: TGeoObj);
  begin
  Inherited GetDataFromOldMappedObj(OMO);
  With OMO as TGCircle do begin
    Self.X1 := X1;
    Self.Y1 := Y1;
    Self.X2 := X2;
    Self.Y2 := Y2;
    Self.Radius := Radius;
    end;
  end;

procedure TGMappedCircle.SetIsArc;
  var P1 : TGeoObj;
  begin
  P1 := TGeoObj(Parent[0]);
  FIsArc := (P1 is TGShortLine) or
            (P1 is TGHalfLine) or
            (P1 is TGArc) or
            ((P1 is TGMappedCircle) and (P1 as TGMappedCircle).IsArc);
  end;

procedure TGMappedCircle.AfterLoading(FromXML : Boolean = True);
  begin
  Inherited AfterLoading(FromXML);
  dv := TVector3.Create(0, 0, 0);
  SetIsArc;
  IsReversed := TGeoObj(Parent[0]).IsReversed xor
                TGTransformation(Parent[1]).IsReversing;
  end;

function TGMappedCircle.GetImplicitMakStartObj(n: Integer): TGeoObj;
  { 05.01.2007 : neu eingeführt, um das Problem der "impliziten Start-
                 objekte" in Makros zu lösen. Sollte nur mit n=0 auf-
                 gerufen werden.
    1. Fall: TGTransformation(Parent[1]) is TGMatrixMap:
       Es wird beim Urbildkreis nachgefragt, welchen Mittelpunkt er hat.
       Das zurückgegebene Punkt-Objekt wird mit derselben Abbildung ab-
       gebildet, die Self erzeugt (hat). Das Bild des Eltern-Mittelpunkts
       ist der Mittelpunkt von Self, und der wird als Ergebnis zurück-
       gegeben.
    2. Fall: TGTransformation(Parent[1]) is TGInversion:
       Hier wird der Mittelpunkt des Bildkreises extra errechnet, weil
       er *nicht* das Bild des Urbildkreis-Mittelpunkts ist.
    Die Fallunterscheidung mit n ist nötig, damit nicht bei einem Makro-
    Run zusätzliche Punkte erzeugt werden, die eigentlich schon da sind! }

  var piso : TGPoint;  // "P"arent's "I"mplicit "S"tart "O"bject
      err  : Integer;
  begin
  If n = 0 then
    If TGeoObj(Parent[1]) is TGMatrixMap then begin
      piso := TGeoObj(Parent[0]).GetImplicitMakStartObj(n) as TGPoint;
      Result := ObjList.InsertObject(TGMappedPoint.Create(ObjList, piso, Parent[1], False),
                                     err);
      end
    else
      Result := ObjList.InsertObject(TGMiddlePt.Create(ObjList, Self, Nil, False),
                                     err)
  else
    Result := Nil;
  end;

function TGMappedCircle.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGMappedCircle) and
            (Parent[0] = GO.Parent[0]) and
            (Parent[1] = GO.Parent[1]);
  end;

function TGMappedCircle.degenerated: Boolean;
  begin
  Result := dv.tag = 0;
  end;

function TGMappedCircle.Dist(xm, ym: Double): Double;
  var v : TVector3;
  { Derzeit nur für den Fall "IsArc = False" eingerichtet !!! }
  begin
  If degenerated then begin
    v := TVector3.Create(0, 0, 0);
    try
      GetHesseEqFromPtAndDir(X1, Y1, X2 - X1, Y2 - Y1, v);
      LastDist := Abs(v.X * xm + v.Y * ym + v.Z);
    finally
      v.Free;
    end;
    end
  else
    LastDist := Abs(Hypot(X1 - xm, Y1 - ym) - Radius);
  Dist := LastDist;
  end;

function TGMappedCircle.IsNearMouse: Boolean;
  begin
  If degenerated then
    Result := DistPt2Line(sx1, sy1, sx2, sy2,
                          ObjList.LastMousePos.X,
                          ObjList.LastMousePos.Y) < CatchDist
  else
    IsNearMouse := Inherited IsNearMouse;
  end;

function TGMappedCircle.Includes(xp, yp: Double): Boolean;
  begin
  If IsDegenerated then
    Result := Abs(dv.X * xp + dv.Y * yp + dv.Z) < DistEpsilon
  else
    Result := Inherited Includes(xp, yp);
  end;

function TGMappedCircle.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var pt, mpt : TFloatPoint;
  begin
  If TGCircle(Parent[0]).GetCoordsFromParam(param, pt.x, pt.y) and
     TGTransformation(Parent[1]).GetMappedPoint(pt, mpt) then begin
    px := mpt.x;
    py := mpt.y;
    Result := True;
    end
  else
    Result := False;
  end;

function TGMappedCircle.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var pt, impt : TFloatPoint;
  begin
  pt.x := px;
  pt.y := py;
  Result := TGTransformation(Parent[1]).GetInvMapPoint(pt, impt) and
            TGCircle(Parent[0]).GetParamFromCoords(impt.x, impt.y, param);
  end;

procedure TGMappedCircle.GetDataVector(var v: TVector3);
  begin
  v.Assign(dv);
  end;

procedure TGMappedCircle.UpdateParams;
  var OL_v : TVector3;     // enthält die Gleichung des Urbildes
      fp,                  // ein Punkt auf der Urbild-Linie
      fpp,                 // der Bildpunkt dieses Punktes
      dir  : TFloatPoint;  // die Richtung der Bildgeraden
  begin
  DataValid := False;
  If TGeoObj(Parent[0]).DataValid and
     TGeoObj(Parent[1]).DataValid then begin
    OL_v := TVector3.Create(0, 0, 0);
    try
      If (TGeoObj(Parent[0]) is TGCircle) then begin
        TGCircle(Parent[0]).GetDataVector(OL_v);
        If (TGCircle(Parent[0]).Parent.Count >= 2) and
           (TGeoObj(TGCircle(Parent[0]).Parent[1]) is TGPoint) then begin
          fp.x := TGPoint(TGCircle(Parent[0]).Parent[1]).X;
          fp.y := TGPoint(TGCircle(Parent[0]).Parent[1]).Y;
          end
        else begin
          fp.x := TGCircle(Parent[0]).X1 + TGCircle(Parent[0]).Radius;
          fp.y := TGCircle(Parent[0]).Y1;
          end;
        end
      else   // Urbild ist eine gerade Linie
        with TGLine(Parent[0]) do begin
          GetHesseEqFromPtAndDir(X1, Y1, X2 - X1, Y2 - Y1, OL_v);
          fp.x := X1;
          fp.y := Y1;
          end;
      If TGTransformation(Parent[1]).GetMappedCircle(OL_v, dv) then begin
        If dv.tag = 1 then begin  // Echter Kreis
          X1 := dv.X;
          Y1 := dv.Y;
          Radius := dv.Z;
          If TGTransformation(Parent[1]).GetMappedPoint(fp, fpp) then begin
            X2 := fpp.x;
            Y2 := fpp.y;
            end
          else begin
            X2 := X1 + Radius;
            Y2 := Y1;
            end;
          end
        else begin                  // Gerade
          GetPedalPoint(dv, 0, 0, X1, Y1);
          GetNormalizedDirFromHesseEq(dv, dir);
          X2 := X1 + dir.x;
          Y2 := Y1 + dir.y;
          end;
        DataValid := True;
        UpdateScreenCoords;
        end;
    finally
      OL_v.Free;
    end;
    end;
  end;

procedure TGMappedCircle.UpdateScreenCoords;
  var rP1, rP2 : TFloatPoint;
  begin
  If degenerated then
    If DataValid then begin
      MovePointsOff(rP1, rP2);
      DataCanShow := DataValid and (ObjList.LogWinKnows(X, Y) = 1);
      If DataCanShow then begin
        ObjList.GetWinCoords(rP1.X, rP1.Y, sx1, sy1);
        ObjList.GetWinCoords(rP2.X, rP2.Y, sx2, sy2);
        end;
      end
    else
  else      // nicht degeneriert, also echter Kreis !
    Inherited UpdateScreenCoords;
  end;

procedure TGMappedCircle.DrawIt;
  var PL : TFloatPointList;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    If degenerated then
      draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                   sx1, sy1, sx2, sy2, MyPenStyle)
    else begin
      SetLength(PL, 1);
      PL[0].x := sx2;
      PL[0].y := sy2;
      draw_circle_on(ObjList.TargetCanvas, act_pixelPerXcm, sx1, sy1,
                     Radius * ObjList.e1x, Radius * ObjList.e2y,
                     MyPenStyle, PL);
      PL := Nil;
      end;
    end;
  end;

procedure TGMappedCircle.HideIt;
  var PL : TFloatPointList;
  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    If degenerated then
      draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                   sx1, sy1, sx2, sy2, MyPenStyle)
    else begin
      SetLEngth(PL, 1);
      PL[0].x := sx2;
      PL[0].y := sy2;
      draw_circle_on(ObjList.TargetCanvas, act_pixelPerXcm, sx1, sy1,
                     Radius * ObjList.e1x, Radius * ObjList.e2y,
                     MyPenStyle);
      PL := Nil;
      end;
    end;
  end;

function  TGMappedCircle.GetInfo: String;
  var s1, s2 : String;
  begin
  s1 := MyObjTxt[43];
  InsertNameOf(Self, s1);
  InsertNameOf(TGeoObj(Parent[0]), s1);
  s2 := TGTransformation(Parent[1]).GetLinkableInfo;
  Result := s1 + s2;
  end;


{-------------------------------------------}
{ TGCircle3P's Methods Implementation       }
{-------------------------------------------}

constructor TGCircle3P.Create(iObjList: TGeoObjListe; iP1, iP2, iP3: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, False);
  BecomesChildOf(iP1);
  BecomesChildOf(iP2);
  BecomesChildOf(iP3);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

procedure TGCircle3P.AfterLoading(FromXML: Boolean);
  begin
  Inherited AfterLoading(FromXML);
  dv := TVector3.Create(0, 0, 0);
  end;

function TGCircle3P.GetInfo: String;
  begin
  Result := MyObjTxt[106];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  InsertNameOf(TGeoObj(Parent[2]), Result);
  end;

function TGCircle3P.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = ClassType) and
            (GO.Parent.IndexOf(Parent[0]) >= 0) and
            (GO.Parent.IndexOf(Parent[1]) >= 0) and
            (GO.Parent.IndexOf(Parent[2]) >= 0);
  end;

function TGCircle3P.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  { Parameter-Bereich 0..1 }
  var sinphi, cosphi : Extended;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  SinCos(2 * Pi * param, sinphi, cosphi);
  px := X1 + Radius * cosphi;
  py := Y1 + Radius * sinphi;
  Result := True;
  end;

function TGCircle3P.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  { Parameter-Bereich 0..1 }
  begin
  param := Unsigned_Angle(1, 0, px - X1, py - Y1) / (2 * pi);
  Result := True;
  end;

function TGCircle3P.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr in [1, 2, 3] then
    Result := Parent[Pred(nr)]
  else
    Result := Nil;
  end;

procedure TGCircle3P.UpdateParams;
  var dir: TFloatPoint;
  begin
  DataValid := TGeoObj(Parent[0]).DataValid and
               TGeoObj(Parent[1]).DataValid and
               TGeoObj(Parent[2]).DataValid;
  If DataValid then begin
    If GetCircumMidPt(TGeoObj(Parent[0]).X, TGeoObj(Parent[0]).Y,
                      TGeoObj(Parent[1]).X, TGeoObj(Parent[1]).Y,
                      TGeoObj(Parent[2]).X, TGeoObj(Parent[2]).Y,
                      dv.X, dv.Y) then begin
      dv.Z := Hypot(dv.X - TGeoObj(Parent[0]).X,
                    dv.Y - TGeoObj(Parent[0]).Y);
      dv.tag := 1;  // Kreis !!
      X1 := dv.X;
      Y1 := dv.Y;
      Radius := dv.Z;
      X2 := X1 + Radius;
      Y2 := Y1;
      end
    else
      If GetBestDirVector(TGeoObj(Parent[0]).X, TGeoObj(Parent[0]).Y,
                          TGeoObj(Parent[1]).X, TGeoObj(Parent[1]).Y,
                          TGeoObj(Parent[2]).X, TGeoObj(Parent[2]).Y,
                          dir.X, dir.Y) and
         GetHesseEqFromPtAndDir(TGeoObj(Parent[1]).X, TGeoObj(Parent[1]).Y,
                                dir.x, dir.y, dv) then begin
        X1 := TGeoObj(Parent[1]).X;
        Y1 := TGeoObj(Parent[1]).Y;
        X2 := X1 + dir.x;
        Y2 := Y1 + dir.y;
        end
      else
        DataValid := False;
    If DataValid then
      UpdateScreenCoords;
    end;
  end;

{-------------------------------------------}
{ TGArc's Methods Implementation            }
{-------------------------------------------}

constructor TGArc.Create(iObjList: TGeoObjListe; iP1, iP2, iP3 : TGeoObj; iis_reversed, iis_visible : Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, False);
  BecomesChildOf(iP2);   { Mittelpunkt }
  BecomesChildOf(iP1);   { StartPunkt  }
  BecomesChildOf(iP3);   { Richtung zum Endpunkt }
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  If iis_reversed then
    FStatus := FStatus or gs_IsReversed;
  UpdateParams;
  DrawIt;
  end;

constructor TGArc.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  X3 := R.ReadFloat;
  Y3 := R.ReadFloat;
  StartAngle := R.ReadFloat;
  EndAngle   := R.ReadFloat;
  end;

constructor TGArc.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  With DE.childNodes.findNode('direction', '') do begin
    X3 := StrToFloat(getAttribute('x3'));
    Y3 := StrToFloat(getAttribute('y3'));
    If HasAttribute('inverted') and
       (LowerCase(getAttribute('inverted')) = 'true') then
      FStatus := FStatus or gs_IsReversed
    else
      FStatus := FStatus and Not gs_IsReversed;
    end;
  end;

procedure TGArc.AfterLoading(FromXML: Boolean);
  begin
  Inherited AfterLoading(FromXML);
  UpdateBorderAngles;
  end;

function  TGArc.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var arc_pos : IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  arc_pos := DOMDoc.createNode('direction');
  arc_pos.setAttribute('x3', FloatToStr(X3));
  arc_pos.setAttribute('y3', FloatToStr(Y3));
  If IsReversed then
    arc_pos.setAttribute('inverted', 'true');
  Result.childNodes.add(arc_pos);
  end;

function  TGArc.Dist(xm, ym: Double): Double;
  begin
  Result := Inherited Dist(xm, ym);
  If Not Includes(xm, ym) then
    Result := 1.0e300;
  end;

function  TGArc.IsNearMouse: Boolean;
  var mr, k,
      qx, qy : Double; // Logische Koordinaten des Punktes, den man erhält,
                       // wenn man die Mausposition vom Zentrum des Bogens aus
                       // auf den Kreis projiziert, auf dem der Bogen liegt.

  function MouseIsNearCircle: Boolean;
    var sqx, sqy : Integer;
    begin
    ObjList.GetWinCoords(qx, qy, sqx, sqy);
    Result := Hypot(ObjList.LastMousePos.X - sqx,
                    ObjList.LastMousePos.Y - sqy) < CatchDist;
    end;

  function MouseIsInsideArcField: Boolean;
    var par : Double;
    begin
    GetParamFromCoords(qx, qy, par);
    Result := (par > 1e-6) and (par < 1 - 1e-6);
    end;

  begin
  Result := False;
  mr := Hypot(ObjList.LogLastMouse_X - X1, ObjList.LogLastMouse_Y - Y1);
  If mr > epsilon then begin
    k  := Radius / mr;
    qx := X1 + (ObjList.LogLastMouse_X - X1) * k;
    qy := Y1 + (ObjList.LogLastMouse_Y - Y1) * k;
    Result := MouseIsNearCircle and MouseIsInsideArcField;
    end;
  end;

function TGArc.HasSameDataAs(GO: TGeoObj): Boolean;
  { 18.02.2007 : Vorsichtige Variante implementiert, die eine durch
                 Inzidenzen verkürzte Parent-Liste berücksichtigt !  }
  function ParentListsAreEqual: Boolean;
    var i : Integer;
    begin
    Result := Parent.Count = GO.Parent.Count;
    i := 0;
    While Result and (i < Parent.Count) do
      If GO.Parent[i] <> Self.Parent[i] then
        Result := False
      else
        i := i + 1;
    end;
  begin
  Result := (GO.ClassType = TGArc) and ParentListsAreEqual;
  end;

function TGArc.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('b');
  end;

function TGArc.Includes(xp, yp: Double): Boolean;
  { Modifikation mit AngleEpsilon eingebaut am 20.05.01
    wegen Problem des Schnittes eines Bogens mit einer Geraden,
    die das Bogenende streift ! }
  var mAngle : Double;
  begin
  If Inherited Includes(xp, yp) then begin
    mAngle := slope_angle(xp - X1, yp - Y1);
    If StartAngle < EndAngle then
      Result := (mAngle >= StartAngle - AngleEpsilon) and
                (mAngle <= EndAngle + AngleEpsilon)
    else
      Result := (mAngle >= StartAngle - AngleEpsilon) or
                (mAngle <= EndAngle + AngleEpsilon);
    end
  else
    Result := False;
  end;

function TGArc.GetFillHandle(Ori: Boolean): HRgn;
  var cHnd : HDC;
      ax, ay, mx, my, bx, by, r : Integer;
      dv, pt : TPoint;
  begin
  cHnd := ObjList.TargetCanvas.Handle;
  ObjList.GetWinCoords(X1, Y1, mx, my);
  If Ori then begin
    ObjList.GetWinCoords(X2, Y2, ax, ay);
    ObjList.GetWinCoords(X3, Y3, bx, by);
    end
  else begin
    ObjList.GetWinCoords(X2, Y2, bx, by);
    ObjList.GetWinCoords(X3, Y3, ax, ay);
    end;
  r := Round(ObjList.e1x * Radius);
  dv := Point(0, 0);
  Case ObjList.OutputStatus of
    outScreen    : If Not ObjList.IsDoubleBuffered then
                     GetViewportOrgEx(cHnd, dv);
    outPreview,
    outPrinter   : GetViewportOrgEx(cHnd, dv);
    outClipboard,
    outFile      : begin
                   pt := ObjList.TargetCanvas.ClipRect.TopLeft;
                   dv := Point(-pt.X, -pt.Y);
                   end;
  end;
  BeginPath(cHnd);
  ObjList.TargetCanvas.Pie(mx - r - dv.X, my - r - dv.Y,
                           mx + r - dv.X, my + r - dv.Y,
                           ax - dv.X, ay - dv.Y, bx - dv.X, by - dv.Y);
  EndPath(cHnd);
  Result := PathToRegion(cHnd);
  end;

function TGArc.GetRotationAngle: Double;
  var diff : Double;
  begin
  diff := EndAngle - StartAngle;
  If diff < 0 then
    Result := diff + 2*pi
  else
    Result := diff;
  end;

function TGArc.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId = ccPointOrArc) or
            (ClassGroupId = ccAnyAngleObj) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGArc.IsClosedLine: Boolean;
  begin
  Result := False;
  end;

function TGArc.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  { Parameter-Bereich [0, 1] }
  var BoundParam, sinphi, cosphi : Extended;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  BoundParam := StartAngle + param*(RotationAngle);
  SinCos(BoundParam, sinphi, cosphi);
  px := X1 + Radius * cosphi;
  py := Y1 + Radius * sinphi;
  Result := True;
  end;

function TGArc.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  { Parameter-Bereich [0, 1] }
  var PointAngle, p_diff, c_diff : Double;
  begin
  Result := True;
  PointAngle := slope_angle(px - X1, py - Y1);
  p_diff := PointAngle - StartAngle;
  If p_diff < 0 then
    p_diff := p_diff + 2*pi;
  If Abs(RotationAngle) > AngleEpsilon then
    param := p_diff / RotationAngle;
  If (param > 1.0) or (param < 0) then begin
    c_diff := PointAngle - EndAngle;
    If c_diff < 0 then
      c_diff := c_diff + 2*pi;
    If c_diff / (2*pi - RotationAngle) > 0.5 then
      param := 0
    else
      param := 1.0;
    end;
  end;

function TGArc.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr = 1 then
    Result := Parent[1]
  else
    Result := Nil;
  end;

function TGArc.GetValue(selector: Integer): Double;
  begin
  If DataValid then
    Case selector of
      gv_val   : Result := RotationAngle;   { Mittelpunktswinkel }
      gv_x     : Result := X1;              { Mittelpunkts-      }
      gv_y     : Result := Y1;              {      Koordinaten   }
      gv_len   : Result := RotationAngle * Radius;      { Bogenlänge         }
      gv_area  : If SignedAreas and IsReversed then     { Sektor-Fläche...   }
                   Result := - Sqr(Radius) * RotationAngle/2  {... mit VZ    }
                 else
                   Result := Sqr(Radius) * RotationAngle/2;   {... ohne VZ   }
    else
      Result := Inherited GetValue(selector);
    end  { of case }
  else { of if }
    Result := 0;
  end;

function TGArc.GetLinePtWithMinMouseDist(xm, ym, quant: Double;
                  var px, py: Double): Boolean;
  var p : Double;
  begin
  Result := GetParamFromCoords(xm, ym, p) and
            GetCoordsFromParam(p, px, py);
  end;

function TGArc.GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean;
  var T1x, T1y, T2x, T2y : Double;
      v1, v2 : Boolean;
  begin
  IntersectCircles(EP.X, EP.Y, r, X1, Y1, Radius, T1x, T1y, T2x, T2y, v1, v2);
  If v1 then v1 := Includes(T1x, T1y);
  If v2 then v2 := Includes(T2x, T2y);
  If v2 and
     ( (Not v1) or
       (Hypot(T1x - px, T1y - py) > Hypot(T2x - px, T2y - py)) ) then begin
    px := T2x;
    py := T2y;
    end
  else begin
    px := T1x;
    py := T1y;
    end;
  Result := v1 or v2;
  end;

procedure TGArc.SaveState;
  begin
  Inherited SaveState;
  With Old_Data do begin
    push(@X3, SizeOf(X3));
    push(@Y3, SizeOf(Y3));
    push(@StartAngle, SizeOf(StartAngle));
    push(@EndAngle, SizeOf(EndAngle));
    end;
  end;

procedure TGArc.RestoreState;
  begin
  With Old_Data do begin
    pop(@EndAngle);
    pop(@StartAngle);
    pop(@Y3);
    pop(@X3);
    end;
  Inherited RestoreState;
  end;

procedure TGArc.UpdateBorderAngles;
  begin
  If (Parent.Count > 2) and TGPoint(Parent[2]).DataValid then begin
    X3 := TGPoint(Parent[2]).X;
    Y3 := TGPoint(Parent[2]).Y;
    If IsReversed then begin
      StartAngle := slope_angle(X3 - X1, Y3 - Y1);
      EndAngle   := slope_angle(X2 - X1, Y2 - Y1);
      end
    else begin
      StartAngle := slope_angle(X2 - X1, Y2 - Y1);
      EndAngle   := slope_angle(X3 - X1, Y3 - Y1);
      end;
    end
  else
    DataValid := False;
  end;

procedure TGArc.UpdateParams;
  begin
  Inherited UpdateParams;
  If DataValid then
    UpdateBorderAngles;
  { UpdateScreenCoords zum Aktualisieren von (sx1, sy1) wird
    schon von der geerbten UpdateParams-Methode aufgerufen ! }
  end;

procedure TGArc.UpdateNameCoordsIn(TextObj: TGTextObj);
  var px, py, len,
      nx, ny : Double;
  begin
  TextObj.DataValid := Self.DataValid;
  If TextObj.DataValid then begin
    GetCoordsFromParam(TextObj.sConst, px, py);
    nx := px - X1;
    ny := py - Y1;
    len := Hypot(nx, ny);
    If len > DistEpsilon then with TextObj do begin
      X := px + nx / len * rConst;
      Y := py + ny / len * rConst;
      end
    else
      TextObj.DataValid := False;
    end;
  end;

procedure TGArc.SetNewNameParamsIn(TextObj: TGTextObj);
  begin
  with TextObj do begin
    rConst := Hypot(X - X1, Y - Y1) - Radius;
    GetParamFromCoords(X, Y, sConst);
    end;
  end;

procedure TGArc.DrawIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    draw_arc_on(ObjList.TargetCanvas,
                act_pixelPerXcm, act_pixelPerYcm, sx1, sy1,
                Radius * ObjList.e1x, Radius * ObjList.e2y,
                StartAngle, EndAngle, MyPenStyle);
    end;
  end;

procedure TGArc.HideIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    draw_arc_on(ObjList.TargetCanvas,
                act_pixelPerXcm, act_pixelPerYcm, sx1, sy1,
                Radius * ObjList.e1x, Radius * ObjList.e2y,
                StartAngle, EndAngle, MyPenStyle);
    end;
  end;

function TGArc.GetInfo: String;
  { 18.02.2007 : Vorsichtige Version implementiert, die eine aufgrund von
                 Koinzidenzen verkürzte Parent-Liste berücksichtigt.      }
  begin
  Result := MyObjTxt[38];
  InsertNameOf(Self, Result);
  If Parent.Count > 1 then
    InsertNameOf(TGeoObj(Parent[1]), Result)
  else
    InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  If Parent.Count > 2 then
    InsertNameOf(TGeoObj(Parent[2]), Result)
  else
    InsertNameOf(TGeoObj(Parent.Last), Result);
  end;


{-------------------------------------------}
{ TGAngle's Methods Implementation          }
{-------------------------------------------}

constructor TGAngle.Create(iObjList: TGeoObjListe; iP1, iP2, iP3 : TGeoObj; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, iis_visible);
  BecomesChildOf(iP1);    { Punkt auf dem 2. Schenkel }
  BecomesChildOf(iP2);    { Scheitelpunkt             }
  BecomesChildOf(iP3);    { Punkt auf dem 1. Schenkel }
  Radius    := InitAngleRadius; { Ab v2.7 : in cm !!! }
  reversed  := False;
  UpdateParams;
  DrawIt;
  end;

constructor TGAngle.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  If GO = Nil then begin
    Radius   := InitAngleRadius;
    reversed := False;
    end
  else begin
    Radius   := TGAngle(GO).Radius;
    reversed := TGAngle(GO).reversed;
    end;
  end;

constructor TGAngle.Load(S: TFileStream; iObjList: TGeoObjListe);
  var i: Integer;
  begin
  Inherited Load(S, iObjList);
  For i := 1 to 3 do begin
    S.Read(dpX[i], SizeOf(dpX[i]));
    S.Read(dpY[i], SizeOf(dpY[i]));
    end;
  S.Read(Angle1, SizeOf(Angle1));
  S.Read(Angle2, SizeOf(Angle2));
  S.Read(Radius, SizeOf(Radius));
  S.Read(reversed, SizeOf(reversed));
  end;

constructor TGAngle.Load32(R: TReader; iObjList: TGeoObjListe);
  var i : Integer;
  begin
  Inherited Load32(R, iObjList);
  For i := 1 to 3 do begin
    dpX[i] := R.ReadFloat;
    dpY[i] := R.ReadFloat;
    end;
  Angle1 := R.ReadFloat;
  Angle2 := R.ReadFloat;
  Radius := R.ReadFloat;
  reversed := R.ReadBoolean;
  end;

constructor TGAngle.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);

  With DE.childNodes.findNode('position', '') do begin
    dpX[1] := StrToFloat(getAttribute('x1'));
    dpY[1] := StrToFloat(getAttribute('y1'));
    dpX[2] := StrToFloat(getAttribute('x2'));
    dpY[2] := StrToFloat(getAttribute('y2'));
    dpX[3] := StrToFloat(getAttribute('x3'));
    dpY[3] := StrToFloat(getAttribute('y3'));
    end;

  With DE.childNodes.findNode('line', '') do begin
    Radius := StrToFloat(getAttribute('radius'));
    If hasAttribute('reversed') then
      Reversed := LowerCase(getAttribute('reversed')) = 'true'
    else
      Reversed := False;
    end;
  end;

function TGAngle.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var position, angledata : IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  position := DOMDoc.createNode('position');
  position.setAttribute('x1', FloatToStr(dpX[1]));
  position.setAttribute('y1', FloatToStr(dpY[1]));
  position.setAttribute('x2', FloatToStr(dpX[2]));
  position.setAttribute('y2', FloatToStr(dpY[2]));
  position.setAttribute('x3', FloatToStr(dpX[3]));
  position.setAttribute('y3', FloatToStr(dpY[3]));
  Result.childNodes.add(position);

  angledata := DOMDoc.createNode('line');
  angledata.setAttribute('radius', FloatToStr(Radius));
  angledata.setAttribute('reversed', LowerCase(BoolToStr(reversed, True)));
  Result.childNodes.add(angledata);
  end;

procedure TGAngle.AfterLoading(FromXML : Boolean);
  begin
  Inherited AfterLoading(FromXML);
  If Not FromXML then
    Radius := Radius / ObjList.e1x;
  Angle1 := Slope_Angle(dpX[1] - dpX[2], dpY[1] - dpY[2]);
  Angle2 := Slope_Angle(dpX[3] - dpX[2], dpY[3] - dpY[2]);
  If Angle2 < Angle1 then Angle2 := Angle2 + 2*pi;
  end;

procedure TGAngle.UpdateOldNameData;
  { Nur aufrufen, wenn die geladene GEO-Datei von
    einer Version *vor* 3.2.0.0 geschrieben wurde! }
  var ws   : WideString;
      wc   : WideChar;
      c    : Char;
      n, i : Integer;
  begin
  ws := FName;
  For i := 1 to Length(ws) do begin
    n := Ord(ws[i]);
    If ((n >= $41) and (n <= $5A)) or
       ((n >= $61) and (n <= $7A)) then begin
      c  := Char(ws[i]);
      wc := GetWideCharFromSymbolChar(c);
      If wc <> ccError then
        ws[i] := wc;
      end;
    end;
  SetNewName(ws);
  ObjList.IsDirty := True;
  end;

function TGAngle.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccDragableObj, ccPointOrAngle,
                              ccNamedObj, ccAnyAngleObj]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGAngle.GetMatchingCursor(mpt: TPoint): TCursor;
  begin
  Result := Drag_Cursor;
  end;

function TGAngle.Dist(xm, ym: Double): Double;
  var d, mw, r1x, r1y, r2x, r2y : Double;
  begin
  LastDist := 1.0e300;
  If (Abs(Angle2 - Angle1 - pi/2) > AngleEpsilon) or
     RightAnglePt then  { Normalfall Winkelbogen          }
    d := Abs(Hypot(xm - dpX[2], ym - dpY[2]) - Radius)
  else begin            { Krisenfall Rechter-Winkel-Haken }
    r1x := dpX[1] - dpX[2];
    r1y := dpY[1] - dpY[2];
    r2x := dpX[3] - dpX[2];
    r2y := dpY[3] - dpY[2];
    d := Hypot(r1x, r1y);
    If d > epsilon then begin
      d := Radius / d; // (d * ObjList.e1x);
      r1x := r1x * d;
      r1y := r1y * d;
      d := Hypot(r2x, r2y);
      If d > epsilon then begin
        d := Radius / d; // (d * ObjList.e1x);
        r2x := r2x * d;
        r2y := r2y * d;
        // Abstände von den (gezeichneten) Linien des Winkelhakens :
        d := Min(DistPt2ShortLn(dpX[2]+r1x,     dpY[2]+r1y,
                                dpX[2]+r1x+r2x, dpY[2]+r1y+r2y, xm, ym),
                 DistPt2ShortLn(dpX[2]+r2x,     dpY[2]+r2y,
                                dpX[2]+r2x+r1x, dpY[2]+r2y+r1y, xm, ym));
        end
      else
        d := 100;
      end
    else
      d := 100;
    end;
  If d < 1 then begin
    mw := Slope_Angle (xm - dpX[2], ym - dpY[2]);
    If mw < Angle1 then
      if mw + 2 * Pi < Angle2 then
        LastDist := d
      else
    else
      if mw < Angle2 then
        LastDist := d;
    end;
  Dist := LastDist;
  end;

function TGAngle.IsNearMouse: Boolean;
  var dx12, dy12, dx32, dy32, dr1, dr3, r, cf : Double;
  begin
  Result := False;
  If DataValid then begin
    r := Radius * ObjList.e1x;
    dx12 := spX[1] - spX[2];
    dy12 := spY[2] - spY[1];
    dr1  := Hypot(dx12, dy12);
    If dr1 > epsilon then begin
      cf := r / dr1;
      dx12 := dx12 * cf;
      dy12 := dy12 * cf;
      dx32 := spX[3] - spX[2];
      dy32 := spY[2] - spY[3];
      dr3  := Hypot(dx32, dy32);
      If dr3 > epsilon then begin
        cf := r / dr3;
        dx32 := dx32 * cf;
        dy32 := dy32 * cf;
        Result := DistPt2OriArc(dx12, dy12, dx32, dy32,
                                ObjList.LastMousePos.X - spX[2],
                                spY[2] - ObjList.LastMousePos.Y) < CatchDist;
        end;
      end;
    end;
  end;

function TGAngle.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGAngle) and
            (GO.Parent[0] = Self.Parent[0]) and
            (GO.Parent[1] = Self.Parent[1]) and
            (GO.Parent[2] = Self.Parent[2]);
  end;

function TGAngle.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName(#$03B1);   // echtes alpha !!!
  end;

procedure TGAngle.GetSpecialDataFrom(Blueprint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  Radius := (BluePrint as TGAngle).Radius;
  Reversed := (BluePrint as TGAngle).Reversed;
  end;

procedure TGAngle.SaveState;
  begin
  Inherited SaveState;
  With Old_Data do begin
    push(@dpX, SizeOf(dpX));
    push(@dpY, SizeOf(dpY));
    push(@spX, SizeOf(spX));
    push(@spY, SizeOf(spY));
    push(@Angle1, SizeOf(Angle1));
    push(@Angle2, SizeOf(Angle2));
    push(@Radius, SizeOf(Radius));
    push(@Reversed, SizeOf(Reversed));
    end;
  end;

procedure TGAngle.RestoreState;
  begin
  With Old_Data do begin
    pop(@Reversed);
    pop(@Radius);
    pop(@Angle2);
    pop(@Angle1);
    pop(@spY);
    pop(@spX);
    pop(@dpY);
    pop(@dpX);
    end;
  Inherited RestoreState;
  end;

procedure TGAngle.UpdateParams;
  { 27.06.2012 : Bug-Report von Elschenbroich wg. beim Verziehen springendem
                 Winkel (90° => 270° => 90°....). Bugfix siehe (***):
    Das Vertauschen der Schenkel-Punktkoordinaten war falsch implementiert:
    es wurde nur in einer Richtung getauscht, in der anderen nicht!         }
  var i: Integer;
      bx, by : Double;
      p: Array [1..3] of TGPoint;
  begin
  DataValid := True;
  If ObjList.DraggedObj = Self then
    If (Abs(Angle2 - Angle1 - pi/2) > AngleEpsilon) or
       RightAnglePt then  { Normalfall Winkelbogen          }
      Radius := Hypot((dpX[2] - ObjList.LogLastMouse_X),
                      (dpY[2] - ObjList.LogLastMouse_Y) * ObjList.yAspect)
      { 23.05.06: Faktor "yAspect" ergänzt für den Fall des
                  anisotropen Koordinatensystems            }
    else                  { Krisenfall Recht-Winkel-Haken   }
      Radius :=    // Abstände von den Schenkeln(!) des Winkelhakens :
         Max(DistPt2Line(dpX[1], dpY[1], dpX[2], dpY[2],
                         ObjList.LogLastMouse_X, ObjList.LogLastMouse_Y),
             DistPt2Line(dpX[3], dpY[3], dpX[2], dpY[2],
                         ObjList.LogLastMouse_X, ObjList.LogLastMouse_Y))
      { Dies liefert im Falle eines anisotropen Koordinaten-
        systems zwar suboptimales Zugverhalten des Winkel-
        hakens, was aber zunächst mal hingenommen wird.     }
  else begin
    For i:= 1 to 3 do begin
      p[i] := TGPoint(Parent[i-1]);
      If (p[i] = Nil) or (Not p[i].DataValid) then
        DataValid := False;
      end;
    If DataValid then begin
      // SpyOut('Beginn der Winkelberechnung', []);
      If reversed then
        for i := 1 to 3 do begin
          dpX[i] := p[4-i].X;
          dpY[i] := p[4-i].Y;
          end
      else
        for i := 1 to 3 do begin
          dpX[i] := p[i].X;
          dpY[i] := p[i].Y;
          end;
      If (Abs(dpX[1] - dpX[2]) + Abs(dpY[1] - dpY[2]) < DistEpsilon) or
         (Abs(dpX[3] - dpX[2]) + Abs(dpY[3] - dpY[2]) < DistEpsilon) then
        DataValid := False
      else begin
        Angle1 := Slope_Angle(dpX[1] - dpX[2], dpY[1] - dpY[2]);
        Angle2 := Slope_Angle(dpX[3] - dpX[2], dpY[3] - dpY[2]);
        // SpyOut('Orientierung: reversed = %s', [BoolToStr(reversed, True)]);
        // SpyOut('Angle1: x = %g ;  y = %g ;  a1 = %g ;', [dpX[1] - dpX[2], dpY[1] - dpY[2], Angle1]);
        // SpyOut('Angle2: x = %g ;  y = %g ;  a2 = %g ;', [dpX[3] - dpX[2], dpY[3] - dpY[2], Angle2]);
        If Angle2 < Angle1 then
          If Angle1 - Angle2 < AngleEpsilon / 100 then  { am 20.05.01 }
            Angle2 := Angle1         { ergänzt wegen Elschenbroch's   }
          else                       { ZeroAngle-Problem (360 statt 0)}
            Angle2 := Angle2 + 2 * Pi;
        If (Not SignedAngles) and (Angle2 - Angle1 > PI) then begin
          reversed := Not reversed;
          { Referenz-Punkte tauschen : }
          bx     := dpX[1]; by     := dpY[1];              {***}
          dpX[1] := dpX[3]; dpY[1] := dpY[3];              {***}
          dpX[3] := bx;     dpY[3] := by;                  {***}
          { Winkel neu berechnen : }
          Angle1 := Slope_Angle(dpX[1] - dpX[2], dpY[1] - dpY[2]);
          Angle2 := Slope_Angle(dpX[3] - dpX[2], dpY[3] - dpY[2]);
          // SpyOut('Orientierung GEDREHT: reversed = %s', [BoolToStr(reversed, True)]);
          // SpyOut('Angle1: x = %g ;  y = %g ;  a1 = %g ;', [dpX[1] - dpX[2], dpY[1] - dpY[2], Angle1]);
          // SpyOut('Angle2: x = %g ;  y = %g ;  a2 = %g ;', [dpX[3] - dpX[2], dpY[3] - dpY[2], Angle2]);
          If Angle2 < Angle1 - epsilon then
            Angle2 := Angle2 + 2 * Pi;
          end;
        end; { of inner else }
      end; { of inner if }

      // SpyOut('Ende der Winkelberechnung', []);
      // SpyOut('-', []);
    end; { of outer else }
  UpdateScreenCoords;
  end;

procedure TGAngle.UpdateScreenCoords;
  var i : Integer;
  begin
  If DataValid then begin
    DataCanShow := (ObjList.LogWinKnows(dpX[2], dpY[2]) > 0) or
                   (ObjList.LogWinKnows(dpX[1], dpY[1]) > 0) or
                   (ObjList.LogWinKnows(dpX[3], dpY[3]) > 0);
    If DataCanShow then
      For i := 1 to 3 do
        ObjList.GetWinCoords(dpX[i], dpY[i], spX[i], spY[i]);
    If (Abs(spX[1] - spX[2]) + Abs(spY[1] - spY[2]) <= 2) or
       (Abs(spX[1] - spX[2]) + Abs(spY[1] - spY[2]) <= 2) then
      DataValid := False;
    end;
  end;

procedure TGAngle.VirtualizeCoords;
  var i : Integer;
  begin
  Inherited VirtualizeCoords;  { vorsichtshalber ! }
  For i := 1 to 3 do begin
    spX[i] := SafeRound(dpX[i]);
    spY[i] := SafeRound(dpY[i]);
    ObjList.GetLogCoords(spX[i], spY[i], dpX[i], dpY[i]);
    end;
  end;

procedure TGAngle.UpdateNameCoordsIn(TextObj: TGTextObj);
  var r, aw : Double;
  begin
  with TextObj do begin
    DataValid := Self.DataValid;
    If DataValid then begin
      aw := (Angle1 + Angle2) / 2 + sConst;
      r := Radius * rConst;
      X := Self.dpX[2] + r * cos(aw);
      Y := Self.dpY[2] + r * sin(aw);
      end;
    end;
  end;

procedure TGAngle.SetNewNameParamsIn(TextObj: TGTextObj);
  var dx, dy : Double;
  begin
  with TextObj do begin
    dx :=  X - Self.dpX[2];
    dy :=  Y - Self.dpY[2];
    sConst := slope_angle(dx, dy) - (Angle2 + Angle1) / 2;
    If Radius > DistEpsilon then
      rConst := Hypot(dx, dy) / Radius;
    end;
  end;

procedure TGAngle.AdjustGraphTools(todraw: Boolean);
  begin
  Inherited AdjustGraphTools(todraw);
  With ObjList.TargetCanvas do
    If todraw then
      If FillAngleSector then begin
        If Pen.Color = clBlack then
          Brush.Color := clYellow
        else
          Brush.Color := LightCol(Pen.Color, 0.333);
        Brush.Style := bsSolid;
        end
      else begin
        Brush.Color := Pen.Color;
        Brush.Style := bsClear;
        end
    else begin
      Brush.Color := ObjList.BackgroundColor;
      Brush.Style := bsSolid;
      end;
  end;

procedure TGAngle.DrawIt;
  var dxa, dya, dxb, dyb, nf : Double;
      r  : Integer;

  procedure DrawPie(x1, y1, x2, y2, x3, y3, x4, y4: Integer);
    var pc : TColor;
        pw : Integer;
    begin
    With ObjList.TargetCanvas do begin
      pc := Pen.Color;
      pw := Pen.Width;
      Pen.Color := Brush.Color;
      Pen.Width := 1;
      Pie(x1, y1, x2, y2, x3, y3, x4, y4);
      Pen.Color := pc;
      Pen.Width := pw;
      Arc(x1, y1, x2, y2, x3, y3, x4, y4);
      end;
    end;

  procedure DrawHook(x1, y1, x2, y2, x3, y3, x4, y4: Integer);
    var pa : Array of TPoint;
        pc : TColor;
        pw : Integer;
    begin
    SetLength(pa, 4);
    pa[0] := Point(x1, y1);
    pa[1] := Point(x2, y2);
    pa[2] := Point(x3, y3);
    pa[3] := Point(x4, y4);
    With ObjList.TargetCanvas do begin
      pc := Pen.Color;
      pw := Pen.Width;
      Pen.Color := Brush.Color;
      Pen.Width := 1;
      Polygon(pa);
      Pen.Color := pc;
      Pen.Width := pw;
      MoveTo(x2, y2);
      LineTo(x3, y3);
      LineTo(x4, y4);
      end;
    pa := Nil;
    end;

  begin
  If IsVisible then with ObjList.TargetCanvas do begin
    AdjustGraphTools(True);
    r := Round(Radius * ObjList.e1x); // 13.09.05: "... * ObjList.ScaleFactor"
                                      // entfernt, da dies schon bei der
                                      // Skalierung des Koordinatensystems
                                      // berücksichtigt wird.
    If Abs(Angle2 - Angle1 - pi/2) > AngleEpsilon then   { Normaldarstellung als Winkelbogen }
      If Angle2 > Angle1 + AngleEpsilon then
        DrawPie(spX[2] - r, spY[2] - r, spX[2] + r, spY[2] + r,
                spX[1], spY[1], spX[3], spY[3])
      else
        { keine Darstellung ! }
    else begin
      dxa := spX[1] - spX[2];                            { Für rechte Winkel: Winkelhaken !  }
      dya := spY[1] - spY[2];
      nf  := Hypot(dxa, dya);
      If nf > Epsilon then begin
        dxa := dxa / nf * r;
        dya := dya / nf * r;
        end;
      dxb := spX[3] - spX[2];
      dyb := spY[3] - spY[2];
      nf  := Hypot(dxb, dyb);
      If nf > Epsilon then begin
        dxb := dxb / nf * r;
        dyb := dyb / nf * r;
        end;
      If RightAnglePt then begin
        DrawPie(spX[2] - r, spY[2] - r, spX[2] + r, spY[2] + r,
                spX[1], spY[1], spX[3], spY[3]);
        Brush.Color := Pen.Color;
        Ellipse(Round(spX[2] + (dxa + dxb)* 0.4) - 3,
                Round(spY[2] + (dya + dyb)* 0.4) - 3,
                Round(spX[2] + (dxa + dxb)* 0.4) + 3,
                Round(spY[2] + (dya + dyb)* 0.4) + 3)
        end
      else
        DrawHook(spX[2], spY[2],
                 Round (spX[2] + dxa      ), Round (spY[2] + dya      ),
                 Round (spX[2] + dxa + dxb), Round (spY[2] + dya + dyb),
                 Round (spX[2]       + dxb), Round (spY[2]       + dyb));
      end;
    end;
  end;

procedure TGAngle.HideIt;
  var dxa, dya, dxb, dyb,
      nf : Double;
      pa : Array of TPoint;
      r  : Integer;
  begin
  If IsVisible then with ObjList.TargetCanvas do begin
    AdjustGraphTools(False);
    r := Round(Radius * ObjList.e1x);
    If Abs(Angle2 - Angle1 - pi/2) > AngleEpsilon then   { Normaldarstellung als Winkelbogen }
      If Angle2 > Angle1 + AngleEpsilon then
        Pie(spX[2] - r, spY[2] - r, spX[2] + r, spY[2] + r,
            spX[1], spY[1], spX[3], spY[3])
      else
        { keine Darstellung ! }
    else begin                                           { Für rechte Winkel: Winkelhaken !  }
      dxa := spX[1] - spX[2];
      dya := spY[1] - spY[2];
      nf  := Sqrt(Sqr(dxa) + Sqr(dya));
      dxa := dxa / nf * r;
      dya := dya / nf * r;
      dxb := spX[3] - spX[2];
      dyb := spY[3] - spY[2];
      nf  := Hypot(dxb, dyb);
      If nf > epsilon then begin
        dxb := dxb / nf * r;
        dyb := dyb / nf * r;
        end;
      If RightAnglePt then
        Pie(spX[2] - r, spY[2] - r, spX[2] + r, spY[2] + r,
            spX[1], spY[1], spX[3], spY[3])
      else begin
        SetLength(pa, 4);
        pa[0] := Point(spX[2], spY[2]);
        pa[1] := Point(Round (spX[2] + dxa      ), Round (spY[2] + dya      ));
        pa[2] := Point(Round (spX[2] + dxa + dxb), Round (spY[2] + dya + dyb));
        pa[3] := Point(Round (spX[2]       + dxb), Round (spY[2]       + dyb));
        Polygon(pa);
        pa := Nil;
        end;
      end;
    end;
  end;

procedure TGAngle.SetShowsAlways(vis: Boolean);
  var i  : Integer;
      pM : TGAngleWidth;
  begin
  If Not vis then begin                       { Wenn der Winkelbogen verborgen wird,       }
    i := 0;                                       { wird automatisch ein eventuell vorhandenes }
    While i < Children.Count do begin             { Winkelmaßobjekt ebenfalls verborgen.       }
      pM := TGAngleWidth(Children.Items[i]);
      If pM is TGAngleWidth then begin
        pM.ShowsAlways := False;
        i := Children.Count;
        end
      else
        Inc(i);
      end;
    end;
  Inherited SetShowsAlways(vis);
  end;

procedure TGAngle.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  menu.Items.Clear;    { "Free"d auch die einzelnen Items ! }
  AddPopupMenuItemTo(menu, cme_hide, CME_PopupClick, cmd_ToggleVis);
  AddPopupMenuItemTo(menu, cme_name, CME_PopupClick, cmd_NameObj);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_col, CME_PopupClick, cmd_EditColour);
  AddPopupMenuItemTo(menu, cme_linestyle, CME_PopupClick, cmd_EditLineStyle);
  end;

function TGAngle.GetInfo: String;
  begin
  Result := MyObjTxt[10];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  InsertNameOf(TGeoObj(Parent[2]), Result);
  end;

function TGAngle.GetValue(selector: Integer): Double;
  begin
  Case selector of
    gv_val : If Angle2 >= Angle1 then
               Result := Angle2 - Angle1
             else
               Result := 2*Pi + Angle2 - Angle1;
  else
    Result := Inherited GetValue(selector);
  end; { of case }
  end;


{-------------------------------------------}
{ TGOrigin's Methods Implementation         }
{-------------------------------------------}

constructor TGOrigin.Create(iObjList: TGeoObjListe; iX, iY: Double; iCSType: Integer; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, 0, 0, False);
  X := iX;          { Ist beides    }
  Y := iY;          { gleich Null ! }
  FMyColour := DefCosysCol;
  MyShape    := 1;
  MyLineWidth := 1;
  MyBrushStyle := bsClear;

  FName := 'O';
  FStatus  := gs_Normal;
  If Not iis_visible then
    FStatus := FStatus and not gs_ShowsAlways;

  CSType := iCSType;

  UpdateParams;
  If IsVisible then begin
    AdjustGraphTools(True);
    DrawIt;
    end;
  end;

constructor TGOrigin.Load (S: TFileStream; iObjList: TGeoObjListe);
  var exy : Double;
      i   : Integer;
  begin
  Inherited Load(S, iObjList);
  For i := 1 to 4 do
    S.Read(exy, SizeOf(exy));
  CSType := ReadOldIntFromStream(S);
  dsx := 1;
  dsy := 1;
  end;

constructor TGOrigin.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);

  BackX1 := R.ReadFloat;        { ergänzt 04.10.03 wg. Skalierungsproblem }
  BackY1 := R.ReadFloat;        {         des Hintergrundbildes           }
  BackX2 := R.ReadFloat;
  BackY2 := R.ReadFloat;

  CSType := R.ReadInteger;
  BackBMP := TBitMap.Create;
  If R.NextValue = vaExtended then begin
    R.ReadFloat;                { 2 Floats Pufferplatz }
    R.ReadFloat;
    R.ReadInteger;              { früher: FBackStatus, jetzt überflüssig! }
    With BackRect do begin
      left := R.ReadInteger;
      top  := R.ReadInteger;
      right  := R.ReadInteger;
      bottom := R.ReadInteger;
      If Abs(right - left) + Abs(bottom - top) > 0 then begin
        BackBMP := TBitmap.Create;
        ReadBitMapDataByReader(R, BackBMP);
        end;
      end;
    end
  else
    BackRect    := Rect(0, 0, 0, 0);
  If (scrx = 0) and (scry = 0) then begin
    scrx := Round(X);
    scry := Round(Y);
    X := 0;
    Y := 0;
    end;
  If (ObjList.WindowOrigin.X = 0) and
     (ObjList.WindowOrigin.Y = 0) then
    ObjList.FWindowOrigin := Point(scrx, scry)
  else begin
    scrx := ObjList.WindowOrigin.X;
    scry := ObjList.WindowOrigin.Y;
    end;
  dsx := 1;
  dsy := 1;
  end;

constructor TGOrigin.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  CSType := 0;
  If DE.hasAttribute('cosys_type') then
    CSType := StrToInt(DE.getAttribute('cosys_type'));
  AxisNoNumbers := False;
  If DE.hasAttribute('show_numbers') then
    AxisNoNumbers := LowerCase(DE.getAttribute('show_numbers')) = 'false';
  GridType := 0;
  If DE.hasAttribute('grid_marks') then
    GridType := StrToInt(DE.getAttribute('grid_marks'));
  end;

procedure TGOrigin.AfterLoading(FromXML : Boolean = True);
  begin
  If Abs(dsx) < epsilon then
    If CSType = 0 then
      dsx := 1
    else
      dsx := Abs(CSType);
  If Abs(dsy) < epsilon then
    dsy := dsx;  // Annahme eines isotropen Koordinatensystems !
  If FromXML and (ObjList.Count > 4) then
    { Dummy-Routine für spätere Ergänzungen };
  end;


function TGOrigin.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  Result.setAttribute('cosys_type', IntToStr(CSType));
  If AxisNoNumbers then
    Result.setAttribute('show_numbers', 'false');
  If GridType <> 0 then
    Result.setAttribute('grid_marks', IntToStr(GridType));
  end;

function TGOrigin.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId = ccDragableObj) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGOrigin.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGOrigin);
  end;

function TGOrigin.GetMatchingCursor(mpt: TPoint): TCursor;
  begin
  Result := Drag_Cursor;
  end;

function TGOrigin.ShowAxis: Boolean;
  begin
  If ObjList.Count > 4 then
    Result := TGAxis(ObjList.Items[1]).ShowsAlways and
              TGAxis(ObjList.Items[2]).ShowsAlways
  else
    Result := False;
  end;

procedure TGOrigin.ExportBackPic2GeoList;
  { 10.04.2008  Test auf BackBMP.Width * BackBMP.Height > 0 eingebaut,
                um den Import leerer Bilder zu vermeiden; diese machten
                beim Abspeichern im PNG-Format Probleme !              }
  var bp : TGImage;
  begin
  If BackBMP <> Nil then
    If BackBMP.Width * BackBMP.Height > 0 then begin   { 10.04.2008: s. o. }
      If Hypot(BackX2, BackY1) > epsilon then begin
        ObjList.GetWinCoords(BackX1, BackY1, BackRect.Left,  BackRect.Top);
        ObjList.GetWinCoords(BackX2, BackY2, BackRect.Right, BackRect.Bottom);
        end
      else with BackRect do begin
        Left := Round(Left * ppcm_corrfactor);
        Top  := Round(Top  * ppcm_corrfactor);
        Right  := Round(Right * ppcm_corrfactor);
        Bottom := Round(Bottom * ppcm_corrfactor);
        ObjList.GetLogCoords(Left,  Top,    BackX1, BackY1);
        ObjList.GetLogCoords(Right, Bottom, BackX2, BackY2);
        end;
      bp := TGImage.CreateFromBMP(ObjList, BackBMP, BackX1, BackY1, BackX2, BackY2);
      Try
        ObjList.Insert(5, bp);
        Inc(ObjList.LastValidObjIndex);
        FreeAndNil(BackBMP);
      except
        bp.Free;
      end;
      end
    else
      FreeAndNil(BackBMP);
  end;

function TGOrigin.GetAxisNoNumbers: Boolean;
  begin
  Result := FStatus and gs_IsReversed > 0;
  end;

procedure TGOrigin.SetAxisNoNumbers(newVal: Boolean);
  begin
  If AxisNoNumbers <> newVal then
    If newVal then
      FStatus := FStatus or gs_IsReversed
    else
      FStatus := FStatus and Not gs_IsReversed;
  end;

procedure TGOrigin.SetGridType(newVal: Integer);
  begin
  If newVal <> FGridType then
    FGridType := newVal;
  end;

procedure TGOrigin.DrawGrid;
  { zeichnet die Kreuzl' für ein kartesisches Koordinatensystem:
    die Achsen müssen parallel zu den Fensterrändern verlaufen.   }
  var x0, xl, yl: Double;
      wx, wy,
      dcr       : Integer;
      ShowNums  : Boolean;
      csl_style : TPenStyle;

  procedure Paint_Cross(xl, yl: Double);
    var xp, yp : Integer;
    begin
    If (yl <> 0) and (xl <> 0) then with ObjList.TargetCanvas do begin
      ObjList.GetWinCoords(xl, yl, xp, yp);
      MoveTo(xp -      dcr,  yp);
      LineTo(xp + Succ(dcr), yp);
      MoveTo(xp, yp -      dcr );
      LineTo(xp, yp + Succ(dcr));
      end;
    end;

  procedure Paint_Mark(xl, yl: Double);
    var xp, yp : Integer;
        pu     : String;
    begin
    ObjList.GetWinCoords(xl, yl, xp, yp);
    With ObjList.TargetCanvas do
      If yl <> 0 then begin
        If ShowNums then begin
          pu := Float2Str(yl, 5);
          TextOut(xp + 3 * dcr, yp - TextHeight(pu) Div 2, pu);
          end;
        MoveTo(xp -      dcr,  yp);
        LineTo(xp + Succ(dcr), yp);
        end
      else
      If xl <> 0 then begin
        MoveTo(xp, yp -      dcr );
        LineTo(xp, yp + Succ(dcr));
        If ShowNums then begin
          pu := Float2Str(xl, 5);
          TextOut(xp - TextWidth(pu) Div 2, yp + 2 * dcr, pu);
          end;
        end;
    end;

  procedure Paint_Arrows;
    var xp, yp, dl : Integer;
        cs         : String;
    begin
    dl := Round(5 * ObjList.ScaleFactor);
    With ObjList.TargetCanvas do begin
      ObjList.GetWinCoords(ObjList.xMax, 0, xp, yp);
      MoveTo(xp, yp); LineTo(xp - 4 * dl, yp - dl);
      MoveTo(xp, yp); LineTo(xp - 4 * dl, yp + dl);
      If ObjList.Count > 1 then
        cs := TGAxis(ObjList.Items[1]).caption
      else
        cs := 'x';
      TextOut(xp - 2 * dl - TextWidth(cs), yp - dl - TextHeight(cs), cs);

      ObjList.GetWinCoords(0, ObjList.yMax, xp, yp);
      MoveTo(xp, yp); LineTo(xp - dl, yp + 4 * dl);
      MoveTo(xp, yp); LineTo(xp + dl, yp + 4 * dl);
      If ObjList.Count > 2 then
        cs := TGAxis(ObjList.Items[2]).caption
      else
        cs := 'y';
      TextOut(xp - 2 * dl - TextWidth(cs), yp, cs);
      end;
    end;

  begin { of DrawGrid }
  ShowNums := Not AxisNoNumbers;
  csl_style := ObjList.TargetCanvas.Pen.Style;
  ObjList.TargetCanvas.Pen.Style := psSolid;
  dcr := Round(2 * ObjList.ScaleFactor);

  xl  := Round(ObjList.xMin / dsx) * dsx;
  While xl < ObjList.xMax do begin  { x-Achse mit Marken versehen }
    Paint_mark (xl, 0);             {  und beschriften            }
    xl := xl + dsx;
    end;

  yl  := Round(ObjList.yMin / dsy) * dsy;
  While yl < ObjList.yMax do begin  { y-Achse mit Marken versehen }
    Paint_Mark (0, yl);             {  und beschriften            }
    yl := yl + dsy;
    end;

  Paint_Arrows;

  If CSType > 0 then begin  { Kreuzl bzw. Gitter }
    xl := Round(ObjList.xMin / dsx) * dsx;
    yl := Round(ObjList.yMin / dsy) * dsy;
    x0 := xl;
    If GridType = 0 then begin
      While yl < ObjList.yMax do begin   { Kreuzl malen }
        While xl < ObjList.xMax do begin
          Paint_Cross (xl, yl);
          xl := xl + dsx;
          end;
        xl := x0;
        yl := yl + dsy;
        end;
      end
    else begin  { Gitter malen }
      xl := Round(ObjList.xMin / dsx) * dsx;
      While xl < ObjList.xMax do with ObjList.TargetCanvas do begin
        ObjList.GetWinCoords(xl, ObjList.yMin, wx, wy);
        draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                     wx, ObjList.WindowRect.Top,
                     wx, ObjList.WindowRect.Bottom, csl_style);
        xl := xl + dsx;
        end;
      yl := Round(ObjList.yMin / dsx) * dsx;
      While yl < ObjList.yMax do with ObjList.TargetCanvas do begin
        ObjList.GetWinCoords(ObjList.xMin, yl, wx, wy);
        draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                     ObjList.WindowRect.Left, wy,
                     ObjList.WindowRect.Right, wy, csl_style);
        yl := yl + dsy;
        end;
      end;
    end;
  end;  { of DrawGrid }

procedure TGOrigin.AdjustGraphTools(todraw: Boolean);
  begin
  Inherited AdjustGraphTools(todraw);
  With ObjList.TargetCanvas do begin
    Brush.Color := ObjList.BackgroundColor;
    Font.Assign(ObjList.StartFont);
    Font.Height := Round(ObjList.StartFont.Height * ObjList.ScaleFactor);
    Pen.Style   := MyPenStyle;
    If todraw then begin
      Brush.Style := bsClear;
      Font.Color  := Pen.Color;
      end
    else begin
      Brush.Style := bsSolid;
      Font.Color  := ObjList.BackgroundColor;
      end;
    end;
  end;

procedure TGOrigin.ReAdjustGraphTools;
  var AxisObj : TGeoObj;
  begin
  With ObjList.TargetCanvas do begin
    If GridType = 2 then  // nur für punktierte Linien:
      Pen.Style := psDot
    else
      Pen.Style := psSolid;
    If (ObjList <> Nil) and (ObjList.Count > 4) then begin
      AxisObj := objList.Items[1];
      Pen.Color := AxisObj.MyColour;
      Font.Color := AxisObj.MyColour;
      end
    else begin
      Pen.Color  := MyColour;
      Font.Color := MyColour;
      end;
    end;
  end;

procedure TGOrigin.UpdateParams;
  begin
  DataValid := True;
  UpdateScreenCoords;
  end;

procedure TGOrigin.UpdateScreenCoords;

  procedure AdjustStep(up: Boolean; var step: Double);
    var fz : Integer;
    begin
    fz := Round(10*frac(Log10(step)));
    If up then
      If (fz = 3) or (fz = -7) then step := step * 2.5
      else                          step := step * 2
    else
      If (fz = 7) or (fz = -3) then step := step / 2.5
      else                          step := step / 2;
    end;

  var es, eps : Double;
  begin
  If DataValid then begin
    scrx := ObjList.WindowOrigin.X;
    scry := ObjList.WindowOrigin.Y;

    If ObjList.OutputStatus = outScreen then begin
      If CSType = 0 then es := 1 else es := Abs(CSType);
      dsx := es;  eps := Abs(ObjList.e1x) / (es * ScreenPPCMx);
      While eps * dsx < 0.95 do AdjustStep(True, dsx);
      While eps * dsx > 1.95 do AdjustStep(False, dsx);
      dsy := es;  eps := Abs(ObjList.Fe2y) / (es * ScreenPPCMy);
      While eps * dsy < 0.95 do AdjustStep(True, dsy);
      While eps * dsy > 1.95 do AdjustStep(False, dsy);
      end;

    DataCanShow := True;
    end;
  end;

procedure TGOrigin.DrawIt;
  begin
  If IsVisible then begin
    Inherited DrawIt;
    If ShowAxis then begin // Falls beide Achsen sichtbar sind:
      ReAdjustGraphTools;
      DrawGrid;
      end;
    end;
  end;

procedure TGOrigin.HideIt;
  var MyTruePenStyle : TPenStyle;
  begin
  If IsVisible then begin
    MyTruePenStyle := MyPenStyle;
    MyPenStyle := psSolid;
    Inherited HideIt;
    ObjList.TargetCanvas.Pen.Style := MyPenStyle;
    MyPenStyle := MyTruePenStyle;
    end;
  end;

procedure TGOrigin.RegisterAsMacroStartObject;
  begin
  With TMakro(ObjList.MakroList.Last) do
    Insert(0, TMakroCmd.Create(Self, -1));
  end;

function TGOrigin.GetInfo: String;
  begin
  Result := MyObjTxt[11];
  InsertNameOf(Self, Result);
  end;

destructor TGOrigin.Destroy;
  begin
  BackBMP.Free;
  Inherited Destroy;
  end;


{-------------------------------------------}
{ TGAxis's Methods Implementation           }
{-------------------------------------------}

constructor TGAxis.Create(iObjList: TGeoObjListe; iOri: TGOrigin;
                          idx, idy: Integer; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, 0, 0, idx, idy, False);
  BecomesChildOf(iOri);
  FMyColour := DefCosysCol;
  MyPenStyle := psSolid;
  MyLineWidth := 1;
  If Abs(idx) > Abs(idy) then begin
    dx := 1;
    dy := 0;
    FName   := 'xa'
    end
  else begin
    dx :=  0;
    dy :=  1;           { 03.01.05: "1" statt "-1" (probeweise!) }
    FName   := 'ya';
    end;
  caption := FName[1];  { Default }
  FStatus := FStatus or gs_DataValid;
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

constructor TGAxis.Load32(R: TReader; iObjList: TGeoObjListe);
  var n : Integer;
  begin
  Inherited Load32(R, iObjList);
  n := Pos('|', FName);
  If n = 0 then
    n := Pos('_', FName);
  If n > 0 then begin
    caption := Copy(FName, n+1, Length(FName));
    Delete(FName, n, Length(FName));
    end
  else
    If Length(FName) > 0 then
      caption := FName[1]
    else
      caption := '';
  end;

constructor TGAxis.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  If DE.hasAttribute('label') then
    caption := DE.getAttribute('label')
  else
    If Pos('X', UpperCase(Name)) > 0 then
      caption := 'x'
    else
      caption := 'y';
  end;

function TGAxis.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  Result.setAttribute('label', caption);
  end;

procedure TGAxis.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  FName := (BluePrint as TGAxis).Name;
  end;

procedure TGAxis.SetMyColour(NewCol: TColor);
  begin
  If FMyColour <> NewCol then begin
    If IsVisible then begin
      HideIt;
      FMyColour := NewCol;
      DrawIt;
      end
    else
      FMyColour := NewCol;
    If ObjList <> Nil then         // andere Achse auch umfärben!
      Case ObjList.IndexOf(Self) of
        1 : TGeoObj(ObjList.Items[2]).MyColour := NewCol;
        2 : TGeoObj(ObjList.Items[1]).MyColour := NewCol;
      end;  { of case }
    end;
  end;

procedure TGAxis.VirtualizeCoords;
  begin
  If Abs(dx) > Abs(dy) then begin  // x-Achse
    dx :=  1;
    dy :=  0;
    end
  else begin                       // y-Achse
    dx :=  0;
    dy :=  -1;    { y-Achsen-Orientierung in 2.6 rumdrehen ! }
    end;
  UpdateParams;
  end;

function TGAxis.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  If GO.ClassType = Self.ClassType then
    Result := (Abs(TGAxis(GO).dx) > Abs(TGAxis(GO).dy)) = (Abs(dx) > Abs(dy))
  else
    Result := False;
  end;

function TGAxis.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId = ccFunktionOrAxis) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGAxis.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr = 1 then
    Result := Parent[0]
  else
    Result := Nil;
  end;

procedure TGAxis.UpdateParams;
  begin
  DataValid := True;
  X1 := 0;
  Y1 := 0;
  X2 := dx;
  Y2 := dy;
  FHesseEq.Assign(-dy, dx, 0);
  UpdateScreenCoords;
  end;

procedure TGAxis.RegisterAsMacroStartObject;
  begin
  With TMakro(ObjList.MakroList.Last) do
    Insert(0, TMakroCmd.Create(Self, -1));
  end;

function TGAxis.IsNearMouse: Boolean;
  begin
  If Abs(dx) > Abs(dy) then  // x-Achse
    Result := Abs(ObjList.LastMousePos.Y - sy1) < CatchDist
  else                       // y-Achse
    Result := Abs(ObjList.LastMousePos.X - sx1) < CatchDist;
  end;

function TGAxis.GetInfo: String;
  begin
  If Abs(dx) > Abs(dy) then  // x-Achse
    Result := MyObjTxt[12]
  else                       // y-Achse
    Result := MyObjTxt[13];
  InsertNameOf(Self, Result);
  end;


{-------------------------------------------}
{ TGaugePoint's Methods Implementation      }
{-------------------------------------------}

constructor TGaugePoint.Create(iObjList: TGeoObjListe; Ori, Ax: TGeoObj; iis_visible: Boolean);
  begin
  If Ax.GeoNum = TGAxis(iObjList.Items[1]).GeoNum then begin
    Inherited Create(iObjList, 1, 0, False);
    Art := 1;
    FName := 'X_1';
    end
  else begin
    Inherited Create(iObjList, 0, 1, False);
    Art := 2;
    FName := 'Y_1';
    end;
  FMyColour := ColorTable[1];
  MyShape   :=  1;
  BecomesChildOf(Ax);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  DrawIt;
  end;

constructor TGaugePoint.Load (S: TFileStream; iObjList: TGeoObjListe);
  begin
  Inherited Load (S, iObjList);
  Art := ReadOldIntFromStream(S);
  end;

constructor TGaugePoint.Load32 (R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  Art := R.ReadInteger;
  end;

constructor TGaugePoint.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  If Name = 'X_1' then
    Art := 1
  else
    Art := 2;
  end;

function TGaugePoint.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  end;

procedure TGaugePoint.UpdateParams;
  begin
  If ObjList.DraggedObj = Self then
    Inherited UpdateParams
  else
    If Art = 1 then begin
      X := 1;
      Y := 0;
      end
    else begin
      X := 0;
      Y := 1;
      end;
  end;

procedure TGaugePoint.DrawIt;
  begin         { verhindert jegliche Darstellung ! }
  DataValid := False;
  end;

procedure TGaugePoint.HideIt;
  begin         { verhindert jegliche Darstellung ! }
  DataValid := False;
  end;

procedure TGaugePoint.SetIsMarked(flag: Boolean);
  { überschreibt die TGeoObj-Methode, um vor dem Löschen des Koordinatensystems
    die mitzulöschenden Objekte korrekt anzuzeigen: Eichpunkte markieren von
    ihren Kindern nur solche, die keine Koordinatenpunkte sind; diese werden
    nämlich in Basispunkte verwandelt und nicht gelöscht.                     }
  var i  : Integer;
  begin
  If flag <> IsMarked then begin
    If flag then
      If IsVisible then begin
        HideIt;
        FStatus := FStatus or gs_IsMarked;
        DrawIt;
        end
      else
        FStatus := FStatus or gs_IsMarked
    else
      If IsVisible then begin
        HideIt;
        FStatus := FStatus and Not gs_IsMarked;
        DrawIt;
        end
      else
        FStatus := FStatus and Not gs_IsMarked;
    i := Pred(Children.Count);
    While i >= 0 do begin
      With TGeoObj(Children.Items[i]) do
        If (ClassType <> TGPoint) and
           (ClassType <> TGCoordPt) then    {!}
          IsMarked := flag;
      Dec(i);
      end;
    end;
  end;

function TGaugePoint.GetInfo: String;
  begin
  If Art = 1 then
    Result := MyObjTxt[14]
  else
    Result := MyObjTxt[15];
  InsertNameOf(Self, Result);
  end;


{-------------------------------------------}
{ TGTextObj's Methods Implementation        }
{-------------------------------------------}

constructor TGTextObj.Create(iObjList: TGeoObjListe; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, iis_visible);
  BMPText    := TBitMap.Create;
  BMPTextOR  := TBitMap.Create;
  BMPTextAND := TBitMap.Create;
  end;

constructor TGTextObj.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBluePrintOf(GO, iGeoNum);
  BMPText    := TBitMap.Create;
  BMPTextOR  := TBitMap.Create;
  BMPTextAND := TBitMap.Create;
  end;

constructor TGTextObj.Load(S: TFileStream; iObjList: TGeoObjListe);
  begin
  Inherited Load(S, iObjList);
  BMPText    := TBitMap.Create;
  BMPTextOR  := TBitMap.Create;
  BMPTextAND := TBitMap.Create;
  RenderWin  := Point(Succ(OutRect.Right - OutRect.Left),
                      Succ(OutRect.Bottom - OutRect.Top));
  end;

constructor TGTextObj.Load32(R: TReader; iObjList: TGeoObjListe);
  var s         : String;
      oldRPos,
      dx, dy    : Integer;
      StartFont : TFont;
  begin
  Inherited Load32(R, iObjList);

  If R.NextValue in [vaInt8, vaInt16, vaInt32] then begin
    scrx := R.ReadInteger;
    scry := R.ReadInteger;
    X  := R.ReadFloat;
    Y  := R.ReadFloat;
    end
  else begin
    scrx := SafeRound(R.ReadFloat);
    scry := SafeRound(R.ReadFloat);
    try
      ObjList.GetLogCoords(scrx, scry, X, Y);
    except
    end;
    end;

  dx := Max(R.ReadInteger, 0);
  dy := Max(R.ReadInteger, 0);
  With OutRect do begin
    left := scrx;
    top  := scry;
    right  := left + dx;
    bottom := top  + dy;
    end;
  RenderWin := Point(Succ(dx), Succ(dy));

  StartFont := TFont.Create;  { Nur zum Auslesen....              }
  With StartFont do begin
    CharSet := TFontCharSet(R.ReadInteger);
    Pitch   := TFontPitch(R.ReadInteger);
    If R.ReadBoolean then Style := Style + [fsBold];
    If R.ReadBoolean then Style := Style + [fsItalic];
    If R.ReadBoolean then Style := Style + [fsUnderline];
    If R.ReadBoolean then Style := Style + [fsStrikeOut];
    Size := R.ReadInteger;
    Name := R.ReadString;
    end;
  StartFont.Free;             { ... und gleich wieder weg damit ! }

  s := R.ReadString;
  If ClassType = TGComment then
    FMyColour := clBlack
  else
    FMyColour := RTFColor(s);
  HTMLText := RTF2HTML(s);
  If Self is TGName then
    HTMLText := KillAllBreaks(HTMLText);

  BMPText    := TBitMap.Create;
  BMPTextOR  := TBitMap.Create;
  BMPTextAND := TBitMap.Create;

  oldRPos := R.Position;
  If (R.NextValue in [vaString, vaLString, vaWString]) and
     (R.ReadString = 'BITMAPDATA') then                    // GEOX-Version
    If ReadBitmapDataByReader(R, BMPText) = 0 then
      DataValid := LoadMasks
    else
  else                                                     // GEO-Version
    R.Position := oldRPos;

  oldRPos := R.Position;
  try
    rConst := R.ReadFloat / ObjList.e1x;
    sConst := R.ReadFloat / ObjList.e2y;
  except
    rConst := 0;
    sConst := 0;
    R.Position := oldRPos;
  end;
  end;

procedure TGTextObj.AfterLoading(FromXML : Boolean = True);
  var SL     : TStringList;
      OrgCol : TColor;
  begin
  If Length(HTMLText) > 0 then begin
    If Not Assigned(FormatText) then begin
      SL := TStringList.Create;
      try
        SL.Text := HTMLText;
        FormatText := TFormatText.Create(SL, ObjList.StartFont);
      finally
        SL.Free;
      end;
      end;
    If Not FromXML then begin
      RenderWin.X := Round(RenderWin.X * 1.1) + 20;
      If ClassType = TGComment then                       // Textbox
        RenderWin.Y := Round(RenderWin.Y * 1.1) + 20
      end;
    RenderHTML2BMP;
    If (ClassType = TGComment) and (Not ShowsAlways) then begin
      OrgCol    := MyColour;
      FMyColour := clNone;
      MyColour  := ColorTable[1];  { grau = Farbe verborgener Objekte }
      FMyColour := OrgCol;
      end;
    end;
  end;

constructor TGTextObj.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var dompos,
      domtext      : IXMLNode;
      LogRenderWin : TFloatPoint;
      dts          : String;
  begin
  Inherited CreateFromDomData(iObjList, DE);

  dompos := DE.childNodes.findNode('position', '');
  X := StrToFloat(dompos.getAttribute('x'));
  Y := StrToFloat(dompos.getAttribute('y'));
  With LogRenderWin do begin
    x := StrToFloat(dompos.getAttribute('width'));
    y := StrToFloat(dompos.getAttribute('height'));
    end;

  ObjList.GetWinCoords(X, Y, scrx, scry);
  RenderWin.X := Round(LogRenderWin.x *     ObjList.e1x );
  RenderWin.Y := Round(LogRenderWin.y * Abs(ObjList.e2y));

  With OutRect do begin
    left := scrx;
    top  := scry;
    right := left + RenderWin.X;
    bottom := top + RenderWin.Y;
    end;

  BMPText    := TBitMap.Create;
  BMPTextOR  := TBitMap.Create;
  BMPTextAND := TBitMap.Create;

  domText := DE.childNodes.findNode('text', '');
  if Assigned(domText) then begin
    dts := domText.Text;
    DeleteChars(#$000A#$000D, dts);  // Weiche Zeilenumbrüche löschen!
    HTMLText := CDATATagRestored(dts);
    end;
  end;

function TGTextObj.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var position, domtext: IXMLNode;
      s : WideString;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  position := DOMDoc.createNode('position');
  position.setAttribute('x', FloatToStr(X));
  position.setAttribute('y', FloatToStr(Y));
  try   { wegen Prototyp-Abspeicherung ergänzt }
    position.setAttribute('width',  FloatToStr(RenderWin.X /     ObjList.e1x) );
    position.setAttribute('height', FloatToStr(RenderWin.Y / Abs(ObjList.e2y)));
  except
    position.setAttribute('width', '0');
    position.setAttribute('height', '0');
  end;
  Result.childNodes.add(position);

  domtext := DOMDoc.createNode('text');
  s := CDATACompatible(HTMLText);
  domtext.childNodes.add(DOMDoc.createNode(s, ntCData));
  Result.childNodes.add(domtext);
  end;


destructor TGTextObj.Destroy;
  begin
  try
    HideIt;       { Objekt vom Bildschirm entfernen }
  except
  end;
  FStatus := FStatus and Not gs_DataValid;
  BMPText.Free;
  BMPTextOR.Free;
  BMPTextAND.Free;
  FormatText.Free;
  Inherited Destroy;
  end;

function TGTextObj.GetMatchingCursor(mpt: TPoint): TCursor;
  begin
  If PtInRect(OutRect, mpt) then
    Result := Hand_Cursor
  else
    Result := crArrow;
  end;

procedure TGTextObj.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  HTMLText := (BluePrint as TGTextObj).HTMLText;
  end;

procedure TGTextObj.UpdateNameCoordsIn(TextObj: TGTextObj);
  begin
  { do nothing }
  end;

procedure TGTextObj.SetMyColour(NewCol: TColor);
  begin
  If NewCol <> FMyColour then begin
    If IsVisible then
      HideIt;
    If DataValid then begin
//      ReplaceColor(BMPText, FMyColour, NewCol);
      ReplaceColorShades(BMPText, ObjList.BackgroundColor, FMyColour, NewCol);
      LoadMasks;
      FMyColour := NewCol;
      end;
    If IsVisible then
      DrawIt;
    end;
  end;

procedure TGTextObj.SetShowsAlways(vis: Boolean);
  var OrgCol : TColor;
  begin
  If ShowsAlways <> vis then
    If vis then begin
      FStatus   := FStatus or gs_ShowsAlways;
      OrgCol    := FMyColour;
      FMyColour := clNone;
      MyColour  := OrgCol;
      DrawIt;
      end
    else begin
      OrgCol    := FMyColour;
      FMyColour := clNone;
      MyColour  := ColorTable[1];  { grau = Farbe verborgener Objekte }
      FMyColour := OrgCol;
      HideIt;
      FStatus   := FStatus and Not gs_ShowsAlways;
      end
  else
    If vis then
      DrawIt
    else
      HideIt;
  end;

procedure TGTextObj.SetWinPos(newVal: TPoint);
  var dx, dy : Integer;
  begin
  Inherited SetWinPos(newVal);

  If BMPText.Width > 0 then  dx := Pred(BMPText.Width)
  else dx := OutRect.Right - OutRect.Left;
  If BMPText.Height > 0 then dy := Pred(BMPText.Height)
  else dy := OutRect.Bottom - OutRect.Top;

  With OutRect do begin
    left   := scrx;
    top    := scry;
    right  := left + dx;
    bottom := top + dy;
    end;
  end;

procedure TGTextObj.Register4Dragging(DragList: TObjPtrList);
  begin
  If Self = ObjList.DraggedObj then
    DragList.Add(Self)
  else
    Inherited Register4Dragging(DragList);
  end;

procedure TGTextObj.SetIsMarked(flag: Boolean);
  var col2 : TColor;
  begin
  If flag <> IsMarked then
    If flag then
      If IsVisible then begin
        HideIt;
        col2 := MyColour;
        MyColour := ColorTable[7];
        FMyColour := col2;
        FStatus := FStatus or gs_IsMarked;
        DrawIt;
        end
      else
        FStatus := FStatus or gs_IsMarked
    else
      If IsVisible then begin
        HideIt;
        col2 := MyColour;
        FMyColour := ColorTable[7];
        MyColour := col2;
        FStatus := FStatus and Not gs_IsMarked;
        DrawIt;
        end
      else
        FStatus := FStatus and Not gs_IsMarked;
  end;

function TGTextObj.GetIsMoving: Boolean;
  begin
  Result := FStatus and gs_IsMoving <> 0;
  end;

procedure TGTextObj.SetIsMoving(flag: Boolean);
  begin
  If flag <> IsMoving then
    If flag then
      FStatus := FStatus or gs_IsMoving
    else
      FStatus := FStatus and Not gs_IsMoving;
  end;

procedure TGTextObj.SetNewRelativPos;
  begin
  TGeoObj(Parent[0]).SetNewNameParamsIn(Self);
  IsMoving := False;
  end;

function TGTextObj.GetHTMLText: String;
  begin
  Result := FHTMLText;
  end;

procedure TGTextObj.SetHTMLText(s: String);
  var SL : TStringList;
  begin
  FHTMLText := s;
  If Assigned(FormatText) then begin
    SL := TStringList.Create;
    try
      SL.Text := s;
      FormatText.SetHTMLText(SL, ObjList.StartFont);
    finally
      SL.Free;
    end;
    end;
  end;

function TGTextObj.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId = ccDragableObj) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGTextObj.Dist (xm, ym: Double): Double;
  var MPos : TPoint;
  begin
  ObjList.GetWinCoords(xm, ym, MPos.x, MPos.y);
  If PtInRect(OutRect, MPos) then
    LastDist := 0
  else
    LastDist := 1.0e300;
  Dist := LastDist;
  end;

function TGTextObj.IsNearMouse: Boolean;
  begin
  Result := DataValid and PtInRect(OutRect, ObjList.LastMousePos);
  end;

function TGTextObj.LoadMasks : Boolean;
  var CopyRect : TRect;
  begin
  try
    With CopyRect do begin
      left := 0; top := 0;
      right := BMPText.Width;
      bottom := BMPText.Height;
      end;
    With BMPTextOR do begin
      Width := BMPText.Width;
      Height := BMPText.Height;
      Canvas.Brush.Color := clBlack;
      Canvas.CopyMode := cmSrcCopy;
      Canvas.BrushCopy(CopyRect, BMPText, CopyRect, clWhite);
      end;
    With BMPTextAND do begin
      Width:= BMPText.Width;
      Height:= BMPText.Height;
      Canvas.Brush.Color := clWhite;
      Canvas.CopyMode := cmSrcInvert;
      Canvas.BrushCopy(CopyRect, BMPText, CopyRect, clWhite);
      end;
    Result := True;
  except
    Result := False;
  end; { of try }
  end;

function TGTextObj.GetRenderWin: TRect;
  begin
  Result := OutRect;
  With Result do begin
    right := left + RenderWin.X + 8;
    bottom := top + RenderWin.Y + 8;
    end;
  end;

function TGTextObj.GetFontScale(Canvas: TCanvas): Double;
  var SL  : TStringList;
      R   : TRect;
      FT  : TFormatText;
      res : Double;
  begin
  SL := TStringList.Create;
  try
    SL.Text  := HTMLText;
    R        := OutRect;
    FT  := TFormatText.Create(SL, R, Canvas);
    try
      res := FT.NewDisplayFactor;
    finally
      FT.Free;
    end;
  finally
    SL.Free;
  end;
  Result := res;
  end;

procedure TGTextObj.RenderHTML2BMP;
  var SL        : TStringList;
      RenderBMP : TBitmap;
      R         : TRect;
      n, i      : Integer;
  begin
  Assert(BMPText <> Nil, 'BMPText = Nil!');
  SL := TStringList.Create;
  try
    SL.Add(HTMLText);
          If Not Assigned(FormatText) then
            FormatText := TFormatText.Create(sl, OutRect, ObjList.FTargetCanvas)
          else
            FormatText.SetHTMLText(sl, ObjList.StartFont);
          R := rect(0, 0, RenderWin.X, RenderWin.Y);
          RenderBMP := TBitmap.Create;
          try
            try
              { Der folgende Code stellt sicher, dass die erste Zeile nicht nur
          Leerzeichen oder gar keine Zeichen enthält. }
        Repeat     // 21.04.05: neu geschrieben !!!
          n := FormatText.CharactersInLine(0);
          If n > 0 then begin
            For i := Pred(n) downto 0 do
              If FormatText.GetLine(0).GetCharacter(i).Character < ' ' then
                FormatText.Delete(Point(i, 0));
            n := FormatText.CharactersInLine(0);
            end;
          If (n = 0) and (FormatText.Lines > 1) then
            FormatText.Merge(0);
        until (n > 0) or (FormatText.Lines = 1);

        { Bitmap vorbereiten }
        If (RenderWin.X <= 0) and (RenderWin.Y <= 0) then begin
          n := FormatText.GetWidth;
          If n > RenderWin.X - 10 then begin
            RenderWin.X := n + 10;
            R.Right := n + 10;
            end;
          n := FormatText.GetHeight;
          If n > RenderWin.Y - 6 then begin
            RenderWin.Y := n + 6;
            R.Bottom := n + 6;
            end;
          end;
        FormatText.SetClientRect(R);

        With RenderBMP do begin
          Width  := RenderWin.X;
          Height := RenderWin.Y;
          end;
        With RenderBMP.Canvas do begin
          Brush.Style := bsSolid;
          Brush.Color := ObjList.BackgroundColor;
          Pen.Color   := Brush.Color;
          FillRect(R);
          end;

        { Rendern }
        FormatText.Canvas := RenderBMP.Canvas;
        FormatText.Paint(False);    // Eingestellte Fontgrößen verwenden !
        CopyReducedBitmap(RenderBMP, BMPText);
        With OutRect do begin
          right := left + BMPText.Width;
          bottom := top + BMPText.Height;
          end;
      finally
        FormatText.Canvas := ObjList.FTargetCanvas;
      end;
    finally
      RenderBMP.Free;
    end;
  finally
    SL.Free;
  end;

  ReplaceColorShades(BMPText, ObjList.BackgroundColor, clBlack, FMyColour);
  DataValid := LoadMasks;
  end;

procedure TGTextObj.GetDataFrom(SEdit: TFormatEdit);
  begin
  Assert(SEdit <> Nil, 'FormatEdit-Parameter ist NIL !');
  If Assigned(FormatText) then
    FormatText.Canvas := SEdit.Canvas
  else
    FormatText := TFormatText.Create(Nil, OutRect, SEdit.Canvas);
  HTMLText    := SEdit.HTMLTextAsString;
  RenderWin.X := OutRect.Right - OutRect.Left;     { RenderWin-Dimensionierung }
  RenderWin.Y := OutRect.Bottom - OutRect.Top;     {    ergänzt am 09.04.06    }
  RenderHTML2BMP;   // 24.03.06:  geändert wg. Bug-Meldung
//  Bug-Meldung von Mag. Stefan Scany wg. Renderfehlern bei
//  nicht-weißem Windows-Fenster-Hintergrund
  DataCanShow := DataValid;
  UpdateParams;  { setzt OutRect !!!  (03.12.99) }
  ObjList.IsDirty := True;
  end;

procedure TGTextObj.UpdateParams;
  { *Vor* jedem Aufruf muß die UpdateParams-Methode des
    jeweils aktuellen Objekttyps aufgerufen werden, damit
    (scrx|scry) sowie (X|Y) korrekt gesetzt werden.   }
  begin
  DataValid := True;
  If IsMoving then begin
    scrx := ObjList.LastMousePos.X - x_Offset;
    scry := ObjList.LastMousePos.Y - y_Offset;
    ObjList.GetLogCoords(scrx, scry, X, Y);
    end
  else
    If Parent.Count > 0 then
      TGeoObj(Parent[0]).UpdateNameCoordsIn(Self);
  UpdateScreenCoords;
  end;

procedure TGTextObj.UpdateScreenCoords;
  var R  : TRect;
  begin
  ObjList.GetWinCoords(X, Y, scrx, scry);
  try
    With OutRect do begin
      left   := scrx;
      top    := scry;
      right  := left + Round(BMPText.Width  * ObjList.ScaleFactor);
      bottom := top  + Round(BMPText.Height * ObjList.ScaleFactor);
      end;
    DataCanShow := IntersectRect(R, ObjList.WindowRect, OutRect);
  except
    DataValid := False;
  end; { of try }
  end;

procedure TGTextObj.AdjustGraphTools(todraw : Boolean);
  begin
  Inherited AdjustGraphTools(todraw);
  With ObjList.TargetCanvas do
    If toDraw then begin
      Brush.Style := bsClear;
      Font.Assign(ObjList.StartFont);
      If ShowsOnlyNow then
        Font.Color := ColorTable[1]
      else
        Font.Color := MyColour;
      end
    else begin
      Brush.Style := bsSolid;
      Brush.Color := ObjList.BackGroundColor;
      end;
  end;

procedure TGTextObj.DrawIt;
  var CM : TCopyMode;
  begin
  If IsVisible then with ObjList.TargetCanvas do begin
    AdjustGraphTools(True);
    CM := CopyMode;
    CopyMode := cmSrcAnd;
    Draw(OutRect.left, OutRect.top, BMPTextAND);
    CopyMode := cmSrcPaint;
    Draw(OutRect.Left, OutRect.top, BMPTextOR);
    CopyMode := CM;
    end;
  end;

procedure TGTextObj.HideIt;
  begin
  If FStatus and gs_IsVisible > 0 then with ObjList.TargetCanvas do begin
    AdjustGraphTools(False);
    FillRect(OutRect);
    end;
  end;

procedure TGTextObj.ExportIt;
  var SL   : TStringList;
      FT   : TFormatText;
      R    : TRect;
      sf   : Double;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    UpdateScreenCoords;
    SL := TStringList.Create;
    try
      SL.Text  := HTMLText;
      R        := OutRect;
      R.Right  := R.Left + Round(RenderWin.X * 1.04 * ObjList.ScaleFactor);
      R.Bottom := R.Top + Round(RenderWin.Y * 1.04 * ObjList.ScaleFactor);
      FT := TFormatText.Create(SL, R, ObjList.TargetCanvas);
      try
        Case ObjList.OutputStatus of
          outPrinter : sf := prn_UserScaleF;
          outPreview : sf := ObjList.ScaleFactor;
        else
          sf := 1;
        end;
        If Abs(sf - 1) > 1e-5 then
          FT.SetDisplayFactor(sf);
        FT.PaintTransparent(R, MyColour, True);
      finally
        FT.Free;
      end;
    finally
      SL.Free;
    end;
    end;
  end;


procedure TGTextObj.HideDisplay;
  begin
  HideIt;
  If Assigned(BMPTextAND) then with BMPTextAND do begin
    Width := 0;
    Height := 0;
    end;
  If Assigned(BMPTextOR) then with BMPTextOR do begin
    Width := 0;
    Height := 0;
    end;
  DataCanShow := False;
  end;

procedure TGTextObj.InitMoving(xm, ym: Integer);
  begin
  IsMoving := True;
  ObjList.LastMousePos := Point(xm, ym);
  end;

procedure TGTextObj.MoveIt;
  begin
  scrx := ObjList.LastMousePos.X - x_Offset;
  scry := ObjList.LastMousePos.Y - y_Offset;
  ObjList.GetLogCoords(scrx, scry, X, Y);
  UpdateScreenCoords;
  end;

{-------------------------------------------}
{ TGName's Methods Implementation           }
{-------------------------------------------}

constructor TGName.Create(iObjList: TGeoObjListe; iGO: TGeoObj; irConst, isConst: Double);
  var SL : TStringList;
  begin
  Inherited Create(iObjList, False);
  BecomesChildOf(iGO);
  iGO.FStatus := iGO.FStatus or gs_HasNameObj;
  If (iGO is TGPolygon) or
     (Not SynchronizeCols) then
    FMyColour := clBlack
  else
    FMyColour := iGO.MyColour;
  FHTMLText := iGO.GetFormattedName;
  SL := TStringList.Create;
  try
    SL.Add(HTMLText);
    FormatText := TFormatText.Create(SL, OutRect, ObjList.TargetCanvas);
  finally
    SL.Free;
  end;
  rConst   := irConst;
  sConst   := isConst;
  TGeoObj(Parent[0]).UpdateNameCoordsIn(Self);
  x_Offset := 0;
  y_Offset := 0;
  FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  { Keine Anzeige, da noch keine BMPs vorhanden ! }
  end;

constructor TGName.Load(S: TFileStream; iObjList: TGeoObjListe);
  begin
  Inherited Load(S, iObjList);
  S.Read(X, SizeOf(X));
  S.Read(Y, SizeOf(Y));
  S.Read(rConst, SizeOf(rConst));
  S.Read(sConst, SizeOf(sConst));
  With OutRect do begin
    left   := ReadOldIntFromStream(S);  { unbrauchbare Dummies einlesen }
    top    := ReadOldIntFromStream(S);
    right  := ReadOldIntFromStream(S);
    bottom := ReadOldIntFromStream(S);
    end;
  x_Offset  := 0;
  y_Offset  := 0;
  RenderWin := NameRenderWin;
  DataCanShow := True;
  end;

constructor TGName.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  RenderWin := NameRenderWin;
  end;

constructor TGName.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  RenderWin := NameRenderWin;
  end;

procedure TGName.RebuildPointers;
  { 12.10.2006 :   Rekonstruktion der Children-Listen aus den Parent-Listen;
                   spart die Notwendigkeit des Abspeicherns der eigentlich
                   redundanten Children-Listen ein.
    13.11.2006 :   Namen müssen in der Children-Liste des Eltern-Objekts
                   immer ganz nach vorne!                                   }
  var i : Integer;
  begin
  Parent.ResolveGeoNums(ObjList);
  For i := 0 to Pred(Parent.Count) do
    TGeoObj(Parent[i]).Children.Insert(0, Self);
  end;


procedure TGName.AfterLoading(FromXML: Boolean);
  begin
  If Length(HTMLText) = 0 then begin  // Patch für alte 1.x-Daten !!!
    HTMLText := TGeoObj(Parent[0]).Name;             // Inhalt holen
    rConst := 0.5;                                   // Auf neue Standard-
    sConst := 0.0;                                   //   Werte setzen
    ObjList.GetLogCoords(Round(X), Round(Y), X, Y);  // User-Koordinaten !
    end;
  Inherited AfterLoading(FromXML);
  If IsZero(rConst, epsilon) and
     IsZero(sConst, epsilon) and
     (Parent.Count > 0) then begin
    TGeoObj(Parent[0]).SetNewNameParamsIn(Self);
    TGeoObj(Parent[0]).FStatus := TGeoObj(Parent[0]).FStatus or gs_HasNameObj;
    end;
  end;


procedure TGName.BecomesChildOf (GO: TGeoObj);
  { überschreibt die TGeoObj-Methode, weil Namen stets als erste in der Children-
    Liste aufgeführt werden müssen, daher "Insert(0,...)" statt "Add(...)" }
  begin
  GO.Children.Insert(0, Self);
  Parent.Add(GO);
  end;


procedure TGName.VirtualizeCoords;
  { Kein(!) Aufruf von Inherited VirtualizeCoords!
    Was das zu tun hätte, wird für Textobjekte
    effektiv schon beim Laden erledigt !!! }
  begin
  TGeoObj(Parent[0]).SetNewNameParamsIn(Self);
  end;


procedure TGName.AddToGroup(GroupMask: Integer);
  begin
  If (TGeoObj(Parent[0]).Groups and GroupMask) = 0 then
    FGroups := FGroups or GroupMask;
  end;


procedure TGName.UpdateParams;
  begin
  If ObjList.IsLoading then Exit;
  DataValid := TGeoObj(Parent[0]).DataValid;
  If DataValid then begin
    If IsMoving then begin                            { Name verziehen      }
      scrx := ObjList.LastMousePos.X - x_Offset;
      scry := ObjList.LastMousePos.Y - y_Offset;
      ObjList.GetLogCoords(scrx, scry, X, Y);
      TGeoObj(Parent[0]).SetNewNameParamsIn(Self);
      end
    else
      if ObjList.DraggedObj = ObjList[0] then         { Zeichnung als       }
        TGeoObj(Parent[0]).SetNewNameParamsIn(Self)   {  Ganzes verschieben }
      else
        TGeoObj(Parent[0]).UpdateNameCoordsIn(Self);  { was anderes ziehen  }
    UpdateScreenCoords;
    end
  else
    DataValid := False;
  end;


procedure TGName.UpdateScreenCoords;
  begin
  Inherited UpdateScreenCoords;
  If Not DataCanShow then
    DataCanShow := TGeoObj(Parent[0]).ShowDataInNameObj or (Length(FHTMLText) > 0);
  end;

procedure TGName.DrawIt;

  function AddHTMLFontInfoTo(s: String; fname: String; fsize: Integer): String;
    begin
    If Length(s) > 0 then begin
      s := '<font face="' + fname + '" size="' + IntToStr(fsize) + '">' +
           s + '</font>';
      Result := s;
      end
    else
      Result := '';
    end;

  var s : String;
      PO : TGeoObj;
  begin
  If IsVisible then begin
    PO := TGeoObj(Parent[0]);
    If PO.ShowDataInNameObj then begin
      AdjustGraphTools(True);
      if PO.ShowNameInNameObj then
        s := HTMLText + ' '
      else
        s := '';
      s := s + TGeoObj(Parent[0]).GetDataStr;
      draw_htmlText_on(ObjList.TargetCanvas, OutRect.Left, OutRect.Top, s);
      OutRect.Right := ObjList.TargetCanvas.PenPos.X;
      OutRect.Bottom := OutRect.Top + ObjList.TargetCanvas.TextHeight(s);
      end { of if }
    else begin
      If BMPTextAND.Width * BMPTextOR.Width = 0 then begin
        If Length(HTMLText) = 0 then
          HTMLText := AddHTMLFontInfoTo(Name, ObjList.StartFont.Name, ObjList.StartFont.Size);
        RenderHTML2BMP;
        end;
      Inherited DrawIt;
      end;
    ExportRect := OutRect;
    end;
  end;

procedure TGName.HideIt;
  begin
  Inherited HideIt;
  end;

procedure TGName.ExportIt;
  var SL   : TStringList;
      FT   : TFormatText;
      R    : TRect;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    UpdateScreenCoords;
    SL := TStringList.Create;
    try
      If TGeoObj(Parent[0]).ShowDataInNameObj then
        SL.Add(HTMLText + ' ' + TGeoObj(Parent[0]).GetDataStr)
      else
        SL.Text := HTMLText;
      R.Left := scrx;
      R.Top  := scry;
      R.Right  := scrx + Round((ExportRect.Right - ExportRect.Left) * 1.04 * ObjList.ScaleFactor);
      R.Bottom := scry + Round((ExportRect.Bottom - ExportRect.Top) * 1.04 * ObjList.ScaleFactor);
      FT := TFormatText.Create(SL, R, ObjList.TargetCanvas);
      try
        FT.PaintTransparent(R, MyColour, True);
      finally
        FT.Free;
      end;
    finally
      SL.Free;
    end;
    end;
  end;

procedure TGName.SetIsGrouped(flag: Boolean);
  begin
  If IsGrouped <> flag then
    If flag then
      FStatus := FStatus or gs_IsGrouped
    else
      FStatus := FStatus and Not gs_IsGrouped;
  end;

procedure TGName.SetShowsAlways(nv: Boolean);
  begin
  Inherited SetShowsAlways(nv);
  If Not ShowsAlways then
    TGeoObj(Parent[0]).ShowDataInNameObj := False;
  end;

procedure TGName.InitMoving(xm, ym: Integer);
  begin
  Inherited InitMoving(xm, ym);
  x_Offset  := xm - scrx;
  y_Offset  := ym - scry;
  end;

procedure TGName.Invalidate;
  begin
  Inherited Invalidate;
  With TGeoObj(Parent[0]) do
    FStatus := FStatus and Not gs_HasNameObj;
  end;

procedure TGName.Revalidate;
  begin
  With TGeoObj(Parent[0]) do
    FStatus := FStatus or gs_HasNameObj;
  UpdateParams;
  If IsVisible then
    DrawIt;
  end;

procedure TGName.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  menu.Items.Clear;    { "Free"d auch die einzelnen Items ! }
  AddPopupMenuItemTo(menu, cme_namhide, CME_PopupClick, cmd_ToggleVis);
  AddPopupMenuItemTo(menu, cme_namedit, CME_PopupClick, cmd_NameObj);
  AddPopupMenuItemTo(menu, cme_col, CME_PopupClick, cmd_EditColour);
  end;

function TGName.DefaultName: WideString;
  begin
  DefaultName := ObjList.GetUniqueName('Name');
  end;

function TGName.GetIsVisible: Boolean;
  begin
  Result := Inherited GetIsVisible and
            TGeoObj(Parent[0]).IsVisible and
            (TGeoObj(Parent[0]).ShowDataInNameObj or
             TGeoObj(Parent[0]).ShowNameInNameObj) ;
  end;

function TGName.GetInfo: String;
  begin
  Result := MyObjTxt[16];
  InsertNameOf(TGeoObj(Parent[0]), Result);
  end;

destructor TGName.Destroy;
  begin
  If Parent.Count > 0 then
    with TGeoObj(Parent[0]) do begin
      FStatus := FStatus and Not gs_HasNameObj;
      FShowDataInNameObj := False;
      FShowNameInNameObj := False;
      end;
  Inherited Destroy;
  end;


{-------------------------------------------}
{ TGDistLine's Methods Implementation       }
{-------------------------------------------}

constructor TGDistLine.Create(iObjList: TGeoObjListe; iObj1, iObj2: TGeoObj; iis_visible: Boolean);
  var i  : Integer;
  begin
  Inherited Create(iObjList, iis_visible);
  If (iObj1 <> Nil) and (iObj2 <> Nil) then begin
    If iObj2.IsPriorTo(iObj1.ClassType) then begin  { Hier wird sichergestellt, daß der Typ  }
      BecomesChildOf(iObj2);                   { von Parent[1] nicht kleiner als der    }
      BecomesChildOf(iObj1);                   { von Parent[0] ist.                     }
      end
    else begin
      BecomesChildOf(iObj1);
      BecomesChildOf(iObj2);
      end;
    If Parent.Count = 2 then
      For i := 1 to 2 do
        If TGeoObj(Parent[Pred(i)]) is TGCircle then TypComp[i] := ccCircle else
        If TGeoObj(Parent[Pred(i)]) is TGStraightLine then TypComp[i] := ccStraightLine else
        If TGeoObj(Parent[Pred(i)]) is TGPoint then TypComp[i] := ccAnyPoint;
    FMyColour := clBlack;
    MyPenStyle := psDot;
    MyLineWidth := 1;
    dx := 0;
    dy := 0;
    x_Offset := 0;
    y_Offset := 0;
    FName := GetName;
    UpdateParams;
    DrawIt;
    end;
  end;

constructor TGDistLine.Load (S: TFileStream; iObjList: TGeoObjListe);
  var i : Integer;
  begin
  Inherited Load(S, iObjList);
  S.Read(X, SizeOf(X));
  S.Read(Y, SizeOf(Y));
  S.Read(rConst, SizeOf(rConst));
  S.Read(sConst, SizeOf(sConst));
  With OutRect do begin
    left   := ReadOldIntFromStream(S);
    top    := ReadOldIntFromStream(S);
    right  := ReadOldIntFromStream(S);
    bottom := ReadOldIntFromStream(S);
    end;
  x_Offset := 0;
  y_Offset := 0;
  For i := 1 to 2 do
    TypComp[i] := ReadOldIntFromStream(S);
  S.Read(value, SizeOf(value));
  S.Read(X1, SizeOf(X1));
  S.Read(Y1, SizeOf(Y1));
  S.Read(X2, SizeOf(X2));
  S.Read(Y2, SizeOf(Y2));
  S.Read(dx, SizeOf(dx));
  S.Read(dy, SizeOf(dy));
  end;

constructor TGDistLine.Load32(R: TReader; iObjList: TGeoObjListe);
  var i : Integer;
  begin
  Inherited Load32(R, iObjList);
  For i := 1 to 2 do
    TypComp[i] := R.ReadInteger;
  value := R.ReadFloat;
  X1 := R.ReadFloat;
  Y1 := R.ReadFloat;
  X2 := R.ReadFloat;
  Y2 := R.ReadFloat;
  dx := R.ReadFloat;
  dy := R.ReadFloat;
  end;

constructor TGDistLine.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);

  With DE.childNodes.findNode('line', '') do begin
    X1 := StrToFloat(getAttribute('x1'));
    Y1 := StrToFloat(getAttribute('y1'));
    X2 := StrToFloat(getAttribute('x2'));
    Y2 := StrToFloat(getAttribute('y2'));
    dx := StrToFloat(getAttribute('dx'));
    dy := StrToFloat(getAttribute('dy'));
    end;
  end;

function TGDistLine.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var line : IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  line := DOMDoc.createNode('line');
  line.setAttribute('x1', FloatToStr(X1));
  line.setAttribute('y1', FloatToStr(Y1));
  line.setAttribute('x2', FloatToStr(X2));
  line.setAttribute('y2', FloatToStr(Y2));
  line.setAttribute('dx', FloatToStr(dx));
  line.setAttribute('dy', FloatToStr(dy));
  Result.childNodes.add(line);
  end;

procedure TGDistLine.AfterLoading(FromXML : Boolean);
  var GO : TGeoObj;
      i  : Integer;
  begin
  Inherited AfterLoading(FromXML);
  FName := GetName;                    // Eventuelle HTML-Tags wiederherstellen
  If ClassType = TGDistLine then begin // also *nicht* für TGAngleWidth-Objekte
    TypComp[1] := 0;
    TypComp[2] := 0;
    For i := 1 to Parent.Count do begin
      GO := Parent.Items[i-1];
      If GO <> Nil then
        If GO is TGCircle then TypComp[i] := ccCircle else
        If GO is TGStraightLine then TypComp[i] := ccStraightLine else
        If GO is TGPoint then TypComp[i] := ccAnyPoint;
      end;
    If Parent.Count < 2 then
      TypComp[2] := TypComp[1];
    end;
  end;

function TGDistLine.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId = ccMeasureObj) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGDistLine.Dist(xm, ym: Double): Double;
  var MPos : TPoint;
  begin
  ObjList.GetWinCoords(xm, ym, MPos.X, MPos.Y);
  If PtInRect(OutRect, MPos) then
    LastDist := 0
  else
    LastDist := 1.0e300;
  Dist := LastDist;
  end;

procedure TGDistLine.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  var i : Integer;
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  FName := GetName;
  If ClassType = TGDistLine then   { 05.02.00 ergänzt: deaktiviert diesen }
    For i := 1 to 2 do             {            Teil für alle Nachkommen! }
      If TGeoObj(Parent[Pred(i)]) is TGCircle then TypComp[i] := ccCircle else
      If TGeoObj(Parent[Pred(i)]) is TGStraightLine then TypComp[i] := ccStraightLine else
      If TGeoObj(Parent[Pred(i)]) is TGPoint then TypComp[i] := ccAnyPoint;
  end;

procedure TGDistLine.SaveState;
  begin
  Inherited SaveState;
  With Old_Data do begin
    push(@X1, SizeOf(X1));
    push(@Y1, SizeOf(Y1));
    push(@X2, SizeOf(X2));
    push(@Y2, SizeOf(Y2));
    push(@dx, SizeOf(dx));
    push(@dy, SizeOf(dy));
    push(@sx1, SizeOf(sx1));
    push(@sy1, SizeOf(sy1));
    push(@sx2, SizeOf(sx2));
    push(@sy2, SizeOf(sy2));
    push(@rConst, SizeOf(rConst));
    push(@sConst, SizeOf(sConst));
    push(@value, SizeOf(value));
    push(@OutRect, SizeOf(OutRect));
    push(@_xm, SizeOf(_xm));
    push(@_ym, SizeOf(_ym));
    push(@_xn, SizeOf(_xn));
    push(@_yn, SizeOf(_yn));
    push(@_xs1, SizeOf(_xs1));
    push(@_ys1, SizeOf(_ys1));
    push(@_xs2, SizeOf(_xs2));
    push(@_ys2, SizeOf(_ys2));
    pushStr(_pu);
    push(@_valid1, SizeOf(_valid1));
    push(@_valid2, SizeOf(_valid2));
    end;
  end;

procedure TGDistLine.RestoreState;
  begin
  With Old_Data do begin
    pop(@_valid2);
    pop(@_valid1);
    popStr(_pu);
    pop(@_ys2);
    pop(@_xs2);
    pop(@_ys1);
    pop(@_xs1);
    pop(@_yn);
    pop(@_xn);
    pop(@_ym);
    pop(@_xm);
    pop(@OutRect);
    pop(@value);
    pop(@sConst);
    pop(@rConst);
    pop(@sy2);
    pop(@sx2);
    pop(@sy1);
    pop(@sx1);
    pop(@dy);
    pop(@dx);
    pop(@Y2);
    pop(@X2);
    pop(@Y1);
    pop(@X1);
    end;
  Inherited RestoreState;
  end;

procedure TGDistLine.UpdateParams;
  var P1, P2    : TGeoObj;
      pGP       : TGPoint;
      pGL, pGL2 : TGStraightLine;
      pGC, pGC2 : TGCircle;
      d_x, d_y,
      d_r       : Double;
  begin
  If IsMoving then
    MoveIt
  else begin
    If Parent.Count < 2 then Exit;
    P1 := TGeoObj(Parent[0]);
    P2 := TGeoObj(Parent[1]);
    If (P1 = Nil) or (P2 = Nil) or
       (Not P1.DataValid) or
       (Not P2.DataValid) then
      DataValid := False
    else begin
      DataValid := True;
      If TypComp[1] = ccAnyPoint then begin      { Das 1. Objekt ist ein Punkt:         }
        pGP := TGPoint(P1);
        X1  := pGP.X;
        Y1  := pGP.Y;
        If TypComp[2] = ccAnyPoint then begin        { Das 2. Objekt ist ein Punkt....  }
          pGP := TGPoint(P2);
          X2  := pGP.X;
          Y2  := pGP.Y;
          end
        else
          if TypComp[2] = ccStraightLine then begin      { ..... oder eine gerade Linie...  }
            pGL := TGStraightLine(P2);
            DataValid := GetPedalPoint(pGL.X1, pGL.Y1, pGL.X2, pGL.Y2, X1, Y1, X2, Y2);
            end
          else
            if TypComp[2] = ccCircle then begin    { ..... oder ein Kreis.            }
              pGC := TGCircle(P2);
              d_x := pGP.X - pGC.X1;
              d_y := pGP.Y - pGC.Y1;
              d_r := Sqrt(Sqr(d_x) + Sqr(d_y));
              If d_r >= DistEpsilon then begin
                d_r := pGC.Radius / d_r;
                X2  := pGC.X1 + d_x * d_r;
                Y2  := pGC.Y1 + d_y * d_r;
                end
              else begin
                X2 := pGC.X1 + pGC.Radius;
                Y2 := pGC.Y1;
                end;
              end
        end
      else
        if TypComp[1] = ccStraightLine then begin    { Das 1. Objekt ist eine gerade Linie: }
          pGL := TGStraightLine(P1);
          If TypComp[2] = ccStraightLine then begin      { Das 2. Objekt ist eine gerade Linie.... }
            pGL2 := TGStraightLine(P2);
            If Not are_parallel (pGL.X1,  pGL.Y1,  pGL.X2,  pGL.Y2,
                                 pGL2.X1, pGL2.Y1, pGL2.X2, pGL2.Y2) then
              DataValid := False
            else
              DataValid := GetPedalPoint (pGL.X1, pGL.Y1, pGL.X2, pGL.Y2,
                                ObjList.xCenter, ObjList.yCenter, X1, Y1) and
                           GetPedalPoint (pGL2.X1, pGL2.Y1, pGL2.X2, pGL2.Y2,
                                X1, Y1, X2, Y2);
            end
          else
            if TypComp[2] = ccCircle then begin     { ..... oder ein Kreis.                   }
              pGC := TGCircle(P2);
              If GetPedalPoint (pGL.X1, pGL.Y1, pGL.X2,
                                pGL.Y2, pGC.X1, pGC.Y1, X1, Y1) then begin
                d_x := X1 - pGC.X1;
                d_y := Y1 - pGC.Y1;
                d_r := Sqrt(Sqr(d_x) + Sqr(d_y));
                If d_r >= pGC.Radius then begin
                  d_r := pGC.Radius / d_r;
                  X2  := pGC.X1 + d_x * d_r;
                  Y2  := pGC.Y1 + d_y * d_r;
                  end
                else
                  DataValid := False;
                end
              else
                DataValid := False;
              end
          end
        else
          if TypComp[1] = ccCircle then begin  { Das 1. Objekt ist ein Kreis, das 2. auch !  }
            pGC  := TGCircle(P1);
            pGC2 := TGCircle(P2);
            d_x := pGC2.X1 - pGC.X1;
            d_y := pGC2.Y1 - pGC.Y1;
            d_r := Sqrt(Sqr(d_x) + Sqr(d_y));
            If (d_r >= pGC.Radius + pGC2.Radius) then begin      { Jeder Kreis liegt im Äußeren des anderen oder... }
              d_r := pGC.Radius / d_r;
              X1  := pGC.X1 + d_x * d_r;
              Y1  := pGC.Y1 + d_y * d_r;
              d_r := d_r * pGC2.Radius / pGC.Radius;
              X2  := pGC2.X1 - d_x * d_r;
              Y2  := pGC2.Y1 - d_y * d_r;
              end
            else
            If (d_r <= Abs(pGC.Radius - pGC2.Radius)) then begin { ein Kreis liegt im Innern des anderen oder...    }
              If Abs(d_r) < DistEpsilon then begin
                d_x := 1.0;
                d_y := 0.0;
                d_r := 1.0;
                end
              else
                If pGC.Radius < pGC2.Radius then
                  d_r := - d_r;
              d_r := pGC.Radius / d_r;
              X1  := pGC.X1 + d_x * d_r;
              Y1  := pGC.Y1 + d_y * d_r;
              d_r := d_r * pGC2.Radius / pGC.Radius;
              X2  := pGC2.X1 + d_x * d_r;
              Y2  := pGC2.Y1 + d_y * d_r;
              end
            else                                                   { es gibt keinen Abstand !                         }
              DataValid := False;
            end;
      end;
    value := Hypot(X2 - X1, Y2 - Y1);
    end;
  If DataValid then begin
    DataCanShow := (ObjList.LogWinKnows(X1, Y1) >= 0) or
                   (ObjList.LogWinKnows(X2, Y2) >= 0);
    UpdateScreenCoords;
    end;
  end;

procedure TGDistLine.UpdateScreenCoords;
  var TH, TW  : Integer;
  begin
  If DataCanShow then begin
    ObjList.GetWinCoords(X1, Y1, sx1, sy1);
    ObjList.GetWinCoords(X2, Y2, sx2, sy2);
    _xm := (sx1 + sx2) * 0.5;
    _ym := (sy1 + sy2) * 0.5;
    _xn := _xm + dx * ObjList.ScaleFactor;
    _yn := _ym + dy * ObjList.ScaleFactor;
    _pu := Float2Str(value, LengthDecimals);
    While _pu[1] = #32 do Delete(_pu, 1, 1);
    _pu := _pu + ObjList.LengthUnit;
    With OutRect, ObjList.TargetCanvas do begin
      Font.Assign(ObjList.StartFont);
      Font.Height := Round(ObjList.StartFont.Height * ObjList.ScaleFactor);
      TH  := TextHeight(_pu);
      TW  := TextWidth(_pu);
      left := Round(_xn) - TW Div 2 - 2;
      top  := Round(_yn) - TH Div 2 - 2;
      right  := left + TW + 4;
      bottom := top  + TH + 4;
      end;
    IntersectRectangleWithLine (OutRect, sx1, sy1, sx2, sy2,
                                _xs1, _ys1, _xs2, _ys2,
                                _valid1, _valid2);
    end;
  end;

procedure TGDistLine.SetMyColour(NewCol: TColor);
  begin
  FMyColour := NewCol;
  end;

procedure TGDistLine.SetIsMarked(flag: Boolean);
  var change   : Boolean;
      ChildObj : TGeoObj;
      i        : Integer;
  begin
  change := IsMarked <> flag;
  Inherited SetIsMarked(flag);
  If change then begin
    i := Pred(Children.Count);
    While i >= 0 do begin               { Kann nicht durch eine FOR-Schleife ersetzt werden ! }
      If i < Children.Count then begin
        ChildObj := TGeoObj(Children.Items[i]);
        If ChildObj.ClassType <> TGPoint then { Versuchsweise nur wirklich abhängige Objekte  }
          ChildObj.IsMarked := flag;          { markieren, keine nur gebundenen Basispunkte ! }
        end;
      Dec(i);
      end;
    ObjList.DrawFirstObjects(ObjList.LastValidObjIndex);
    end;
  end;

procedure TGDistLine.AdjustGraphTools(todraw : Boolean);
  begin
  Inherited AdjustGraphTools(todraw);
  With ObjList.TargetCanvas do begin
    Font.Assign(ObjList.StartFont);
    Font.Height := Round(ObjList.StartFont.Height * ObjList.ScaleFactor);
    If todraw then with ObjList.TargetCanvas do
      If ShowsOnlyNow then
        Font.Color := ColorTable[1]
      else
        Font.Color := Pen.Color
    else begin
      Font.Color := ObjList.BackgroundColor;
      Pen.Style := psSolid;
      Pen.Width := 5;
      end;
    end;
  end;

procedure TGDistLine.DrawIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    If _valid1 or _valid2 then begin
      If _valid1 then
        draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                     sx1, sy1, _xs1, _ys1, MyPenStyle);
      If _valid2 then
        draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                     sx2, sy2, _xs2, _ys2, MyPenStyle);
      end
    else begin
      draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                   sx1, sy1, sX2, sY2, MyPenStyle);
      MoveToRectBorder(OutRect, _xm, _ym, _xn, _yn);
      draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                   _xm, _ym, _xn, _yn, MyPenStyle);
      end;
    ObjList.TargetCanvas.TextOut(OutRect.left + 2, OutRect.top + 2, _pu);
    If ShowMeasuresFramed then with OutRect do
      draw_rectangle_on(ObjList.TargetCanvas, act_pixelPerXcm,
                        left, top, right, bottom, MyPenStyle);
    end;
  end;

procedure TGDistLine.HideIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    If _valid1 or _valid2 then begin
      If _valid1 then
        draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                     sx1, sy1, _xs1, _ys1, MyPenStyle);
      If _valid2 then
        draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                     sx2, sy2, _xs2, _ys2, MyPenStyle);
      end
    else begin
      draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                   sx1, sy1, sx2, sy2, MyPenStyle);
      draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                   _xm, _ym, _xn, _yn, MyPenStyle);
      end;
    With OutRect do
      ObjList.TargetCanvas.Rectangle(left, top, right, bottom);
    end;
  end;

procedure TGDistLine.ExportIt;
  begin
  UpdateScreenCoords;
  AdjustGraphTools(True);
  DrawIt;
  end;

procedure TGDistLine.InitMoving(xm, ym: Integer);
  begin
  IsMoving := True;
  x_Offset  := xm - Round((sx1 + sx2) * 0.5 + dx);
  y_Offset  := ym - Round((sy1 + sy2) * 0.5 + dy);
  end;

procedure TGDistLine.MoveIt;
  begin
  dx := ObjList.LastMousePos.X - Round((sx1 + sx2) * 0.5) -  x_Offset;
  dy := ObjList.LastMousePos.Y - Round((sy1 + sy2) * 0.5) -  y_Offset;
  end;

procedure TGDistLine.SetNewRelativPos;
  begin
  MoveIt;
  IsMoving := False;
  end;

function TGDistLine.GetValue(selector: Integer): Double;
  begin
  If selector = gv_val then
    Result := Value
  else
    Result := Inherited GetValue(selector);
  end;

function TGDistLine.GetName: WideString;
  var pu1, pu2 : WideString;
  begin
  pu1 := TGeoObj(Parent[0]).Name;
  If Parent.Count > 1 then
    pu2 := TGeoObj(Parent[1]).Name
  else
    pu2 := pu1;
  Result := 'd(' + pu1 + ';' + pu2 + ')';
  end;

procedure TGDistLine.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  menu.Items.Clear;    { "Free"d auch die einzelnen Items ! }
  AddPopupMenuItemTo(menu, cme_hide, CME_PopupClick, cmd_ToggleVis);
  AddPopupMenuItemTo(menu, cme_col, CME_PopupClick, cmd_EditColour);
  end;

function TGDistLine.GetInfo: String;
  begin
  Result := MyObjTxt[17];
  InsertNameOf(TGeoObj(Parent[0]), Result);
  If Parent.Count > 1 then
    InsertNameOf(TGeoObj(Parent[1]), Result)
  else
    InsertNameOf(TGeoObj(Parent[0]), Result);
  end;


{-------------------------------------------}
{ TGAngleWidth's Methods Implementation     }
{-------------------------------------------}

constructor TGAngleWidth.Create(iObjList: TGeoObjListe; iObj: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, iis_visible);
  BecomesChildOf(iObj);
  TypComp[1] := 0;
  TypComp[2] := 0;

  FMyColour  := clBlack;
  MyPenStyle := psDot;
  MyLineWidth := 1;
  dx :=  1.0;
  dy :=  0.5;
  x_Offset := 0;
  y_Offset := 0;
  FName := GetName;
  UpdateParams;
  DrawIt;
  end;

procedure TGAngleWidth.AfterLoading(FromXML: Boolean);
  begin
  Inherited AfterLoading(FromXML);
  If Not FromXML then begin  // Beim Import alter binärer GEO-Dateien:
    dx := dx / ObjList.e1x;
    dy := dy / ObjList.e2y;
    X1 := X + dx;
    Y1 := Y + dy;
    X2 := 0;
    Y2 := 0;
    end;
  end;

function TGAngleWidth.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId = ccAnyAngleObj) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

procedure TGAngleWidth.InsertMeasureInto(Target: TFormatEdit);
  var NO: TGName;
      s : String;
  begin
  If TGAngle(Parent[0]).HasNameObj(NO) then
    s := NO.HTMLText
  else
    s := WideString2HTMLString(TGAngle(Parent[0]).Name);
  Target.Paste('w(' + s + ')');
  end;

procedure TGAngleWidth.UpdateParams;
  var pA   : TGAngle;
      w, r : Double;
  begin
  If IsMoving then
    MoveIt
  else begin
    DataValid := False;
    pA := TGAngle(Parent[0]);
    If pA = Nil then Exit;
    If pA.DataValid then begin
      with pA do begin
        value  := Abs(Angle2 - Angle1);
        w := (Angle1 + Angle2) * 0.5;
        r := Radius * 0.66;
        end;
      X := pA.dpX[2] + r * cos(w);  // (X;Y) ist die "Mitte" des vom Winkel-
      Y := pA.dpY[2] + r * sin(w);  //     bogen umschlossenen Sektors
      X1 := X + dx;
      Y1 := Y + dy;
      DataValid := True;
      end;
    end;
  If DataValid then
    UpdateScreenCoords;
  end;

procedure TGAngleWidth.UpdateScreenCoords;
  var TH, TW: Integer;
  begin
  Inherited AdjustGraphTools(True);  { Setzt vor allem den Font ! }
  ObjList.GetWinCoords(X,  Y,  scrx, scry);
  ObjList.GetWinCoords(X1, Y1, sx1,  sy1 );
  _pu := Float2Str(value * 180 / pi, AngleDecimals);
  While _pu[1] = #32 do Delete(_pu, 1, 1);
  _pu := _pu + ObjList.AngleUnit;
  With OutRect, ObjList.TargetCanvas do begin
    Font.Assign(ObjList.StartFont);
    Font.Height := Round(ObjList.StartFont.Height * ObjList.ScaleFactor);
    TW := TextWidth(_pu);
    TH := TextHeight(_pu);
    left := sx1 - TW Div 2 - 2;
    top  := sy1 - TH Div 2 - 2;
    right  := left + TW + 4;
    bottom := top  + TH + 4;
    end;
  end;

procedure TGAngleWidth.DrawIt;

  procedure DrawLines (xa, ya, xb, yb : Double);
    var Pt       : TPoint;
    begin
    If ShowMeasuresFramed then with OutRect do
      draw_rectangle_on(ObjList.TargetCanvas, act_pixelPerXcm, left,  top, right, bottom, MyPenStyle);
    Pt.x := Round(xa);
    Pt.y := Round(ya);
    If Not PtInRect(OutRect, Pt) then begin
      MoveToRectBorder(OutRect, xa, ya, xb, yb);
      draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm, xa, ya, xb, yb, MyPenStyle);
      end;
    end;

  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    ObjList.TargetCanvas.TextOut(OutRect.left + 2, OutRect.Top + 2, _pu);
    DrawLines(scrx, scry, sx1, sy1);
    end;
  end;

procedure TGAngleWidth.HideIt;

  procedure DrawLines (xa, ya, xb, yb : Double);
    var Pt : TPoint;
    begin
    With ObjList.TargetCanvas, OutRect do begin
      Rectangle (left, top, right, bottom);
      Pt.x := Round(xa);
      Pt.y := Round(ya);
      If Not PtInRect(OutRect, Pt) then begin
        MoveToRectBorder(OutRect, xa, ya, xb, yb);
        draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm, xa, ya, xb, yb, MyPenStyle);
        end;
      end;
    end;

  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    DrawLines(scrx, scry, sx1, sy1);
    end;
  end;

procedure TGAngleWidth.InitMoving(xm, ym: Integer);
  begin
  IsMoving := True;
  x_Offset := xm - sx1;
  y_Offset := ym - sy1;
  end;

procedure TGAngleWidth.MoveIt;
  begin
  dx := (ObjList.LastMousePos.X - scrx - x_Offset)/ObjList.e1x;
  dy := (ObjList.LastMousePos.Y - scry - y_Offset)/ObjList.e2y;
  X1 := X + dx;
  Y1 := Y + dy;
  end;

function TGAngleWidth.GetValue(selector: Integer): Double;
  begin
  Case selector of
    gv_val : Result := Value;
  else
    Result := Inherited GetValue(selector);
  end; { of case }
  end;

function TGAngleWidth.GetName: WideString;
  var angle : TGeoObj;
      NO    : TGName;
  begin
  angle  := TGeoObj(Parent[0]);
  If Length(HTMLText) > 0 then
    Result := HTMLText
  else
    If angle.HasNameObj(NO) then
      Result := 'w(' + angle.Name + ')'
    else
      Result := 'w(' + TGeoObj(angle.Parent[0]).Name +
                 ';' + TGeoObj(angle.Parent[1]).Name +
                 ';' + TGeoObj(angle.Parent[2]).Name + ')';
  end;

function TGAngleWidth.GetFormattedName: String;
  var angle : TGeoObj;
      NO    : TGName;
  begin
  angle  := TGeoObj(Parent[0]);
  If Length(HTMLText) > 0 then
    Result := HTMLText
  else
    If angle.HasNameObj(NO) then
      Result := 'w(' + angle.GetFormattedName + ')'
    else
      Result := 'w(' + TGeoObj(angle.Parent[0]).GetFormattedName +
                 ';' + TGeoObj(angle.Parent[1]).GetFormattedName +
                 ';' + TGeoObj(angle.Parent[2]).GetFormattedName + ')';
  end;

function TGAngleWidth.GetInfo: String;
  var p0  : TGeoObj;
  begin
  Result := MyObjTxt[18];
  p0 := Parent[0];
  InsertNameOf(TGeoObj(p0.Parent[0]), Result);
  InsertNameOf(TGeoObj(p0.Parent[1]), Result);
  InsertNameOf(TGeoObj(p0.Parent[2]), Result);
  end;


{--------------------------------------------------}
{ TGAreaSize's method implementation               }
{--------------------------------------------------}

constructor TGAreaSize.Create(iObjList: TGeoObjListe; iObj: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, iObj, iis_visible);
  end;

procedure TGAreaSize.InsertMeasureInto(Target: TFormatEdit);
  var NO : TGName;
  begin
  If TGArea(Parent[0]).HasNameObj(NO) then
    Target.Paste('area(' + NO.HTMLText + ')')
  else
    Target.Paste('area(' + TGArea(Parent[0]).Name + ')');
  end;

procedure TGAreaSize.UpdateParams;
  var pA : TGParentObj;
  begin
  If IsMoving then
    MoveIt
  else begin
    DataValid := False;
    pA := TGeoObj(Parent[0]) as TGParentObj;
    If pA = Nil then Exit;
    If pA.DataValid then begin
      value := pA.GetValue(gv_area);
      X  := pA.GetValue(gv_x);
      Y  := pA.GetValue(gv_y);
      X1 := X + dx;
      Y1 := Y + dy;
      DataValid := True;
      end;
    end;
  If DataValid then
    UpdateScreenCoords;
  end;

procedure TGAreaSize.UpdateScreenCoords;
  var TH, TW: Integer;
  begin
  Inherited AdjustGraphTools(True);  { Setzt vor allem den Font ! }
  ObjList.GetWinCoords(X,  Y,  scrx, scry);
  ObjList.GetWinCoords(X1, Y1, sx1,  sy1 );
  _pu := Float2Str(value, AreaDecimals);
  While _pu[1] = #32 do Delete(_pu, 1, 1);
  _pu := #32 + _pu + ObjList.AreaUnit;
  With OutRect, ObjList.TargetCanvas do begin
    Font.Assign(ObjList.StartFont);
    Font.Height := Round(ObjList.StartFont.Height * ObjList.ScaleFactor);
    TW := TextWidth(_pu);
    TH := TextHeight(_pu);
    left := sx1 - TW Div 2 - 2;
    top  := sy1 - TH Div 2 - 2;
    right  := left + TW + 4;
    bottom := top  + TH + 4;
    end;
  end;

function TGAreaSize.GetName: WideString;
  begin
  Result := 'area(' + TGeoObj(Parent[0]).name + ')';
  end;

function TGAreaSize.GetInfo: String;
  begin
  Result := MyObjTxt[97];
  If TGeoObj(Parent[0]).Parent.Count = 1 then
    InsertNameOf(TGeoObj(TGeoObj(Parent[0]).Parent[0]), Result)
  else
    InsertNameOf(TGeoObj(Parent[0]), Result);
  end;



{--------------------------------------------------}
{ TGMiddlePt's method implementation               }
{--------------------------------------------------}

constructor TGMiddlePt.Create(iObjList: TGeoObjListe; iP1, iP2: TGeoObj; iis_visible : Boolean);
  { Falls für einen Streckenmittelpunkt die Endpunkte iP1 und iP2 der
    Elternstrecke zusammenfallen, liegt ungeschlechtliche Vermehrung vor:
    dann liegt der Mittelpunkt ebenfalls in diesem Punkt.
    27.01.07 : erweitert auf Mittelpunkte von Kreisen bzw.
               Mittelpunkte von Ellipsen bzw. Hyperbeln !
    24.07.10 : erweitert auf Mittelpunkte von Strecken mit expliziter Nennung
               der Elternstrecke als einzigem Elternobjekt !               }
  begin
  Inherited Create (iObjList, 0, 0, False);
  BecomesChildOf (iP1);         { Ist iP1 = iP2, wird nur dieser Punkt     }
  BecomesChildOf (iP2);         { nur einmal in der Parent-Liste vermerkt. }
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

procedure TGMiddlePt.UpdateParams;
  var p1, p2: TGeoObj;
  begin
  DataValid := False;
  p1 := TGeoObj(Parent[0]);
  If (p1 = Nil) or (Not p1.DataValid) then Exit;
  If p1 is TGPoint then begin    { Mittelpunkt zwischen 2 Punkten }
    If Parent.Count = 2 then
      p2 := TGPoint(Parent[1])
    else
      p2 := p1;                  { Bei ungeschlechtlicher Vermehrung ...        }
    If (p2 <> Nil) and p2.DataValid then begin
      X := (p1.X + p2.X) / 2.0;
      Y := (p1.Y + p2.Y) / 2.0;
      DataValid := True;
      end;
    end
  else if p1 is TGShortLine then begin   { Strecken-Mittelpunkt }
    X := ((p1 as TGShortLine).X1 + (p1 as TGShortLine).X2) / 2;
    Y := ((p1 as TGShortLine).Y1 + (p1 as TGShortLine).Y2) / 2;
    DataValid := True;
    end
  else if p1 is TGCircle then begin      { Kreis-Mittelpunkt }
    X := (p1 as TGCircle).X1;
    Y := (p1 as TGCircle).Y1;
    DataValid := True;
    end
  else if p1 is TGConic then begin       { Kegelschnitt-Mittelpunkt }
    if (p1 as TGConic).IsEllipse or (p1 as TGConic).IsHyperbel then begin
      X := (p1 as TGConic).GetValue(gv_x);
      Y := (p1 as TGConic).GetValue(gv_y);
      DataValid := True;
      end
    end;
  If DataValid then
    UpdateScreenCoords;
  end;

function TGMiddlePt.GetInfo: String;
  begin
  Result := '';
  If TGeoObj(Parent[0]) is TGPoint then begin
    Result := MyObjTxt[19];
    InsertNameOf(Self, Result);
    InsertNameOf(TGeoObj(Parent[0]), Result);
    If Parent.Count > 1 then    { Ungeschlechtliche Vermehrung möglich ! }
      InsertNameOf(TGeoObj(Parent[1]), Result)
    else
      InsertNameOf(TGeoObj(Parent[0]), Result);
    end
  else if TGeoObj(Parent[0]) is TGShortLine then begin
    Result := MyObjTxt[109];
    InsertNameOf(Self, Result);
    InsertNameOf(TGeoObj(Parent[0]), Result);
    end
  else if TGeoObj(Parent[0]) is TGCircle then begin
    Result := MyObjTxt[98];
    InsertNameOf(Self, Result);
    InsertNameOf(TGeoObj(Parent[0]), Result);
    end
  else if TGeoObj(Parent[0]) is TGConic then begin
    If TGConic(Parent[0]).IsEllipse then
      Result := MyObjTxt[99]
    else if TGConic(Parent[0]).IsHyperbel then
      Result := MyObjTxt[100];
    If Result <> '' then begin
      InsertNameOf(Self, Result);
      InsertNameOf(TGeoObj(Parent[0]), Result);
      end;
    end;
  end;


{--------------------------------------------------}
{ TGMirrorPt's method implementation               }
{--------------------------------------------------}

constructor TGMirrorPt.Create(iObjList: TGeoObjListe; iP1, iSyZ: TGeoObj; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, 0, 0, False);
  BecomesChildOf (iP1);
  BecomesChildOf (iSyZ);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

function TGMirrorPt.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGMirrorPt) and
            (GO.Parent.Count = Self.Parent.Count) and
            (GO.Parent[0] = Self.Parent[0]) and
            (GO.Parent[1] = Self.Parent[1]);
  end;

procedure TGMirrorPt.UpdateParams;
  var u, sz  : TGPoint;
      sa     : TGStraightLine;
      sk     : TGCircle;
      xm, ym,
      dx, dy,
      f      : Double;
  begin
  DataValid := False;
  u := TGPoint(Parent[0]);
  If (u <> Nil) and u.DataValid then
    If (Parent.Count > 1) and
       (TGeoObj(Parent[1]) is TGLine) then
      If TGeoObj(Parent[1]) is TGStraightLine then begin   { Spiegeln an einer Geraden }
        sa := TGStraightLine(Parent[1]);
        If sa.DataValid and
           GetPedalPoint (sa.X1, sa.Y1, sa.X2, sa.Y2, u.X, u.Y, xm, ym) then begin
          X := 2.0 * xm - u.X;
          Y := 2.0 * ym - u.Y;
          DataValid := True;
          end;
        end
      else begin                { Spiegeln an einem Kreis }
        sk := TGCircle(Parent[1]);
        If sk.DataValid and
           (sk.Radius > epsilon) then begin
          dx := u.X - sk.X1;
          dy := u.Y - sk.Y1;
          f  := Sqr(dx) + Sqr(dy);
          If f  > epsilon then begin
            f := Sqr(sk.Radius) / f;
            X := sk.X1 + f * dx;
            Y := sk.Y1 + f * dy;
            DataValid := True;
            end;
          end
        end
    else begin                  { Spiegeln an einem Punkt }
      If Parent.Count > 1 then
        sz := TGPoint(Parent[1])  { Bei geschlechtlicher oder auch ... }
      else
        sz := u;                  { ...ungeschlechtlicher Vermehrung ! }
      If sz.DataValid then begin
        X  := 2.0 * sz.X - u.X;
        Y  := 2.0 * sz.Y - u.Y;
        DataValid := True;
        end;
      end;
  UpdateScreenCoords;
  end;

function TGMirrorPt.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;


{--------------------------------------------------}
{ TGMovedPt's method implementation                }
{--------------------------------------------------}

constructor TGMovedPt.Create(iObjList: TGeoObjListe; iP1, iP2: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create (iObjList, 0, 0, False);
  BecomesChildOf (iP1);
  BecomesChildOf (iP2);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

function TGMovedPt.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  If GO.ClassType = TGMovedPt then
    Result := (Parent[0] = GO.Parent[0]) and
              (Parent[1] = GO.Parent[1])
  else
    Result := (GO is TGPoint) and
              (Parent[0] = TGeoObj(Parent[1]).Parent[0]) and
              (GO = TGeoObj(Parent[1]).Parent[1]);
  end;

procedure TGMovedPt.UpdateParams;
  begin
  If TGeoObj(Parent[0]).DataValid and
     TGeoObj(Parent[1]).DataValid then begin
    X := TGPoint(Parent[0]).X + TGVector(Parent[1]).dx;
    Y := TGPoint(Parent[0]).Y + TGVector(Parent[1]).dy;
    DataValid   := True;
    DataCanShow := ObjList.LogWinContains(X, Y);
    UpdateScreenCoords;
    end
  else
    DataValid := False;
  end;

function TGMovedPt.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;


{--------------------------------------------------}
{ TGRotatedPt's method implementation              }
{--------------------------------------------------}

constructor TGRotatedPt.Create(iObjList: TGeoObjListe; iUBP, iMP, iAO: TGeoObj; iis_visible : Boolean);
  begin
  Inherited Create (iObjList, 0, 0, False);
  BecomesChildOf(iUBP);     { UrbildPunkt }
  BecomesChildOf(iMP);      { Mittelpunkt }
  BecomesChildOf(iAO);      { Argument-Objekt}
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

function TGRotatedPt.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGRotatedPt) and
            (GO.Parent[0] = Parent[0]) and
            (GO.Parent[1] = Parent[1]) and
            (GO.Parent[2] = Parent[2]);
  end;

procedure TGRotatedPt.UpdateParams;
  var UBP, DP : TGPoint;
      rx, ry  : Double;
  begin
  If TGeoObj(Parent[0]).DataValid and            { Alle Eltern gültig }
     TGeoObj(Parent[1]).DataValid and
     TGeoObj(Parent[2]).DataValid then begin
    UBP := Parent[0];                                   { Urbildpunkt }
    DP  := Parent[1];                                   { Drehpunkt   }
    RotAngle := TGeoObj(Parent[2]).GetValue(gv_val);  { Drehwinkel  }
    rx := UBP.X - DP.X;
    ry := UBP.Y - DP.Y;
    RotateVector2ByAngle(rx, ry, RotAngle, rx, ry);
    X := DP.X + rx;
    Y := DP.Y + ry;
    DataValid := True;
    UpdateScreenCoords;
    end
  else
    DataValid := False;
  end;

function TGRotatedPt.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;


{--------------------------------------------------}
{ TGStretchedPt's method implementation            }
{--------------------------------------------------}

constructor TGStretchedPt.Create(iObjList: TGeoObjListe; iUBP, iZP,
  iSF: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, 0, 0, False);
  BecomesChildOf(iUBP);
  BecomesChildOf(iZP);
  BecomesChildOf(iSF);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

function TGStretchedPt.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGStretchedPt) and
            (GO.Parent[0] = Parent[0]) and
            (GO.Parent[1] = Parent[1]) and
            (GO.Parent[2] = Parent[2]);
  end;

function TGStretchedPt.GetInfo: String;
  begin
  Result := Format(MyObjTxt[25], [ClassName]);
  InsertNameOf(Self, Result);
  end;

procedure TGStretchedPt.UpdateParams;
  var UBP, SZ : TGPoint;
      rx, ry  : Double;
  begin
  DataValid := TGeoObj(Parent[0]).DataValid and         { Alle Eltern gültig }
               TGeoObj(Parent[1]).DataValid and
               TGeoObj(Parent[2]).DataValid;
  If DataValid then begin
    UBP := Parent[0];                                 { Urbildpunkt   }
    SZ  := Parent[1];                                 { Streckzentrum }
    SFactor := TGeoObj(Parent[2]).GetValue(gv_val);   { Streckfaktor  }
    rx := UBP.X - SZ.X;
    ry := UBP.Y - SZ.Y;
    X := SZ.X + SFactor * rx;
    Y := SZ.Y + SFactor * ry;
    UpdateScreenCoords;
    end;
  end;


{--------------------------------------------------}
{ TGDoublePt's method implementation               }
{--------------------------------------------------}

constructor TGDoublePt.Create(iObjList: TGeoObjListe; iS1, iS2: TGeoObj; iis_visible : Boolean);
  begin
  Inherited Create (iObjList, 0, 0, False);
  BecomesChildOf (iS1);
  BecomesChildOf (iS2);
  CheckParent3;
    { Nun ist Parent[0] eine gerade Linie oder ein Kreis,
              Parent[1] ist stets ein Kreis,
              Parent[2] enthält Nil oder einen gemeinsamen
                 Punkt von Parent[0] und Parent[1], sofern
                 es einen solchen schon gibt !               }
  Status2 := gs_Normal;
  tv1 := -1;
  tv2 := -2;
  If Not iis_visible then
    Status2 := Status2 and Not gs_ShowsAlways
  else
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

constructor TGDoublePt.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  If (GO <> Nil) and
     (TGDoublePt(GO).Status2 <> 0) then
    Status2 := TGDoublePt(GO).Status2
  else
    Status2 := gs_normal;
  end;

constructor TGDoublePt.Load(S: TFileStream; iObjList: TGeoObjListe);
  begin
  Inherited Load(S, iObjList);
  S.Read(X_2, SizeOf(X_2));
  S.Read(Y_2, SizeOf(Y_2));
  S.Read(Status2, SizeOf(Status2));
  end;

constructor TGDoublePt.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  X_2 := R.ReadFloat;
  Y_2 := R.ReadFloat;
  Status2 := Word(R.ReadInteger);
  If R.NextValue = vaExtended then begin
    tv1 := R.ReadFloat;
    tv2 := R.ReadFloat;
    CheckFloat(tv1, -1);
    CheckFloat(tv2, -2);
    end
  else begin
    tv1 := -1;
    tv2 := -2;
    end;
  end;

function TGDoublePt.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := Nil;
  end;

function TGDoublePt.IsIncidentWith(line: TGLine): Boolean;
  begin
  Result := (Parent.IndexOf(line) >= 0) or
            Inherited IsIncidentWith(line);
  end;

procedure TGDoublePt.VirtualizeCoords;
  begin
  Inherited VirtualizeCoords;
  scrx_2 := SafeRound(X_2);
  scry_2 := SafeRound(Y_2);
  ObjList.GetLogCoords(scrx_2, scry_2, X_2, Y_2);
  end;

procedure TGDoublePt.CheckParent3;
  { nachgerüstet am 01.09.95:
    bei Doppelpunkten wird geprüft, ob einer der beiden zu erzeugenden Punkte
    schon vorhanden ist; dies geschieht nur durch Untersuchung der Verwandt-
    schaftsbeziehungen, d.h. nicht numerisch, sondern logisch:

      Wenn es einen Punkt gibt, der gemeinsamer Elter beider Eltern ist, dann
      ist dies ein gemeinsamer Punkt der beiden Eltern. Mithin existiert schon
      einer der Schnittpunkte.

    Falls ein Punkt schon da ist, wird im DoublePt-Objekt stets der jeweils
    andere Schnittpunkt gespeichert. Ein SecondPt-Objekt ist in diesem Falle
    im Grunde überflüssig; die Verwaltung seiner Daten wird jedoch nach wie
    vor im DoublePt-Objekt durchgeführt.

    ---------------------------------------

    überarbeitet am 18.03.02:
    angepaßt an die für 2.4 veränderte Typ-Hierarchie der TGeo-Objekte

    überarbeitet am 29.07.04:
    ergänzt für den Fall, dass schon ein Punkt existiert, der als Elter
    einen Kreis hat, der seinerseits Elter des Doppelpunkt-Objekts ist:

      Wenn es einen Punkt gibt, der gleichzeitig Schnittpunkt mit einem
      Elter-Kreis und seinerseits Elter des anderen Elter-Objekts ist, dann
      ist dies ebenfalls ein gemeinsamer Punkt der beiden Eltern. Mithin
      existiert auch in diesem Fall schon einer der Schnittpunkte.

    ---------------------------------------------------------------------  }

  var pa : TGeoObj;    { Parent-Objekt }
      SP : TGPoint;    { Schnittpunkt  }
      i  : Integer;
  begin
  While Parent.Count > 2 do Parent.Delete(2);

  If ((TGeoObj(Parent[1]).ClassType = TGCircle) or          // Nur genau diese
      (TGeoObj(Parent[1]).ClassType = TGArc)) then begin    // beiden Typen !!
    SP := TGPoint(Parent[1]).Parent[1];  { SP ist der Punkt, durch den der Vater- }
                                         {   Kreis (= 2. Elter!) definiert ist.   }
    If SP.IsIncidentWith(TGLine(Parent[0])) then
      Parent.Add(SP);
    end;

  If Parent.Count <= 2 then begin  { Noch nichts gefunden ! }
    pa := TGeoObj(Parent[0]);
    For i := 0 to Pred(pa.Children.Count) do
      If (pa.Children[i] <> Self) and
         (TGeoObj(pa.Children[i]) is TGPoint) and
         (TGPoint(pa.Children[i]).IsIncidentWith(Parent[1])) then
        Parent.Add(pa.Children[i]);
    end;

  If Parent.Count <= 2 then begin  { Noch nichts gefunden ! }
    pa := TGeoObj(Parent[1]);
    For i := 0 to Pred(pa.Children.Count) do
      If (pa.Children[i] <> Self) and
         (TGeoObj(pa.Children[i]) is TGPoint) and
         (TGPoint(pa.Children[i]).IsIncidentWith(Parent[0])) then
        Parent.Add(pa.Children[i]);
    end;

  If Parent.Count >= 2 then begin
    UpdateParams;
    ObjList.UpdateAllDescendentsOf(Self);
    end;
  end;

function TGDoublePt.AllParentsUnFlagged: Boolean;
  var i, k : Integer;
      APU  : Boolean;
  begin
  i   := 0;
  APU := True;
  k   := Min(2, Parent.Count);
  While (i < k) and APU do begin
    If TGeoObj(Parent[i]).IsFlagged then
      APU := False;
    Inc(i);
    end;
  AllParentsUnFlagged := APU;
  end;

procedure TGDoublePt.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  X_2 := (BluePrint as TGDoublePt).X_2;
  Y_2 := (BluePrint as TGDoublePt).Y_2;
  end;

procedure TGDoublePt.SaveState;
  begin
  Inherited SaveState;
  With Old_Data do begin
    push(@X_2, SizeOf(X_2));
    push(@Y_2, SizeOf(Y_2));
    push(@scrx_2, SizeOf(scrx_2));
    push(@scry_2, SizeOf(scry_2));
    push(@Status2, SizeOf(Status2));
    push(@tv1, SizeOf(tv1));
    push(@tv2, SizeOf(tv2));
    end;
  tv1 := -1;  { Erzwingt beim Ortslinien-Update eine Initialisierung im  }
  tv2 := -1;  { deterministischen Aktualisierungsmodus, d.h.:            }
  end;        { die vorige Lage der Punkte wird *nicht* berücksichtigt!  }

procedure TGDoublePt.RestoreState;
  begin
  With Old_Data do begin
    pop(@tv2);
    pop(@tv1);
    pop(@Status2);
    pop(@scry_2);
    pop(@scrx_2);
    pop(@Y_2);
    pop(@X_2);
    end;
  Inherited RestoreState;
  end;

procedure TGDoublePt.UpdateParams;
  var p1   : TGLine;
      pK,
      pK2  : TGCircle;
      pSL  : TGStraightLine;
      is_valid,
      is_valid_2   : Boolean;
      old_x, old_y : Double;
      e    : Integer;

  procedure Switch4closerMatch;
    var new_tv1,    { neue Werte für die relativen Positionen }
        new_tv2,             {   TV = "Teilverhältnis"        }
        vpx, vpy,            { "Vorhandener Punkt"            }
        pu        : Double;
        iv_buf,              { "IsValid-Buffer"               }
        reverse   : Boolean;

    function ctv_dist(v1, v2: Double) : Double;
      begin
      Result := Abs(v2 - v1);
      If Result > 0.5 then
        Result := 1 - Result;
      end;

    function NoSecondPtYet: Boolean;
      var i : Integer;
      begin
      Result := True;
      For i := 0 to Pred(Children.Count) do
        If TGeoObj(Children[i]) is TGSecondPt then
          Result := False;
      end;

    begin { of Switch4closerMatch }
    If (Parent.Count > 2) and (Parent[2] <> Nil) then
      try     { den Punkt wählen, der *nicht* mit Parent[2] übereinstimmt   }
        vpx := TGPoint(Parent[2]).X;
        vpy := TGPoint(Parent[2]).Y;
        reverse := Hypot(X - vpx, Y - vpy) < Hypot(X_2 - vpx, Y_2 - vpy);
      except  { falls Parent[2] nicht mehr existiert }
        Parent.Delete(2);
        If NoSecondPtYet then
          ObjList.InsertObject(TGSecondPt.Create(ObjList, Self, True), e);
        reverse := False;
      end
    else  { beide Punkte verfügbar }
      If ObjList.DragStrategy = 1 then begin { Stetigkeit hat Vorrang ! }
        pk2.GetParamFromCoords(X, Y, new_tv1);
        pk2.GetParamFromCoords(X_2, Y_2, new_tv2);
        If tv1 + tv2 >= 0 then { Falls alte Werte vorhanden sind :  }
          reverse := ctv_dist(new_tv1, tv2) + ctv_dist(new_tv2, tv1) <
                     ctv_dist(new_tv1, tv1) + ctv_dist(new_tv2, tv2)
        else                   { Noch keine alten Werte verfügbar ! }
          reverse := False;
        end
      else                               { Reversibilität hat Vorrang ! }
        reverse := False;
    { In jedem Fall: relative Positionen abspeichern, aber mit der  }
    {    korrekten Zuordnung: tv1 enthält stets das TV des im       }
    {    TGDoublePt-Objekt aktiven Punktes !                        }
    If reverse then begin
      pu := X; X := X_2; X_2 := pu;
      pu := Y; Y := Y_2; Y_2 := pu;
      iv_buf := is_valid; is_valid := is_valid_2; is_valid_2 := iv_buf;
      tv1 := new_tv2;
      tv2 := new_tv1;
      end
    else begin
      pk2.GetParamFromCoords(X, Y, tv1);
      pk2.GetParamFromCoords(X_2, Y_2, tv2);
      end;
    end;   { of Switch4closerMatch }

  begin
  is_valid   := False;
  is_valid_2 := False;
  old_x := X;
  old_y := Y;
  p1  := TGLine  (Parent[0]);
  pk2 := TGCircle(Parent[1]);   { Der 2. Elter ist immer ein Kreis !    }
  If (pk2 <> Nil) and (p1 <> Nil) and
     pk2.DataValid and p1.DataValid then begin
    If p1 is TGCircle then begin     { falls der 1. Elter ein Kreis ist,.... }
      pK := TGCircle(p1);
      IntersectCircles (pK2.X1, pK2.Y1, pK2.Radius, pk.X1, pK.Y1, pK.Radius,
                        X, Y, X_2, Y_2, is_valid, is_valid_2);
      end
    else begin                       { andernfalls muß er eine gerade Linie sein !  }
      pSL := TGStraightLine(p1);
      IntersectCircleWithLine (pK2.X1, pK2.Y1, pK2.Radius, pSL.X1, pSL.Y1, pSL.X2, pSL.Y2,
                               X, Y, X_2, Y_2, is_valid, is_valid_2);
      end;
    is_valid   := is_valid and p1.Includes(X, Y) and pk2.Includes (X, Y);
    is_valid_2 := is_valid_2 and p1.Includes(X_2, Y_2) and pk2.Includes(X_2, Y_2);
    If is_valid and is_valid_2 then
      Switch4closerMatch;
    {27.04.03: Der Aufruf von Switch4closerMatch wurde erst *nach* der
               Feinjustierung von is_valid und is_valid_2 eingefügt statt
    davor. Dies hat zur Folge, dass eine Halbgerade, die in einem Kreis
    beginnt, immer einen ersten *ungültigen* und einen zweiten *gültigen*
    Schnittpunkt mit diesem Kreis hat.                                    }
    end;

  DataValid := is_valid;
  If is_valid_2 then
    Status2 := Status2 or gs_DataValid
  else
    Status2 := Status2 and Not gs_DataValid;

  Last_dx := X - old_x;
  Last_dy := Y - old_y;
  UpdateScreenCoords;
  end;

procedure TGDoublePt.UpdateScreenCoords;
  begin
  Inherited UpdateScreenCoords;
  If Status2 and gs_DataValid > 0 then begin
    ObjList.GetWinCoords(X_2, Y_2, scrx_2, scry_2);
    If ObjList.LogWinContains(X_2, Y_2) then
      Status2 := Status2 or gs_DataCanShow
    else
      Status2 := Status2 and Not gs_DataCanShow;
    end;
  end;

function TGDoublePt.GetInfo: String;
  begin
  If TGeoObj(Parent[0]) is TGCircle then
    Result := Format(MyObjTxt[22], [1])
  else
    Result := Format(MyObjTxt[23], [1]);
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;


{--------------------------------------------------}
{ TGSecondPt's method implementation               }
{--------------------------------------------------}

constructor TGSecondPt.Create(iObjList: TGeoObjListe; iFirstPt: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, 0, 0, False);
  BecomesChildOf (iFirstPt);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

function TGSecondPt.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  If ClassType = TGSecondPt then
    Result := Nil
  else
    Result := Inherited CreateObjNode(DOMDoc);
  end;

function TGSecondPt.IsIncidentWith(line: TGLine): Boolean;
  begin
  If ClassType = TGSecondPt then
    Result := TGDoublePt(Parent[0]).IsIncidentWith(line)
  else
    Result := Inherited IsIncidentWith(line);
  end;

procedure TGSecondPt.UpdateParams;
  var P    : TGDoublePt;
      mask : Word;
  begin
  P := TGDoublePt(Parent[0]);
  If P = Nil then Exit;
  mask := gs_DataValid or gs_DataCanShow;{ Nur diese beiden Flags übernehmen ! }
  FStatus := (FStatus and Not mask) or (P.Status2 and mask);
  If DataValid then begin
    X  := P.X_2;
    Y  := P.Y_2;
    scrx := P.scrx_2;
    scry := P.scry_2;
    end;
  end;

function TGSecondPt.GetInfo: String;
  var p0 : TGeoObj;
  begin
  p0 := TGeoObj(Parent[0]);
  If TGeoObj(p0.Parent[0]) is TGCircle then
    Result := Format(MyObjTxt[22], [2])
  else
    Result := Format(MyObjTxt[23], [2]);
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(p0.Parent[0]), Result);
  If p0.Parent.Count > 1 then
    InsertNameOf(TGeoObj(p0.Parent[1]), Result)
  else
    InsertNameOf(TGeoObj(p0.Parent[0]), Result);
  end;


{--------------------------------------------------}
{ TGIntersectPt's method implementation            }
{--------------------------------------------------}

constructor TGIntersectPt.Create(iObjList: TGeoObjListe; iIntersection: TGeoObj;
                                 iPtIndex: Integer; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, iIntersection, False);
  PtIndex := iPtIndex;
  UpdateParams;
  If iis_visible then
    ShowsAlways := True;
  end;

constructor TGIntersectPt.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  If Assigned(GO) then
    If GO is TGIntersectPt then
      PtIndex := TGIntersectPt(GO).PtIndex
    else if GO is TGDoublePt then
      PtIndex := 0
    else
      PtIndex := 1;
  end;

constructor TGIntersectPt.CreateFromBlueprint(iObjList: TGeoObjListe; MakNum, CmdNum: Integer);
  var ActMakro  : TMakro;
      ActMakCmd : TMakroCmd;
      GO        : TGeoObj;
  begin
  ActMakro  := iObjList.MakroList.Items[MakNum];   { Datenquelle ermitteln }
  ActMakCmd := ActMakro.Items[CmdNum];
  GO        := ActMakCmd.ProtoTyp;
  If GO is TGIntersectPt then
    PtIndex  := (GO as TGIntersectPt).PtIndex;
  Inherited CreateFromBlueprint(iObjList, MakNum, CmdNum);
  end;

constructor TGIntersectPt.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var domPos : IXMLNode;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  If DE.hasAttribute('plist_index') then
    PtIndex := StrToInt(DE.getAttribute('plist_index'))
  else
    PtIndex := -1;
  domPos := DE.childNodes.FindNode('position', '');
  If domPos.hasAttribute('z') then
    Age := StrToFloat(domPos.getAttribute('z'))
  else
    Age := 0;
  DataValid := Age < epsilon;
  end;

function TGIntersectPt.ParentLinksAreOkay : Boolean;
  begin
  Result := Inherited ParentLinksAreOkay and
            (Parent.Count = 1) and
            (TGeoObj(Parent[0]) is TGDoubleIntersection);
  end;

function  TGIntersectPt.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  Result.setAttribute('plist_index', IntToStr(PtIndex));
  If Age > epsilon then
    Result.childNodes.FindNode('position', '').setAttribute('z', FloatToStr(Age));
  end;

function TGIntersectPt.GetDisplacement(Pt: TFloatPoint): Double;
  begin
  Result := SumOfSquares([X - Pt.x, Y - Pt.y, Age]);
  end;

function TGIntersectPt.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (ClassType = GO.ClassType) and
            (Parent[0] = GO.Parent[0]) and
            (PtIndex = TGInterSectPt(GO).PtIndex);
  end;

function TGInterSectPt.IsIncidentWith(line: TGLine): Boolean;
  begin
  Result := (TGeoObj(Parent[0]).Parent.IndexOf(line) >= 0) or
            Inherited IsIncidentWith(line);
  end;

function TGInterSectPt.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId = ccPointOnCurve) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

procedure TGIntersectPt.SetNameTo(s: String);
  begin
  FName := s;
  end;

procedure TGIntersectPt.PatchDataFrom(OPt: TGPoint);
  begin
  FGeoNum := OPt.GeoNum;
  SetNameTo(OPt.Name);
  X := OPt.X;
  Y := OPt.Y;
  MyColour := OPt.MyColour;
  MyPenStyle := OPt.MyPenStyle;
  MyBrushStyle := OPt.MyBrushStyle;
  MyLineWidth := OPt.MyLineWidth;
  MyShape := OPt.MyShape;
  ShowsAlways := OPt.ShowsAlways;
  end;

procedure TGIntersectPt.UpdateParams;
  var Pt : TFloatPoint;
  begin
  If TGDoubleIntersection(Parent[0]).VariantValid[PtIndex] then begin
    DataValid := True;
    Pt := TGDoubleIntersection(Parent[0]).VariantPt[PtIndex];
    X := Pt.X;
    Y := Pt.Y;
    Age := 0;
    UpdateScreenCoords;
    end
  else begin
    Age := Age + 1;
    DataValid := False;
    end;
  end;

function TGIntersectPt.GetInfo: String;
  var n : Integer;
  begin
  If TGeoObj(TGeoObj(Parent[0]).Parent[1]) is TGCircle then
    If TGeoObj(TGeoObj(Parent[0]).Parent[0]) is TGCircle then
         n := 22
    else n := 23
  else  // Parent[0].Parent[1] ist ein Kegelschnitt !
    If TGeoObj(TGeoObj(Parent[0]).Parent[0]) is TGConic then
         n := 20
    else n := 21;
  Result := Format(MyObjTxt[n], [Succ(PtIndex)]);
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(TGeoObj(Parent[0]).Parent[0]), Result);
  InsertNameOf(TGeoObj(TGeoObj(Parent[0]).Parent[1]), Result);
  end;


{--------------------------------------------------}
{ TGLxLPt's method implementation                  }
{--------------------------------------------------}

constructor TGLxLPt.Create(iObjList: TGeoObjListe; iG1, iG2: TGeoObj; iis_visible : Boolean);
  begin
  Inherited Create (iObjList, 0, 0, False);
  BecomesChildOf (iG2);
  BecomesChildOf (iG1);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

function TGLxLPt.CreateI2GConstraintNode(DOMDoc: IXMLDocument;
                                         ObjNames: TStrings): IXMLNode;
  var PtNode,
      P1Node,
      P2Node: IXMLNode;
  begin
  Result := Nil;
  If AllParentsInList(ObjNames) then begin
    PtNode := DOMDoc.createNode('point');
    PtNode.setAttribute('out', 'true');
    PtNode.nodeValue := Name;
    P1Node := DOMDoc.createNode('line');
    P1Node.nodeValue := TGeoObj(Parent[0]).Name;
    P2Node := DOMDoc.createNode('line');
    P2Node.nodeValue := TGeoObj(Parent[1]).Name;
    Result := DOMDoc.createNode('point_intersection_of_lines');
    Result.childNodes.add(PtNode);
    Result.childNodes.add(P1Node);
    Result.childNodes.add(P2Node);
    end;
  end;


function TGLxLPt.IsIncidentWith(line: TGLine): Boolean;
  begin
  Result := (Parent.IndexOf(line) >= 0) or
            Inherited IsIncidentWith(line);
  end;

procedure TGLxLPt.UpdateParams;
  var g1, g2 : TGStraightLine;
      is_valid  : Boolean;
  begin
  DataValid := False;
  g1 := TGStraightLine(Parent[0]);
  g2 := TGStraightLine(Parent[1]);
  If (g1 <> Nil) and (g2 <> Nil) and
     g1.DataValid and g2.DataValid then begin
    IntersectLines(g1.X1, g1.Y1, g1.X2, g1.Y2, g2.X1, g2.Y1, g2.X2, g2.Y2,
                   X, Y, is_valid);
    DataValid := is_valid and g1.Includes(X, Y) and g2.Includes(X, Y);
    UpdateScreenCoords;
    end;
  end;

function TGLxLPt.GetInfo: String;
  begin
  Result := MyObjTxt[26];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;


{--------------------------------------------------}
{ TGPol's method implementation                    }
{--------------------------------------------------}

constructor TGPol.Create(iObjList: TGeoObjListe; iSL, iC: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, 0, 0, False);
  BecomesChildOf(iSL);
  BecomesChildOf(iC);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

function TGPol.IsIncidentWith(line: TGLine): Boolean;
  begin
  Result := False;
  end;

procedure TGPol.UpdateParams;
  var g : TGStraightLine;
      C : TGLine;  // eigentlich: TGCircle oder TGConic
  begin
  DataValid := False;
  g := TGeoObj(Parent[0]) as TGStraightLine;
  C := TGeoObj(Parent[1]) as TGLine;
  If (g <> Nil) and (C <> Nil) and
     g.DataValid and C.DataValid then begin
    DataValid := C.GetPolOf(g.HesseEq, X, Y);
    If DataValid then
      UpdateScreenCoords;
    end;
  end;

function TGPol.GetInfo: String;
  begin
  Result := MyObjTxt[96];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;


{-------------------------------------------}
{ TGMSenkr's Methods Implementation         }
{-------------------------------------------}

function TGMSenkr.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  Result := Nil;
  end;

procedure TGMSenkr.UpdateParams;
  { 15.10.02: Aus Gründen der Kompatibilität zu früheren Versionen
              hat die Mittelsenkrechte einer Strecke P1P2 stets eine
              Orientierung, die durch eine *Rechtsdrehung* aus der
              der Strecke P1P2 hervorgeht. Leider!!!
    08.05.05: Bei der Einführung des XML-Datei-Formates wurde dieser
              Zopf abgeschnitten. Jetzt geht die Orientierung der
              Mittelsenkrechten aus der der Strecke durch eine
              mathematisch-positive Drehung hervor, also links herum
              und gegen den Uhrzeigersinn - wie es sein soll! }
  var p1, p2 : TGPoint;
      p0x, p0y, p1x, p1y, dx, dy : Double;
  begin
  DataValid := False;
  p1 := TGPoint(Parent[0]);
  If (p1 <> Nil) and p1.DataValid then begin
    p2 := TGPoint(Parent[1]);
    If (p2 <> Nil) and
       (p2.DataValid) then begin
      p0x := TGeoObj(Parent[0]).X;
      p0y := TGeoObj(Parent[0]).Y;
      p1x := TGeoObj(Parent[1]).X;
      p1y := TGeoObj(Parent[1]).Y;
      X1 := (p0x + p1x) / 2;
      Y1 := (p0y + p1y) / 2;
      dx := p0y - p1y;
      dy := p1x - p0x;
      DataValid := GetHesseEqFromPtAndDir(X1, Y1, dx, dy, FHesseEq);
      If DataValid then begin
        X2 := X1 + dx;
        Y2 := Y1 + dy;
        UpdateScreenCoords;
        end
      end;
    end;
  end;

function TGMSenkr.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var e_rv : TFloatPoint;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  If DataValid then begin
    e_rv := GetNormalizedDirection;
    px := X1 + param * e_rv.x;
    py := Y1 + param * e_rv.y;
    Result := True;
    end;
  end;

function TGMSenkr.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var e_rv : TFloatPoint;
  begin
  If DataValid then begin
    e_rv := GetNormalizedDirection;
    If Abs(e_rv.x) > Abs(e_rv.y) then // 30.07.03 statt:  Abs(x - xm) > Abs(y - ym)
      param := (px - X1) / e_rv.x     // ( Dietmar Viertel: alte Version geht schief
    else                              //     für horizontale Mittelsenkrechte !   )
      param := (py - Y1) / e_rv.y;
    Result := True;
    end
  else
    Result := False;
  end;

function TGMSenkr.GetInfo: String;
  begin
  Result := MyObjTxt[27];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;


{-------------------------------------------}
{ TGWHalb's Methods Implementation          }
{-------------------------------------------}

constructor TGWHalb.Create(iObjList: TGeoObjListe; iP1, iP2, iP3 : TGeoObj; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, Nil, Nil, False);
  BecomesChildOf(iP1);
  BecomesChildOf(iP2);
  BecomesChildOf(iP3);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  Set_CBDI;
  UpdateParams;
  DrawIt;
  end;

procedure TGWHalb.AfterLoading(FromXML : Boolean = True);
  var p        : Array [1..3] of TGPoint;
      dx0, dy0,
      dx1, dy1,
      dx2, dy2,
      nf1, nf2 : Double;
      i        : Integer;
  begin
  Inherited AfterLoading(FromXML);
  DataValid := True;
  For i := 1 to 3 do begin
    p[i] := TGPoint(Parent[i-1]);
    If p[i] = Nil then Exit;     { Notbremse }
    If Not p[i].DataValid then
      DataValid := False;
    end;
  If DataValid then begin
    X1 := p[2].X;        { Scheitel-      }
    Y1 := p[2].Y;        {   Koordinaten  }
    dx1 := p[1].X - X1;  { Richtung des   }
    dy1 := p[1].Y - Y1;  {   1. Schenkels }
    dx2 := p[3].X - X1;  { Richtung des   }
    dy2 := p[3].Y - Y1;  {   2. Schenkels }
    nf1 := Hypot(dx1, dy1);
    If nf1 < DistEpsilon then
      DataValid := False
    else begin
      nf2 := Hypot(dx2, dy2);
      If nf2 < DistEpsilon then
        DataValid := False
      else begin
        dx1 := dx1/nf1;       { Erstmal normieren }
        dy1 := dy1/nf1;
        dx2 := dx2/nf2;
        dy2 := dy2/nf2;
        dx0 := dx1 + dx2;     { Geht für Winkel weit ab von 180° }
        dy0 := dy1 + dy2;
        If Hypot(dx0, dy0) > epsilon then begin
          X2 := X1 + dx0;
          Y2 := Y1 + dy0;
          end
        else begin
          X2 := X1 + dy1 - dy2;
          Y2 := Y1 + dx2 - dx1;
          end;
        end;
      end;
    end;
  end;

function TGWHalb.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGWHalb) and
            (GO.Parent[0] = Self.Parent[0]) and
            (GO.Parent[1] = Self.Parent[1]) and
            (GO.Parent[2] = Self.Parent[2]);
  end;

function TGWHalb.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr = 1 then
    Result := Parent[1]
  else
    Result := Nil;
  end;

procedure TGWHalb.UpdateParams;
  { Aus den 3 definierenden Punkten des zu halbierenden Winkels werden
    zwei Einheitsvektoren errechnet, welche eine Raute "in dem Winkel"
    aufspannen: deren erste Diagonale (= Summe der Vektoren) weist in
    Richtung der Winkelhalbierenden, wohingegen die zweite (= Differenz
    der Vektoren!) orthogonal dazu ist. Ist die erste Diagonale kürzer
    als ein Einheitsvektor, dann wird die Richtung der Winkelhalbierenden
    aus der zweiten Diagonalen errechnet.
    Über die Orientierung wird durch Vergleich mit der alten Orientierung
    und die Forderung möglichst kleiner Veränderungen (Stetigkeits-
    Forderung) entschieden.                                             }
  var p        : Array [1..3] of TGPoint;
      dx0, dy0,
      dx1, dy1,
      dx2, dy2,
      nf1, nf2 : Double;
      i        : Integer;
  begin
  DataValid := True;
  For i := 1 to 3 do begin
    p[i] := TGPoint(Parent[i-1]);
    If p[i] = Nil then Exit;     { Notbremse }
    If Not p[i].DataValid then
      DataValid := False;
    end;
  If DataValid then begin
    X1 := p[2].X;        { Scheitel-      }
    Y1 := p[2].Y;        {   Koordinaten  }
    dx1 := p[1].X - X1;  { Richtung des   }
    dy1 := p[1].Y - Y1;  {   1. Schenkels }
    dx2 := p[3].X - X1;  { Richtung des   }
    dy2 := p[3].Y - Y1;  {   2. Schenkels }
    nf1 := Hypot(dx1, dy1);
    If nf1 < DistEpsilon then
      DataValid := False
    else begin
      nf2 := Hypot(dx2, dy2);
      If nf2 < DistEpsilon then
        DataValid := False
      else begin
        dx1 := dx1/nf1;       { Erstmal normieren }
        dy1 := dy1/nf1;
        dx2 := dx2/nf2;
        dy2 := dy2/nf2;
        dx0 := dx1 + dx2;     { Geht für Winkel weit ab von 180° }
        dy0 := dy1 + dy2;
        If ObjList.DragStrategy = 1 then begin  { Stetigkeit hat Vorrang ! }
          If Hypot(dx0, dy0) < 1 then begin
            dx0 := dy1 - dy2;   { Alternative für Winkel um 180° herum }
            dy0 := dx2 - dx1;
            end;
          If Hypot(X1 - dx0 - X2, Y1 - dy0 - Y2)
             < Hypot(X1 + dx0 - X2, Y1 + dy0 - Y2) then begin
            X2 := X1 - dx0;
            Y2 := Y1 - dy0;
            end
          else begin
            X2 := X1 + dx0;
            Y2 := Y1 + dy0;
            end;
          end
        else                                  { Reversibilität hat Vorrang }
          If Hypot(dx0, dy0) > epsilon then begin
            X2 := X1 + dx0;
            Y2 := Y1 + dy0;
            end
          else begin
            X2 := X1 + dy1 - dy2;
            Y2 := Y1 + dx2 - dx1;
            end;
        GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
        UpdateScreenCoords;
        end;
      end;
    end;
  end;

function TGWHalb.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var dx, dy, db : Double;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  dx := X2 - X1;
  dy := Y2 - Y1;
  db := Sqrt(Sqr(dx) + Sqr(dy));
  If DataValid and (db > DistEpsilon) then begin
    dx := dx / db;
    dy := dy / db;
    px := TGPoint(Parent[1]).X + param * dx;
    py := TGPoint(Parent[1]).Y + param * dy;
    Result := True;
    end;
  end;

function TGWHalb.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var dx, dy, db, fx, fy : Double;
  begin
  Result := False;
  If Not GetPedalpoint(X1, Y1, X2, Y2, px, py, fx, fy) then begin
    fx := px;
    fy := py;
    end;
  dx := X2 - X1;
  dy := Y2 - Y1;
  db := Sqrt(Sqr(dx) + Sqr(dy));
  If DataValid and (db > DistEpsilon) then begin
    dx := dx / db;      // Einheits-Richtungsvektor herstellen
    dy := dy / db;
    If Abs(dx) > Abs(dy) then
      param := (fx - TGPoint(Parent[1]).X) / dx
    else
      param := (fy - TGPoint(Parent[1]).Y) / dy;
    Result := True;
    end;
  end;

function TGWHalb.GetInfo: String;
  begin
  Result := MyObjTxt[28];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  InsertNameOf(TGeoObj(Parent[2]), Result);
  end;


{-------------------------------------------}
{ TGLot's Methods Implementation            }
{-------------------------------------------}

function TGLot.HasSameDataAs(GO: TGeoObj): Boolean;
  { 11.06.06 :  TGLot ist inzwischen ersetzt durch den davon abgeleiteten
                Typ TGSenkr; daher erfolgt der Typvergleich mit "is" statt
                mit "=" angewendet auf die ClassType-Eigenschaften !      }
  begin
  Result := (GO is TGLot) and
            (GO.Parent[0] = Self.Parent[0]) and
            (GO.Parent[1] = Self.Parent[1]);
  end;

procedure TGLot.VirtualizeCoords;
  var p : TGPoint;
      g : TGStraightLine;
  begin
  p := TGPoint(Parent[0]);
  If (p <> Nil) and p.DataValid then begin
    X2 := p.X;
    Y2 := p.Y;
    g  := TGStraightLine(Parent[1]);
    If (g <> Nil) and (g.DataValid) and
       GetPedalPoint(g.X1, g.Y1, g.X2, g.Y2, X2, Y2, X1, Y1) then begin
      DataValid := True;
      If Abs(X1-X2) + Abs(Y1-Y2) < DistEpsilon then begin
        X1 := X2 + (g.Y1 - g.Y2);
        Y1 := Y2 + (g.X2 - g.X1);
        end;
      end;
    end;
  end;

function TGLot.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr = 1 then
    Result := Parent[0]
  else
    Result := Nil;
  end;

procedure TGLot.UpdateParams;
  { 15.10.02 : Aus Gründen der Kompatibilität zu früheren Versionen hat
               das Lot s *in* einem Punkt einer Geraden g stets eine
               Orientierung, die aus der der Geraden g durch eine
               Drehung *im* Uhrzeigersinn hervorgeht. Leider !!!    }
  var p : TGPoint;
      g : TGStraightLine;
  begin
  DataValid := False;
  p := TGPoint(Parent[0]);
  If (p <> Nil) and p.DataValid then begin
    X2 := p.X;
    Y2 := p.Y;
    g  := TGStraightLine(Parent[1]);
    If (g <> Nil) and (g.DataValid) and
       GetPedalPoint(g.X1, g.Y1, g.X2, g.Y2, X2, Y2, X1, Y1) then begin
      DataValid := True;
      If Abs(X1-X2) + Abs(Y1-Y2) < DistEpsilon then begin
        X1 := X2 + (g.Y1 - g.Y2);
        Y1 := Y2 + (g.X2 - g.X1);
        end;
      GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
      UpdateScreenCoords;
      end;
    end;
  end;

function TGLot.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var dx, dy, db : Double;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  dx := TGStraightLine(Parent[1]).Y2 - TGStraightLine(Parent[1]).Y1;
  dy := TGStraightLine(Parent[1]).X1 - TGStraightLine(Parent[1]).X2;
  db := Sqrt(Sqr(dx) + Sqr(dy));
  If DataValid and (db > DistEpsilon) then begin
    dx := dx / db;
    dy := dy / db;
    px := TGPoint(Parent[0]).X + param * dx;
    py := TGPoint(Parent[0]).Y + param * dy;
    Result := True;
    end;
  end;

function TGLot.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var dx, dy, db : Double;
  begin
  Result := False;
  dx := TGStraightLine(Parent[1]).Y2 - TGStraightLine(Parent[1]).Y1;
  dy := TGStraightLine(Parent[1]).X1 - TGStraightLine(Parent[1]).X2;
  db := Sqrt(Sqr(dx) + Sqr(dy));
  If DataValid and (db > DistEpsilon) then begin
    dx := dx / db;
    dy := dy / db;
    If Abs(dx) > Abs(dy) then
      param := (px - TGPoint(Parent[0]).X) / dx
    else
      param := (py - TGPoint(Parent[0]).Y) / dy;
    Result := True;
    end;
  end;

function TGLot.GetInfo: String;
  begin
  Result := MyObjTxt[29];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;


{-------------------------------------------}
{ TGSenkr's Methods Implementation          }
{-------------------------------------------}

constructor TGSenkr.CreateFrom(oldObj: TGLot);
  var child : TGeoObj;
      i     : Integer;
  begin
  Inherited Create(oldObj.ObjList,
                   oldObj.Parent[0], oldObj.Parent[1],
                   oldObj.IsVisible);
  For i := Pred(oldObj.Parent.Count) downto 0 do
    oldObj.Stops2BeChildOf(oldObj.Parent[i]);
  While oldObj.Children.Count > 0 do begin
    child := TGeoObj(oldObj.Children[0]);
    i := child.Parent.IndexOf(oldObj);
    If i >= 0 then begin
      child.Parent[i] := Self;   // Patchen, um die Ordnung in
      children.Add(child);       //   der Elternliste zu wahren!
      end;
    oldObj.Children.Delete(0);
    end;
  MyColour    := oldObj.MyColour;
  MyLineWidth := oldObj.MyLineWidth;
  MyPenStyle  := oldObj.MyPenStyle;
  UpdateParams;
  end;

function TGSenkr.CreateI2GConstraintNode(DOMDoc: IXMLDocument;
                                            ObjNames: TStrings): IXMLNode;
  var LnNode,
      P1Node,
      P2Node: IXMLNode;
  begin
  Result := Nil;
  If AllParentsInList(ObjNames) then begin
    LnNode := DOMDoc.createNode('line');
    LnNode.setAttribute('out', 'true');
    LnNode.nodeValue := Name;
    P1Node := DOMDoc.createNode('point');
    P1Node.nodeValue := TGeoObj(Parent[0]).Name;
    P2Node := DOMDoc.createNode('line');
    P2Node.nodeValue := TGeoObj(Parent[1]).Name;
    Result := DOMDoc.createNode('line_perpendicular_to_line_through_point');
    Result.childNodes.add(LnNode);
    Result.childNodes.add(P1Node);
    Result.childNodes.add(P2Node);
    end;
  end;

procedure TGSenkr.SetNewNameParamsIn(TextObj: TGTextObj);
  var dx, dy,
      xp, yp,
      dr    : Double;
  begin
  with TextObj do begin
    dx := X2 - X1;
    dy := Y2 - Y1;
    dr := Hypot(dx, dy);
    If dr > DistEpsilon then begin
      dx := dx / dr;
      dy := dy / dr;
      GetPedalPoint(X1, Y1, X2, Y2, X, Y, xp, yp);
      If Abs(dx) > Abs(dy) then
        sConst := (xp - X2) / dx
      else
        sConst := (yp - Y2) / dy;
      rConst := ((X - X1) * dy - (Y - Y1) * dx);
      end;
    end;
  end;

procedure TGSenkr.UpdateNameCoordsIn(TextObj: TGTextObj);
  var dx, dy, dr, fx, fy : Double;
  begin
  with TextObj do begin
    DataValid := Self.DataValid;
    If DataValid then begin
      dx := X2 - X1;
      dy := Y2 - Y1;
      dr := Hypot(dx, dy);
      If dr > DistEpsilon then begin
        dx := dx / dr;              // Richtungsvektor normieren
        dy := dy / dr;
        fx  := X2 + sConst * dx;    // Punkt auf der Geraden entlang schieben,
        fy  := Y2 + sConst * dy;
        X := fx + dy * rConst;      // Punkt orthogonal zur Geraden weg schieben
        Y := fy - dx * rConst;
        end
      else begin
        X := X1 + 0.2;
        Y := Y1 + 0.2;
        end;
      end;
    end;
  end;

procedure TGSenkr.UpdateParams;
{ 31.12.02 : die Richtung der Senkrechten geht nun immer aus der
             Richtung der Bezugsgeraden Parent[1] durch eine
             mathematisch positive Drehung (also *gegen* die Uhr!)
             hervor, und zwar unabhängig davon, ob der Punkt
             Parent[0] auf der Bezugslinie liegt oder nicht !      }
  var p : TGPoint;
      g : TGStraightLine;
  begin
  DataValid := False;
  p := TGPoint(Parent[0]);
  If (p <> Nil) and p.DataValid then begin
    X2 := p.X;
    Y2 := p.Y;
    g  := TGStraightLine(Parent[1]);
    If (g <> Nil) and (g.DataValid) then begin
      DataValid := True;
      X1 := X2 + (g.Y2 - g.Y1);
      Y1 := Y2 + (g.X1 - g.X2);
      GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
      UpdateScreenCoords;
      end;
    end;
  end;


{-------------------------------------------}
{ TGParall's Methods Implementation         }
{-------------------------------------------}

function TGParall.CreateI2GConstraintNode(DOMDoc: IXMLDocument;
                                          ObjNames: TStrings): IXMLNode;
  var LnNode,
      P1Node,
      P2Node: IXMLNode;
  begin
  Result := Nil;
  If AllParentsInList(ObjNames) then begin
    LnNode := DOMDoc.createNode('line');
    LnNode.setAttribute('out', 'true');
    LnNode.nodeValue := Name;
    P1Node := DOMDoc.createNode('point');
    P1Node.nodeValue := TGeoObj(Parent[0]).Name;
    P2Node := DOMDoc.createNode('line');
    P2Node.nodeValue := TGeoObj(Parent[1]).Name;
    Result := DOMDoc.createNode('line_parallel_to_line_through_point');
    Result.childNodes.add(LnNode);
    Result.childNodes.add(P1Node);
    end;
  end;

function TGParall.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = TGParall) and
            (GO.Parent[0] = Self.Parent[0]) and
            (GO.Parent[1] = Self.Parent[1]);
  end;

procedure TGParall.VirtualizeCoords;
  var p : TGPoint;
      g : TGStraightLine;
  begin
  p := TGPoint(Parent[0]);
  If (p <> Nil) and p.DataValid then begin
    X1 := p.X;
    Y1 := p.Y;
    g  := TGStraightLine(Parent[1]);
    If (g <> Nil) and (g.DataValid) then begin
      X2 := X1 + (g.X2 - g.X1);
      Y2 := Y1 + (g.Y2 - g.Y1);
      end;
    end;
  end;

function TGParall.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr = 1 then
    Result := Parent[0]
  else
    Result := Nil;
  end;

procedure TGParall.UpdateParams;
  var p : TGPoint;
      g : TGStraightLine;
  begin
  DataValid := False;
  p := TGPoint(Parent[0]);
  If (p <> Nil) and (p.DataValid) then begin
    X1 := p.X;
    Y1 := p.Y;
    g  := TGStraightLine(Parent[1]);
    If (g <> Nil) and (g.DataValid) then begin
      X2 := X1 + g.X2 - g.X1;
      Y2 := Y1 + g.Y2 - g.Y1;
      GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
      DataValid := True;
      UpdateScreenCoords;
      end;
    end;
  end;

function TGParall.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var dx, dy, db : Double;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  dx := TGStraightLine(Parent[1]).X2 - TGStraightLine(Parent[1]).X1;
  dy := TGStraightLine(Parent[1]).Y2 - TGStraightLine(Parent[1]).Y1;
  db := Sqrt(Sqr(dx) + Sqr(dy));
  If DataValid and (db > DistEpsilon) then begin
    dx := dx / db;
    dy := dy / db;
    px := TGPoint(Parent[0]).X + param * dx;
    py := TGPoint(Parent[0]).Y + param * dy;
    Result := True;
    end;
  end;

function TGParall.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var dx, dy, db : Double;
  begin
  Result := False;
  dx := TGStraightLine(Parent[1]).X2 - TGStraightLine(Parent[1]).X1;
  dy := TGStraightLine(Parent[1]).Y2 - TGStraightLine(Parent[1]).Y1;
  db := Sqrt(Sqr(dx) + Sqr(dy));
  If DataValid and (db > DistEpsilon) then begin
    dx := dx / db;
    dy := dy / db;
    If Abs(dx) > Abs(dy) then
      param := (px - TGPoint(Parent[0]).X) / dx
    else
      param := (py - TGPoint(Parent[0]).Y) / dy;
    Result := True;
    end;
  end;

function TGParall.GetInfo: String;
  begin
  Result := MyObjTxt[30];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  end;


{-------------------------------------------}
{ TGTangent's Methods Implementation        }
{-------------------------------------------}

constructor TGTangent.Create(iObjList: TGeoObjListe; iP, iL: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, iP, iL, iis_visible);
  end;

function TGTangent.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr = 1 then
    Result := Parent[0]
  else
    Result := Nil;
  end;

procedure TGTangent.UpdateParams;
  var P : TGPoint;
      L : TGLine;
  begin
  P := Parent[0];
  L := Parent[1];
  try
    If P.DataValid and L.DataValid and P.IsIncidentWith(L) then begin
      L.GetTangentIn(P.X, P.Y, FHesseEq);
      X1 := P.X;
      Y1 := P.Y;
      X2 := X1 + FHesseEq.Y;
      Y2 := Y1 - FHesseEq.X;
      DataValid := True;
      UpdateScreenCoords;
      end
    else
      DataValid := False;
  except
    DataValid := False;
  end;
  end;

function TGTangent.GetInfo: String;
  begin
  Result := MyObjTxt[68];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  end;


{-------------------------------------------}
{ TGNormal's Methods Implementation         }
{-------------------------------------------}

procedure TGNormal.UpdateParams;
  var v : TVector3;
      P : TGPoint;
      L : TGLine;
  begin
  P := Parent[0];
  L := Parent[1];
  try
  If P.DataValid and L.DataValid and P.IsIncidentWith(L) then begin
    v := TVector3.Create(0, 0, 0);
    try
      L.GetTangentIn(P.X, P.Y, v);
      X1 := P.X;
      Y1 := P.Y;
      X2 := X1 + v.X;
      Y2 := Y1 + v.Y;
      GetHesseEqFromPtAndDir(P.X, P.Y, v.X, v.Y, FHesseEq);
      DataValid := True;
      UpdateScreenCoords;
    finally
      v.Free;
    end;
    end;
  except
    DataValid := False;
  end;
  end;

function TGNormal.GetInfo: String;
  begin
  Result := MyObjTxt[94];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  end;


{-------------------------------------------}
{ TGPolare's Methods Implementation         }
{-------------------------------------------}

constructor TGPolare.Create(iObjList: TGeoObjListe; iP, iL: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, iP, iL, iis_visible);
  end;

function TGPolare.GetInfo: String;
  begin
  Result := MyObjTxt[95];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;

function TGPolare.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  Result := Nil;
  end;

procedure TGPolare.UpdateParams;
  var P : TGPoint;
      L : TGLine;   // eigentlich TGCircle oder TGConic
      P1, P2 : TFloatPoint;
  begin
  P := Parent[0];
  L := Parent[1];
  DataValid := False;
  If P.DataValid and L.DataValid then begin
    L.GetPolareOf(P.X, P.Y, FHesseEq);
    Get2PointsFromHesseEq(FHesseEq, P1, P2);
    X1 := P1.X;
    Y1 := P1.Y;
    X2 := P2.X;
    Y2 := P2.Y;
    DataValid := True;
    UpdateScreenCoords;
    end;
  end;

{-------------------------------------------}
{ TGCurve's Methods Implementation          }
{-------------------------------------------}

destructor TGCurve.Destroy;
  begin
  FreeAndNil(points);
  Inherited Destroy;
  end;

procedure TGCurve.GetDataVector(var v: TVector3);
  begin
  end;

function TGCurve.GetLinePtWithMinMouseDist(xm, ym, quant: Double;
                  var px, py: Double): Boolean;
  var p : Double;
  begin
  Result := GetParamFromCoords(xm, ym, p) and
            GetCoordsFromParam(p, px, py);
  end;

function TGCurve.GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean;
  var d, n_d, il, _X, _Y,
      T1x, T1y, T2x, T2y : Double;
      T1_valid, T2_valid,
      pt_out, line_out : Boolean;
      i : Integer;

  procedure next_i;
    begin
    repeat Inc(i)
    until (i >= points.Count) or
          ((points[i  ] <> nil) and (points[i  ].IsValid) and
           (points[i-1] <> nil) and (points[i-1].IsValid)) ;
    end;

  begin
  _X := 1e10;
  _Y := 1e10;
  i := 0;
  while (i < points.Count) and (points[i] = nil) do
    Inc(i);
  if (i < points.Count) then begin
    d  := Hypot(EP.X - points[i].x, EP.Y - points[i].y);
    pt_out := d > r;
    next_i;
    while i < points.Count do begin
      if pt_out then
        n_d := DistPt2ShortLn(points[i-1].X, points[i-1].Y, points[i].X, points[i].Y, EP.X, EP.Y)
      else
        n_d := Hypot(points[i].X - EP.X, points[i].Y - EP.Y);
      line_out := n_d > r;
      il := Hypot(points[i].X - points[i-1].X, points[i].Y - points[i-1].Y);
      if (line_out <> pt_out) and (il > MathLib.epsilon) then begin
        MathLib.IntersectCircleWithLine(EP.X, EP.Y, r, points[i-1].X, points[i-1].Y, points[i].X, points[i].Y,
                                        T1x, T1y, T2x, T2y, T1_valid, T2_valid);
        If T1_valid and
           (Hypot((points[i-1].X + points[i].X) - 2*T1x, (points[i-1].Y + points[i].Y) - 2*T1y) < il) and
           (Hypot(T1x - px, T1y - py) < Hypot(_X - px, _Y - py)) then begin
          _X := T1x;
          _Y := T1y;
          end;
        If T2_valid and
           (Hypot((points[i-1].X + points[i].X) - 2*T2x, (points[i-1].Y + points[i].Y) - 2*T2y) < il) and
           (Hypot(T2x - px, T2y - py) < Hypot(_X - px, _Y - py)) then begin
          _X := T2x;
          _Y := T2y;
          end;
        end;
      if not pt_out then
        n_d := Hypot(points[i].X - EP.X, points[i].Y - EP.Y);
      pt_out := n_d > r;
      next_i;
      end;
    end;
  Result := Hypot(_X, _y) < 1e10;
  if Result then begin
    px := _X;
    py := _Y;
    end;
  end;

procedure TGCurve.SaveState;
  var n, m, i : Integer;
  begin
  Inherited SaveState;
  For i := 0 to High(IntPointLists) do begin
    n := Succ(High(IntPointLists[i]));
    Old_Data.push(@IntPointLists[i, 0], n * SizeOf(TPoint));
    Old_Data.push(@n, SizeOf(n));
    end;
  m := Succ(High(IntPointLists));
  Old_Data.push(@m, SizeOf(m));
  end;

procedure TGCurve.RestoreState;
  var n, m, i : Integer;
  begin
  IntPointLists := Nil;
  Old_Data.pop(@m);
  SetLength(IntPointLists, m);
  For i := 0 to Pred(m) do begin
    Old_Data.pop(@n);
    SetLength(IntPointLists[i], n);
    Old_Data.pop(@IntPointLists[i, 0]);
    end;
  Inherited RestoreState;
  end;

function TGCurve.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := ClassGroupId in [ccAnyGeoObj, ccAnyObjNoArea, ccParentObj,
                             ccNamedObj, ccAnyLine, ccMappableObj];
  end;

function TGCurve.Dist(xm, ym: Double): Double;
  var n : Integer;
      dv, dp, dn : Double;
  begin
  LastDist := 1.0e300;
  n := points.GetPtIndexNextToXY(xm, ym);
  If (n >= 0) and
     ObjList.LogWinContains(TVector3(points[n]).X,
                            TVector3(points[n]).Y) then begin
    dp := Hypot(TVector3(points[n]).X - xm, TVector3(points[n]).Y - ym);
    If (n > 0) and
       ObjList.LogWinContains(TVector3(points[Pred(n)]).X,
                              TVector3(points[Pred(n)]).Y) then begin
      dv := DistPt2ShortLn(TVector3(points[Pred(n)]).X, TVector3(points[Pred(n)]).Y,
                           TVector3(points[n      ]).X, TVector3(points[n      ]).Y,
                           xm, ym);
      If dv < dp then
        dp := dv;
      end;
    If (n < Pred(points.Count)) and
       ObjList.LogWinContains(TVector3(points[Succ(n)]).X,
                              TVector3(points[Succ(n)]).Y) then begin
      dn := DistPt2ShortLn(TVector3(points[Succ(n)]).X, TVector3(points[Succ(n)]).Y,
                           TVector3(points[n      ]).X, TVector3(points[n      ]).Y,
                           xm, ym);
      If dn < dp then
        dp := dn;
      end;
    end
  else
    dp := 1.0e300;
  If dp < LastDist then LastDist := dp;
  Result := LastDist;
  end;

function TGCurve.IsNearMouse: Boolean;
  var dmin, d,
      e0, e1, e2 : Double;
      f01, w12   : Boolean;    // "f"allend, "w"achsend
      i, k       : Integer;
  begin
  Result := False;
  dmin := 1.0e300;
  For i := 0 to High(IntPointLists) do
    If High(IntPointLists[i]) >= 2 then begin
      e0 := Hypot(TPoint(IntPointLists[i, 0]).X - ObjList.LastMousePos.X,
                    TPoint(IntPointLists[i, 0]).Y - ObjList.LastMousePos.Y);
      e1 := Hypot(TPoint(IntPointLists[i, 1]).X - ObjList.LastMousePos.X,
                    TPoint(IntPointLists[i, 1]).Y - ObjList.LastMousePos.Y);
      f01 := e1 < e0;
      For k := 2 to High(IntPointLists[i]) do begin
        e2 := Hypot(TPoint(IntPointLists[i, k]).X - ObjList.LastMousePos.X,
                      TPoint(IntPointLists[i, k]).Y - ObjList.LastMousePos.Y);
        w12 := e2 > e1;
        If f01 and w12 then
          If e1 < CatchDist then begin
            Result := True;
            Exit;
            end
          else begin
            d := DistPt2ShortLn
              (TPoint(IntPointLists[i, k-2]).X, TPoint(IntPointLists[i, k-2]).Y,
               TPoint(IntPointLists[i, k-1]).X, TPoint(IntPointLists[i, k-1]).Y,
               ObjList.LastMousePos.X, ObjList.LastMousePos.Y);
            If d < dmin then dmin := d;
            d := DistPt2ShortLn
              (TPoint(IntPointLists[i, k-1]).X, TPoint(IntPointLists[i, k-1]).Y,
               TPoint(IntPointLists[i, k  ]).X, TPoint(IntPointLists[i, k  ]).Y,
               ObjList.LastMousePos.X, ObjList.LastMousePos.Y);
            If d < dmin then dmin := d;
            end;
        If dmin < CatchDist then begin
          Result := True;
          Exit;
          end
        else begin
          e1  := e2;
          f01 := Not w12;
          end;
        end;
      end
    else if High(IntPointLists[i]) = 1 then begin
      e0 := Hypot(TPoint(IntPointLists[i, 0]).X - ObjList.LastMousePos.X,
                    TPoint(IntPointLists[i, 0]).Y - ObjList.LastMousePos.Y);
      e1 := Hypot(TPoint(IntPointLists[i, 1]).X - ObjList.LastMousePos.X,
                    TPoint(IntPointLists[i, 1]).Y - ObjList.LastMousePos.Y);
      e2 := DistPt2ShortLn
              (TPoint(IntPointLists[i, 0]).X, TPoint(IntPointLists[i, 0]).Y,
               TPoint(IntPointLists[i, 1]).X, TPoint(IntPointLists[i, 1]).Y,
               ObjList.LastMousePos.X, ObjList.LastMousePos.Y);
      d := min(e0, min(e1, e2));
      if d < dmin then dmin := d;
      if dmin < CatchDist then begin
        Result := True;
        Exit;
        end;
      end;
  end;


{-------------------------------------------}
{ TOLPoint's Methods Implementation         }
{-------------------------------------------}

constructor TOLPoint.Create(iObjList: TGeoObjListe; ix, iy: Double);
  begin
  X := ix;
  Y := iy;
  end;

constructor TOLPoint.Load(S: TFileStream);
  begin
  S.Read(X, SizeOf(X));
  S.Read(Y, SizeOf(Y));
  end;

constructor TOLPoint.Load32(R: TReader);
  begin
  X := R.ReadFloat;
  Y := R.ReadFloat;
  end;



{-------------------------------------------}
{ TGXCircle's Methods Implementation        }
{-------------------------------------------}

constructor TGXCircle.Create(iObjList: TGeoObjListe; iP: TGeoObj;
                             iRTerm : WideString; iis_visible : Boolean);
  begin
  Inherited Create (iObjList, Nil, 0, False);
  BecomesChildOf(iP);
  rTerm := TTBaum.Create(ObjList, Rad);
  rTerm.BuildTree(iRTerm);
  rTerm.BuildString;
  rTerm.RegisterTermParentsIn(Self);
  X2 := 0.0;
  Y2 := 0.0;
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

constructor TGXCircle.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  If GO = Nil then begin
    rTerm := TTBaum.Create(Nil, Rad);
    rTerm.BuildTree('1');
    end
  else begin
    rTerm := TTBaum.Create(GO.ObjList, Rad);
    rTerm.BuildTree(TGXCircle(GO).rTerm.source_str);
    end;
  end;

procedure TGXCircle.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  FreeAndNil(rTerm);
  rTerm := TTBaum.CreateFromGeoNumString
                    ((BluePrint as TGXCircle).rTerm.GeoNumString, MakNum, ObjList);
  If rTerm.Status = tbOkay then
    rTerm.RegisterTermParentsIn(Self);
  end;

constructor TGXCircle.Load(S: TFileStream; iObjList: TGeoObjListe);
  var idNum : Integer;
  begin
  Inherited Load(S, iObjList);
  idNum := ReadOldIntFromStream(S);
  If idNum = 140 then
    rTerm := TTBaum.Load(ObjList, S)
  else begin
    rTerm := Nil;
    Raise EStreamError.Create('TermObjekt erwartet!');
    end;
  end;

constructor TGXCircle.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  rTerm := TTBaum.Load32(ObjList, R);
  end;

constructor TGXCircle.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var s    : WideString;
      rTag : IXMLNode;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  rTag := DE.childNodes.findNode('radius', '');
  If rTag.hasAttribute('r_term') then
    s := literalLine(rTag.getAttribute('r_term'))
  else
    s := CDATATagRestored(rTag.nodeValue);
  rTerm := TTBaum.Create(ObjList, ObjList.GetDefAngleMode);
  rTerm.source_str := s;
  end;

constructor TGXCircle.CreateProtoTypFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var s    : WideString;
      rTag : IXMLNode;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  rTag := DE.childNodes.findNode('radius', '');
  If rTag.hasAttribute('r_term') then
    s := literalLine(rTag.getAttribute('r_term'))
  else
    s := CDATATagRestored(rTag.nodeValue);
  rTerm := TTBaum.Create(iObjList, Rad);
  rTerm.fgeonum_str := s;
  end;

procedure TGXCircle.AfterLoading(FromXML: Boolean);
  var pu: Double;
  begin
  Inherited AfterLoading(FromXML);
  rTerm.UpdateDegSourceAndBuildTree(rTerm.source_str, False);
  rTerm.Calculate(1.0, pu);
  If (rTerm.Status = tbOkay) and
     (pu > - epsilon) then begin
    If pu < epsilon then pu := 0.0;
    Radius := pu;
    DataValid := True;
    end
  else begin
    Radius := -1;
    DataValid := False;
    end;
  end;

function TGXCircle.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var domRad : IXMLNode;
      radstr : WideString;
  begin
  Y2 := Y1;
  If Radius > 0 then
    X2 := X1 + Radius
  else
    X2 := X1;
  Result := Inherited CreateObjNode(DOMDoc);
  domRad := DomDoc.createNode('radius');
  If Assigned(rTerm.baum) then begin
    rTerm.BuildString;
    radStr := rTerm.source_str;
    end
  else
    radStr := FloatToStr(Radius);
  domRad.setAttribute('r_term', maskDelimiters(radStr));
  Result.childNodes.replaceNode(Result.childNodes.FindNode('radius', ''), domRad);
  end;

function TGXCircle.CreatePrototypNode(DOMDoc: IXMLDocument): IXMLNode;
  var domRad : IXMLNode;
      s      : WideString;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  domRad := DomDoc.createNode('radius');
  s := CDATACompatible(rTerm.GeoNumString);
  domRad.childNodes.add(DomDoc.createNode(s, ntCData));
  Result.childNodes.replaceNode(Result.childNodes.findNode('radius', ''), domRad);
  end;

procedure TGXCircle.UpdateV1xObjects;
  begin
  Inherited UpdateV1xObjects;
  rTerm.RegisterTermParentsIn(Self);
  end;

procedure TGXCircle.VirtualizeCoords;
  begin
  sx1 := SafeRound(X1 * ppcm_corrfactor);
  sy1 := SafeRound(Y1 * ppcm_corrfactor);
  ObjList.GetLogCoords(sx1, sy1, X1, Y1);
  Radius := Radius * ppcm_corrFactor / ObjList.e1x;
  end;

procedure TGXCircle.UpdateOldPrototype;
  begin
  Inherited UpdateOldPrototype;
  rTerm.ConvertSource2GeoNumString;
  end;

function TGXCircle.DataEquivalent(var data): Boolean;
  var vbaum    : TTBaum;
      vbaumstr : String;
  begin
  vbaum := TTBaum.Create(ObjList, Rad);
  vbaumstr := String(data);
  try
    vbaum.BuildTree(vbaumstr);
    If vbaum.Status = tbOkay then
      DataEquivalent := rTerm.HasSameDataAs(vbaum)
    else
      DataEquivalent := False;
  finally
    vBaum.Free;
  end;
  end;

function TGXCircle.HasSameDataAs(GO: TGeoObj): Boolean;
  var term : String;
  begin
  term := rTerm.source_str;
  Result := (GO.ClassType = TGXCircle) and
            (GO.Parent[0] = Self.Parent[0]) and
            (TGXCircle(GO).DataEquivalent(term));
  end;

procedure TGXCircle.UpdateParams;
  var pu : Double;
  begin
  If Parent.Count = 0 then Exit;
  rTerm.Calculate(1.0, pu);
  If (rTerm.Status = tbOkay) and
     (pu > - epsilon) then begin
    If pu < epsilon then pu := 0.0;
    Radius := pu;
    DataValid := True;
    Inherited UpdateParams;
    end
  else begin
    Radius := -1;
    DataValid := False;
    end;
  end;

procedure TGXCircle.SetNewRadius(rStr: WideString);
  begin
  HideIt;
  rTerm.UnregisterTermParentsIn(Self) ;
  rTerm.BuildTree(rStr);
  rTerm.RegisterTermParentsIn(Self);
  UpdateParams;
  DrawIt;
  end;

procedure TGXCircle.RebuildTermStrings;
  begin
  HideIt;
  rTerm.BuildString;
  DrawIt;
  end;

function TGXCircle.HasBuggyTerm: Boolean;
  begin
  If rTerm.status = tbEmpty then
    rTerm.BuildTree(rTerm.source_str);
  Result := rTerm.status <= tbCompError;
  end;

procedure TGXCircle.LoadContextMenuEntriesInto(menu: TPopupMenu);
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_radius, CME_PopupClick, cmd_EditRadius);
  end;

function TGXCircle.GetInfo: String;
  var s : String;
  begin
  s := rTerm.GetHTMLString;
  Result := Format(MyObjTxt[32], [s]);
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  end;

destructor TGXCircle.Destroy;
  begin
  rTerm.UnregisterTermParentsIn(Self);
  FreeAndNil(rTerm);
  Inherited Destroy;
  end;

destructor TGXCircle.FreeBluePrint;
  begin
  FreeAndNil(rTerm);
  inherited FreeBluePrint;
  end;



{-------------------------------------------}
{ TGXLine's Methods Implementation          }
{-------------------------------------------}

constructor TGXLine.Create(iObjList: TGeoObjListe; iP1, iSP : TGeoObj;
                           iWTerm : WideString; iis_visible : Boolean);
  begin
  Inherited Create(iObjList, iP1, iSP, 1, False);
  wTerm   := TTBaum.Create(ObjList, Rad);
  wTerm.BuildTree(iWTerm);
  wTerm.BuildString;
  wTerm.RegisterTermParentsIn(Self);
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  UpdateParams;
  DrawIt;
  end;

constructor TGXLine.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  If GO = Nil then begin
    wTerm := TTBaum.Create(Nil, Rad);
    wTerm.BuildTree('0.1');
    end
  else begin
    wTerm := TTBaum.Create(GO.ObjList, Rad);
    wTerm.BuildTree(TGXLine(GO).wTerm.source_str);
    end;
  end;

procedure TGXLine.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  FreeAndNil(wTerm);
  wTerm := TTBaum.CreateFromGeoNumString
                    ((BluePrint as TGXLine).wTerm.GeoNumString, MakNum, ObjList);
  If wTerm.Status = tbOkay then
    wTerm.RegisterTermParentsIn(Self);
  end;

constructor TGXLine.Load(S: TFileStream; iObjList: TGeoObjListe);
  var idNum : Integer;
  begin
  Inherited Load(S, iObjList);
  idNum := ReadOldIntFromStream(S);
  If idNum = 140 then
    wTerm := TTBaum.Load(ObjList, S)
  else begin
    wTerm := Nil;
    Raise EStreamError.Create('TermObjekt erwartet!');
    end;
  end;

constructor TGXLine.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  wTerm := TTBaum.Load32(ObjList, R);
  end;

constructor TGXLine.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var s : String;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  wTerm := TTBaum.Create(iObjList, ObjList.GetDefAngleMode);
  s := DE.childNodes.findNode('term', '').nodeValue;
  DeleteChars(#09#10#13, s);  // 11.04.2010 :  Tabs + Zeilenumbruch-Reste weg !
  wTerm.source_str := s;
  end;

constructor TGXLine.CreateProtoTypFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  wTerm := TTBaum.Create(iObjList, Rad);
  wTerm.fgeonum_str := DE.childNodes.findNode('term', '').nodeValue;
  end;

procedure TGXLine.AfterLoading(FromXML: Boolean);
  var ws: WideString;
  begin
  Inherited AfterLoading(FromXML);
  ws := wTerm.source_str;
  wTerm.UpdateDegSourceAndBuildTree(ws, True);
  end;

function TGXLine.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var domAngle : IXMLNode;
      s  : WideString;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  domAngle := DOMDoc.createNode('term');
  wTerm.BuildString;
  s := HTMLKillAllTags(wTerm.source_str);
  domAngle.childNodes.add(DOMDoc.createNode(s, ntText));
       // 30.12.10    Parameter "ntText" hinzugefügt wg. BugReport v.
       //             Franz Klement: Gerade in bestimmtem Winkel kann
       // nicht abgespeichert werden! ==> Fixed in 3.6a !!!
  Result.childNodes.add(domAngle);
  end;

function TGXLine.CreatePrototypNode(DOMDoc: IXMLDocument): IXMLNode;
  var domAngle : IXMLNode;
      s        : WideString;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  domAngle := DOMDoc.createNode('term');
  s := CDATACompatible(wTerm.GeoNumString);
  domAngle.childNodes.add(DOMDoc.createNode(s, ntText));
  Result.childNodes.add(domAngle);
  end;

procedure TGXLine.UpdateV1xObjects;
  begin
  Inherited UpdateV1xObjects;
  wTerm.RegisterTermParentsIn(Self);
  end;

procedure TGXLine.UpdateOldPrototype;
  begin
  Inherited UpdateOldPrototype;
  wTerm.ConvertSource2GeoNumString;
  end;

destructor TGXLine.Destroy;
  begin
  wTerm.UnregisterTermParentsIn(Self);
  FreeAndNil(wTerm);
  Inherited Destroy;
  end;

destructor TGXLine.FreeBluePrint;
  begin
  FreeAndNil(wTerm);
  inherited FreeBluePrint;
  end;

function TGXLine.HasSameDataAs(GO: TGeoObj): Boolean;
  var term : String;
  begin
  term   := wTerm.source_str;
  Result := (GO.ClassType = TGXLine) and
            (GO.Parent[0] = Self.Parent[0]) and
            (GO.Parent[1] = Self.Parent[1]) and
            (GO.DataEquivalent(term));
  end;

procedure TGXLine.UpdateParams;
  var pu : Double;
  begin
  DataValid := False;
  If wTerm <> Nil then begin
    wTerm.Calculate(1.0, pu);
    If wTerm.Status = tbOkay then begin
      dAngle    := pu;
      DataValid := True;
      Inherited UpdateParams;
      end;
    end;
  end;

function TGXLine.DataEquivalent(var data): Boolean;
  var vbaum : TTBaum;
      vbaumstr : String;

  function DE (tb1, tb2 : TKnoten): Boolean;
    begin
    If tb1 <> Nil then
      If tb2 <> Nil then
        If tb1.token = tb2.token then
          Case tb1.token of
             0 : DE := tb1.value = tb2.value;
            22,
            23 : DE := DE(tb1.right_ch.right_ch,
                          tb2.right_ch.right_ch);
          else
            DE := DE(tb1.left_ch,  tb2.left_ch ) and
                  DE(tb1.right_ch, tb2.right_ch);
          end { of case }
        else
          DE := False
      else
        DE := False
    else
      DE := tb2 = Nil;
    end;

  begin
  vbaum := TTBaum.Create(ObjList, Rad);
  vbaumstr := String(data);
  try
    vbaum.BuildTree(vbaumstr);
    If vbaum.Status = tbOkay then
      DataEquivalent := DE(vbaum.Baum, wTerm.Baum)
    else
      DataEquivalent := False;
  finally
    vBaum.Free;
  end;
  end;

procedure TGXLine.SetNewAngle(wStr: WideString);
  begin
  HideIt;
  wTerm.UnregisterTermParentsIn(Self) ;
  wTerm.BuildTree(wStr);
  wTerm.RegisterTermParentsIn(Self);
  UpdateParams;
  DrawIt;
  end;

procedure TGXLine.RebuildTermStrings;
  begin
  HideIt;
  wTerm.BuildString;
  DrawIt;
  end;

function TGXLine.HasBuggyTerm: Boolean;
  begin
  If wTerm.status = tbEmpty then
    wTerm.BuildTree(wTerm.source_str);
  Result := wTerm.status <= tbCompError;
  end;

procedure TGXLine.LoadContextMenuEntriesInto(menu: TPopupMenu);
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_angle, CME_PopupClick, cmd_EditAngle);
  end;

function TGXLine.GetInfo: String;
  var s : String;
  begin
  wTerm.BuildString;
  s := wTerm.GetHTMLString;
  Result := Format(MyObjTxt[33], [s]);
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;


{-------------------------------------------}
{ TGXRay's Methods Implementation           }
{-------------------------------------------}

procedure TGXRay.DrawIt;
  begin
  inherited DrawIt;

  end;

procedure TGXRay.HideIt;
  begin
  inherited HideIt;

  end;

function TGXRay.Includes(xp, yp: Double): Boolean;
  var tv : Double;
  begin
  If Inherited Includes(xp, yp) then begin
    tv  := -1;
    Result := GetTV(X1, Y1, X2, Y2, xp, yp, tv) and (tv >= -DistEpsilon);
    end
  else
    Result := False;
  end;

function TGXRay.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  { Parameter-Bereich 0..1, sofern P(px|py) zwischen den
    definierenden Punkten Parent[0] und Parent[1] liegt }
  var e_rv : TFloatPoint;
  begin
  e_rv := GetNormalizedDirection;
  Result := GetTV(X1, Y1, X1 + e_rv.x, Y1 + e_rv.y, px, py, param);
  end;

function TGXRay.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var e_rv : TFloatPoint;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  If DataValid then begin
    e_rv := GetNormalizedDirection;
    px := X1 + param * e_rv.x;
    py := Y1 + param * e_rv.y;
    Result := True;
    end;
  end;


procedure TGXRay.UpdateScreenCoords;
  var rX2, rY2 : Double;

  procedure MoveSecondPointOff;
    var dr   : Double;
        e_rv : TFloatPoint;
    begin
    If DataValid then begin
      if ObjList.LogWinKnows(X1, Y1) = 1 then begin
        X := X1;  Y := Y1; end
      else
        If ObjList.LogWinKnows(X2, Y2) = 1 then begin
          X := X2;  Y := Y2; end
        else
          If Not GetPedalPoint (X1, Y1, X2, Y2,
                                ObjList.xCenter, ObjList.yCenter,
                                X, Y) then begin
            DataValid := False;
            Exit;
            end;
      dr   := 3.0 * ObjList.LogWinRadius;
      e_rv := GetNormalizedDirection;
      rX2  := X + e_rv.x * dr;
      rY2  := Y + e_rv.y * dr;
      end;
    end;

  begin
  If DataValid then begin
    MoveSecondPointOff;
    DataCanShow := DataValid and LineIntersectsWindow;
    If DataCanShow then begin
      ObjList.GetWinCoords( X1,  Y1, sx1, sy1);
      ObjList.GetWinCoords(rX2, rY2, sx2, sy2);
      end;
    end;
  end;

function TGXRay.GetInfo: String;
  var s : String;
  begin
  wTerm.BuildString;
  s := wTerm.GetHTMLString;
  Result := Format(MyObjTxt[107], [s]);
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  end;



{-------------------------------------------}
{ TGComment's Methods Implementation        }
{-------------------------------------------}

constructor TGComment.Create(iObjList: TGeoObjListe; iColor: Word; iOrg: TPoint);
  begin
  Inherited Create(iObjList, True);
  FMyColour := ColorTable[iColor];
  scrx := iOrg.X;
  scry := iOrg.Y;
  ObjList.GetLogCoords(scrx, scry, X, Y);
  x_Offset := 0;
  y_Offset := 0;
  UpdateParams;
  DrawIt;
  end;

constructor TGComment.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Halt;  // Abbruch
  end;

constructor TGComment.Load(S: TFileStream; iObjList: TGeoObjListe);
  var CText    : String;
  begin
  Inherited Load(S, iObjList);
  S.Read(X, SizeOf(X));
  S.Read(Y, SizeOf(Y));
  BMPText.Width  := ReadOldIntFromStream(S);
  BMPText.Height := ReadOldIntFromStream(S);
  With OutRect do begin
    left   := Round(X);
    top    := Round(Y);
    right  := left + BMPText.Width;
    bottom := top  + BMPText.Height;
    end;

  CText   := ReadOldStrFromStream(S); { 1. Textvariante "weglesen" }
  OldText := ReadOldStrFromStream(S); { 2. Textvariante einlesen   }
  HTMLText := RTF2HTML(OldText);
  FMyColour := clBlack;  { zwangsweise !!! }
  RenderWin.X := BMPText.Width;
  RenderWin.Y := BMPText.Height;
  end;

constructor TGComment.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  end;

constructor TGComment.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  end;

procedure TGComment.AfterLoading(FromXML: Boolean);
  begin
  Inherited AfterLoading(FromXML);
//  If (ClassType = TGComment) and (Parent.Count > 0) then  // gebundene Textbox
//    SetNewRelativPos;
  If Parent.Count > 0 then
    TGeoObj(Parent[0]).SetNewNameParamsIn(Self)
  else begin
    rConst := 0;
    sConst := 0;
    end;
  end;

function TGComment.DefaultName: WideString;
  begin
  DefaultName := ObjList.GetUniqueName('tb');
  end;

function TGComment.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId = ccComment) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGComment.GetMatchingCursor(mpt: TPoint): TCursor;
  var linkTag : Integer;
  begin
  If PtInRect(OutRect, mpt) then begin
    linkTag := GetLinkTagFromWinPos(mpt);
    If linkTag = 0 then
      Result := Hand_Cursor
    else
      Result := crArrow;
    end
  else
    Result := crArrow;
  end;

function TGComment.IsDynamic: Boolean;
  begin
  Result := (paraCount > 0) or (Assigned(FormatText) and
                                Assigned(FormatText.LinkList) and
                                (FormatText.LinkList.Count > 0));
  end;

function TGComment.GetLinkTagFromWinPos(wpos: TPoint): Integer;
  var rpos: TPoint;
      fc  : TCharacter;
  begin
  Result := 0;
  If Assigned(FormatText) then begin
    wpos.X := wpos.X - scrx;
    wpos.Y := wpos.Y - scry;
    rpos := FormatText.GetCharInPos(wpos);
    fc := FormatText.GetCharacter(rpos);
    If fc <> Nil then
      Result := fc.Font.Tag;
    end;
  end;

function TGComment.GetLinkAddressFromTag(ltag: Integer): String;
  begin
  Result := '';
  If Assigned(FormatText) then
    Result := FormatText.GetLinkAddress(ltag);
  end;

function TGComment.GetLeadingParas(pc: Integer; s: String): String;
  var n, c: Integer;
  begin
  Result := s;
  If (pc > 0) and (pc < paraCount) then begin
    n := Pos('<hr>', s);
    If n > 0 then begin
      c := 1;
      While (c > 0) and (c < pc) do begin
        n  := PosEx('<hr>', s, n + 4);
        c  := c + 1;
        end;
      If c = pc then begin                      // abschneiden !
        n := GetNextPlainCharIndex(s, n + 4);
        If n > 1 then
          Result := Copy(s, 1, n - 1);
        end;
      end;
    end;
  end;

procedure TGComment.SetHTMLText(s: String);
  begin
  // Falls nötig fügt die folgende Funktion auch den letzten Strich hinzu oder
  // löscht diesen, falls er der einzige ist und keine Textzeichen mehr folgen.
  paraCount := CountHRDelimitedParas(s);
  FHTMLText := s;
  If paraCount > 0 then begin
    If paraVisNum > paraCount then
      paraVisNum := paraCount
    else
      if paraVisNum = 0 then
        paraVisNum := 1     // Andernfalls paraVisNum ungeändert lassen !
    end
  else
    paraVisNum := 0;
  RenderHTML2BMP;           // Neu rendern !
  end;

procedure TGComment.RenderHTML2BMP;
  var SL        : TStringList;
      ACPos     : TPoint;
      sel       : TSelection;
      newFont   : TFormatFont;
      LinkText  : String;
      LinkIndex : Integer;
      RenderBMP : TBitmap;
      R         : TRect;
      n, i      : Integer;
  begin
  If BMPText = Nil then Exit;
  SL := TStringList.Create;
  try
    SL.Add(GetLeadingParas(paraVisNum, HTMLText));
    If Not Assigned(FormatText) then
      FormatText := TFormatText.Create(SL, OutRect, ObjList.FTargetCanvas)
    else begin
      FormatText.Canvas := ObjList.FTargetCanvas;
      FormatText.SetHTMLText(SL, ObjList.StartFont);
      end;
    If paraCount > 0 then begin
      Assert(paraVisNum > 0, 'paraVisNum = 0  trotz  paraCount > 0!');
      If paraVisNum < paraCount then begin
        linkText  := '[ <font face="Symbol">ß</font> ]';
        linkIndex := 1000;
        end
      else begin    // also wenn paraVisNum = paraCount
        linkText  := '[ <font face="Symbol">Ý</font> ]';
        linkIndex := 1001;
        end;
      ACPos := Point(0, FormatText.Lines - 1);
      FormatText.InsertHTMLText(ACPos, linktext);
      sel.Start := ACPos;
      sel.Ende  := Point(ACPos.X + Length(linktext) - 1, ACPos.Y);
      newFont   := TFormatFont.Create(FormatText.GetCharFont(ACPos));
      try
        newFont.Color := clBlue;
        newFont.Tag   := linkIndex;
        FormatText.ChangeFont(sel, newFont, [fcColor, fcTag]);
        newFont.Style := newFont.Style + [fsUnderline];
        sel.Start.X := sel.Start.X + 1;
        sel.Ende.X  := sel.Start.X + 3; //  sel.Ende.X - 2;
        FormatText.ChangeFont(sel, newFont, [fcUnderline]);
      finally
        newFont.Free;
      end;
      end;

    R := Rect(0, 0, RenderWin.X, RenderWin.Y);
    RenderBMP := TBitmap.Create;
    try
      try
        { Der folgende Code stellt sicher, dass die erste Zeile nicht nur
          Leerzeichen oder gar keine Zeichen enthält. }
        Repeat     // 21.04.05: neu geschrieben !!!
          n := FormatText.CharactersInLine(0);
          If n > 0 then begin
            For i := Pred(n) downto 0 do
              If FormatText.GetLine(0).GetCharacter(i).Character < ' ' then
                FormatText.Delete(Point(i, 0));
            n := FormatText.CharactersInLine(0);
            end;
          If (n = 0) and (FormatText.Lines > 1) then
            FormatText.Merge(0);
        until (n > 0) or (FormatText.Lines = 1);

        { Bitmap vorbereiten }
        If (RenderWin.X <= 0) and (RenderWin.Y <= 0) then begin
          n := FormatText.GetWidth;
          If n > RenderWin.X - 10 then begin
            RenderWin.X := n + 10;
            R.Right := n + 10;
            end;
          n := FormatText.GetHeight;
          If n > RenderWin.Y - 6 then begin
            RenderWin.Y := n + 6;
            R.Bottom := n + 6;
            end;
          end;
        FormatText.SetClientRect(R);

        With RenderBMP do begin
          Width  := RenderWin.X;
          Height := RenderWin.Y;
          end;
        With RenderBMP.Canvas do begin
          Brush.Style := bsSolid;
          Brush.Color := ObjList.BackgroundColor;
          Pen.Color   := Brush.Color;
          FillRect(R);
          end;

        { Rendern }
        FormatText.Canvas := RenderBMP.Canvas;
        FormatText.Paint(False);    // Eingestellte Fontgrößen verwenden !
        CopyReducedBitmap(RenderBMP, BMPText);
        With OutRect do begin
          right := left + BMPText.Width;
          bottom := top + BMPText.Height;
          end;
      finally
        FormatText.Canvas := ObjList.FTargetCanvas;
      end;
    finally
      RenderBMP.Free;
    end;
  finally
    SL.Free;
  end;

  ReplaceColorShades(BMPText, ObjList.BackgroundColor, clBlack, FMyColour);
  DataValid := LoadMasks;
  end;

procedure TGComment.BecomesChildOf(GO: TGeoObj);
  begin
  Inherited BecomesChildOf(GO);
  If IsVisible then begin    { Sollte eigentlich *immer* der Fall sein ! }
    HideIt;
    SetNewAbsolutePos(TGParentObj(GO).GetWinPosNextTo(X, Y));
    SetNewRelativPos;
    DrawIt;
    end;
  end;

procedure TGComment.Stops2BeChildOf(GO: TGeoObj);
  begin
  If IsVisible then begin
    HideIt;
    SetNewAbsolutePos(Point(scrx + 15, scry + 15));
    DrawIt;
    end;
  Inherited Stops2BeChildOf(GO);
  end;

procedure TGComment.InitMoving(xm, ym: Integer);
  begin
  Inherited InitMoving(xm, ym);
  x_Offset  := xm - scrx;
  y_Offset  := ym - scry;
  end;

function TGComment.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := False;
  end;

procedure TGComment.VirtualizeCoords;
  begin
  If (Abs(scrx) + Abs(scry) = 0) and (Abs(X) + Abs(Y) > 0) then begin
    scrx := Round(X);
    scry := Round(Y);
    ObjList.GetLogCoords(scrx, scry, X, Y);
    end;
  end;

procedure TGComment.Rescale;
  begin
  If Parent.Count = 0 then
    ObjList.GetLogCoords(scrx, scry, X, Y)
  else
    UpdateParams;
  end;

procedure TGComment.Expand;
  var lh : Double;  // "l"ogical "h"eight (of the comment window)
  begin
  If (paraCount > 0) and (paraVisNum < paraCount) then begin
    paraVisNum := paraVisNum + 1;
    HideIt;
    RenderHTML2BMP;
    lh := BMPText.Height / Abs(ObjList.e2y) + 0.5;
    If Y - lh < ObjList.yMin then begin  // unterer Textrand unterhalb des
      Y := ObjList.yMin + lh;            //    unteren Fensterrandes
      UpdateScreenCoords;
      end;
    end;
  end;

procedure TGComment.Collapse;
  begin
  If (paraCount > 0) then begin
    paraVisNum := 1;
    HideIt;
    RenderHTML2BMP;
    If Y > ObjList.yMax then begin       // oberer Textrand oberhalb des
      Y := ObjList.yMax - 0.5;           //    oberen Fensterrandes
      UpdateScreenCoords;
      end;
    end;
  end;

procedure TGComment.GetDataFrom(SEdit: TFormatEdit);
  begin
  Assert(SEdit <> Nil, 'FormatEdit-Parameter ist NIL !');
  If Assigned(FormatText) then
    FormatText.Canvas := SEdit.Canvas
  else
    FormatText := TFormatText.Create(Nil, OutRect, SEdit.Canvas);
  RenderWin.X := SEdit.Width;
  RenderWin.Y := SEdit.Height;
  HTMLText    := SEdit.HTMLTextAsString;  { Ruft intern RenderHTML2BMP auf ! }
  DataCanShow := DataValid;
  UpdateParams;  { setzt OutRect !!!  (03.12.99) }
  ObjList.IsDirty := True;
  end;

procedure TGComment.UpdateParams;
  begin
  If ObjList.IsLoading then Exit;
  DataValid := True;
  If IsMoving then begin
    scrx := ObjList.LastMousePos.X - x_Offset;
    scry := ObjList.LastMousePos.Y - y_Offset;
    ObjList.GetLogCoords(scrx, scry, X, Y);
    end
  else
    If Parent.Count > 0 then begin   { Gebundene Textboxen }
      TGeoObj(Parent[0]).UpdateNameCoordsIn(Self);
      If Not TGeoObj(Parent[0]).DataValid then
        DataValid := False;
{
        FStatus := FStatus or gs_ShowsAlways
      else
        FStatus := FStatus and Not gs_ShowsAlways;
}
      end
    else                             { Freie Textboxen     }
      If ObjList.OutputStatus in [outPreview, outPrinter, outFile] then
        ObjList.GetWinCoords(X, Y, scrx, scry)
      else
        ObjList.GetLogCoords(scrx, scry, X, Y);
  UpdateScreenCoords;
  end;

procedure TGComment.DrawIt;
  var CM : TCopyMode;
  begin
  If IsVisible then with ObjList.TargetCanvas do begin
    AdjustGraphTools(True);
    If DataValid then begin
      CM := CopyMode;
      CopyMode := cmSrcAnd;
      Draw(scrx, scry, BMPTextAND);
      CopyMode := cmSrcPaint;
      Draw(scrx, scry, BMPTextOR);
      CopyMode := CM;
      end;
    end;
  end;

procedure TGComment.HideIt;
  begin
  If IsVisible then with ObjList.TargetCanvas do begin
    AdjustGraphTools(False);
    FillRect(OutRect);
    end;
  end;

procedure TGComment.ExportIt;
  { 31.05.2013 : Andreas Katzengruber meldet im Forum einen Bug:
                 zwei Textboxen, die in der Zeichnung gleichgroße Fonts
    verwenden, konnten bei skaliertem Export in eine Pixel-Grafik-Datei
    dort mit verschieden großen Fonts dargestellt werden.
    Zur Behebung dieses Missstandes wird in der folgenden Export-Routine ein
    gemeinsamer Skalierungsfaktor namens "ObjList.FontScaleFactor" verwendet,
    der für *alle* Textboxen der aktuellen Konstruktion passt. Sofern dieser
    Parameter einen positiven (und damit gültigen) Wert hat, wird er zur
    Skalierung aller Textboxen eingesetzt. Andernfalls wird die "alte" und
    fehlerbehaftete Auto-Resize-Funktion aus TFormatText für jede Textbox
    einzeln benutzt.
    Siehe auch: "TGeoObjListe.GetNewFontScaleFactor()"                        }

  var SL   : TStringList;
      FT   : TFormatText;
      R    : TRect;
      sf   : Double;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    UpdateScreenCoords;
    SL := TStringList.Create;
    try
      SL.Text  := GetLeadingParas(paraVisNum, HTMLText);
      R.Left   := scrx;
      R.Top    := scry;
      R.Right  := scrx + Round((OutRect.Right - OutRect.Left) * 1.04);
      R.Bottom := scry + Round((OutRect.Bottom - OutRect.Top) * 1.04);
      FT := TFormatText.Create(SL, R, ObjList.TargetCanvas);
      try
        Case ObjList.OutputStatus of
          outPrinter : sf := prn_UserScaleF;
          outPreview : sf := ObjList.ScaleFactor;
        else
          if ObjList.FontScaleFactor > mathlib.epsilon then
            sf := ObjList.FontScaleFactor
          else
            sf := 1;
        end;
        If Abs(sf - 1) > 1e-5 then begin
          FT.SetDisplayFactor(sf);
          FT.PaintTransparent(R, MyColour, False); // Do not resize any more!
          end
        else
          FT.PaintTransparent(R, MyColour, True);  // Resize!
      finally
        FT.Free;
      end;
    finally
      SL.Free;
    end;
    end;
  end;

procedure TGComment.SetNewAbsolutePos(newPos: TPoint);
  begin
  ObjList.GetLogCoords(newPos.X, newPos.Y, X, Y);
  If Parent.Count > 0 then
    TGeoObj(Parent[0]).SetNewNameParamsIn(Self);
  UpdateScreenCoords;
  end;

procedure TGComment.SetNewRelativPos;
  begin
  If Parent.Count > 0 then
    TGeoObj(Parent[0]).SetNewNameParamsIn(Self);
  IsMoving := False;
  end;

procedure TGComment.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  menu.Items.Clear;    { "Free"d auch die einzelnen Items ! }
  AddPopupMenuItemTo(menu, cme_hide, CME_PopupClick, cmd_ToggleVis);
  AddPopupMenuItemTo(menu, cme_col, CME_PopupClick, cmd_EditColour);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_edit, CME_PopupClick, cmd_NameObj);
  If Parent.Count > 0 then
    AddPopupMenuItemTo(menu, cme_tboxfree, CME_PopupClick, cmd_ReleaseTBox)
  else
    AddPopupMenuItemTo(menu, cme_tboxbind, CME_PopupClick, cmd_BindTBox2Obj);
  end;

function TGComment.GetInfo: String;
  begin
  Result := MyObjTxt[36];
  end;


{-------------------------------------------}
{ TGNumber's Methods Implementation         }
{-------------------------------------------}

function TGNumber.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccDragableObj, ccAnyAngleObj,
                              ccMeasureObj]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGNumber.IsNearMouse: Boolean;
  begin
  Result := Dist(ObjList.LogLastMouse_X, ObjList.LogLastMouse_Y) * ObjList.e1x < CatchDist;
  end;

procedure TGNumber.Rescale;
  { Behält die relative Position im Ausgabefenster bei !!! }
  begin
  LastDist := 1.0e300;
  If ObjList.OutPutStatus in [outPreview, outPrinter] then
    ObjList.GetWinCoords(X, Y, scrx, scry)
  else
    ObjList.GetLogCoords(scrx, scry, X, Y);
  UpdateScreenCoords;
  end;

procedure TGNumber.VirtualizeCoords;
  begin
  ObjList.GetLogCoords(scrx, scry, X, Y);
  end;

procedure TGNumber.SetMyShape(newVal: Integer);
  begin
  if FMyShape <> newVal then begin
    HideIt;
    FMyShape := newVal;
    UpdateScreenCoords;
    DrawIt;
    end;
  end;

procedure TGNumber.SetShowName(newval : Boolean);
  begin
  If newval <> FShowName then begin
    HideIt;
    FShowName := newval;
    UpdateScreenCoords;
    DrawIt;
    end;
  end;

procedure TGNumber.ReDimData;
  begin
  ObjList.GetLogCoords(scrx, scry, X, Y);
  UpdateScreenCoords;
  end;

procedure TGNumber.SetNewName(NewName: WideString);
  var vis : Boolean;
  begin
  vis := IsVisible;
  If vis then HideIt;
  Inherited SetNewName(NewName);
  LastDist := 1.0e300;
  UpdateParams;
  If vis then DrawIt;
  end;

procedure TGNumber.AdjustGraphTools(todraw: Boolean);
  begin
  Inherited AdjustGraphTools(todraw);
  With ObjList.TargetCanvas do begin
    Pen.Style   := psSolid;
    Pen.Width   := Round(1 * ObjList.ScaleFactor);
    Brush.Style := bsSolid;
    Brush.Color := ObjList.BackgroundColor;
    Font.Assign(ObjList.StartFont);
    Font.Height := Round(-12 * ObjList.ScaleFactor);
    If todraw then
      Font.Color := Pen.Color
    else
      Font.Color := ObjList.BackgroundColor;
    end;
  end;

procedure TGNumber.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  menu.Items.Clear;    { "Free"d auch die einzelnen Items ! }
  AddPopupMenuItemTo(menu, cme_hide, CME_PopupClick, cmd_ToggleVis);
  AddPopupMenuItemTo(menu, cme_name, CME_PopupClick, cmd_NameObj);
  AddPopupMenuItemTo(menu, cme_col, CME_PopupClick, cmd_EditColour);
  end;

procedure TGNumber.InsertMeasureInto(Target: TFormatEdit);
  begin
  Target.Paste(' ' + Name + ' ');
  end;

procedure TGNumber.ShowCentered(Canvas: TCanvas; v: Double;
                                R: TRect; prec: Integer; Prefix: String = '');
  var buf : String;
  begin
  buf := FloatToStrF(v, ffGeneral, prec, 0);
  If Length(buf) > prec + 3 then
    buf := FloatToStrF(v, ffExponent, prec, 0);
  If Length(Prefix) > 0 then
    buf := Prefix + buf;
  ShowCentered(Canvas, buf, R);
  end;

procedure TGNumber.ShowCentered(Canvas: TCanvas; valStr: WideString; R: TRect);
  begin
{
  With Canvas do
    TextOut((R.left + R.right - TextWidth(valStr)) div 2,
            (R.Top + R.Bottom - TextHeight(valStr)) div 2, valStr);
}
  draw_htmlText_on(Canvas,
                   (R.Left + R.Right - Canvas.TextWidth(valStr)) div 2,
                   (R.Top + R.Bottom - Canvas.TextHeight(valStr)) div 2,
                   WideString2HTMLString(valStr));
  end;


{-------------------------------------------}
{ TGNumberObj's Methods Implementation      }
{-------------------------------------------}

constructor TGNumberObj.Create(iObjList: TGeoObjListe; iWidth: Integer;
                               iValMin, iValue, iValMax: Double;
                               iis_visible: Boolean);
  var spot : TPoint;
  begin
  Inherited Create(iObjList, False);
  spot := ObjList.GetFreePlace4NewNumber;
  scrX := spot.x;
  scrY := spot.y;
  ObjList.GetLogCoords(scrx, scry, X, Y);
  If iWidth < 250 then
    NumWidth := 250
  else
    NumWidth  := iWidth;
  NumHeight := 33;
  FValue  := iValue;
  FValMin := iValMin;
  FValMax := iValMax;
  if Self.ClassType = TGNumberObj then
    FQuant    := NumberQuant
  else
    FQuant    := 0.0;
  FAniStep  := DefAniStep;
  FMyColour := clGray;
  FShowName := True;
  UpdateScreenCoords;
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  end;

constructor TGNumberObj.Load32(R: TReader; iObjList: TGeoObjListe);
  var s : String;
      n : Integer;
  begin
  inherited Load32(R, iObjList);
  scrx := R.ReadInteger;
  scry := R.ReadInteger;
  ObjList.GetLogCoords(scrx, scry, X, Y);
  n := R.Position;
  try
    s          := R.ReadString;
    FAniStep   := R.ReadFloat;
  except
    R.Position := n;
    FAniStep   := DefAniStep;
  end;
  NumWidth  := R.ReadInteger;
  NumHeight := R.ReadInteger;
  FValue    := R.ReadFloat;
  FValMin   := R.ReadFloat;
  FValMax   := R.ReadFloat;
  n := R.Position;
  try
    s          := R.ReadString;
    FQuant     := R.ReadFloat;
  except
    R.Position := n;
    FQuant     := NumberQuant;
  end;
  FShowName := R.ReadBoolean;
  FMyShape  := 1;   // Always switch to "Slider view" with these old files !!
  LastDist  := 1.0e300;
  UpdateScreenCoords;
  end;

constructor TGNumberObj.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  If DE.hasAttribute('show_name') then
    FShowName := LowerCase(DE.getAttribute('show_name')) = 'true'
  else
    FShowName := False;

  With DE.childNodes.findNode('position', '') do begin
    X := StrToFloat(getAttribute('x'));
    Y := StrToFloat(getAttribute('y'));
    NumWidth  := StrToInt(getAttribute('width'));
    NumHeight := StrToInt(getAttribute('height'));
    end;

  With DE.childNodes.findNode('value', '') do begin
    FValMin := StrToFloat(getAttribute('min'));
    FValue  := StrToFloat(getAttribute('actual'));
    FValMax := StrToFloat(getAttribute('max'));
    If hasAttribute('quant') then
      FQuant := StrToFloat(getAttribute('quant'))
    else
      FQuant := 0;
    If hasAttribute('ani_step') then
      FAniStep := StrToFloat(getAttribute('ani_step'))
    else
      FAniStep := 0;
    end;

  if MyShape <> 2 then   // if not explicit "Counter view",
    MyShape := 1;        // then always switch to "Slider view"!

  SetAllValues(MinValue, Value, MaxValue, FQuant);
  LastDist := 10000;
  end;

constructor TGNumberObj.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  var nr : TGNumberObj;
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  If GO = Nil then begin
    NumWidth  := 150;
    NumHeight :=  33;
    FValMin :=  -3;
    FValMax :=   8;
    FQuant  := 0.1;
    FValue  :=   1;
    end
  else begin
    nr := GO as TGNumberObj;
    NumWidth  := nr.NumWidth;
    NumHeight := nr.NumHeight;
    FValMin   := nr.MinValue;
    FValMax   := nr.MaxValue;
    FQuant    := nr.FQuant;
    FValue    := nr.Value;
    end;
  end;

procedure TGNumberObj.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  var bp : TGNumberObj;
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  bp := BluePrint as TGNumberObj;
  NumWidth  := bp.NumWidth;
  NumHeight := bp.NumHeight;
  FValMin   := bp.MinValue;
  FValMax   := bp.MaxValue;
  FQuant    := bp.FQuant;
  Value     := bp.Value;
  end;

function TGNumberObj.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var domvalue, position : IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  Result.setAttribute('show_name', LowerCase(BoolToStr(FShowName, True)));

  position := DOMDoc.createNode('position');
  position.setAttribute('x', FloatToStr(X));
  position.setAttribute('y', FloatToStr(Y));
  position.setAttribute('width', IntToStr(NumWidth));
  position.setAttribute('height', IntToStr(NumHeight));
  Result.childNodes.add(position);

  domvalue := DOMDoc.createNode('value');
  domvalue.setAttribute('min', FloatToStr(FValMin));
  domvalue.setAttribute('actual', FloatToStr(FValue));
  domvalue.setAttribute('max', FloatToStr(FValMax));
  domvalue.setAttribute('quant', FloatToStr(FQuant));
  domvalue.setAttribute('ani_step', FloatToStr(FAniStep));
  Result.childNodes.add(domvalue);
  end;

function TGNumberObj.CreateProtoTypNode(DOMDoc: IXMLDocument): IXMLNode;
  var xmlClassName : String;
      position,
      domvalue     : IXMLNode;
  begin
  xmlClassName := ObjList.Get_XMLTypeName(ClassName);
  Assert(xmlClassName <> '', 'Unknown xml class name of "' + ClassName + '"');
  If Length(xmlClassName) = 0 then begin
    Result := Nil;
    Exit;
    end;
  Result := DOMDoc.createNode(xmlClassName);
  Result.setAttribute('id', IntToStr(GeoNum));
  Result.setAttribute('name', FName);

  position := DOMDoc.createNode('position');
  position.setAttribute('x', FloatToStr(X));
  position.setAttribute('y', FloatToStr(Y));
  position.setAttribute('width', IntToStr(NumWidth));
  position.setAttribute('height', IntToStr(NumHeight));
  Result.childNodes.add(position);

  domvalue := DOMDoc.createNode('value');
  domvalue.setAttribute('min', FloatToStr(FValMin));
  domvalue.setAttribute('actual', FloatToStr(FValue));
  domvalue.setAttribute('max', FloatToStr(FValMax));
  domvalue.setAttribute('quant', FloatToStr(FQuant));
  domvalue.setAttribute('ani_step', FloatToStr(FAniStep));
  Result.childNodes.add(domvalue);
  end;

function TGNumberObj.GetAniMinValue: Double;
  begin
  Result := FValMin;
  end;

function TGNumberObj.GetAniMaxValue: Double;
  begin
  Result := FValMax;
  end;

function TGNumberObj.GetAniValue: Double;
  begin
  Result := FValue;
  end;

procedure TGNumberObj.SetAniValue(nav: Double);
  { Setzt voraus, dass in der übergeordneten GeoObjListe (ObjList) schon
    die DragList mit diesem Objekt und seinen Kindern gefüllt wurde. Nur
    dann wird die Zeichnung automatisch korrekt aktualisiert.            }
  var i : Integer;
  begin
  If FValue <> nav then begin
    FValue := Boxed(nav);
    SetPositionFromValue;
    For i := 1 to Pred(ObjList.DragList.Count) do
      TGeoObj(ObjList.DragList[i]).UpdateParams;
    end;
  end;

procedure TGNumberObj.SetValue(newValue: Double);
  begin
  If Abs(FValue - newValue) > epsilon then
    If MyShape = 1 then    // Slider view
      If ObjList.DraggedObj = Self then begin        { normaler Zugmodus }
        FValue      := Boxed(Quantisized(newValue, FQuant));
        FBoundParam := Boxed(newValue);  { unquantisiert, für Ortslinien }
        end
      else begin  { Automations-Modus !!! }
        FValue := Boxed(newValue);
        SetPositionFromValue;
        end
    else begin            // Counter view / Minimized - Darstellung
      FValue := Boxed(Quantisized(newValue, FQuant));
      ObjList.UpdateAllDescendentsOf(self);
      end;
  end;

function TGNumberObj.AdjustValue : Boolean;
  var oldVal : Double;
  begin
  Result := False;
  if MyShape = 2 then begin  // Counter view only !!
    oldVal := Value;
    Case Round(LastDist) of
      -2 : SetValue(Value + FQuant);
      -3 : SetValue(Value - FQuant);
    End; { of case }
    Result := Abs(Value - oldVal) > epsilon;
    if Result then
      ObjList.GroupList.UpdateConditions;
    end;
  end;

procedure TGNumberObj.SetPositionFromValue;
  begin
  valpx   := Round((FValue - FValMin)*(valpxmax - valpxmin)/(FValMax - FValMin)) + valpxmin;
  If valpx < valpxmin then begin
    valpx := valpxmin; Value := FValMin; end;
  If valpx > valpxmax then begin
    valpx := valpxmax; Value := FValMax; end;
  end;

function TGNumberObj.SetLinePosition(tv: Double): Boolean;
  begin
  FValue := tv;
  Result := True;
  end;

function TGNumberObj.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccNumberObj, ccMakroDefObj]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGNumberObj.IsDynamicLocLineControl: Boolean;
  begin
  Result := true;
  end;

function TGNumberObj.IsLineBound(var TL: TGLine): Boolean;
  begin
  TL     := TGLine(Self);
  Result := True;
  end;

function TGNumberObj.CanControlAnimation: Boolean;
  begin
  Result := True;
  end;

function TGNumberObj.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := False;
  end;

function TGNumberObj.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('Z');
  end;

function TGNumberObj.GetMatchingCursor(mpt: TPoint): TCursor;
  var R : TRect;
  begin
  if MyShape = 1 then begin   // Slider_View
    R.TopLeft := MinRect.TopLeft;
    R.BottomRight := MaxRect.BottomRight;
    If PtInRect(R, mpt) then
      Result := Hand_Cursor
    else
      If Hypot(mpt.x - valpx, mpt.y - valpy) < CatchDist then
        Result := Drag_Cursor
      else
        Result := crArrow;
    end
  else begin                  // "Counter_View"
    if (LastDist > -1.5) and (LastDist < -0.5) then
      Result := Hand_Cursor
    else
      Result := crArrow;
    end;
  end;

function TGNumberObj.Dist(xm, ym: Double): Double;
  { 15.11.2012 : [*] Detektierung der AdjustRange-Pfeile deaktiviert, weil
                     die Pfeile mehr Verwirrung als Nutzen gebracht haben.
    Stattdessen wurde neben der bisherigen Ansicht (jetzt "Slider-View"
    genannt) eine verkleinerte Ansicht ("Counter-View") implementiert.
    Weitere Änderungen in this.DrawIt();  }
  var R    : TRect;
      MPos : TPoint;
  begin
  LastDist := 1.0e300;
  ObjList.GetWinCoords(xm, ym, MPos.X, MPos.Y);
  If PtInRect(ObjRect, MPos) then
    If MyShape = 1 then  // SliderView
      If PtInRect(BarRect, MPos) then
        LastDist := Hypot(valpx - MPos.X, valpy - MPos.Y) / ObjList.e1x
      else begin
        R.TopLeft := MinRect.TopLeft;
        R.BottomRight := MaxRect.BottomRight;
        If PtInRect(R, MPos) then
          LastDist := -1;   { Maus steht in oberer Hälfte }
        end
    else begin  // "CounterView"
      If PtInRect(ValRect, MPos) then
        LastDist := -1
      else
        If PtInRect(BarRect, MPos) then
          If MPos.Y < (BarRect.Top + BarRect.Bottom) Div 2 then
            LastDist := -2   // Erhöhen
          else
            LastDist := -3;  // Erniedrigen
      end;
  Result := LastDist;
  end;

function TGNumberObj.GetValue(selector: Integer): Double;
  { 21.09.09 : Rückgabewert für Selector-Wert "gv_angle" auf das Bogenmaß
               des Winkels (also FValue) gesetzt statt auf das Gradmaß !  }
  begin
  Case selector of
    gv_val   : Result := FValue;
    gv_min   : Result := FValMin;
    gv_max   : Result := FValMax;
    gv_quant : Result := FQuant;
  else
    Result := Inherited GetValue(selector);
  end; { of case }
  end;

function TGNumberObj.AdjustBorders: Boolean;
  begin
  If LastDist < -1.5 then begin
    HideIt;
    UpdateParams;
    Redraw;
    Result := True;
    end
  else
    Result := False
  end;

procedure TGNumberObj.SetAllValues(vmin, vact, vmax, vquant: Double);
  begin
  ObjList.FillDragList(Self);
  FValMin := vmin;
  FValMax := vmax;
  If FQuant > - epsilon then
    FQuant  := vquant;
  Value   := Quantisized(vact, FQuant);
  If IsVisible then HideIt;
  SetPositionFromValue;
  If IsVisible then DrawIt;
  end;

procedure TGNumberObj.SetAniParams(vmin, vact, vmax, vstep: Double);
  begin
  ObjList.FillDragList(Self);
  FValMin  := vmin;
  FValMax  := vmax;
  FAniStep := vstep;
  If (vact >= vmin) and (vact <= vmax) then
    Value  := Boxed(vact);
  If IsVisible then HideIt;
  SetPositionFromValue;
  If IsVisible then DrawIt;
  end;

procedure TGNumberObj.ResetOLCPList(PointList : TVector3List);
  begin
  PointList.Reset2StandardList(MinValue, MaxValue, 50);
  end;

procedure TGNumberObj.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@FValue, SizeOf(FValue));
  end;

procedure TGNumberObj.RestoreState;
  begin
  Old_Data.pop(@FValue);
  Inherited RestoreState;
  end;


procedure TGNumberObj.UpdateParams;

  procedure AdjustValue(MoveUpwards: Boolean);
    var v, dv : Double;
    begin
    //Schrittweite ermitteln:
    if FQuant > 0 then
      dv := FQuant
    else begin
      v := (Abs(FValMin) + Abs(FValMax));
      Power(10, Floor(log10(v)-1), dv);
      end;

    // Wert anpassen:
    If MoveUpWards then begin { Erhöhen }
      v := StrToFloat(FloatToStrF(FValue + dv, ffGeneral, 2, 0));
      If v > FValMax then begin
        FValue := FValMax;
        MessageBeep(mb_IconHand);
        end
      else
        FValue := v;
      end
    else begin                { Erniedrigen }
      v := StrToFloat(FloatToStrF(FValue - dv, ffGeneral, 2, 0));
      If v < FValMin then begin
        FValue := FValMin;
        MessageBeep(mb_IconHand);
        end
      else
        FValue := v;
      end;
    end;

  var raw : Double;

  begin
  If LastDist <= CatchDist/ObjList.e1x then
    If LastDist >= 0 then begin          { Schieber verziehen   }
      valpx := ObjList.LastMousePos.x;
      If valpx > valpxmax then valpx := valpxmax;
      If valpx < valpxmin then valpx := valpxmin;
      raw := (valpx - valpxmin)*(FValMax - FValMin)/(valpxmax - valpxmin) + FValMin;
      Value := Quantisized(raw, FQuant);
      end
    else
      Case Round(LastDist) of
        -1 : begin                { Komplett verschieben }
             ObjList.GetLogCoords(scrx, scry, X, Y);
             X := X + ObjList.LastLogMouseDX;
             Y := Y + ObjList.LastLogMouseDY;
             ObjList.GetWinCoords(X, Y, scrx, scry);
             end;
        -2 : AdjustValue(True);   { Wert hoch     }
        -3 : AdjustValue(False);  { Wert runter   }
      end;
  UpdateScreenCoords;
  end;

procedure TGNumberObj.UpdateScreenCoords;
  { Richtet das Objekt gemäß den Daten in X, Y, Width und Height ein }
  var d1, d12, dx : Integer;
  begin
  d1  := Round(     ObjList.ScaleFactor);
  d12 := Round(12 * ObjList.ScaleFactor);
  ObjList.GetWinCoords(X, Y, scrx, scry);
  if (MyShape = 1) then begin  // Slider View
    ObjRect      := Rect(scrx, scry,
                         scrx + Round(NumWidth * ObjList.ScaleFactor),
                         scry + Round(NumHeight * ObjList.ScaleFactor));
    BarRect      := Rect(ObjRect.Left, ObjRect.Bottom - (d12 + 2 * d1),
                         ObjRect.Right, ObjRect.Bottom);
    dx := (ObjRect.Right - ObjRect.Left) Div 4;
    MinRect      := Rect(ObjRect.Left,       ObjRect.Top,
                         ObjRect.Left + dx,  BarRect.Top - d1);
    MaxRect      := Rect(ObjRect.Right - dx, ObjRect.Top,
                         ObjRect.Right,      BarRect.Top - d1);
    ValRect      := Rect(MinRect.Right + d1, ObjRect.Top,
                         MaxRect.Left - d1, BarRect.Top - d1);
    valpy    := (BarRect.Top + BarRect.Bottom) Div 2;
    valpxmin := BarRect.Left + 6;
    valpxmax := BarRect.Right - 7;
    SetPositionFromValue;
    end
  else begin                   // Miniaturansicht ("Counter View")
    ObjRect  := Rect(scrx, scry,
                     scrx + Round((NumWidth Div 3) * ObjList.ScaleFactor),
                     scry + Round((NumHeight Div 2) * ObjList.ScaleFactor) + 3 * d1);
    BarRect  := Rect(ObjRect.Left, ObjRect.Top,
                     ObjRect.Left + d12, ObjRect.Bottom);
    ValRect  := Rect(BarRect.Right + d1, ObjRect.Top,
                     ObjRect.Right, ObjRect.Bottom);
    end;
  end;

procedure TGNumberObj.DrawArrowsInto(R: TRect);
  var d, dmx, dmy : Integer;
  begin
  d   := Round(ObjList.ScaleFactor);
  dmx := (R.Left + R.Right) Div 2;
  dmy := (R.Top + R.Bottom) Div 2;
  With ObjList.TargetCanvas do begin
    Polygon([Point(R.Left  + d + 1, dmy - d),
             Point(R.Right - d - 2, dmy - d),
             Point(dmx, R.Top + d + 1)]);
    Polygon([Point(R.Left  + d + 1, dmy + d),
             Point(R.Right - d - 2, dmy + d),
             Point(dmx, R.Bottom - d - 2)]);
    end;
  end;

procedure TGNumberObj.DrawIt;
  var ns     : String;
      dz, d4 : Integer;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    If ShowName then
      If Length(name) > 2 then
        ns := name + '='
      else
        ns := name + ' = '
    else
      ns := '';
    With ObjList.TargetCanvas do begin
      // Rahmen zeichnen:
      if (MyShape = 1) then begin   // Slider-View
        Rectangle(BarRect);
        Rectangle(ValRect);
        Rectangle(MinRect);
        Rectangle(MaxRect);
        MoveTo(valpxmin, valpy);
        LineTo(valpxmax, valpy);
        end
      else                          // Counter-View
        Rectangle(ObjRect);

      // Texte formatieren und ausgeben:
      If Abs(FQuant) < epsilon then
        dz := 8
      else
        dz := Max(Abs(Round(log10(FQuant))), 3);

      if (MyShape = 1) then begin   // Slider-View
        ShowCentered(ObjList.TargetCanvas, FValMin, MinRect, dz);
        ShowCentered(ObjList.TargetCanvas, FValMax, MaxRect, dz);
        end;
      Font.Color  := DarkCol(MyColour);
      ShowCentered(ObjList.TargetCanvas, value, ValRect, dz, ns);

      Brush.Color := LightCol(MyColour);
      Pen.Color   := DarkCol(MyColour);
      Brush.Color := MyColour;
      if (MyShape = 1) then begin   // Slider-View
        // Slider zeichnen:
        d4 := Round(4 * ObjList.ScaleFactor);
        Polygon([Point(valpx - d4, valpy - d4),
                 Point(valpx - d4, valpy     ),
                 Point(valpx     , valpy + d4),
                 Point(valpx + d4, valpy     ),
                 Point(valpx + d4, valpy - d4)]);
        end
      else begin                    // Counter-View
        // Steuer-Pfeile zeichnen:
        DrawArrowsInto(BarRect);
        end;
      end;
    end;
  end;

procedure TGNumberObj.HideIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    ObjList.TargetCanvas.Rectangle(ObjRect);
    end;
  end;

procedure TGNumberObj.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_editrange, CME_PopupClick, cmd_EditRange);
  if ClassType = TGNumberObj then
    if MyShape = 1 then   // is Slider view
      AddPopupMenuItemTo(menu, cme_showcounter, CME_PopupClick, cmd_ShowCounter)
    else                  // is Counter view
      AddPopupMenuItemTo(menu, cme_showslider, CME_PopupClick, cmd_ShowSlider);
  end;

procedure TGNumberObj.Invalidate;
  begin
  If ObjList.AnimationSource = Self then
    ObjList.AnimationSource := Nil;
  Inherited Invalidate;
  end;

function TGNumberObj.GetInfo: String;
  var arg : String;
  begin
  arg := Float2Str(value, 3);
  Result := Format(MyObjTxt[53], [arg]);
  InsertNameOf(Self, Result);
  end;


{-------------------------------------------}
{ TGLogSlider's Methods Implementation      }
{-------------------------------------------}

procedure TGLogSlider.UpdateParams;
  var xrel, raw : Double;
  begin
  If LastDist <= CatchDist/ObjList.e1x then begin
    DataValid := True;                   { Hoffentlich !!       }
    If LastDist >= 0 then begin          { Schieber verziehen   }
      valpx := ObjList.LastMousePos.x;
      If valpx > valpxmax then valpx := valpxmax;
      If valpx < valpxmin then valpx := valpxmin;
      xrel := (valpx - valpxmin)/(valpxmax - valpxmin);
      raw := FValMin * Math.Power(FValMax / FValMin, xrel);
      Value := Quantisized(raw, FQuant);
      end
    else  { Nicht am Schieber gezogen, sondern sonst was -- was auch immer: }
      Case Round(LastDist) of
        -1 : begin                       { Komplett verschieben }
             ObjList.GetLogCoords(scrx, scry, X, Y);
             X := X + ObjList.LastLogMouseDX;
             Y := Y + ObjList.LastLogMouseDY;
             ObjList.GetWinCoords(X, Y, scrx, scry);
             end;
        -2,
        -3 : DataValid := False;
      end;
    end;
  UpdateScreenCoords;
  end;

function TGLogSlider.CanControlAnimation: Boolean;
  begin
  Result := False;
  end;

{ ------- Private Helpers ------------------- }

procedure TGLogSlider.SetPositionFromValue;
  var xrel : Double;
  begin
  xrel := Math.Log10(fValue/fValMin) / (Math.Log10(fValMax / fValMin));
  valpx   := valpxmin + Round(xrel*(valpxmax - valpxmin));
  If valpx < valpxmin then begin
    valpx := valpxmin; Value := FValMin; end;
  If valpx > valpxmax then begin
    valpx := valpxmax; Value := FValMax; end;
  end;

procedure TGLogSlider.SetValue(newValue: Double);
  begin
  If Abs(Abs(FValue/newValue) - 1) > epsilon then
    If ObjList.DraggedObj = Self then begin        { normaler Zugmodus }
      FValue      := Boxed(Quantisized(newValue, FQuant));
      FBoundParam := Boxed(newValue);  { unquantisiert, für Ortslinien }
      end
    else begin  { Automations-Modus !!! }
      FValue := Boxed(newValue);
      SetPositionFromValue;
      end;
  end;

procedure TGLogSlider.SetAllValues(vmin, vact, vmax, vquant: Double);
  begin
  ObjList.FillDragList(Self);
  FValMin := vmin;
  FValMax := vmax;
  If FQuant > - epsilon then begin        // Change this !!!
    FQuant  := 0.0001;
    nq := Round(vquant);
    end;
  Value   := Quantisized(vact, FQuant);
  If IsVisible then HideIt;
  SetPositionFromValue;
  If IsVisible then DrawIt;
  end;

procedure TGLogSlider.ExportIt;
  begin
  // Nothing to do.
  end;


{ ------------------------------------------- }
{ TGTermObj's Methods Implementation          }
{ ------------------------------------------- }

constructor TGTermObj.Create(iObjList: TGeoObjListe;
          iTermStr, iCommentStr: WideString; iShowTerm, iis_visible: Boolean);
  var spot: TPoint;
  begin
  Inherited Create(iObjList, False);
  spot := ObjList.GetFreePlace4NewNumber;
  scrx := spot.X;
  scry := spot.Y;
  ObjList.GetLogCoords(scrx, scry, X, Y);
  NumWidth := 150;
  NumHeight := 32;
  DeciDigits := TermDigits;
  FTerm := TTBaum.Create(iObjList, Rad);
  SetNewTerm(iTermStr);
  FShowTerm := iShowTerm;
  FComment := iCommentStr;
  UpdateParams;
  If iis_visible then
    FStatus := FStatus or gs_ShowsAlways;
  end;

constructor TGTermObj.Load32(R: TReader; iObjList: TGeoObjListe);
  var oldPos, FTOStatus: Integer;
                // tos_NoTermDisp     = $00000001;
  begin
  Inherited Load32(R, iObjList);
  scrx := R.ReadInteger;
  scry := R.ReadInteger;
  oldPos := R.Position;
  try
    FComment := R.ReadString;
    CommentOutStr := R.ReadString;
  except
    R.Position := oldPos;
    FComment := '';
    CommentOutStr := '';
  end; { of try }

  NumWidth := R.ReadInteger;
  NumHeight := R.ReadInteger;
  With ObjRect do
    begin
    Left := scrx;
    Top := scry;
    Right := Left + NumWidth;
    Bottom := Top + NumHeight;
    end;

  oldPos := R.Position;
  try
    FTOStatus := R.ReadInteger;
  except
    R.Position := oldPos;
    FTOStatus := 0;
  end; { of try }

  FShowTerm := FTOStatus = 0;
  FShowName := R.ReadBoolean;
  FTerm := TTBaum.Load32(iObjList, R);
  LastDist := 500;
  If DeciDigits < 2 then
    DeciDigits := TermDigits;
//  UpdateParams;     { Auf keinen Fall aktivieren ! Gibt Chaos ! }
  end;


constructor TGTermObj.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var domVal : IXMLNode;
      ws     : WideString;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  If DE.hasAttribute('show_name') then
    FShowName := LowerCase(DE.getAttribute('show_name')) = 'true'
  else
    FShowName := True;
  If DE.hasAttribute('show_term') then
    FShowTerm := LowerCase(DE.getAttribute('show_term')) = 'true'
  else
    FShowTerm := True;
  If DE.hasAttribute('show_format') then
    FOutFormat := StrToInt(DE.getAttribute('show_format'))
  else
    FOutFormat := 0;  // normal display, without any units or scaling

  With DE.childNodes.findNode('position', '') do begin
    X := StrToFloat(getAttribute('x'));
    Y := StrToFloat(getAttribute('y'));
    NumWidth  := StrToInt(getAttribute('width'));
    NumHeight := StrToInt(getAttribute('height'));
    end;

  domVal := DE.childNodes.findNode('value', '');
  If domVal.hasAttribute('comment') then
    FComment := domVal.getAttribute('comment')
  else
    FComment := '';
  FTerm := TTBaum.Create(iObjList, ObjList.GetDefAngleMode);
  ws := domVal.getAttribute('term');
  FTerm.source_str := literalLine(ws);
  if DeciDigits <> TermDigits then
    DeciDigits := FMyShape;
  If DeciDigits < 2 then
    DeciDigits := TermDigits;
  end;

function TGTermObj.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var domvalue, position, app : IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  { 2011-11-05: Den folgenden "app"-schnitt ergänzt wegen Bugreport von Frau
                Friebe (und anderen), dass Dezimalstellen-Einstellungen in
                Term-Objekten das Speichern und Wiederladen nicht überstehen. }
  app := Result.ChildNodes.findNode('appearance', '');
  if app = Nil then begin
    app := DOMDoc.CreateNode('appearance');
    app.SetAttribute('shape', IntToStr(DeciDigits));
    Result.ChildNodes.Add(app);
    end
  else
    app.SetAttribute('shape', IntToStr(DeciDigits));

  Result.setAttribute('show_name', LowerCase(BoolToStr(FShowName, True)));
  Result.setAttribute('show_term', LowerCase(BoolToStr(FShowTerm, True)));
  Result.setAttribute('show_format', IntToStr(FOutFormat));

  position := DOMDoc.createNode('position');
  position.setAttribute('x', FloatToStr(X));
  position.setAttribute('y', FloatToStr(Y));
  position.setAttribute('width', IntToStr(NumWidth));
  position.setAttribute('height', IntToStr(NumHeight));
  Result.childNodes.add(position);

  domvalue := DOMDoc.createNode('value');
  FTerm.BuildString;
  domvalue.setAttribute('term', maskDelimiters(FTerm.source_str));
  If Length(FComment) > 0 then
    domvalue.setAttribute('comment', FComment);
  Result.childNodes.add(domvalue);
  end;

destructor TGTermObj.Destroy;
  begin
  FreeAndNil(FTerm);
  Inherited Destroy;
  end;

destructor TGTermObj.FreeBluePrint;
  begin
  FreeAndNil(FTerm);
  inherited FreeBluePrint;
  end;

procedure TGTermObj.AfterLoading(FromXML: Boolean = True);
  {20.12.09 : Für 3.5a die folgende Diagnose-Funktion
              "hasAngleDependentChild" eingebaut; sie sichert die Erkennung
   einer Drehung und die korrekte Konversion des Drehwinkelterms. Könnte auf
   weitere Spezialfälle verallgemeinert werden, aber mit der nötigen Vorsicht:
   z.B. wird der Fall "TGXLine" schon in "TGXLine.AfterLoading()" korrekt
   erledigt, selbst wenn der dort lokal gespeicherte Baum Referenzen auf
   externe Term-Objekte hat!
   Problematisch bleibt auch der (bisher glücklicherweise hypothetische)
   Fall, dass ein TermObj mehrere Kinder hat, die den Term mal im Grad-
   und mal im Bogenmaß auswerten. Hoffentlich kommt sowas nie vor !!!       }

  function hasAngleDependentChild: Boolean;
    var i : Integer;
    begin
    Result := False;
    For i := 0 to Pred(Children.Count) do begin
      if ((TGeoObj(Children[i]) is TGTransformation) and
          (TGTransformation(Children[i]).MapType = mapRotation)) then
        Result := True;
      end;
    end;

  begin
  Inherited AfterLoading(FromXML);
  FTerm.UpdateDegSourceAndBuildTree(FTerm.source_str, hasAngleDependentChild);
  If Parent.Count = 0 then
    FTerm.RegisterTermParentsIn(Self);
  FTerm.Calculate(0, FValue);
  DataValid := FTerm.is_okay;
  end;

function TGTermObj.Dist(xm, ym: Double): Double;
  var MPos: TPoint;
  begin
  ObjList.GetWinCoords(xm, ym, MPos.X, MPos.Y);
  If PtInRect(ObjRect, Mpos) then
    LastDist := -1
  else
    LastDist := 1.0e300;
  Result := LastDist;
  end;

function TGTermObj.IsEstimated : Boolean;
  begin
  If Assigned(FTerm) then
    Result := FTerm.is_estimated
  else
    Result := False;
  end;

function TGTermObj.GetIsVisible: Boolean;
  begin
  Result := (FStatus and (gs_ShowsOnlyNow or gs_ShowsAlways) > 0) and
            ObjList.GroupList.IsGroupVis(FGroups);
  end;

function TGTermObj.GetDeciDigits: Integer;
  begin
  Result := FMyShape;
  end;

procedure TGTermObj.SetDeciDigits(newVal: Integer);
  begin
  FMyShape := newVal;
  end;

procedure TGTermObj.SetShowTerm(newVal: Boolean);
  var is_vis : Boolean;
  begin
  If newVal <> FShowTerm then begin
    is_vis := IsVisible;
    If is_vis then
      HideIt;
    FShowTerm := newVal;
    UpdateScreenCoords;
    If is_vis then
      DrawIt;
    end;
  end;

function TGTermObj.GetMatchingCursor(mpt: TPoint): TCursor;
  begin
  If LastDist <= CatchDist then
    Result := Hand_Cursor
  else
    Result := crArrow;
  end;

function TGTermObj.GetTermString: WideString;
  begin
  FTerm.BuildString;
  Result := MaskDelimiters(FTerm.source_str);
  end;

function TGTermObj.GetValueStr: WideString;
  var SValue : Double;
      buf    : WideString;
  begin
  Case FOutFormat of
    1 : SValue := grad(Value);
    2 : SValue := Value / pi;
  else
    SValue := Value;
  end; { of case }
  If IsZero(SValue, epsilon) then
    buf := ' 0 '
  else
    If (Abs(SValue) < 1e-2) then
      buf := FloatToStrF(SValue, ffExponent, DeciDigits, 1)
    else
      buf := FloatToStrF(SValue, ffGeneral, DeciDigits, 0);
  Case FOutFormat of
    1 : begin
        While buf[Length(buf)] = ' ' do Delete(buf, Length(buf), 1);
        buf := buf + '° ';
        end;
    2 : buf := buf + WideChar($03C0); // "greek(pi)";
  end; { of case }
  Result := buf;
  end;

function TGTermObj.GetHTMLString: String;
  begin
  Result := FTerm.GetHTMLString;
  end;

procedure TGTermObj.SetNewTerm(ts: WideString);
  begin
  HideIt;
  FTerm.UnregisterTermParentsIn(Self);
  FTerm.BuildTree(ts);
  If FTerm.status > tbCompError then    { Unterbleibt nur, wenn schon die }
    FTerm.RegisterTermParentsIn(Self);  { Term-Kompilierung schief ging ! }
  UpdateParams;
  DrawIt;
  end;

procedure TGTermObj.SetComment(newCStr: String);
  begin
  FComment := newCStr;
  end;

procedure TGTermObj.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_editterm, CME_PopupClick, cmd_EditTerm);
  end;

function TGTermObj.GetValue(selector: Integer): Double;
  { 21.09.09 : Rückgabewert für Selector-Wert "gv_angle" auf das Bogenmaß
               des Winkels (also FValue) gesetzt statt auf das Gradmaß !  }
  begin
  Case selector of
    gv_val : Result := Value;
  else
    Result := Inherited GetValue(selector);
  end; { of case }
  end;

function TGTermObj.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO is TGTermObj) and
            FTerm.HasSameDataAs(TGTermObj(GO).FTerm) and
            (Not FTerm.is_const);
  end;

function TGTermObj.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('T');
  end;

procedure TGTermObj.Invalidate;
  begin
  FTerm.UnRegisterTermParentsIn(Self);
  Inherited Invalidate;
  end;

procedure TGTermObj.Revalidate;
  begin
  FTerm.RegisterTermParentsIn(Self);
  Inherited Revalidate;
  UpdateParams;
  end;

procedure TGTermObj.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@FValue, SizeOf(FValue));
  Old_Data.push(@FShowTerm, SizeOF(FShowTerm));
  Old_Data.push(@FTerm.Status, SizeOf(FTerm.status));
  end;

procedure TGTermObj.RestoreState;
  begin
  Old_Data.pop(@FTerm.Status);
  Old_Data.pop(@FShowTerm);
  Old_Data.pop(@FValue);
  Inherited RestoreState;
  end;

procedure TGTermObj.UpdateParams;
  begin
  If IsVisible and
     (ObjList.DraggedObj = Self) then begin   { Komplett verschieben }
    X := X + ObjList.LastLogMouseDX;
    Y := Y + ObjList.LastLogMouseDY;
    end
  else
    try
      FTerm.Calculate(0, FValue);
      DataValid := FTerm.is_okay;
    except
      DataValid := False;
    end;
  UpdateScreenCoords;
  end;

procedure TGTermObj.UpdateScreenCoords;
  var buf           : WideString;
      MinimalHeight : Integer;
      ShowCaption   : Boolean;
  begin
  ObjList.GetWinCoords(X, Y, scrx, scry);
  With ObjList.TargetCanvas.Font do begin
    Assign(ObjList.StartFont);
    Height := Round(-12 * ObjList.ScaleFactor);
    end;
  ShowCaption := ShowName or ShowTerm or (Length(Comment) > 0);

  If ShowCaption then begin  // 2-zeilige Anzeige
    NumWidth  := Round(150 * ObjList.ScaleFactor);
    NumHeight := Round( 32 * ObjList.ScaleFactor);
    CommentOutStr := '';
    If ShowName then
      CommentOutStr := Self.GetFormattedName;
    If ShowTerm then
      If Length(CommentOutStr) > 0 then
        CommentOutStr := CommentOutStr + ' = ' + WideString2HTMLString(GetTermString)
      else
        CommentOutStr := WideString2HTMLString(GetTermString);
    If Length(Comment) > 0 then
      If Length(CommentOutStr) > 0 then
        CommentOutStr := CommentOutStr + '  {' + Comment + '}'
      else
        CommentOutStr := Comment;
    end
  else begin                 // Nur einzeilige Wert-Anzeige
    NumWidth  := Round( 75 * ObjList.ScaleFactor);
    NumHeight := Round( 16 * ObjList.ScaleFactor);
    CommentOutStr := '';
    end;

  If DataValid then
    buf := GetValueStr
  else
    buf := MyMess[10];

  MinimalWidth := max(ObjList.TargetCanvas.TextWidth(HTMLKillAllTags(CommentOutStr)),
                      ObjList.TargetCanvas.TextWidth(buf));
  If MinimalWidth > NumWidth - 10 then
    NumWidth := MinimalWidth + 10;

  If ShowCaption then  // 2-zeilige Anzeige
    MinimalHeight := 2 * ObjList.TargetCanvas.TextHeight(CommentOutStr) + 5
  else                 // Nur 1-zeilige Wert-Anzeige
    MinimalHeight := ObjList.TargetCanvas.TextHeight('My') + 5;
  If MinimalHeight > NumHeight then
    NumHeight := MinimalHeight;

  With ObjRect do begin
    Left   := scrx;
    Top    := scry;
    Right  := Left + NumWidth;
    Bottom := Top + NumHeight;
    end;
  If ShowCaption then begin  // 2-zeilige Anzeige
    With CommentRect do begin
      TopLeft := ObjRect.TopLeft;
      BottomRight := Point(ObjRect.Right, ObjRect.Top + NumHeight Div 2);
      end;
    With ValRect do begin
      TopLeft := Point(ObjRect.Left, CommentRect.Bottom + 2);
      BottomRight := ObjRect.BottomRight;
      end;
    end
  else                       // Nur 1-zeilige Wert-Anzeige
    ValRect := ObjRect;
  end;

procedure TGTermObj.DrawIt;
  var TextSize : TSize;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    ObjList.TargetCanvas.Rectangle(ObjRect);
    If Length(CommentOutStr) > 0 then
      draw_htmlText_on(ObjList.TargetCanvas,
                       ObjRect.left + (NumWidth - MinimalWidth) div 2,
                       ObjRect.Top + Round(ObjList.ScaleFactor),
                       CommentOutStr);
    If FTerm.is_okay then
      ShowCentered(ObjList.TargetCanvas, GetValueStr, ValRect)
    else begin
      TextSize := ObjList.TargetCanvas.TextExtent(MyMess[10]);
      ObjList.TargetCanvas.TextOut((ValRect.left + ValRect.right - TextSize.cx) div 2,
                        (ValRect.Top + ValRect.Bottom - TextSize.cy) div 2,
                        MyMess[10]);
      end;
    end;
  end;

procedure TGTermObj.HideIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    ObjList.TargetCanvas.Rectangle(ObjRect);
    end;
  end;

procedure TGTermObj.RebuildTermStrings;
  begin
  FTerm.BuildString;
  UpdateParams;
  If IsVisible then
    ObjList.DrawFirstObjects(ObjList.LastValidObjIndex, True);
  end;

function TGTermObj.HasBuggyTerm: Boolean;
  begin
  If FTerm.status = tbEmpty then
    FTerm.BuildTree(FTerm.source_str);
  Result := FTerm.status <= tbCompError;
  end;

procedure TGTermObj.ReDimData;
  begin
  FTerm.BuildString;
  FTerm.Calculate(0, FValue);
  DataValid := FTerm.is_okay;
  Inherited ReDimData;
  end;

function TGTermObj.GetInfo: String;
  var arg : String;
  begin
  arg := FTerm.GetHTMLString;
  Result := Format(MyObjTxt[55], [arg]);
  InsertNameOf(Self, Result);
  end;


{--------------------------------------------------}
{ TGVertexPt's method implementation               }
{--------------------------------------------------}

constructor TGVertexPt.Create(iObjList: TGeoObjListe; iPoly: TGeoObj;
                              n: Integer; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, 0, 0, False);
  BecomesChildOf(iPoly);
  FPtIndex := n;
  UpdateParams;
  If iis_visible then
    ShowsAlways := True;
  end;

constructor TGVertexPt.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var s : String;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  s := DE.getAttribute('plist_index');
  If Length(s) > 0 then
    FPtIndex := StrToInt(s)
  else
    FPtIndex := -1;
  end;

function TGVertexPt.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  Result.setAttribute('plist_index', IntToStr(FPtIndex));
  end;

function  TGVertexPt.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (ClassType = GO.ClassType) and
            (Parent[0] = GO.Parent[0]) and
            (FPtIndex  = (GO as TGVertexPt).FPtIndex);
  end;

function TGVertexPt.GetInfo: String;
  begin
  Result := MyObjTxt[102];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  end;

function TGVertexPt.IsIncidentWith(line: TGLine): Boolean;
  begin
  Result := line = Parent[0];
  end;

procedure TGVertexPt.UpdateParams;
  begin
  DataValid := (TGeoObj(Parent[0]) as TGRegPoly).GetVertice(FPtIndex, X, Y);
  If DataValid then
    UpdateScreenCoords;
  end;

procedure TGVertexPt.UpdateScreenCoords;
  begin
  ObjList.GetWinCoords(X, Y, scrx, scry);
  end;




initialization

{ Klassen-Registrierung }

RegisterClass(TGeoObj);
RegisterClass(TGPoint);
RegisterClass(TGLine);
RegisterClass(TGStraightLine);
RegisterClass(TGShortLine);
RegisterClass(TGHalfLine);
RegisterClass(TGLongLine);
RegisterClass(TGBaseLine);
RegisterClass(TGCircle);
RegisterClass(TGBaseCircle);
RegisterClass(TGCircle3P);
RegisterClass(TGArc);
RegisterClass(TGAngle);
RegisterClass(TGTextObj);
RegisterClass(TGName);
RegisterClass(TGFixCircle);
RegisterClass(TGFixLine);
RegisterClass(TGVector);
RegisterClass(TGDirLine);
RegisterClass(TGDistLine);
RegisterClass(TGAngleWidth);
RegisterClass(TGOrigin);
RegisterClass(TGAxis);
RegisterClass(TGaugePoint);
RegisterClass(TGCoordPt);
RegisterClass(TGPol);
RegisterClass(TGXPoint);
RegisterClass(TGMiddlePt);
RegisterClass(TGMirrorPt);
RegisterClass(TGMirrorLine);
RegisterClass(TGMirrorLongLine);
RegisterClass(TGMirrorCircle);
RegisterClass(TGMovedPt);
RegisterClass(TGMovedLongLine);
RegisterClass(TGMovedCircle);
RegisterClass(TGRotatedPt);
RegisterClass(TGRotatedLongLine);
RegisterClass(TGRotatedCircle);
RegisterClass(TGStretchedPt);
RegisterClass(TGStretchedCircle);
RegisterClass(TGStretchedLongLine);
RegisterClass(TGDoublePt);
RegisterClass(TGSecondPt);
RegisterClass(TGIntersectPt);
RegisterClass(TGLxLPt);
RegisterClass(TGMSenkr);
RegisterClass(TGLot);
RegisterClass(TGSenkr);
RegisterClass(TGParall);
RegisterClass(TGWHalb);
RegisterClass(TGTangent);
RegisterClass(TGNormal);
RegisterClass(TGPolare);
RegisterClass(TGChordal);
RegisterClass(TOLPoint);
RegisterClass(TGOLCircle);
RegisterClass(TGOLLongLine);
RegisterClass(TGXCircle);
RegisterClass(TGXLine);
RegisterClass(TGComment);
RegisterClass(TGNumberObj);
RegisterClass(TGTermObj);
RegisterClass(TGArea);
RegisterClass(TGAreaSize);
RegisterClass(TGMappedPoint);
RegisterClass(TGMappedLine);
RegisterClass(TGMappedCircle);
RegisterClass(TGVertexPt);
RegisterClass(TGXRay);
RegisterClass(TGLogSlider);


finalization

end.
