UNIT MathLib;

INTERFACE

USES  Windows, Graphics, Classes; //, Unit_LGS;

TYPE  TPointArrays    = Array of Array of TPoint;

      TFloatPoint     = Record
                          x, y : Double;
                        end;
      TFloatPointList = Array of TFloatPoint;

      T2DimFloatArray = Array of Array of Double;

      TCoeff6         = Array [0..5] of Double;
      TMatrix32       = Array [0..2, 0..1] of Double;

      TCNumber = class(TObject)
        protected
          rp : Double;
          ip : Double;
        public
          constructor create(i_rp, i_ip: Double);
          function getRealPart: Double;
          function getImgPart: Double;
          function getAbsLength: Double;
          function isZero: Boolean;
          function isReal: Boolean;
          procedure plus(cn2: TCNumber);
          procedure minus(cn2: TCNumber);
          procedure times(cn2: TCNumber);
          procedure divideBy(cn2: TCNumber);
        end;

      TCNumberList = class(TList)
        protected
          function getItem(nr: Integer): TCNumber;
        public
          destructor Destroy; override;
          property item[nr: Integer]: TCNumber read getItem;
        end;

      TVector3     = class(TObject)
        protected
          procedure SetIsValid(newVal: Boolean);
          function  GetIsValid : Boolean;
        public
          X, Y, Z  : Double;
          tag      : Integer;
          constructor Create(ix, iy, iz: Double; itag: Integer = 0);
          constructor CreateCopyOf(iv: TVector3);
          constructor CreateFromString(s: String);
          constructor Load32(R : TReader);
          procedure Store32(W : TWriter);
          function  GetContentsString: String;
          procedure Assign(ix, iy, iz: Double; itag: Integer = 0); overload;
          procedure Assign(src: TVector3); overload;
          procedure CopyFrom(source: TVector3);
          procedure DivBy(d: Double);
          property  IsValid: Boolean read GetIsValid write SetIsValid;
        end;

      TVector3List = class(TList)
        private
          function GetRLV(n: Integer): TVector3;
          function GetItem(n: Integer): TVector3;
        public
          constructor CreateFromString(s: String);
          constructor Load32(R: TReader);
          destructor  Destroy; override;
          procedure Clear; override;
          procedure WipeOut;  // = Clear ohne "Items.Free"
          procedure DeleteItem(n : Integer);
          function  GetContentsString: String;
          function  InsertZSorted     (ix, iy, iz: Double;
                                       itag: Integer = 0  ): Integer; overload;
          function  InsertZSorted     (v   : TVector3     ): Integer; overload;
          function  InsertZSortedWithXYDist(minDist,
                                       ix, iy, iz: Double;
                                       itag: Integer = 0  ): Integer;
          function  GetPtIndexNextToXY   (xp, yp  : Double): Integer;
          function  GetPtIndexWithZequals(zp      : Double): Integer;
          function  ValidPointCount                        : Integer;
          procedure Reset2StandardList(startparam, endparam: Double;
                                       insCount  : Integer);
          procedure Add2StandardList(startparam, endparam: Double;
                                       insCount  : Integer);
          procedure AddExtraEndPoints;
          property RLV [n: Integer]: TVector3 read GetRLV;  // "R"ing "L"ist "V"ector
          property Item[n: Integer]: TVector3 read GetItem; default;
        end;

      TCoordSys2D = class(TObject)
        private
          px0, py0,             // Pixelkoordinaten des Nullpunktes
          pWidth,               // Breite des Ausgabefensters in Pixeln
          pHeight   : Integer;  // Höhe des Ausgabefensters in Pixeln
          fe1x, fe1y,           // Pixel-Koordinaten des 1. Einheitsvektors
          fe2x, fe2y: Double;   // Pixel-Koordinaten des 2. Einheitsvektors
          fIsOkay   : Boolean;  // Zustand des Objekts
          fXmin, fYmin,         // Logische Koordinaten der linken unteren Ecke
          fXmax, fYmax,         // Logische Koordinaten der rechten oberen Ecke
          fLWRad    : Double;   // Logischer Radius des kleinesten Kreises, der
                                //   das Ausgabefenster vollständig enthält
          function GetXcenter: Double;  // Zugriffsfunktionen für die logischen
          function GetYcenter: Double;  //     Koordinaten der Fenstermitte
        public
          constructor Create(ix0, iy0, ipW, ipH: Integer; iex, iey: Double);
          procedure ResetTo(ix0, iy0, ipW, ipH: Integer; iex, iey: Double);
          function GetLogCoords(px, py: Integer; var lx, ly: Double): Boolean;
          function GetWinCoords(lx, ly: Double; var px, py: Integer): Boolean;
          function LogWinContains(lx, ly: Double): Boolean;
          function LogWinKnows(lx, ly: Double): Integer;
          property e1x: Double read fe1x;
          property e2y: Double read fe2y;
          property Xcenter: Double read GetXcenter;
          property YCenter: Double read GetYcenter;
          property IsOkay: Boolean read fIsOkay;
          property LogWinRadius: Double read FLWrad;
        end;


CONST prim : ARRAY [1..50] OF Integer =       { Primzahlen < 230;         }
                 (  2,   3,   5,   7,  11,    { genügt für die Faktori-   }
                   13,  17,  19,  23,  29,    { sierung aller natürlicher }
                   31,  37,  41,  43,  47,    { 16(15)-Bit-Integer-Zahlen,}
                   53,  59,  61,  67,  71,    { denn 230 * 230 > 50000    }
                   73,  79,  83,  89,  97,
                  101, 103, 107, 109, 113,
                  127, 131, 137, 139, 149,
                  151, 157, 163, 167, 173,
                  179, 181, 191, 193, 197,
                  199, 211, 223, 227, 229);

      epsilon : Double = 1e-12; { Allgemeine Rechengenauigkeit }
      euler   : Double = 0;     { hier wird beim Start die Euler'sche
                                     Zahl e eingetragen }

{--- Mathematisch-geometrische Standardaufgaben ------}

function SafeRound       (    x       : Double        ) : Integer;
function SafeSub         (    x, y    : Double        ) : Double;
function IsEqual         (    v1, v2  : Double        ) : Boolean;
function IsInteger       (    x       : Double;
                              dx      : Double = 0    ) : Boolean;
function Quantisized     (    x, dx   : Double        ) : Double;
function GCD             (    a, b    : Integer       ) : Integer;   { = ggT }
function NormingValue    (    x, y, z : Double;
                              dd      : Double = 1e-5 ) : Double;

function arcsin          (    x       : Double        ) : Double;
function arccos          (    x       : Double        ) : Double;
function bogen           (    grad    : Double        ) : Double;
function grad            (    bogen   : Double        ) : Double;

function slope_angle     (    x, y            : Double) : Double;
function signed_angle    (    ax, ay, bx, by  : Double) : Double;
function unsigned_angle  (    ax, ay, bx, by  : Double) : Double;
function ui2gt           (    p               : Double) : Double;
function gt2ui           (    t               : Double) : Double;
function GetRandom       (    b1, b2          : Double) : Double;

function power           (    basis, hochzahl : Double;
                          var value           : Double    ) : Boolean;

function LTRB_Rect       (    r               : TRect     ) : TRect;

function DistPt2Line     (    x1, y1, x2, y2,
                              x,  y           : Double    ) : Double; overload;
function DistPt2Line     (    g               : TVector3;
                              x0, y0          : Double    ) : Double; overload;

function DistPt2ShortLn  (    x1, y1, x2, y2,
                              x, y            : Double    ) : Double;

function DistPt2OriArc   (    x1, y1, x2, y2,
                              x, y            : Double    ) : Double;

function are_parallel    (    x1, y1, x2, y2,
                              x3, y3, x4, y4  : Double    ) : Boolean;

function GetTV           (    x1, y1, x2, y2,
                              xt, yt          : Double;
                          var tv              : Double    ) : Boolean;

function GetLineThroughPoints
                         (     x1, y1, x2, y2 : Double;
                           var a, b, c        : Double    ) : Boolean;

function GetHesseEqFromPtAndDir
                         (     px, py, dx, dy : Double;
                           var eq             : TVector3  ) : Boolean;

function GetHesseEqFromPtAndNormal
                         (     px, py, nx, ny : Double;
                           var eq             : TVector3  ) : Boolean;

function GetNormalizedDirFromHesseEq
                         (     eq             : TVector3;
                           var dir            : TFloatPoint): Boolean;

function Get2PointsFromHesseEq
                         (     eq             : TVector3;
                           var P1, P2         : TFloatPoint): Boolean;

function GetPedalPoint   (     x1, y1, x2, y2,
                               xm, ym         : Double;
                           var xf, yf         : Double    ) : Boolean; overload;

function GetPedalPoint   (     g              : TVector3;
                               x0, y0         : Double;
                           var xf, yf         : Double    ) : Boolean; overload;

function  GetProjPoints  (     g1, g2         : TVector3;
                               xp, yp         : Double;
                           var x1, y1, x2, y2 : Double    ) : Boolean;

function GetLineParamFromPt  ( g              : TVector3;
                               x0, y0, x1, y1 : Double;
                           var t              : Double    ) : Boolean;

function GetLinePtFromParam  ( g              : TVector3;
                               t, x0, y0      : Double;
                           var x1, y1         : Double    ) : Boolean;

function GetSymAxis      (     x1, y1, x2, y2 : Double;
                           var xm, ym, rx, ry : Double    ) : Boolean;

function GetCircumMidPt  (     x1, y1, x2, y2,
                               x3, y3         : Double;
                           var xm, ym         : Double    ) : Boolean;

function GetCircleDataFromMat (mat            : Array of Double;
                           var xm, ym, r      : Double    ) : Boolean;

function GetBestDirVector(     x1, y1, x2, y2,
                               x3, y3         : Double;
                           var xm, ym         : Double    ) : Boolean;

function TooMuchBending  (     u1, u2, u3     : TVector3  ) : Boolean;


function GetConicCoeffFromPoints
                         (     P       : TFloatPointList;
                           var coeff   : Array of Double  ) : Boolean;

function GetConicParamsFromCoeff
                         (     co      : Array of Double;
                           var ct      : Integer;
                           var xm, ym, xn, yn,
                               hdx, hdy, alpha,
                               ha_a, ha_b,
                               ec      : Double;
                           var g1, g2  : TVector3         ) : Boolean;

function GetPolareFromPolAndConic
                         (     px, py  : Double;
                               coeff   : Array of Double;
                           var polCoeff: TVector3         ) : Boolean;

function GetPolFromPolareAndConic
                         (     polare: TVector3;
                               coeff : Array of Double;
                           var px, py: Double             ) : Boolean;

function Get4thTrapezoidPoint
                         (     x1, y1, x2, y2,
                               x3, y3  : Double;
                           var x4, y4  : Double           ) : Boolean;

function GetAffineMapFromPts
                         (     p, q    : TFloatPointList;
                           var Mat     : TMatrix32        ) : Boolean;


function SolveQuadraticEquation
                         (     a, b, c : Double;
                           var x1, x2  : Double)  : Integer;

function SolveCubicEquation
                         (     a, b, c, d         : Double;
                           var x1, x2, x3         : Double) : Integer;

function SolveForthOrderEquation
                         (     a, b, c, d, e      : Double;
                           var x1, x2, x3, x4     : Double) : Integer;

procedure SortAsc        ( var a1, a2             : Double);

procedure IntersectLines (     x1, y1, x2, y2,
                               x3, y3, x4, y4     : Double;
                           var xs, ys             : Double;
                           var valid              : Boolean); overload;

procedure IntersectLines (     g1, g2             : TVector3;
                           var xs, ys             : Double;
                           var valid              : Boolean); overload;

procedure IntersectCircleWithLine
                         (     xm, ym, radius,
                               xa, ya, xb, yb     : Double;
                           var P1x, P1y, P2x, P2y : Double;
                           var valid1, valid2     : Boolean);

procedure IntersectCircles
                         (     xm1, ym1, r1,
                               xm2, ym2, r2       : Double;
                           var P1x, P1y, P2x, P2y : Double;
                           var valid1, valid2     : Boolean);

procedure IntersectConicWithLine
                         (     co                 : TCoeff6;
                               g                  : TVector3;
                           var x1, y1, x2, y2     : Double;
                           var valid1, valid2     : Boolean);

procedure IntersectConics(     co1, co2           : TCoeff6;
                           var fp                 : TFloatPointList;
                           var valid1, valid2,
                               valid3, valid4     : Boolean);

procedure IntersectRectangleWithLine
                         (     Rect               : TRect;
                               X1, Y1, X4, Y4     : Double;
                           var x2, y2, x3, y3     : Double;
                           var valid2, valid3     : Boolean); overload;

procedure IntersectRectangleWithLine
                         (     xmin, xmax,
                               ymin, ymax         : Double;
                               g                  : TVector3;
                           var x1, y1, x2, y2     : Double;
                           var v                  : Boolean); overload;

procedure MoveToRectBorder
                         (     Rect               : TRect;
                               xz, yz             : Double;
                           var xmp, ymp           : Double);

function  RectBorderNumber
                         (     Rect               : TRect;
                               px, py             : Integer;
                               detailed : Boolean = False       ) : Integer;

procedure RotateVector2ByAngle
                         (     ix, iy, angle      : Double;
                           var ex, ey             : Double);

procedure GetCentreOfGravity_2DPolyInt
                         (     n                  : Integer;
                           var PointList          : TFloatPointList;
                           var xcog, ycog, area   : Double);

procedure GetLeftSideWindowPolygon
                         (     ax, ay, bx, by,
                               xmin, ymin,
                               xmax, ymax         : Double;
                           var PointList          : TFloatPointList);

procedure MakeBezierShapingPointList
                         (     DataPoint          : TVector3List;
                           var ShapingPt          : Array of TPoint);

function  CorrCoeff      (     data               : TVector3List): Double;

function  BestLineApprox (     data               : TVector3List;
                           var QualityF           : Double;
                           var pt, dir            : TVector3    ): Boolean;

function  BestCircleApprox
                         (     data               : TVector3List;
                           var QualityF           : Double;
                           var pt                 : TVector3;
                           var radius             : Double      ): Boolean;

function  BestConicApprox(     data               : TVector3List;
                           var QualityF           : Double;
                           var coeff              : TCoeff6     ): Boolean;

{------- Kryptisches -------------------------}

function DecodeRegString   (source : AnsiString ) : AnsiString;
function EncodeRegString   (source : AnsiString ) : AnsiString;
function GetCtrlStringFrom (n      : Integer) : String;
function GetCtrlIntegerFrom(s      : String ) : Integer;
function FileCheckSumIsOk  (f_name : String ) : Boolean;
function SetTextCheckSum   (sl : TStringList) : Boolean;
function TextCheckSumIsOk  (sl : TStringList) : Boolean;
function GetStatusCtrl     (n  : Integer    ) : Integer;

{------- String-Manipulata -------------------}

procedure increment    (var s      : string ) ;
procedure FormatNumStr (var s      : String ) ;
procedure DeleteChars  (delchars   : String;
                        var s      : String ) ;
procedure CheckFloat   (var f      : Double;
                            default: Double ) ;
function  AsFloat      (    s      : String ) : Double;
procedure GetFloatPair (var s      : String;
                        var x, y   : Double ) ;


IMPLEMENTATION

Uses SysUtils, Math, crc32, GlobVars, Unit_LGS;


Const sqrt2 : Double = 0;  { hier wird beim Start "SQRT(2)" eingetragen }
      ln10  : Double = 0;  { hier wird beim Start "LN(10)" eingetragen  }

{========== TCoordSys2D ===================================================}

constructor TCoordSys2D.Create(ix0, iy0, ipW, ipH: Integer; iex, iey: Double);
  begin
  ResetTo(ix0, iy0, ipW, ipH, iex, iey);
  end;

procedure TCoordSys2D.ResetTo(ix0, iy0, ipW, ipH: Integer; iex, iey: Double);
  begin
  px0 := ix0;
  py0 := iy0;
  pWidth  := ipW;
  pHeight := ipH;
  fe1x := iex;
  fe1y := 0;
  fe2x := 0;
  fe2y := -Abs(iey);
  If Hypot(fe1x, fe2y) > 0 then begin
    fIsOkay := True;
    GetLogCoords(0, pHeight, fXmin, fYmin);
    GetLogCoords(pWidth, 0, fXmax, fYmax);
    fLWRad := Hypot(fXmax - fXmin, fYMax - fYmin) / 2;
    end
  else
    fIsOkay := False;
  end;

function TCoordSys2D.GetLogCoords(px, py: Integer; var lx, ly: Double): Boolean;
  begin
  Result := IsOkay;
  lx := ( px - px0) / e1x;
  ly := ( py - py0) / e2y;
  end;

function TCoordSys2D.GetWinCoords(lx, ly: Double; var px, py: Integer): Boolean;
  begin
  Result := IsOkay;
  px := SafeRound(px0 + lx * e1x);
  py := SafeRound(py0 + ly * e2y);
  end;

function TCoordSys2D.GetXcenter: Double;
  begin
  Result := (fXmin + fXmax) / 2;
  end;

function TCoordSys2D.GetYcenter: Double;
  begin
  Result := (fYMin + fYmax) / 2;
  end;

function TCoordSys2D.LogWinKnows(lx, ly: Double): Integer;
  { Logische Koordinaten!  Sei d der Abstand des Punktes (lx,ly) vom
    Mittelpunkt des aktuellen Ausgabefensters, r der Abstand eines
    Fenstereckpunkts von diesem Mittelpunkt.
    Die Funktion liefert
       1  für          d <    r
       0  für     r <= d <  2*r
      -1  für   2*r <= d          }
  var d : Double;
  begin
  d := Hypot(lx - Xcenter, ly - Ycenter);
  If d < FLWrad then
    Result := 1
  else
    if d < 2 * FLWrad then
      Result := 0
    else
      Result := -1;
  end;

function TCoordSys2D.LogWinContains(lx, ly: Double): Boolean;
  begin
  Result := (lx >= fXmin) and (lx <= fXmax) and
            (ly >= fYmin) and (ly <= fYmax);
  end;


{============ Komplexe Zahlen ===========================================}

constructor TCNumber.create(i_rp, i_ip: Double);
  begin
  rp := i_rp;
  ip := i_ip;
  end;

function TCNumber.getAbsLength: Double;
  begin
  Result := Math.Hypot(rp, ip);
  end;

function TCNumber.getRealPart: Double;
  begin
  Result := rp;
  end;

function TCNumber.getImgPart: Double;
  begin
  Result := ip;
  end;

function TCNumber.isZero: Boolean;
  begin
  Result := getAbsLength < MathLib.epsilon;
  end;

function TCNumber.isReal: Boolean;
  begin
  Result := Abs(ip) < MathLib.epsilon;
  end;

procedure TCNumber.plus(cn2: TCNumber);
  begin
  rp := rp + cn2.getRealPart;
  ip := ip + cn2.getImgPart;
  end;

procedure TCNumber.minus(cn2: TCNumber);
  begin
  rp := rp - cn2.getRealPart;
  ip := ip - cn2.getImgPart;
  end;

procedure TCNumber.times(cn2: TCNumber);
  var rp1, ip1, rp2, ip2 : Double;
  begin
  rp1 := rp;
  ip1 := ip;
  rp2 := cn2.getRealPart;
  ip2 := cn2.getImgPart;
  rp  := rp1 * rp2 - ip1 * ip2;
  ip  := rp1 * ip2 + rp2 * ip1;
  end;

procedure TCNumber.divideBy(cn2: TCNumber);
  var rp1, ip1, rp2, ip2, aq2 : Double;
  begin
  rp1 := rp;
  ip1 := ip;
  rp2 := cn2.getRealPart;
  ip2 := -cn2.getImgPart;
  aq2 := Sqr(rp2) + Sqr(ip2);
  if aq2 > MathLib.epsilon then begin
    rp  := (rp1 * rp2 - ip1 * ip2) / aq2;
    ip  := (rp1 * ip2 + rp2 * ip1) / aq2;
    end;
  end;

{======== Komplexe-Zahlen-Liste ===========================================}

function TCNumberList.getItem(nr: Integer): TCNumber;
  begin
  if (nr >= 0) and (nr < Count) then
    Result := TCNumber(Get(nr))
  else
    Result := Nil;
  end;

destructor TCNumberList.Destroy;
  begin
  While Count > 0 do begin
    item[0].Free;
    Delete(0);
    end;
  Inherited Destroy;
  end;

{======== Vektor-Typ ======================================================}

constructor TVector3.Create(ix, iy, iz: Double; itag: Integer = 0);
  begin
  Inherited Create;
  X   := ix;
  Y   := iy;
  Z   := iz;
  tag := itag;
  end;

constructor TVector3.CreateCopyOf(iv: TVector3);
  begin
  Inherited Create;
  X := iv.X;
  Y := iv.Y;
  Z := iv.Z;
  tag := iv.tag;
  end;

constructor TVector3.CreateFromString(s: String);
  var buf : String;
      n   : Integer;
  begin
  Inherited Create;
  n := POS(';', s);
  buf := Copy(s, 1, Pred(n));
  X := StrToFloat(buf);

  Delete(s, 1, n);
  n := POS(';', s);
  buf := Copy(s, 1, Pred(n));
  Y := StrToFloat(buf);

  Delete(s, 1, n);
  Z := StrToFloat(s);

  If (Abs(X) > 1e100) and (Abs(Y) > 1e100) then
    tag := -2;
  end;

constructor TVector3.Load32(R : TReader);
  begin
  X := R.ReadFloat;
  Y := R.ReadFloat;
  Z := R.ReadFloat;
  If (Abs(X) > 1e100) and (Abs(Y) > 1e100) then
    tag := -2;
  end;

procedure TVector3.Store32(W : TWriter);
  begin
  If IsValid then begin
    W.WriteFloat(X);
    W.WriteFloat(Y);
    W.WriteFloat(Z);
    end
  else begin
    W.WriteFloat(1.1e100);
    W.WriteFloat(1.1e100);
    W.WriteFloat(Z);
    end;
  end;

function TVector3.GetContentsString: String;
  begin
  Result := FloatToStr(X) + ';' + FloatToStr(Y) + ';' + FloatToStr(Z);
  end;

function TVector3.GetIsValid: Boolean;
  begin
  Result := tag > -2;
  end;

procedure TVector3.SetIsValid(newVal: Boolean);
  begin
  If newVal then
    tag := 0
  else
    tag := -2;
  end;

procedure TVector3.Assign(ix, iy, iz: Double; itag: Integer = 0);
  begin
  X   := ix;
  Y   := iy;
  Z   := iz;
  tag := itag;
  end;

procedure TVector3.Assign(src: TVector3);
  begin
  X   := src.X;
  Y   := src.Y;
  Z   := src.Z;
  tag := src.tag;
  end;

procedure TVector3.CopyFrom(source: TVector3);
  begin
  X   := source.x;
  Y   := source.y;
  Z   := source.z;
  tag := source.tag;
  end;

procedure TVector3.DivBy(d: Double);
  begin
  If Abs(d) > epsilon then begin
    X := X / d;
    Y := Y / d;
    Z := Z / d;
    end;
  end;

{======== Vektoren-Liste ==================================================}

constructor TVector3List.CreateFromString(s: String);
  var buf : String;
      nv  : TVector3;
      i   : Integer;
  begin
  Inherited Create;
  While Length(s) > 0 do begin
    i := POS(' ', s);
    If i > 0 then begin
      buf := Copy(s, 1, Pred(i));
      System.Delete(s, 1, i);
      end
    else begin
      buf := s;
      s   := '';
      end;
    DeleteChars(#09#10#13, buf); // 15.03.2010: Tabs + Umbruch-Reste killen
    try
      nv := TVector3.CreateFromString(buf);
      Add(nv);
    except
      SpyOut('Invalid Vector3List entry: "%s" ', [buf]);
    end; { of try }
    end;
  end;

constructor TVector3List.Load32(R: TReader);
  begin
  Inherited Create;
  R.ReadListBegin;
  While not R.EndOfList do
    Add(TVector3.Load32(R));
  R.ReadListEnd;
  end;

destructor TVector3List.Destroy;
  { Achtung! Die Liste "besitzt" alle eingetragenen Vektoren !
    Daher gibt sie zunächst den durch die Vektoren belegten
    Speicher frei, ehe sie selbst entfernt wird.              }
  var i : Integer;
  begin
  For i := Pred(Count) downto 0 do begin
    Item[i].Free;
    Items[i] := Nil;
    end;
  Inherited Destroy;
  end;

function TVector3List.GetRLV(n: Integer): TVector3;
  { Diese Funktion liefert für jedes n >= 0 einen Vektor aus der Liste,
    sofern sie überhaupt auch nur einen enthält.                       }
  begin
  If Count > 0 then
    Result := Items[n MOD Count]
  else
    Result := Nil;
  end;

function TVector3List.GetItem(n: Integer): TVector3;
  { Zugriffsfunktion für die einzelnen Vektoren aus der Liste.
    Achtung!! Auch für gültige Indizes kann Nil zurückgegeben werden!  }
  begin
  if (n >= 0) and (n < Count) then
    Result := Items[n]
  else
    Result := Nil;
  end;

procedure TVector3List.Clear;
  { Achtung! Die Liste "besitzt" alle eingetragenen Vektoren !
    Daher gibt sie zunächst den durch die Vektoren belegten
    Speicher frei, ehe sie selbst geleert wird.               }
  var i : Integer;
  begin
  For i := Pred(Count) downto 0 do
    DeleteItem(i);
  Inherited Clear;
  end;

procedure TVector3List.WipeOut;
  { Führt ein "Clear" ohne Löschung der einzelnen Vektoren durch.
    Eingeführt für den (seltenen) Fall, dass die Liste die Vektoren
    doch nicht besitzt ! }
  begin
  Inherited Clear;
  end;

procedure TVector3List.DeleteItem(n: Integer);
  begin
  try
    Item[n].Free;
  finally
    Delete(n);
  end;
  end;

function TVector3List.GetContentsString: String;
  var i : Integer;
  begin
  Result := '';
  If Count >= 1 then begin
    Result := TVector3(Items[0]).GetContentsString;
    For i := 1 to Pred(Count) do
      Result := Result + ' ' + TVector3(Items[i]).GetContentsString;
    end;
  end;

function TVector3List.InsertZSortedWithXYDist
               (minDist, ix, iy, iz: Double; itag: Integer = 0): Integer;
  var aDist, bDist : Double;
      i            : Integer;
  begin
  If count = 0 then begin
    Add(TVector3.Create(ix, iy, iz, itag));
    Result := 0;
    end
  else begin
    i := Pred(Count);
    While (i >= 0) and
          (TVector3(Items[i]).Z > iz) do
      Dec(i);

    If i >= 0 then
      aDist := Hypot(ix - TVector3(Items[i]).X,
                       iy - TVector3(Items[i]).Y)
    else
      aDist := minDist + 1;
    If i < Pred(Count) then
      bDist := Hypot(ix - TVector3(Items[Succ(i)]).X,
                       iy - TVector3(Items[Succ(i)]).Y)
    else
      bDist := minDist + 2;

    If (aDist > minDist) and (bDist > minDist) then begin
      Insert(Succ(i), TVector3.Create(ix, iy, iz, itag));
      Result := Succ(i);
      end
    else
      Result := -1;
    end;
  end;

function TVector3List.InsertZSorted(ix, iy, iz: Double; itag: Integer = 0): Integer;
  var i : Integer;
  begin
  If count = 0 then begin
    Add(TVector3.Create(ix, iy, iz, itag));
    Result := 0;
    end
  else begin
    i := Pred(Count);
    While (i >= 0) and
          (TVector3(Items[i]).z > iz) do
      Dec(i);
    Insert(Succ(i), TVector3.Create(ix, iy, iz, itag));
    Result := Succ(i);
    end;
  end;

function TVector3List.InsertZSorted(v: TVector3): Integer;
  var i : Integer;
  begin
  If count = 0 then begin
    Add(v);
    Result := 0;
    end
  else begin
    i := Pred(Count);
    While (i >= 0) and
          (TVector3(Items[i]).z > v.z) do
      Dec(i);
    Insert(Succ(i), v);
    Result := Succ(i);
    end;
  end;

function  TVector3List.GetPtIndexNextToXY(xp, yp: Double ): Integer;
  var i     : Integer;
      d2min, d2new : Double;
  begin
  Result := -1;
  If Count > 0 then begin
    d2min := 1e20;
    For i := 0 to Pred(Count) do
      With TVector3(Items[i]) do
        If IsValid then begin
          d2new := Sqr(X - xp) + Sqr(Y - yp);
          If d2new < d2min then begin
            d2min  := d2new;
            Result := i;
            end;
          end;
    end;
  end;

function  TVector3List.GetPtIndexWithZequals(zp: Double): Integer;
  { 01.05.2008 :  Neu implementiert, um unabhängig von der (zuvor gemachten)
                  Voraussetzung zu werden, dass der Parameter z stets im
    Intervall [0..1] liegen muss. Nun ist der Parameter-Bereich beliebig,
    was speziell für die Behandlung von Funktionen wichtig ist.            }
  var n : Integer;
  begin
  Result := - 1;
  If Count > 0 then
    If Count = 1 then
      If Abs(TVector3(Items[0]).Z - zp) < epsilon / 10 then
        Result := 0
      else
    else begin
      n := SafeRound((zp                             - TVector3(Items[0]).Z) /
                     (TVector3(Items[Pred(Count)]).Z - TVector3(Items[0]).Z) *
                     Pred(Count));              // Erst mal schätzen, dann
      If n <  0     then n := 0;            //   Schätzwert sicher ins zulässige
      If n >= Count then n := Pred(Count);  //   Index-Interval bringen !
      While (n >= 0   ) and (TVector3(Items[n]).Z - zp > epsilon / 10) do n := n - 1;
      While (n < Count) and (zp - TVector3(Items[n]).Z > epsilon / 10) do n := n + 1;
      If Abs(TVector3(Items[n]).Z - zp) < epsilon / 10 then
        Result := n;
      end;
  end;

function  TVector3List.ValidPointCount: Integer;
  var n, i : Integer;
  begin
  n := 0;
  For i := 0 to Pred(Count) do
    If TVector3(Items[i]).IsValid then
      n := n + 1;
  Result := n;
  end;

procedure TVector3List.Reset2StandardList(startparam, endparam: Double;
                                          insCount: Integer);
  begin
  Clear;
  Add2StandardList(startparam, endparam, insCount);
  end;

procedure TVector3List.Add2StandardList(startparam, endparam: Double; insCount: Integer);
  var i         : Integer;
      dp, param : Double;
  begin
  InsertZSorted(0, 0, StartParam);
  InsertZSorted(0, 0, EndParam);
  If InsCount > 0 then begin
    dp    := (EndParam - StartParam) / (InsCount + 1);
    param :=  StartParam + dp;
    For i := 1 to InsCount do begin
      InsertZSorted(0, 0, param);
      param := param + dp;
      end;
    end;
  end;

procedure TVector3List.AddExtraEndPoints;
  var nz : Double;
  begin
  If Count > 3 then begin     { zusätzliche Punkte zum Versorgen der Enden }
    nz := (TVector3(Items[0      ]).Z + TVector3(Items[1      ]).Z) / 2;
    InsertZSorted(0, 0, nz);
    nz := (TVector3(Items[Count-1]).Z + TVector3(Items[Count-2]).Z) / 2;
    InsertZSorted(0, 0, nz);
    InsertZSorted(0, 0, TVector3(First).Z + ParamEpsilon);
    InsertZSorted(0, 0, TVector3(Last ).Z - ParamEpsilon);
    end;
  end;


{======== Mathematische Funktionen ========================================}


CONST g_nach_b   : Double  = 1.7453292519943295769e-0002;
      SafeMaxInt : Integer = MaxInt Div 2;

function SafeRound (X : Double) : Integer;
  begin
  If IsNAN(X) then               { 04.09.03  Reihenfolge der Tests geändert: }
    Result := SafeMaxInt         {           Erst auf NAN testen !!!         }
  else
    If Abs(x) < SafeMaxInt then
      If X >= 0 then
        Result := Floor(X + 0.5)
      else
        Result := Ceil (X - 0.5)
    else
      if (X > 0) then
        Result := SafeMaxInt
      else
        Result := - SafeMaxInt;
  end;

function SafeSub(X, Y : Double) : Double;
  var bx, by, d : Double;
  begin
  bx := Abs(X);
  by := Abs(Y);
  d := X - Y;
  If bx > by then
    If Abs(d) < bx * epsilon then
      Result := 0
    else
      Result := d
  else
    If Abs(d) < by * epsilon then
      Result := 0
    else
      Result := d;
  end;

function IsEqual (v1, v2 : Double): Boolean;
  var diff, sum : Double;
  begin
  diff := Abs(v1 - v2);
  If diff < epsilon then
    Result := true
  else begin
    sum := Abs(v1) + Abs(v2);
    if sum > epsilon then
      Result := diff / sum < epsilon
    else
      Result := False;
    end;
  end;

function IsInteger (x : Double; dx : Double = 0) : Boolean;
  begin
  If dx = 0 then dx := epsilon else dx := Abs(dx);
  x := Abs(FRAC(x));
  If x > 0.5 then x := 1 - x;
  Result := x < dx;
  end;

function GCD(a, b: Integer): Integer;
  { Euklidischer Algorithmus, berechnet den
    größten gemeinsamen Teiler von a und b  }
  var r : Integer;
  begin
  If b > a then begin        // Stellt sicher, dass die größere
    r := a; a := b; b := r;  //   der beiden Zahlen in a steht
    end;
  While b > 0 do begin       // Eigentlicher Euklidischer Algorithmus
    r := a Mod b;
    a := b;
    b := r;
    end;
  Result := a;
  end;

function NormingValue(x, y, z: Double; dd : Double = 1e-5) : Double;
  { Es wird vorausgesetzt, dass dd positiv ist. }
  var p : Double;
  begin
  If dd < epsilon then dd := epsilon;
  x := Abs(x);
  y := Abs(y);
  z := Abs(z);
  If x < epsilon then x := 0;
  If y < epsilon then y := 0;
  If z < epsilon then z := 0;
  Result := Sqrt(Sqr(x) + Sqr(y) + Sqr(z));
  If Result > epsilon then begin
    If z > y then begin p := z; z := y; y := p; end;
    If y > x then begin p := y; y := x; x := p; end;
    If z > y then begin p := z; z := y; y := p; end;
    // Jetzt gilt:  x > y > z !
    If IsInteger(x, dd) and IsInteger(y, dd) and IsInteger(z, dd) then
      If z > epsilon then
        Result := GCD(GCD(SafeRound(x), SafeRound(y)), SafeRound(z))
      else if y > epsilon then
        Result := GCD(SafeRound(x), SafeRound(y))
      else
        Result := SafeRound(x);
    end
  else
    Result := 0;  // Notbremse für den Fall x = y = z = 0  !
  end;

function Quantisized(x, dx: Double): Double;
  var n : Integer;
  begin
  If dx < epsilon then
    Result := x
  else begin
    n := SafeRound(x / dx);
    Result := n * dx;
    end;
  end;

function log10 (x: Double) : Double;
  begin
  If x > 0 then
    Result := ln(x) / ln10
  else
    Result := NAN;
  end;

function arcsin (x : Double) : Double;
  begin
  If ABS (x) > 1.0 then
    raise EInvalidOp.Create('Unzulässiges Argument der arcSin - Funktion !!')
  else
    If ABS (x) < 1.0 then arcsin := ARCTAN (x / SQRT (1 - SQR (x)))
    else
      If x > 0 then arcsin :=   PI / 2
      else          arcsin := - PI / 2;
  end;


function arccos (x : Double) : Double;
  begin
  If ABS (x) > 1.0 then
    raise EInvalidOp.Create('Unzulässiges Argument der arcCos - Funktion !!')
  else
    If ABS (x) < 0.999999 then
      arccos := PI / 2 - ARCTAN (x / SQRT (1 - SQR (x) ) )
    else
      If x > 0 then arccos := 0
      else          arccos := PI;
  end;


function bogen (grad : Double) : Double;
  begin
  bogen := grad * g_nach_b;
  end;


function grad (bogen : Double) : Double;
  begin
  grad := bogen / g_nach_b;
  end;


function slope_angle (x, y : Double) : Double;
  { gibt den orientierten Steigungswinkel des Vektors (x|y) zurück; dabei
    wird vorausgesetzt, daß die Komponenten x und y des übergebenen Vektors
    in einem Koordinatensystem gegeben sind, in dem die y-Achse aus der
    x-Achse durch eine Drehung um pi/2 gegen den Uhrzeigersinn hervorgeht.
    Der ermittelte Winkel ist jedoch stets der im Gegenuhrzeigersinn
    orientierte Winkel des übergebenen Vektors gegen die positive
    x-Richtung.
    Es ist stets  0.0 <= slope_angle < 2 * Pi .                           }

  VAR sa : Double;
  begin
  If ABS(x) < epsilon then
    If y < 0.0 then
      sa := 1.5 * PI
    else
      sa := 0.5 * PI
  else begin
    sa := ARCTAN (y/x);
    If x < 0.0 then
      sa := sa + PI
    else   { x >= 0 }
      If y < 0.0 then
        sa := 2.0 * PI + sa;
    end;
//if (sa > pi) and (Abs(2*pi - sa) < AngleEpsilon) then
//  sa := 0;
  Result := sa;
  end;


function  signed_angle (ax, ay,
                        bx, by   : Double) : Double;
  { gibt den orientierten Winkel zurück, um den der Vektor
    (ax|ay) gedreht werden muß, um in die Richtung des
    Vektors (bx|by) zu zeigen; dabei drehen positive Winkel
    *gegen* den Uhrzeigersinn, negative *im* Uhrzeigersinn.
    Es ist stets:  - Pi < signed_angle <= Pi.                }

  begin
  Result := slope_angle (bx, by) - slope_angle (ax, ay);
  If Result > Pi then
    Result := Result - 2 * Pi
  else If Result <= - Pi then
    Result := Result + 2 * Pi;
  end;


function unsigned_angle (ax, ay,
                         bx, by  : Double) : Double;
  { gibt den Winkel zurück, um den der Vektor (ax|ay)
    gedreht werden muß, um in die Richtung des Vektors
    (bx|by) zu zeigen; dabei dreht der Winkel immer
    *gegen* den Uhrzeigersinn, also mathematisch positiv.
    Es ist stets:  0 <= unsigned_angle < 2*Pi.              }

  begin
  Result := slope_angle (bx, by) - slope_angle (ax, ay);
  If Result >= 2 * Pi then
    Result := Result - 2 * Pi
  else If Result < 0 then
    Result := Result + 2 * Pi;
  end;

function LTRB_Rect (r : TRect) : TRect;
  { korrigiert eventuelle falsche Orientierung des Rechtecks r;
    im zurückgegebenen Rechteck gilt stets :
           left <= right
           top <= bottom      }
  var buf : Integer;
  begin
  With r do begin
    If Left > Right then begin
      buf := Right; Right := Left; Left := buf; end;
    If Top > Bottom then begin
      buf := Bottom; Bottom := Top; Top := buf; end;
    end;
  Result := r;
  end;

function power (basis, hochzahl : Double; var value: Double) : Boolean;
  begin
  power := True;
  try
    value := math.Power(basis, hochzahl)
  except
    power := False;
  end;
  end;

function gt2ui(t : Double): Double;
  { Bildet die Menge der reellen Zahlen streng monoton wachsend in das
    Intervall (-1; 1) ab. Das Schaublid geht durch den Ursprung, und zwar
    mit seine größten Steigung, nämlich +1. Die Funktion gt2ui ist eine
    rationale Ersatz-Funktion für den Arcus-Tangens.                      }
  var w, z : Double;
  begin
  If Abs(t) < 1e-8 then
    Result := t
  else begin
    z := -0.5/t;
    w := Sqrt(Sqr(z)+1);
    If t > 0 then
      Result := z + w
    else
      Result := z - w;
    end;
  end;

function ui2gt(p : Double): Double;
  { Bildet das Intervall (-1; 1) streng monoton wachsend auf die Menge der
    reellen Zahlen ab. Das Schaubild geht durch den Ursprung, und zwar mit
    seiner kleinsten Steigung, nämlich +1. Die Funktion ui2gt ist eine
    rationale Ersatz-Funktion für den Tangens.                            }
  begin
  try
    Result := p/(1-Sqr(p));
  except
    Result := NAN;
  end; { of try }
  end;

function GetRandom(b1, b2: Double): Double;
  { berechnet eine Zufallszahl aus dem Intervall [b1; b2) }
  begin
  Result := b1 + (b2 - b1) * Random;
  end;

function GetTV (x1, y1, x2, y2, xt, yt : Double; var tv : Double) : Boolean;
  { berechnet das Teilverhältnis von (xt, yt) bezüglich der orientierten
    Strecke [(x1, y1), (x2, y2)]. Dabei wird vorausgesetzt, daß die drei
    übergebenen Punkte kollinear liegen, was jedoch nicht überprüft wird.
    Die Funktion gibt genau dann TRUE zurück, wenn die Berechnung erfolg-
    reich war. In diesem Fall enthält tv das berechnete Teilverhältnis;
    andernfalls wird tv unverändert zurückgegeben.                        }
  var dx, dy, adx, ady : Double;
  begin
  Result := True;
  dx  := x2 - x1;
  dy  := y2 - y1;
  adx := Abs(dx);
  ady := Abs(dy);
  If adx > ady then
    If adx > epsilon then
      tv := (xt - x1) / dx
    else
      Result := False
  else
    If ady > epsilon then
      tv := (yt - y1) / dy
    else
      Result := False;
  end;

function GetLineThroughPoints(x1, y1, x2, y2: Double; var a, b, c: Double): Boolean;
  { Berechnet einen Satz von Koeffizienten der Gleichung ax + by + c = 0
    der Geraden, die durch P1(x1|y1) und  P2(X2|y2) geht. Der Normalenvektor
    (a|b) geht aus P1P2 durch eine mathematische positive (d.h. "Links-")
    Drehung um pi/2 hervor. Das Ergebnis der Funktion ist genau dann TRUE
    (und a, b, c  damit gültig!), wenn P1 und P2 verschieden sind.          }
  begin
  a := y1 - y2;
  b := x2 - x1;
  c := -a*x1 - b*y1;
  Result := Hypot(a, b) > epsilon;
  end;

function GetHesseEqFromPtAndDir(px, py, dx, dy: Double; var eq: TVector3): Boolean;
  { Der Normalenvektor geht aus dem übergebenen Richtungsvektor (dx, dy) durch
    eine (mathematisch positive) Links-Drehung um pi/2 hervor. Die Gleichung
    der Geraden ist ax + by + c = 0 mit [a, b, c] = [eq.x, eq.y, eq.z] .    }
  var d : Double;
  begin
  d := Hypot(dx, dy);
  If d > epsilon then begin
      eq.x := -dy / d;
      eq.y :=  dx / d;
      eq.z := -px * eq.x - py * eq.y;
      eq.tag := 0;
      Result := True;
      end
  else
    Result := False;
  end;

function GetHesseEqFromPtAndNormal(px, py, nx, ny: Double; var eq: TVector3): Boolean;
  var d : Double;
  begin
  d := Hypot(nx, ny);
  If d > epsilon then begin
      eq.x := nx / d;
      eq.y := ny / d;
      eq.z := -px * eq.x - py * eq.y;
      eq.tag := 0;
      Result := True;
      end
  else
    Result := False;
  end;

function GetNormalizedDirFromHesseEq(eq: TVector3; var dir: TFloatPoint): Boolean;
  { Der Richtungsvektor geht aus dem in eq enthaltenen Normalenvektor
    durch eine (mathematisch negative) Rechts-Drehung um pi/2 hervor. }
  begin
  If (eq.X <> 0) or (eq.Y <> 0) then begin
    dir.x :=   eq.Y;
    dir.y := - eq.X;
    Result := True;
    end
  else
    Result := False;
  end;

function Get2PointsFromHesseEq(eq: TVector3; var P1, P2: TFloatPoint): Boolean;
  { Berechnet anhand der in eq übergebenen Hesseform zwei verschiedene
    Punkte auf dieser Geraden und gibt deren Koordinaten zurück.       }
  begin
  If eq.tag = 0 then begin
    If Abs(eq.X) > Abs(eq.Y) then begin
      P1.x := - eq.Z / eq.X;
      P1.y := 0;
      end
    else begin
      P1.x := 0;
      P1.y := - eq.Z / eq.Y;
      end;
    P2.x := P1.x + eq.Y;
    P2.y := P1.y - eq.X;
    Result := True;
    end
  else
    Result := False;
  end;

function GetPedalPoint (x1, y1, x2, y2, xm, ym: Double; var xf, yf: Double) : Boolean;
  { Berechnet die Koordinaten (xf, yf) vom Fußpunkt des Lotes von (xm, ym)
    aus auf die Gerade durch (x1, y1) und (x2, y2);  die Berechnung geht
    schief, wenn die beiden Punkte, die die Gerade definieren, zu dicht
    beieinander liegen. Falls dies passiert, werden die Koordinaten xf und
    yf ungeändert zurückgegeben und FALSE zurückgegeben; war die Berechnung
    erfolgreich, wird TRUE zurückgegeben.                             }

  var s, x21, y21, sqd12 : Double;

  begin
  x21 := x2 - x1;
  y21 := y2 - y1;
  sqd12 := Sqr (x21) + Sqr (y21);
  If sqd12 > DistEpsilon then begin
    s   := ((xm - x1) * x21 + (ym - y1) * y21) / sqd12;
    xf  := x1 + s*x21;
    yf  := y1 + s*y21;
    Result := True;
    end
  else
    Result := False;
  end;


function  GetPedalPoint(    g      : TVector3;
                            x0, y0 : Double;
                        var xf, yf : Double) : Boolean;
  { Berechnet den Lotfußpunkt Q(xf, yf) von P(x0, y0) auf die
    Gerade g : ax + by + c = 0  mit a = g.x, b = g.y, c = g.z
    Die Berechnung geht nur dann schief, wenn die Richtung der
    Geraden g unbestimmt ist. Dann wird FALSE zurückgegeben,
    andernfalls TRUE.                                          }

  var b2, t : Double;

  begin
  b2 := Sqr(g.X) + Sqr(g.Y);
  If Abs(b2) > epsilon then begin
    t := (-g.X * x0 - g.Y * y0 - g.Z) / b2;
    xf := x0 + t * g.X;
    yf := y0 + t * g.Y;
    Result := True;
    end
  else
    Result := False;
  end;


function  GetProjPoints(    g1, g2 : TVector3;
                            xp, yp : Double;
                        var x1, y1,
                            x2, y2 : Double) : Boolean;
  { Interpretiert die (in Hesseform!) übergebenen Geraden als Achsen eines
    affinen Koordinatensystems und berechnet in diesem die Projektionen des
    übergebenen Punktes (xp; yp) auf die Achsen. Die entsprechenden Punkte
    auf den Achsen werden in (x1; y1) und (x2; y2) zurückgeliefert.        }
  var d : Double;
      h : TVector3;
  begin
  Assert(Abs(Hypot(g1.X, g1.Y) - 1) < epsilon, 'Hesse-Form expected!');
  Assert(Abs(Hypot(g2.X, g2.Y) - 1) < epsilon, 'Hesse-Form expected!');
  d := g2.X * xp + g2.Y * yp + g2.Z;
  h := TVector3.Create(g2.X, g2.Y, g2.Z - d);
  try
    IntersectLines(g1, h, x1, y1, Result);
    If Result then begin
      d := g1.X * xp + g1.Y * yp + g1.Z;
      h.Assign(g1.X, g1.Y, g1.Z - d);
      IntersectLines(g2, h, x2, y2, Result);
      end;
  finally
    h.Free;
  end;
  end;


function  GetLineParamFromPt (    g      : TVector3;
                                  x0, y0,
                                  x1, y1 : Double;
                              var t      : Double) : Boolean;
  { g muss die Koeffizienten der Hesse-Normalenform der Geraden
    enthalten; P(x0;y0) und Q(x1;y1) müssen auf der Geraden liegen;
    dann liefert die Funktion den Parameterwert t des Geradenpunktes Q
    bezüglich des "Eichpunktes" P, der den Parameterwert 0 hat.
    Der Rückgabewert ist immer TRUE.                            }
  var dx, dy : Double;
  begin
  dx := x1 - x0;
  dy := y1 - y0;
  If Abs(dx) > Abs(dy) then
    t :=  dx / g.Y
  else
    t := -dy / g.X;
  Result := True;
  end;


function  GetLinePtFromParam (    g      : TVector3;
                                  t,
                                  x0, y0 : Double;
                              var x1, y1 : Double  ) : Boolean;
  { g muss die Koeffizienten der Hesse-Normalenform der Geraden
    enthalten; P(x0;y0) muss auf der Geraden liegen; dann liefert
    die Funktion die Koordinaten des Geradenpunktes Q(x1;y1) zum
    Parameterwert t bezüglich des "Eichpunktes" P(x0;y0).
    Der Rückgabewert der Funktion ist immer TRUE.               }
  begin
  x1 := x0 + t * g.Y;
  y1 := y0 - t * g.X;
  Result := True;
  end;


function  GetSymAxis(x1, y1, x2, y2     : Double;
                     var xm, ym, rx, ry : Double) : Boolean;
  { berechnet die Mittelsenkrechte der Punkte P1(x1|y1) und P2(x2|y2);
    in (xm|ym) wird der Mittelpunkt von P1 und P2 zurückgegeben,
    in (rx|ry) der Richtungsvektor der Mittelsenkrechten, der aus
    P1P2 durch eine mathematisch positive Vierteldrehung hervorgeht.
    Das Ergebnis ist genau dann TRUE, wenn (rx|ry) vom Nullvektor
    verschieden ist.                                                  }
  begin
  xm := (x1 + x2) / 2;
  ym := (y1 + y2) / 2;
  rx := (y2 - y1);
  ry := (x1 - x2);
  Result := Hypot(rx, ry) > epsilon;
  end;


function  GetCircumMidPt(x1, y1, x2, y2, x3, y3: Double;
                         var xm, ym            : Double) : Boolean;
  { Wenn die übergebenen Punkt (xi; yi) ein echtes Dreieck bilden,
       dann wird dessen Umkreis-Mittelpunkt berechnet und in (xm; ym)
       zurückgegeben; die Funktion liefert in diesem Falle TRUE;
    andernfalls liefert die Funktion FALSE. }

  var xa, ya, xra, yra,
      xb, yb, xrb, yrb,
      t, dis          : Double;
  begin
  Result := False;
  If GetSymAxis(x1, y1, x2, y2, xa, ya, xra, yra) and
     GetSymAxis(x2, y2, x3, y3, xb, yb, xrb, yrb) then begin
    dis := yrb * xra - xrb * yra;
    If Abs(dis) > epsilon then begin
      t  := ((xb - xa) * yra - (yb - ya) * xra) / dis;
      xm := xb + t * xrb;
      ym := yb + t * yrb;
      Result := True;
      end;
    end;
  end;

function GetCircleDataFromMat(mat: Array of Double; var xm, ym, r: Double): Boolean;
  var r2 : Double;
  begin
  Result := False;
  if (mat[0] = 1) and (mat[1] = 0) and           // Beschreibt die Matrix
     (mat[3] = 0) and (mat[4] = 1) then begin    // wirklich einen Kreis?
    xm := -mat[2];
    ym := -mat[5];
    r2 := Sqr(xm) + Sqr(ym) - mat[8];
    if r2 >= 0 then begin                 // Ist der Kreis wirklich reell?
      r := Sqrt(Abs(r2));
      Result := True;
      end;
    end;
  end;

function  GetBestDirVector(x1, y1, x2, y2, x3, y3: Double;
                           var xm, ym            : Double) : Boolean;
  { Es wird voarausgesetzt, dass die übergebenen Punkte (xi; yi) *kein*
    echtes Dreieck bilden. Das kann z.B. dadurch gesichert sein, dass
    ein vorhergehender Aufruf von "GetCircumMidPt" mit denselben Parametern
    den Wert FALSE geliefert hat.
    Wenn es gelingt, eine Gerade zu bestimmen, auf der alle übergebenen
       Punkte (xi; yi) liegen, dann wird in (xm; ym) ein normierter
       Normalenvektor dieser Geraden zurückgegeben und die Funktion
       liefert TRUE;
    andernfalls liefert die Funktion FALSE. Dieser Fall kann nur dann
       eintreten, wenn die 3 übergebenen Punkte paarweise identisch sind. }

  var d12, d13, d23 : Double;
  begin
  Result := False;
  d12 := Hypot(x1-x2, y1-y2);
  d13 := Hypot(x1-x3, y1-y3);
  d23 := Hypot(x2-x3, y2-y3);
  If d12 > d13 then
    if d12 > d23 then begin { d12 ist maximal }
      if d12 > epsilon then begin
        xm := (x1 - x2) / d12;
        ym := (y1 - y2) / d12;
        Result := True;
        end;
      end
    else begin { d23 ist maximal }
      if d23 > epsilon then begin
        xm := (x2 - x3) / d23;
        ym := (y2 - y3) / d23;
        Result := True;
        end;
      end
  else
    if d13 > d23 then begin { d13 ist maximal }
      if d13 > epsilon then begin
        xm := (x1 - x3) / d13;
        ym := (y1 - y3) / d13;
        Result := True;
        end;
      end
    else begin { d23 ist maximal }
      if d23 > epsilon then begin
        xm := (x2 - x3) / d23;
        ym := (y2 - y3) / d23;
        Result := True;
        end;
      end;
  end;


function TooMuchBending(u1, u2, u3: TVector3): Boolean;
  { Diese Funktion testet, ob die übergebenen Punkte nahe bei einer
    gemeinsamen Geraden liegen. Sie ergibt TRUE, wenn dies nicht der
    Fall ist, also wenn die Punkte eine Kurve beschreiben.

    11.12.2006 : Wesentliche Erweiterung des Funktions-Umfangs:
                 Nun wird zunächst getestet, ob die übergebenen Vektoren
    sich in ihrer Sichtbarkeit unterscheiden. Falls ja, wird schon TRUE
    zurückgegeben. Andernfalls wird im Falle sichtbarer Punkte getestet,
    ob sie auf einer Geraden liegen, im Falle von Punkten außerhalb des
    Fensterbereichs wird gleich FALSE zurückgegeben. }

  var du12x, du12y, du12b, du23x, du23y, du23b, bz, bn : Double;
  begin
  If (u1.tag <> u2.tag) or (u2.tag <> u3.tag) then
    Result := True
  else begin
    Result := False;
    If u1.tag = 1 then begin
      du12x := u2.x - u1.x;
      du12y := u2.y - u1.y;
      du12b := Hypot(du12x, du12y);
      If Abs(du12b) > epsilon then begin
        du12x := du12x / du12b;
        du12y := du12y / du12b;
        du23x := u3.x - u2.x;
        du23y := u3.y - u2.y;
        du23b := Hypot(du23x, du23y);
        If Abs(du23b) > epsilon then begin
          du23x := du23x / du23b;
          du23y := du23y / du23b;
          bz := Hypot(du23x - du12x, du23y - du12y);
          bn := Hypot(du23x + du12x, du23y + du12y);
          Result := bz > bn * MaxBending;
          end;
        end;
      end;
    end;
  end;


function GetConicCoeffFromPoints(P: TFloatPointList; var coeff: Array of Double): Boolean;
  { Liefert in der Variablen "coeff" die Koeffizienten der Gleichung
        ax² + 2bxy + cy² + 2dx + 2ey + f = 0
    zurück (Bezeichnungen nach Bronstein, "Taschenbuch der Mathematik"),
    die den Kegelschnitt durch die 5 Punkte P[i], (i = 0..4) darstellt.
    Algorithmus nach Plücker (siehe Hohenwarter, "GeoGebra", S. 132ff)

    Historische Anmerkung zur Warnung vor Experimenten:
      Vor der folgenden Implementierung gab es einen 1. Lösungsversuch auf
      der Basis von Linearen Gleichungssystemen: dabei wurde der gewählte
      Koeffizientenvektor durch die zusätzliche Bedingung
      a + b + c + d + e + f = 1  festgelegt. Dies führte in den Fällen zum
      Versagen, in denen sich a + b + c + d + e + f = 0 ergab. Andere
      Normierungsgleichungen führen auf ähnliche Probleme =>
      besser die Plücker'sche Methode verwenden !!!                        }

  type tvector = Array[0..2] of Double;
       tmatrix = Array[0..2, 0..2] of Double;

  function scalprod(v1, v2: tvector): Double;
    begin
    Result := v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2];
    end;

  procedure vprod(v1, v2: tvector; var v3 : tvector);
    begin
    v3[0] := v1[1] * v2[2] - v2[1] * v1[2];
    v3[1] := v1[2] * v2[0] - v2[2] * v1[0];
    v3[2] := v1[0] * v2[1] - v2[0] * v1[1];
    end;

  procedure fillmatrix(g1, g2: tvector; var m: tmatrix);
    var i, k : Integer;
    begin
    For i := 0 to 2 do
      For k := 0 to 2 do
        m[i,k] := g1[i]*g2[k] + g2[i]*g1[k];
    end;

  procedure vtransf(m: tmatrix; v: tvector; var rv: tvector);
    var i : Integer;
    begin
    For i := 0 to 2 do
      rv[i] := v[0]*m[0,i] + v[1]*m[1,i] + v[2]*m[2,i];
    end;

  var vg12, vg34, vg13, vg24       : tvector;
      vp           : Array [1..5] of tvector;
      ma, mb, mc   : tmatrix;
      la, mu, norm : Double;
      i, k         : Integer;

  begin { of GetConicCoeffFromPoints }
  Result := False;
  For i := 1 to 5 do begin
    vp[i,0] := P[i-1].X;
    vp[i,1] := P[i-1].Y;
    vp[i,2] := 1;
    end;
  vprod(vp[1], vp[2], vg12);  vprod(vp[3], vp[4], vg34);
  vprod(vp[1], vp[3], vg13);  vprod(vp[2], vp[4], vg24);
  fillmatrix(vg12, vg34, ma);
  fillmatrix(vg13, vg24, mb);
  vtransf(mb, vp[5], vp[1]);  la := scalprod(vp[5], vp[1]);
  vtransf(ma, vp[5], vp[1]);  mu := scalProd(vp[5], vp[1]);

  For i := 0 to 2 do
    For k := 0 to 2 do
      mc[i, k] := la * ma[i, k] - mu * mb[i, k];

  coeff[0] :=  mc[0, 0];
  coeff[1] := (mc[1, 0] + mc[0, 1]) / 2;
  coeff[2] :=  mc[1, 1];
  coeff[3] := (mc[2, 0] + mc[0, 2]) / 2;
  coeff[4] := (mc[2, 1] + mc[1, 2]) / 2;
  coeff[5] :=  mc[2, 2];

  norm := NormingValue(coeff[0], coeff[1], coeff[2], 1e-3);
  If norm > epsilon then begin
    If coeff[0] < 0 then
      norm := - norm;
    If Abs(norm) > epsilon then begin
      For i := 0 to 5 do
        coeff[i] := coeff[i] / norm;
      For i := 0 to 5 do                  { 19.10.06 (Bug v. Herrn Jäger): }
        If Abs(coeff[i]) < epsilon then   { Sehr kleine Koeffizienten auf  }
          coeff[i] := 0;                  {    Null ziehen !               }
      Result := True;
      end;
    end;
  end; { of GetConicCoeffFromPoints }


function GetConicParamsFromCoeff(    co            : Array of Double;
                                 var ct            : Integer;
                                 var xm, ym, xn, yn,
                                     hdx, hdy, alpha,
                                     ha_a, ha_b, ec: Double;
                                 var g1, g2        : TVector3     ): Boolean;
  { Bestimmt den Typ und die zugehörigen Form-Parameter des übergebenen
    Kegelschnitts  a x² + 2b xy + c y² + 2d x + 2e y + f = 0  mit
    (a, b, c, d, e, f) = (co[0], co[1], co[2], co[3], co[4], co[5]).

    Der Kegelschnitt wird dazu einer Hauptachsen-Transformation (HAT)
    unterzogen: zunächst wird er in eine achsenparallele Lage gedreht und
    dann in eine Standardlage verschoben. Danach liegt bei Mittelpunkts-
    Kurven (Ellipse, Hyperbel) der Mittelpunkt, bei Parabeln der Scheitel
    im Ursprung. (Siehe Schupp, "Kegelschnitte", S. 85ff)

    Die zurückgelieferten Parameter sind:

      ct : Typ des Kegelschnitts :  0 =  ungültig
                                    1 =  Parabel
                                    2 =  Parallele Geraden
                                    3 =  Doppelgerade
                                    4 =  Schneidende Geraden
                                    5 =  Hyperbel
                                    6 =  Punkt
                                    7 =  Ellipse

      Im Folgenden:  MPK = Mittelpunktskurve;        ( Typ 5, 7       )
                     PK  = Parabelkurve;             ( Typ 1          )
                     ZKS = Zerfallender Kegelschnitt ( Typ 2, 3, 4, 6 )

      xm, ym, xn, yn :  MPK: Mittelpunkt; PK: Scheitel
                        ZKS: Messpunkte auf den Geraden
      hdx, hdy       :  MPK, PK, ZKS: Verschiebung für HAT;
      alpha          :  MPK, PK: Drehwinkel für HAT;         ZKS: --
      ha_a, ha_b     :  MPK: Halbachsen; PK: Achsenrichtung; ZKS: --
      ec             :  MPK: Exzentrizität; PK: Parameter p; ZKS: --
      g1, g2         :  MPK: Achsen (Ell.) bzw. Asymptoten (Hyp.)
                        PK: Leitgerade und Symm.-Achse;      ZKS: Geraden }

  { Letzte Änderung: 14.02.2006 }

  var DG, dk,   // Invarianten des Kegelschnitts (DG = Det, dk = Unterdet)
      v, w1, w2 : Double;                         // Puffervariablen
      rotmat    : Array [0..1, 0..1] of Double;   // lokale Drehmatrix
      nco       : TCoeff6;                        // transformierte Gleichung
      i         : Integer;

  procedure InitRotMat(w : Double);
    var sw, cw : Extended;
    begin
    SinCos(w, sw, cw);
    rotmat[0,0] :=   cw;
    rotmat[1,0] := - sw;
    rotmat[0,1] :=   sw;
    rotmat[1,1] :=   cw;
    end;

  procedure rotatePt(x1, y1: Double; var x2, y2: Double);
    begin
    x2 := rotmat[0,0] * x1 + rotmat[1,0] * y1;
    y2 := rotmat[0,1] * x1 + rotmat[1,1] * y1;
    end;

  procedure rotateConic(rota: Double);
    var sina, cosa         : Extended;
        sico, sin2a, cos2a : Double;
    begin
    SinCos(rota, sina, cosa);
    cos2a := Sqr(cosa);
    sin2a := Sqr(sina);
    sico := sina * cosa;
    nco[0] := co[0]*cos2a - 2*co[1]*sico + co[2]*sin2a;
    nco[1] := 0;      // = (co[0] - co[2])*sico + co[1]*(cos2a -sin2a);
    nco[2] := co[0]*sin2a + 2*co[1]*sico + co[2]*cos2a;
    nco[3] := co[3]*cosa - co[4]*sina;
    nco[4] := co[3]*sina + co[4]*cosa;
    nco[5] := co[5];
    end;

  begin { of GetConicParamsFromCoeff }
  // Erst mal Werte ausrechnen
  DG := co[0]*(co[2]*co[5] - Sqr(co[4])) +
        co[1]*(co[4]*co[3] - co[1]*co[5]) +
        co[3]*(co[1]*co[4] - co[2]*co[3]);
  dk := co[0]*co[2] - Sqr(co[1]);

  // Dann auf "Null???" überprüfen
  If Abs(DG) < epsilon then DG := 0;
  If Abs(dk) < epsilon then dk := 0;

  try
    If Abs(co[1]) > epsilon then begin  // gedrehte Lage
      v  := (co[0] - co[2]) / (2 * co[1]);
      w1 := arctan(v - Hypot(v, 1));
      w2 := w1 + pi/2;  // = arctan(v + Hypot(v, 1));
      If alpha <= w1 then
        if Abs(alpha - w1) < Abs(alpha - (w2-pi)) then alpha := w1
        else                                           alpha := w2
      else if alpha<= w2 then
        if Abs(alpha- w1) < Abs(alpha- w2) then alpha:= w1
        else                                    alpha:= w2
      else
        if Abs(alpha- (w1 + pi)) < Abs(alpha- w2) then alpha:= w1
        else                                           alpha:= w2;
      rotateConic(alpha);                  // setzt das nco-Array !
      end
    else begin                          // Achsenlage
      For i := 0 to 5 do nco[i] := co[i];
      nco[1] := 0;
      w1     := 0;
      w2     := pi/2;
      alpha  := 0;
      end;

    If Abs(dk) > epsilon then         // Mittelpunktskurve
      If dk > 0 then                     // Gleiche Vorzeichen von a und c
        If Abs(DG) > epsilon then begin     // Ellipsen-artige Kurven
          If Abs(nco[0]) > Abs(nco[2]) then begin // falsche Ausrichtung =>
            If alpha > (w1 + w2) / 2 then alpha := w1
            else                          alpha := w2;
            rotateConic(alpha);                      // Drehung korrigieren
            end;
          If DG*(nco[0] + nco[2]) < 0 then begin  // Reelle Ellipse ( TYP 7 )
            ha_a := Sqrt(Abs(DG / (dk * nco[0])));   // Große Halbachse
            ha_b := Sqrt(Abs(DG / (dk * nco[2])));   // Kleine Halbachse
            ec := Sqrt(1 - Sqr(ha_b/ha_a));          // Exzentrizität
            hdx := -nco[3]/nco[0];
            hdy := -nco[4]/nco[2];
            InitRotMat(-alpha);
            rotatePt(hdx, hdy, xm, ym);              // Mittelpunkt
            rotatePt(0, 1, xn, yn);
            GetHesseEqFromPtAndDir(xm, ym, xn, yn, g2);
            rotatePt(1, 0, xn, yn);
            GetHesseEqFromPtAndDir(xm, ym, xn, yn, g1);
            xn := xm + ha_a * ec * xn;               // Ein Brennpunkt
            yn := ym + ha_a * ec * yn;
            ct := 7;
            end
          else                                    // Imaginäre Ellipse ( TYP 0 )
            ct := 0;
          end
        else begin                          // Doppelpunkt  ( TYP = 6 )
          hdx := -nco[3]/nco[0];
          hdy := -nco[4]/nco[2];
          InitRotMat(-alpha);
          rotatePt(hdx, hdy, xm, ym);              // Mittelpunkt
          ct := 6;
          end
      else { dk > 0 }                    // Verschiedene Vorzeichen von a und c
        if Abs(DG) > epsilon then begin     // Hyperbel  ( TYP 5 )
          If DG * nco[2] > 0 then begin        // falsche Ausrichtung =>
            If alpha > (w1 + w2) / 2 then alpha := w1
            else                          alpha := w2;
            rotateConic(alpha);                        // Drehung korrigieren
            end;
          ha_a := Sqrt(Abs(DG / (dk * nco[0])));       // Große Halbachse
          ha_b := Sqrt(Abs(DG / (dk * nco[2])));       // Kleine Halbachse
          ec := Sqrt(1 + Sqr(ha_b/ha_a));              // Exzentrizität
          hdx := -nco[3]/nco[0];
          hdy := -nco[4]/nco[2];
          InitRotMat(-alpha);
          rotatePt(hdx, hdy, xm, ym);                  // Mittelpunkt
          rotatePt(ha_a, ha_b, xn, yn);
          GetHesseEqFromPtAndDir(xm, ym, xn, yn, g1);  // 1. Asymptote
          rotatePt(ha_a, -ha_b, xn, yn);
          GetHesseEqFromPtAndDir(xm, ym, xn, yn, g2);  // 2. Asymptote
          rotatePt(1, 0, xn, yn);
          xn := xm + ha_a * ec * xn;                   // Ein Brennpunkt
          yn := ym + ha_a * ec * yn;
          ct := 5;
          end
        else begin  { DG = 0 }              // 2 schneidende Geraden ( TYP 4 )
          InitRotMat(-alpha);
          rotatePt(-nco[3]/nco[0],                  // Mittelpunkt;
                   -nco[4]/nco[2], xm, ym);         // beide Messpunkte auf den
          xn := xm;  yn := ym;                      //   Mittelpunkt setzen !
          v  := Sqrt(Abs(nco[0]/nco[2]));
          rotatePt(1,  v, w1, w2);                  // Steigungen der 1. Geraden
          GetHesseEqFromPtAndDir(xm, ym, w1, w2, g1);
          rotatePt(1, -v, w1, w2);                  // Steigungen der 2. Geraden
          GetHesseEqFromPtAndDir(xn, yn, w1, w2, g2);
          ct := 4
          end
    else begin                        // Parabolische Kurven (dk = 0)
      If Abs(nco[0]) < Abs(nco[2]) then begin // falsche Ausrichtung =>
        If alpha > (w1 + w2) / 2 then alpha := w1
        else                          alpha := w2;
        rotateConic(alpha);                      // Drehung korrigieren
        end;    // Jetzt ist nco[2] (also der Koeffizient von y²) gleich Null !
      If Abs(DG) > epsilon then begin    // Parabel   ( TYP 1 )
        hdx := -nco[3]/nco[0];
        hdy := (sqr(nco[3]) - nco[0]*nco[5])/(2*nco[0]*nco[4]);
        ec := -nco[4]/nco[0];
        ha_a := 0;
        If ec > 0 then ha_b := 1 else ha_b := -1;
        InitRotMat(-alpha);
          // Leitgerade und Symmetrieachse in g1 und g2 zurückgeben:
        rotatePt(ha_a, ha_b, xn, yn);       // Symmetrieachsen-Richtung
        rotatePt(hdx, hdy - ec/2, xm, ym);  // Schnittpunkt Leitgerade / Symmetrieachse
        GetHesseEqFromPtAndDir(xm, ym, yn, -xn, g1);
        GetHesseEqFromPtAndDir(xm, ym, xn,  yn, g2);
          // Scheitel der Parabel:
        rotatePt(hdx, hdy, xm, ym);
        ct := 1;
        end
      else begin                         // 2 parallele Geraden
        v := Sqr(nco[3]) - nco[0]*nco[5];
        InitRotMat(-alpha);
        If v > epsilon then begin           // 2 Geraden  ( TYP 2 )
          rotatePt(0, 1, w1, w2);
          rotatePt((-nco[3] - Sqrt(v)) / nco[0], 0, xm, ym);
          GetHesseEqFromPtAndDir(xm, ym, w1, w2, g1);
          rotatePt((-nco[3] + Sqrt(v)) / nco[0], 0, xn, yn);
          GetHesseEqFromPtAndDir(xn, yn, w1, w2, g2);
          ct := 2;
          end
        else if (v > - epsilon) and         // 1 Doppelgerade  ( TYP 3 )
                (Abs(nco[0]) > epsilon) then begin
          rotatePt(0, 1, w1, w2);
          rotatePt(-nco[3] / nco[0], 0, xm, ym);
          GetHesseEqFromPtAndDir(xm, ym, w1, w2, g1);
          g2.Assign(0, 0, 0);
          ct := 3;
          end
        else                                // Imaginäre Doppelgerade ( TYP 0 )
          ct := 0;
        end;
      end;
  except
    ct := 0;
  end;
  Result := ct <> 0;
  end;  { of GetConicParamsFromCoeff }


function GetPolFromPolareAndConic(    polare: TVector3;
                                      coeff : Array of Double;
                                  var px, py: Double         ): Boolean;
  { berechnet den Pol zur übergebenen Polaren "polare" zum Kegelschnitt
    mit den Koeffizienten "coeff[i]", i = 0..5; liefert "TRUE" oder "FALSE",
    ja nachdem, ob die Berechnung erfolgreich war oder nicht. Im ersten Fall
    werden zusätzlich in "px" und "py" die Pol-Koordinaten zurückgegeben.   }
  var lgs : TLGS;
      eq  : TEquation;
  begin
  Result := False;
  lgs := TLGS.Create(3, 3);
  SetLength(eq, 4);
  try
    eq[1] := coeff[0]; eq[2] := coeff[1]; eq[3] := coeff[3]; eq[0] := polare.X; lgs.SetEquation(1, eq);
    eq[1] := coeff[1]; eq[2] := coeff[2]; eq[3] := coeff[4]; eq[0] := polare.Y; lgs.SetEquation(2, eq);
    eq[1] := coeff[3]; eq[2] := coeff[4]; eq[3] := coeff[5]; eq[0] := polare.Z; lgs.SetEquation(3, eq);
    lgs.Diagonalize;
    lgs.GetEquation(0, eq);
    If (Round(eq[0]) = 1) and (Abs(eq[3]) > epsilon) then begin
      px := eq[1] / eq[3];
      py := eq[2] / eq[3];
      Result := True;
      end
  finally
    eq := Nil;
    lgs.Free;
  end;
  end;


function GetPolareFromPolAndConic(    px, py  : Double;
                                      coeff   : Array of Double;
                                  var polCoeff: TVector3       ): Boolean;
  { berechnet die Polare zum übergebenen Pol ("px"; "py") zum Kegelschnitt
    mit den Koeffizienten "coeff[i]", i = 0..5; liefert "TRUE" oder "FALSE",
    ja nachdem, ob die Berechnung erfolgreich war oder nicht. Im ersten Fall
    werden zusätzlich in "polCoeff" die Koeffizienten der Polaren-Gleichung
    in Hesse-Form zurückgegeben.                                            }
  var bnv : Double;
  begin
  polCoeff.X := coeff[0]*px + coeff[1]*py + coeff[3];
  polCoeff.Y := coeff[1]*px + coeff[2]*py + coeff[4];
  polCoeff.Z := coeff[3]*px + coeff[4]*py + coeff[5];
  bnv := Hypot(polCoeff.X, polCoeff.Y);
  If Abs(bnv) > epsilon then begin
    polCoeff.DivBy(bnv);
    Result := True;
    end
  else
    Result := False;
  end;

function Get4thTrapezoidPoint(x1, y1, x2, y2, x3, y3: Double; var x4, y4:Double): Boolean;
  { berechnet den 4. Punkte des Trapezes mit Grundseite P1P2 und einer
    Ecke P3; P4 ist also der Bildpunkt von P3 bei Spiegelung an der
    Mittelsenkrechten von P1 und P2. [ Dabei ist Pi = P(xi|yi). ]
    Geht die Berechnung schief, weil P1 und P2 zu dicht liegen, werden
    x1 und x4 nicht verändert und die Funktion gibt False zurück,
    andernfalls True.                                                  }

  var xp, yp : Double;

  begin
  If GetPedalPoint (x1, y1, x2, y2, x3, y3, xp, yp) then begin
    x4 := x1 + x2 + x3 - 2*xp;
    y4 := y1 + y2 + y3 - 2*yp;
    Result := True;
    end
  else
    Result := False;
  end;


function GetAffineMapFromPts(p, q: TFloatPointList; var Mat: TMatrix32): Boolean;
  var LGS : TLGS;
      eq  : TEquation;
      i   : Integer;
  begin
  LGS := TLGS.Create(3, 3);
  SetLength(eq, 4);
  For i := 1 to 3 do begin
    eq[0] := q[i-1].x;
    eq[1] := p[i-1].x;
    eq[2] := p[i-1].y;
    eq[3] := 1;
    LGS.SetEquation(i, eq);
    end;
  LGS.Diagonalize;
  LGS.GetEquation(0, eq);
  If Round(eq[0]) = 1 then begin  // LGS eindeutig lösbar
    Mat[0,0] := eq[1];
    Mat[1,0] := eq[2];
    Mat[2,0] := eq[3];
    For i := 1 to 3 do begin
      eq[0] := q[i-1].y;
      eq[1] := p[i-1].x;
      eq[2] := p[i-1].y;
      eq[3] := 1;
      LGS.SetEquation(i, eq);
      end;
    LGS.Diagonalize;
    LGS.GetEquation(0, eq);
    If Round(eq[0]) = 1 then begin
      Mat[0,1] := eq[1];
      Mat[1,1] := eq[2];
      Mat[2,1] := eq[3];
      Result := True;
      end
    else
      Result := False;
    end
  else  // LGS nicht eindeutig lösbar, also:
    Result := False;
  eq := Nil;
  LGS.Free;
  end;


{================= Standard-Gleichungen lösen ==================}

function SolveQuadraticEquation(    a, b, c : Double;
                                var x1, x2  : Double): Integer;
  { Berechnet die Lösungen der quadratischen Gleichung ax² + bx + c = 0.
    Gibt die Anzahl der verschiedenen reellen Lösungen als Funktions-
    Ergebnis zurück; für a=b=c=0 wird das Ergebnis -1 zurückgeliefert.
    Die reellen Lösungswerte werden gegebenenfalls in x1 und x2
    zurückgegeben.                                                 }
  var d, q : Double;
  begin
  d := Sqrt(Sqr(a) + Sqr(b) + Sqr(c));
  If d > epsilon then begin
    a := a/d;       { Erst normieren ! }
    b := b/d;
    c := c/d;
    If Abs(a) > epsilon then begin { echte quadratische Gleichung }
      d := Sqr(b) - 4*a*c;
      If d > -epsilon then
        If d > epsilon then begin  { zwei Lösungen }
          d := Sqrt(d);
          If b > 0 then
            q := (b + d)/(-2)
          else
            q := (b - d)/(-2);
          x1 := q/a;
          x2 := c/q;                   // nachgerechnet am 28.07.05: stimmt !
          Result := 2;
          end
        else begin                 { genau eine Lösung }
          x1 := -b/(2*a);
          Result := 1;
          end
      else
        Result := 0;               { keine Lösung }
      end
    else  { a = 0, also nur lineare Gleichung !!! }
      If Abs(b) > epsilon then begin
        x1     := -c/b;            { genau eine Lösung }
        Result := 1;
        end
      else  { b = 0 }
        If Abs(c) > epsilon then
          Result := 0              { keine Lösung }
        else
          Result := -1;            { viele Lösungen ! }

    If (Abs(c) < epsilon) and (Result > 0) then     { "Null-Nullstelle" nachjustieren }
      Case Result of
        1 : x1 := 0;
        2 : If Abs(x2) > Abs(x1) then
              x1 := 0
            else
              x2 := 0;
      end;
    end
  else
    Result := -1;                  { viele Lösungen ! }
  end;


function SolveCubicEquation(    a, b, c, d : Double;
                            var x1, x2, x3 : Double): Integer;
  { Berechnet die Lösungen der kubischen Gleichung ax³ + bx² + cx + d = 0 .
    Gibt die Anzahl der verschiedenen reellen Lösungen als Funktions-Ergebnis
    zurück; für den Fall einer allgemeingültigen Gleichung wird -1 geliefert.
    Die reellen Lösungswerte kommen gegebenenfalls in x1, x2 und x3 zurück.   }
  var q, r, r2, q3, v, w, _A, _B : Double;

  procedure iterate(var x: Double);
    var xa, dx,
        denom : Double;
        i     : Integer;
    begin
    dx := Abs(x * 1e-15);   { Maschinen-Genauigkeit für Double }
    i  := 0;
    Repeat
      xa := x;
      denom := (3*xa+2*a)*xa+b;
      If Abs(denom) > epsilon then
        x  := xa - (((xa+a)*xa+b)*xa+c)/denom
      else
        i := 10;
      Inc(i);   { Notbremse }
    until SameValue(x, xa, dx) or (i > 10);
    end;

  begin
  If Abs(a) > epsilon then begin
    b := b/a; c := c/a; d := d/a;
    a := b; b := c; c := d;
    { Nun sind a, b und c die Koeffizienten der normierten Gleichung
      x³ + ax² + bx + c = 0. Auf diese Gleichung wenden wir das Lösungs-
      verfahren von Vieta mit der Erweiterung von Hohenwarter an,
      allerdings nicht in der von ihm angegebenen falschen Form:              }
    q  := (Sqr(a) - 3*b)/9;
    r  := (2*Math.Power(a,3) - 9*a*b + 27*c)/54;
    r2 := Sqr(r);
    q3 := Math.Power(q,3);
    d  := r2 - q3;
    If d < 0 then begin   { Fall "d < 0" : 3 verschiedene reelle Lösungen     }
      w  := ArcCos(r/SQRT(q3));
      v  := -2*Sqrt(q);
      x1 := v*cos(w/3) - a/3;
      x2 := v*cos((w + 2*pi)/3) - a/3;
      x3 := v*cos((w - 2*pi)/3) - a/3;
      Iterate(x1);
      Iterate(x2);
      Iterate(x3);
      Result := 3;
      end
    else begin            { Fall "d >= 0" :  mindestens 1 reelle Lösung       }
      _A := Math.Power(Abs(r) + Sqrt(d), 1/3);
      If r > 0 then _A := -_A;
      If Abs(_A) > epsilon then
        _B := q/_A
      else
        _B := 0;
      x1 := _A + _B - a/3;
      If Abs(d) > epsilon then begin  { Fall "d > 0" : Eine reelle und zwei   }
        Iterate(x1);                  {          komplex-konjugierte Lösungen }
        Result := 1;           { x1 ist "einfach", darf also iteriert werden. }
        end
      else                            { Fall "d = 0" }
        If (Abs(r2) > epsilon) then begin    { Dann fallen die zwei komplexen }
          x2 := -0.5 * (_A + _B) - a/3;      {   Lösungen zusammen!           }
          Iterate(x1);  { Nur x1 iterieren, aber nicht x2, wegen f'(x2) = 0 ! }
          Result := 2;
          end
        else
          Result := 1;            { x1 ist "dreifach", daher nicht iterieren! }
      end;
    If IsZero(c) and (Result > 0) then        { "Null-Nullstelle" nachjustieren }
      Case Result of
        1 : x1 := 0;
        2 : If Abs(x2) > Abs(x1) then
              x1 := 0
            else
              x2 := 0;
        3 : If Abs(x3) > Abs(x2) then
              If Abs(x2) > Abs(x1) then
                x1 := 0
              else
                x2 := 0
            else
              If Abs(x3) > Abs(x1) then
                x1 := 0
              else
                x3 := 0;
      end;
    end
  else  { Fall "a = 0", d.h. keine (echte) kubische Gleichung }
    Result := SolveQuadraticEquation(b, c, d, x1, x2);
  end;


function SolveForthOrderEquation(    a, b, c, d, e  : Double;
                                 var x1, x2, x3, x4 : Double) : Integer;
  { Algorithmus nach Zurmühl, "Praktische Mathematik", S. 60ff }
  var z1, z2, z3, w, p1, p2, s1, s2 : Double;
      xa : Array [1..4] of Double;
      n, n2, i : Integer;

  procedure iterate(var x: Double);
    var xo, dx,
        ya, ys : Double;
        i      : Integer;
    begin
    dx := Abs(x * 1e-15);   { Maschinen-Genauigkeit für Double }
    i  := 0;
    Repeat
      xo := x;
      ya := (((xo + b)*xo + c)*xo + d)*xo + e;
      ys := ((4*xo + 3*b)*xo + 2*c)*xo + d;
      If (Abs(ys) > epsilon) and (Abs(ya) > epsilon) then
        x  := xo - ya/ys
      else
        i := 10;
      Inc(i);   { Notbremse }
    until SameValue(x, xo, dx) or (i > 10);
    end;

  begin
  If Abs(a) > epsilon then begin
    b := b/a;  {a3}
    c := c/a;  {a2}
    d := d/a;  {a1}
    e := e/a;  {a0}
    n := SolveCubicEquation(1, c, b*d-4*e, Sqr(d)+e*(Sqr(b)-4*c), z1, z2, z3);
    If n > 0 then begin
      If n > 1 then begin         { Kleinste Wurzel suchen }
        If z2 < z1 then z1 := z2;
        If n > 2 then
          If z3 < z1 then z1 := z3;
        end;
      w := Sqr(z1/2) - e;
      If w >= 0 then begin
        w  := Sqrt(w);
        If w > epsilon then begin
          p1 := -0.5*z1 + w;
          p2 := -0.5*z1 - w;
          s1 := (p1*b - d)/(2*w);
          s2 := (d - p2*b)/(2*w);       // 21.11.04 VZ umgedreht!
          end
        else begin
          p1 := -0.5*z1;
          p2 := p1;
          SolveQuadraticEquation(1, -b, c+z1, s1, s2);
          end;
        n  := SolveQuadraticEquation(1, s1, p1, x1, x2);
        n2 := SolveQuadraticEquation(1, s2, p2, x3, x4);
        i := 1;
        If n > 0 then begin
          xa[i] := x1; Inc(i);
          If n > 1 then begin
            xa[i] := x2; Inc(i);
            end;
          end;
        If n2 > 0 then begin
          xa[i] := x3; Inc(i);
          If n2 > 1 then begin
            xa[i] := x4; Inc(i);
            end;
          end;
        Dec(i);     { = n + n2 }
        For n := 1 to Pred(i) do       { nach aufsteigender Größe sortieren }
          For n2 := Succ(n) to i do
            If xa[n] > xa[n2] then begin
              w := xa[n]; xa[n] := xa[n2]; xa[n2] := w;
              end;
        For n := i Downto 2 do         { Doubletten löschen }
          If Abs(xa[n-1] - xa[n]) < epsilon then begin
            for n2 := n-1 to Pred(i) do
              xa[n2] := xa[n2 + 1];
            i := i - 1;
            end;
        For n := 1 to i do
          Iterate(xa[i]);
        If i > 0 then begin            { in die Ausgabe-Variablen transferieren }
          x1 := xa[1];
          If i > 1 then begin
            x2 := xa[2];
            If i > 2 then begin
              x3 := xa[3];
              If i > 3 then
                x4 := xa[4];
              end;
            end;
          end;
        Result := i;                   { Anzahl der Lösungen zurückliefern }
        end
      else
        Result := 0;
      end
    else            { Keine (eindeutige?) Lösung gefunden ?? }
      Result := 0;  {  Das sollte eigentlich nie passieren!! }
    end
  else
    Result := SolveCubicEquation(b, c, d, e, x1, x2, x3);
  end;

procedure SortAsc(var a1, a2: Double);
  var p : Double;
  begin
  If a1 > a2 then begin
    p  := a1;
    a1 := a2;
    a2 := p;
    end;
  end;

{========= Schnitt-Algorithmen =========================}

procedure IntersectLines(x1, y1, x2, y2, x3, y3, x4, y4: Double;
                         var xs, ys: Double; var valid: Boolean);
  var x21, y21, x34, y34, s : Double;
  begin
  x21 := X2 - X1;  y21 := Y2 - Y1;
  x34 := X4 - X3;  y34 := Y4 - Y3;
  s := SafeSub(x21 * y34, y21 * x34);
  If Abs (s) > epsilon then begin
    s  := (y21 * (X3 - X1) - x21 * (Y3 - Y1)) / s;
    xs := X3 + s * x34;
    ys := Y3 + s * y34;
    valid := True;
    end
  else
    valid := False;
  end;

procedure IntersectLines(g1, g2 : TVector3;
                         var xs, ys: Double; var valid: Boolean);
  var det : Double;
  begin
  det := g1.X * g2.Y - g2.X * g1.Y;
  If Abs(det) > epsilon then begin
    valid := True;
    xs := (g1.Y * g2.Z - g2.Y * g1.Z) / det;
    ys := (g2.X * g1.Z - g1.X * g2.Z) / det;
    end
  else
    valid := False;
  end;

procedure IntersectCircleWithLine (xm, ym, radius,
                                   xa, ya, xb, yb : Double;
                                   var P1x, P1y, P2x, P2y   : Double;
                                   var valid1, valid2 : Boolean);
  var amx, amy, ux, uy, a, b, c,
      s1, s2 : Double;
      n      : Integer;
  begin
  valid1 := False;
  valid2 := False;
  GetPedalPoint(xa, ya, xb, yb, xm, ym, ux, uy);
  a := Hypot(ux - xm, uy - ym);
  If Abs(a - radius) < DistEpsilon then begin
    P1x := ux;
    P1y := uy;
    valid1 := True;
    P2x := ux;
    P2y := uy;
    valid2 := True;
    end
  else begin
    ux := xb - xa;
    uy := yb - ya;
    a  := Sqr(ux) + Sqr(uy);
    If a > epsilon then begin
      amx := xa - xm;
      amy := ya - ym;
      b   := 2.0 * (ux * amx + uy * amy);
      c   := Sqr(amx) + Sqr(amy) - Sqr(radius);
      n := SolveQuadraticEquation(a, b, c, s1, s2);
      If n = 2 then begin
        If s1 > s2 then begin    // Lösungen der Größe nach anordnen !
          b  := s1; s1 := s2; s2 := b; end;
        P1x := xa + s1 * ux;
        P1y := ya + s1 * uy;
        valid1 := True;
        P2x := xa + s2 * ux;
        P2y := ya + s2 * uy;
        valid2 := True;
        end
      else
        If n = 1 then begin
          P1x := xa + s1 * ux;
          P1y := ya + s1 * uy;
          valid1 := True;
          P2x := P1x;
          P2y := P1y;
          valid2 := True;
          end;
      end;
    end;
  end;


procedure IntersectCircles (xm1, ym1, r1, xm2, ym2, r2 : Double;
                            var P1x, P1y, P2x, P2y     : Double;
                            var valid1, valid2         : Boolean);
  var dmx, dmy,
      a, c,
      xa, ya   : Double;
  begin                            { Das Problem wird zurückgeführt auf den    }
  dmx := xm2 - xm1;                { Schnitt eines Kreises mit einer Geraden,  }
  dmy := ym2 - ym1;                { nämlich der Chordalen beider Kreise.      }
  a   := Sqr(dmx) + Sqr(dmy);
  If a > epsilon then begin
    c := 0.5 * (Sqr(r1) - Sqr(r2) + Sqr(xm2) - Sqr(xm1) + Sqr(ym2) - Sqr(ym1));
    If Abs(dmx) > Abs(dmy) then begin
      xa := c / dmx;
      ya := 0.0;
      end
    else begin
      xa := 0.0;
      ya := c / dmy;
      end;
    { 15.10.02: Aus Gründen der Kompatibilität mit früheren Versionen
                sind die beiden Schnittpunkte S1 und S2 zweier Kreise
                k1(M1,r1) und k2(M2,r2) stets so angeordnet, daß die
                Orientierung von [S1S2] aus der Orientierung von [M1M2]
                durch eine *Rechtsdrehung* hervorgeht. Leider!!!     }
    { 20.05.05: Mit der Einführung des XML-Formats wurde dieser Zopf
                abgeschnitten. Für neue Objekte geht die Richtung von
                [S1;S2] aus der Richtung von [M1;M2] durch eine mathe-
                matisch positive *Linksdrehung* hervor !  Endlich!!!
                Die dafür notwendige Änderung findet allerdings in der
                aufzurufenden Prozedur IntersectCircleWithLine statt,
                in der mehrere Verdrehungen von Aufruf-Parametern sowie
                seltsame Vorzeichen-Festlegungen beseitigt wurden. }
    IntersectCircleWithLine(xm1, ym1, r1, xa, ya, xa - dmy, ya + dmx,
                            P1x, P1y, P2x, P2y, valid1, valid2);
    end
  else begin
    valid1 := False;
    valid2 := False;
    end;
  end;


procedure IntersectConicWithLine (co : TCoeff6; g : TVector3;
                                  var x1, y1, x2, y2 : Double;
                                  var valid1, valid2 : Boolean);
  { co enthält die Koeffizienten a, b, c, d, e, f der Kegelschnitt-
       gleichung in der Form  ax² + 2bxy + cy² + 2dx + 2dy + f = 0;
    g enthält die Koeffizienten p, q, r der Geradengleichung in
       der Form  px + qy + r = 0  mit  p = g.x, q = g.y, r = g.z  }
  var a, b, c, d, e, f, h, j, k, p, q, r : Double;
      n : Integer;
  begin
  { Daten in interne Variablen übernehmen }
  a := co[0]; b := co[1]; c := co[2]; d := co[3]; e := co[4]; f := co[5];
  h := g.X; j := g.Y; k := g.Z;  { h und j dürfen nicht beide gleich Null sein! }

  { Schnittpunkte suchen }
  If Abs(j) > Abs(h) then begin  { Dann ist sicher j <> 0 ! }
    p := a - 2*b*h/j + c*Sqr(h/j);
    q := 2*(d - (e*h + b*k)/j + c*h*k/Sqr(j));
    r := f - 2*e*k/j + c*Sqr(k/j);
    n := SolveQuadraticEquation(p, q, r, x1, x2);
    valid1 := False; valid2 := False;
    If n >= 1 then begin
      y1 := (-h*x1 - k) / j;
      valid1 := True;
      end;
    If n = 2 then begin
      y2 := (-h*x2 - k) / j;
      valid2 := True;
      end;
    end
  else begin                     { Dann ist sicher h <> 0 ! }
    p := a*Sqr(j/h) - 2*b*j/h + c;
    q := 2*(a*j*k/Sqr(h) - (b*k + d*j)/h + e);
    r := a*Sqr(k/h) - 2*d*k/h + f;
    n := SolveQuadraticEquation(p, q, r, y1, y2);
    Valid1 := False; valid2 := False;
    If n >= 1 then begin
      x1 := (-j*y1 - k) / h;
      valid1 := True;
      end;
    If n = 2 then begin
      x2 := (-j*y2 - k) / h;
      valid2 := True;
      end;
    end;
  end;


procedure IntersectConics(     co1, co2           : TCoeff6;
                           var fp                 : TFloatPointList;
                           var valid1, valid2,
                               valid3, valid4     : Boolean);
  { Algorithmus nach Hohenwarter, "GeoGebra", S. 137, Abschnitt 6.3.4
    Verwendet wird ein Algorithmus von Plücker.
    co1 und co2 enthalten die Koeffizienten a, b, c, d, e, f der Kegel-
    schnittgleichungen in der Form ax² + 2bxy + cy² + 2dx + 2dy + f = 0 }
  var a1, b1, c1, d1, e1, f1,
      a2, b2, c2, d2, e2, f2,
      u, v, w, z, s1, s2, s3,
      xm, ym, xm2, ym2,
      hdx, hdy, alpha,
      a, b, e  : Double;
      validn   : Array [1..4] of Boolean;
      g1, g2   : TVector3;
      n, ct,
      i        : Integer;
  begin
  { Interne Variablen initialisieren }
  a1 := co1[0]; b1 := co1[1]; c1 := co1[2]; d1 := co1[3]; e1 := co1[4]; f1 := co1[5];
  a2 := co2[0]; b2 := co2[1]; c2 := co2[2]; d2 := co2[3]; e2 := co2[4]; f2 := co2[5];
  valid1 := False; valid2 := False; valid3 := False; valid4 := False;
  For i := 1 to 4 do validn[i] := False;

  { Kegelschnitt-Linearkombination mit Det = 0 konstruieren }
  u :=  a2*(Sqr(e2) - c2*f2)   + b2*(b2*f2   - e2*d2)   + d2*(c2*d2   - b2*e2  );

  v :=  a1*(c2*f2   - Sqr(e2)) + c1*(a2*f2   - Sqr(d2)) + f1*(a2*c2   - Sqr(b2)) +
     2*(e1*(b2*d2   - a2*e2)   + b1*(d2*e2   - b2*f2)   + d1*(b2*e2   - c2*d2) );

  w :=  a2*(Sqr(e1) - c1*f1)   + c2*(Sqr(d1) - a1*f1)   + f2*(Sqr(b1) - a1*c1  ) +
     2*(e2*(a1*e1   - b1*d1)   + b2*(b1*f1   - d1*e1)   + d2*(c1*d1   - b1*e1) );

  z :=  a1*(c1*f1   - Sqr(e1)) + b1*(e1*d1   - b1*f1)   + d1*(b1*e1   - c1*d1  );
  n := SolveCubicEquation(u, v, w, z, s1, s2, s3);

  If n > 0 then begin
    { Geeignetste Lösung heraussuchen }
    u := s1;
    If n > 1 then begin
      If Abs(s2) > Abs(u) then
        u := s2;
      If n > 2 then
        If Abs(s3) > Abs(u) then
          u := s3;
      end;

    { Diesen Kegelschnitt in co[2] ablegen.... }
    For i := 0 to 5 do
      co2[i] := co1[i] - u * co2[i];

    { ...und in die erzeugenden Geraden zerlegen }
    g1 := TVector3.Create(0, 0, 0);
    g2 := TVector3.Create(0, 0, 0);
    try
      GetConicParamsFromCoeff(co2, ct, xm, ym, xm2, ym2, hdx, hdy, alpha, a, b, e, g1, g2);

      If ct in [2, 3, 4, 5] then begin
        { Auch Hyperbel ( ct = 5 ) als "fast zerfallend" zulassen; dann
            Asymptoten als Erzeugende interpretieren !
          Die gefundenen Erzeugenden mit dem ersten Kegelschnitt schneiden }
        IntersectConicWithLine(co1, g1, fp[0].x, fp[0].y, fp[1].x, fp[1].y,
                               valid1, valid2);
      If ct <> 3 then
        IntersectConicWithLine(co1, g2, fp[2].x, fp[2].y, fp[3].x, fp[3].y,
                               valid3, valid4);
      end;
    finally
      g2.Free;
      g1.Free;
    end; { of try }
    end; { of if }
  end;


procedure IntersectRectangleWithLine (Rect: TRect; X1, Y1, X4, Y4: Double;
                                      var x2, y2, x3, y3: Double;
                                      var valid2, valid3: Boolean);

  { berechnet die Schnittpunkte P2(x2|y2) und P3(x3|y3) der Strecke von
    P1(x1|y1) nach P4(x4|y4) mit dem Rechteck Rect; P1 und P4 sollten
    verschieden sein.

    Die Punkte P2 und P3 sind auf der Strecke P1P4 angeordnet:
    P1, P2, P3, P4.
    valid2 wird genau dann TRUE gesetzt, wenn die Strecke P1P2 auf P1P4,
                    aber außerhalb von Rect liegt. Ist es FALSE, dann liegt
                    also P1 innerhalb von Rect. (P2 ist dann ungültig.)
    valid3 wird genau dann TRUE gesetzt, wenn die Strecke P3P4 auf P1P4,
                    aber außerhalb von Rect liegt. Ist es FALSE, dann liegt
                    also P4 innerhalb von Rect. (P3 ist dann ungültig.)         }

  type calc   = Record
                  xe, ye,             { Rechtecks-Ecke                                            }
                  s,                  { Pseudo-Abstand dieser Ecke von der Strecke (X1|Y1)(X4|Y4) }
                  xs, ys  : Double;   { Schnittpunkt der Strecke (X1|Y1)(X4|Y4) mit der Strecke   }
                                      {   von der i-ten zur (i+1)-ten Ecke                        }
                  s_valid : Boolean;  { Gültigkeit des Schnittpunkts                              }
                end;

  var i, k, n : Integer;
      t       : Array [1..4] of calc;
      w,
      nx, ny  : Double;
      Pt      : TPoint;
  begin
  valid2 := False;
  valid3 := False;
  nx := Y4 - Y1;  { Normalenvektor }
  ny := X1 - X4;  {  der Strecke   }
  With Rect do begin
    t[1].xe := right; t[1].ye := top;     { "Rechts oben"  }
    t[2].xe := left;  t[2].ye := top;     { "Links oben"   }
    t[3].xe := left;  t[3].ye := bottom;  { "Links unten"  }
    t[4].xe := right; t[4].ye := bottom;  { "Rechts unten" }
    end;
  For i := 1 to 4 do
    t[i].s  := (t[i].xe - X1) * nx + (t[i].ye - Y1) * ny;
  For i := 1 to 4 do begin
    k := Succ(i Mod 4);                                   { Falls die Ecken i und k auf verschiedenen }
    If (t[i].s > 0) xor (t[k].s > 0) then begin           { Seiten von g(P1,P4) liegen :              }
      w := Abs(t[i].s) / (Abs(t[i].s) + Abs(t[k].s));
      t[i].xs := t[i].xe + w * (t[k].xe - t[i].xe);
      t[i].ys := t[i].ye + w * (t[k].ye - t[i].ye);
      t[i].s_valid :=            { wird TRUE gesetzt, wenn S zwischen P1 und P4 liegt. }
        (t[i].xs - X1) * (t[i].xs - X4) + (t[i].ys - Y1) * (t[i].ys - Y4) < 0.0;
      end
    else
      t[i].s_valid := False;
    end;

  n := 2;
  For i := 1 to 4 do             { Schnittpunkte in die Ausgangsvariablen eintragen ! }
    If t[i].s_valid then
      If n = 2 then begin
        x2 := t[i].xs;  y2 := t[i].ys;  valid2 := True;  Inc(n);  end
      else begin
        x3 := t[i].xs;  y3 := t[i].ys;  valid3 := True;  end;

  If valid3 and                  { Falls es 2 Schnittpunkte gibt :  Reihenfolge überprüfen ! }
     ((x2 - X1) * (x2 - x3) + (y2 - Y1) * (y2 - y3) > 0.0) then begin
    nx := x2; x2 := x3; x3 := nx;
    ny := y2; y2 := y3; y3 := ny;
    end
  else
    If valid2 then begin         { Falls es genau 1 Schnittpunkt gibt:        }
      Pt.x := Round(X1);
      Pt.y := Round(Y1);
      If PtInRect(Rect, Pt) then begin   { Wenn P1 innerhalb von Rect liegt,  }
        x3 := x2;                        { dann wird der einzige Schnittpunkt }
        y3 := y2;                        {   als P3 verbucht und P2 ungültig. }
        valid2 := False;
        valid3 := True;
        end;
      end;
  end;

procedure IntersectRectangleWithLine(xmin, xmax, ymin, ymax : Double; g: TVector3;
                                     var x1, y1, x2, y2: Double; var v: Boolean);
  { Rechteck: R = [ (x,y) mit (xmin<=x<=xmax) und (ymin<=y<=ymax) ]
    Gerade  : g : ax + by + c = 0  mit (a=g.x, b=g.y, c=g.z) und (a²+b²=1)
    Berechnet die Punkte P1(x1, y1) und P2(x2,y2), in denen die Gerade g die
    Seiten(geraden) von R schneidet.
    In v wird genau dann TRUE zurückgegeben, wenn die Strecke P1P2 in R liegt.}
  var cx, cy : Array[1..4] of Double;
      valid  : Array[1..4] of Boolean;
      si, ti  : Integer;    // source index, target index
  begin
  if Abs(g.Y) < MathLib.epsilon then begin
    x1 := (-g.Z - g.Y * ymin) / g.X;
    y1 := ymin;
    x2 := (-g.Z - g.Y * ymax) / g.X;
    y2 := ymax;
    v := (x1 >= xmin) AND (x1 <= xmax) AND (x2 >= xmin) and (x2 <= xmax);
    end
  else
  if Abs(g.X) < MathLib.epsilon then begin
    x1 := xmin;
    y1 := (-g.Z - g.X * xmin) / g.Y;
    x2 := xmax;
    y2 := (-g.Z - g.X * xmax) / g.Y;
    v := (y1 >= ymin) AND (y1 <= ymax) AND (y2 >= ymin) and (y2 <= ymax);
    end
  else begin
    cx[1] := xmin; cy[1] := (-g.Z - g.X * xmin) / g.Y;
    valid[1] := (cy[1] >= ymin) AND (cy[1] <= ymax);
    cx[2] := xmax; cy[2] := (-g.Z - g.X * xmax) / g.Y;
    valid[2] := (cy[2] >= ymin) AND (cy[2] <= ymax);
    cx[3] := (-g.Z - g.Y * ymin) / g.X; cy[3] := ymin;
    valid[3] := (cx[3] >= xmin) AND (cx[3] <= xmax);
    cx[4] := (-g.Z - g.Y * ymax) / g.X; cy[4] := ymax;
    valid[4] := (cx[4] >= xmin) AND (cx[4] <= xmax);
    si := 1; ti := 1;
    while (si <= 4) and (ti <= 2) do begin
      if valid[si] then begin
        if ti = 1 then begin
          x1 := cx[si];
          y1 := cy[si];
          end
        else begin
          x2 := cx[si];
          y2 := cy[si];
          end;
        Inc(ti);
        end;
      Inc(si);
      end; // of while
    v := ti > 2;
    end; // of else
  end; // of begin

procedure MoveToRectBorder(Rect: TRect; xz, yz: Double; var xmp, ymp: Double);
  { setzt voraus, daß (xz|yz) außerhalb von Rect liegt;
    wenn (xmp|ymp) innerhalb von Rect liegt, dann wird (xmp|ymp)
    in Richtung von (xz|yz) "auf" den Rand von Rect geschoben    }
  var ixz, iyz,
      ixp, iyp : Integer;
      Pt       : TPoint;
  begin
  ixp := Round(xmp);
  iyp := Round(ymp);
  If PtInRect(Rect, Point(ixp, iyp)) then begin
    ixz := Round(xz);
    iyz := Round(yz);
    Repeat
      Pt.x := (ixz + ixp) Div 2;
      Pt.y := (iyz + iyp) Div 2;
      If PtInRect(Rect, Pt) then begin
        ixp := Pt.x;
        iyp := Pt.y;
        end
      else begin
        ixz := Pt.x;
        iyz := Pt.y;
        end
    until Abs(ixp-ixz) + Abs(iyp-iyz) < 8;
    xmp := ixz;
    ymp := iyz;
    end;
  end;


function RectBorderNumber(Rect : TRect; px, py : Integer;
                          detailed: Boolean = False) : Integer;
  { Berechnet eine Kennzahl für die Lage des          6 |   2   | 3
    Punktes (px; py) relativ zum übergebenen         --- ------- --
    Rechteck R:                                       4 |   0   | 1
    innen  = 0;                                      --- ------- --
    rechts = 1; oben  = 2;                           12 |   8   | 9
    links  = 4; unten = 8;

    "detailed = True" : die Ergebnisse der Einzelprüfungen werden mit OR
                        verbunden, womit auch die Eckfelder erkannt werden.
    "detailed = False": es wird nur zwischen rechts, links, oben und unten
                        unterschieden; zurückgegeben wird die "dominierende"
                        Lage.                                               }
  begin
  Result := 0;
  If px >= Rect.Right then Result := Result OR 1
  else if px <= Rect.Left then Result := Result OR 4;
  If py <= Rect.Top then Result := Result OR 2
  else if py >= Rect.Bottom then Result := Result OR 8;
  If Not detailed then
    Case Result of
      3 : If px - Rect.Right > Rect.Top - py then Result := 1 else Result := 2;
      6 : If Rect.Left - px  > Rect.Top - py then Result := 4 else Result := 2;
      9 : If px - Rect.Right > py - Rect.Bottom then Result := 1 else Result := 8;
     12 : If Rect.Left - px  > py - Rect.Bottom then Result := 4 else Result := 8;
    end;  { of case } 
  end;

procedure RotateVector2ByAngle (     ix, iy, angle : Double;
                                 var ex, ey        : Double);
  { gilt so für ein rechtshändiges Koordinatensystem (y-Achse geht durch
    Drehung gegen den Uhrzeigersinn um pi/2 aus der x-Achse hervor),
    sodass positive Winkel zu Drehungen *gegen* den Uhrzeigersinn führen;
    der übergebene Winkel angle muss im Bogenmaß gegeben sein.           }
  var sa, ca : Extended;
  begin
  SinCos(angle, sa, ca);
  ex := ix * ca - iy * sa;
  ey := ix * sa + iy * ca;
  end;

procedure GetCentreOfGravity_2DPolyInt
                       (     n          : Integer;
                         var PointList  : TFloatPointList;
                         var xcog, ycog,
                             area       : Double);
  { Alle folgenden Algorithmen gehen von PolyFillMode = Alternate aus,
    also : doppelt umlaufene Flächenstücke zählen *nicht* zum Polygon ! }

  { Aus einer Bibliothek von "efg" mit folgendem Hinweis :
  // Calculate Centroid and Area of a polygon.
  // The Polygon array is assumed to be closed, i.e.,
  // PointList[0] = PointList[n]
  //
  // The algebraic sign of the area is positive for counterclockwise
  // ordering of vertices in the X-Y plane, and negative for
  // clockwise ordering. (Sign will be opposite in Windows graphics space.)
  //
  // Reference:  "Centroid of a Polygon" in Graphics Gems IV,
  // Paul S. Heckbert (editor), Academic Press, 1994, pp. 3-6.          }

  {
    var term, aSum,
        xSum, ySum: Double;
        i, j      : Integer;

    begin
    If n < 3 then Exit;

    aSum := 0.0;
    xSum := 0.0;
    ySum := 0.0;
    For i := 0 to n-1 do begin
      j := i + 1;
      term := PointList[i].X * PointList[j].Y - PointList[j].X * PointList[i].Y;
      aSum := aSum + term;
      xSum := xSum + (PointList[j].X + PointList[i].X) * term;
      ySum := ySum + (PointList[j].Y + PointList[i].Y) * term;
    end;

    area := 0.5 * aSum;

    If area > epsilon then begin
      xcog := xSum / (3.0 * aSum);
      ycog := ySum / (3.0 * aSum);
      end
    else begin
      xSum := 0;
      ySum := 0;
      For i := 0 to n-1 do begin
        xSum := xSum + PointList[i].X;
        ySum := ySum + PointList[i].Y;
        end;
      xcog := xSum / n;
      ycog := ySum / n;
      end;
    end;
  }
  {
    Der folgende Eigenbau ist zwar umständlicher, aber etwas leichter zu
    begreifen. Leider kann auch er den unnatürlichen Tatbestand nicht
    vermeiden, daß sich die verschiedenen Flächenanteile eines symmetrisch
    überschlagenen Polygons zum Flächeninhalt Null addieren.
  }

  var bufList : TVector3List;
      i       : Integer;
      xa, ya,
      x_cog,
      y_cog   : Double;

  procedure AddTriangleCOG (xb, yb, xc, yc : Double);
    begin
    bufList.Add(TVector3.Create(xa + xb + xc, ya + yb + yc,
                                (xa*yb-xb*ya) +
                                (xb*yc-xc*yb) +
                                (xc*ya-xa*yc)));
    end;

  begin
  bufList := TVector3List.Create;
  xa := PointList[0].X;
  ya := PointList[0].Y;
  For i := 1 to n-2 do
    AddTriangleCOG (PointList[i  ].X, PointList[i  ].Y,
                    PointList[i+1].X, PointList[i+1].Y);
  x_cog := 0;
  y_cog := 0;
  area  := 0;
  For i := 0 to Pred(bufList.Count) do begin
    x_cog := x_cog + TVector3(bufList[i]).x * TVector3(bufList[i]).z;
    y_cog := y_cog + TVector3(bufList[i]).y * TVector3(bufList[i]).z;
    area  := area  + TVector3(bufList[i]).z;
    end;
  If ABS(area) > epsilon then begin
    xcog := x_cog / (3 * area);
    ycog := y_cog / (3 * area);
    end;
  area := area / 2;    // Faktor 0.5 ergänzt am 02.10.00
  bufList.Free;
  end;


type TCornerstone = Record
                      corner  : TFloatPoint;
                      IsLeft  : Boolean;
                      section : TFloatPoint;
                      IsValid : Boolean;
                     end;

procedure GetLeftSideWindowPolygon(     ax, ay, bx, by,
                                        xmin, ymin,
                                        xmax, ymax     : Double;
                                    var PointList      : TFloatPointList);
  { Liefert das Polygon, das den links von der Geraden durch A(ax|ay)
    und B(bx|by) liegenden Teil des Fensters (xmin..xmax|ymin..ymax)
    umschließt. Dabei ist die Gerade von A nach B orientiert.        }
  var dx, dy,
      nx, ny,
      mx, my   : Double;
      CSList   : Array [0..3] of TCornerstone; { "C"orner"s"tone-"List" }
      PlusCount,
      i, k     : Integer;

  function CS(j : Integer): TCornerstone;
    begin
    Result := CSList[j Mod 4]
    end;

  begin
  { Initialisierungen }
  dx := bx - ax;
  dy := by - ay;
  mx := (ax + bx) / 2;
  my := (ay + by) / 2;
  nx := -dy;                   { Der Normalenvektor zeigt in die Halbebene }
  ny := dx;                    {    links von der Geraden durch A und B.   }
  CSList[0].corner.x := xmin;  { Linke untere Fensterecke  }
  CSList[0].corner.y := ymin;
  CSList[1].corner.x := xmax;  { Rechte untere Fensterecke }
  CSList[1].corner.y := ymin;
  CSList[2].corner.x := xmax;  { Rechte obere Fensterecke  }
  CSList[2].corner.y := ymax;
  CSList[3].corner.x := xmin;  { Linke obere Fensterecke   }
  CSList[3].corner.y := ymax;

  { Orientierung der Ecken berechnen }
  PlusCount := 0;
  For i := 0 to 3 do begin
    CSList[i].IsLeft := (CSList[i].corner.x - mx) * nx +
                        (CSList[i].corner.y - my) * ny  > 0;
    If CSList[i].IsLeft then Inc(PlusCount);
    end;

  { Schnittpunkte mit den Fensterkanten berechnen }
  For i := 0 to 3 do
    If CSList[i].IsLeft <> CS(i+1).IsLeft then
      IntersectLines(CS(i  ).corner.x, CS(i  ).corner.y,
                     CS(i+1).corner.x, CS(i+1).corner.y,
                     ax, ay, bx, by,
                     CSList[i].section.x, CSList[i].section.y,
                     CSList[i].IsValid)
    else
      CSList[i].IsValid := False;

  { Polygon-Ecken auslesen }
  If PlusCount > 0 then          { mindestens eine Ecke links von g(A,B) }
    If PlusCount < 4 then begin      { aber mindestens eine Ecke rechts  }
      SetLength(PointList, PlusCount + 2);
      i := 0;   { Index in die Corner-Liste }
      While Not (CS(i).IsLeft and CS(i).IsValid) do Inc(i);
      PointList[0] := CS(i).section;
      Repeat
        Inc(i)
      until CS(i).IsValid;
      PointList[1] := CS(i).section;
      Inc(i);
      k := 2;   { Index in die Ausgabe-Liste }
      While CS(i).IsLeft do begin
        PointList[k] := CS(i).corner;
        Inc(i);
        Inc(k);
        end;
      end
    else begin                       { alle 4 Ecken links von g(A,B)     }
      SetLength(PointList, 4);
      For i := 0 to 3 do
        PointList[i] := CS(i).corner;
      end
  else                           { alle Ecken rechts von g(A,B)          }
    SetLength(PointList, 0);
  end;


procedure MakeBezierShapingPointList(    DataPoint: TVector3List;
                                     var ShapingPt: Array of TPoint);
  var s, r, xm, ym,
      t2dx0, t2dy0,
      w12, w23,
      d12, d23   : Double;
      i          : Integer;
      v1, v2, v3 : TVector3;  { nur zum bequemeren Lesen der Points-Liste }

  procedure orthonormalize(dx, dy: Double; var r, tdx, tdy: Double);
    begin
    tdx := -dy;
    tdy :=  dx;
    r   := Hypot(tdx, tdy);
    If r > epsilon then begin
      tdx := tdx / r;
      tdy := tdy / r;
      end;
    end;

  begin

  { Innere Punkte verarbeiten : }

  For i := 1 to DataPoint.Count - 2 do begin
    v1 := DataPoint[i-1];
    v2 := DataPoint[i  ];
    v3 := DataPoint[i+1];
    s  := (v2.X-v3.X)*(v2.Y-v1.Y) - (v2.X-v1.X)*(v2.Y-v3.Y);
    If Abs(s) > epsilon then begin
      s  := 0.5 * ((v3.X-v1.X)*(v1.X-v2.X) + (v3.Y-v1.Y)*(v1.Y-v2.Y)) / s;
      xm := (v2.X+v3.X)/2 + s*(v3.Y-v2.Y);
      ym := (v2.Y+v3.Y)/2 + s*(v2.X-v3.X);
      orthonormalize(v2.X-xm, v2.Y-ym, r, t2dx0, t2dy0);
      w12 := -signed_angle(v2.X-xm, v2.Y-ym, v1.X-xm, v1.Y-ym);
      w23 := -signed_angle(v3.X-xm, v3.Y-ym, v2.X-xm, v2.Y-ym);
      d12 := 4/3*r*tan(w12/4);
      d23 := 4/3*r*tan(w23/4);
      ShapingPt[3*i - 1].X := SafeRound(TVector3(DataPoint[i]).X - d12*t2dx0);
      ShapingPt[3*i - 1].Y := SafeRound(TVector3(DataPoint[i]).Y - d12*t2dy0);
      ShapingPt[3*i    ].X := SafeRound(TVector3(DataPoint[i]).X);
      ShapingPt[3*i    ].Y := SafeRound(TVector3(DataPoint[i]).Y);
      ShapingPt[3*i + 1].X := SafeRound(TVector3(DataPoint[i]).X + d23*t2dx0);
      ShapingPt[3*i + 1].Y := SafeRound(TVector3(DataPoint[i]).Y + d23*t2dy0);
      end
    else begin  { v1, v2 und v3 sind kollinear }
      ShapingPt[3*i - 1].X := SafeRound(0.7 * TVector3(DataPoint[i]).X + 0.3 * TVector3(DataPoint[i-1]).X);
      ShapingPt[3*i - 1].Y := SafeRound(0.7 * TVector3(DataPoint[i]).Y + 0.3 * TVector3(DataPoint[i-1]).Y);
      ShapingPt[3*i    ].X := SafeRound(TVector3(DataPoint[i]).X);
      ShapingPt[3*i    ].Y := SafeRound(TVector3(DataPoint[i]).Y);
      ShapingPt[3*i + 1].X := SafeRound(0.7 * TVector3(DataPoint[i]).X + 0.3 * TVector3(DataPoint[i+1]).X);
      ShapingPt[3*i + 1].Y := SafeRound(0.7 * TVector3(DataPoint[i]).Y + 0.3 * TVector3(DataPoint[i+1]).Y);
      end;
    end;

  { Randpunkte verarbeiten : }

  ShapingPt[0].X := SafeRound(TVector3(DataPoint[0]).X);
  ShapingPt[0].Y := SafeRound(TVector3(DataPoint[0]).Y);

  If Get4thTrapezoidPoint(TVector3(DataPoint[0]).X, TVector3(DataPoint[0]).Y,
                          TVector3(DataPoint[1]).X, TVector3(DataPoint[1]).Y,
                          ShapingPt[2].X, ShapingPt[2].Y,
                          xm, ym) then begin
    ShapingPt[1].X := SafeRound(xm);
    ShapingPt[1].Y := SafeRound(ym);
    end
  else begin
    ShapingPt[1].X := SafeRound(TVector3(DataPoint[0]).X);
    ShapingPt[1].Y := SafeRound(TVector3(DataPoint[0]).Y);
    end;

  i := Pred(DataPoint.Count);
  If Get4thTrapezoidPoint(TVector3(DataPoint[i-1]).X, TVector3(DataPoint[i-1]).Y,
                          TVector3(DataPoint[i  ]).X, TVector3(DataPoint[i  ]).Y,
                          ShapingPt[3*i - 2].X, ShapingPt[3*i - 2].Y,
                          xm, ym) then begin
    ShapingPt[3*i - 1].X := SafeRound(xm);
    ShapingPt[3*i - 1].Y := SafeRound(ym);
    end
  else begin
    ShapingPt[3*i - 1].X := SafeRound(TVector3(DataPoint[i]).X);
    ShapingPt[3*i - 1].Y := SafeRound(TVector3(DataPoint[i]).Y);
    end;

  ShapingPt[3*i    ].X := SafeRound(TVector3(DataPoint[i]).X);
  ShapingPt[3*i    ].Y := SafeRound(TVector3(DataPoint[i]).Y);
  end;


function DistPt2Line (x1, y1, x2, y2, x, y: Double): Double;
  { liefert für "wohldefinierte" Geraden g((x1,y1),(x2,y2))
    den Abstand von P(x,y) zu g, sonst den Wert 10000.0      }
  var xn, yn, d : Double;
  begin
  yn := x2 - x1;
  xn := y1 - y2;
  d   := Hypot(xn, yn);
  If d > DistEpsilon then
    DistPt2Line := Abs(((x - x1) * xn + (y - y1) * yn) / d)
  else
    DistPt2Line := 10000.0;
  end;


function DistPt2Line(g: TVector3; x0, y0: Double): Double;
  { liefert für Geraden in Hesse-Form (also ax + by + c = 0
    mit a = g.x, b = g.y, c = g.z  und a² + b² = 1) den Abstand
    des Punktes P(x0, y0)                                    }
  begin
  Result := Abs(g.X * x0 + g.Y * y0 + g.Z);
  end;


function DistPt2ShortLn (x1, y1, x2, y2, x,  y: Double) : Double;
  { liefert für "wohldefinierte" Strecken s((x1,y1),(x2,y2))
    den Abstand von P(x,y) zu s, sofern der Fußpunkt des Lotes
    von P auf s in s enthalten ist, andernfalls den Abstand zum
    nächstgelegenen Streckenendpunkt                            }
  var d, dx12, dy12, dx1, dy1, dx2, dy2 : Double;
  begin
  dx12 := x2 - x1;
  dy12 := y2 - y1;
  dx1  := x  - x1;
  dy1  := y  - y1;
  If dx1 * dx12 + dy1 * dy12 >= 0 then begin
    dx2 := x2 - x;
    dy2 := y2 - y;
    If dx2 * dx12 + dy2 * dy12 >= 0 then begin
      { äquivalent zu : Result := DistPt2Line(x1, y1, x2, y2, x, y) }
      d := Hypot(dx12, dy12);
      If d > DistEpsilon then
        Result := Abs((dx1 * dy12 - dy1 * dx12) / d)
      else
        Result := Hypot(dx1, dy1);
      end
    else
      Result := Hypot(dx2, dy2)
    end
  else
    Result := Hypot(dx1, dy1);
  end;


function DistPt2OriArc(x1, y1, x2, y2, x, y: Double) : Double;
  { Gibt den Abstand der Punktes P(x|y) von dem Bogen um O(0|0)
    zurück, der in P(x1|y1) anfängt und in Q(x2|y2) endet.
    Liegt P nicht im vom Bogen beschriebenen Winkelfeld, dann wird
    der Abstand zum nächstgelegenen Bogenendpunkt zurückgegeben.
    ACHTUNG !!!  d(O;P) = d(O;Q) wird vorausgesetzt!
                 Außerdem muss das verwendete Koordinatensystem
                 rechthändig sein.                                 }
  var aa, am, ae : Double;
  begin
  Assert(IsZero(Hypot(x1, y1) - Hypot(x2, y2), 1e-6),
         'DistPt2OriArc: Invalid arc end point!');
  aa := slope_angle(x1, y1);
  ae := slope_angle(x2, y2);
  If ae < aa then ae := ae + 2*pi;
  am := slope_angle(x, y);
  If am < aa then am := am + 2*pi;
  If (am >= aa) and (am <= ae) then
    Result := Abs(Hypot(x, y) - Hypot(x1, y1))
  else
    Result := Min(Hypot(x-x1, y-y1), Hypot(x-x2, y-y2));
  end;

function are_parallel (x1, y1, x2, y2, x3, y3, x4, y4 : Double): Boolean;
  { liefert TRUE, wenn P1P2 parallel zu P3P4 ist, sonst FALSE }
  var p1, p2, z, n : Double;
  begin
  p1 := (x2 - x1) * (y4 - y3);
  p2 := (y2 - y1) * (x4 - x3);
  z  := Abs(p1 - p2);
  n  := Abs(p1) + Abs(p2);
  If n > epsilon then
    are_parallel := z / n < epsilon
  else
    are_parallel := z < epsilon;
  end;


function  CorrCoeff (data : TVector3List) : Double;
  var i, n                  : Integer;
      sx, sy, sxy, sx2, sy2 : Double;
  begin
  sx  := 0; sy  := 0; sxy  := 0;
  sx2 := 0; sy2 := 0;
  n   := data.Count;
  For i := 0 to Pred(data.Count) do
    with TVector3(data.Items[i]) do begin
      sx := sx + X;
      sy := sy + Y;
      sxy := sxy + X * Y;
      sx2 := sx2 + X * X;
      sy2 := sy2 + Y * Y;
      end;
  Result := (n*sxy - sx*sy)/SQRT((n*sx2-SQR(sx))*(n*sy2-SQR(sy)));
  end;


function  BestLineApprox (     data     : TVector3List;
                           var QualityF : Double;
                           var pt, dir  : TVector3   ): Boolean;
  { Als Qualitätsmaß wird - sofern verfügbar - der Betrag des
    Korrelationskoeffizienten herangezogen:
       QualityF liegt immer im Intervall [0..1];
       je geringer die Korrelation zwischen xi und yi ist,
       desto kleiner wird QualityF.
    25.11.06 : Um Fehler für Punktwolken zu vermeiden, die "ins Unendliche"
               greifen, sollten gar zu weit außerhalb liegenden Punkte nicht
               in die Berechnung einfließen. => Berücksichtige data[i].tag !  }
  var i, n        : Integer;
      x2, y2, dmin, dneu,
      sx, sy, sxy, sx2, sy2,   { Koordinatensummen }
      sax, say, saxy,          { x-Varianz, y-Varianz, Kovarianz }
      a, b, c, d  : Double;    { Parameter der Ausgleichsgeraden }
  begin
  If data.Count < 7 then
    Result := False
  else begin
    Result := True;

    { Punktedaten aufbereiten }
    sx  := 0;  sy  := 0; sxy  :=  0;
    sx2 := 0;  sy2 := 0; dmin := 1e100;
    n   := 0;
    For i := 0 to Pred(data.Count) do
      with TVector3(data.Items[i]) do
        If (tag >= 0) then begin  { Nur *gültige* Punkte nehmen, die  }
          sx := sx + X;           { genügend nah beim Fenster liegen! }
          sy := sy + Y;
          sxy := sxy + X * Y;
          x2 := sqr(X);
          y2 := sqr(Y);
          sx2 := sx2 + x2;
          sy2 := sy2 + y2;
          dneu := x2 + y2;
          If dneu < dmin then
            dmin := dneu;
          Inc(n);
          end;

    { Qualitätsmaß für die Approximation bestimmen }
    sax  := Abs(n * sx2 - SQR(sx));   // "Abs" wird hier nur aus numerischen
    say  := Abs(n * sy2 - SQR(sy));   // Gründen vorsichtshalber eingesetzt.
    saxy :=     n * sxy - sx * sy;
    If (sax * epsilon > say) or (say * epsilon > sax) then  // Achsenparallel?
      QualityF := 1
    else                                                    // "schräger" Fall
      if (sax > epsilon) and (say > epsilon) then
        QualityF := Abs(saxy) / SQRT(sax * say)
      else
        QualityF := 0;

    { Parameter der Ausgleichsgeraden g berechnen }
    { Zu möglichen Definitionen der Ausgleichsgeraden siehe auch:
      MNU 2006, Heft 1, S. 7ff, "Die 3., 4. und 5. Regessionsgerade" }
    c := SafeSub(sx2 * sy2, SQR(sxy));
    If Abs(c) > epsilon then begin
      a := sxy * sy - sy2 * sx;
      b := sxy * sx - sx2 * sy;
      d := Hypot(a, b);
      If Abs(d) > epsilon then
        dir.Assign(b/d, -a/d, 0)
      else   { Dies sollte eigentlich *nie* passieren ! }
        Result := False;
      end
    else begin
      If sx2 > sy2 then begin
        a := -sxy;
        b := sx2;
        end
      else begin
        a := sy2;
        b := -sxy;
        end;
      d := Hypot(a, b);
      If Abs(d) > epsilon then
        dir.Assign( b/d, -a/d, 0)
      else   { Dies sollte eigentlich *nie* passieren ! }
        Result := False;
      end;
    If Result then begin
      a := sx / n;  b := sy / n;
      GetPedalPoint(a, b, a + dir.X, b + dir.Y, 0, 0, c, d);
      pt.Assign(c, d, 0);
      end;
    end;
  end;


function  BestCircleApprox (    data     : TVector3List;
                            var QualityF : Double;
                            var pt       : TVector3;
                            var radius   : Double     ): Boolean;
  { Zur Ermittlung des Qualitätsmaßes wird die Streuung der während der
    Berechnung auftauchenden Radiuswerte herangezogen:
       QualityF liegt immer im Intervall [0..1];
       je größer die Streuung der Radiuswerte ist,
       desto kleiner wird QualityF.                                 }

   function GetNextTriangle(var a, b, c : Integer) : Boolean;
     begin
     Repeat Inc(c) until (c >= data.Count) or TVector3(data[c]).IsValid;
     Repeat Inc(b) until (b >= c) or TVector3(data[b]).IsValid;
     Repeat Inc(a) until (a >= b) or TVector3(data[a]).IsValid;
     Result := (c < data.Count) and (b < c) and (a < b);
     end;

   var mp_List    : TVector3List;
       xm, ym, r,
       s, sr, sr2 : Double;
       i1, i2, i3,
       i, k       : Integer;

   begin
   Result := False;
   If data.Count > 7 then begin
     mp_List  := TVector3List.Create;

     { Mittelpunkts-Kandidaten durch Mittelsenkrechten-Schnitte bestimmen }
     k := data.Count Div 3;
     i1 := -1;   i2 := k-1;   i3 := 2*k-1;
     While GetNextTriangle(i1, i2, i3) do
       If GetCircumMidPt(TVector3(data[i1]).X, TVector3(data[i1]).Y,
                         TVector3(data[i2]).X, TVector3(data[i2]).Y,
                         TVector3(data[i3]).X, TVector3(data[i3]).Y,
                         xm, ym) then begin
         mp_List.Add(TVector3.Create(xm, ym, 0))
         end;

     { Mittelpunktskoordinaten als Mittelwerte berechnen }
     If mp_List.Count > 3 then begin
       xm := 0; ym := 0;
       For i := 0 to Pred(mp_List.Count) do begin
         xm := xm + TVector3(mp_List[i]).X;
         ym := ym + TVector3(mp_List[i]).Y;
         end;
       xm := xm / mp_List.Count;
       ym := ym / mp_List.Count;

     { Radius und Radius-Streuung berechnen }
       k := 0;  sr := 0;  sr2 := 0;
       For i := 0 to Pred(data.Count) do
         If TVector3(data[i]).IsValid then begin
           r   := Hypot(TVector3(data[i]).X - xm, TVector3(data[i]).Y - ym);
           sr  := sr  + r;
           sr2 := sr2 + SQR(r);
           Inc(k);
           end;

     { Datenausgabe }
       If k > 1 then begin
         pt.X     := xm;
         pt.Y     := ym;
         radius   := sr / k;
         s        := SQRT(ABS(sr2 - SQR(sr)/k)/(k-1));
         QualityF := Math.Max(1 - s, 0);
         Result   := True;
         end;
       end;

     mp_List.Free;
     end;
   end;

function  BestConicApprox(    data     : TVector3List;
                          var QualityF : Double;
                          var coeff    : TCoeff6     ): Boolean;
  var Pts      : TFloatPointList;
      mp_ind   : Array [0..4] of Integer;
      mp_count : Integer;
      sd2      : Double;
      i        : Integer;

  function fillMatchPts: Boolean;
    var n, vn, dn, i : Integer;
    begin
    for i := 0 to 4 do mp_ind[i] := -1;
    try
      dn := (mp_count - 5) Div 4;
      n  := 0;
      while Not data.Item[n].IsValid do n := n + 1;
      Pts[0].x := data.GetItem(n).X;
      Pts[0].y := data.GetItem(n).Y;
      i  := 1;
      Repeat
        vn := 0;
        Repeat
          if data.Item[n].IsValid then vn := vn + 1;
          n := n + 1;
        Until vn >= dn;
        Pts[i].x := data.GetItem(n).X;
        Pts[i].y := data.GetItem(n).Y;
        i := i + 1;
      until i > 4;
      Result := True;
    except
      Result := False;
    end;
    end;

  function PtOnConicTest(x, y : Double): Double;
    // Berechnet den Wert des Terms ax² + 2bxy + cy² + 2dx + 2ey + f
    // mit (a; b; c; d; e; f) = coeff[i], i = 0..5. Dieser Term ist
    // genau dann Null, wenn der Punkt (x|y) auf dem Kegelschnitt liegt.
    begin
    Result := coeff[0] * Sqr(x) + 2 * coeff[1] * x * y + coeff[2] * Sqr(y) +
              2 * coeff[3] * x  + 2 * coeff[4] * y + coeff[5];
    end;

  begin
  Result := False;
  mp_count := data.ValidPointCount;
  SetLength(Pts, 5);
  try
    if fillMatchPts and
       GetConicCoeffFromPoints(Pts, coeff) then begin
      sd2 := 0;
      for i := 0 to Pred(mp_count) do
        if data.Item[i].IsValid then
          sd2 := sd2 + Abs(PtOnConicTest(data.Item[i].X, data.Item[i].Y));
      QualityF := max(0, 1 - sd2 / mp_count);
      Result   := True;
      end;
  finally
    Pts := Nil;
  end;
  end;



{======== Anti-Viren- und Identifikations-Prüfsummen ======================}


CONST file_check_buffer_size : Integer = $8000; { = 32 KByte }

function DecodeRegString(source: AnsiString): AnsiString;
  var p     : String;
      vb, i : Integer;   // "V"erschluesselungs-"B"yte
  begin
  For i := Length(source) downto 1 do  { Remove invalid chars }
    If Not (source[i] in ['0'..'9', 'A'..'F', 'a'..'f']) then
      Delete(source, i, 1);
  Result := '';
  vb := $93;                      { Decode data....      }
  For i := 0 to Pred(Length(source) Div 2) do begin
    p := '$' + Copy(String(source), Succ(2*i), 2);
    Result := AnsiChar(StrToInt(p) XOR Byte(vb)) + Result;
    vb := (vb + $73) and $00FF;
    end;
  end;

function EncodeRegString(source: AnsiString): AnsiString;
  var p         : String;
      vb, cc, i : Integer;
  begin
  Result := '';
  cc := 0;
  vb := $93;
  For i := Length(source) downto 1 do begin
    p := IntToHex(Ord(source[i]) XOR Byte(vb), 2);
    Result := Result + AnsiString(p);
    vb := (vb + $73) and $00FF;
    Inc(cc, 2);
    If cc > 79 then begin
      Result := Result + #13#10;
      cc := 0;
      end;
    end;
  While Result[Length(Result)-2] = #13 do
    Delete(Result, Length(Result)-2, 2);
  end;


function FileCheckSumIsOk(f_name: String): Boolean;
  var f: File;
      c: array[0..4096]of Byte;
      OldFileMode,
      i, b: Byte;
      Checksum: Cardinal;
      AmtTransferred: Integer;
  begin
  OldFileMode := FileMode;
  FileMode := fmOpenRead;
  assignfile(f, f_name);
  try
    try
      // Alte Checksumme auslesen
      reset(f, 1);
      seek(f, 0);
      BlockRead(f, c, 4096);
      move(c[$20], CheckSum, 4);  { Checksumme auslesen}
      if (c[$25] = Ord('R')) and (c[$26] = Ord('M')) then begin
        b := $A5;
        for i := 0 to 6 do
          b := b XOR Byte(c[$20 + i]);
        if b <> c[$27] then
          Checksum := 0;          { Checksumme löschen weil Prüfsumme ungültig }
        end
      else
        CheckSum := 0;            { Checksumme löschen weil Signatur ungültig  }

      // Checksumme neu berechnen
      crc32val := $A3CF7158;      { Initialisierungswert eintragen             }
      for i := $20 to $29 do      { Checksummenplatz mit Nullen überschreiben  }
        c[i] := 0;
      updatecrc(Addr(c), 4096);
      SpyOut('Checksum after first run: $%8.8x', [crc32val]);
      repeat
        BlockRead(f, c, 4096, AmtTransferred);
        updatecrc(Addr(c), AmtTransferred);
      until (AmtTransferred < 4096);

      // Gespeicherte und berechnete Checksumme vergleichen:
      Result := CheckSum = crc32val;
      SpyOut('Checksum read : $%8.8x   calculated :  $%8.8x', [CheckSum, crc32val]);
    except
      Result := False;
    end;
  finally
    Closefile(f);
    FileMode := OldFileMode;
  end; { of try }
  end;


function SetTextCheckSum(sl : TStringList) : Boolean;
  var n, i, k : Integer;
      s, p    : String;
  begin
  Result := False;
  If sl.Count > 2 then begin
    n := 37;
    For i := 2 to Pred(sl.Count) do begin
      s := sl[i];
      For k := 1 to Length(s) do
        If s[k] >= ' ' then
          n := n + Ord(s[k]);
      end;
    p := IntToStr(n Mod 97);
    s := p;
    p := IntToStr(n Mod 91);
    While Length(p) < 2 do P := '0' + p;
    s := s + p;
    p := IntToStr(n Mod 73);
    While Length(p) < 2 do P := '0' + p;
    s := s + p;
    p := IntToStr(n Mod 85);
    While Length(p) < 2 do P := '0' + p;
    s := s + p;
    sl[1] := s;
    Result := True;
    end;
  end;


function TextCheckSumIsOk (sl : TStringList) : Boolean;
  var n, i, k : Integer;
      s, p    : String;
  begin
  Result := False;
  If sl.Count > 2 then begin
    n := 37;
    For i := 2 to Pred(sl.Count) do begin
      s := sl[i];
      For k := 1 to Length(s) do
        If s[k] >= ' ' then
          n := n + Ord(s[k]);
      end;
    p := IntToStr(n Mod 97);
    s := p;
    p := IntToStr(n Mod 91);
    While Length(p) < 2 do P := '0' + p;
    s := s + p;
    p := IntToStr(n Mod 73);
    While Length(p) < 2 do P := '0' + p;
    s := s + p;
    p := IntToStr(n Mod 85);
    While Length(p) < 2 do P := '0' + p;
    s := s + p;
    Result := sl[1] = s;
    end;
  end;


function GetStatusCtrl(n: Integer): Integer;

  function GCN(c1, c2, c3, c4: AnsiChar): Integer;
    begin
    Result := (((((Ord(c1) SHL 8) OR Ord(c2)) SHL 8) OR Ord(c3)) SHL 8) + Ord(c4);
    end;

  begin
  Case n of
    1 : Result := GCN(MyMoveCursor, MyHelpCursor,
                      MyInputCursor, MyCatchCursor);
    2 : Result := GCN(MyDragCursor, MyPickCursor,
                      MyZoomCursor, MyStopCursor);
  else
    Result := 0;
  end;
  If LizenzNr > 0 then
    Result := Result XOR LizenzNr
  else
    Result := Result XOR GeoFileCRMask;
  end;

{========= String-Erweiterungen ===============================}

function GetCtrlStringFrom(n: Integer) : String;
  var i, j : Integer;
      s, z : String;
  begin
  If n < 0 then
    Result := ''
  else begin
    SetLength(s, 107);
    For i := 1 to 107 do
      s[i] := Char(65 + Random(26));
    j := (Ord(s[3]) - 60) * (1 + Ord(s[5]) Mod 3);
    z := IntToStr(n);
    s[j] := Char(75 + Length(z));
    For i := 1 to Length(z) do
      s[j+i] := Char(65 + Ord(z[i]) - Ord('0') + 10 * Random(1));
    j := 0;
    For i := 2 to 107 do
      j := j + Ord(s[i]);
    s[1] := Char(65 + j Mod 26);
    i := 1 + Random(4);
    While i < 107 do begin
      z := LowerCase(s[i]);
      s[i] := z[1];
      i := i + 1 + Random(4);
      end;
    Result := s;
    end;
  end;


function GetCtrlIntegerFrom(s: String): Integer;
  var i, j : Integer;
      z    : String;
  begin
  If Length(s) <> 107 then
    Result := -1
  else begin
    s := UpperCase(s);
    j := 0;
    for i := 2 to 107 do
      j := j + Ord(s[i]);
    If Ord(s[1]) = 65 + j Mod 26 then begin
      z := '';
      j := (Ord(s[3]) - 60) * (1 + Ord(s[5]) Mod 3);
      For i := 1 to Ord(s[j]) - 75 do
        z := z + Char((Ord(s[j + i]) - 65) Mod 10 + Ord('0'));
      Try
        Result := StrToInt(z);
      except
        Result := -2;
      end;
      end
    else
      Result := -1;
    end;
  end;


procedure Increment(var s : String);
  { erhöht das letzte Zeichen am Ende des Strings s um 1;
    falls s auf '9' endet, wird ein korrekter Übertrag gemacht:
    die letzte Stelle wird zu '0', die vorletzte wird inkrementiert.
    Gibt es keine vorletzte, wird s eine '1' vorangestellt.

    Das Inkrementieren wird selbst dann durchgeführt, wenn s gar
    nicht auf Ziffern endet. Ist s leer, wird nichts gemacht.   }

  var n : Integer;

  begin
  n := Length(s);
  If n > 0 then
    If s[n] = '9' then
      If n >= 2 then begin
        s[n] := '0';
        s[n-1] := Succ(s[n-1]);
        end
      else
        s := '10'
    else
      s[n] := Succ(s[n])
  end;


procedure FormatNumStr(var s : String);
  var pu : String;
  begin
  pu := s;
  While pu[1] = #32 do Delete(pu, 1, 1);
  If (Pos(FormatSettings.DecimalSeparator, pu) > 0) then begin
    While pu[Length(pu)] = '0' do
      Delete(pu, Length(pu), 1);
    If (pu[Length(pu)] = FormatSettings.DecimalSeparator) then
      Delete(pu, Length(pu), 1);
    end;
  s := pu;
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


procedure CheckFloat(var f : Double; default : Double);
  var buf : String;
  begin
  buf := FloatToStr(f);
  If POS('N', buf) > 0 then
    f := default;
  end;


function  AsFloat(s : String) : Double;

  procedure Subst(cc : Char);
    var i : Integer;
    begin
    For i := Length(s) downto 1 do
      If s[i] = cc then s[i] := FormatSettings.DecimalSeparator;
    end;

  begin
  Case FormatSettings.DecimalSeparator of
    ',' : Subst('.');
    '.' : Subst(',');
  end; { of case }
  AsFloat := StrToFloat(s);
  end;


procedure GetFloatPair(var s : String; var x, y : Double);
  var n, t : Integer;
      sa   : String;
  begin
  n  := Pos(' ', s);
  If n > 0 then begin
    sa := Copy(s, 1, Pred(n));
    Delete(s, 1, n);
    end
  else begin
    sa := s;
    s  := '';
    end;
  If Length(sa) > 0 then begin
    t := Pos(';', sa);
    x := AsFloat(Copy(sa, 1, Pred(t)));
    Delete(sa, 1, t);
    y := AsFloat(sa);
    end
  else begin
    x := 0;
    y := 0;
    end;
  end;


{======== Initialisierung =================================================}


initialization
sqrt2 := Sqrt(2);
euler := exp(1);
ln10  := ln(10);
Randomize;
end.
