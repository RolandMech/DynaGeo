unit GeoConic;

interface

uses Windows, Types, Classes, SysUtils, Menus, Math, Graphics, XMLIntf,
     MathLib, Utility, Declar, GlobVars, GeoTypes, GeoTransf;

type

  TGConic = class(TGCurve)
    protected
      FConicType: Integer;  { Werte :  0 =  noch nicht erkannt / ungültig
                                       1 =  Parabel
                                       2 =  Parallele Geraden
                                       3 =  Doppelgerade
                                       4 =  Schneidende Geraden
                                       5 =  Hyperbel
                                       6 =  Punkt
                                       7 =  Ellipse
                              Achtung! Der Typ muss nicht über die ganze
                                       Lebensdauer des Objekts derselbe
                                       sein! Er kann sich auch ändern.     }
      FCoeff    : TCoeff6;  { Enthält a, b, c, d, e und f für
                                ax² + 2bxy + cy² + 2dx + 2ey + f = 0  oder
                                (x, y, 1) ( a  b  d ) (x)
                                          ( b  c  e ) (y)   =   0
                                          ( d  e  f ) (1)                  }
      { Im Folgenden:  MPK = Mittelpunktskurve;        ( Typ 5, 7       )
                       PK  = Parabelkurve;             ( Typ 1          )
                       ZKS = Zerfallender Kegelschnitt ( Typ 2, 3, 4, 6 )
                       HAT = Hauptachsen-Transformation                    }
      x_m, y_m, x_n, y_n,   { MPK: Mittelpunkt; PK: Scheitel               }
                            { ZKS: Messpunkte auf den Geraden              }
      hdx, hdy,             { MPK, PK, ZKS: Verschiebung für HAT           }
      alpha,                { MPK, PK: Drehwinkel für HAT;         ZKS: -- }
      a, b,                 { MPK: Halbachsen; PK: Achsenrichtung; ZKS: -- }
      excen     : Double;   { MPK: Exzentrizität; PK: Parameter p; ZKS: -- }
      g1, g2    : TVector3; { MPK: Achsen (Ell.) bzw. Asymptoten (Hyp.)    }
                            { PK: Leitgerade und Achse;  ZKS: Geraden      }
      rotmat    : Array [1..2, 1..2] of Double;  { für HAT, nur MPK u. PK  }

      function GetIsEllipse: Boolean;
      function GetIsParabel: Boolean;
      function GetIsHyperbel: Boolean;
      function GetBorderPoints(var bp: Array of TFloatPoint): Integer;
      function GetConicPtNextTo(mx, my: Double): TVector3;
      function GetFillHandle(Ori: Boolean): HRgn; override;
      function DefaultName: WideString; override;
      function HasSameDataAs(GO: TGeoObj): Boolean; override;
      function EllipticCircumference: Double;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure GetEquationFromFFP(fx1, fy1, fx2, fy2, px, py: Double;
                                   expEllipse: Boolean);
      procedure FillList;
      procedure LoadRotationMatrix; virtual;
      procedure SetNewNameParamsIn(TextObj: TGTextObj); override;
      procedure SetNameRefPoint(nx, ny: Double);
      procedure UpdateNameCoordsIn(TextObj: TGTextObj); override;
      procedure UpdateScreenCoords; override;
      procedure DrawIt; override;
      procedure HideIt; override;
    public
      constructor Create(iObjList: TGeoObjListe; P1, P2, P3, P4, P5: TGeoObj;
                         iis_visible: Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateFromMat(iObjList: TGeoObjListe; mat: Array of Double; iis_visible: Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor CreateProtoTypFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      function    CreateProtoTypNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function    CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      destructor  Destroy; override;
      destructor  FreeBluePrint; override;
      procedure AfterLoading(FromXML : Boolean = True); override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean; override;
      function  GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean; override;
      procedure ResetOLCPList(PointList : TVector3List); override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      procedure IntersectWithLine(    g: TVector3;
                                  var X1, Y1, X2, Y2 : Double;
                                  var valid1, valid2 : Boolean);
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  IsClosedLine: Boolean; override;
      function  Includes(px, py: Double): Boolean; override;
      function  Dist(xm, ym: Double): Double; override;
      function  GetDataStr: String; override;
      function  GetValue(selector: Integer): Double; override;
      function  GetPolOf(polare: TVector3; var px, py: Double): Boolean; override;
      function  GetPolareOf(bx, by: Double; var polCoeff: TVector3): Boolean; override;
      function  GetTangentIn(bx, by: Double; var tanCoeff: TVector3): Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      function  GetInfo: String; override;
      { Die folgenden 3 Eigenschaften geben Auskunft über den *momentanen* Typ
        des Kegelschnitts. Dieser kann bei Ausartungen oder einem Kegelschnitt
        durch 5 Punkte beim Verziehen variieren ! }
      property IsEllipse: Boolean read GetIsEllipse;
      property IsParabel: Boolean read GetIsParabel;
      property IsHyperbel: Boolean read GetIsHyperbel;
      property coeff: TCoeff6 read FCoeff;
    end;

  TGOLConic = class(TGConic)
    public
      constructor Create(iObjList: TGeoObjListe; iOL: TGeoObj; iis_visible: Boolean);
      procedure UpdateParams; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function GetInfo: String; override;
    end;

  TGEllipseF = class(TGConic)
    protected
      function HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; P1, P2, P3 : TGPoint; iis_visible : Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      function  IsClosedLine: Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGEllipseS = class(TGEllipseF)
    protected
      function HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGEllipseK = class(TGEllipseF)
    protected
      function HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGParabelF = class(TGConic)
    protected
      function HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; P: TGPoint; L: TGStraightLine; iis_visible : Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGParabelT = class(TGConic)
    protected
      function HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; P1, P2: TGPoint; L1, L2: TGStraightLine; iis_visible : Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGHyperbelF = class(TGConic)
    protected
      function HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; P1, P2, P3 : TGPoint; iis_visible : Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGHyperbelA = class(TGConic)
    protected
      function HasSameDataAs(GO: TGeoObj): Boolean; override;
    public
      constructor Create(iObjList: TGeoObjListe; as1, as2: TGLongLine; P: TGPoint; iis_visible : Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGMappedConic = class(TGConic)
    public
      constructor Create(iObjList: TGeoObjListe; iPO: TGLine; iMapObj: TGTransformation; iis_visible : Boolean);
      procedure AfterLoading(FromXML: Boolean); override;
      function  IsClosedLine: Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;


implementation

uses Unit_LGS, GeoLocLines;

{-------------------------------------------}
{ TGConic's Methods Implementation          }
{-------------------------------------------}

constructor TGConic.Create(iObjList: TGeoObjListe; P1, P2, P3, P4, P5: TGeoObj;
                           iis_visible: Boolean);
  begin
  Inherited Create(iObjList, False);
  BecomesChildOf(P1);
  BecomesChildOf(P2);
  BecomesChildOf(P3);
  BecomesChildOf(P4);
  BecomesChildOf(P5);
  g1 := TVector3.Create(0, 0, 0);
  g2 := TVector3.Create(0, 0, 0);
  Points := TVector3List.Create;
  F_CCTP := True;
  If Parent.Count = 5 then begin
    UpdateParams;
    If DataValid then
      ShowsAlways := iis_visible;
    end
  else
    DataValid := False;
  end;

constructor TGConic.CreateFromMat(iObjList: TGeoObjListe; mat: Array of Double; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, False);
  F_CCTP := True;
  FCoeff[0] :=  mat[0];
  FCoeff[1] := (mat[1] + mat[3])/2;
  FCoeff[2] :=  mat[4];
  FCoeff[3] := (mat[2] + mat[6])/2;
  FCoeff[4] := (mat[5] + mat[7])/2;
  FCoeff[5] :=  mat[8];
  points := TVector3List.Create;
  g1 := TVector3.Create(0, 0, 0);
  g2 := TVector3.Create(0, 0, 0);
  If GetConicParamsFromCoeff(Coeff, FConicType, x_m, y_m, x_n, y_n,
                             hdx, hdy, alpha, a, b, excen, g1, g2) then begin
    LoadRotationMatrix;
    DataValid := True;
    ShowsAlways := iis_visible;
    end;
  end;

constructor TGConic.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var domParams,
      domPoints: IXMLNode;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  F_CCTP := True;

  domParams := DE.childNodes.findNode('params', '');
  FCoeff[0] := StrToFloat(domParams.getAttribute('a'));
  FCoeff[1] := StrToFloat(domParams.getAttribute('b'));
  FCoeff[2] := StrToFloat(domParams.getAttribute('c'));
  FCoeff[3] := StrToFloat(domParams.getAttribute('d'));
  FCoeff[4] := StrToFloat(domParams.getAttribute('e'));
  FCoeff[5] := StrToFloat(domParams.getAttribute('f'));

  dompoints := DE.childNodes.findNode('points', '');
  If domPoints <> Nil then
    points := TVector3List.CreateFromString(dompoints.nodeValue)
  else
    points := TVector3List.Create;

  g1 := TVector3.Create(0, 0, 0);
  g2 := TVector3.Create(0, 0, 0);
  end;

constructor TGConic.CreateProtoTypFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  F_CCTP := True;
  points := TVector3List.Create;
  g1     := TVector3.Create(0, 0, 0);
  g2     := TVector3.Create(0, 0, 0);
  end;

constructor TGConic.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  FConicType := (GO as TGConic).FConicType;
  end;

procedure TGConic.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  FConicType := (BluePrint as TGConic).FConicType;
  Points := TVector3List.Create;
  g1 := TVector3.Create(0, 0, 0);
  g2 := TVector3.Create(0, 0, 0);
  F_CCTP := True;
  end;

function TGConic.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var DOMParams,
      DOMPoints: IXMLNode;
      s        : String;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  DOMParams := DOMDoc.createNode('params');
  With DOMParams do begin
    setAttribute('a', FloatToStr(Coeff[0]));
    setAttribute('b', FloatToStr(Coeff[1]));
    setAttribute('c', FloatToStr(Coeff[2]));
    setAttribute('d', FloatToStr(Coeff[3]));
    setAttribute('e', FloatToStr(Coeff[4]));
    setAttribute('f', FloatToStr(Coeff[5]));
    end;
  Result.childNodes.add(DOMParams);

  DOMPoints := DOMDoc.createNode('points');
  s := points.GetContentsString;
  DOMPoints.setNodeValue(s);
  Result.childNodes.add(DOMPoints);
  end;


function TGConic.CreateProtoTypNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  end;


destructor TGConic.Destroy;
  begin
  ShowsAlways   := False;
  IntPointLists := Nil;
  g1.Free;
  g2.Free;
  Inherited Destroy;
  end;


destructor TGConic.FreeBluePrint;
  begin
  FreeAndNil(g1);
  FreeAndNil(g2);
  inherited FreeBluePrint;
  end;


function TGConic.DefaultName: WideString;
  begin
  Result := GetUniqueName('KS');
  end;


function TGConic.HasSameDataAs(GO: TGeoObj): Boolean;
  var i : Integer;
  begin
  Result := GO.ClassType = Self.ClassType;
  i := 0;
  While Result and (i < Parent.Count) do begin
    Result := GO.Parent.IndexOf(Self.Parent[i]) >= 0;
    i := i + 1;
    end;
  end;


function TGConic.Includes(px, py: Double): Boolean;
  begin
  Result := Abs(Coeff[0]*Sqr(px) + 2*Coeff[1]*px*py + Coeff[2]*Sqr(py) +
                  2*Coeff[3]*px + 2*Coeff[4]*py + Coeff[5]) < DistEpsilon;
  end;


function TGConic.GetConicPtNextTo(mx, my: Double): TVector3;
  var n       : Integer;
      xp, yp,             { Aktuelles Optimum }
      xq, yq,             { Letzter Testpunkt }
      LSD,                { "L"ast "S"mallest "D"istance }
      NSD,
      t, dt   : Double;

  function PerformStep(delta: Double): Boolean;
    begin
    Result := False;
    GetCoordsFromParam(t + delta, xq, yq);
    NSD := Hypot(xq - mx, yq - my);
    If NSD < LSD then begin
      LSD := NSD;
      xp := xq;
      yp := yq;
      t := t + delta;
      Result := True;
      end
    end;

  begin
  n := points.GetPtIndexNextToXY(mx, my);
  If (n > 0) and
     (n < Pred(points.Count)) then begin
    t  := TVector3(points[n]).Z;
    dt := (TVector3(points[Succ(n)]).Z - TVector3(points[Pred(n)]).Z) / 3;
    xp := TVector3(points[n]).X;
    yp := TVector3(points[n]).Y;
    LSD := Hypot(xp - mx, yp - my);
    While dt > ParamEpsilon do begin
      If Not PerformStep(dt) then
        PerformStep(-dt);
      dt := dt/2;
      end; { of while }
    end { of if }
  else
    t := TVector3(points[n]).Z;
  GetCoordsFromParam(t, xp, yp);
  Result := TVector3.Create(xp, yp, t);
  end;


function TGConic.GetFillHandle(Ori: Boolean): HRgn;
  var IPL     : Array of TPoint;
      NBP     : TPoint;  { "N"ext"B"order"P"oint    }
      R       : TRect;
      BCN,               { "B"order"C"hange"N"umber }
      n, i, k : Integer;

  procedure IPLAdd(edges, mask: Integer);
    var actEdge,
        PN     : Integer;   // "P"attern "N"umber
    begin
    If edges >= 0 then
      PN := edges
    else
      PN := 15 + edges;
    While PN > 0 do begin
      ActEdge := PN and mask;
      Case ActEdge of
        1 : begin IPL[n] := Point(R.Right, R.Top   ); n := n + 1; end;
        2 : begin IPL[n] := Point(R.Left,  R.Top   ); n := n + 1; end;
        4 : begin IPL[n] := Point(R.Left,  R.Bottom); n := n + 1; end;
        8 : begin IPL[n] := Point(R.Right, R.Bottom); n := n + 1; end;
      end; { of case, kein "else" }
      PN := PN and (Not mask);
      mask := mask SHL 1;
      If mask > 8 then mask := 1;
      end;
    end;

  begin
  Result := 0;
  If IsClosedLine then begin
    R := ObjList.WindowRect;
    n := 0;
    For i := 0 to High(IntPointLists) do
      n := n + High(IntPointLists[i]) + 3;
    SetLength(IPL, n + 1);

    n := 0;
    If High(IntPointLists) >= 0 then
      For i := 0 to High(IntPointLists) do begin
        For k := 0 to High(IntPointLists[i]) do begin  // Nächste Serie
          IPL[n] := IntPointLists[i,k];
          n := n + 1;
          end;
        If i < High(IntPointLists) then
          NBP := IntPointLists[i+1, 0]  // Startpunkt der nächsten Serie
        else
          NBP := IntPointLists[0, 0];   // Startpunkt der ersten Serie
        BCN := RectBorderNumber(R, NBP.X, NBP.Y) -
               RectBorderNumber(R, IPL[n-1].X, IPL[n-1].Y);
        If BCN <> 0 then begin     // Punkte dazwischenschieben
          IPLAdd(BCN, 1 SHL (Pred(Abs(BCN)) Mod 4));
          end;
        end;

    If n > 3 then                       // Rand-Polygon erzeugen
      Result := CreatePolygonRgn(IPL[0], n, PolyFillMode);
    IPL := Nil;                         // Puffer freigeben
    end;
  end;


procedure TGConic.AfterLoading(FromXML : Boolean = True);
  var NO : TGName;
      i  : Integer;
  begin
  Inherited AfterLoading(FromXML);
  If GetConicParamsFromCoeff(Coeff, FConicType, x_m, y_m, x_n, y_n,
                             hdx, hdy, alpha, a, b, excen, g1, g2) then begin
    LoadRotationMatrix;
    NO := Nil;  // Zum Namen suchen nicht HasNameObj() nehmen, weil das erst
    i  := 0;    //   nach dem ersten Aufruf von UpdateParams funktioniert !
    While (NO = Nil) and (i < Children.Count) do
      If TGeoObj(Children[i]) is TGName then
        NO := TGName(Children[i])
      else
        i := i + 1;
    If NO <> Nil then begin
      SetNameRefPoint(NO.X, NO.Y);
      end;
    end;
  end;


function TGConic.EllipticCircumference: Double;
  { Berechnet den Ellipsenumfang mit einer Näherungsformel
    von Ramanujan.  Quelle: www.mathematik.ch              }
  var k : Double;
  begin
  If a + b > 0 then begin
    k := 3*Sqr((a - b) / (a + b));
    Result := (a + b) * pi * (1 + k / (10 + Sqrt(4 - k)));
    end
  else
    Result := 0;
  end;


procedure TGConic.GetEquationFromFFP(fx1, fy1, fx2, fy2, px, py: Double;
                                     expEllipse: Boolean);
  // Berechnet die Gleichung des Kegelschnitts mit den Brennpunkten
  // F1(fx1, fy1) und F2(fx2, fy2), der durch P(px, py) verläuft.
  var za, za2, lg, mh, lpg, mph,
      g2h2, l2m2, gh2lm2, norm  : Double;
      i                         : Integer;
  begin
  try
    DataValid := True;
    If expEllipse then                    // Fall Ellipse
      za := Hypot(px - fx1, py - fy1) +
            Hypot(px - fx2, py - fy2)
    else                                  // nur Fall Hyperbel !
      za := Hypot(px - fx1, py - fy1) -
            Hypot(px - fx2, py - fy2);

    za2 := Sqr(za);
    lg  := fx2 - fx1;  mh  := fy2 - fy1;
    lpg := fx2 + fx1;  mph := fy2 + fy1;

    g2h2 := Sqr(fx1) + Sqr(fy1);
    l2m2 := Sqr(fx2) + Sqr(fy2);
    gh2lm2 := g2h2 - l2m2;

    FCoeff[0] := 4 * (Sqr(lg) - za2);
    FCoeff[1] := 4 * lg * mh;
    FCoeff[2] := 4 * (Sqr(mh) - za2);
    FCoeff[3] := 2 * (lg * gh2lm2 + lpg * za2);
    FCoeff[4] := 2 * (mh * gh2lm2 + mph * za2);
    FCoeff[5] := Sqr(gh2lm2) - 2 * (g2h2 + l2m2) * za2 + Sqr(za2);

    norm := NormingValue(coeff[0], coeff[1], coeff[2], 1e-3);
    If coeff[0] < 0 then
      norm := -norm;
    If Abs(norm) > epsilon then
      For i := 0 to 5 do
        FCoeff[i] := FCoeff[i] / norm;

    GetConicParamsFromCoeff(coeff, FConicType, x_m, y_m, x_n, y_n,
                            hdx, hdy, alpha, a, b, excen, g1, g2);
    LoadRotationMatrix;
    FillList;
    UpdateScreenCoords;
  except
    DataValid := False;
  end
  end;


function TGConic.GetBorderPoints(var bp: Array of TFloatPoint): Integer;
  { Gibt die Anzahl der gefundenen Schnittpunkte mit dem aktuellen Rand
    des logischen Zeichenbereiches zurück; bp enthält die Koordinaten
    dieser Punkte.                                                      }

  procedure GetConicXFromY(cy: Double; var x1, x2: Double; var v1, v2: Boolean);
    var n : Integer;
    begin
    n := SolveQuadraticEquation(Coeff[0], 2*(Coeff[1]*cy + Coeff[3]),
                                Coeff[2]*Sqr(cy) + 2*Coeff[4]*cy + Coeff[5], x1, x2);
    v1 := (n > 0) and (ObjList.xMin <= x1) and (x1 <= ObjList.xMax);
    v2 := (n > 1) and (ObjList.xMin <= x2) and (x2 <= ObjList.xMax);
    end;

  procedure GetConicYFromX(cx: Double; var y1, y2: Double; var v1, v2: Boolean);
    var n : Integer;
    begin
    n := SolveQuadraticEquation(Coeff[2], 2*(Coeff[1]*cx + Coeff[4]),
                                Coeff[0]*Sqr(cx) + 2*Coeff[3]*cx + Coeff[5], y1, y2);
    v1 := (n > 0) and (ObjList.yMin <= y1) and (y1 <= ObjList.yMax);
    v2 := (n > 1) and (ObjList.yMin <= y2) and (y2 <= ObjList.yMax);
    end;

  var r : Array[1..2] of Double;
      v : Array[1..2] of Boolean;
      n, i : Integer;
  begin
  n := 0;
  GetConicXFromY(ObjList.yMax, r[1], r[2], v[1], v[2]);
  For i := 1 to 2 do
    If v[i] then begin
      bp[n].x := r[i];
      bp[n].y := ObjList.yMax;
      n := n + 1;
      end;
  GetConicXFromY(ObjList.yMin, r[1], r[2], v[1], v[2]);
  For i := 1 to 2 do
    If v[i] then begin
      bp[n].x := r[i];
      bp[n].y := ObjList.yMin;
      n := n + 1;
      end;
  GetConicYFromX(ObjList.xMax, r[1], r[2], v[1], v[2]);
  For i := 1 to 2 do
    If v[i] then begin
      bp[n].x := ObjList.xMax;
      bp[n].y := r[i];
      n := n + 1;
      end;
  GetConicYFromX(ObjList.xMin, r[1], r[2], v[1], v[2]);
  For i := 1 to 2 do
    If v[i] then begin
      bp[n].x := ObjList.xMin;
      bp[n].y := r[i];
      n := n + 1;
      end;
  Result := n;
  end;


procedure TGConic.FillList;

  procedure InitializeList;
    var bp   : Array of TFloatPoint;
        t    : Array of Double;
        flag : Boolean;
        tp   : Double;
        n, i : Integer;
    begin
    SetLength(bp, 4);
    n := GetBorderPoints(bp);
    If n > 0 then begin
      SetLength(t, n);
      For i := 0 to Pred(n) do
        GetParamFromCoords(bp[i].x, bp[i].y, t[i]);
      Repeat
        flag := False;
        For i := 0 to n - 2 do
          If t[i+1] < t[i] then begin
            tp := t[i]; t[i] := t[i+1]; t[i+1] := tp;
            flag := True;
            end;
      until Not flag;
      Case n of
        2 : With points do begin
              Reset2StandardList(t[0], t[1], 40);
              AddExtraEndPoints;
              end;
        3 : With points do begin
              Reset2StandardList(t[0], t[2], 40);
              If (t[0] < 0.5) and (0.5 < t[1]) then
                InsertZSorted(0, 0, 0.5);
              AddExtraEndPoints;
              end;
        4 : With points do begin
              Reset2StandardList(t[0], t[1], 20);
              Add2StandardList  (t[2], t[3], 20);
              InsertZSorted(0, 0, t[1] - ParamEpsilon);
              InsertZSorted(0, 0, (t[1] + t[2])/2, -2);
              InsertZSorted(0, 0, t[2] + ParamEpsilon);
              AddExtraEndPoints;
              end;
      else
        Points.Reset2StandardList(ParamEpsilon, 1-ParamEpsilon, 50);
        Points.AddExtraEndPoints;
      end;
      t := Nil;
      end { of if }
    else
      Points.Reset2StandardList(ParamEpsilon, 1-ParamEpsilon, 50);
    bp := Nil;
    end;

  procedure AddLineSegment(g: TVector3);
    var xs, ys : Double;
        ok     : Boolean;
        cnt    : Integer;
        b      : TVector3;
    begin
    cnt := 0;
    b := TVector3.Create(1, 0, -ObjList.xMin);
    try
      IntersectLines(g, b, xs, ys, ok);
      If ok and (ys >= ObjList.yMin) and (ys <= ObjList.yMax) then begin
        Points.Add(TVector3.Create(xs, ys, 0));
        Inc(cnt);
        end;
      b.Z := -ObjList.xMax;
      IntersectLines(g, b, xs, ys, ok);
      If ok and (ys >= ObjList.yMin) and (ys <= ObjList.yMax) then begin
        Points.Add(TVector3.Create(xs, ys, 0));
        Inc(cnt);
        end;
      If cnt < 2 then begin
        b.Assign(0, 1, -ObjList.yMin);
        IntersectLines(g, b, xs, ys, ok);
        If ok and (xs >= ObjList.xMin) and (xs <= ObjList.xMax) then begin
          Points.Add(TVector3.Create(xs, ys, 0));
          Inc(cnt);
          end;
        If cnt < 2 then begin
          b.Z := -ObjList.yMax;
          IntersectLines(g, b, xs, ys, ok);
          If ok and (xs >= ObjList.xMin) and (xs <= ObjList.xMax) then begin
            Points.Add(TVector3.Create(xs, ys, 0));
            end;
          end;
        end;
    finally
      b.Free;
    end;
    end;

  procedure CalculateOLPoint(v : TVector3);
    begin
    GetCoordsFromParam(v.Z, v.X, v.Y);
    v.tag := ObjList.LogWinKnows(v.X, v.Y);
    end;

  procedure InsertPointsBetween(v0, v1, v2: TVector3);
    { Ergänzt die Punktliste rekursiv um weitere Punkte, so dass die
      Richtungsänderung aufeinanderfolgender Punktpaare nicht zu groß
      ist. Die Routine ist von TGLocLine übernommen !

      29.01.11 :  Wegen Bug-Meldung von Christoph Wehren (Email 28.01.11)
                  wurden "vorsichtshalber" eingebaute "try-finally"-Konstruk-
      tionen wieder entfernt, welche die (scheinbar!) lokalen Variablen vm
      und vn wieder aus dem Speicher entfernten. Dadurch wurden Lücken in die
      "points"-Liste gerissen, die später zu Zugriffsfehlern führten.        }
    var vm, vn : TVector3;
        dist   : Double;
    begin
    dist := Hypot(v1.X-v0.X, v1.Y-v0.Y) + Hypot(v2.X - v1.X, v2.Y - v1.Y);
    If (dist > ObjList.PixelDist * 5) and
       (Abs(v2.Z-v0.Z) > ParamEpsilon) and
       TooMuchBending(v0, v1, v2) then begin
      vm := TVector3.Create(0, 0, (v0.Z + v1.Z)/2);
      CalculateOLPoint(vm);
      points.InsertZSorted(vm);

      vn := TVector3.Create(0, 0, (v1.Z + v2.Z)/2);
      CalculateOLPoint(vn);
      points.InsertZSorted(vn);

      If (v0.tag > 0) or (vm.tag > 0) or (v1.tag > 0) then
        InsertPointsBetween(v0, vm, v1);
      end;
    end;

  procedure CompleteList;
    { Ergänzt die Points-Liste um die X- und Y-Koordinaten.
      14.01.07 :  In ht[] wird eine Statistik geführt, um die Anzahl der
                  Punkte weit außerhalb des Fensters zu bestimmen. Gibt es
      zu viele davon, aber wenigstens *einen* gültigen Punkt innerhalb des
      Fensters, werden rund um diesen Punkt weitere Kurvenpunkte gesucht und
      eingefügt. Dieser Krisenfall tritt ein für Hyperbeln, die "fast"
      Parabeln sind. Dann ist die Parametrisierung der Hyperbel so, dass die
      Stützpunkte leider weit weg vom Mittelpunkt der Kurve gesetzt werden. }

    var ht : Array [-1..1] of Integer;
        i  : Integer;
    begin
    For i := -1 to 1 do ht[i] := 0;
    For i := 0 to Pred(Points.Count) do
      try
        With TVector3(Points[i]) do begin
          GetCoordsFromParam(Z, X, Y);
          tag := ObjList.LogWinKnows(X, Y);
          Inc(ht[tag]);
          end;
      except
        TVector3(Points[i]).IsValid := False;
      end;
    If ht[-1] > Points.Count Div 3 then begin
      SpyOut('Verdächtige Kegelschnitt-Kurve!', []);
      If ht[1] > 0 then begin   // es gibt mindestens einen gültigen Punkt!
        i := 0;
        While (i < Points.Count) and
              (TVector3(Points[i]).tag < 1) do
          Inc(i);
        If i = 0 then i := 1;
        While (i < Pred(Points.Count)) and (TVector3(Points[i]).tag = 1) do begin
          InsertPointsBetween(Points[i-1], Points[i], Points[i+1]);
          Repeat
            i := i + 1
          until (i = Points.Count) or (TVector3(Points[i]).tag = 1);
          end;
        end;
      end;
    end;

  procedure Stretch2Border(infparam: Double);
    { 06.12.2006 : Ergänzt die Points-Liste um einen ungültigen Punkt,
                   der die durch "infparam" gegebene Asymptoten-Richtung
                   repräsentiert;
                   sorgt außerdem dafür, dass die beiden Hyperbel-Ast-
                   Enden, die zu dieser Asymptote gehören, mit je einem
                   Punkt *außerhalb* des sichtbaren Fensters enden, so
                   dass die Hyperbel innerhalb des Fensters stets
                   *vollständig* gezeichnet wird.                      }
    var n : Integer;
        p : Double;
    begin
    n := Points.InsertZSorted(0, 0, infparam, -2);
    While (n > 0) and
          (TVector3(Points[n-1]).tag < 1) do
      n := n - 1;
    If n > 1 then
      While TVector3(Points[n]).tag <> 0 do begin
        p := (TVector3(Points[n-1]).Z + TVector3(Points[n]).Z) / 2;
        Points.InsertZSorted(0, 0, p);
        With TVector3(Points[n]) do begin
          GetCoordsFromParam(Z, X, Y);
          tag := ObjList.LogWinKnows(X, Y);
          If tag > 0 then n := n + 1;
          end;
        end;
    n := Points.GetPtIndexWithZequals(infparam);
    While (n < Pred(Points.Count)) and
          (TVector3(Points[n+1]).tag < 1) do
      n := n + 1;
    If n < Pred(Points.Count) then
      While TVector3(Points[n]).tag <> 0 do begin
        p := (TVector3(Points[n+1]).Z + TVector3(Points[n]).Z) / 2;
        Points.InsertZSorted(0, 0, p);
        With TVector3(Points[n+1]) do begin
          GetCoordsFromParam(Z, X, Y);
          tag := ObjList.LogWinKnows(X, Y);
          If tag <= 0 then n := n + 1;
          end;
        end;
    end;

  begin { of FillList }
  Case FConicType of
    1 : begin   // Parabel
        InitializeList;
        CompleteList;
        end;
    5 : begin  // Hyperbel
        Points.Reset2StandardList(ParamEpsilon, 1-ParamEpsilon, 61);
        CompleteList;
        Stretch2Border(0.25);
        Stretch2Border(0.75);
        end;
    7 : begin  // Ellipse
        Points.Reset2StandardList(0, 1-ParamEpsilon, Max(50, Round(a + b)));
        CompleteList;
        end;
    2,         // Parallele Geraden
    4 : begin  // Schneidende Geraden
        Points.Clear;
        AddLineSegment(g1);
        AddLineSegment(g2);
        end;
    3 : begin  // Doppelgerade
        Points.Clear;
        AddLineSegment(g1);
        end;
    6 : begin  // Singulärer Punkt
        Points.Clear;
        Points.Add(TVector3.Create(x_m, y_m, 0.5));
        end;
  else
    Points.Clear;     // für FConicType = 0, also ungeklärte Verhältnisse
  end; { of case }
  SetNameRefPoint(X, Y);
  end; { of FillList }


procedure TGConic.IntersectWithLine(    g: TVector3;
                                    var X1, Y1, X2, Y2 : Double;
                                    var valid1, valid2 : Boolean);
  begin
  IntersectConicWithLine(Coeff, g, X1, Y1, X2, Y2, valid1, valid2);
  end;


procedure TGConic.LoadRotationMatrix;
  // Lädt die Matrix mit den Koeffizienten der Drehung, die
  // von der achsenparallelen Lage in die originale Lage des
  // Kegelschnittes führt, daher "-alpha", also inverse HAT!
  begin
  rotmat[1, 1] :=   cos(-alpha);
  rotmat[1, 2] :=   sin(-alpha);
  rotmat[2, 1] := - rotmat[1, 2];
  rotmat[2, 2] :=   rotmat[1, 1];
  end;


function TGConic.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  { Der Kegelschnitt wird über das Intervall [0..1] parametrisiert.
    Dabei entspricht jedem Parameterwert t aus [0..) genau *ein* Punkt;
    die zu t=0 und t=1 gehörenden Punkte werden identifiziert, in Analogie
    zum Kreis, der sich nach einer Drehung um 2*pi auch wieder schließt.
    Intern wird das Intervall [0..1] mit der ui2gt-Funktion über ganz R
    ausgedehnt, um auch die entarteten Fälle korrekt parametrisieren zu
    können.                                                              }
  var p, s, tx, ty, p2: Double;
      pValid          : Boolean;
  begin
  Result := False;
  Case FConicType of           // Erst die Entartungen abarbeiten,....
    2,
    4 : If IsNan(param) then
          Exit
        else
          If param > 0.5 then begin
            s := ui2gt(4*param - 3);
            Result := GetLinePtFromParam(g2, s, x_n, y_n, px, py);
            end
          else begin
            s := ui2gt(4*param - 1);
            Result := GetLinePtFromParam(g1, s, x_m, y_m, px, py);
            end;
    3 : If IsNan(param) then
          Exit
        else begin
          s := ui2gt(2*param - 1);
          Result := GetLinePtFromParam(g1, s, x_m, y_m, px, py);
          end;
    6 : begin
        px := x_m;
        py := y_m;
        Result := DataValid;
        end;
  else begin { of outer case }   // ...dann die Standardfälle:
    If (Not IsNan(param)) and (param > epsilon) and (param < 1 - epsilon) then begin
      p  := tan(pi*(param - 0.5));
      p2 := Sqr(p);
      pValid := True;
      end
    else begin
      p  := 0;
      p2 := 0;
      pValid := False;
      end;
    Case FConicType of   { t sei der übergebene, originale param-Wert : }
      1 : If pValid then begin         { Parabel :                   }
            tx := excen * p;                 { Scheitel bei t=0.5    }
            ty := excen/2*p2;
            end
          else begin
            tx := 0;                         { t=0 (und t=1) :       }
            ty := 0;                         {   Fernpunkt!          }
            end;
      5 : If pValid then               { Hyperbel :                  }
            If Abs(1 - p2) > epsilon then begin
              tx := a * (1 + p2) / (1 - p2); { Ein Scheitel liegt    }
              ty := 2 * b * p / (1 - p2);    { bei t=0.5 ...         }
              end
            else begin     { Eigentlich liegen bei t = 0.25 und      }
              tx := a;     { t = 0.75  zwei Definitions-Lücken vor!  }
              ty := 0;     { Ersatzweise wird aber der Hauptscheitel }
              end          { zurückgegeben.                          }
          else begin
            tx := -a;                        { ... der andere bei    }
            ty :=  0;                        {       t=0 (und t=1)   }
            end;
      7 : If pValid then begin         { Ellipse :                   }
            tx := a * (1 - p2) / (1 + p2);   { 1. Hauptscheitel      }
            ty := 2 * b * p / (1 + p2);      {   bei t = 0.5         }
            end            { Nebenscheitel bei t = 0.25 und t = 0.75 }
          else begin
            tx := -a;                        { 2. Hauptscheitel bei  }
            ty :=  0;                        {   t = 0 ( und t = 1 ) }
            end;
    else { of inner case }
      { Sollte eigentlich nie passieren: Dummy für den Fall "FConicType = 0"; }
      tx := 0;          { führt bei Mittelpunkts-Kurven effektiv zur }
      ty := 0;          { Rückgabe der Koordinaten des Mittelpunkts  }
    end; { of inner case }
    tx := tx + hdx;               // Inverse HAT !
    ty := ty + hdy;
    px := rotmat[1, 1] * tx + rotmat[2, 1] * ty;
    py := rotmat[1, 2] * tx + rotmat[2, 2] * ty;
    Result := True;
  end; { of case-else-begin }
  end; { of outer case }
  end;


function TGConic.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var tx, ty,
      tx2, ty2,
      t, p : Double;
      v       : TVector3;
  begin
  Result := False;
  If FConicType in [2, 3, 4, 6] then
    Case FConicType of
      2,
      4 : If GetPedalPoint(g1, px, py, tx,  ty ) and
             GetPedalPoint(g2, px, py, tx2, ty2) then
            If Sqr(px - tx ) + Sqr(py - ty ) <=
               Sqr(px - tx2) + Sqr(py - ty2) then begin
              Result := GetLineParamFromPt(g1, x_m, y_m, tx, ty, t);
              param := (gt2ui(t) + 1) / 4;    // liegt in  (0 ; 0.5)
              end
            else begin
              Result := GetLineParamFromPt(g2, x_n, y_n, tx2, ty2, t);
              param := (gt2ui(t) + 3) / 4;    // liegt in  (0.5; 1)
              end;
      3 : If GetPedalPoint(g1, px, py, tx, ty) and
             GetLineParamFromPt(g1, x_m, y_m, tx, ty, t) then begin
            param := (gt2ui(t) + 1) / 2;
            Result := True;
            end;
      6 : begin
          If (param < 0) or (param > 1) then    { Punkt }
            param := 0.5;
          Result := True;
          end;
    end
  else begin   // FConicType in [0, 1, 5, 7]
    If Not Includes(px, py) then begin
      v := Nil;
      try
        v := GetConicPtNextTo(px, py);
        If v.IsValid then begin
          px := v.X;
          py := v.Y;
          end;
      finally
        v.Free;
      end; { of try }
      end;
    tx := rotmat[1, 1] * px + rotmat[1, 2] * py - hdx;    // originale HAT !
    ty := rotmat[2, 1] * px + rotmat[2, 2] * py - hdy;
    Case FConicType of
      1 : If Abs(excen) > epsilon then        { Parabel }
            param := arctan(tx / excen) / pi + 0.5
          else
            param := -1;
      5 : If Abs(tx) > a + epsilon then begin { Hyperbel }
            p := Sqrt((tx - a) / (tx + a));
            If sign(tx) = sign(ty) then
              param := arctan(p) / pi + 0.5
            else
              param := arctan(-p) / pi + 0.5;
            end
          else begin
            If tx > a - epsilon then
              param := 0.5
            else
              If tx < -a + epsilon then
                If sign(ty) <= 0 then
                  param := 0
                else
                  param := 1
              else
                param := NAN;
            end;
      7 : If Abs(a+tx) > epsilon then begin   { Ellipse }
            If a > tx then
              p := Sqrt(Abs((a - tx) / (a + tx)))
            else
              p := 0;
            If Sign(ty) > 0 then
              param := arctan(p) / pi + 0.5
            else
              param := arctan(-p) / pi + 0.5;
            end
          else begin
            If Sign(ty) <= 0 then
              param := 0
            else
              param := 1;
            end;
    end; { of case }
    Result := True;
    end; { of else }
  end;

function TGConic.GetLinePtWithMinMouseDist(xm, ym, quant: Double;
                  var px, py: Double): Boolean;
  begin
  Result := Inherited GetLinePtWithMinMouseDist(xm, ym, quant, px, py);
  end;

function TGConic.GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean;
  var circle : TCoeff6;
      fp     : TFloatPointList;
      _X, _Y : Double;
      v1, v2,
      v3, v4 : Boolean;

  procedure check(v: Boolean; lx, ly: Double);
    begin
    if v and (Hypot(lx - px, ly - py) < Hypot(_X - px, _Y - py)) then begin
      _X := lx;
      _Y := ly;
      end;
    end;

  begin
  circle[0] := 1;
  circle[1] := 0;
  circle[2] := 1;
  circle[3] := -EP.X;
  circle[4] := -EP.Y;
  circle[5] := Sqr(EP.X) + Sqr(EP.Y) - Sqr(r);
  SetLength(fp, 4);
  MathLib.IntersectConics(coeff, circle, fp, v1, v2, v3, v4);
  _X := 1e10;
  _Y := 1e10;
  check(v1, fp[0].x, fp[0].y);
  check(v2, fp[1].x, fp[1].y);
  check(v3, fp[2].x, fp[2].y);
  check(v4, fp[3].x, fp[3].y);
  Result := Hypot(_X, _Y) < 1e10;
  If Result then begin
    px := _X;
    py := _Y;
    end;
  fp := Nil;
  end;


procedure TGConic.ResetOLCPList(PointList : TVector3List);
  begin
  PointList.Reset2StandardList(0, 1-ParamEpsilon, 40);
  end;


procedure TGConic.SaveState;
  begin
  Inherited SaveState;
  With Old_Data do begin
    push(@a, SizeOf(a));
    push(@b, SizeOf(b));
    push(@alpha, SizeOf(alpha));
    push(@FConicType, SizeOf(FConicType));
    push(@excen, SizeOf(excen));
    push(@rotmat, SizeOf(rotmat));
    push(@x_m, SizeOf(x_m));
    push(@y_m, SizeOf(y_m));
    push(@x_n, SizeOf(x_n));
    push(@y_n, SizeOf(y_n));
    push(@g1, SizeOf(g1));
    push(@g2, SizeOf(g2));
    push(@hdx, SizeOf(hdx));
    push(@hdy, SizeOf(hdy));
    push(@FCoeff, SizeOf(FCoeff));

    end;
  end;


procedure TGConic.RestoreState;
  begin
  With Old_Data do begin
    pop(@FCoeff);
    pop(@hdy);
    pop(@hdx);
    pop(@g2);
    pop(@g1);
    pop(@y_n);
    pop(@x_n);
    pop(@y_m);
    pop(@x_m);
    pop(@rotmat);
    pop(@excen);
    pop(@FConicType);
    pop(@alpha);
    pop(@b);
    pop(@a);
    end;
  Inherited RestoreState;
  end;

procedure TGConic.SetNameRefPoint;
  var cpnn : TVector3;   // "c"onic "p"oint "n"ext to "n"ame
  begin
  Case FConicType of
    1, 5, 7 : begin
              cpnn := GetConicPtNextTo(nx, ny);
              X := cpnn.X;
              Y := cpnn.Y;
              cpnn.Free;
              end;
    2       : begin
              X := (x_m + x_n) / 2;
              Y := (y_m + y_n) / 2;
              end;
    3       : GetPedalPoint(g1, 0, 0, X, Y);
  else
    X := x_m;
    Y := y_m;            
  end; { of case }
  end;


procedure TGConic.SetNewNameParamsIn(TextObj: TGTextObj);
  begin
  SetNameRefPoint(TextObj.X, TextObj.Y);
  TextObj.rConst := TextObj.X - X;
  TextObj.sConst := TextObj.Y - Y;
  end;

procedure TGConic.UpdateNameCoordsIn(TextObj: TGTextObj);
  begin
  With TextObj do begin
    X := Self.X + rConst;
    Y := Self.Y + sConst;
    end;
  end;

procedure TGConic.UpdateParams;
  var PL : TFloatPointList;
      i  : Integer;
  begin
  DataValid := True;
  if Parent.Count = 5 then begin
    SetLength(PL, 5);
    For i := 0 to 4 do
      If TGPoint(Parent[i]).DataValid then begin
        PL[i].x := TGPoint(Parent[i]).X;
        PL[i].y := TGPoint(Parent[i]).Y;
        end
      else
        DataValid := False;
    DataValid := DataValid and
                 GetConicCoeffFromPoints(PL, FCoeff) and
                 GetConicParamsFromCoeff(Coeff, FConicType, x_m, y_m, x_n, y_n,
                                         hdx, hdy, alpha, a, b, excen, g1, g2);
    PL := Nil;
    end;
  if DataValid then begin
    LoadRotationMatrix;
    FillList;
    UpdateScreenCoords;
    end;
  end;


procedure TGConic.UpdateScreenCoords;
  var sx, sy     : Double;
      VList,
      VList2     : TVector3List;
      inside,
      outside    : Boolean;    // = True <=> Es gibt einen Punkt außerhalb !
      in_tag,                  // Tag für "Punkt liegt *im* Fenster"
      fpo,                     // "f"irst "p"oint "o"utside
      lpo,                     // "l"ast  "p"oint "o"utside
      imax,                    // letzter gültiger Verarbeitungs-Index
      n, m, i, k : Integer;

  procedure PointListAdd(pt: TVector3);
    var s_x, s_y : Double;
    begin
    ObjList.GetFWinCoords(pt.X, pt.Y, s_x, s_y);
    VList.Add(TVector3.Create(s_x, s_y, pt.Z));
    end;

  begin
  IntPointLists := Nil;
  DataCanShow   := False;
  i := 0;
  k := 0;    { Letzter gültiger Index von IntPointLists }
  VList := TVector3List.Create;
  Case FConicType of
    2 : begin
        SetLength(IntPointLists, 1, 4);
        For i := 0 to 3 do begin
          PointListAdd(TVector3(points[i]));
          IntPointLists[0,i] := Point(SafeRound(TVector3(VList[i]).X),
                                      SafeRound(TVector3(VList[i]).Y));
          end;
        DataCanShow := True;
        end;

    4 : begin
        If Points.Count > 0 then begin
          SetLength(IntPointLists, 1, 4);
          For i := 0 to 3 do
            PointListAdd(TVector3(points[i]));

          For i := 0 to 3 do
            IntPointLists[0,i] := Point(SafeRound(TVector3(VList[i]).X),
                                        SafeRound(TVector3(VList[i]).Y));
          DataCanShow := True;
          end
        else
          DataCanShow := False;
        end;

    7 : begin
        outside := False;
        inside  := False;
        For i := 0 to Pred(Points.Count) do begin
          ObjList.GetFWinCoords(TVector3(Points[i]).X, TVector3(Points[i]).Y, sx, sy);
          If PtInRect(ObjList.WindowRect, Point(SafeRound(sx), SafeRound(sy))) then begin
            in_tag  := 1;        // Pkt im Fenster
            inside  := True
            end
          else begin
            in_tag  := 0;        // Pkt außerhalb des Fensters
            outside := True;
            end;
          VList.Add(TVector3.Create(sx, sy, 0, in_tag));
          end;
        If inside then begin     // Es gibt Punkte *im* Fenster
          If outside then begin    // Es gibt auch Punkte *außerhalb*

            VList2 := TVector3List.Create;
            i := 0;
            While (i < VList.Count) and (TVector3(VList[i]).tag = 1) do
              i := i + 1;
            // i zeigt jetzt auf den ersten Punkt außerhalb des Fensters
            imax := i + VList.Count;    // letzter gültiger Index
            While i < imax do begin
              While (i < imax) and ((VList.RLV[i+1]).tag = 0) do
                i := i + 1;
              // i zeigt jetzt auf den letzten Punkt außerhalb des Fensters
              If i < imax then begin
                lpo := i;
                i := i + 1;
                // Jetzt zeigt i auf den ersten Punkt innerhalb des Fensters
                While (i < imax) and ((VList.RLV[i]).tag = 1) do
                  i := i + 1;
                // Nun zeigt i auf den ersten Punkt außerhalb des Fensters
                If i <= imax then begin
                  fpo := i;
                  n := fpo - lpo + 1;
                  SetLength(IntPointLists, k+1);
                  SetLength(IntPointLists[k], 3 * n - 2);
                  For m := lpo to fpo do
                    VList2.Add(VList.RLV[m]);
                  MakeBezierShapingPointList(VList2, IntPointLists[k]);
                  VList2.WipeOut;
                  Inc(k);
                  end;
                end;
              end;
            DataCanShow := True;
            VList2.Free;
            end
          else begin               // Es gibt *nur* Punkte im Fenster
            SetLength(IntPointLists, 1);
            SetLength(IntPointLists[0], 3 * VList.Count - 2);
            MakeBezierShapingPointList(VList, IntPointLists[0]);
            DataCanShow := True;
            end;
          end;  
        end;
  else
    While i < points.Count do begin
      { Zunächst *alle* Punkte außerhalb des Fensters überspringen }
      While (i < points.Count) and
            Not (TVector3(points[i]).IsValid and
                 ObjList.LogWinContains(TVector3(points[i]).X, TVector3(points[i]).Y)) do
        Inc(i);

      If (i > 0) and             { Letzten Punkt außerhalb des Fensters }
         TVector3(points[i-1]).IsValid then    { *vor* die Serie setzen }
        PointListAdd(points[i-1]);

      While (i < points.Count) and          { Punkte-Serie *im* Fenster }
            (TVector3(points[i]).IsValid and
            ObjList.LogWinContains(TVector3(points[i]).X,
                                   TVector3(points[i]).Y)) do begin
        PointListAdd(points[i]);
        Inc(i);
        end;

      If (i < points.Count) and  { Ersten Punkt außerhalb des Fensters  }
         TVector3(points[i]).IsValid then   { *hinter* die Serie setzen }
        PointListAdd(points[i]);

      If VList.Count > 2 then begin     { Stützpunkt-Liste erzeugen.... }
        SetLength(IntPointLists, k+1);
        SetLength(IntPointLists[k], VList.Count * 3 - 2);
        MakeBezierShapingPointList(VList, IntPointLists[k]);
        DataCanShow := True;
        Inc(k);
        end;
      VList.Clear;
      end;
  end; { of case }
  VList.Free;
  end;


procedure TGConic.DrawIt;
  var i, k : Integer;

  procedure ShowParams;
    begin
    With ObjList.TargetCanvas do begin
      Brush.Color := clWhite;
      Font.Color  := clBlack;
      TextOut(10,  40, 'Type = ' + IntToStr(FConicType) + '          ');
      TextOut(10,  60, 'Mitte = (' + FloatToStrF(x_m, ffGeneral, 5, 10) +
                            ' | ' + FloatToStrF(y_m, ffGeneral, 5, 10) + ')           ');
      TextOut(10,  80, 'Halbachsen : ' + FloatToStrF(a, ffGeneral, 5, 10) +
                                 '; ' + FloatToStrF(b, ffGeneral, 5, 10) + '         ');
      TextOut(10, 100, 'Drehwinkel = ' + FloatToStrF(alpha, ffGeneral, 5, 10) + '     ');
      TextOut(10, 120, 'delta = ' + FloatToStrF(Coeff[0]*Coeff[2] - Sqr(Coeff[1]),
                                                ffGeneral, 5, 10) + '        ');
      TextOut(10, 140, 'Spur  = ' + FloatToStrF(Coeff[0] + Coeff[2], ffGeneral, 5, 10) + '        ');
      end;
    end;

  begin
  If IsVisible then begin
    AdjustGraphTools(True);
//    ShowParams;
    Case FConicType of
     2 : begin  { Geradenpaar ausgeben }
         draw_long_line_clip_on(ObjList.TargetCanvas,
               IntPointLists[0,0].X, IntPointLists[0,0].Y,
               IntPointLists[0,1].X, IntPointLists[0,1].Y);
         draw_long_line_clip_on(ObjList.TargetCanvas,
               IntPointLists[0,2].X, IntPointLists[0,2].Y,
               IntPointLists[0,3].X, IntPointLists[0,3].Y);
         end;
     4 : begin  { Geradenpaar ausgeben }
         draw_long_line_clip_on(ObjList.TargetCanvas,
               IntPointLists[0,0].X, IntPointLists[0,0].Y,
               IntPointLists[0,1].X, IntPointLists[0,1].Y);
         draw_long_line_clip_on(ObjList.TargetCanvas,
               IntPointLists[0,2].X, IntPointLists[0,2].Y,
               IntPointLists[0,3].X, IntPointLists[0,3].Y);
         end;
     6 : ObjList.TargetCanvas.Ellipse
               (IntPointLists[0,0].X - pointSize,     IntPointLists[0,0].Y - pointSize,
                IntPointLists[0,0].X + pointSize + 1, IntPointLists[0,0].Y + pointSize + 1);
    else
      For i := 0 to High(IntPointLists) do begin
        ObjList.TargetCanvas.PolyBezier(IntPointLists[i]);
        If ShowLocLinePts then begin  // Normalerweise deaktiviert; nur zur Diagnose
          k := 1;                     //    bei Ortslinien-Problemen einschalten!
          While k < High(IntPointLists[i]) do begin
            ObjList.TargetCanvas.Ellipse
                 (IntPointLists[i,k].X - pointSize,     IntPointLists[i,k].Y - pointSize,
                  IntPointLists[i,k].X + pointSize + 1, IntPointLists[i,k].Y + pointSize + 1);
            k := k + 3;
            end;
          end;
        end;
    end; { of case }
    end;
  end;


procedure TGConic.HideIt;
  var i {, k} : Integer;
  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    Case FConicType of
     2 : begin  { Geradenpaar ausgeben }
         draw_long_line_clip_on(ObjList.TargetCanvas,
               IntPointLists[0,0].X, IntPointLists[0,0].Y,
               IntPointLists[0,1].X, IntPointLists[0,1].Y);
         draw_long_line_clip_on(ObjList.TargetCanvas,
               IntPointLists[0,2].X, IntPointLists[0,2].Y,
               IntPointLists[0,3].X, IntPointLists[0,3].Y);
         end;
     4 : begin  { Geradenpaar ausgeben }
         draw_long_line_clip_on(ObjList.TargetCanvas,
               IntPointLists[0,0].X, IntPointLists[0,0].Y,
               IntPointLists[0,1].X, IntPointLists[0,1].Y);
         draw_long_line_clip_on(ObjList.TargetCanvas,
               IntPointLists[0,2].X, IntPointLists[0,2].Y,
               IntPointLists[0,3].X, IntPointLists[0,3].Y);
         end;
     6 : ObjList.TargetCanvas.Ellipse   { Punkt ausgeben }
           (IntPointLists[0,0].X - pointSize,     IntPointLists[0,0].Y - pointSize,
            IntPointLists[0,0].X + pointSize + 1, IntPointLists[0,0].Y + pointSize + 1);
    else
      For i := 0 to High(IntPointLists) do
        ObjList.TargetCanvas.PolyBezier(IntPointLists[i]);
    end; { of case }
    end;
  end;


function TGConic.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccConic, ccSimpleLine,
                              ccConicOrCircle, ccMakroDefObj]) or
            ((ClassGroupId = ccCurveWithTans) and (FConicType in [1, 5, 7])) or
            ((ClassGroupId in [ccBorderOrArea, ccBorderLine]) and IsEllipse) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGConic.IsClosedLine: Boolean;
  begin
  Result := IsEllipse;
  end;

function TGConic.Dist(xm, ym: Double): Double;
  begin
  Case FConicType of 
    1, 5, 7 : LastDist := Inherited Dist(xm, ym);
    2, 4    : LastDist := Min(DistPt2Line(g1, xm, ym),
                              DistPt2Line(g2, xm, ym));
    3       : LastDist := DistPt2Line(g1, xm, ym);
    6       : LastDist := Hypot(xm - x_m, ym - y_m);
  else
    LastDist := 1.0e300;
  end; { of case }
  Result := LastDist;
  end;


function TGConic.GetPolOf(polare: TVector3; var px, py: Double): Boolean;
  begin
  Result := GetPolFromPolareAndConic(polare, coeff, px, py);
  end;


function TGConic.GetPolareOf(bx, by: Double; var polCoeff: TVector3): Boolean;
  begin
  Result := GetPolareFromPolAndConic(bx, by, coeff, polCoeff);
  end;


function TGConic.GetTangentIn(bx, by: Double; var tanCoeff: TVector3): Boolean;
  { Liefert in tanCoeff die Koeffizienten der Gleichung ax + by + c = 0  der
    Tangenten an den Kegelschnitt im übergebenen Punkt B(bx, by). Dabei wird
    vorausgesetzt, dass dieser Punkt wirklich auf der Kurve liegt. Dies muss
    durch die aufrufende Prozedur sichergestellt sein.                       }
  begin
  Result := GetPolareOf(bx, by, tanCoeff);
  end;


function TGConic.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If (nr > 0) and (nr <= Parent.Count) then
    Result := Parent[Pred(nr)]
  else
    Result := Nil;
  end;


function TGConic.GetValue(selector: Integer): Double;
  begin
  If DataValid then
    Case selector of
      gv_x      : Result := x_m;
      gv_y      : Result := y_m;
      gv_len    : If IsEllipse then                    { Umfang }
                    Result := EllipticCircumference    
                  else
                    Result := 0;
      gv_radius : Result := a;
      gv_area   : If SignedAreas and IsReversed then
                    Result := - pi * a * b
                  else
                    Result :=   pi * a * b;
    else
      Result    := 0;
    end  { of case }
  else { of if }
    Result := 0;
  end;


function TGConic.GetDataStr: String;

  procedure ffs(z: Double; postf: String; IsConst: Boolean; var res: String);
    begin
    If IsConst then  // letzter Koeffizient
      If Abs(z) > DistEpsilon then
        if z > 0 then
          res := res + ' + ' + Float2Str(z, 2) + postf
        else
          res := res + ' - ' + Float2Str(-z, 2) + postf
      else
        res := res + postf
    else
      If Abs(z) > DistEpsilon then  // Koeffizient ist nicht Null
        If SameValue(Abs(z), 1) then     // Koeffizient ist Eins
          if z > 0 then
            res := res + ' + ' + postf
          else
            res := res + ' - ' + postf
        else                           // Koeffizient ist nicht Eins
          if z > 0 then
            res := res + ' + ' + Float2Str(z, 2) + postf
          else
            res := res + ' - ' + Float2Str(-z, 2) + postf;
    end;

  var s : String;
  begin
  s := ' {';
  ffs(Coeff[0], 'x²', False, s);
  ffs(2*Coeff[1], 'xy', False, s);
  ffs(Coeff[2], 'y²', False, s);
  ffs(2*Coeff[3], 'x', False, s);
  ffs(2*Coeff[4], 'y', False, s);
  ffs(Coeff[5], ' = 0 }', True, s);
  If s[4] = '+' then Delete(s, 4, 2);
  Result := s;
  end;


function TGConic.GetIsEllipse: Boolean;
  begin
  Result := FConicType = 7;
  end;


function TGConic.GetIsParabel: Boolean;
  begin
  Result := FConicType = 1;
  end;


function TGConic.GetIsHyperbel: Boolean;
  begin
  Result := FConicType = 5;
  end;


function TGConic.GetInfo: String;
  var n, i : Integer;
  begin
  If IsEllipse then n := 63
  else
    if IsParabel then n := 64
    else
      if IsHyperbel then n := 65
      else n := 62;
  Result := MyObjTxt[n];
  InsertNameOf(Self, Result);
  For i := 0 to 4 do
    InsertNameOf(TGeoObj(Parent[i]), Result);
  end;


{-------------------------------------------}
{ TGOLConic's Methods Implementation        }
{-------------------------------------------}

constructor TGOLConic.Create(iObjList: TGeoObjListe; iOL: TGeoObj;
                             iis_visible: Boolean);
  begin
  Inherited Create(iObjList, iOL, nil, nil, nil, nil, False);
  UpdateParams;
  ShowsAlways := iis_visible;
  end;

procedure TGOLConic.UpdateParams;
  var PaLL    : TGLocLine;  // "Pa"rent "L"ocus "L"ine
      quality : Double;
  begin
  PaLL := Parent.Items[0]; // as TGLocLine;
  If (PaLL <> Nil) and
     BestConicApprox(PaLL.points, quality, FCoeff) and
     (quality > LocSL_ConicLimit) then begin
    DataValid := True;
    GetConicParamsFromCoeff(Coeff, FConicType, x_m, y_m, x_n, y_n,
                            hdx, hdy, alpha, a, b, excen, g1, g2);
    LoadRotationMatrix;
    FillList;
    UpdateScreenCoords;
    end
  else
    DataValid := False;
  PaLL.ShowsAlways := Not DataValid;
  end;

procedure TGOLConic.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_locstnd, CME_PopupClick,
                     cmd_EditLocLineStnd, True);
  end;

function TGOLConic.GetInfo: String;
  begin
  Result := MyObjTxt[108];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  end;



{-------------------------------------------}
{ TGEllipseF's Methods Implementation       }
{-------------------------------------------}

constructor TGEllipseF.Create(iObjList: TGeoObjListe; P1, P2, P3: TGPoint;
                              iis_visible: Boolean);
  begin
  Inherited Create(iObjList, P1, P2, P3, Nil, Nil, False);
  FConicType := 7;
  UpdateParams;
  If DataValid then
    ShowsAlways := iis_visible;
  end;

constructor TGEllipseF.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  FConicType := 7;
  end;

function TGEllipseF.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = Self.ClassType) and
            same2Obj(GO.Parent[0], GO.Parent[1],
                     Self.Parent[0], Self.Parent[1]) and
            (GO.Parent[2] = Self.Parent[2]);
  end;

function TGEllipseF.IsClosedLine: Boolean;
  begin
  Result := True;
  end;

function TGEllipseF.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr = 1 then
    Result := Parent[2]
  else
    Result := Nil;
  end;

procedure TGEllipseF.UpdateParams;
  var P, F1, F2   : TGPoint;
  begin
  F1 := Parent[0];
  F2 := Parent[1];
  P  := Parent[2];
  If P.DataValid and F1.DataValid and F2.DataValid then begin
    GetEquationFromFFP(F1.X, F1.Y, F2.X, F2.Y, P.X, P.Y, True);
    DataValid := IsEllipse;
    end
  else
    DataValid := False;
  If DataValid then
    UpdateScreenCoords;
  end;

function TGEllipseF.GetInfo: String;
  var i : Integer;
  begin
  Result := MyObjTxt[69];
  InsertNameOf(Self, Result);
  For i := 0 to 2 do
    InsertNameOf(TGeoObj(Parent[i]), Result);
  end;


{-------------------------------------------}
{ TGEllipseS's Methods Implementation       }
{-------------------------------------------}

function TGEllipseS.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = Self.ClassType) and
            (GO.Parent[0] = Self.Parent[0]) and
            (GO.Parent[1] = Self.Parent[1]) and
            (GO.Parent[2] = Self.Parent[2]);
  end;

function TGEllipseS.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr = 1 then
    Result := Parent[1]
  else
    Result := Nil;
  end;

procedure TGEllipseS.UpdateParams;
  var MP, HS, NK : TGPoint;
      a1, b1, ax, ay, c, d,
      f1x, f1y, f2x, f2y : Double;
  begin
  DataValid := False;
  MP := Parent[0];
  HS := Parent[1];
  NK := Parent[2];
  If MP.DataValid and HS.DataValid and NK.DataValid then begin
    x_m := MP.X; y_m := MP.Y;
    ax := HS.X - x_m; ay := HS.Y - y_m;
    a1 := Hypot(ax, ay);
    b1 := Hypot(NK.X - x_m, NK.Y - y_m);
    If a1 >= b1 then begin  // Normalfall :
      a  := a1;             //   Daten übernehmen
      b  := b1;
      end
    else begin              // Andernfalls:
      a  := b1;             //   Scheitelrollen tauschen !
      b  := a1;
      ax := HS.Y - y_m;
      ay := x_m - HS.X;
      end;
    c := Sqrt(Sqr(a) - Sqr(b));
    d := Hypot(ax, ay);
    If d > epsilon then begin
      ax := ax / d;
      ay := ay / d;
      f1x := MP.X + c * ax;
      f1y := MP.Y + c * ay;
      f2x := MP.X - c * ax;
      f2y := MP.Y - c * ay;
      GetEquationFromFFP(f1x, f1y, f2x, f2y, HS.X, HS.Y, True);
      DataValid := IsEllipse;
      end
    end;
  If DataValid then
    UpdateScreenCoords;
  end;

function TGEllipseS.GetInfo: String;
  var i : Integer;
  begin
  Result := MyObjTxt[70];
  InsertNameOf(Self, Result);
  For i := 0 to 2 do
    InsertNameOf(TGeoObj(Parent[i]), Result);
  end;


{-------------------------------------------}
{ TGEllipseK's Methods Implementation       }
{-------------------------------------------}

function TGEllipseK.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = Self.ClassType) and
            (GO.Parent[0] = Self.Parent[0]) and
            same2Obj(GO.Parent[1], GO.Parent[2],
                     Self.Parent[1], Self.Parent[2]);
  end;

function TGEllipseK.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr in [1, 2] then
    Result := Parent[nr]
  else
    Result := Nil;
  end;

procedure TGEllipseK.UpdateParams;
  var MP, K1, K2 : TGPoint;
      gk, hl, gm, hn,
      a1, b1, c, d, u, v,
      rx, ry, t,
      mtx, mty   : Double;
  begin
  DataValid := False;
  MP := Parent[0];     // M  (g, h)
  K1 := Parent[1];     // K1 (k, l)
  K2 := Parent[2];     // K2 (m, n)
  If MP.DataValid and K1.DataValid and K2.DataValid then begin
    gk := MP.X - K1.X;
    hl := MP.Y - K1.Y;
    gm := MP.X - K2.X;
    hn := MP.Y - K2.Y;
    If Abs(gk * gm + hl * hn) > epsilon then begin  // K1 und K2 sind keine Scheitel
      u := gk - hn;
      v := hl + gm;
      d := Hypot(u, v);
      If d > epsilon then begin
        u := u / d;
        v := v / d;
        rx := 0.5 * (K1.X + MP.X - hn);
        ry := 0.5 * (K1.Y + MP.Y + gm);
        t  := 0.5 * Hypot(gk + hn, hl - gm);
        d := Hypot(K1.X - rx, K1.Y - ry);
        a := t + d;                      // Halbachsenlängen
        b := t - d;
        c := Sqrt(Abs(Sqr(a) - Sqr(b))); // vorsichtshalber "Abs" !
        mtx := rx - MP.X - t * u;
        mty := ry - MP.Y - t * v;
        d := Hypot(mtx, mty);
        If d > epsilon then begin
          d := c / d;
          mtx := mtx * d;
          mty := mty * d;
          GetEquationFromFFP(MP.X + mtx, MP.Y + mty,
                             MP.X - mtx, MP.Y - mty,
                             K1.X, K1.Y, True);
          DataValid := IsEllipse;
          end;
        end;
      end
    else begin  // K1 und K2 sind Scheitel !
      a1 := Hypot(gk, hl);
      b1 := Hypot(gm, hn);
      If a1 > b1 then begin
        a   := a1;  b   := b1;
        mtx := gk;  mty := hl;
        end
      else begin
        a   := b1;  b   := a1;
        mtx := gm;  mty := hn;
        end;
      c := Sqrt(Abs(Sqr(a) - Sqr(b)));
      If a > epsilon then begin  // andernfalls: Entartung zum Punkt !
        d := c / a;              //   c = d = 0  <==>  Kreis !
        mtx := mtx * d;
        mty := mty * d;
        GetEquationFromFFP(MP.X + mtx, MP.Y + mty,
                           MP.X - mtx, MP.Y - mty,
                           K1.X, K1.Y, True);
        DataValid := IsEllipse;
        end;
      end;
    end;
  If DataValid then
    UpdateScreenCoords;
  end;

function TGEllipseK.GetInfo: String;
  var i : Integer;
  begin
  Result := MyObjTxt[71];
  InsertNameOf(Self, Result);
  For i := 0 to 2 do
    InsertNameOf(TGeoObj(Parent[i]), Result);
  end;


{-------------------------------------------}
{ TGParabelF's Methods Implementation       }
{-------------------------------------------}

constructor TGParabelF.Create(iObjList: TGeoObjListe;
                              P: TGPoint; L: TGStraightLine;
                              iis_visible: Boolean);
  begin
  Inherited Create(iObjList, P, L, Nil, Nil, Nil, False);
  FConicType := 1;
  UpdateParams;
  If DataValid then
    ShowsAlways := iis_visible;
  end;

constructor TGParabelF.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  inherited CreateFromDomData(iObjList, DE);
  FConicType := 1;
  end;

function TGParabelF.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = Self.ClassType) and
            (GO.Parent[0] = Self.Parent[0]) and
            (GO.Parent[1] = Self.Parent[1]);
  end;

function TGParabelF.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  Result := Nil;
  end;

procedure TGParabelF.UpdateParams;
  var F  : TGPoint;
      L  : TGStraightLine;
      lv : TVector3;
      norm  : Double;
      i  : Integer;
  begin
  DataValid := False;
  F := Parent[0];
  L := Parent[1];
  If F.DataValid and L.DataValid then begin
    lv := TVector3.Create(0, 0, 0);
    try
      L.GetDataVector(lv);
      FCoeff[0] := 1 - Sqr(lv.X);
      FCoeff[1] := - lv.X * lv.Y;
      FCoeff[2] := 1 - Sqr(lv.Y);
      FCoeff[3] := - F.X - lv.X * lv.Z;
      FCoeff[4] := - F.Y - lv.Y * lv.Z;
      FCoeff[5] := Sqr(F.X) + Sqr(F.Y) - Sqr(lv.Z);
      norm := NormingValue(coeff[0], coeff[1], coeff[2], 1e-3);
      If coeff[0] < 0 then
        norm := -norm;
      If Abs(norm) > epsilon then
        For i := 0 to 5 do
          FCoeff[i] := FCoeff[i] / norm;
      GetConicParamsFromCoeff(Coeff, FConicType, x_m, y_m, x_n, y_n,
                              hdx, hdy, alpha, a, b, excen, g1, g2);
      If IsParabel then begin
        LoadRotationMatrix;
        FillList;
        DataValid := True;
        UpdateScreenCoords;
        end;
    finally
      lv.Free;
    end;
    end;
  end;

function TGParabelF.GetInfo: String;
  var i : Integer;
  begin
  Result := MyObjTxt[72];
  InsertNameOf(Self, Result);
  For i := 0 to 1 do
    InsertNameOf(TGeoObj(Parent[i]), Result);
  end;


{-------------------------------------------}
{ TGParabelT's Methods Implementation       }
{-------------------------------------------}

constructor TGParabelT.Create(iObjList: TGeoObjListe; P1, P2: TGPoint;
                              L1, L2: TGStraightLine; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, P1, P2, L1, L2, Nil, iis_visible);
  FConicType := 1;
  UpdateParams;
  If DataValid then
    ShowsAlways := iis_visible;
  end;

constructor TGParabelT.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  inherited CreateFromDomData(iObjList, DE);
  FConicType := 1;
  end;

function TGParabelT.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = Self.ClassType) and
            (((GO.Parent[0] = Self.Parent[0]) and (GO.Parent[1] = Self.Parent[1]) and
              (GO.Parent[2] = Self.Parent[2]) and (GO.Parent[3] = Self.Parent[3])) or
             ((GO.Parent[0] = Self.Parent[2]) and (GO.Parent[1] = Self.Parent[3]) and
              (GO.Parent[2] = Self.Parent[0]) and (GO.Parent[3] = Self.Parent[1])));
  end;

function TGParabelT.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  Case nr of
    1 : Result := Parent[0];
    2 : Result := Parent[2];
  else
    Result := Nil;
  end; { of case }
  end;

procedure TGParabelT.UpdateParams;
  var P      : TFloatPointList;
      d1, d2 : TFloatPoint;
      v1, v2 : TVector3;
      ok     : Boolean;
      i      : Integer;
  begin
  try
    DataValid := False;
    ok        := True;
    For i := 0 to 3 do
      If Not TGeoObj(Parent[i]).DataValid then
        ok := False;
    If ok then begin
      v1 := TVector3.Create(0, 0, 0);
      v2 := TVector3.Create(0, 0, 0);
      SetLength(P, 6);
      try
        P[0].x := TGPoint(Parent[0]).X;
        P[0].y := TGPoint(Parent[0]).Y;
        P[4].x := TGPoint(Parent[1]).X;
        P[4].y := TGPoint(Parent[1]).Y;
        d1 := TGStraightLine(Parent[2]).GetNormalizedDirection;
        d2 := TGStraightLine(Parent[3]).GetNormalizedDirection;
        If GetHesseEqFromPtAndDir(P[0].x, P[0].y, d1.x, d1.y, v1) and
           GetHesseEqFromPtAndDir(P[4].x, P[4].y, d2.x, d2.y, v2) then begin
          IntersectLines(v1, v2, P[5].x, P[5].y, ok);
          If ok then begin
            P[1].x := 0.64 * P[0].x + 0.32 * P[5].x + 0.04 * P[4].x;
            P[1].y := 0.64 * P[0].y + 0.32 * P[5].y + 0.04 * P[4].y;
            P[2].x := 0.25 * P[0].x + 0.50 * P[5].x + 0.25 * P[4].x;
            P[2].y := 0.25 * P[0].y + 0.50 * P[5].y + 0.25 * P[4].y;
            P[3].x := 0.04 * P[0].x + 0.32 * P[5].x + 0.64 * P[4].x;
            P[3].y := 0.04 * P[0].y + 0.32 * P[5].y + 0.64 * P[4].y;
            GetConicCoeffFromPoints(P, FCoeff);
            GetConicParamsFromCoeff(FCoeff, FConicType, x_m, y_m, x_n, y_n,
                                    hdx, hdy, alpha, a, b, excen, g1, g2);
            If IsParabel then begin
              LoadRotationMatrix;
              FillList;
              DataValid := True;
              UpdateScreenCoords;
              end;
            end;
          end;
      finally
        P := Nil;
        v2.Free;
        v1.Free;
      end;
      end;
  except
    DataValid := False;
  end; { of try }
  end;

function TGParabelT.GetInfo: String;
  begin
  Result := MyObjTxt[73];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  InsertNameOf(TGeoObj(Parent[1]), Result);
  InsertNameOf(TGeoObj(Parent[2]), Result);
  InsertNameOf(TGeoObj(Parent[3]), Result);
  end;


{-------------------------------------------}
{ TGHyperbelF's Methods Implementation      }
{-------------------------------------------}

constructor TGHyperbelF.Create(iObjList: TGeoObjListe; P1, P2, P3: TGPoint;
  iis_visible: Boolean);
  begin
  Inherited Create(iObjList, P1, P2, P3, Nil, Nil, False);
  FConicType := 5;
  UpdateParams;
  If DataValid then
    ShowsAlways := iis_visible;
  end;

constructor TGHyperbelF.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  FConicType := 5;
  end;

function TGHyperbelF.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = Self.ClassType) and
            same2Obj(GO.Parent[0], GO.Parent[1],
                     Self.Parent[0], Self.Parent[1]) and
            (GO.Parent[2] = Self.Parent[2]);
  end;

function TGHyperbelF.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr = 1 then
    Result := Parent[2]
  else
    Result := Nil;
  end;

procedure TGHyperbelF.UpdateParams;
  var P, F1, F2   : TGPoint;
  begin
  F1 := Parent[0];
  F2 := Parent[1];
  P  := Parent[2];
  If P.DataValid and F1.DataValid and F2.DataValid then begin
    GetEquationFromFFP(F1.X, F1.Y, F2.X, F2.Y, P.X, P.Y, False);
    DataValid := IsHyperbel;
    end
  else
    DataValid := False;
  If DataValid then
    UpdateScreenCoords;
  end;

function TGHyperbelF.GetInfo: String;
  var i : Integer;
  begin
  Result := MyObjTxt[74];
  InsertNameOf(Self, Result);
  For i := 0 to 2 do
    InsertNameOf(TGeoObj(Parent[i]), Result);
  end;


{-------------------------------------------}
{ TGHyperbelA's Methods Implementation      }
{-------------------------------------------}

constructor TGHyperbelA.Create(iObjList: TGeoObjListe;
                               as1, as2: TGLongLine; P: TGPoint;
                               iis_visible: Boolean);
  begin
  Inherited Create(iObjList, as1, as2, P, Nil, Nil, iis_visible);
  FConicType := 5;
  UpdateParams;
  If DataValid then
    ShowsAlways := iis_visible;
  end;

constructor TGHyperbelA.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  inherited CreateFromDomData(iObjList, DE);
  FConicType := 1;
  end;

function TGHyperbelA.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = Self.ClassType) and
            same2Obj(GO.Parent[0], GO.Parent[1],
                     Self.Parent[0], Self.Parent[1]) and
            (GO.Parent[2] = Self.Parent[2]);
  end;

function TGHyperbelA.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If nr = 1 then
    Result := Parent[2]
  else
    Result := Nil;
  end;

procedure TGHyperbelA.UpdateParams;
  var PA1, PA2 : TGStraightLine;
      PP       : TGPoint;
      v        : Double;
      as1, as2 : TVector3;
  begin
  DataValid := False;
  PA1 := Parent[0];
  PA2 := Parent[1];
  PP  := Parent[2];
  If PA1.DataValid and PA2.DataValid and PP.DataValid then begin
    as1 := TVector3.Create(0, 0, 0);
    as2 := TVector3.Create(0, 0, 0);
    try
      PA1.GetDataVector(as1);
      PA2.GetDataVector(as2);
      FCoeff[0] := as1.X * as2.X;
      FCoeff[1] := (as1.X * as2.Y + as1.Y * as2.X);
      FCoeff[2] := as1.Y * as2.Y;
      FCoeff[3] := (as1.X * as2.Z + as1.Z * as2.X);
      FCoeff[4] := (as1.Y * as2.Z + as1.Z * as2.Y);
      FCoeff[5] := as1.Z * as2.Z;
      v := FCoeff[0] * Sqr(PP.X) + FCoeff[1] * PP.X * PP.Y + FCoeff[2] * Sqr(PP.Y) +
           FCoeff[3] * PP.X + FCoeff[4] * PP.Y + FCoeff[5];
      FCoeff[5] := FCoeff[5] - v;
      FCoeff[4] := FCoeff[4] / 2;
      FCoeff[3] := FCoeff[3] / 2;
      FCoeff[1] := FCoeff[1] / 2;
      If GetConicParamsFromCoeff(coeff, FConicType, x_m, y_m, x_n, y_n,
                                 hdx, hdy, alpha, a, b, excen, g1, g2)
         and IsHyperbel then begin
        LoadRotationMatrix;
        FillList;
        DataValid := True;
        UpdateScreenCoords;
        end;
    finally
      as1.Free;
      as2.Free;
    end; { of try }
    end; { of if }
  end;

function TGHyperbelA.GetInfo: String;
  var i : Integer;
  begin
  Result := MyObjTxt[75];
  InsertNameOf(Self, Result);
  For i := 0 to 2 do
    InsertNameOf(TGeoObj(Parent[i]), Result);
  end;



{-------------------------------------------}
{ TGMappedConic's Methods Implementation    }
{-------------------------------------------}


constructor TGMappedConic.Create(iObjList: TGeoObjListe; iPO: TGLine;
                                 iMapObj: TGTransformation; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, iPO, iMapObj, Nil, Nil, Nil, False);
  If iPO is TGConic then
    FConicType := (iPO as TGConic).FConicType
  else // iPO ist ein Kreis !
    FConicType := 7;
  IsReversed := iPO.IsReversed xor iMapObj.IsReversing;
  UpdateParams;
  If iis_visible then
    ShowsAlways := True;
  end;

procedure TGMappedConic.AfterLoading(FromXML: Boolean);
  begin
  Inherited AfterLoading(FromXML);
  IsReversed := TGeoObj(Parent[0]).IsReversed xor
                TGTransformation(Parent[1]).IsReversing;
  end;

function TGMappedConic.IsClosedLine: Boolean;
  { Liefert genau dann TRUE, wenn die Kurve *permanent* eine Ellipse ist }
  begin
  Result := TGLine(Parent[0]).IsClosedLine;
  end;

function TGMappedConic.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  Result := Nil;
  end;

function TGMappedConic.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var pt, mpt : TFloatPoint;
  begin
  If TGeoObj(Parent[0]) is TGCircle then
    Result := TGCircle(Parent[0]).GetCoordsFromParam(param, pt.x, pt.y)
  else
    Result := TGConic(Parent[0]).GetCoordsFromParam(param, pt.x, pt.y);
  If Result then
    If TGTransformation(Parent[1]).GetMappedPoint(pt, mpt) then begin
      px := mpt.x;
      py := mpt.y;
      end
    else
      Result := False;
  end;

function TGMappedConic.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var pt, impt : TFloatPoint;
  begin
  Result := False;
  pt.x := px;
  pt.y := py;
  If TGTransformation(Parent[1]).GetInvMapPoint(pt, impt) then
    If TGeoObj(Parent[0]) is TGCircle then
      Result := TGCircle(Parent[0]).GetParamFromCoords(impt.x, impt.y, param)
    else
      Result := TGConic(Parent[0]).GetParamFromCoords(impt.x, impt.y, param);
  end;

procedure TGMappedConic.UpdateParams;
  var PC: TGConic;
      MO: TGMatrixMap;
      sourceCoeff : TCoeff6;
  begin
  If TGeoObj(Parent[0]) is TGCircle then begin  // Urbild ist Kreis
    FConicType := 7;  // <=> Ellipse !
    TGCircle(Parent[0]).GetConicCoeff(sourceCoeff);
    end
  else
  If TGeoObj(Parent[0]) is TGConic then begin   // Urbild ist Kegelschnitt
    PC := TGeoObj(Parent[0]) as TGConic;
    FConicType := PC.FConicType;
    sourceCoeff := PC.coeff;
    end;

  MO := TGeoObj(Parent[1]) as TGMatrixMap;
  DataValid := MO.GetMappedConic(sourceCoeff, FCoeff);

  If DataValid then
    If GetConicParamsFromCoeff(Coeff, FConicType, x_m, y_m, x_n, y_n,
                               hdx, hdy, alpha, a, b, excen, g1, g2) then begin
      IsReversed := TGeoObj(Parent[0]).IsReversed xor
                    TGTransformation(Parent[1]).IsReversing;
      LoadRotationMatrix;
      FillList;
      UpdateScreenCoords;
      end
    else
      DataValid := False;
  end;

function TGMappedConic.GetInfo: String;
  var s1, s2 : String;
  begin
  s1 := MyObjTxt[45];
  InsertNameOf(Self, s1);
  InsertNameOf(TGeoObj(Parent[0]), s1);
  s2 := TGTransformation(Parent[1]).GetLinkableInfo;
  Result := s1 + s2;
  end;



initialization

  RegisterClass(TGConic);
  RegisterClass(TGOLConic);
  RegisterClass(TGEllipseF);
  RegisterClass(TGEllipseS);
  RegisterClass(TGEllipseK);
  RegisterClass(TGParabelF);
  RegisterClass(TGParabelT);
  RegisterClass(TGHyperbelF);
  RegisterClass(TGHyperbelA);
  RegisterClass(TGMappedConic);

finalization

end.
