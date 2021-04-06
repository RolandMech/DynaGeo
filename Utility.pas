Unit Utility;

Interface

{$IFDEF NO_PLATFORMWARNINGS}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

Uses Windows, Classes, Graphics, Forms, IniFiles, Menus, SysUtils, ShlObj,
     TBaum, MathLib;

Const ColorTable   : Array [0..8] of TColor =      
                       ($00000000,      { schwarz  0}
                        $00C0C0C0,      { grau     1}
                        $000000FF,      { rot      2}
                        $00FF0000,      { blau     3}
                        $0000FFFF,      { gelb     4}
                        $00FF00FF,      { magenta  5}
                        $00003F7F,      { braun    6}
                        $0000CC00,      { grün     7}
                        $00FFFFFF);     { weiß     8}
                      { =00BBGGRR                   }
Type
  TWorld = class(TObject)
    private
      FRect    : TRect;
      fx_center,
      fy_center,
      fradius,
      radius_2 : Double;   { = Radius-Quadrat ! }
    public
      constructor Create (Wnd: HWnd);
      procedure Initialize (iRect: TRect);
      function LastInitRect : TRect;
      function Knows (x, y: Double): Boolean;
      procedure GetLongLineBorderPoints(var x1, y1, x2, y2 : Double);
      property x_center: Double read fx_center;
      property y_center: Double read fy_center;
      property radius: Double read fradius;
      property Rect: TRect read FRect;
    end;

  TDataStack = class(TList)
    destructor Destroy; override;
    function is_empty : Boolean;
    procedure push(vp: Pointer; vSize: Integer);
    procedure pop (vp: Pointer);
    procedure pushStr(s: String);
    procedure popStr(var s: String);
    procedure Clear; override;
    end;

  TPointParams = class(TObject)
    private
      ppX, ppY,
      ppLast_dx,
      ppLast_dy  : Double;
      ppFStatus  : Integer;
    public
      constructor CreateWithDataFrom(Pt: TObject);
      constructor Load32(R: TReader);
      procedure LoadDataFrom(Pt: TObject);
      procedure LoadPosFrom(Pt: TObject);
      procedure LoadMoveFrom(Pt: TObject);
      procedure WriteDataTo(Pt: TObject);
    end;

  TPPInitDataList = class(TList)
    public
      constructor Load32(R: TReader);
      destructor  Destroy; override;
    end;

  TObjPtrList = class(TList)
    private
      BackupList : TList;
    public
      DuplicatesAllowed : Boolean;
      ExpectedType,
      ExpectedCount,
      IL_Line,
      IL_Row            : Integer;
      constructor Create(iDuplicatesAllowed: Boolean);
      constructor Load (var S: TFileStream);
      constructor Load32(R: TReader);
      destructor Destroy; override;
      procedure Insert(Index: Integer; Item: Pointer);
      function  Add(Item: Pointer): Integer;
      procedure AddBlinking(GO: Pointer; OBE: Boolean);
      procedure SaveState;
      procedure RestoreState;
      function  SafeGetGeoNum(index: Integer): Integer;
      function  GetGeoNumString: String;
      procedure SetGeoNumString(NumStr: String);
      procedure ResolveGeoNums(GOList: TList);
      procedure BringFreePointsToListStart;
      procedure BringNameObjToListStart;
      procedure BringSetsquareToListStart;
      procedure SortByDependencies;
    end;

  TSortedGObjList = class(TList)
    private
      FValid : Boolean;
      Source : TList;
      function Okay2Transfer(GO: TObject): Boolean;
    public
      constructor CreateSortedCopyOf(iSource: TList);
      property Valid: Boolean read FValid;
    end;

  TLRUList = class(TStringList)
    private
      TargetMenu: TMenuItem;
      FStartIndex,
      FLRUCount : Integer;
      ClickProc : TNotifyEvent;
      procedure SetLRUCount(newLRUCount: Integer);
    public
      constructor Create(iTargetMenu: TMenuItem;
                         iMenuStartIndex,
                         iLRUCount  : Integer;
                         iClickProc : TNotifyEvent);
      destructor Destroy; override;
      procedure AddItem(new_str : String);
      procedure DeleteItem(old_str: String);
      property LRUCount: Integer read FLRUCount write SetLRUCount;
      property StartIndex: Integer read FStartIndex;
    end;

  TNameNumList = class(TObject)
    private
      List : TStringList;
    public
      constructor Create;
      destructor Destroy; override;
      function GetNextFreeSuffixOf(nam: String): Integer;
      procedure SetNextFreeSuffixOf(nam: String; num: Integer);
    end;

  TStift = class(TObject)
    public
      Daten     : TLogPen;
      PenHandle : HPen;
      is_used   : Boolean;
      constructor Load(var S: TFileStream);
      destructor Done; virtual;
    end;

  TStiftListe = class(TList)
    public
      constructor Load(var S: TFileStream);
    end;

  TPinsel = class(TObject)
    public
      Daten       : TLogBrush;
      BrushHandle : HBrush;
      is_used     : Boolean;
      constructor Load(var S: TFileStream);
      destructor Done; virtual;
    end;

  TPinselListe = class(TList)
    public
      constructor Load(var S: TFileStream);
    end;


function  same2Obj           (a1, a2, b1, b2     : Pointer): Boolean;
function  GetGeoTypeByNum    (Num                : Integer): TClass;
function  SeveralObjsPossible(List               : TList  ): Boolean;
function  canJexport         (GO                 : TObject): Boolean;

function  ColDist            (c1, c2             : TColor ): Integer;
function  LightCol   (orgCol: TColor; faint : Double = 0.5): TColor;
function  DarkCol    (orgCol: TColor; strong: Double = 0.5): TColor;
function  GetTextCol         (WantedCol, BackCol : TColor ): TColor;
function  GetVisibleCol      (WantedCol, BackCol : TColor ): TColor;
procedure IncrementCol       (var f              : TColor );

function  CloneRegion        (    source         : HRgn   ): HRgn;
function  GetRegionSize      (    Rgn            : HRgn   ): Integer;
function  Shrink             (    R              : TRect;
                                  dl             : Integer): TRect;
function  GetTopLeftOfR2InsideR1 (R1, R2         : TRect  ): TPoint;
procedure MoveWinIntoDesktop (    width, height  : Integer;
                              var left, top      : Integer);

procedure ClearBitmap        (BMP                : TBitmap;
                              bkCol              : TColor);
procedure CopyReducedBitmap  (Source,
                              Target             : TBitmap);

procedure draw_long_line_clip_on (Target         : TCanvas;
                              x1, y1, x2, y2     : Double);
procedure draw_line_clip_on  (Target             : TCanvas;
                              x1, y1, x2, y2     : Double);
procedure draw_line_on       (Target             : TCanvas;
                              res, x1, y1, x2, y2: Double;
                              Style              : TPenStyle);
procedure draw_circle_on     (Target             : TCanvas;
                              res, xm, ym, rx, ry: Double;
                              Style              : TPenStyle;
                              PL                 : TFloatPointList = Nil);
procedure draw_arc_on        (Target             : TCanvas;
                              resx, resy,
                              xm, ym, rx, ry,
                              s_ang, e_ang       : Double;
                              Style              : TPenStyle);
procedure draw_rectangle_on  (Target             : TCanvas;
                              res, x1, y1, x2, y2: Double;
                              Style              : TPenStyle);
procedure draw_cross_on      (Target             : TCanvas;
                              res, x, y, d       : Double);
procedure draw_xcross_on     (Target             : TCanvas;
                              res, x, y, d       : Double);
procedure draw_htmlText_on   (Target             : TCanvas;
                              sx, sy             : Integer;
                              fStr               : String);

procedure AddPopupMenuItemTo (TargetMenu         : TPopupMenu;
                              iCaption           : String;
                              iOnClick           : TNotifyEvent;
                              iTag               : Integer;
                              iChecked           : Boolean = False);

procedure WriteOldStrToStream  (S        : TStream;
                                s2w      : String     );
function  ReadOldStrFromStream (S        : TStream;
                                propSize : Integer = 0): String;
function  ReadOldIntFromStream (S        : TStream    ): Integer;
function  SearchFirst          (s        : TStream;
                                ss       : String     ): Integer;
function  SkipCommentsIn       (s        : TStream    ): Integer;

function  WriteBitMapDataByWriter (W : TWriter; BMP: TBitMap): Integer;
function  ReadBitMapDataByReader  (R : TReader; BMP: TBitMap): Integer;
  { Diese beiden Funktionen liefern  0, wenn alles okay ist
                               bzw.  1  im Fehlerfall             }

procedure PackBMPIntoString(BitMap: TBitMap; var s: String);
procedure LoadBMPFromString(s: String; BitMap: TBitMap);
procedure patch_DPIres_in_BMP_Stream(outStream: TStream; outDPI: Integer);
procedure patch_DPIres_in_JPG_Stream(outStream: TStream; outDPI: Integer);

function GetDateTimeFromFileTime (file_t   : TFileTime) : TDateTime;
function GetDateTimeFromFATTime  (fat_t    : Integer  ) : TDateTime;

function RegisterOCX             (filepath : String   ) : Boolean;
function UnregisterOCX           (filepath : String   ) : Boolean;

function Float2Str     (value    : Extended;
                        decimals : Integer            ) : String;
function AdjustDeciSeparator (s  : String             ) : String;
function Bool2Str      (value    : Boolean            ) : String;
function Str2Bool      (value    : String             ) : Boolean;
function CutByteFromHexStr(var s : String             ) : Integer;

procedure DeleteChars            (delchars : String;
                                  var s    : String         ); overload;
procedure DeleteChars            (delchars : WideString;
                                  var s    : WideString     ); overload;
procedure replace                (so, sc   : String;
                                  var ws   : String;
                                  suffix   : String     = ''); overload;
procedure replace                (so, sc   : WideString;
                                  var ws   : WideString;
                                  suffix   : WideString = ''); overload;

function ReplaceVarsIn           (s        : String;
                                  ReplTab  : TStringList) : String;
function SearchForw              (s2f      : String;
                                  SL       : TStrings;
                                  start    : Integer;
                                  var found: Integer  ) : Boolean;
function ExtractData             (key      : String;
                                  SL       : TStrings;
                                  start    : Integer  ) : String;

function maskDelimiters          (s    : WideString   ) : WideString;
function rebuildDelimiters       (s    : WideString   ) : WideString;
function literalLine             (s    : WideString   ) : WideString;
function CDATACompatible         (s    : WideString   ) : WideString;
function CDATATagRestored        (s    : WideString   ) : WideString;
function HTMLKillAllTags         (s    : WideString   ) : WideString;

function HTMLKillEmptyTags       (source  : String    ) : String;
function HTMLKillNonsenseTags    (source  : String    ) : String;
function HTMLExtractAttrValue    (attName,
                                  orgStr  : String    ) : String;
function KillAllBreaks           (source  : String    ) : String;
function FormatAllBreaks         (source  : String    ) : String;

function BuildPosFlag            (b1, b2  : Boolean   ) : Integer;
function GetWideCharFromSymbolChar (c     : Char       ): WideChar;
function GetSymbolCharFromWideChar (wc    : WideChar   ): Char;
function IsDigit                   (wc    : WideChar   ): Boolean;
function IsDelimiter               (wc    : WideChar   ): Boolean;
function IsGreekNameSymbol         (wc    : WideChar   ): Boolean;
function IsNameChar                (wc    : WideChar   ): Boolean;
function IsAngleTerm               (iGOL  : TObject;
                                    ws    : WideString ): Boolean;
function HTMLString2WideString   (source  : String     ): WideString;
function WideString2HTMLString   (source  : WideString ): String;

function GetNextPlainCharIndex   (s       : String;
                                  start   : Integer = 1): Integer;
function CountHRDelimitedParas   (var src : String     ): Integer;


function DriveHoldsReadableData  (d        : Char     ) : Boolean;
function FileAllowsWriting       (fname    : String   ) : Boolean;
function StartingFromCD          (var root : String   ) : Boolean;

function FilePathAsURL              (s     : String   ) : String;
function ExtractURLPathFrom         (fname : String   ) : String;
function ExtractURLNameFrom         (fname : String   ) : String;
function ExtractURLExtFrom          (fname : String   ) : String;
function MergeFilePathAndRelFileName(path,
                                     relfn : String   ) : String;
function MergeURLPathAndRelFileName (path,
                                     relfn : String   ) : String;

function GetSelectedFilterExt    (s        : String;
                                  n        : Integer;
                                  defExt   : String   ) : String;
function GetValidationVarType    (s        : String   ) : Integer;

function ProjectName                                    : String;
function GetActUsersTempFolder                          : String;
function GetActUsersAppDataFolder(dir      : String   ) : String;
function GetAllUsersAppDataFolder(dir      : String   ) : String;
function TempFileName            (ext      : String   ) : String;
function GetValidCHMFile         (src_fn   : String   ) : String;
function GetFullExistingFilePath (searchDir: TStrings;
                                  fname    : String   ) : String;

procedure InitializeLanguage (Lang_Id  : String);
procedure InitShortCuts      (Lang_Id  : String);
procedure Wait               (delay    : Integer);
procedure ShowLastErrorMsg;

procedure ReplaceColor       (BMP      : TBitMap;
                              OldColor,
                              NewColor : TColor);
procedure ReplaceColorShades (BMP      : TBitMap;
                              BackColor,
                              OldColor,
                              NewColor : TColor);
function GetScreenPixelFormat : TPixelFormat;



Implementation

Uses ActiveX, ComObj, ComCtrls, StrUtils, Dialogs, Math, Registry,
     Declar, GlobVars, GeoTypes, GeoLocLines, GeoHelper, GeoImage,
     GeoVerging, GeoConic, GeoTransf, Symbols, ZLib, MainWin;


   {================= GeoTypes-Kompatibilität ==============}

function same2Obj(a1, a2, b1, b2: Pointer): Boolean;
  begin
  same2Obj := ((a1=b1) and (a2=b2)) or ((a1=b2) and (a2=b1));
  end;

function GetGeoTypeByNum(Num : Integer) : TClass;
  begin
  Case Num of
    10 : Result := TGPoint;
    11 : Result := TGLxLPt;
    12 : Result := TGDoublePt;
    13 : Result := TGSecondPt;
    14 : Result := TGMiddlePt;
    15 : Result := TGMirrorPt;
    16 : Result := TGCoordPt;
    17 : Result := TGMovedPt;
    18 : Result := TGRotatedPt;
    20 : Result := TGOrigin;
    21 : Result := TGaugePoint;
    29 : Result := TGAxis;
    30 : Result := TGBaseLine;
    31 : Result := TGShortLine;
    32 : Result := TGLongLine;
    33 : Result := TGMSenkr;
    34 : Result := TGLot;
    35 : Result := TGParall;
    36 : Result := TGWHalb;
    37 : Result := TGFixLine;
    38 : Result := TGDirLine;
    40 : Result := TGBaseCircle;
    41 : Result := TGCircle;
    42 : Result := TGFixCircle;
    43 : Result := TGXCircle;
    44 : Result := TGArc;
    47 : Result := TGVector;
    48 : Result := TGXLine;
    51 : Result := TGPolygon;
    52 : Result := TGAngle;
    61 : Result := TGLocLine;
    70 : Result := TGTextObj;
    71 : Result := TGName;
    79 : Result := TGComment;
    81 : Result := TGDistLine;
    82 : Result := TGAngleWidth;
    91 : Result := TGNumberObj;
  else
    Result := TGeoObj;
  end; { of case }
  end;


function SeveralObjsPossible(List: TList): Boolean;

  function SameGeoClass(obj1, obj2: TGeoObj): Boolean;
    begin
    Result :=
      (obj1.InheritsFrom(TGPoint)    and obj2.InheritsFrom(TGPoint)) or
      (obj1.InheritsFrom(TGLine)     and obj2.InheritsFrom(TGLine))  or
      (obj1.InheritsFrom(TGPolygon)  and obj2.InheritsFrom(TGPolygon)) or
      (obj1.InheritsFrom(TGDistLine) and obj2.InheritsFrom(TGDistLine));
    end;

  begin
  If List.Count < 2 then
    Result := False
  else   { mindestens 2 Objekte in der Liste }
    Result := SameGeoClass(TGeoObj(List[0]), TGeoObj(List[1]));
  end;


function canJexport(GO: TObject): Boolean;
  begin
  if (GO is TGOLLongLine) or      // Lineare Ortslinien
     (GO is TGOLCircle) or        // Kreisförmige Ortslinien
     (GO is TGOLConic) or         // Kegelschnitt-Ortslinien

     (GO is TGVergingLine) or     // Eingeschobene Strecken

     (GO is TGCheckControl)       // Heuristische Verifikation
  then
    Result := False
  else
    Result := True;
  end;



   {========= Farbbearbeitungs-Routinen ===================}

function GetScreenPixelFormat : TPixelFormat;
  var cbpp : Integer;
  begin
  cbpp := GetDeviceCaps(Application.MainForm.Canvas.Handle, BITSPIXEL);
  Case cbpp of
     0 : Result := pfDevice;
     1 : Result := pf1bit;
     4 : Result := pf4bit;
     8 : Result := pf8bit;
    15 : Result := pf15bit;
    16 : Result := pf16bit;
    24 : Result := pf24bit;
    32 : Result := pf32bit;
  else
    Result := pfCustom;
  end;
  end;

function LightCol(orgCol: TColor; faint: Double = 0.5): TColor;
  begin
  orgCol := ColorToRGB(orgCol);
  Result := TColor(RGB($FF - Round(($FF - GetRValue(orgCol)) * faint),
                       $FF - Round(($FF - GetGValue(orgCol)) * faint),
                       $FF - Round(($FF - GetBValue(orgCol)) * faint)));
  end;


function DarkCol(orgCol: TColor; strong: Double = 0.5): TColor;
  begin
  orgCol := ColorToRGB(orgCol);
  Result := TColor(RGB(Round(GetRValue(orgCol) * strong),
                       Round(GetGValue(orgCol) * strong),
                       Round(GetBValue(orgCol) * strong)));
  end;


function ColDist(c1, c2 : TColor) : Integer;
  { Liefert den "Abstand" zweier Farben:
    gleiche Farben haben den Abstand 0; der größtmögliche Abstand ist 255. }
  var i, cd    : Integer;
      ic1, ic2 : LongInt;
  begin
  ic1 := ColorToRGB(c1);
  ic2 := ColorToRGB(c2);
  cd  := 0;
  For i := 1 to 3 do begin
    cd := cd + Abs((ic1 and $000000FF) - (ic2 and $000000FF));
    ic1 := ic1 SHR 8;
    ic2 := ic2 SHR 8;
    end;
  Result := cd Div 3;
  end;


function GetDistancedCol(WCol, BCol : TColor; MinDist: Integer): TColor;
  begin                                   { Farb-Abstand messen         }
  If ColDist(WCol, BCol) >= MinDist then  { Bei hinreichendem Abstand : }
    Result := WCol                        {   Farbe übernehmen          }
  else                                    { andernfalls:                }
    If ColDist(BCol, clBlack) < 128 then  {   weiß oder schwarz wählen, }
      Result := clWhite                   {   je nachdem, welche Farbe  }
    else                                  {   den größeren Kontrast zum }
      Result := clBlack;                  {   Hintergrund hat           }
  end;


function GetTextCol (WantedCol, BackCol : TColor ): TColor;
  begin
  Result := GetDistancedCol(WantedCol, BackCol, 64);
  end;


function GetVisibleCol (WantedCol, BackCol : TColor ): TColor;
  begin
  Result := GetDistancedCol(WantedCol, BackCol, 16);
  end;


procedure IncrementCol(var f : TColor);
  var r, g, b : Byte;
  begin
  r := GetRValue(f);
  g := GetGValue(f);
  b := GetBValue(f);
  If r < 255 then Inc(r) else Dec(r);
  If g < 255 then Inc(g) else Dec(g);
  If b < 255 then Inc(b) else Dec(b);
  f := RGB(r, g, b);
  end;


   {========= Bereichs-Routinen ===================}

function CloneRegion(source: HRgn): HRgn;
  var rdSize : Integer;
      rdData : PRgnData;
  begin
  rdSize := GetRegionData(source, 0, Nil);
  GetMem(rdData, rdSize);
  GetRegionData(source, rdSize, rdData);
  Result := ExtCreateRegion(Nil, rdSize, rdData^);
  FreeMem(rdData, rdSize);
  end;

function GetRegionSize(Rgn: HRgn): Integer;
  var rds   : Integer;
      data  : PRgnData;
      PRect : ^TRect;
      n, w, h,
      i     : Integer;
  begin
  Result := 0;
  If Rgn <> 0 then begin
    rds := GetRegionData(Rgn, 0, Nil);
    GetMem(data, rds);
    n := GetRegionData(Rgn, rds, data);
    If n > 0 then begin
      PRect := @(data^.Buffer);
      n := 0;
      For i := 1 to data^.rdh.nCount do begin
        w := PRect^.Right - PRect^.Left;
        h := PRect^.Bottom - PRect^.Top;
        n := n + w * h;
        Inc(PRect, 1);
        end;
      Result := n;
      end;
    end;
  end;

function Shrink(R: TRect; dl: Integer): TRect;
  begin
  With R do begin
    left := left + dl;
    top  := top  + dl;
    right  := Max(left, right - dl);
    bottom := Max(top, bottom - dl);
    end;
  Result := R;
  end;

function GetTopLeftOfR2InsideR1(R1, R2: TRect): TPoint;
  begin
  If R2.Right > R1.Right then
    Result.x := R1.right - (R2.Right - R2.Left)
  else
    If R2.Left < R1.Left then
      Result.x := R1.Left
    else
      Result.x := R2.Left;
  If R2.Bottom < R1.Top then
    Result.y := R1.Top
  else
    If R2.Top > R1.Bottom then
      Result.y := R1.Bottom - (R2.Bottom - R2.Top)
    else
      Result.y := R2.Top;
  end;

procedure MoveWinIntoDesktop(width, height: Integer; var left, top: Integer);
  begin
  If Left < Screen.DesktopLeft then
    Left := Screen.DesktopLeft + 5;
  If Left > Screen.DesktopRect.Right - Width then
    Left := Screen.DesktopRect.Right - Width - 5;
  If Top < Screen.DesktopTop then
    Top := Screen.DesktopTop + 5;
  If Top > Screen.DesktopRect.Bottom - Height then
    Top := Screen.DesktopRect.Bottom - Height - 5;
  end;


   {========= Zeichen-Routinen ===================}

procedure draw_long_line_clip_on(Target: TCanvas; x1, y1, x2, y2: Double);
  var xm, ym, x0, y0, dx, dy : Double;
  begin
  dx := x2 - x1;
  dy := y2 - y1;
  With Target.ClipRect do begin
    xm := (left + right) / 2;
    ym := (bottom + top) / 2;
    end;
  If Hypot(dx, dy) > epsilon then begin
    GetPedalPoint(x1, y1, x2, y2, xm, ym, x0, y0);
    Repeat
      x1 := x0 + dx;
      y1 := y0 + dy;
      x2 := x0 - dx;
      y2 := y0 - dy;
      dx := 2 * dx;
      dy := 2 * dy;
    until (Not PtInRect(Target.ClipRect, Point(SafeRound(x1), SafeRound(y1)))) and
          (Not PtInRect(Target.ClipRect, Point(SafeRound(x2), SafeRound(y2))));
    draw_line_clip_on(Target, x1, y1, x2, y2);
    end;
  end;


procedure draw_line_clip_on(Target: TCanvas; x1, y1, x2, y2: Double);
  { Falls der verwendete Grafiktreiber das Clipping an den Fenstergrenzen
    nicht korrekt selbst durchführt und die zu zeichnende Strecke teil-
    weise außerhalb des aktuellen Fensters liegt, sind ihre Endpunkte
    so aufeinander zuzuschieben, daß sie die im Fenster verlaufende
    Teilstrecke begrenzen. }

  var ix1, iy1,
      ix2, iy2 : Integer;
      xn2, yn2,
      xn3, yn3 : Double;
      v2,  v3  : Boolean;
  begin
  IntersectRectangleWithLine (Target.ClipRect, x1, y1, x2, y2, xn2, yn2, xn3, yn3, v2, v3);
  If v2 then begin ix1 := Round(xn2); iy1 := Round(yn2); end
  else       begin ix1 := Round(x1);  iy1 := Round(y1);  end;
  If v3 then begin ix2 := Round(xn3); iy2 := Round(yn3); end
  else       begin ix2 := Round(x2);  iy2 := Round(y2);  end;
  Target.MoveTo(ix1, iy1);
  Target.LineTo(ix2, iy2);
  end;


procedure draw_line_on(Target: TCanvas; res, x1, y1, x2, y2: Double; Style: TPenStyle);
  var l,  dl,
      dx, dy,
      xa, ya,
      xe, ye,
      kmax, k : Double;
      PenDown : Boolean;
  begin
  If (Abs(x1) < GDIMaxInt) and
     (Abs(y1) < GDIMaxInt) and
     (Abs(x2) < GDIMaxInt) and
     (Abs(y2) < GDIMaxInt) then
    If (InternalLineStyle or (Target.Pen.Width > 1)) and
       (Style <> psSolid) then begin
      l := Sqrt(Sqr(x2 - x1) + Sqr(y2 - y1));
      If l < DistEpsilon then exit;
      Case Style of
        psDash : dl := 0.40 * res / l;
        psDot  : dl := 0.10 * res / l;
      else
        dl := 0.25 * res / l;
      end; { of case }
      Target.Pen.Style := psSolid;
      dx := (x2 - x1) * dl;
      dy := (y2 - y1) * dl;
      kmax := l / Sqrt(Sqr(dx) + Sqr(dy));
      k  :=  1.0;
      xe := x1;
      ye := y1;
      PenDown := True;
      While k <= kmax do begin
        xa := xe;
        ya := ye;
        xe := x1 + k * dx;
        ye := y1 + k * dy;
        If PenDown then begin
          draw_line_clip_on(Target, xa, ya, xe, ye);
          If Style = psDash then
            k := k + 0.5
          else
            k := k + 1.0;
          end
        else
          If Style = psDash then
            k := k + 1.0
          else
            k := k + 0.5;
        PenDown := Not PenDown;
        end;
      If PenDown then
        draw_line_clip_on(Target, xe, ye, x2, y2);
      end
    else begin
      Target.Pen.Style := Style;
      draw_line_clip_on(Target, x1, y1, x2, y2);
      end;
  end;

procedure draw_circle_on(Target: TCanvas; res, xm, ym, rx, ry: Double; Style: TPenStyle;
                         PL: TFloatPointList = Nil);
  var w, dw, wmax,
      sw1, cw1,
      sw2, cw2,
      dx0, dy0,
      ax, ay     : Double;
      x1, y1,
      x2, y2,
      cr, i, k   : Integer;
      is_vis,
      found,
      PenDown    : Boolean;
      IntPtList  : Array of TPoint;
      VList      : TVector3List;
  begin
  If (Abs(rx) < GDIMaxRadius) and
     (Abs(ry) < GDIMaxRadius) then
    If (InternalCurvStyle or (Target.Pen.Width > 1)) and
       (Style <> psSolid) then begin
      If rx < DistEpsilon then Exit;
      Case Style of
        psDash : dw := 0.40 * res / rx;
        psDot  : dw := 0.10 * res / rx;
      else
        dw := 0.25 * res / rx;
      end;
      Target.Pen.Style := psSolid;
      wmax := 2 * PI + dw * 0.5;
      PenDown := True;
      x1 := Round(xm - rx);
      y1 := Round(ym - ry);
      x2 := Round(xm + rx);
      y2 := Round(ym + ry);
      If Style = psDash then
        w := dw
      else
        w := dw * 0.5;
      cw2  :=  1.0;
      sw2  :=  0.0;
      While w < wmax do begin
        cw1 := cw2;
        sw1 := sw2;
        cw2 := cos(w);
        sw2 := sin(w);
        If PenDown then begin
          Target.Arc(x1, y1, x2, y2,
              Round (xm + cw2 * 5000), Round (ym + sw2 * 5000),
              Round (xm + cw1 * 5000), Round (ym + sw1 * 5000));
          If Style = psDash then
            w := w + dw * 0.5
          else
            w := w + dw;
          end
        else
          If Style = psDash then
            w := w + dw
          else
            w := w + dw * 0.5;
        PenDown := Not PenDown;
        end;
      end
    else begin
      Target.Pen.Style := Style;
      Target.Ellipse(Round(xm - rx), Round(ym - ry), Round(xm + rx), Round(ym + ry))
      end

  else begin   { Kreisradius außerhalb des erlaubten Bereichs      }
    With Target.ClipRect do begin
      x1 := (left + right) Div 2;    { Mittelpunkt des Canvas-     }
      y1 := (top + bottom) Div 2;    {   Clip-Rechtecks            }
      cr := Math.max(right - left, bottom - top) Div 2;
      end;
    w  := Hypot(x1-xm, y1-ym);
    If Abs(w-rx) < cr then begin { Kreislinie läuft durchs Fenster }
      { Suche Kreispunkt im Fenster  }
      dx0 := (x1-xm) / w * rx;       { Geht immer, ist aber bei    }
      dy0 := (ym-y1) / w * ry;       {   großen Radien ungenau,    }
      If PL <> Nil then begin        { daher: in PunktListe suchen }
        i := 0;                      {   falls es eine gibt !      }
        Repeat
          ax := PL[i].x;
          ay := PL[i].y;
          found := PtInRect(Target.ClipRect,
                            Point(SafeRound(ax), SafeRound(ay)));
          i := i + 1;
        until found or (i > High(PL));
        If found then begin
          dx0 := ax - xm;
          dy0 := ay - ym;     // ym - ay;
          end;
        end;
      { Fülle Stützpunktliste        }
      VList := TVector3List.Create;
      try
        dw := PI/12;
        is_vis := True;
        i := 0;
        While is_Vis and (i >= -24) do begin
          ax := xm + cos(i*dw) * dx0 + sin(i*dw) * dy0;
          ay := ym - sin(i*dw) * dx0 + cos(i*dw) * dy0;
          VList.Insert(0, TVector3.Create(ax, ay, 0));
          i := i - 1;
          is_Vis := PtInRect(Target.ClipRect, Point(Round(ax), Round(ay)));
          end;
        is_vis := True;
        k := 1;
        While is_Vis and (k <= 24 + i) do begin
          ax := xm + cos(k*dw) * dx0 + sin(k*dw) * dy0;
          ay := ym - sin(k*dw) * dx0 + cos(k*dw) * dy0;
          VList.Add(TVector3.Create(ax, ay, 0));
          k := k + 1;
          is_Vis := PtInRect(Target.ClipRect, Point(Round(ax), Round(ay)));
          end;
        { Zeichne eine Bezierkurve     }
        SetLength(IntPtList, VList.Count * 3 - 2);
        MakeBezierShapingPointList(VList, IntPtList);
        Target.PolyBezier(IntPtList);
        IntPtList := Nil;
      finally
        VList.Free;
      end;
      end;
    end;
  end;

function distortAngle(ang, asp: Double): Double;
  var sa, ca : Extended;
  begin
  SinCos(ang, sa, ca);
  sa := sa / asp;
  Result := slope_angle(ca, sa);
  end;

procedure draw_arc_on(Target         : TCanvas;
                      resx, resy,
                      xm, ym, rx, ry,
                      s_ang, e_ang   : Double;
                      Style          : TPenStyle);
  var w, dw, wmax,
      sw1, cw1,
      sw2, cw2   : Double;
      x1, y1,
      x2, y2     : Integer;
      PenDown    : Boolean;
  begin
  If (Abs(xm) + Abs(rx) < GDIMaxInt) and
     (Abs(ym) + Abs(ry) < GDIMaxInt) then begin
    If (rx < DistEpsilon) or
       (Abs(e_ang - s_ang) < AngleEpsilon) then Exit;
    If e_ang < s_ang then e_ang := e_ang + 2 * pi;
    If Not IsZero(e_ang - s_ang, 1e-6) then begin
      s_ang := DistortAngle(s_ang, resx/resy);
      e_ang := DistortAngle(e_ang, resx/resy);
      end;
    If (InternalCurvStyle or (Target.Pen.Width > 1))and
       (Style <> psSolid) then begin
      Case Style of
        psDash : dw := 0.40 * resx / rx;
        psDot  : dw := 0.10 * resx / rx;
      else
        dw := 0.25 * resx / rx;
      end;
      Target.Pen.Style := psSolid;
      wmax := e_ang;
      if wmax < s_ang then       // 09.03.10: Ergänzt wg. Bugreport
        wmax := wmax + 2*pi;     //           von Prof. Deißler!
      PenDown := True;
      x1 := Round(xm - rx);
      y1 := Round(ym - ry);
      x2 := Round(xm + rx);
      y2 := Round(ym + ry);
      If Style = psDash then
        w := s_ang + dw
      else
        w := s_ang + dw * 0.5;
      cw2  :=  cos(s_ang);
      sw2  :=  sin(s_ang);
      While w < wmax do begin
        cw1 := cw2;
        sw1 := sw2;
        cw2 := cos(w);
        sw2 := sin(w);
        If PenDown then begin
          Target.Arc(x1, y1, x2, y2,
              Round (xm + cw1 * 2000), Round (ym - sw1 * 2000),
              Round (xm + cw2 * 2000), Round (ym - sw2 * 2000));
          If Style = psDash then
            w := w + dw * 0.5
          else
            w := w + dw;
          end
        else
          If Style = psDash then
            w := w + dw
          else
            w := w + dw * 0.5;
        PenDown := Not PenDown;
        end;
      end
    else
      Target.Arc(Round(xm - rx), Round(ym - ry),
                 Round(xm + rx), Round(ym + ry),
                 Round(xm + cos(s_ang)*2000), Round (ym - sin(s_ang)*2000),
                 Round(xm + cos(e_ang)*2000), Round (ym - sin(e_ang)*2000));
    end
  else
    ;   { Da der "else"-Fall praktisch nie eintritt, riskieren wir hier
          einfach ein komplettes Unterdrücken jeglicher Grafikausgabe,
          zumindest bis es einen handfesten Grund gibt, nochmals Arbeit
          in dieses Teilproblem zu investieren. Dann unbedingt zuerst
          den entsprechenden Fall in "draw_circle_on" studieren und
          eine entsprechende Bezierkurven-Lösung konstruieren !        }
  end;

procedure draw_rectangle_on(Target: TCanvas; res, x1, y1, x2, y2: Double; Style: TPenStyle);
  begin
  If (InternalLineStyle or (Target.Pen.Width > 1)) and
     (Style <> psSolid) then begin
    draw_line_on(Target, res, x1, y1, x1, y2, Style);
    draw_line_on(Target, res, x1, y2, x2, y2, Style);
    draw_line_on(Target, res, x2, y2, x2, y1, Style);
    draw_line_on(Target, res, x2, y1, x1, y1, Style);
    end
  else
    If (Abs(x1) < GDIMaxInt) and (Abs(y1) < GDIMaxInt) and
       (Abs(x2) < GDIMaxInt) and (Abs(y2) < GDIMaxInt) then
    Target.Rectangle (Round(x1), Round(y1), Round(x2), Round(y2));
  end;

procedure draw_cross_on(Target: TCanvas; res, x, y, d: Double);
  var e : Double;
  begin
  If (Abs(x) + Abs(d) < GDIMaxInt) and
     (Abs(y) + Abs(d) < GDIMaxInt) then begin
    If Target.Pen.Width = 1 then
      e := d + 1
    else
      e := d;
    draw_line_on(Target, res, x-d, y, x+e, y, Target.Pen.Style);
    draw_line_on(Target, res, x, y-d, x, y+e, Target.Pen.Style);
    end;
  end;

procedure draw_xcross_on(Target: TCanvas; res, x, y, d: Double);
  var e: Double;
  begin
  If (Abs(x) + Abs(d) + 1 < GDIMaxInt) and
     (Abs(y) + Abs(d) + 1 < GDIMaxInt) then begin
    If Target.Pen.Width = 1 then
      e := d + 1
    else
      e := d;
    draw_line_on(Target, res, x-d, y-d, x+e, y+e, Target.Pen.Style);
    draw_line_on(Target, res, x-d, y+d, x+e, y-e, Target.Pen.Style);
    end;
  end;


procedure draw_htmlText_on(Target: TCanvas; sx, sy: Integer; fStr: String);
  { Gibt einen übergebenen ASCII-HTML-String "fs" auf dem Canvas "Target"
    aus. Dabei wird derzeit nur das Font-Tag interpretiert, um die
    Darstellung der griechischen Buchstaben zu ermöglichen.              }

  procedure ProcessTag(tagCmd: String; tagAttr: String; var sy: Integer);
    var sn       : String;
        fas, fae,            // FontAttributeStart, FontAttributeEnd
        i        : Integer;  
        ofm, nfm : TTextMetric;
    begin
    If tagCmd = 'font' then begin
      // FontFace
      fas := Pos('face', tagAttr);
      GetTextMetrics(Target.Handle, ofm);
      If fas > 0 then begin
        fas := PosEx('"', tagAttr, fas);
        fae := PosEx('"', tagAttr, fas + 1);
        tagAttr := Copy(tagAttr, Succ(fas), Pred(fae - fas));
        Target.Font.Name := tagAttr;
        GetTextMetrics(Target.Handle, nfm);
        sy := sy -(nfm.tmAscent - ofm.tmAscent);
        end;
      fas := Pos('size', tagAttr);
      If fas > 0 then begin
        fas := Pos('=', tagAttr);
        fas := PosEx('"', tagAttr, fas);
        fae := PosEx('"', tagAttr, fas + 1);
        sn := Copy(tagAttr, Succ(fas), Pred(fae - fas));
        If Length(sn) > 0 then
          Target.Font.Size := StrToInt(sn)
        else begin
          fas := Pos('=', tagAttr);
          Delete(tagAttr, 1, fas);
          sn := '';
          For i := 1 to Length(tagAttr) do
            If CharInSet(tagAttr[i], ['0'..'9']) then
              sn := sn + tagAttr[i];
          if Length(sn) > 0 then
            Target.Font.Size := StrToInt(sn)
          else
            Target.Font.Size := GlobalDefaultFont.Size;
          end;
        end;
      end
    else if tagCmd = 'sub' then begin
      sy := sy + Target.Font.Size Div 2;
      Target.Font.Size := Target.Font.Size * 3 Div 4;
      end
    else if tagCmd = 'sup' then begin
      sy := sy - Target.Font.Size Div 5;
      Target.Font.Size := Target.Font.Size * 3 Div 4;
      end
    else if tagCmd = 'b' then
      Target.Font.Style := Target.Font.Style + [fsBold]
    else if tagCmd = 'i' then
      Target.Font.Style := Target.Font.Style + [fsItalic]
    else if tagCmd = 'u' then
      Target.Font.Style := Target.Font.Style + [fsUnderLine]
      ;
    end;

  procedure ProcessHTML(ws: String; var sx: Integer; var sy: Integer);
    var startFont: TFont;
        tagContent,
        tagCmd,
        tagAttr,
        taggedData : String;
        ots, ote,              // OpenTagStart, OpenTagEnd
        cts, cte,              // CloseTagStart, CloseTagEnd
        old_sy,
        i          : Integer;
    begin
    startFont := TFont.Create;
    ots := Pos('<', ws);
    While ots > 0 do begin
      // Text vor dem Tag ausgeben:
      Target.TextOut(sx, sy, RebuildDelimiters(Copy(ws, 1, Pred(ots))));
      sx := Target.PenPos.X;
      // Tag-Daten erkunden:
      ote := PosEx('>', ws, ots + 1);
      i := 1;
      tagContent := trim(Copy(ws, Succ(ots), Pred(ote - ots)));
      tagCmd := '';
      While (i <= Length(tagContent)) and
            CharInSet(tagContent[i], ['A'..'Z', 'a'..'z']) do begin
        tagCmd := tagCmd + tagContent[i];
        i := i + 1;
        end;
      tagAttr := trim(Copy(tagContent, Length(tagCmd) + 1, Length(tagContent)));
      cts := PosEx('</' + tagCmd, ws, ote);
      cte := PosEx('>', ws, cts + 1);
      If cts = 0 then begin       // Notfall: Schließendes Tag fehlt !
        cts := Length(ws) + 1;
        cte := cts;
        end;
      taggedData := Copy(ws, Succ(ote), Pred(cts - ote));
      // Tag-Kommando ausführen
      startFont.Assign(Target.Font);
      old_sy := sy;
      ProcessTag(tagCmd, tagAttr, sy);
      ProcessHTML(taggedData, sx, sy); // Text im Tag ausgeben
      Target.Font.Assign(startFont);
      sy := old_sy;
      Delete(ws, 1, cte);
      ots := Pos('<', ws);
      end;
    //Text nach dem FontTag ausgeben
    Target.TextOut(sx, sy, RebuildDelimiters(ws));
    sx := Target.PenPos.X;
    startFont.Free;
    end;

  begin
  ProcessHTML(fStr, sx, sy);
  end;

   {====== TPointParams ==========================}

constructor TPointParams.CreateWithDataFrom(Pt: TObject);
  begin
  Inherited Create;
  LoadDataFrom(Pt);
  end;

constructor TPointParams.Load32(R: TReader);
  begin
  Inherited Create;
  ppX := R.ReadFloat;
  ppY := R.ReadFloat;
  R.ReadFloat;
  ppLast_dx := R.ReadFloat;
  ppLast_dy := R.ReadFloat;
  ppFStatus := R.ReadInteger;
  end;

procedure TPointParams.LoadPosFrom(Pt: TObject);
  begin
  With TGPoint(Pt) do begin
    ppX := X;
    ppY := Y;
    ppFStatus := Status;
    end;
  end;

procedure TPointParams.LoadMoveFrom(Pt: TObject);
  begin
  With TGPoint(Pt) do begin
    ppLast_dx := Lastdx;
    ppLast_dy := Lastdy;
    end;
  end;

procedure TPointParams.LoadDataFrom(Pt: TObject);
  begin
  LoadPosFrom(Pt);
  LoadMoveFrom(Pt);
  end;

procedure TPointParams.WriteDataTo(Pt: TObject);
  begin
  TGPoint(Pt).RestorePointParams(ppX, ppY,  ppFStatus,
                                 ppLast_dx, ppLast_dy);
  end;


   {====== TPPInitDataList =======================}

constructor TPPInitDataList.Load32(R: TReader);
  begin
  Inherited Create;
  R.ReadListBegin;
  While Not R.EndOfList do
    Add(TPointParams.Load32(R));
  R.ReadListEnd;
  end;

destructor TPPInitDataList.Destroy;
  var i : Integer;
  begin
  For i := Pred(Count) downto 0 do begin
    TPointParams(Items[i]).Free;
    Items[i] := Nil;
    end;
  Clear;
  Inherited Destroy;
  end;

   {====== TObjNum ===============================}

type TObjNum = class(TObject)
                 public
                   num : Integer;
                   constructor Load(var S: TFileStream);
               end;

constructor TObjNum.Load(var S: TFileStream);
  var idNum : Integer;
  begin
  idNum := ReadOldIntFromStream(S);  { 98h }
  If idNum = $98 then
    num   := ReadOldIntFromStream(S)
  else
    raise EStreamError.Create ('ObjektPointer erwartet!');
  end;

   {====== TObjPtrList ===========================}

constructor TObjPtrList.Create(iDuplicatesAllowed: Boolean);
  begin
  Inherited Create;
  BackupList := TList.Create;
  DuplicatesAllowed := iDuplicatesAllowed;
  end;

destructor TObjPtrList.Destroy;
  begin
  BackupList.Free;
  Inherited Destroy;
  end;

constructor TObjPtrList.Load(var S: TFileStream);
  var id, n, i : Integer;
      buf      : TObjNum;
  begin
  id := ReadOldIntFromStream(S);
  If id = $32 then begin
    n := ReadOldIntFromStream(S);
    ReadOldIntFromStream(S);
    ReadOldIntFromStream(S);
    For i := 0 to Pred(n) do begin
      buf := TObjNum.Load(S);
      Add(Pointer(buf.num));
      buf.Free;
      end;
    BackupList := TList.Create;
    DuplicatesAllowed := False;
    end
  else
    Raise EStreamError.Create('ObjektPointerListe erwartet!');
  end;

constructor TObjPtrList.Load32(R: TReader);
  { Lädt Integer-GeoNummern aus einer Datei;
    die Umwandlung in gültige Pointer muß gegebenenfalls
    anschließend extern geschehen.                       }
  var n : Integer;
  begin
  R.ReadListBegin;
  While not R.EndOfList do begin
    n := R.ReadInteger;
    Add(Pointer(n));
    end;
  R.ReadListEnd;
  BackupList := TList.Create;
  DuplicatesAllowed := False;
  end;

function TObjPtrList.Add(Item: Pointer): Integer;
  begin
  If DuplicatesAllowed or
     (IndexOf(Item) < 0) then
    Result := Inherited Add(Item)
  else
    Result := -1;
  end;

procedure TObjPtrList.Insert(Index: Integer; Item: Pointer);
  begin
  If DuplicatesAllowed or
     (IndexOf(Item) < 0) then
    Inherited Insert(Index, Item);
  end;

procedure TObjPtrList.AddBlinking(GO: Pointer; OBE: Boolean);
  { OBE = "O"bject "B"link "E"nable }
  begin
  Add(GO);
  If Not TGeoObj(GO).IsBlinking then
    TGeoObj(GO).InitBlinking(OBE);
  end;

procedure TObjPtrList.SaveState;
  var i : Integer;
  begin
  BackupList.Clear;
  For i := 0 to Pred(Count) do
    BackupList.Add(Items[i]);
  end;

procedure TObjPtrList.RestoreState;
  var i : Integer;
  begin
  Clear;
  For i := 0 to Pred(BackupList.Count) do
    Add(BackupList.Items[i]);
  end;

function TObjPtrList.SafeGetGeoNum(index: Integer): Integer;
  begin
  Try
    Result := TGeoObj(Items[index]).GeoNum
  except
    Result := Integer(Items[index]);
  end;
  end;

function TObjPtrList.GetGeoNumString: String;
  var i: Integer;
  begin
  Result := '';
  For i := 0 to Pred(Count) do
    Result := Result + IntToStr(SafeGetGeoNum(i)) + ';';
  If Length(Result) > 0 then
    System.Delete(Result, Length(Result), 1);
  end;

procedure TObjPtrList.SetGeoNumString(NumStr: String);
  { 10.05.09 : Check auf unzulässige Zeichen [*] hinzugefügt, weil in
               "Steibl_Hausaufgaben.geo" der aus der GEO-XML-Datei
    herausgelesene Parent-Listen-String plötzlich von Leerzeichen
    eingerahmt war. Es bleibt myteriös, warum diese Leerzeichen
    aufgetaucht sind; jedenfalls führten sie stets zum Scheitern
    der StrToInt-Funktion. }
  var i: Integer;
  begin
  for i := Length(NumStr) downTo 1 do       // [*]
    if Not CharInSet(NumStr[i], ['0'..'9', ';']) then
      System.Delete(NumStr, i, 1);
  i := Pos(';', NumStr);
  While i > 0 do begin
    Add(Pointer(StrToInt(Copy(NumStr, 1, i-1))));
    System.Delete(NumStr, 1, i);
    i := POS(';', NumStr);
    end;
  If Length(NumStr) > 0 then
    Add(Pointer(StrToInt(NumStr)));
  end;

procedure TObjPtrList.ResolveGeoNums(GOList: TList);
  var GO : TGeoObj;
      i  : Integer;
  begin
  For i := Pred(Count) downto 0 do begin
    GO := (GOList as TGeoObjListe).GetObj(Integer(Items[i]));
    If GO <> Nil then
      Items[i] := GO
    else
      If (GOList as TGeoObjListe).IndexOf(Items[i]) < 0 then
        Delete(i);
    end;
  end;

procedure TObjPtrList.BringFreePointsToListStart;
  var GO   : TGeoObj;
      b, i : Integer;
  begin
  b := 0;                 { Ungebundene Basispunkte nach vorne bringen !  }
  While (b < Count) and
        (TGeoObj(Items[b]) is TGPoint) and
        (TGPoint(Items[b]).Parent.Count = 0) do
    b := b + 1;
  i := Pred(Count);
  While i >= b do begin
    If (TGeoObj(Items[i]) is TGPoint) and
       (TGPoint(Items[i]).Parent.Count = 0) then begin
      GO := Items[i];
      Delete(i);
      Insert(0, GO);
      b := b + 1;         { b = Zahl der Basispunkte am Anfang der Liste  }
      end
    else
      i := i - 1;
    end;
  end; { of BringFreePointsToListStart }

procedure TObjPtrList.BringNameObjToListStart;
  var GO   : TGeoObj;
      i, k : Integer;
  begin
  i := Pred(Count);
  k := i;
  While (i > 0) and (k > 0) do begin
    If TGeoObj(Items[i]) is TGName then begin
      GO := Items[i];
      Delete(i);
      Insert(0, GO);
      k := k - 1;
      end
    else begin
      k := k - 1;
      i := i - 1;
      end;
    end;
  end; { of BringNameObjToListStart }

procedure TObjPtrList.BringSetsquareToListStart;
  var GO : TGeoObj;
      i  : Integer;
  begin
  For i := Pred(Count) downto 1 do
    If TGeoObj(Items[i]) is TGSetsquare then begin
      GO := Items[i];
      Delete(i);
      Insert(0, GO);
      end;
  end;

procedure TObjPtrList.SortByDependencies;
  var GO      : TGeoObj;
      i, k, n : Integer;
  begin
  i := 0;
  While i < Count do begin
    GO := TGeoObj(Items[i]); { Objekt fokussieren                       }
    k := 0;                  { Index in die Eltern-Liste initialisieren }
    While k < GO.Parent.Count do begin
      n := IndexOf(GO.Parent[k]);
      If n > i then begin       { Elter ist in der Liste *hinter* GO :  }
        Delete(i);              {   vorne raus-operieren und direkt     }
        Insert(n, GO);          {   hinter dem Elter einsortieren !     }
        GO := TGeoObj(Items[i]);       { Neues i. Objekt fokussieren    }
        k := 0;                        { und Untersuchung neu starten   }
        end
      else
        k := k + 1;             { nächsten Elter untersuchen            }
      end;
    i := i + 1;              { nächstes Objekt !                        }
    end;
  end;

   {====== TSortedGObjList =======================}

constructor TSortedGObjList.CreateSortedCopyOf(iSource: TList);
  var i, n, maxIndex, maxSteps : Integer;
  begin
  Inherited Create;
  Source   := iSource;
  n        := 0;
  maxIndex := (Source as TGeoObjListe).LastValidObjIndex;
  maxSteps := SQR (maxIndex + 1);
  While Pred(Count) < maxIndex do begin
    i := 0;
    While (i <= maxIndex) and (n <= maxSteps) do begin
      If Okay2Transfer(Source.Items[i]) then
        Add(Source.Items[i]);
      Inc(i);
      Inc(n);
      end;
    end;
  FValid := n <= maxSteps;
  end;

function TSortedGObjList.Okay2Transfer(GO: TObject): Boolean;
  var i : Integer;
  begin
  If (IndexOf(GO) < 0) then begin   { GO noch nicht in der Zielliste ! }
    Result := True;
    For i := 0 to Pred(TGeoObj(GO).Parent.Count) do
      If IndexOf(TGeoObj(GO).Parent[i]) < 0 then begin
        Result := False;
        Exit;
        end;
    end
  else
    Result := False;
  end;


   {====== TNameNumList ==========================}

constructor TNameNumList.Create;
  begin
  List := TStringList.Create;
  List.Sorted := True;
  List.Duplicates := dupIgnore;
  end;

destructor TNameNumList.Destroy;
  begin
  List.Free;
  Inherited Destroy;
  end;

function TNameNumList.GetNextFreeSuffixOf(nam: String): Integer;
  var n : Integer;
  begin
  If List.Find(nam, n) then
    Result := Integer(List.Objects[n])
  else
    Result := 1;
  end;

procedure TNameNumList.SetNextFreeSuffixOf(nam: String; num: Integer);
  var n : Integer;
  begin
  If List.Find(nam, n) then
    List.Objects[n] := Pointer(num)
  else
    List.AddObject(nam, Pointer(num));
  end;

   {====== TWorld ================================}

constructor TWorld.Create (Wnd: HWnd);
  var R : TRect;
  begin
  Inherited Create;
  If (Wnd = 0) or
     Not GetClientRect(Wnd, R) then begin
    R.Left   := 0;
    R.Top    := 0;
    R.Right  := Screen.Width;
    R.Bottom := Screen.Height;
    end;
  Initialize(R);
  end;

procedure TWorld.Initialize(iRect: TRect);
  begin
  FRect := iRect;
  With FRect do begin
    fx_center := right  / 2.0;
    fy_center := bottom / 2.0;
    radius_2 := Sqr(fx_center) + Sqr(fy_center) + 1.0;
    fradius  := Sqrt(radius_2);
    left   := left   + 2;
    right  := right  - 2;
    top    := top    + 2;
    bottom := bottom - 2;
    end;
  end;

function TWorld.LastInitRect : TRect;
  begin
  Result := FRect;
  With Result do begin
    left   := left   - 2;
    right  := right  + 2;
    top    := top    - 2;
    bottom := bottom + 2;
    end;
  end;

procedure TWorld.GetLongLineBorderPoints(var x1, y1, x2, y2 : Double);
  var r1x, r1y,
      r2x, r2y : Double;
      v1,  v2  : Boolean;
  begin
  IntersectCircleWithLine(x_center, y_center, Radius, x1, y1, x2, y2,
                          r1x, r1y, r2x, r2y, v1, v2);
  If v1 then begin
    x1 := r1x;
    y1 := r1y;
    end;
  If v2 then begin
    x2 := r2x;
    y2 := r2y;
    end;
  end;

function TWorld.Knows (x, y: Double): Boolean;     { liefert genau dann "True", wenn der übergebene Punkt  }
  begin                                            { im "Einflußbereich" der aktuellen Welt liegt.         }
  Knows := Sqr(x - fx_center) + Sqr (y - fy_center) < radius_2;
  end;


   {====== TStift ================================}

constructor TStift.Load(var S: TFileStream);
  begin
  With Daten do begin
    lopnStyle   := ReadOldIntFromStream(S);
    lopnWidth.x := ReadOldIntFromStream(S);
    lopnWidth.y := ReadOldIntFromStream(S);
    S.Read(lopnColor, SizeOf(TColorRef));
    end;
  PenHandle := CreatePenIndirect(Daten);
  is_used   := True;
  end;

destructor TStift.Done;
  begin
  DeleteObject(PenHandle);
  end;


   {====== TStiftListe ===========================}

constructor TStiftListe.Load(var S: TFileStream);
  var dummy, n, id, i  : Word;
  begin
  S.Read(n, SizeOf(n));
  S.Read(dummy, SizeOf(dummy));
  S.Read(dummy, SizeOf(dummy));

  For i := 0 to Pred(n) do begin
    S.Read(id, SizeOf(id));
    If id = $96 then
      Add(TStift.Load(S))
    else
      raise EStreamError.Create('Stift-Daten erwartet!');
    end;
  end;

   {====== TPinsel ===============================}

constructor TPinsel.Load(var S: TFileStream);
  begin
  With Daten do begin
    lbStyle := ReadOldIntFromStream(S);
    S.Read(lbColor, SizeOf(TColorRef));
    lbHatch := ReadOldIntFromStream(S);
    end;
  BrushHandle := CreateBrushIndirect(Daten);
  is_used     := True;
  end;

destructor TPinsel.Done;
  begin
  DeleteObject(BrushHandle);
  end;


   {====== TPinselListe ==========================}

constructor TPinselListe.Load(var S: TFileStream);
  var dummy, n, id, i : Word;
  begin
  S.Read(n, SizeOf(n));
  S.Read(dummy, SizeOf(dummy));
  S.Read(dummy, SizeOf(dummy));

  For i := 0 to Pred(n) do begin
    S.Read(id, SizeOf(id));
    If id = $97 then
      Add(TPinsel.Load(S))
    else
      raise EStreamError.Create('Pinsel-Daten erwartet!');
    end;
  end;


{=========== Menü-Hilfsprozeduren =====================}

procedure AddPopupMenuItemTo(TargetMenu: TPopupMenu;
                             iCaption: String;
                             iOnClick: TNotifyEvent;
                             iTag : Integer;
                             iChecked: Boolean = False);
  var newitem : TMenuItem;
  begin
  newitem:= TMenuItem.Create(TargetMenu);
  newitem.Caption := iCaption;
  newitem.OnClick := iOnClick;
  newitem.Tag     := iTag;
  newitem.Checked := iChecked;
  TargetMenu.Items.Add(newitem);
  end;


{=========== Stream-Hilfsprozeduren ===================}

procedure WriteOldStrToStream (S: TStream; s2w : String);
  var n : Word;
  begin
  n := Length(s2w);
  S.Write(n, SizeOf(n));
  S.Write(s2w[1], n);
  end;

function ReadOldStrFromStream (S : TStream; propSize : Integer = 0) : String;
  var n   : Word;
      buf : String[255];
  begin
  S.Read(n, SizeOf(n));
  If n > 0 then begin
    If propSize > 0 then
      n := propSize
    else
      If n > 255 then n := 255;
    buf := ' ';
    SetLength(buf, n);
    S.Read(buf[1], n);
    end
  else
    buf := '';
  ReadOldStrFromStream := String(buf);
  end;

function ReadOldIntFromStream (S: TStream) : Integer;
  var SI : SmallInt;
  begin
  S.Read(SI, SizeOf(SI));
  Result := SI;
  end;

function SearchFirst(s: TStream; ss: String): Integer;
  { Sucht im Stream s ab der aktuellen Position nach der Zeichenfolge ss.
    Falls ss gefunden wird, wird die Stream-Position des nächsten auf ss
    folgenden Zeichens zurückgeliefert; falls nicht, wird -1 zurückgegeben. }
  var cr : String;
      i  : Integer;
  begin
  Result := -1;
  SetLength(cr, Length(ss));
  For i := 1 to Length(ss) do
    cr[i] := '*';
  i := 1;
  Repeat
    s.Read(cr[i], 1);
    if cr[i] = ss[i] then
      i := i + 1
    else
      i := 1;
  until (i > Length(ss)) or (s.Position >= s.Size);
  if cr = ss then
    Result := s.Position;
  end;

function SkipCommentsIn(s: TStream): Integer;
  { Überliest im Stream einen XML-Kommentar ( also ein Tag
    der Form <!-- [........] -->  mit beliebigem Inhalt );
    liefert die Position hinter diesem Tag zurück }
  var apos : Integer;
  begin
  Result := 0;
  s.Position := 0;
  apos := SearchFirst(s, '<!--');
  if apos >= 0 then begin
    apos := SearchFirst(s, '-->');
    if (apos > 0) and (apos < s.Size) then
      Result := apos;
    end;
  end;



{----- BitMaps (komprimiert) in einen Stream schreiben
                       bzw. aus einem Stream lesen -------------}

type T256Palette = array [0..255] of TRGBQuad;
     P256Bitmap  = ^T256Bitmap;
     T256Bitmap  = packed record
                     b256File : TBitmapFileHeader;
                     b256Info : TBitmapInfoHeader;
                     b256Pal  : T256Palette;
                     b256Data : record end;
                   end;
     PICInfo     = ^TICInfo;
     TICInfo     = packed record
                     dwSize,                  // sizeof (TICInfo)
                     fccType,                 // compressor type eg vidc
                     fccHandler,              // compressor subtype eg rle
                     dwFlags,                 // lo word is type specific
                     dwVersion,               // version of driver
                     dwVersionICM : DWORD;    // version of the ICM
                     szName : array [0..15] of wchar;           // short name
                     szDescription : array [0..127] of wchar;   // long name
                     szDriver : array [0..127] of wchar;        // driver that contains the compressor
                   end;
     TICHandle   = THandle;

const
  ICMODE_COMPRESS = 1;
  ICTYPE_VIDEO    = ord ('v') +
                    ord ('i') shl  8 +
                    ord ('d') shl 16 +
                    ord ('c') shl 24;
  BitmapSignature = $4D42;

function ICLocate (fccType, fccHandler: DWORD; lpbiIn, lpbmOut : PBitmapInfoHeader; wFlags: word) : TICHandle;
  stdcall; external 'msvfw32.dll' name 'ICLocate';

function ICGetInfo (Handle: TICHandle; var ICInfo: TICInfo; cb: DWORD): LRESULT;
  stdcall; external 'msvfw32.dll' name 'ICGetInfo';

function ICImageCompress (Handle: TICHandle; uiFlags: UINT; lpbiIn: PBitmapInfo;
  lpBits: pointer; lpbiOut: PBitmapInfo; lQuality: integer; plSize: PInteger): HBitmap;
  stdcall; external 'msvfw32.dll' name 'ICImageCompress';

function ICClose (Handle: TICHandle): LRESULT;
  stdcall; external 'msvfw32.dll' name 'ICClose';

function CompressPalette (var Pal: T256Palette; Data: pointer; DataSize: integer): word;
  { compress a 256 colour palette by removing unused entries;
    returns new number of entries                             }
  type TPaletteUsed = packed record
                        Used : boolean;
                        NewEntry : byte;
                      end;
       TPaletteUsedArray = array [0..255] of TPaletteUsed;
  var PUArray : TPaletteUsedArray;
      Scan    : PByte;
      NewValue,
      Loop    : integer;
      NewPal  : T256Palette;
  begin
  { look through the bitmap data bytes looking
    for palette entries in use                 }
  fillchar (PUArray, sizeof (PUArray), 0);
  Scan:= Data;
  for Loop:= 1 to DataSize do begin
    PUArray[Scan^].Used := true;
    inc (Scan);
    end;

  { go through palette and set new entry numbers for those in use }
  NewValue := 0;
  for Loop:= 0 to 255 do
    with PUArray[Loop] do
      if Used then begin
        NewEntry := NewValue;
        inc (NewValue);
        end;
  Result := NewValue; // return number in use
  if NewValue = 256 then exit;

  { go through bitmap data assigning new palette numbers }
  Scan:= Data;
  for Loop:= 1 to DataSize do begin
    Scan^ := PUArray[Scan^].NewEntry;
    inc (Scan);
    end;

  { create a new palette and copy across only those entries in use }
  fillchar (NewPal, sizeof (T256Palette), 0);
  for Loop := 0 to 255 do
    with PUArray [Loop] do
      if Used then
        NewPal[NewEntry] := Pal [Loop];

  { return the new palette }
  Pal := NewPal;
  end;


function CompressBMPFile(InMS: TMemoryStream): Integer;
  { Result = 0 : alles okay, kein Fehler
             1 : Daten enthalten kein BMP
             2 : BMP ist nicht 8Bit
             3 : BMP ist schon komprimiert
             4 : Kein Komprimierer gefunden
             5 : Komprimierungsfehler         }

  var InMSCopy      : TMemoryStream;
      Handle        : THandle;
      CompressHandle: Integer;
      ICInfo        : TICInfo;
      OutBitmap,
      InBitmapCopy  : P256Bitmap;
      CompressedStuff,
      OutData,
      InDataCopy    : pointer;
      InDataSize,
      OutSize,
      InColours,
      OutColours    : integer;

  function CompressIt : Integer;
    begin
    Result := 5;
    try
      with InBitmapCopy^ do begin
        if b256Info.biClrUsed = 0 then
          InColours := 256
        else
          InColours := b256Info.biClrUsed;
        { determine size of data bits }
        with b256Info do
          if biSizeImage = 0 then
            InDataSize := biWidth * biHeight
          else
            InDataSize := biSizeImage;
        end;
      InDataCopy := pointer(integer(InBitmapCopy) +
                            sizeof (TBitmapFileHeader) +
                            sizeof (TBitmapInfoHeader) +
                            InColours * sizeof (TRGBQuad));
      with InBitmapCopy^ do
        OutColours := CompressPalette (b256Pal, InDataCopy, InDataSize);
      { now copy the input file to fill in most of the output bitmap values }
      Move (InBitmapCopy^, OutBitmap^, sizeof (T256Bitmap));
      { set the compression required  }
      OutBitmap^.b256Info.biCompression := BI_RLE8;

      { find a compressor }
      CompressHandle := ICLocate (ICTYPE_VIDEO, 0, @InBitmapCopy^.b256Info,
                                  @OutBitmap.b256Info, ICMODE_COMPRESS);
      If CompressHandle = 0 then
        Result := 4
      else begin
        try
          fillchar (ICInfo, sizeof (TICInfo), 0);
          ICInfo.dwSize := sizeof (TICInfo);
          { get info on the compressor }
          ICGetInfo (CompressHandle, ICInfo, sizeof (TICInfo));
          OutSize := 0;  { best compression }
          { now compress the image }
          Handle := ICImageCompress (CompressHandle, 0,
                                     @InBitmapCopy^.b256Info,
                                     InDataCopy, @OutBitmap^.b256Info,
                                     10000, @OutSize);
        finally
          ICClose (CompressHandle)
        end;

        if Handle <> 0 then begin  { get the compressed data }
          CompressedStuff := GlobalLock (Handle);
          try
            { modify the filesize and offset in case palette has shrunk }
            with OutBitmap^.b256File do begin
              bfOffBits := sizeof (TBitmapFileHeader) +
                           sizeof(TBitmapInfoHeader) +
                           OutColours * sizeof (TRGBQuad);
              bfSize := bfOffBits + DWord(OutSize);
              end;
            { locate the data }
            OutData := pointer (integer(CompressedStuff) +
                                sizeof(TBitmapInfoHeader) +
                                InColours * sizeof (TRGBQuad));
            { modify the bitmap info header }
            with OutBitmap^.b256Info do begin
              biSizeImage := OutSize;
              biClrUsed := OutColours;
              biClrImportant := 0;
              end;
            { export the bitmap to the stream }
            with InMS do begin
              Clear;
              Write (OutBitmap^, sizeof (TBitmapFileHeader) +
                                 sizeof (TBitmapInfoHeader));
              Write (InBitmapCopy^.b256Pal, OutColours*sizeof (TRGBQuad));
              Write (OutData^, OutSize)
              end;

            Result := 0;   { Success !!! }
          finally
            GlobalUnlock(Handle)
          end;   { of try }
          end  { of if}
        end; { of else }
    except
      { do nothing }
    end; { of try }
    end;

  begin
  InMSCopy := TMemoryStream.Create;
  InMSCopy.LoadFromStream(InMS);
  InBitmapCopy := P256BitMap(InMSCopy.Memory);
  New(OutBitMap);
  try
    with InBitmapCopy^ do
      if b256File.bfType = BitmapSignature then
        if b256Info.biBitCount = 8 then
          if b256Info.biCompression = BI_RGB then
            { Ok, we have a 256 colour, uncompressed bitmap }
            Result := CompressIt
          else
            Result := 3  { Bitmap already compressed }
        else
          Result := 2  { Not a 256 colour bitmap }
      else
        Result := 1; { Not a bitmap at all }
  finally
    Dispose(OutBitmap);
    InMSCopy.Free;
  end; { of try }
  end;

function WriteBitMapDataByWriter (W : TWriter; BMP: TBitMap): Integer;
  var MS       : TMemoryStream;
      LocalBMP : TBitMap;
  begin
  try
    MS := TMemoryStream.Create;
    BMP.SaveToStream(MS);

    { Reduzierung der Farbtiefe auf 256 Farben, um Platz zu sparen }
    MS.Position := 0;
    LocalBMP := TBitMap.Create;
    LocalBMP.LoadFromStream(MS);
    MS.Clear;
    LocalBMP.PixelFormat := pf8Bit;
    LocalBMP.SaveToStream(MS);
    LocalBMP.Free;

    { Versuche, die Daten zu komprimieren : }
    If MS.Size > 0 then
      CompressBMPFile(MS);

    { Jetzt wird gespeichert : }
    W.WriteInteger(MS.Size);
    W.Write(MS.Memory^, MS.Size);
    W.FlushBuffer;
    MS.Free;
    Result :=  0;
  except
    Result :=  1;
  end;
  end;

function  ReadBitMapDataByReader (R: TReader; BMP: TBitMap): Integer;
  var MS   : TMemoryStream;
      oldPos,
      Size : Integer;
  begin
  Result := 1;
  oldPos := R.Position;
  If R.NextValue in [vaInt8, vaInt16, vaInt32] then
    try
      Size := R.ReadInteger;
      If Size > 0 then begin
        MS := TMemoryStream.Create;
        MS.SetSize(Size);
        R.Read(MS.Memory^, MS.Size);
        BMP.LoadFromStream(MS);
        MS.Free;
        end;
      Result := 0;
    except
      R.Position := oldPos;
    end;
  end;

procedure PackBMPIntoString(BitMap: TBitMap; var s: String);
  var m_s      : TMemoryStream;
      z_s      : TCompressionStream;
      DataSize : Int64;
      b, r, i  : Integer;  { b_itmapdata, r_eadcount }
  begin
  m_s := TMemoryStream.Create;
  z_s := TCompressionStream.Create(clMax, m_s);
  BitMap.SaveToStream(z_s);
  DataSize := z_s.Position;
  z_s.Free;

  s := IntToStr(DataSize) + ';'#13#10;
  m_s.Position := 0;
  b := 0;
  i := 0;
  Repeat
    r := m_s.Read(b, 4);
    s := s + IntToHex(b, 8);
    i := i + 1;
    If i > 20 then begin
      s := s + #13#10;
      i := 0;
      end
    else
      i := i + 1;
  until r < 4;
  m_s.Free;
  end;

procedure LoadBMPFromString(s: String; BitMap: TBitMap);
  var m_s, d_s : TMemoryStream;
      z_s      : TDecompressionStream;
      DataSize : Int64;
      b, i     : Integer;   { b_itmapdata }
  begin
  i := POS(';', s);                        // Datenblockgröße lesen
  DataSize := StrToInt(Copy(s, 1, Pred(i)));
  Delete(s, 1, i);

  For i := Length(s) DownTo 1 do           // Zeilenumbrüche raus
    If (s[i] = #10) or (s[i] = #13) then
      Delete(s, i, 1);

  m_s := TMemoryStream.Create;             // Hex-Text in Zahlen konvertieren
  While Length(s) > 0 do begin
    b := StrToInt('$' + Copy(s, 1, 8));
    m_s.Write(b, SizeOf(b));
    Delete(s, 1, 8);
    end;
  m_s.Position := 0;

  d_s := TMemoryStream.Create;
  d_s.SetSize(DataSize);
  z_s := TDecompressionStream.Create(m_s);
  z_s.Read(d_s.Memory^, DataSize);
  z_s.Free;
  m_s.Free;
  BitMap.LoadFromStream(d_s);
  d_s.Free;
  end;


procedure patch_DPIres_in_BMP_Stream(outStream: TStream; outDPI: Integer);
  const error_msg: String = 'Stream write error during DPI patch.';
  var data: Integer;   // 4 Byte signed
  begin
  data := Round(outDPI * 100 / 2.54); // Get DotsPerMeter from DotsPerInch
  try
    outStream.seek(38, soFromBeginning);
    if outStream.Write(data, 4) <> 4 then
      SpyOut(error_msg, [])
    else begin
      if outStream.Write(data, 4) <> 4 then
        SpyOut(error_msg, []);
      end;
  finally
    outStream.Position := 0;
  end; // of try
  end;

procedure patch_DPIres_in_JPG_Stream(outStream: TStream; outDPI: Integer);
  type TDataBlock = Record
                     units  : Byte;
                     x_dens : Word;
                     y_dens : Word;
                   end;
  const JFIF_Id    : ShortString = 'JFIF' + #$00;
        bufferSize : Integer    = 60;
        error_msg  : String     = 'Stream write error during DPI patch.';
  var data   : TDataBlock;
      n      : Integer;
      buffer : ShortString;
  begin
  try
    SetLength(buffer, bufferSize + 1);
    outStream.Position := 0;
    outStream.Read(buffer[1], bufferSize);
    n := POS(JFIF_Id, buffer);
    if n > 0 then begin
      data.units  := 1;                   // unit is dpi
      data.x_dens := Swap(Word(outDPI));  // switch byte order
      data.y_dens := Swap(Word(outDPI));  // switch byte order
      outStream.seek(n + 6, soFromBeginning);
      if (outStream.Write(data.units, 1) <> 1) or
         (outStream.Write(data.x_dens, 2) <> 2) or
         (outStream.Write(data.y_dens, 2) <> 2) then
        SpyOut(error_msg, []);
      end
  finally
    outStream.Position := 0;
  end;
  end;


{============ Zeitstempel-Hilfsprozeduren ===================}

var TimeZoneInfo  : TTimeZoneInformation;
    TZI_available : Boolean;

procedure InitTimeZoneInfo;
  var tz_res : Integer;
  begin
  tz_res := GetTimeZoneInformation(TimeZoneInfo);
  TZI_available := (tz_res = Time_Zone_Id_Standard) or
                   (tz_res = Time_Zone_Id_Daylight);
  end;

function  GetDateTimeFromFileTime(file_t: TFileTime): TDateTime;
  var st, lst : TSystemTime;
      lft     : TFileTime;
  begin
  FileTimeToSystemTime(file_t, st);
  If TZI_available and
     SystemTimeToTzSpecificLocalTime(@TimeZoneInfo, st, lst) then begin
    Result := SystemTimeToDateTime(lst);
    end
  else begin
    FileTimeToLocalFileTime(file_t, lft);
    FileTimeToSystemTime(lft, lst);
    Result := SystemTimeToDateTime(lst);
    end;
  end;

function GetDateTimeFromFATTime(fat_t: Integer): TDateTime;
  var lft, ft : TFileTime;
  begin
  DosDateTimeToFileTime(HiWord(fat_t), LoWord(fat_t), lft);
  LocalFileTimeToFileTime(lft, ft);
  Result := GetDateTimeFromFileTime(ft);
  end;

{=============== OCX-Registrierung ===============================}

type
  TRegProc = function : HResult; stdcall;

function RegisterAxLib(filepath: String; regflag: Boolean) : Boolean;
  const ProcName: array[0..1] of PChar =
                    ('DllUnregisterServer', 'DllRegisterServer');
  var LibHandle : THandle;
      RegProc   : TRegProc;
      n         : Integer;
  begin
  Result := False;
  If regflag then n := 1 else n := 0;
  LibHandle := LoadLibrary(PChar(filepath));
  if LibHandle <> 0 then
    try
      @RegProc := GetProcAddress(LibHandle, ProcName[n]);
      Result := (@RegProc <> Nil) and
                (RegProc = 0)
    finally
      FreeLibrary(LibHandle);
    end;
  end;

function RegisterOCX(filepath : String) : Boolean;
  begin
  If FileExists(filepath) and
     (Uppercase(ExtractFileExt(filepath)) = '.OCX') then
    Result := RegisterAxLib(filepath, True)
  else
    Result := False;
  end;

function UnregisterOCX(filepath : String) : Boolean;
  begin
  If FileExists(filepath) and
     (Uppercase(ExtractFileExt(filepath)) = '.OCX') then
    Result := RegisterAxLib(filepath, False)
  else
    Result := False;
  end;


{=============== TDataStack ======================================}

type TDataStackItem = class(TObject)
                      public
                        ItemSize : Integer;
                        ItemPtr  : Pointer;
                      end;

destructor TDataStack.Destroy;
  begin
  Clear;
  Inherited Destroy;
  end;

function TDataStack.is_empty: Boolean;
  begin
  Result := Count = 0;
  end;

procedure TDataStack.pop(vp: Pointer);
  begin
  If Count > 0 then begin
    With TDataStackItem(Last) do begin
      If (ItemPtr <> Nil) and (vp <> Nil) then
        System.Move(ItemPtr^, vp^, ItemSize);
      FreeMem(ItemPtr, ItemSize);
      Free;
      end;
    Delete(Pred(Count));
    end;
  end;

procedure TDataStack.push(vp: Pointer; vSize: Integer);
  var NewEntry : TDataStackItem;
  begin
  NewEntry := TDataStackItem.Create;
  With NewEntry do begin
    ItemSize := vSize;
    GetMem(ItemPtr, ItemSize);
    System.Move(vp^, ItemPtr^, ItemSize);
    end;
  Add(NewEntry);
  end;

procedure TDataStack.popStr(var s: String);
  var n : Integer;
  begin
  pop(@n);
  SetLength(s, n);
  If n > 0 then
    pop(@s[1]);
  end;

procedure TDataStack.pushStr(s: String);
  var n : Integer;
  begin
  n := Length(s);
  If n > 0 then
    push(@s[1], n);
  push(@n, SizeOf(Integer));
  end;

procedure TDataStack.Clear;
  begin
  While Count > 0 do
    pop(Nil);
  end;

{===================== TLRUList ================================}

constructor TLRUList.Create(iTargetMenu: TMenuItem;
                            iMenuStartIndex,
                            iLRUCount  : Integer;
                            iClickProc : TNotifyEvent);
  begin
  Inherited Create;
  TargetMenu := iTargetMenu;
  FStartIndex := iMenuStartIndex;
  FLRUCount := iLRUCount;
  ClickProc := iClickProc;
  end;

destructor TLRUList.Destroy;
  begin
  while Count > 0 do
    DeleteItem(get(Count - 1));
  Inherited Destroy;
  end;

procedure TLRUList.SetLRUCount(newLRUCount: Integer);
  begin
  If (LRUCount <> newLRUCount) and
     (newLRUCount >= 0) then begin
    If LRUCount = 0 then   { alter Wert 0, also bisher keine LRU-Liste }
      TargetMenu.Insert(StartIndex,
                        NewItem('-', 0, False, True, Nil, 0, ''));
    FLRUCount := newLRUCount;
    While Count > LRUCount do
      DeleteItem(Strings[Pred(Count)]);
    If LRUCount = 0 then   { neuer Wert 0, also nun keine LRU-Liste mehr }
      TargetMenu.Delete(StartIndex);
    end;
  end;

procedure TLRUList.AddItem(new_str: String);
  var n   : Integer;
      NMI : TMenuItem;
  begin
  if LRUCount > 0 then begin
    n := IndexOf(new_str);
    If n > 0 then           { Eintrag vorhanden, aber nicht an 1. Stelle:        }
      DeleteItem(new_str);        { löschen !                                    }
    If n <> 0 then begin    { Eintrag noch nicht (n < 0) oder nicht mehr (n > 0) vorhanden: }
      While (Count > 0) and (Count >= LRUCount) do         { neu/wieder erzeugen + einfügen }
        DeleteItem(Strings[Pred(Count)]);
      Insert(0, new_str);
      NMI := NewItem(new_str, 0, False, True, ClickProc, 0, '');
      TargetMenu.Insert(StartIndex, NMI);
      end;
    end;
  end;

procedure TLRUList.DeleteItem(old_str: String);
  var n   : Integer;
      OMI : TMenuItem;
  begin
  n := IndexOf(old_str);
  If n >= 0 then begin
    Put(n, '');
    Delete(n);  // Eintrag in der LRUListe löschen
    OMI := TargetMenu.Items[StartIndex + n]; // Zugehöriges MenuItem merken...
    TargetMenu.Delete(StartIndex + n);       // ..., aus dem Menü löschen...
    OMI.Free;                                // ... und schließlich freigeben !
    end;
  end;

{============= Konvertierung ===================================}

function Float2Str(value       : Extended;
                   decimals    : Integer): String;
  var buf   : String;
      dspos : Integer;
  begin
  buf := FloatToStrF(value, ffFixed, 15, decimals);
  While buf[1] = ' ' do
    Delete(buf, 1, 1);
  dspos := Pos(FormatSettings.DecimalSeparator, buf);
  If dspos > 0 then begin        { Wenn DeziTrenner im String, dann   }
    While buf[Length(buf)] = '0' do  { End-Nullen entfernen           }
      Delete(buf, Length(buf), 1);
    If dspos = Length(buf) then      { Wenn Dezitrenner am Ende, dann }
      Delete(buf, dspos, 1);            { DeziTrenner weg !           }
    end;
  Result := buf;
  end;

function AdjustDeciSeparator(s: String): String;
  { Es wird angenommen, dass FormatSettings.DecimalSeparator entweder ',' oder '.' ist. }
  begin
  If FormatSettings.DecimalSeparator = '.' then
    Replace(',', FormatSettings.DecimalSeparator, s)
  else
    Replace('.', FormatSettings.DecimalSeparator, s);
  Result := s;
  end;

function Bool2Str(value: Boolean): String;
  begin
  If value then
    Result := 'true'
  else
    Result := 'false';
  end;

function Str2Bool(value: String): Boolean;
  begin
  value := UpperCase(value);
  DeleteChars(' ', value);
  Result := POS('TRUE', Value) > 0
  end;


procedure DeleteChars(delchars : string; var s : String);
  var i, n : Integer;
  begin
  For i := 1 to Length(delchars) do begin
    n := POS(delchars[i], s);
    While n > 0 do begin
      Delete(s, n, 1);
      n := POS(delchars[i], s);
      end;
    end;
  end;

procedure DeleteChars(delchars : WideString; var s : WideString);
  var i, n : Integer;
  begin
  For i := 1 to Length(delchars) do begin
    n := POS(delchars[i], s);
    While n > 0 do begin
      Delete(s, n, 1);
      n := POS(delchars[i], s);
      end;
    end;
  end;


procedure replace(so, sc : String; var ws : String; suffix: String = '');
  var n, i : Integer;
  begin
  If Pos(so, sc) > 0 then
    MessageDlg('"' + so + '" kann nicht durch "' + sc +
               '" ersetzt werden,'#13#10 +
               'da dies zu einer Endlosschleife führen würde.',
               mtError, [mbOk], 0)
  else begin
    n := Pos(UpperCase(so), UpperCase(ws));  { Achtung ! POS ist wohl *doch* case-sensitiv !!! }
    While n > 0 do begin
      Delete(ws, n, Length(so));
      If Length(suffix) > 0 then begin
        i := n;
        While (i <= Length(ws)) and (ws[i] <> ')') do Inc(i);
        If i <= Length(ws) then
          Insert(suffix, ws, i);
        end;
      Insert(sc, ws, n);
      n := Pos(UpperCase(so), UpperCase(ws));
      end;
    end;
  end;

procedure replace(so, sc : WideString; var ws : WideString; suffix: WideString = '');
  var n, i : Integer;
  begin
  If Pos(so, sc) > 0 then
    MessageDlg('"' + so + '" kann nicht durch "' + sc +
               '" ersetzt werden,'#13#10 +
               'da dies zu einer Endlosschleife führen würde.',
               mtError, [mbOk], 0)
  else begin
    n := Pos(UpperCase(so), UpperCase(ws));  { Achtung ! POS ist wohl *doch* case-sensitiv !!! }
    While n > 0 do begin
      Delete(ws, n, Length(so));
      If Length(suffix) > 0 then begin
        i := n;
        While (i <= Length(ws)) and (ws[i] <> ')') do Inc(i);
        If i <= Length(ws) then
          Insert(suffix, ws, i);
        end;
      Insert(sc, ws, n);
      n := Pos(UpperCase(so), UpperCase(ws));
      end;
    end;
  end;


function ReplaceVarsIn(s: String; ReplTab: TStringList): String;
  var vs : String;
      i  : Integer;
  begin
  For i := 0 to Pred(ReplTab.Count) do begin
    vs := Copy(ReplTab[i], Pos('@', ReplTab[i]), 2);
    replace(vs, ReplTab.Values[vs], s);
    end;
  Result := s;
  end;


function SearchForw(s2f: String; SL: TStrings; start: Integer;
                   var found: Integer): Boolean;
  var i : Integer;
  begin
  i      := start;
  Result := False;
  While (Not Result) and (i < SL.Count) do
    If Pos(UpperCase(s2f), UpperCase(SL[i])) > 0 then begin
      Result := True;
      found  := i;
      end
    else
      Inc(i);
  end;


function ExtractData(key: String; SL: TStrings; start: Integer): String;
  var s    : String;
      n, p : Integer;
  begin
  Result := '';
  key    := key + '="';
  n      := start;
  While (Length(Result) = 0) and (n < SL.Count) do begin
    p := Pos(UpperCase(key), UpperCase(SL[n]));
    If p > 0 then begin
      p := p + Length(key);
      s := Copy(SL[n], p, Length(SL[n]));
      p := Pos('"', s);
      If p > 0 then
        Result := Copy(s, 1, p-1)
      else
        Result := s;
      end
    else
      n := n + 1;
    end;
  end;

function maskDelimiters(s: WideString): WideString;
  begin
  replace('>', '&gt;', s);
  replace('<', '&lt;', s);
  replace('''', '&apos;', s);
  replace('"', '&quot;', s);
  Result := s;
  end;

function rebuildDelimiters(s: WideString): WideString;
  begin
  replace('&amp;', '&', s);
  replace('&gt;', '>', s);
  replace('&lt;', '<', s);
  replace('&apos;', '''', s);
  replace('&quot;', '"', s);
  Result := s;
  end;

function literalLine(s: WideString): WideString;
  begin
  Result := killAllBreaks(rebuildDelimiters(s));
  end;

function CDATACompatible(s: WideString): WideString;
  begin
  if Length(s) > 0 then
    replace(']]>', ']]&gt;', s);
  Result := s;
  end;

function CDATATagRestored(s: WideString): WideString;
  begin
  if Length(s) > 0 then
    replace(']]&gt;', ']]>', s);
  Result := s;
  end;

function HTMLKillEmptyTags(source: String): String;
  var s, e   : Integer;
      htm_Id : String;
  begin
  s := 1;
  While (s < Length(source)) and (source[s] <> '<') do
    Inc(s);
  While (s < Length(source)) and
        (source[s] = '<') do begin  // Anfangstag gefunden
    e := s + 1;
    While (e < Length(source)) and Not CharInSet(source[e], [' ', '>']) do
      Inc(e);
    If CharInSet(source[e], [' ', '>']) then begin
      htm_Id := Copy(source, s, e - s);
      If htm_Id[Length(htm_Id)] <> '>' then
        htm_Id := htm_Id + '>';
      Insert('/', htm_Id, 2);    // htm_Id enthält nun das Ende-Tag!
      While (e < Length(source)) and Not (source[e] = '>') do
        Inc(e);
      If Copy(source, e+1, Length(htm_Id)) = htm_Id then begin  // Gefunden
        Delete(source, s, e - s + 1 + Length(htm_Id));         // => löschen!
        s := 1;
        end
      else
        s := e + 1;
      While (s < Length(source)) and (source[s] <> '<') do
        Inc(s);                // Neuen Tag-Anfang suchen
      end;
    end;
  Result := source;
  end;

function HTMLExtractAttrValue( attName, orgStr: String) : String;
  { von Tom Schaller aus TFormatFont übernommen !  30.06.06 }
  var valStr : String;
      n      : Integer;
  begin
  n := Pos(UpperCase(attName), UpperCase(orgStr));
  If n > 0 then begin
    n := n + Length(attName);
    While CharInSet(orgStr[n], [' ', '=']) do Inc(n);
    valStr := '';
    If orgStr[n] = '"' then begin
      Inc(n);
      Repeat
        valStr := valStr + orgStr[n];
        Inc(n);
      until (n > Length(orgStr)) or (orgStr[n] = '"');
      end
    else
      Repeat
        valStr := valStr + orgStr[n];
        Inc(n);
      until (n > Length(orgStr)) or CharInSet(orgStr[n], [' ', '>']);
    Result := valStr;
    end
  else
    Result := '';
  end;

function HTMLKillNonsenseTags(source: String): String;
  const tn  : Array [0..1] of String = ('sup>', 'sub>');
  var ato,               // "a"ctual "t"ag "o"pens
      nto   : Boolean;   // "n"ext   "t"ag "o"pens
      t1, t2,
      i     : Integer;
  begin
  While (Length(source) > 0) and (source[1] = ' ') do
    Delete(source, 1, 1);
  For i := 0 to 1 do begin
    ato := False;
    Repeat
      t1 := Pos(tn[i], source);
      If t1 > 1 then begin
        ato := source[t1 - 1] = '<';
        If Not ato then
          Delete(source, t1 - 2, Length(tn[i]) + 2);
        end;
    until (t1 <= 1) or ato;
    If t1 > 1 then begin   // Es gibt ein öffnendes Tag.
      Repeat
        t2 := PosEx(tn[i], source, t1 + 1);
        If t2 > 0 then begin  // Zweites Tag gefunden.
          nto := source[t2 - 1] = '<';
          If nto = ato then     // Gleichartige Tags direkt hintereinander
            If nto then
              Delete(source, t2 - 1, Length(tn[i]) + 1)
            else
              Delete(source, t2 - 2, Length(tn[i]) + 2)
          else begin
            t1  := t2;
            ato := nto;
            end;
          end;
      until t2 = 0;
      end;
    end;
  Result := source;
  end;

function HTMLKillAllTags(s: WideString): WideString;
  var na, ne, cc : Integer;
  begin
  na := POS('<', s);
  While na > 0 do begin
    ne := POS('>', s);
    While (ne > 0) and (ne < na) do begin  // Schließendes Tag *vor*
      Delete(s, ne, 1);                    //    öffnendem Tag
      na := na - 1;                        // ==> Zeichen löschen !
      ne := POS('>', s);
      end;
    If ne > 0 then begin                   // dann ist auch  ne > na !!!
      cc := ne - na + 1;                   // ==> Tag komplett löschen !
      Delete(s, na, cc);
      end;
    na := POS('<', s);
    end;
  Result := s;
  end;

function BuildPosFlag(b1, b2: Boolean): Integer;
  var res : Integer;
  begin
  if b1 then
    res := 1
  else
    res := 0;
  if b2 then
    res := res + 2;
  Result := res;
  end;

{============= Routinen für die Verwaltung der "Griechen" ================}

function GetWideCharFromSymbolChar(c : Char): WideChar;
  { versucht, das übergebene Zeichen aus dem Windows-"Symbol"-Zeichensatz in
    ein UCS-2-Zeichen ("Arial"-WideChar) zu konvertieren. Gelingt dies, dann
    wird das entsprechende WideChar-Zeichen zurückgegeben; andernfalls wird
    das Zeichen wccError ( = #$0015, ASCII-Nr. 21, "Negative Acknowledge")
    zurückgegeben. }
  var n : Integer;
  begin
  n := Pos(c, symList);
  If (n > 0) and (n <= Length(WSymNumList)) then
    Result := WideChar(WSymNumList[n])
  else
    if CharInSet(c, NameChar) then
      Result := WideChar(c)
    else
      Result := wccError;  // Negative Acknowledge - Zeichen
  end;

function GetSymbolCharFromWideChar(wc: WideChar): Char;
  { versucht, das übergebene UCS-2-Zeichen in den Windows-"Symbol"-Zeichen-
    satz zu mappen. Falls das nicht unter Anwendung der obigen Konvertie-
    rungstabellen nicht gelingt, wird das Zeichen ccError ( = #$15, ASCII-
    Nr. 21, "Negative Acknowledge") zurückgegeben.    }
  var f, n, i : Integer;
  begin
  n := Ord(wc);
  If n < 256 then    // ASCII-kompatible Zeichen ungeändert zurücksenden
    Result := Char(n)
  else begin         // Zeichen aus dem erweiterten Bereich umsetzen
    f := 0;
    i := 1;
    While (f = 0) and (i < 65) do begin
      If n = WSymNumList[i] then
        f := i
      else
        i := i + 1;
      end;
    If f > 0 then
      Result := SymList[f]
    else
      Result := ccError;
    end;
  end;


function IsDigit(wc: WideChar): Boolean;
  begin
  Result := (wc >= '0') and (wc <= '9');
  end;


function IsDelimiter(wc: WideChar): Boolean;
  begin
  Result := Pos(wc, DelimiterWChar) > 0;
  end;


function IsNameChar (wc: WideChar): Boolean;
  begin
  Result := (Pos(wc, NameWChar) > 0) or   //  Is ASCII-NameChar or
            (Pos(wc, WSymList ) > 0);     //  Is GreekSymbol
  end;


function IsGreekNameSymbol(wc: WideChar): Boolean;
  begin
  Result := Pos(wc, WSymList) > 0;
  end;


function IsAngleTerm(iGOL: TObject; ws: WideString): Boolean;
  var tree: TTBaum;
  begin
  Result := False;
  tree := TTBaum.Create(TGeoObjListe(iGOL), Rad);
  try
    tree.BuildTree(ws);
    If tree.is_okay then
      Result := tree.is_angle;
  finally
    tree.Free;
  end;
  end;


function HTMLString2WideString(source: String): WideString;

  function HTML2Wide(s: String): WideString;
    var res   : WideString;
        wc    : WideChar;
        n,
        oft_S,           // Start-Position des öffnenden "font"-Tags
        oft_E,           // Ende-Position des öffnenden "font"-Tags
        cft_S,           // Start-Position des schließenden "font"-Tags
        cft_E : Integer; // Ende-Position des schließenden "font"-Tags
    begin
    res  := '';
    While Length(s) > 0 do begin
      oft_E := 0;
      cft_S := 0;
      cft_E := 0;
      oft_S := Pos('<font', s);
      If oft_S > 0 then begin
        oft_E := PosEx('>', s, oft_S);
        If oft_E > oft_S then begin
          cft_S := PosEx('</font', s, oft_E);
          If cft_S > oft_E then
            cft_E := PosEx('>', s, cft_S);
          end;
        end;
      If cft_E > oft_S then begin  // Komplettes "font"-Tag gefunden !!!
        // Alle Zeichen *vor* dem Font-Tag nach res schreiben
        res := res + Copy(s, 1, Pred(oft_S));
        If Pos('SYMBOL', UpperCase(Copy(s, oft_S, oft_E - oft_S + 1))) > 0 then begin
          // Alle Zeichen im Symbol-Font nach UCS-2 transferieren !
          For n := Succ(oft_E) to Pred(cft_S) do begin
            wc := GetWideCharFromSymbolChar(s[n]);
            If wc > wccError then
              res := res + wc
            else
              res := res + WideChar(s[n]);
            end;
          end
        else // Kein Symbol-Font ==> komplett konvertieren, FontTag übernehmen
          res := res + Copy(s, oft_S, Succ(oft_E - oft_S)) +
                 HTML2Wide(Copy(s, Succ(oft_E), Pred(cft_S - oft_E))) +
                 Copy(s, cft_S, cft_E - cft_S + 1);
        Delete(s, 1, cft_E);
        end
      else begin // Kein "font"-Tag ==> kompletten String konvertieren
        res := res + s;
        s := '';
        end;
      end;
    Result := res;
    end;

  var res : WideString;
  begin
  If Length(source) > 0 then begin
    res := HTML2Wide(source);       // übersetzt alle Griechen in UCS-2
    res := HTMLKillAllTags(res);    // entfernt alle HTML-Tags
    DeleteChars(' ', res);
    res := RebuildDelimiters(res);  // restauriert "<"- und ">"-Zeichen
    end
  else
    res := '';
  Result := res;
  end;

function WideString2HTMLString(source: WideString): String;
  var res : String;
      i   : Integer;
      cc  : Char;
  begin
  res := '';
  For i := 1 to Length(source) do
    If Ord(source[i]) < 256 then
      res := res + Char(source[i])
    else begin
      cc := GetSymbolCharFromWideChar(source[i]);
      If cc <> ccError then
        res := res + '<font face="Symbol">' + cc + '</font>'
      else
        res := res + Char(source[i]);   // Notlösung!
      end;
  Result := res;
  end;

function KillAllBreaks(source: String): String;
  begin
  replace('<br>', ' ', source);
  replace('<BR>', ' ', source);
  replace(#$000D, ' ', source);
  replace(#$000A, ' ', source);
  replace('  ', ' ', source);     // Danach gibt's nur noch einzelne Blanks!
  Result := trim(source);
  end;

function FormatAllBreaks(source: String): String;
  { Formatierungskorrektur für harte Zeilenumbrüche:
    Jeder Steuerstring, der mit einem #$D beginnt, wird in ein #$D#$A
    umgesetzt. Mehrfache Zeilenumbrüche (also: Leerzeilen!) werden dabei
    gekillt. Wird beim Abspeichern und Wiederladen von Makro-Hilfetexten
    verwendet.                                                           }
  var i : Integer;
  begin
  replace(#$D#$D, #$D, source);   // Killt doppelte #13
  For i := Length(source) downto 1 do
    if source[i] = #$D then
      insert(#$A, source, i+1);   // Ergänzt alle #13 zu #13#10
  replace(#$A#$A, #$A, source);   // Killt doppelte #10;
  replace('  ', ' ', source);     // Danach gibt's nur noch einfache Blanks!
  Result := source;
  end;

function GetNextPlainCharIndex(s: String; start: Integer = 1): Integer;
  var pc: Boolean;  // "p"lain "c"har
      i : Integer;
  begin
  Result := 0;
  pc := True;
  i  := start;
  While (i <= Length(s)) and (Result = 0) do begin
    Case s[i] of
      '<' : pc := False;
      '>' : pc := True;
    else
      If pc and (Ord(s[i]) > 32) then
        Result := i;
    end; { of case }
    i := i + 1;
    end;
  end;

function CountHRDelimitedParas (var src: String): Integer;
  { Zählt die durch <hr>-Tags getrennten Abschnitte; fügt gegebenenfalls
    einen abschließenden Strich am Ende des letzten Abschnitts hinzu. Ist
    nur 1 Strich vorhanden, der ganz am Ende des Textes steht, dann wird
    dieser entfernt und Result = 0 zurückgeliefert.  }
  var n, i, oi : Integer;
  begin
  n  := 0;
  oi := 0;
  i := Pos('<hr>', src);
  While i > 0 do begin
    n  := n + 1;
    oi := i;
    i  := PosEx('<hr>', src, oi + 4);
    end;
  If (n > 0) and
     (GetNextPlainCharIndex(src, oi + 4) > 0) then begin
    Result := n + 1;             // Nach einem Strich kommt noch echter Text,
    src := src + '<br><hr><br>'; // also: abschließenden Strich hinzufügen !
    end
  else begin
    If n = 1 then begin          // Einzelnen Strich am Textende löschen !
      Delete(src, Pos('<hr>', src), 4);
      n := 0;
      end;
    Result := n;
    end;
  end;

function FilePathAsURL(s: String): String;
  var ls : String;
      n  : Integer;
  begin
  ls := AnsiLowercase(s);   // nur zum sicheren Finden eines 
  n := Pos('file:', ls);    //   "file:"-Protokolls
  If n > 0 then begin
    Delete(s, n, 5);
    While CharInSet(s[n], ['/', '\']) do
      Delete(s, n, 1);
    end;
//  Replace(':', '|', s);   // deaktiviert (23.07.09)
  Replace('\', '/', s);
  Result := 'file:///' + s;
  end;

function ExtractURLPathFrom(fname: String): String;
  var i: Integer;
  begin
  i := Length(fname);
  While (i > 0) and Not CharInSet(fname[i], ['/', '\', ':']) do Dec(i);
  If i > 0 then
    Result := Copy(fname, 1, i)
  else
    Result := '';
  end;

function ExtractURLNameFrom(fname: String): String;
  var i: Integer;
  begin
  i := Length(fname);
  While (i > 0) and Not CharInSet(fname[i], ['/', '\', ':']) do Dec(i);
  If i > 0 then
    Result := Copy(fname, Succ(i), Length(fname))
  else
    Result := fname;
  end;

function ExtractURLExtFrom(fname: String): String;
  var i: Integer;
  begin
  i := Length(fname);
  While (i > 0) and Not (fname[i] = '.') do Dec(i);
  If i > 0 then
    Result := Copy(fname, i, Length(fname))
  else
    Result := '';
  end;

function MergeFilePathAndRelFileName(path, relfn: String): String;
  { Erwartet in path einen Datei-Pfad, der mit einem Laufwerk beginnt und
    '\' als Trennzeichen benutzt; in relfn wird ein relativer Pfad erwartet,
    der ebenfalls '\' als Trennzeichen benutzt.
    Verarbeitet alle '.\'- und '..\'-Konstrukte in relfn und gibt den
    resultierenden Gesamt-Pfad zurück. }
  var n : Integer;
  begin
  Result := '';
  While relfn[1] = '.' do begin
    If Pos('..\', relfn) = 1 then begin
      Delete(relfn, 1, 3);
      n := Length(path) - 1;
      While (n > 0) and (path[n] <> '\') do  n := n - 1;
      If n > 0 then
        Delete(path, n + 1, Length(path))
      else
        Exit;
      end
    else if Pos('.\', relfn) = 1 then
      Delete(relfn, 1, 2);
    end;
  While relfn[1] = '\' do Delete(relfn, 1, 1);
  If (Length(path) > 0) and (path[Length(path)] <> '\') then
    path := path + '\';
  Result := path + relfn;
  end;

function MergeURLPathAndRelFileName(path, relfn: String): String;
  { Erwartet in path einen URL-Pfad, der mit einem Servernamen beginnt und
    '/' als Trennzeichen benutzt; in relfn wird ein relativer Pfad erwartet,
    der ebenfalls '/' (statt '\') als Trennzeichen benutzt.
    Verarbeitet alle './'- und '../'-Konstrukte in relfn und gibt die
    resultierende Gesamt-URL zurück. }
  var n : Integer;
  begin
  Result := '';
  While relfn[1] = '.' do begin
    If Pos('../', relfn) = 1 then begin
      Delete(relfn, 1, 3);
      n := Length(path) - 1;
      While (n > 0) and (path[n] <> '/') do  n := n - 1;
      If n > 0 then
        Delete(path, n + 1, Length(path))
      else
        Exit;
      end
    else if Pos('./', relfn) = 1 then
      Delete(relfn, 1, 2);
    end;
  While relfn[1] = '/' do Delete(relfn, 1, 1);
  If path[Length(path)] <> '/' then path := path + '/';
  Result := path + relfn;
  end;

function GetSelectedFilterExt(s: String; n: Integer; defExt: String): String;
  var i, k : Integer;
  begin
  i := 0;
  While (Length(s) > 0) and (i < n) do begin
    k := POS('|*', s);
    If k > 0 then begin
      Delete(s, 1, k + 1);
      Inc(i);
      end
    else
      s := '';
    end;
  If Length(s) > 0 then begin
    k := POS('|', s);
    If k = 0 then k := POS(';', s);
    If k > 0 then
      Result := Copy(s, 1, Pred(k))
    else
      Result := s;
    end
  else
    Result := defExt;
  end;

function GetValidationVarType(s: String): Integer;
  var i : Integer;
  begin
  Result := 0;
  For i := 0 to High(varTypeStrs) do
    if s = varTypeStrs[i] then
      Result := varTypeIds[i];
  end;

function CutByteFromHexStr(var s: String): Integer;
  const AllowedChars = ['0'..'9', 'A'..'F', 'a'..'f'];
  var pu : String;
  begin
  While (Length(s) > 0) and
        (Not CharInSet(s[1], AllowedChars)) do
    Delete(s, 1, 1);
  pu := '';
  While (Length(s) > 0) and
        (Length(pu) < 2) and
        CharInSet(s[1], AllowedChars) do begin
    pu := pu + Upcase(s[1]);
    Delete(s, 1, 1);
    end;
  If Length(pu) > 0 then
    Result := StrToInt('$' + pu)
  else
    Result := -1;
  end;


{============= Projekt-Name ====================================}

function ProjectName : String;
  begin
  Result := MyStartMsg[8];
  While CharInSet(Result[Length(Result)], [' ', '-', '[']) do
    Delete(Result, Length(Result), 1);
  end;

{============= Temp-Pfad in den "Dokumenten" des aktuellen Benutzers ========}

function GetActUsersTempFolder : String;
  { Ermittelt das "Temp"-Verzeichnis im Ordner "Dokumente" des aktuellen
    Benutzers, und erzeugt gegebenenfalls das Unterverzeichnis "temp".
    Der zurückgegebene Pfad enthält keinen abschließenden "\".
    Im Fehlerfall wird ein leerer String zurückgegeben.                  }
  var dir, pu : String;
  begin
  Result := '';
  SetLength(pu, MAX_PATH);
  dir := 'temp' + #0;
  if Succeeded( SHGetFolderPathAndSubDirW(0,
                CSIDL_PERSONAL or CSIDL_FLAG_CREATE,
                0, SHGFP_TYPE_CURRENT, PWideChar(dir), PWideChar(pu)) ) then begin
    SetLength(pu, Pos(#0, pu) - 1);
    While (Length(pu) > 0) and CharInSet(pu[Length(pu)], ['/', '\']) do
      Delete(pu, Length(pu), 1);
    Result := pu;
    end;
  end;

{============= AppData-Pfad des aktuellen Benutzers ==============}

function GetActUsersAppDataFolder(dir: String): String;
  { Ermittelt das "Application Data"-Verzeichnis aus dem Profil des aktuellen
    Benutzers, und erzeugt gegebenenfalls das Unterverzeichnis "dir". Der
    zurückgegebene Pfad enthält keinen abschließenden "\".
    Im Fehlerfall wird ein leerer String zurückgegeben.                     }
  var pu : String;
  begin
  Result := '';
  SetLength(pu, MAX_PATH);
  dir := dir + #0;
  if Succeeded( SHGetFolderPathAndSubDirW(0,
                CSIDL_APPDATA or CSIDL_FLAG_CREATE,
                0, SHGFP_TYPE_CURRENT, PWideChar(dir), PWideChar(pu)) ) then begin
    SetLength(pu, Pos(#0, pu) - 1);
    While (Length(pu) > 0) and CharInSet(pu[Length(pu)], ['/', '\']) do
      Delete(pu, Length(pu), 1);
    Result := pu;
    end;
  end;

{============= Globaler AppData-Pfad (für *alle* Benutzer) =======}

  // Die folgende Funktion wird derzeit (Mai 2011) noch nicht benutzt.
  // Sie wird für zukünftige Überarbeitungen des Konfigurations-Systems
  // bereitgestellt.
function GetAllUsersAppDataFolder(dir: String): String;
  { Ermittelt das "Application Data"-Verzeichnis aus dem Profil "All Users",
    und erzeugt gegebenenfalls das Unterverzeichnis "dir". Der zurückgegebene
    Pfad enthält keinen abschließenden "\".
    Im Fehlerfall wird ein leerer String zurückgegeben. }

  var pu : String;
  begin
  Result := '';
  SetLength(pu, MAX_PATH);
  dir := dir + #0;
  if Succeeded( SHGetFolderPathAndSubDirW(0,
                CSIDL_COMMON_APPDATA or CSIDL_FLAG_CREATE,
                0, SHGFP_TYPE_CURRENT, PWideChar(dir), PWideChar(pu)) ) then begin
    SetLength(pu, Pos(#0, pu) - 1);
    While (Length(pu) > 0) and CharInSet(pu[Length(pu)], ['/', '\']) do
      Delete(pu, Length(pu), 1);
    Result := pu;
    end;
  end;


{============= Gültiger Pfad zu einer temporären Datei =========}

function TempFileName (ext: String) : String;
  var dir, path : String[255];
      n         : Integer;
  begin
  Result := '';
  FillChar(dir[0], 255, #0);
  n := GetTempPath(254, @dir[1]);
  If (n > 0) and (n < 255) then begin
    SetLength(dir, n);
    FillChar(path, 255, #0);
    GetTempFileName(@dir[1], 'edg'#0, 0, @path[1]);
    n := 0;
    While (n<255) and (path[1+n] <> #0) do n := n + 1;
    If (n > 0) and (n < 255) then begin
      SetLength(path, n);
      If Length(ext) > 0 then begin
        If ext[1] <> '.' then ext := '.' + ext;
        Result := ChangeFileExt(String(path), ext);
        end
      else
        Result := String(path);
      end;
    end;
  end;

{============= Bugfix für MS-CHM-Bug ===========================}

function GetValidCHMFile (src_fn : String) : String;

  function IsRemoteFile(fn: String): Boolean;
    var DrivePart: String;
    begin
    Result := False;
    DrivePart := ExtractFileDrive(fn);
    If Length(DrivePart) = 0 then begin  // Keine Pfad-Information?
      fn := ExpandUNCFileName(ExtractFileName(fn));
      DrivePart := ExtractFileDrive(fn);
      end;
    If Length(DrivePart) > 0 then
      If Pos('\\', DrivePart) > 0 then   // UNCPfad erkannt
        Result := True
      else begin                         // Kein UNCPfad !
        DrivePart := DrivePart[1] + ':/';
        Result := GetDriveType(PWideChar(DrivePart)) = DRIVE_REMOTE;
        end;
    end;

  var target_fn: String;
      TmpBuf : Array [0..255] of Char;
  begin
  Result := src_fn;
  If FileExists(src_fn) and
     IsRemoteFile(src_fn) and
     (GetTempPath(255, TmpBuf) > 0) then begin
    target_fn := IncludeTrailingPathDelimiter(TmpBuf) + ExtractFileName(src_fn);
    If CopyFile(PWideChar(src_fn), PWideChar(target_fn), False) then
      Result := target_fn;
    end;
  end;

function GetFullExistingFilePath (searchDir: TStrings; fname: String): String;
  { sucht in den in "searchDir" übergebenen Verzeichnissen nach der Datei
    mit dem Namen "fname". Dabei kann "fname" auch einen relativen Pfad
    enthalten. Wird unter diesen Suchpfaden keine Datei gefunden, wird noch
    im aktuellen Verzeichnis gesucht.
    Zurückgegeben wird der volle (UNC-)Pfad der gefundenen Datei bzw. ein
    leerer String, wenn keine existierende Datei des angegebenen Namens
    gefunden werden konnte.                                                 }
  var testpath : String;
      found    : Boolean;
      i        : Integer;
  begin
  Result := '';
  found  := False;
  If SearchDir <> Nil then begin
    i := 0;
    While (i < SearchDir.Count) and (Not found) do begin
      If Length(searchDir[i]) > 0 then begin
        If fname[1] = '\' then
          testpath := ExcludeTrailingPathDelimiter(searchDir[i]) + fname
        else
          testpath := IncludeTrailingPathDelimiter(searchDir[i]) + fname;
        If FileExists(testpath) then begin
          Result := testpath;
          found  := True;
          end;
        end;
      i := i + 1;
      end;
    end;
  If Not found then begin
    testpath := ExpandUNCFileName(fname);
    If FileExists(testpath) then
      Result := testpath;
    end;
  end;

{============= Datei beschreibbar? =============================}

function FileAllowsWriting(fname: String): Boolean;
  var attrs,
      f_hnd : Integer;
  begin
  If FileExists(fname) then begin   // Bei existierenden Dateien werden nur
    attrs  := FileGetAttr(fname);   //   die Attribute überprüft.
    Result := (attrs and faReadOnly) = 0;
    end
  else begin                        // Falls die Datei noch nicht existiert,
    f_hnd := FileCreate(fname);     //   wird sie probeweise erzeugt...
    If f_hnd > 0 then begin
      Result := True;
      FileClose(f_hnd);
      DeleteFile(fname);            //   und wieder gelöscht !
      end
    else
      Result := False;
    end;
  end;

{============= EXE-Laufwerk ist CD? ============================}

function StartingFromCD(var root: String): Boolean;
  { In "root" wird stets der Name des Wurzelverzeichnisses des Laufwerks
    zurückgegeben, von dem das aktuelle Programm gestartet wurde, aber
    *ohne* abschließenden "\", also z.B. "C:" oder "D:".  }
  var dt : Byte;
  begin
  root   := ExtractFileDrive(Application.ExeName);
  If root[Length(root)] <> '\' then
    root := root + '\';
  dt     := GetDriveType(PWideChar(root));
  Delete(root, Length(root), 1);
  SpyOut('Drive %s has type %d', [root, dt]);
  Result := dt = DRIVE_CDROM;
  end;

{============= Diskette im Laufwerk? ===========================}

function DriveHoldsReadableData(d: Char): Boolean;
  var sr : TSearchRec;
      i  : Integer;
  begin
  {$I-}
  i := FindFirst(d + ':\*.*', faAnyFile, sr);
  FindClose(sr);
  {$I+}
  Result := i = 0;
  end;

{============= Warten ==========================================}

procedure wait(delay : Integer);
  var start: Integer;
  begin
  start := GetTickCount;
  While Integer(GetTickCount) - start < delay do
    Application.ProcessMessages;
  end;



{============= System-Fehler-Meldung ===========================}

procedure ShowLastErrorMsg;
  var buf : String;
      n   : Integer;
  begin
  SetLength(buf, 100);
  n := GetLastError;
  FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, Nil, n, 0, PChar(buf), 80, Nil);
  ShowMessage('Windows-Fehler :'#10#13#13 + buf);
  end;


{============= Sprachanpassung =================================}

procedure InitShortCuts(Lang_Id : String);
  { Die deutschen ShortCuts sind voreingestellt. Hier sind trotzdem auch
    deutsche Daten aufgeführt, damit die Prozedur auch zum Zurückschalten
    von der englischen auf die deutsche Oberfläche verwendet werden kann.
    In jedem Fall kann man sich aber auf die tatsächlichen Änderungen
    beschränken!                                                            }
  begin
  DeleteChars(' .', Lang_Id);
  Lang_Id := UpperCase(Lang_Id);
  If Lang_Id = 'DEU' then begin
    key_Bold        :=  6; { Ctrl F für "F_ett"           }
    key_Italic      := 11; { Ctrl K für "K_ursiv"         }
    key_UnderLine   := 21; { Ctrl U für "U_nterstrichen"  }
    key_Subscript   :=  9; { Ctrl I für "I_ndex"          }
    key_Superscript :=  5; { Ctrl E für "E_xponent"       }
    With HauptFenster do begin
      Zeichnungvergroessern1.ShortCut  := ShortCut(Word('G'), [ssCtrl]);
      Zeichnungverkleinern1.ShortCut   := ShortCut(Word('K'), [ssCtrl]);
      end;
    SC_Repeat  := Word('W');  { Ctrl W für "W_iederholen" }
    end
  else If Lang_Id = 'ENG' then begin
    key_Bold        :=  2; { Ctrl B für "B_old"           }
    key_Italic      :=  9; { Ctrl I für "I_talic"         }
    key_UnderLine   := 21; { Ctrl U für "U_nderline"      }
    key_Subscript   := 19; { Ctrl S für "S_ubscript"      }
    key_Superscript := 20; { Ctrl T für "T_opscript"      }
    With HauptFenster do begin
      Zeichnungvergroessern1.ShortCut  := ShortCut(Word('E'), [ssCtrl]);
      Zeichnungverkleinern1.ShortCut   := ShortCut(Word('D'), [ssCtrl]);
      end;
    SC_Repeat  := Word('R');  { Ctrl R für "R_epeat"      }
    end;
  end;

procedure InitializeLanguage(Lang_Id: String);
  var buf     : String;
      p       : PChar;
      NewInst : THandle;

  function SetResHInstance(NewInstance: THandle): Boolean;
    var CurModule: PLibModule;
    begin
    Result := False;
    If NewInstance <> 0 then begin
      CurModule := LibModuleList;
      while CurModule <> nil do begin
        if CurModule.Instance = HInstance then begin
          if CurModule.ResInstance <> CurModule.Instance then
            FreeLibrary(CurModule.ResInstance);
          CurModule.ResInstance := NewInstance;
          Result := True;
          Exit;
          end;
        CurModule := CurModule.Next;
        end;
      end;
    end;

  begin
  buf := ChangeFileExt(Application.ExeName, '.' + Lang_id);
  If (Length(buf) > 0) and (FileExists(buf)) then begin
    p := StrAlloc(Length(buf) + 1);  // altertümlich, aber sicher!
    StrPCopy(p, buf);
    NewInst := LoadLibraryEx(p, 0, LOAD_LIBRARY_AS_DATAFILE);
    StrDispose(p);
    If SetResHInstance(NewInst) then
      EuklidLanguage := UpperCase(Copy(buf, Length(buf)-2, 3));
    end;
  end;

{============= Farbaustausch in Bitmaps ========================}

procedure ReplaceColor (BMP      : TBitMap;
                        OldColor,
                        NewColor : TColor);
  var i, j  : Integer;
  begin
  With BMP do
    For i := 0 to Pred(Width) do
      For j := 0 to Pred(Height) do
        If Canvas.Pixels[i, j] = OldColor then
          Canvas.Pixels[i, j] := NewColor;
  end;

procedure ReplaceColorShades (BMP      : TBitMap;
                              BackColor,
                              OldColor,
                              NewColor : TColor);
  { Färbt eine logisch monochrome Halbton-Bitmap um.
    Da die aktuelle Farbe eines jeden Pixels stets heller als
    OldColor ist, ist der Quotient
       (255 - [ActColour]) / (255 - [OldColor])
    nie größer als 1. Dabei steht [ ] für ein beliebiges Farb-Byte. }

  var actColor      : TColor;
      acr, acg, acb,
      ocr, ocg, ocb,
      ncr, ncg, ncb,
      i, j          : Integer;
  begin
  ocr := 255 - GetRValue(OldColor);
  ocg := 255 - GetGValue(OldColor);
  ocb := 255 - GetBValue(OldColor);
  ncr := 255 - GetRValue(NewColor);
  ncg := 255 - GetGValue(NewColor);
  ncb := 255 - GetBValue(NewColor);
  With BMP do
    For i := 0 to Pred(Width) do
      For j := 0 to Pred(Height) do
        If Canvas.Pixels[i, j] <> BackColor then begin
          actColor := Canvas.Pixels[i, j];
          If actColor = OldColor then
            Canvas.Pixels[i, j] := NewColor
          else begin
            If ocr > 0 then
              acr := MulDiv(ncr, 255 - GetRValue(actColor), ocr)
            else
              acr := ncr;
            If ocg > 0 then
              acg := MulDiv(ncg, 255 - GetGValue(actColor), ocg)
            else
              acg := ncg;
            If ocb > 0 then
              acb := MulDiv(ncb, 255 - GetBValue(actColor), ocb)
            else
              acb := ncb;
            Canvas.Pixels[i, j] := RGB(255 - acr, 255 - acg, 255 - acb);
            end;
          end;
  end;

{============= Bitmap löschen ==================================}

procedure ClearBitmap(BMP: TBitmap; bkCol : TColor);
  begin
  If BMP <> Nil then
    With BMP.Canvas do begin
      Brush.Style := bsSolid;
      Brush.Color := bkCol;
      Pen.Color   := bkCol;
      BMP.Canvas.FillRect(Rect(0, 0, BMP.Width, BMP.Height));
      end;
  end;

{============= Bitmap schrumpfen und kopieren ==================}

procedure CopyReducedBitmap(Source, Target: TBitmap);
  var xmax, ymax,
      x, y      : Integer;
      backcol   : TColor;
      found     : Boolean;
  begin
  If Not Assigned(Source) then Exit;

  xmax := Pred(Source.Width);    { Ungenutzten Hintergrund abschneiden }
  ymax := Pred(Source.Height);
  backcol := Source.TransparentColor and $FFFFFF;

  found := False;                { Rechte weiße Spalten abstreichen    }
  Repeat
    For y := 0 to ymax do
      If Source.Canvas.Pixels[xmax, y] <> backcol then
        found := True;
    If Not found then
      xmax := xmax - 1;
  until found or (xmax < 0);
  If xmax < Pred(Source.Width) then
    xmax := xmax + 1;

  found := False;                { Untere weiße Zeilen abstreichen     }
  Repeat
    For x := 0 to xmax do
      If Source.Canvas.Pixels[x, ymax] <> backcol then
        found := True;
    If Not found then
      ymax := ymax - 1;
  until found or (ymax < 0);
  If ymax < Pred(Source.Height) then
    ymax := ymax + 1;

  Target.Width  := Succ(xmax);   { Ziel dimensionieren }
  Target.Height := Succ(ymax);   { und Daten kopieren  }
  BitBlt(Target.Canvas.Handle, 0, 0, Succ(xmax), Succ(ymax),
         Source.Canvas.Handle, 0, 0, SRCCOPY);
  end;

{===============================================================}


initialization

  InitTimeZoneInfo;

finalization

end.
