unit GeoHelper;

interface

uses Windows, Classes, Menus, SysUtils, Math, Graphics,
     Declar, GlobVars, GeoTypes, GeoTransf, Utility, MathLib,
     XMLIntf, TBaum;

type
  TGDoubleIntersection = class(TGeoObj) // ersetzt TGDoublePt
    protected
      CheckLater : Boolean;
      tv1, tv2   : Double;
      imp_Data   : TDataStack;
      FPtList    : TFloatPointList;
      FValidList : Array of Boolean;
      function  GetVariantPt(n: Integer): TFloatPoint; virtual;
      function  GetVariantValid(n: Integer): Boolean; virtual;
      function  DefaultName: WideString; override;
      procedure CheckExistingIPs;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure UpdateScreenCoords; override;
     procedure DrawIt; override;
      procedure HideIt; override;
    public
      constructor Create(iObjList: TGeoObjListe; iS1, iS2: TGeoObj; CheckP3: Boolean = True);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      destructor Destroy; override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure AfterLoading(FromXML: Boolean = True); override;
      procedure CheckParent3(DoUpdate: Boolean = True);
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      procedure StoreOldPoints(X_1, Y_1, X_2, Y_2: Double; v1, v2: Boolean);
      procedure CheckOrientation;
      function  Dist(xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  LostAllChildren: Boolean;
      function  GetInfo: String; override;
      property  VariantPt[n : Integer]: TFloatPoint read GetVariantPt;
      property  VariantValid[n : Integer]: Boolean read GetVariantValid;
    end;

  TGQuadIntersection = class(TGDoubleIntersection)
    protected
      OIPP : Array [0..3] of Double;  // "O"ld "I"ntersection "P"oint "P"arams
      s    : String;
      function  PreExistingIntersectionPtCount : Integer;
      function  ParamDist(p1, p2: Double): Double;
      procedure SortPointList;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure DrawIt; override;
    public
      constructor Create(iObjList: TGeoObjListe; iS1, iS2: TGeoObj; CheckP3: Boolean = False);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure AfterLoading(FromXML: Boolean = True); override;
      procedure UpdateParams; override;
    end;

  TGPolygon = class(TGCurve)
    protected
      area      : Double;
      function  DefaultName: WideString; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      function  GetFillHandle(Ori: Boolean): HRgn; override;
      function  GetVCount: Integer; virtual;
      function  AllAncestorsAreFreePoints(PList: TObjPtrList = Nil): Boolean; override;
      function  GetSegmentObj(nr: Integer): TGShortLine; virtual;
      procedure ReverseParentList;
      procedure SetMyColour(NewCol: TColor); override;
      procedure SetIsFlagged(flag: Boolean); override;
      procedure SetIsBlinking(flag: Boolean); override;
      procedure SetShowsAlways(vis: Boolean); override;
      procedure SetIsGrouped(flag: Boolean); override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure UpdateScreenCoords; override;
      procedure AdjustGraphTools(todraw : Boolean); override;
      procedure DrawIt; override;
      procedure HideIt; override;
    public
      constructor Create(iObjList: TGeoObjListe; iVertexList: TList; iis_visible: Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateFromBlueprint(iObjList: TGeoObjListe; MakNum, CmdNum: Integer); override;
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      destructor  Destroy; override;
      procedure AfterLoading(FromXML: Boolean = False); override;
      function  BorderOrientation: Integer;
      function  WindingNumber(sx, sy: Double): Integer;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  IsClosedLine: Boolean; override;
      function  IsFilled(var FO: TGArea): Boolean; override;
      function  IsNearMouse: Boolean; override;
      function  Dist (xm, ym: Double): Double; override;
      function  Includes(xp, yp: Double): Boolean; override;
      function  GetValue(selector: Integer): Double; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure UpdateNameCoordsIn(TextObj: TGTextObj); override;
      procedure SetNewNameParamsIn(TextObj: TGTextObj); override;
      procedure SetAsStartObject4MacroRun(MakNum, CmdNum: Integer); override;
      procedure ResetOLCPList(PointList : TVector3List); override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetRandomParam: Double; override;
      function  GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean; override;
      function  GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean; override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure UpdateParams; override;
      procedure SetGraphTools(LineStyleNum, PointStyleNum,
                              FillStyleNum: Integer; iColor: TColor); override;
      procedure GetGraphTools(var LineStyleNum, PointStyleNum,
                                  FillStyleNum: Integer; var iColor: TColor); override;
      procedure RegisterAsMacroStartObject; override;
      procedure LoadContextMenuEntriesInto(menu: TPopupMenu); override;
      function  GetInfo: String; override;
      property  VCount: Integer read GetVCount;
    end;

  TGRegPoly = class (TGPolygon)
    protected
      FVCount   : Integer;
      FReversed : Boolean;
      circum    : Double;
      function  suc(n: Integer): Integer;
      function  GetVCount: Integer; override;
      function  GetSegmentObj(nr: Integer): TGShortLine; override;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure SetShowsAlways(vis: Boolean); override;
      procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      procedure UpdateScreenCoords; override;
    public
      constructor Create(iObjList: TGeoObjListe; iP1, iP2: TGPoint;
                         ivCount: Integer; iReversed: Boolean);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      destructor Destroy; override;
      procedure AfterLoading(FromXML: Boolean = False); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  IsNearMouse: Boolean; override;
      function  Dist (xm, ym: Double): Double; override;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean; override;
      function  GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean; override;
      procedure UpdateParams; override;
      function  Includes(xp, yp: Double): Boolean; override;
      function  GetVertice(selector: Integer; var vx, vy: Double): Boolean;
      function  GetFillHandle(Ori: Boolean): HRgn; override;
      function  GetValue(selector: Integer): Double; override;
      function  GetInfo: String; override;
      property  IsReversed: Boolean read FReversed;
//    property  VCount: Integer read GetVCount;
    end;

  TGMappedRegPoly = class(TGRegPoly)
    public
      constructor Create(iObjList: TGeoObjListe; iPP: TGRegPoly; iMap: TGTransformation);
      procedure AfterLoading(FromXML: Boolean = False); override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;

  TGCheckControl = class(TGeoObj)
    protected
      FVTermStr: WideString;
      FVVars,
      FVHint  : String;
      FVBBaum : TBoolBaum;
      function  GetVTermStr: WideString;
      procedure UpdateScreenCoords; override;
      procedure DrawIt; override;
      procedure HideIt; override;
    public
      constructor Create(iObjList: TGeoObjListe; iValiTerm: WideString; iValiVars, iValiHint: String);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      destructor  Destroy; override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure AfterLoading(FromXML: Boolean); override;
      procedure UpdateParams; override;
      procedure RebuildTermStrings; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  Dist(xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  GetVarObj(num: Integer): TGeoObj;
      function  CheckSolution(TargetObj: Array of TGeoObj): Integer;
      function  GetHTMLString: WideString;
      function  GetInfo: String; override;
      property  VTermStr : WideString read GetVTermStr;
      property  VVars    : String read FVVars;
      property  VHint    : String read FVHint;
    end;

  TGUnknown = class(TGeoObj)
    protected
      procedure UpdateScreenCoords; override;
      procedure DrawIt; override;
      procedure HideIt; override;
    public
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure UpdateParams; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  Dist(xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  GetInfo: String; override;
    end;

  TGObjGroup = class(TGeoObj)
    protected
      function DefaultName: WideString; override;
      procedure UpdateScreenCoords; override;
      procedure DrawIt; override;
      procedure HideIt; override;
    public
      constructor Create(iObjList: TGeoObjListe ; members: TObjPtrList);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      procedure UpdateParams; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  Dist(xm, ym: Double): Double; override;
      function  IsNearMouse: Boolean; override;
      function  GetInfo: String; override;

    end;

function ValidationTermOk(    Drawing : TGeoObjListe;
                              VTermStr,
                              VVars   : String;
                          var ErrMsg  : String;
                          var ErrNum  : Integer) : Boolean;


implementation

uses StrUtils, GeoConic, GeoMakro;

{--------------------------------------------------}
{ TGDoubleIntersection's method implementation     }
{--------------------------------------------------}

constructor TGDoubleIntersection.Create(iObjList: TGeoObjListe;
                                        iS1, iS2: TGeoObj;
                                        CheckP3: Boolean = True);
  { CheckP3 wird gebraucht, um beim Import alter Daten der Version 2.6 und
    früher die damals verwendeten TGDoublePt-Objekte korrekt in neue
    TGDoubleIntersection-Objekte transformieren zu können (siehe Unit
    FileIO.GeoFileLoad.PatchOld26Objects.ReplaceOldDPWithIntersection).
    Dabei wird mit CheckP3 = False die automatische Registrierung schon
    vorhandener gemeinsamer Punkte der beiden Elternlinien abgeschaltet. }
  begin
  Inherited Create(iObjList, false);
  BecomesChildOf(iS1);      { Parent[0] ist eine gerade Linie oder ein Kreis; }
  BecomesChildOf(iS2);      { Parent[1] ist stets ein Kreis                   }
  If ClassType = TGDoubleIntersection then begin
    SetLength(FPtList   , 2);
    SetLength(FValidList, 2);
    tv1 := -1;
    tv2 := -2;
    If CheckP3 then begin
      CheckParent3;         { Wenn Parent[2] definiert ist, enthält es einen  }
      UpdateParams;         { gemeinsamen Punkt von Parent[0] und Parent[1].  }
      end;
    end;
  end;


constructor TGDoubleIntersection.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  SetLength(FPtList   , 2);
  SetLength(FValidList, 2);
  tv1 := -1;
  tv2 := -2;
  end;


constructor TGDoubleIntersection.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var s : String;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  SetLength(FPtList   , 2);
  SetLength(FValidList, 2);
  s := DE.childNodes.findNode('pointlist', '').NodeValue;
  DeleteChars(#09#10#13, s); // 11.04.2010 :  Tabs + Zeilenumbruch-Reste weg !
  GetFloatPair(s, FPtList[0].X, FPtList[0].Y);
  GetFloatPair(s, FPtList[1].X, FPtList[1].Y);
  tv1 := -1;
  tv2 := -2;
  end;


destructor TGDoubleIntersection.Destroy;
  begin
  FValidList := Nil;
  FPtList := Nil;
  FreeAndNil(imp_Data);
  Inherited Destroy;
  end;


procedure TGDoubleIntersection.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  SetLength(FPtList   , 2);
  SetLength(FValidList, 2);
  tv1 := -1;
  tv2 := -2;
  end;


procedure TGDoubleIntersection.AfterLoading(FromXML: Boolean = True);
    { 11.02.2007 : Die Methode wurde neu geschrieben, weil das frisch
                   veröffentlichte DynaGeo 3.0 beim Laden selbst neu-
      erstellter Dateien den Schnittpunkten falsche PtIndex-Werte
      unterschob, wenn von den beiden möglichen Schnittpunkten nur
      einer vorhanden war. Vorherige Version dieser Methode :

          try
            i := 0;
            While i < Children.Count do begin
              k := i;
              While TGIntersectPt(Children[k]).PtIndex <> i do
                Inc(k);
              If k <> i then begin
                buf         := Children[k];
                Children[k] := Children[i];
                Children[i] := buf;
                end;
              Inc(i);
              end;
          except
            For i := 0 to Pred(Children.Count) do
              TGIntersectPt(Children[i]).PtIndex := i;
          end;

      Unklar ist, wozu der Inhalt des "try"-Abschnitts eigentlich taugt.
      Der Code im "except"-Teil führte im Falle, dass nicht alle Schnitt-
      punkte echt vorhanden waren, zu einer willkürlichen Umverdrahtung
      der Schnittpunkte, gemäß der die jeweiligen Werte von PtIndex mit
      den Platznummern in der Kinder-Liste identisch hätten werden sollen.

      AfterLoading soll nur sicherstellen, dass die Schnittpunkte nicht
      ihre Rollen vertauschen. Der obige Code wurde daher entfernt und
      durch die untenstehende Variante ersetzt, die nur im Fall von 2
      Schnittpunkten die Zuordnung der PtIndex-Werte überprüft und wenn
      nötig austauscht. Normalerweise sollte aber kein Tausch nötig sein. }

  var SP1, SP2 : TGIntersectPt;
      n        : Integer;
  begin
  Inherited AfterLoading(FromXML);
  If Children.Count = 2 then begin  { Nur in diesem Fall überprüfen !     }
    SP1 := TGIntersectPt(Children.Items[0]);
    SP2 := TGIntersectPt(Children.Items[1]);
    If (Hypot(SP1.X - VariantPt[SP1.PtIndex].x, SP1.Y - VariantPt[SP1.PtIndex].y) +
        Hypot(SP2.X - VariantPt[SP2.PtIndex].x, SP2.Y - VariantPt[SP2.PtIndex].y)) >
       (Hypot(SP1.X - VariantPt[SP2.PtIndex].x, SP1.Y - VariantPt[SP2.PtIndex].y) +
        Hypot(SP2.X - VariantPt[SP1.PtIndex].x, SP2.Y - VariantPt[SP1.PtIndex].y)) then begin
      n           := SP1.PtIndex;
      SP1.PtIndex := SP2.PtIndex;
      SP2.PtIndex := n;
      SpyOut('Unexpected switch of IntersectPt.PtIndex with %s and %s',
             [SP1.Name, SP2.Name]);
      end;
    end;
  If Parent.Count < 3 then     { Vorsichtshalber eingebaut ab Version 3.0 }
    CheckParent3(False);
  end;

function TGDoubleIntersection.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  { nachgerüstet am 05.05.13:
    Multi-Intersection-Objekte werden nur abgespeichert, wenn sie mindestens
    einen Schnittpunkt verwalten; dies soll verhindern, dass funktionslose
    und eventuell defekte Multi-Intersection-Objekte in der GEO-Datei über-
    leben und dann später wieder revalidiert werden.

    wieder entfernt am 01.05.14:
    Die Children-Listen werden in Prototypen nicht vollständig geführt. Dies
    führte bei Makro-Aufzeichnungen dazu, das Double-Intersection-Prototypen
    überhaupt nicht erzeugt werden können, weil sie keine Kinder zu haben
    scheinen -- was nicht stimmt. Also weg mit diesem Sonderweg!!!        }
  var domPtList : IXMLNode;
      s         : String;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  domPtList := DOMDoc.createNode('pointlist');
  s := FloatToStr(FPtList[0].X) + ';' + FloatToStr(FPtList[0].Y) + ' ' +
       FloatToStr(FPtList[1].X) + ';' + FloatToStr(FPtList[1].Y);
  domPtList.setNodeValue(s);
  Result.childNodes.add(domPtList);
  end;


procedure TGDoubleIntersection.CheckParent3(DoUpdate: Boolean);
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

    ---------------------------------------

    überarbeitet am 26.05.05:
    ergänzt um eine Sonderbehandlung für die "3-Kreis-Figur";
    in diesem Rahmen wurde die Funktion "TGCircle.IsPairedWith()"
    nachgerüstet.

    ---------------------------------------

    überarbeitet am 27.11.06:
    ergänzt um einen abschließenden Aufruf von "CheckExistingIPs",
    falls alle vorhergehenden Suchen nichts gefunden haben.

    ---------------------------------------------------------------------

    überarbeitet am 05.05.13:
    eine Fehlermeldung vom 04.05.13 von Peter Geist im Forum enthält eine
    Konstruktion, bei der beim Schnitt zweier Kreise fälschlicherweise nur
    1 Schnittpunkt erzeugt wurde.                                         }

  var pa     : TGeoObj;    { Parent-Objekt }
      SP     : TGPoint;    { Schnittpunkt  }
      c1, c2 : TGCircle;   { Vaterkreise   }
      i      : Integer;
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

  If (Parent.Count <= 2) and
     (TGeoObj(Parent[0]).ClassType = TGCircle) and
     (TGeoObj(Parent[1]).ClassType = TGCircle) then begin
    c1 := TGCircle(Parent[0]);
    c2 := TGCircle(Parent[1]);
    If c1.IsPairedWith(c2) then begin
      SP := TGPoint(c1.Parent[1]);
      If (SP <> c2.Parent[0]) and
         (c2.Includes(SP.X, SP.Y)) and (c1.Includes(SP.X, SP.Y)) then
        Parent.Add(SP);
      SP := TGPoint(c2.Parent[1]);
      If (SP <> c1.Parent[0]) and
         (c1.Includes(SP.X, SP.Y)) and (c2.Includes(SP.X, SP.Y)) then
        Parent.Add(SP);
      end;
    end;

  If Parent.Count <= 2 then
    CheckExistingIPs;

  If DoUpdate and (Parent.Count >= 2) then begin
    UpdateParams;
    ObjList.UpdateAllDescendentsOf(Self);
    end;
  end;


procedure TGDoubleIntersection.CheckExistingIPs;
  var pl1, pl2 : TList;   // "p"arent "l"ine
      i        : Integer;

  procedure LoadPL4(GO: TGLine; pl: TList);
    var PO : TGPoint;
        i : Integer;
    begin
    i := 1;
    PO := GO.GetParentPointOnSelf(i);
    While PO <> Nil do begin
      pl.Add(PO);
      i := i + 1;
      PO := GO.GetParentPointOnSelf(i);
      end;
    end;

  begin
  pl1 := TList.Create;
  pl2 := TList.Create;
  try
    LoadPL4(Parent[0], pl1);
    LoadPL4(Parent[1], pl2);
    For i := 0 to Pred(pl1.Count) do
      If pl2.IndexOf(pl1.Items[i]) >= 0 then
        BecomesChildOf(pl1.Items[i]);
  finally
    pl1.Free;
    pl2.Free;
  end; { of try }      
  end;

function TGDoubleIntersection.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('DI_');
  end;


function TGDoubleIntersection.GetVariantPt(n: Integer): TFloatPoint;
  begin
  Result.x := FPtList[n].X;
  Result.y := FPtList[n].Y;
  end;


function TGDoubleIntersection.GetVariantValid(n: Integer): Boolean;
  begin
  If n <= High(FValidList) then
    Result := FValidList[n]
  else
    Result := False;
  end;


function TGDoubleIntersection.Dist(xm, ym: Double): Double;
  begin
  Result := 10000;
  end;

function TGDoubleIntersection.IsNearMouse: Boolean;
  begin
  Result := False;
  end;

function TGDoubleIntersection.LostAllChildren: Boolean;
  var n, i : Integer;
  begin
  Result := True;
  For i := 0 to Pred(Children.Count) do begin
    n := ObjList.IndexOf(Children[i]);
    If (n >= 0) and (n <= ObjList.LastValidObjIndex) then
      Result := False;
    end;
  end;


procedure TGDoubleIntersection.StoreOldPoints(X_1, Y_1, X_2, Y_2: Double; v1, v2: Boolean);
  begin
  FPtList[0].x := X_1;
  FPtList[0].y := Y_1;
  FPtList[1].x := X_2;
  FPtList[1].y := Y_2;
  FValidList[0] := v1;
  FValidList[1] := v2;
  If Not Assigned(imp_Data) then
    imp_Data := TDataStack.Create;
  With imp_Data do begin
    push(@v1, SizeOf(Boolean));
    push(@v2, SizeOf(Boolean));
    push(@X_1, SizeOf(Double));
    push(@Y_1, SizeOf(Double));
    push(@X_2, SizeOf(Double));
    push(@Y_2, SizeOf(Double));
    end;
  end;


procedure TGDoubleIntersection.CheckOrientation;
  { Sichert, dass Doppelpunkte beim Laden alter Dateien so angeordnet
    werden, wie sie in der alten Version auch lagen. Überschreibt auch
    die Anordnungsinformation, die sich eventuell aus der Orientierung
    der Eltern ergeben würde. }

  function ChildrenAreSwitched : Boolean;
    var old_x1, old_y1, old_x2, old_y2,
        new_x12, new_y12,
        p3n1, p3n2,
        even, crossed  : Double;
        p3             : TGPoint;
        old_v1, old_v2 : Boolean;
    begin
    Result := False;
    If (Parent.Count = 3) and (Children.Count = 1) then begin
      p3 := TGPoint(Parent[2]);
      p3n1 := Hypot(FPtList[0].X - p3.X, FPtList[0].Y - p3.Y);
      p3n2 := Hypot(FPtList[1].X - p3.X, FPtList[1].Y - p3.Y);
      If p3n2 > p3n1 then
        Result := True;
      end
    else begin
      If Assigned(imp_Data) and Not imp_Data.is_empty then
        with imp_Data do begin
          pop(@old_y2);
          pop(@old_x2);
          pop(@old_y1);
          pop(@old_x1);
          pop(@old_v2);
          pop(@old_v1);
          end
      else begin
        CheckLater := False;
        Exit;
        end;
        
      If Hypot(old_x2 - old_x1, old_y2 - old_y1) > DistEpsilon then

      { Alte Version (seit 2.7 d) dieser Entscheidung :
      =====================================================================
      If  old_v1 and old_v2 and
          (Hypot(old_x2 - old_x1, old_y2 - old_y1) > DistEpsilon) then....
      =====================================================================
        Führte z.B. zur Verkrüppelung des Elschenbroich'schen Einrad-Fahrers
        (Datei a1_01.geo aus der Aufgabensammlung für Klasse 5+6).
        Beim Schnitt eines Kreises mit einer Geraden, wobei der Kreis durch
        einen Punkt auf dieser Geraden verläuft, wird dieser Punkt als 3.
        Elter des Doppelpunkt-Objekts eingetragen. Daraufhin gibt es nur noch
        einen zu erzeugenden Schnittpunkt, weshalb dann old_v1 oder old_v2
        FALSE ist. In dieser Situation wurde der IF-Teil also übersprungen,
        obwohl in seinem Innern dieser Fall doch behandelt worden wäre!

        Warum die Zusatzbedingungen in der Version 2.7d hinzugefügt worden
        waren, lässt sich nicht mehr rekonstruieren. Es gab offenbar keinen
        dokumentierten Bug, der damit gelöst werden sollte. Daher wurden die
        willkürlich(?) und falsch ergänzten Zusatzbedingungen am 07.05.06 für
        die Version 2.7g wieder entfernt.                                   }

        If Children.Count = 2 then begin
          If CheckLater then begin
            even    := 0;   // Summe der zurückgelegten Wege bei aktueller...
            crossed := 0;   //   ... bzw. invertierter Zuordnung der Punkte !
            If VariantValid[0] then begin
              even    := Hypot(FPtList[0].x - old_x1, FPtList[0].y - old_y1);
              crossed := Hypot(FPtList[0].x - old_x2, FPtList[0].y - old_y2);
              end;
            If VariantValid[1] then begin
              even    := even    + Hypot(FPtList[1].x - old_x2, FPtList[1].y - old_y2);
              crossed := crossed + Hypot(FPtList[1].x - old_x1, FPtList[1].y - old_y1);
              end;
            Result := crossed < even;
            end
          else begin
            If old_v1 and old_v2 then begin
              new_x12 := FPtList[1].X - FPtList[0].X;
              new_y12 := FPtList[1].Y - FPtList[0].Y;
              Result := (old_x2 - old_x1) * new_x12 + (old_y2 - old_y1) * new_y12 < 0;
              end
            else begin
              If old_v1 <> old_v2 then  // 20.09.05: Diese Unterscheidung ergänzt.
                Result := (old_v1 = VariantValid[1]) and
                          (old_v2 = VariantValid[0])
              else begin                // Beide ungültig ==> später checken
                Result := False;        // Damit jetzt nichts geändert wird !
                With imp_Data do begin  // Daten wieder auf den Stack schieben.
                  push(@old_v1, SizeOf(Boolean));
                  push(@old_v2, SizeOf(Boolean));
                  push(@old_x1, SizeOf(Double));
                  push(@old_y1, SizeOf(Double));
                  push(@old_x2, SizeOf(Double));
                  push(@old_y2, SizeOf(Double));
                  end;
                CheckLater := True;     // Vormerken !
                end;
              end;
            end;
          end
        else begin  // hier hoffentlich immer Children.Count = 1 !!!
          Result := Hypot(FPtList[0].X - (old_x1), FPtList[0].Y - (old_y1)) >
                    Hypot(FPtList[1].x - (old_x1), FPtList[1].Y - (old_y1));
          end
      else
        If TGeoObj(Parent[0]) is TGLongLine then
          Result := TGLongLine(Parent[0]).Reversed27;
      end;
    If imp_Data.is_empty then
      FreeAndNil(imp_Data);
    end;

  var buf : Integer;
  begin
  If ChildrenAreSwitched then begin
    If Children.Count >= 2 then begin
      buf                                 := TGIntersectPt(Children[0]).PtIndex;
      TGIntersectPt(Children[0]).PtIndex := TGIntersectPt(Children[1]).PtIndex;
      TGIntersectPt(Children[1]).PtIndex := buf;
      end
    else
      TGIntersectPt(Children[0]).PtIndex := 1;   // statt 0 !
    UpdateParams;  // Nur sich selbst neu updaten !
                   // Keinesfalls die nachfolgenden Objekte !!!
    end;
  end;


procedure TGDoubleIntersection.UpdateParams;
  var p1, p2    : TGLine;
      pK, pK2   : TGCircle;
      pMC, pMC2 : TGMappedCircle;
      pC2  : TGConic;
      pSL  : TGStraightLine;
      pu   : Double;
      e    : Integer;

  procedure Switch4closerMatch(k: TGLine);
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
      var n, i : Integer;
      begin
      n := 0;
      For i := 0 to Pred(Children.Count) do
        If TGeoObj(Children[i]) is TGIntersectPt then
          n := n + 1;
      Result := n < 2;
      end;

    begin { of Switch4closerMatch }
    e := ObjList.IndexOf(Self);
    If (Parent.Count > 2) and (Parent[2] <> Nil) then
      try     { den Punkt wählen, der *nicht* mit Parent[2] übereinstimmt   }
        vpx := TGPoint(Parent[2]).X;
        vpy := TGPoint(Parent[2]).Y;
        reverse := Hypot(FPtList[0].X - vpx, FPtList[0].Y - vpy) <
                   Hypot(FPtList[1].X - vpx, FPtList[1].Y - vpy);
      except  { falls Parent[2] nicht mehr existiert }
        Parent.Delete(2);
        If NoSecondPtYet then
          ObjList.InsertObject(TGIntersectPt.Create(ObjList, Self, 1, True), e);
        reverse := False;
      end
    else  { beide Punkte verfügbar }
      If ObjList.DragStrategy = 1 then begin { Stetigkeit hat Vorrang ! }
        k.GetParamFromCoords(FPtList[0].X, FPtList[0].Y, new_tv1);
        k.GetParamFromCoords(FPtList[1].X, FPtList[1].Y, new_tv2);
        If tv1 + tv2 >= 0 then { Falls alte Werte vorhanden sind :  }
          reverse := ctv_dist(new_tv1, tv2) + ctv_dist(new_tv2, tv1) <
                     ctv_dist(new_tv1, tv1) + ctv_dist(new_tv2, tv2)
        else                   { Noch keine alten Werte verfügbar ! }
          reverse := False;
        end
      else                               { Reversibilität hat Vorrang ! }
        reverse := False;                { Normalfall !!! }

    { In jedem Fall: relative Positionen abspeichern, aber mit der  }
    {    korrekten Zuordnung: tv1 enthält stets das TV des im       }
    {    ersten TGIntersectPt-Objekt aktiven Punktes !              }
    If reverse then begin
      pu := FPtList[0].X; FPtList[0].X := FPtList[1].X; FPtList[1].X := pu;
      pu := FPtList[0].Y; FPtList[0].Y := FPtList[1].Y; FPtList[1].Y := pu;
      iv_buf := FValidList[0]; FValidList[0] := FValidList[1]; FValidList[1] := iv_buf;
      tv1 := new_tv2;
      tv2 := new_tv1;
      end
    else begin
      k.GetParamFromCoords(FPtList[0].X, FPtList[0].Y, tv1);
      k.GetParamFromCoords(FPtList[1].X, FPtList[1].Y, tv2);
      end;
    end;   { of Switch4closerMatch }

  procedure CheckSolutions;
    begin
    FValidList[0] := FValidList[0] and
                     p1.Includes (FPtList[0].X, FPtList[0].Y) and
                     p2.Includes(FPtList[0].X, FPtList[0].Y);
    FValidList[1] := FValidList[1] and
                     p1.Includes(FPtList[1].X, FPtList[1].Y) and
                     p2.Includes(FPtList[1].X, FPtList[1].Y);
    If FValidList[0] and FValidList[1] and (Not CheckLater) then
      Switch4closerMatch(p2);
    {27.04.03: Der Aufruf von Switch4closerMatch wurde erst *nach* der
               Feinjustierung von FValidList[0] und FValidList[1] einge-
    fügt statt davor. Dies hat zur Folge, dass eine Halbgerade, die in
    einem Kreis beginnt, immer einen ersten *ungültigen* und einen
    zweiten *gültigen* Schnittpunkt mit diesem Kreis hat.            }
    end;

  procedure IntersectWithDegeneratedCircle;
    begin
    pMC2 := TGMappedCircle(p2);
    If p1 is TGStraightLine then begin { Der 1. Elter ist eine gerade Linie }
      pSL := TGStraightLine(p1);
      IntersectLines(pSL.X1, pSL.Y1, pSL.X2, pSL.Y2, pMC2.X1, pMC2.Y1, pMC2.X2, pMC2.Y2,
                     FPtList[0].X, FPtList[0].Y, FValidList[0]);
      FValidList[1] := False;
      end
    else if (p1 is TGMappedCircle) and TGMappedCircle(p1).IsDegenerated then begin
      pMC := TGMappedCircle(p1);    { Sonderfall : entarteter Kreis !       }
      IntersectLines(pMC.X1, pMC.Y1, pMC.X2, pMC.Y2, pMC2.X1, pMC2.Y1, pMC2.X2, pMC2.Y2,
                               FPtList[0].X, FPtList[0].Y, FValidList[0]);
      FValidList[1] := False;
      end
    else begin                      { andernfalls ist er ein echter Kreis ! }
      pK := TGCircle(p1);
      IntersectCircleWithLine (pK.X1, pK.Y1, pK.Radius, pMC2.X1, pMC2.Y1, pMC2.X2, pMC2.Y2,
                        FPtList[0].X, FPtList[0].Y, FPtList[1].X, FPtList[1].Y,
                        FValidList[0], FValidList[1]);
      end;
    CheckSolutions;
    end;

  procedure IntersectWithNormalCircle;
    begin
    pK2 := TGCircle(Parent[1]);
    If p1 is TGStraightLine then begin { Der 1. Elter ist eine gerade Linie }
      pSL := TGStraightLine(p1);
      IntersectCircleWithLine (pK2.X1, pK2.Y1, pK2.Radius, pSL.X1, pSL.Y1, pSL.X2, pSL.Y2,
                               FPtList[0].X, FPtList[0].Y, FPtList[1].X, FPtList[1].Y,
                               FValidList[0], FValidList[1]);
      end
    else if (p1 is TGMappedCircle) and TGMappedCircle(p1).IsDegenerated then begin
      pMC := TGMappedCircle(p1);    { Sonderfall : entarteter Kreis !       }
      IntersectCircleWithLine (pK2.X1, pK2.Y1, pK2.Radius, pMC.X1, pMC.Y1, pMC.X2, pMC.Y2,
                               FPtList[0].X, FPtList[0].Y, FPtList[1].X, FPtList[1].Y,
                               FValidList[0], FValidList[1]);
      end
    else begin                      { andernfalls ist er ein echter Kreis ! }
      pK := TGCircle(p1);
      IntersectCircles (pK.X1, pK.Y1, pK.Radius, pk2.X1, pK2.Y1, pK2.Radius,
                        FPtList[0].X, FPtList[0].Y, FPtList[1].X, FPtList[1].Y,
                        FValidList[0], FValidList[1]);
      end;
    CheckSolutions;
    end;

  procedure IntersectWithConic;
    begin
    pC2 := TGConic(parent[1]);
    If p1 is TGStraightLine then begin
      pC2.IntersectWithLine((p1 as TGStraightLine).HesseEq,
                            FPtList[0].X, FPtList[0].Y,
                            FPtList[1].X, FPtList[1].Y,
                            FValidList[0], FValidList[1]);
      If FValidList[0] and FValidList[1] then begin
        If (p1.X2 - p1.X1) * (FPtList[1].x - FPtList[0].x) +
           (p1.Y2 - p1.Y1) * (FPtList[1].y - FPtList[0].y) < 0 then begin
          pu := FPtList[0].x; FPtList[0].x := FPtList[1].x; FPtList[1].x := pu;
          pu := FPtList[0].y; FPtList[0].y := FPtList[1].y; FPtList[1].y := pu;
          end;
        FValidList[0] := p1.Includes (FPtList[0].X, FPtList[0].Y);
        FValidList[1] := p1.Includes (FPtList[1].X, FPtList[1].Y);
        end;
      If FValidList[0] and FValidList[1] and (Not CheckLater) then
        Switch4closerMatch(pC2);
      end;
    end;

  begin
  FValidList[0] := False;
  FValidList[1] := False;
  p1  := Parent[0]; // Gerade Linie oder Kreis (wenn p2 auch ein Kreis ist!)
  p2  := Parent[1]; // Stets Kreis oder Kegelschnitt
  If (p2 <> Nil) and (p1 <> Nil) and p2.DataValid and p1.DataValid then
    If p2 is TGCircle then  // Der 2. Elter ist ein Kreis, und zwar....
      If (p2 is TGMappedCircle) and    // ... ein degenerierter Kreis
         TGMappedCircle(p2).IsDegenerated then
        IntersectWithDegeneratedCircle
      else                             // ... echter Kreis
        IntersectWithNormalCircle
    else                    // Der 2. Elter ist ein Kegelschnitt
      IntersectWithConic;
  If CheckLater and
     (FValidList[0] or FValidList[1]) then begin
    CheckOrientation;
    CheckLater := False;
    end;
  DataValid := True;  // Immer !!!
  end;

procedure TGDoubleIntersection.UpdateScreenCoords;
  begin
  // Nothing to do!
  end;


procedure TGDoubleIntersection.SaveState;
  var i : Integer;
  begin
  Old_Data.push(@FStatus, SizeOf(FStatus));
  For i := 0 to High(FPtList) do begin
    Old_Data.push(@FValidList[i], SizeOf(Boolean));
    Old_Data.push(@FPtList[i].X, SizeOf(Double));
    Old_Data.push(@FPtList[i].Y, SizeOf(Double));
    end;
  end;

procedure TGDoubleIntersection.RestoreState;
  var i : Integer;
  begin
  For i := High(FPtList) downTo 0 do begin
    Old_Data.pop(@FPtList[i].Y);
    Old_Data.pop(@FPtList[i].X);
    Old_Data.pop(@FValidList[i]);
    end;
  Old_Data.pop(@FStatus);
  end;

procedure TGDoubleIntersection.DrawIt;
  begin
  end;

procedure TGDoubleIntersection.HideIt;
  begin
  end;

procedure TGDoubleIntersection.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  end;

function TGDoubleIntersection.GetInfo: String;
  begin
  Result := '';
  end;


{--------------------------------------------------}
{ TGQuadIntersection's method implementation       }
{--------------------------------------------------}

constructor TGQuadIntersection.Create(iObjList: TGeoObjListe;
                                        iS1, iS2: TGeoObj;
                                        CheckP3: Boolean = False);
  begin
  Inherited Create(iObjList, iS1, iS2, False);
  SetLength(FPtList   , 4);
  SetLength(FValidList, 4);
  CheckExistingIPs;
  UpdateParams;
  end;


constructor TGQuadIntersection.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  SetLength(FPtList   , 4);
  SetLength(FValidList, 4);
  end;


constructor TGQuadIntersection.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var s : String;
      i : Integer;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  SetLength(FPtList   , 4);
  SetLength(FValidList, 4);
  s := DE.childNodes.findNode('pointlist', '').NodeValue;
  For i := 0 to 3 do
    GetFloatPair(s, FPtList[i].X, FPtList[i].Y);
  end;


function TGQuadIntersection.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  { nachgerüstet am 05.05.13:
    Multi-Intersection-Objekte werden nur abgespeichert, wenn sie mindestens
    einen Schnittpunkt verwalten; dies soll verhindern, dass funktionslose
    und eventuell defekte Multi-Intersection-Objekte in der GEO-Datei über-
    leben und dann später wieder revalidiert werden.                       }
  var old_domPtList,
      domPtList : IXMLNode;
      s         : String;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  if Result <> nil then begin     {*}
    old_domPtList := Result.childNodes.findNode('pointlist', '');
    domPtList := DOMDoc.createNode('pointlist');
    s := FloatToStr(FPtList[0].X) + ';' + FloatToStr(FPtList[0].Y) + ' ' +
         FloatToStr(FPtList[1].X) + ';' + FloatToStr(FPtList[1].Y) + ' ' +
         FloatToStr(FPtList[2].X) + ';' + FloatToStr(FPtList[2].Y) + ' ' +
         FloatToStr(FPtList[3].X) + ';' + FloatToStr(FPtList[3].Y);
    domPtList.setNodeValue(s);
    Result.childNodes.replaceNode(old_domPtList, domPtList);
    end;
  end;


procedure TGQuadIntersection.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  var i : Integer;
  begin
  SetLength(FPtList   , 4);
  SetLength(FValidList, 4);
  For i := 0 to 3 do
    OIPP[i] := -1;
  end;


procedure TGQuadIntersection.AfterLoading(FromXML: Boolean = True);
  var CO : TGIntersectPt;  // "C"hild "O"bject
      i  : Integer;
  begin
  Inherited AfterLoading(FromXML);
  For i := 0 to Pred(Children.Count) do begin
    CO := Children[i];
    FValidList[CO.PtIndex] := CO.Age < epsilon;
    end;
  For i := 0 to 3 do
    If VariantValid[i] then
      TGConic(Parent[1]).GetParamFromCoords(VariantPt[i].x, VariantPt[i].y, OIPP[i])
    else
      OIPP[i] := -1;
  end;


procedure TGQuadIntersection.DrawIt;
  begin
{$IFOPT R+} // Beta-Test-Version
  With ObjList.TargetCanvas do begin
    Brush.Color := ObjList.BackgroundColor;
    Brush.Style := bsSolid;
    Pen.Color := clBlack;
    TextOut(10, 10, s);
    end;
{$ENDIF}
  end;  

function  TGQuadIntersection.PreExistingIntersectionPtCount: Integer;
  begin
  Result := Parent.Count - 2;
  end;

function  TGQuadIntersection.ParamDist(p1, p2: Double): Double;
  var d : Double;
  begin
  If p1 < 0 then
    p1 := - 1 - p1;
  If p2 < 0 then
    p2 := - 1 - p2;
  d := Abs(p2 - p1);
  If d <= 0.5 then
    Result := d
  else
    Result := 1 - d;
  end;


procedure TGQuadIntersection.SortPointList;
  var NIPP   : Array [0..3] of Double;   // "N"ew "I"ntersection "P"oint "P"aram
      dist   : Array [0..3, 0..3] of Double;    // "dist"ance matrix
      perm   : Array [0..3] of Integer;  // Permutation:  Perm[i] = k   <=>
                                         // VariantPt[k] muss mit den Daten
                                         // aus VariantPt[i] gefüllt werden
      IPCBuf : Array [0..3] of TFloatPoint;   // Puffervariablen
      IPVBuf : Array [0..3] of Boolean;       //   fürs Permutieren
      k, i   : Integer;                  // Schleifen-Variablen

  procedure Sort5;
    var old_used,
        new_used : Array [0..3] of Boolean;
        MinDist  : Double;
        ovip,
        nvip,
        k_min,
        i_min,
        k, i     : Integer;

    begin
    ovip := 4;
    nvip := 4;
    For i := 0 to 3 do begin
      If OIPP[i] < 0 then Dec(ovip);
      If NIPP[i] < 0 then Dec(nvip);
      old_used[i] := False;
      new_used[i] := False;
      Perm[i] := -1;
      end;
    If nvip <= ovip then begin
      Repeat
        MinDist := 1e10;
        i_min := -1;
        k_min := -1;
        For k := 0 to 3 do
          If (NIPP[k] >= 0) and
             (Not new_used[k]) then
            For i := 0 to 3 do
              If (OIPP[i] >= 0) and
                 (Not old_used[i]) and
                 (Dist[i, k] < MinDist) then begin
                i_min := i;
                k_min := k;
                MinDist := Dist[i, k];
                end;
        If (i_min >= 0) and (k_min >= 0) then begin
          old_used[i_min] := True;
          new_used[k_min] := True;
          Perm[i_min] := k_min;
          end;
      until (i_min < 0) or (k_min < 0);
      Repeat
        MinDist := 1e10;
        i_min := -1;
        k_min := -1;
        For i := 0 to 3 do
          If (Not old_used[i]) then
            For k := 0 to 3 do
              If (Not new_used[k]) and
                 (Dist[i, k] < MinDist) then begin
                i_min := i;
                k_min := k;
                MinDist := Dist[i, k];
                end;
        If (i_min >= 0) and (k_min >= 0) then begin
          old_used[i_min] := True;
          new_used[k_min] := True;
          Perm[i_min] := k_min;
          end;
      until (i_min < 0) or (k_min < 0);
      end
    else begin
      Repeat
        MinDist := 1e10;
        i_min := -1;
        k_min := -1;
        For i := 0 to 3 do
          If (OIPP[i] >= 0) and
             (Not old_used[i]) then
            For k := 0 to 3 do
              If (NIPP[k] >= 0) and
                 (Not new_used[k]) and
                 (Dist[i, k] < MinDist) then begin
                i_min := i;
                k_min := k;
                MinDist := Dist[i, k];
                end;
        If (i_min >= 0) and (k_min >= 0) then begin
          old_used[i_min] := True;
          new_used[k_min] := True;
          Perm[i_min] := k_min;
          end;
      until (i_min < 0) or (k_min < 0);
      Repeat
        MinDist := 1e10;
        i_min := -1;
        k_min := -1;
        For i := 0 to 3 do
          If (Not old_used[i]) then
            For k := 0 to 3 do
              If (Not new_used[k]) and
                 (Dist[i, k] < MinDist) then begin
                i_min := i;
                k_min := k;
                MinDist := Dist[i, k];
                end;
        If (i_min >= 0) and (k_min >= 0) then begin
          old_used[i_min] := True;
          new_used[k_min] := True;
          Perm[i_min] := k_min;
          end;
      until (i_min < 0) or (k_min < 0);
      end;
    end;

  begin
  { Parameterwerte der neuen Lage laden }
  For i := 0 to 3 do
    If VariantValid[i] then
      TGConic(Parent[1]).GetParamFromCoords(VariantPt[i].x, VariantPt[i].y, NIPP[i])
    else
      If OIPP[i] < 0 then         // Lösung war schon zuvor ungültig
        NIPP[i] := OIPP[i]        //  => alten Wert aufbewahren !
      else
        NIPP[i] := -1 - OIPP[i];  // Lösung ist gerade ungültig geworden

  { Distanz-Matrix füllen }
  For i := 0 to 3 do              // x-Richtung : alte Parameter
    For k := 0 to 3 do            // y-Richtung : neue Parameter
      dist[i, k] := ParamDist(OIPP[i], NIPP[k]);

  { Permutation mit kürzester Distanzsumme suchen }
  sort5;

  { Punkt-Positionen vertauschen }
  For i := 0 to 3 do begin            // Erst permutiert in die Puffer...
    IPVBuf[i] := FValidList[perm[i]];
    If IPVBuf[i] then
      IPCBuf[i] := FPtList[perm[i]]
    else
      TGConic(Parent[1]).GetCoordsFromParam(NIPP[perm[i]], IPCBuf[i].X, IPCBuf[i].Y);
    end;
  For i := 0 to 3 do begin            // ... dann alle Daten zurückschreiben
    FValidList[i] := IPVBuf[i];
    FPtList[i]    := IPCBuf[i];
    OIPP[i]       := NIPP[perm[i]];   // Alte Parameter-Werte merken !
    end;
  end;


(*
procedure TGQuadIntersection.SortPointList;
  { Sortiert die errechneten Schnittpunkte unter Berücksichtigung der
    Abstände zu den alten Lagen. Nach einer Idee von Hohenwarter (siehe
    "GeoGebra", S. 167 ff.) werden dabei ungültige Punkte mit einem
    zusätzlichen z-Abstand zur Zeichenebene bewertet, was sie "in die
    Ferne" rückt. Es wird die Abstandssumme für alle Permutationen der
    Zuordnung der neuen zu den alten Punktlagen errechnet, so dass das
    gefundene Minimum echt ist.
    --------------------------------------

    überarbeitet am 27.11.06 :
    regänzt um die Verwaltung der schon vor der Erstellung des Schnitt-
    Objekts vorhandenen Schnittpunkte; diese werden in FPtList und
    FValidList stets nach hinten geschoben.                           }

  procedure ExchangeResults(i, j : Integer);
    var f_buf : TFloatPoint;
        b_buf : Boolean;
    begin
    f_buf      := FPtList[i];
    FPtList[i] := FPtList[j];
    FPtList[j] := f_buf;
    b_buf         := FValidList[i];
    FValidList[i] := FValidList[j];
    FValidList[j] := b_buf;
    end;

  procedure Sort4;
    const Permu4   : Array [0..23, 0..3] of Integer =
                      ((0, 1, 2, 3), (0, 1, 3, 2), (0, 2, 1, 3), (0, 2, 3, 1),
                       (0, 3, 1, 2), (0, 3, 2, 1), (1, 0, 2, 3), (1, 0, 3, 2),
                       (1, 2, 0, 3), (1, 2, 3, 0), (1, 3, 0, 2), (1, 3, 2, 0),
                       (2, 0, 1, 3), (2, 0, 3, 1), (2, 1, 0, 3), (2, 1, 3, 0),
                       (2, 3, 0, 1), (2, 3, 1, 0), (3, 0, 1, 2), (3, 0, 2, 1),
                       (3, 1, 0, 2), (3, 1, 2, 0), (3, 2, 0, 1), (3, 2, 1, 0));
    var PtDist     : Array [0..3, 0..3] of Double;
           { x-Richtung: Schnittpunktobjekte;  y-Richtung: Neuberechnete Punkte }
        DistSum    : Array [0..23] of Double;
        maxDist,
        minDist    : Double;
        i, k       : Integer;
    begin
    maxDist := 0;
    For i := 0 to 3 do
      For k := 0 to 3 do
        If FValidList[k] then begin
          PtDist[i, k] := TGIntersectPt(Children[i]).GetDisplacement(FPtList[k]);
          If PtDist[i, k] > maxDist then
            maxDist := PtDist[i, k];
          end
        else
          PtDist[i, k] := -1;
    maxDist := maxDist * 1.1;
    For i := 0 to 3 do
      For k := 0 to 3 do
        If PtDist[i, k] < 0 then
          PtDist[i, k] := maxDist;
    For i := 0 to 23 do begin
      DistSum[i] := 0;
      For k := 0 to 3 do
        DistSum[i] := DistSum[i] + PtDist[k, Permu4[i, k]];
      end;
    minDist := DistSum[0];
    k := 0;
    For i := 1 to 23 do
      If DistSum[i] < minDist then begin
        k := i;
        minDist := DistSum[i];
        end;
    If k > 0 then begin              { Also führt die k-te Permutation  }
      For i := 0 to 3 do begin       {   zur minimalen Abstandssumme !  }
        PtDist[i, 0] := FPtList[Permu4[k,i]].x;
        PtDist[i, 1] := FPtList[Permu4[k,i]].y;
        If FValidList[Permu4[k,i]] then PtDist[i, 2] := 1 else PtDist[i, 2] := 0;
        end;
      For i := 0 to 3 do begin
        FPtList[i].x := PtDist[i, 0];
        FPtList[i].y := PtDist[i, 1];
        FValidList[i] := PtDist[i, 2] > 0.5;
        end;
      end;
    end;  { of Sort4 }

  procedure Sort3;
    const Permu3   : Array [0..5, 0..2] of Integer =
                      ((0, 1, 2), (0, 2, 1),
                       (1, 0, 2), (1, 2, 0),
                       (2, 0, 1), (2, 1, 0));
    var PtDist     : Array [0..2, 0..2] of Double;
           { x-Richtung: Schnittpunktobjekte;  y-Richtung: Neuberechnete Punkte }
        DistSum    : Array [0..5] of Double;
        maxDist,
        minDist    : Double;
        i, k       : Integer;
    begin
    maxDist := 0;
    For i := 0 to 2 do
      For k := 0 to 2 do
        If FValidList[k] then begin
          PtDist[i, k] := TGIntersectPt(Children[i]).GetDisplacement(FPtList[k]);
          If PtDist[i, k] > maxDist then
            maxDist := PtDist[i, k];
          end
        else
          PtDist[i, k] := -1;
    maxDist := maxDist * 1.1;
    For i := 0 to 2 do
      For k := 0 to 2 do
        If PtDist[i, k] < 0 then
          PtDist[i, k] := maxDist;
    For i := 0 to 5 do begin
      DistSum[i] := 0;
      For k := 0 to 2 do
        DistSum[i] := DistSum[i] + PtDist[k, Permu3[i, k]];
      end;
    minDist := DistSum[0];
    k := 0;
    For i := 1 to 5 do
      If DistSum[i] < minDist then begin
        k := i;
        minDist := DistSum[i];
        end;
    If k > 0 then begin              { Also führt die k-te Permutation  }
      For i := 0 to 2 do begin       {   zur minimalen Abstandssumme !  }
        PtDist[i, 0] := FPtList[Permu3[k,i]].x;
        PtDist[i, 1] := FPtList[Permu3[k,i]].y;
        If FValidList[Permu3[k,i]] then PtDist[i, 2] := 1 else PtDist[i, 2] := 0;
        end;
      For i := 0 to 2 do begin
        FPtList[i].x := PtDist[i, 0];
        FPtList[i].y := PtDist[i, 1];
        FValidList[i] := PtDist[i, 2] > 0.5;
        end;
      end;
    end;  { of Sort3 }

  procedure Sort2;
    var dsa, dsb : Double;
    begin
    dsa := TGIntersectPt(Children[0]).GetDisplacement(FPtList[0]) +
           TGIntersectPt(Children[1]).GetDisplacement(FPtList[1]);
    dsb := TGIntersectPt(Children[0]).GetDisplacement(FPtList[1]) +
           TGIntersectPt(Children[1]).GetDisplacement(FPtList[0]);
    If Abs(dsb) < Abs(dsa) then
      ExchangeResults(0, 1);
    end;

  procedure SortExistingIntersectionPoints;
    var PPO     : TGPoint;
        Dist,
        MinDist : Double;
        mdi,       // "M"in "D"ist "I"ndex
        i, j    : Integer;
    begin
    For i := 2 to Pred(Parent.Count) do begin
      PPO := TGeoObj(Parent[i]) as TGPoint;
      mdi := -1;
      MinDist := 1e20;
      For j := 0 to 5 - i do
        If FValidList[j] then begin
          Dist := Hypot(PPO.X - FPtList[j].x, PPO.Y - FPtList[j].y);
          If Dist < MinDist then begin
            MinDist := Dist;
            mdi := j;
            end;
          end;
      If (mdi >= 0) and (mdi <> 5-i) then
        ExchangeResults(mdi, 5-i);
      end;
    end;  { of RegisterExistingIntersectionPoints }

  begin { of SortPointList }
  SortExistingIntersectionPoints;
  Case Children.Count of
    2 : Sort2;
    3 : Sort3;
    4 : Sort4;
  end;  { of case }
  end;  { of SortPointList }
*)

procedure TGQuadIntersection.UpdateParams;
  var p1  : TGLine;
      p2  : TGConic;
      pC  : TGConic;
      pK  : TGCircle;
      pMK : TGMappedCircle;
      pSL : TGStraightLine;
      CaCo: TCoeff6;
      gv  : TVector3;
      i   : Integer;
  begin
  { Parameterwerte der alten Lage speichern }
  For i := 0 to 3 do
    If VariantValid[i] then
      TGConic(Parent[1]).GetParamFromCoords(VariantPt[i].x, VariantPt[i].y, OIPP[i])
    else
      If OIPP[i] > 0 then         // Lösung ist gerade ungültig geworden
        OIPP[i] := -1 - Frac(Abs(OIPP[i]))
      else;                       // Andernfalls: alten Wert behalten !

  For i := 0 to 3 do
    FValidList[i] := False;
  p1 := TGeoObj(Parent[0]) as TGLine;  { Der 1. Elter kann irgend eine Linie sein, }
  p2 := TGeoObj(Parent[1]) as TGConic; { der 2. ist immer ein Kegelschnitt !       }
  If (p1 <> Nil) and p1.DataValid and
     (p2 <> Nil) and p2.DataValid then begin
    If p1 is TGConic then begin         // Der 1. Elter ist auch ein Kegelschnitt
      pC := TGConic(P1);
      IntersectConics(pC.coeff, p2.coeff, FPtList,
                      FValidList[0], FValidList[1], FValidList[2], FValidList[3]);
      end
    else if (p1 is TGMappedCircle) and  // Der 1. Elter ist ein degenerierter Kreis
            TGMappedCircle(p1).IsDegenerated then begin
      pMK := p1 as TGMappedCircle;
      gv := TVector3.Create(0, 0, 0);
      try
        pMK.GetDataVector(gv);
        IntersectConicWithLine(p2.coeff, gv,
                               FPtList[0].X, FPtList[0].Y, FPtList[1].X, FPtList[1].Y,
                               FValidList[0], FValidList[1]);
      finally
        gv.Free;
      end;
      For i := 0 to 1 do
        FValidList[i] := FValidList[i] and
                         pMK.Includes (FPtList[i].X, FPtList[i].Y);
      end
    else if p1 is TGCircle then begin   // Der 1. Elter ist ein echtes Kreisobjekt
      pK := TGCircle(p1);               //  (kann übrigens auch ein Bogen sein!)
      pK.GetConicCoeff(CaCo);
      IntersectConics(CaCo, p2.coeff, FPtList,
                      FValidList[0], FValidList[1], FValidList[2], FValidList[3]);
      For i := 0 to 3 do
        FValidList[i] := FValidList[i] and
                         pK.Includes (FPtList[i].X, FPtList[i].Y);
      end
    else begin                          // Der 1. Elter ist eine gerade Linie
      pSL := TGStraightLine(p1);
      gv := TVector3.Create(0, 0, 0);
      try
        pSL.GetDataVector(gv);
        IntersectConicWithLine(p2.coeff, gv,
                               FPtList[0].X, FPtList[0].Y, FPtList[1].X, FPtList[1].Y,
                               FValidList[0], FValidList[1]);
      finally
        gv.Free;
      end;
      For i := 0 to 1 do
        FValidList[i] := FValidList[i] and
                         pSL.Includes (FPtList[i].X, FPtList[i].Y);
      end;
    end;
  SortPointList;
  DataValid := True;  // Immer! Über die Details entscheidet ValidList[] !
  end;


{-------------------------------------------}
{ TGPolygon's Methods Implementation        }
{-------------------------------------------}

constructor TGPolygon.Create(iObjList: TGeoObjListe; iVertexList: TList; iis_visible: Boolean);
  var i : Integer;
  begin
  Inherited Create(iObjList, iis_visible);
  F_CCTP := False;
  If iVertexList <> Nil then begin
    For i := 0 to iVertexList.Count-2 do
      BecomesChildOf(iVertexList.Items[i]);
    If BorderOrientation < 0 then
      If SignedAreas then
        IsReversed := True
      else
        ReverseParentList;
    SetLength(IntPointLists, 1, Succ(Parent.Count));
    UpdateParams;
    DrawIt;
    Set_CBDI;
    end;
  end;

destructor TGPolygon.Destroy;
  begin
  IntPointLists := Nil;
  Inherited Destroy;
  end;

constructor TGPolygon.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  If ClassType = TGPolygon then
    SetLength(IntPointLists, 1, Succ(Parent.Count));
  end;

constructor TGPolygon.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  If GO <> Nil then
    SetLength(IntPointLists, 1, Succ(Parent.Count));
  end;

constructor TGPolygon.CreateFromBlueprint(iObjList: TGeoObjListe;
                                          MakNum, CmdNum: Integer);
  begin
  Inherited CreateFromBluePrint(iObjList, MakNum, CmdNum);
  Set_CBDI;
  end;

constructor TGPolygon.Load32(R: TReader; iObjList: TGeoObjListe);
  var i, ix, iy : Integer;
  begin
  Inherited Load32(R, iObjList);
  MyBrushStyle := TBrushStyle(R.ReadInteger);
  SetLength(IntPointLists, 1, Succ(Parent.Count));
  i := 0;
  R.ReadListBegin;
  While Not R.EndOfList do begin
    ix := R.ReadInteger;
    iy := R.ReadInteger;
    IntPointLists[0,i] := Point(ix, iy);
    Inc(i);
    end;
  R.ReadListEnd;
  end;

function TGPolygon.HasSameDataAs(GO: TGeoObj): Boolean;
  { Die Ecken müssen bei einem kompletten Umlauf in der Reihenfolge
    übereinstimmen, nicht aber in der genauen Anordnung:
    ABCDE und DEABC sind gleich, aber ABCDE und BACDE sind verschieden.
    01.08.03:  Nachgerüstet, dass auch ABCD und DCBA als gleich gelten ! }

  function SameCornersAs(AP: TGPolygon): Boolean;
    { Überprüft, ob die Eltern in beiden Parent-Listen übereinstimmen
      und in der gleichen relativen Reihenfolge auftreten; dabei werden
      die beiden Listen als zyklisch geschlossen aufgefaßt. }
    var n, i : Integer;
    begin
    Result := True;
    n := AP.Parent.IndexOf(Parent[0]);
    If n >= 0 then begin
      For i := 1 to Pred(Parent.Count) do begin
        n := (n + 1) Mod AP.Parent.Count;
        If AP.Parent[n] <> Parent[i] then
          Result := False;
        end;
      If Not Result then begin
        Result := True;
        n := AP.Parent.IndexOf(Parent[0]);
        For i := Pred(Parent.Count) downto 1 do begin
          n := (n + 1) Mod AP.Parent.Count;
          If AP.Parent[n] <> Parent[i] then
            Result := False;
          end;
        end;
      end
    else
      Result := False;
    end;

  begin { of HasSameDataAs }
  Result := (GO.ClassType = TGPolygon) and
            (GO.Parent.Count = Parent.Count) and
            SameCornersAs(GO as TGPolygon);
  end;  { of HasSameDataAs }


function TGPolygon.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('N');
  end;


function TGPolygon.GetVCount: Integer;
  begin
  Result := Parent.Count;
  end;

procedure TGPolygon.SetMyColour(NewCol: TColor);
  var i   : Integer;
      seg : TGLine;
      fill: TGArea;
  begin
  Inherited SetMyColour(NewCol);
  For i := 0 to Pred(VCount) do begin
    seg := GetSegmentObj(i);
    if seg <> Nil then
      seg.MyColour := NewCol;
    end;
  If IsFilled(fill) then
    fill.MyColour := LightCol(NewCol);
  end;

procedure TGPolygon.SetIsFlagged(flag: Boolean);
  var i : Integer;
  begin
  If (ObjList.DraggedObj is TGArea) and
     (ObjList.DraggedObj.Parent[0] = Self) then
    For i := 0 to Pred(Parent.Count) do
      If (TGPoint(Parent[i]).Parent.Count = 0) and
         (TGPoint(Parent[i]).Friends.Count = 0) then
      TGeoObj(Parent[i]).IsFlagged := flag;
  Inherited SetIsFlagged(flag);
  end;

procedure TGPolygon.SetShowsAlways(vis: Boolean);
  var i   : Integer;
      seg : TGLine;
      fill: TGArea;
  begin
  Inherited SetShowsAlways(vis);
  For i := 0 to Pred(Parent.Count) do
    TGeoObj(Parent.Items[i]).ShowsAlways := vis;
  For i := 0 to Pred(VCount) do begin
    seg := GetSegmentObj(i);
    if seg <> Nil then
      seg.ShowsAlways := vis;
    end;
  If IsFilled(fill) then
    fill.ShowsAlways := vis;
  end;

procedure TGPolygon.SetIsGrouped(flag: Boolean);
  var i   : Integer;
      seg : TGLine;
      fill: TGArea;
  begin
  Inherited SetIsGrouped(flag);
  For i := 0 to Pred(Parent.Count) do
    TGeoObj(Parent.Items[i]).IsGrouped := flag;
  for i := 0 to Pred(VCount) do begin
    seg := GetSegmentObj(i);
    if seg <> Nil then
      seg.IsGrouped := flag;
    end;
  If IsFilled(fill) then
    fill.IsGrouped := flag;
  end;

procedure TGPolygon.SetIsBlinking(flag: Boolean);

  function GetShortLineWithParents(P1, P2: TGPoint) : TGShortLine;
    var i : Integer;
    begin
    Result := Nil;
    i := 5;
    While (Result = Nil) and (i < ObjList.LastValidObjIndex) do
      If (TGeoObj(ObjList.Items[i]) is TGShortLine) and
         (TGeoObj(ObjList.Items[i]).Parent.IndexOf(P1) >= 0) and
         (TGeoObj(ObjList.Items[i]).Parent.IndexOf(P2) >= 0) then
        Result := TGShortLine(ObjList.Items[i])
      else
        i := i + 1;
    end;

  procedure SetBorderBlinking;
    var i    : Integer;
        List : TList;
        L    : TGShortLine;
    begin
    list := TList.Create;
    try
      For i := 0 to Pred(Parent.Count) do begin
        L := GetShortLineWithParents(Parent[i], Parent[(i+1) Mod Parent.Count]);
        If L <> Nil then
          List.Add(L);
        end;
      For i := 0 to Pred(List.Count) do
        TGShortLine(List.Items[i]).IsBlinking := flag;
    finally
      List.Free;
    end; { of try }
    end;

  begin
  If IsBlinking <> flag then begin
    If flag then
      FStatus := FStatus or gs_IsBlinking
    else
      FStatus := FStatus and Not gs_IsBlinking;
    SetBorderBlinking;
    end;
  end;

procedure TGPolygon.ReverseParentList;
  var vorne, hinten : Integer;
  begin
  vorne  := 0;
  hinten := Pred(Parent.Count);
  While vorne < hinten do begin
    Parent.Exchange(vorne, hinten);
    Inc(vorne);
    Dec(hinten);
    end;
  end;

procedure TGPolygon.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  SetLength(IntPointLists, 1, Succ(Parent.Count));
  end;

procedure TGPolygon.AfterLoading(FromXML: Boolean = False);
  var mask, i   : Integer;
      seg       : TGLine;
  { Wenn alle Seiten eines Polygons in der gleichen Sichtbarkeitsgruppe
    enthalten sind, dann muss auch das Polygon selbst zu dieser Gruppe
    hinzugefügt werden. Der folgende Code stellt dies sicher.
    ( Bugmeldung von Frau Friebe vom 25.11.08 bzw. 12.01.09 ) }
  begin
  UpdateParams;
  If ShowsAlways then begin
    mask   := -1;   // Alle Bits setzen !
    For i := 0 to Pred(VCount) do begin
      seg := GetSegmentObj(i);
      if (seg <> Nil) and (seg.Groups > 0) then
        mask := mask and seg.Groups;
      end;
    if (mask > 0) then
      Self.FGroups := Self.FGroups or mask;
    end;
  end;

procedure TGPolygon.SaveState;
  begin
  Old_Data.push(@FStatus, SizeOf(FStatus));
  Old_Data.push(@area, SizeOf(area));
  Old_Data.push(@IntPointLists[0,0],
                SizeOf(TPoint)*Succ(High(IntPointLists[0])));
  end;

procedure TGPolygon.RestoreState;
  begin
  Old_Data.pop(@IntPointLists[0,0]);
  Old_Data.pop(@area);
  Old_Data.pop(@FStatus);
  end;

procedure TGPolygon.UpdateParams;
  var i         : Integer;
      FloatPoly : TFloatPointList;
  begin
  DataValid := True;
  For i := 0 to Pred(Parent.Count) do
    If Not TGeoObj(Parent[i]).DataValid then
      DataValid := False;
  If DataValid then begin
    SetLength(FloatPoly, Succ(Parent.Count));
    For i := 0 to Pred(Parent.Count) do begin
      FloatPoly[i].x := TGPoint(Parent[i]).X;
      FloatPoly[i].y := TGPoint(Parent[i]).Y;
      end;
    FloatPoly[Parent.Count] := FloatPoly[0];
    GetCentreOfGravity_2DPolyInt(Parent.Count, FloatPoly,
                                 X, Y, area);
    FloatPoly := Nil;
    UpdateScreenCoords;
    end;
  end;

procedure TGPolygon.UpdateScreenCoords;
  var i : Integer;
  begin
  If DataValid then begin
    For i := 0 to Pred(Parent.Count) do
      IntPointLists[0,i] := Point(TGPoint(Parent[i]).scrx,
                                  TGPoint(Parent[i]).scry);
    IntPointLists[0, Parent.Count] := IntPointLists[0, 0];
    ObjList.GetWinCoords(X, Y, scrx, scry);
    DataCanShow := True;
    end;
  end;

function TGPolygon.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var i      : Integer;
      fra,
      xa, ya,
      xb, yb : Double;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  param := Abs(param);
  i     := Trunc(param);
  fra   := Frac(param);
  If (i >= 0) and (i < Parent.Count) then begin
    With TGPoint(Parent[i]) do begin
      xa := X; ya := Y; end;
    With TGPoint(Parent[(i+1) mod Parent.Count]) do begin
      xb := X; yb := Y; end;
    px := xa + fra * (xb - xa);
    py := ya + fra * (yb - ya);
    Result := True;
    end;
  end;

function TGPolygon.GetLinePtWithMinMouseDist(xm, ym, quant: Double;
                  var px, py: Double): Boolean;
  var p : Double;
  begin
  Result := GetParamFromCoords(xm, ym, p) and
            GetCoordsFromParam(p, px, py);
  end;

function TGPolygon.GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean;

  function suc(n: Integer): Integer;
    begin
    Result := (n + 1) Mod Parent.Count;
    end;

  var i          : Integer;
      T1x, T1y, T2x, T2y,
      _X, _Y, dr : Double;
      T1_valid,
      T2_valid   : Boolean;

  procedure Check(valid: Boolean; sx, sy: Double; n: Integer);
    var tv, nr : Double;
    begin
    If valid then begin
      GetTV(TGPoint(Parent[    n ]).X, TGPoint(Parent[    n ]).Y,
            TGPoint(Parent[suc(n)]).X, TGPoint(Parent[suc(n)]).Y,
            sx, sy, tv);
      If (tv >= 0) and (tv <= 1) then begin
        nr := Hypot(sx - px, sy - py);
        if nr < dr then begin
          _X := sx;
          _Y := sy;
          dr := nr;
          end;
        end;
      end;
    end;

  begin
  dr := 1e20;
  _X := 1e10; _Y := 1e10;
  For i := 0 to Pred(Parent.Count) do begin
    IntersectCircleWithLine(EP.X, EP.Y, r,
                            TGPoint(Parent[    i ]).X, TGPoint(Parent[    i ]).Y,
                            TGPoint(Parent[suc(i)]).X, TGPoint(Parent[suc(i)]).Y,
                            T1x, T1y, T2x, T2y, T1_valid, T2_valid);
    Check(T1_valid, T1x, T1y, i);
    Check(T2_valid, T2x, T2y, i);
    end;
  Result := Hypot(_X, _Y) < 1e10;
  If Result then begin
    px := _X;
    py := _Y;
    end;
  end;


function TGPolygon.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  { Bereich : [0...n]  bei n Ecken  }
  var i          : Integer;
      t, dr, dp,
      xped, yped : Double;

  function suc(n: Integer): Integer;
    begin
    Result := (n+1) Mod Parent.Count;
    end;

  begin
  Result := True;
  param := -0.5;    { Zunächst alle Fußpunkte von Loten von der  }
  dr    := 1e20;    {    Maus auf die Polygonseiten testen       }
  For i := 0 to Pred(Parent.Count) do begin
    t := -1;
    If GetPedalPoint(TGPoint(Parent[i     ]).X, TGPoint(Parent[i     ]).Y,
                     TGPoint(Parent[suc(i)]).X, TGPoint(Parent[suc(i)]).Y,
                     px, py, xped, yped) and
       GetTV(TGPoint(Parent[i     ]).X, TGPoint(Parent[i     ]).Y,
             TGPoint(Parent[suc(i)]).X, TGPoint(Parent[suc(i)]).Y,
             xped, yped, t) then begin
      dp := Hypot(xped - px, yped - py);
      If (t >= 0) and (t <= 1) and  { Punkt ist innerer Punkt der Seite  }
         (dp < dr) then begin       { und dichter an der Maus als bisher }
        dr    := dp;
        param := i + t;             { Nehmen ! }
        end;
      end;
    end;
  For i := 0 to Pred(Parent.Count) do begin  { Bisheriges Ergebnis mit }
    dp := Hypot(TGPoint(Parent[i]).X - px,   {   den Abständen zu den  }
                TGPoint(Parent[i]).Y - py);  {   Polygon-Ecken         }
    If dp < dr then begin                    {   vergleichen           }
      dr    := dp;
      param := i;
      end;
    end;
  end;

function TGPolygon.GetRandomParam: Double;
  begin
  Result := (Inherited GetRandomParam) * Parent.Count;
  end;

procedure TGPolygon.UpdateNameCoordsIn(TextObj: TGTextObj);
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


procedure TGPolygon.SetNewNameParamsIn(TextObj: TGTextObj);
  begin
  with TextObj do begin
    rConst := X - Self.X;
    sConst := Y - Self.Y;
    end;
  end;


procedure TGPolygon.AdjustGraphTools(todraw : Boolean);
  begin
  { Ist leer, weil Polygone derzeit gar keine darstellbaren
    Objekte mehr sind, sondern nur "Verwaltungseinheiten". }
  end;

procedure TGPolygon.HideIt;
  begin
  { Ist leer, weil Polygone derzeit gar keine darstellbaren
    Objekte mehr sind, sondern nur "Verwaltungseinheiten". }
  end;

procedure TGPolygon.DrawIt;
  { Ist im Normalfall funktionslos, weil Polygone derzeit gar keine
    darstellbaren Objekte mehr sind, sondern nur "Verwaltungseinheiten".

    Behandelt wird hier nur der Spezialfall der Ortslinienaufzeichnung, bei
    dem die Auslöschung der Trägerlinie verhindert werden muss. Dazu wird die
    Seite gesucht, auf der der Zugpunkt gerade läuft. Falls sie gefunden
    wird, wird sie mitsamt ihren Endpunkten neu gezeichnet.               }

  var TL    : TGLine;
      L_Obj : TGShortLine;
      n1, n2,
      i     : Integer;
  begin
  If (OLineMode = 4) and
     (ObjList.DraggedObj <> Nil) and
     (ObjList.DraggedObj.ClassType = TGPoint) and
     (TGPoint(ObjList.DraggedObj).IsLineBound(TL)) and
     (TL = Self) then begin
    n1 := Trunc(TGPoint(ObjList.DraggedObj).BoundParam);
    n2 := Succ(n1) Mod Parent.Count;
    i  := 5;
    L_Obj := Nil;
    While i <= ObjList.LastValidObjIndex do begin
      If (TGeoObj(ObjList.Items[i]) is TGShortLine) and
         (TGeoObj(ObjList.Items[i]).Parent.IndexOf(Parent[n1]) >= 0) and
         (TGeoObj(ObjList.Items[i]).Parent.IndexOf(Parent[n2]) >= 0) and
         (TGeoObj(ObjList.Items[i]).IsVisible) then begin
        L_Obj := ObjList.Items[i];
        i := ObjList.LastValidObjIndex;
        end;
      i := i + 1;
      end;
    If L_Obj <> Nil then begin
      L_Obj.ReDraw(True);
      TGeoObj(Parent[n1]).Redraw(True);
      TGeoObj(Parent[n2]).Redraw(True);
      end;
    end;
  end;

function TGPolygon.BorderOrientation: Integer;
  var angle_sum : Double;
      i         : Integer;
  begin
  If Parent.Count < 3 then
    Result := 0
  else with Parent do begin
    angle_sum :=
      signed_angle(TGPoint(Last).X - TGPoint(Items[Count-2]).X,
                   TGPoint(Last).Y - TGPoint(Items[Count-2]).Y,
                   TGPoint(First).X - TGPoint(Last).X,
                   TGPoint(First).Y - TGPoint(Last).Y) +
      signed_angle(TGPoint(First).X - TGPoint(Last).X,
                   TGPoint(First).Y - TGPoint(Last).Y,
                   TGPoint(Items[1]).X - TGPoint(First).X,
                   TGPoint(Items[1]).X - TGPoint(First).Y);
    For i := 2 to Pred(Count) do
      angle_sum := angle_sum + signed_angle
           (TGPoint(Items[i-1]).X - TGPoint(Items[i-2]).X,
            TGPoint(Items[i-1]).Y - TGPoint(Items[i-2]).Y,
            TGPoint(Items[i]).X - TGPoint(Items[i-1]).X,
            TGPoint(Items[i]).Y - TGPoint(Items[i-1]).Y);
    Result := Round(angle_sum / (2 * Pi));
    end;
  end;

function TGPolygon.WindingNumber(sx, sy : Double): Integer;
  var angle_sum : Double;
      i         : Integer;
  begin
  angle_sum := signed_angle(TGPoint(Parent.Last).X - sx,
                            TGPoint(Parent.Last).Y - sy,
                            TGPoint(Parent.First).X - sx,
                            TGPoint(Parent.First).Y - sy);
  For i := 1 to Pred(Parent.Count) do
    angle_sum := angle_sum +
                 signed_angle(TGPoint(Parent.Items[i-1]).X - sx,
                              TGPoint(Parent.Items[i-1]).Y - sy,
                              TGPoint(Parent.Items[i]).X - sx,
                              TGPoint(Parent.Items[i]).Y - sy);
  Result := Round(angle_sum / (2 * Pi));
  end;

function TGPolygon.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If (nr > 0) and (nr < Parent.Count) then
    Result := Parent[Pred(nr)]
  else
    Result := Nil;
  end;

function TGPolygon.GetValue(selector: Integer): Double;
  var i : Integer;
  begin
  If DataValid then
    Case selector of
      gv_len   : begin        { Umfang berechnen }
                 Result :=
                    Hypot(TGPoint(Parent.Last).X - TGPoint(Parent[0]).X,
                          TGPoint(Parent.Last).Y - TGPoint(Parent[0]).Y);
                 For i := 0 to Parent.Count-2 do
                   Result := Result +
                      Hypot(TGPoint(Parent[i]).X - TGPoint(Parent[i+1]).X,
                            TGPoint(Parent[i]).Y - TGPoint(Parent[i+1]).Y);
                 end;
      gv_area  : If SignedAreas then
                   Result := area
                 else
                   Result := Abs(area);
    else
      Result := Inherited GetValue(selector);
    end
  else
    Result := 0;
  end;

function TGPolygon.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccAnyPoly, ccBorderLine, ccBorderOrArea,
                              ccMappableObj, ccMakroDefObj]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;

function TGPolygon.IsClosedLine: Boolean;
  begin
  Result := True;
  end;

function TGPolygon.IsFilled(var FO: TGArea): Boolean;
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

function TGPolygon.Dist (xm, ym: Double): Double;
  var d          : Double;
      k, v, n, i : Integer;
  begin
  Result := 1.0e300;
  k := -1;
  For i := 0 to Pred(Parent.Count) do begin
    d := Hypot(TGeoObj(Parent[i]).X - xm, TGeoObj(Parent[i]).Y - ym);
    If d < Result then begin
      Result := d;
      k := i;      { k enthält den Index des Eckpunkts mit }
      end;         { der k_ürzesten Distanz zum Mauspunkt  }
    end;
  If k >= 0 then begin
    If k > 0 then
      v := k - 1         { Index des V_orgänger-Eckpunkts }
    else
      v := Pred(Parent.Count);
    If k < Pred(Parent.Count) then
      n := k + 1         { Index des N_achfolger-Eckpunkts }
    else
      n := 0;

    d := DistPt2ShortLn(TGeoObj(Parent[v]).X, TGeoObj(Parent[v]).Y,
                        TGeoObj(Parent[k]).X, TGeoObj(Parent[k]).Y,
                        xm, ym);
    If d < Result then Result := d;

    d := DistPt2ShortLn(TGeoObj(Parent[k]).X, TGeoObj(Parent[k]).Y,
                        TGeoObj(Parent[n]).X, TGeoObj(Parent[n]).Y,
                        xm, ym);
    If d < Result then Result := d;
    end;
  end;

function TGPolygon.Includes(xp, yp: Double): Boolean;
  begin
  Result := Dist(xp, yp) < DistEpsilon;
  end;

function TGPolygon.IsNearMouse: Boolean;
  var dmin, d : Double;
      i       : Integer;
  begin
  Result := False;
  If DataValid then begin
    dmin := 1e300;
    For i := 0 to Pred(Parent.Count) do begin
      d := DistPt2ShortLn(IntPointLists[0,i  ].X, IntPointLists[0,i  ].Y,
                          IntPointLists[0,i+1].X, IntPointLists[0,i+1].Y,
                          ObjList.LastMousePos.X, ObjList.LastMousePos.Y);
      If d < dmin then dmin := d;
      end;
    Result := dmin < CatchDist;
    end;
  end;

function TGPolygon.GetFillHandle(Ori: Boolean): HRgn;
  begin
  Result := CreatePolygonRgn(IntPointLists[0,0], Parent.Count, PolyFillMode);
  end;


function TGPolygon.AllAncestorsAreFreePoints(PList: TObjPtrList = Nil): Boolean;

  function AllAncestorsCanMoveFree: Boolean;
    { 24.08,2008 : Fehlermeldung von Elschenbroich ("Beispiel-18.geo") wg.
                   mangelnder Beweglichkeit zuvor verschiebbarer Polygon-
      Füllungen. Deshalb die Routine "RegisterObjWithAllDependents()" reno-
      viert, so dass nun sicher alle von den Basis-Eckpunkten abhängigen
      Objekte in DragL eingetragen werden. Allerdings muss die Liste nun in
      "AllAncestorsAreFreePoints()" nachträglich sortiert werden (siehe [*]).}

    var FVL, DVL,
        DragL   : TObjPtrList;
        i       : Integer;

    procedure RegisterObjWithAllDescendents(GO: TGeoObj);
      var i : Integer;
      begin
      If FVL.IndexOf(GO) >= 0 then   // Basispunkte ohne Eltern
        DragL.Insert(0, GO)          //   vorne einschieben,...
      else                           // ... abhängige Objekte
        DragL.Add(GO);               //   hinten anfügen !
      For i := 0 to Pred(GO.Children.Count) do    // Kinder eintragen
        RegisterObjWithAllDescendents(GO.Children[i]);
      end;

    procedure Check4FixedVertices(DragList: TList; FVList, DVList: TObjPtrList);
      { Simuliert den Zugvorgang intern, um zu bestimmen, welche der abhängigen
        Polygonecken synchron mitverschiebbar sind; diese Ecken werden aus der
        DVList gelöscht. Übrig bleiben darin nur diejenigen Ecken, die *nicht*
        synchron verschiebbar sind. }
      type TCheckRec = record
                         GO    : TGPoint;
                         x_old : Double;
                         y_old : Double;
                         dr    : Double;
                       end;
      var DVData   : Array of TCheckRec;
          d_x, d_y,
          ddr      : Double;
          i, j     : Integer;

      begin { of Check4FixedVertices }
      For i := 0 to Pred(Parent.Count) do   { Save all vertices' state      }
        TGPoint(Parent[i]).SaveState;
      SetLength(DVData, DVList.Count);      { Save dependend points' coords }
      For i := 0 to Pred(DVList.Count) do
        With DVData[i] do begin
          GO    := DVList[i];
          x_old := GO.X;
          y_old := GO.Y;
          dr    := 0;
          end;
      try
        For j := 0 to 4 do begin              { Simulate dragging .....       }
          d_x := (ObjList.xMax - ObjList.xMin) * (Random - 0.5);
          d_y := (ObjList.yMax - ObjList.yMin) * (Random - 0.5);
          i := 0;                                { Move free base points        }
          While (i < DragList.Count) and
                (TGeoObj(DragList[i]) is TGPoint) and
                (TGPoint(DragList[i]).Parent.Count = 0) do begin
            with TGPoint(DragList[i]) do begin
              X := X + d_x;
              Y := Y + d_y;
              end;
            i := i + 1;
            end;

          While i < DragList.Count do begin      { Update all dependend objects }
            TGeoObj(DragList[i]).UpdateParams;
            i := i + 1;
            end;

          For i := 0 to Pred(DVList.Count) do    { Measure displacements        }
            with DVData[i] do begin
              If j > 0 then begin                   { j = 0 : only initialize ! }
                ddr := Hypot(GO.X - x_old - d_x, GO.Y - y_old - d_y);
                dr := dr + ddr;
                end;
              x_old := GO.X;
              y_old := GO.Y;
              end;
          end;

        For i := Pred(DVList.Count) DownTo 0 do begin
          If DVData[i].dr < epsilon then      { Check results of drag test    }
            DVList.Remove(DVData[i].GO);
          end;
      finally
        For i := 0 to Pred(Parent.Count) do   { Restore all vertices' state   }
          TGPoint(Parent[i]).RestoreState;
        i := 0;
        While (i < DragList.Count) and        { Skip free base points         }
              (TGeoObj(DragList[i]) is TGPoint) and
              (TGPoint(DragList[i]).Parent.Count = 0) do
          i := i + 1;
        While i < DragList.Count do begin     { Update all dependend objects  }
          TGeoObj(DragList[i]).UpdateParams;
          i := i + 1;
          end;
        DVData := Nil;                        { Clear up memory               }
      end;  { of try }
      end;  { of Check4FixedVertices }

    begin { of AllAncestorsCanMoveFree }
    Result := False;
    FVL    := TObjPtrList.Create(False);
    DVL    := TObjPtrList.Create(False);
    DragL  := TObjPtrList.Create(False);
    try
      { Erst alle Eckpunkte des Polygons auf FVL und DVL aufteilen }
      For i := 0 to Pred(Parent.Count) do
        If (TGeoObj(Parent[i]).ClassType = TGPoint) and
           (TGeoObj(Parent[i]).Parent.Count = 0) then   // Eckpunkt "echt frei" ?
          FVL.Add(Parent[i])
        else
          DVL.Add(Parent[i]);

      { Dann alle "freien" Ecken mit all ihren Kindern in DragL eintragen }
      For i := 0 to Pred(FVL.Count) do
        RegisterObjWithAllDescendents(TGeoObj(FVL[i]));
      DragL.SortByDependencies;     // [*]

      { Zugvorgang simulieren: Abhängigkeiten testen und DVL aktualisieren }
      Check4FixedVertices(DragL, FVL, DVL);

      { Ergebnis auswerten }
      If DVL.Count = 0 then begin
        If PList <> Nil then
          For i := 0 to Pred(Parent.Count) do
            PList.Add(Parent[i]);
        Result := True;
        end;
    finally
      DragL.Free;
      DVL.Free;
      FVL.Free;
    end; { of try }
    end; { of AllAncestorsCanMoveFree }

  function AllEdgesAreFreeBasePoints : Boolean;
    var i : Integer;
    begin
    Result := True;
    i := 0;
    While Result and (i < Parent.Count) do
      If TGeoObj(Parent[i]).Parent.Count > 0 then
        Result := False
      else
        Inc(i);
    If Result then
      If PList <> Nil then
        For i := 0 to Pred(Parent.Count) do
          PList.Add(Parent[i]);
    end;

  begin { of AllAncestorsAreFreePoints }
  If AllEdgesAreFreeBasePoints then
    Result := True
  else
    If (Parent.Count <= 12) and (OLineMode = 0) then
      Result := AllAncestorsCanMoveFree
    else
      Result := False;
  end; { of AllAncestorsAreFreePoints }


function TGPolygon.GetSegmentObj(nr: Integer): TGShortLine;
  { 19.08.2008 : Liefert die nr-te Kante des Polygons (oder NIL).
                 Wird gebraucht in "SetGraphTools".              }
  var p_1, p_2 : TGPoint;
      res      : TGShortLine;
      i        : Integer;
  begin
  Result := Nil;
  If (nr >= 0) and (nr < Parent.Count) then begin
    If nr = Pred(Parent.Count) then begin
      p_1 := TGeoObj(Parent.Last) as TGPoint;
      p_2 := TGeoObj(Parent[0]) as TGPoint;
      end
    else begin
      p_1 := TGeoObj(Parent[nr]) as TGPoint;
      p_2 := TGeoObj(Parent[nr + 1]) as TGPoint;
      end;
    i := 0;
    While (Result = Nil) and (i <= ObjList.LastValidObjIndex) do begin
      If TGeoObj(ObjList.Items[i]).ClassType = TGShortLine then begin
        res := TGShortLine(ObjList.Items[i]);
        If (res.Parent.IndexOf(p_1) >= 0) and
           (res.Parent.IndexOf(p_2) >= 0) then
          Result := res;
        end;
      Inc(i);
      end;
    end;
  end;


procedure TGPolygon.SetAsStartObject4MacroRun(MakNum, CmdNum: Integer);
  var aktMakro   : TMakro;
      aktMakCmd  : TMakroCmd;
  begin
  aktMakro := TMakro(ObjList.MakroList[MakNum]);
  aktMakCmd := aktMakro.Items[CmdNum];
  aktMakCmd.pNewObj := Self;  
  If VCount <> (aktMakCmd.ProtoTyp as TGPolygon).VCount then
    aktMakro.MakroStatus := -5   { Polygonfehler: Eckenzahl stimmt nicht! }
  else
    Inherited SetAsStartObject4MacroRun(MakNum, CmdNum);
  end;


procedure TGPolygon.SetGraphTools(LineStyleNum, PointStyleNum,
                                  FillStyleNum: Integer; iColor: TColor);
  {19.08.2008 : Bug-Meldung von Elschenbroich: man kann bei Polygonen
                kein Grafik-Attribut "auf einen Schlag" ändern, obwohl
   die Benutzeroberfläche dies nahe legt. => Ergänzt !                 }
  var seg : TGShortLine;
      i : Integer;
  begin
  For i := 0 to Pred(VCount) do begin
    seg := GetSegmentObj(i);
    If seg <> Nil then
      seg.SetGraphTools(LineStyleNum, PointStyleNum, FillStyleNum, iColor);
    end;  
  end;


procedure TGPolygon.GetGraphTools(var LineStyleNum, PointStyleNum,
                                      FillStyleNum: Integer; var iColor: TColor);
  begin
  end;


procedure TGPolygon.ResetOLCPList(PointList : TVector3List);
  begin
  PointList.Reset2StandardList(ParamEpsilon, Parent.Count - ParamEpsilon, Parent.Count * 8);
  end;


procedure TGPolygon.RegisterAsMacroStartObject;
  var i : Integer;
  begin
  With TMakro(ObjList.MakroList.Last) do begin
    For i := 0 to Pred(Parent.Count) do
      AddCmd(TMakroCmd.Create(Parent[i], -1));
    AddCmd(TMakroCmd.Create(Self, 0));
    end;
  end;


procedure TGPolygon.LoadContextMenuEntriesInto(menu: TPopupMenu);
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  menu.Items.Delete(Pred(menu.Items.Count));  // keine Gleichung anzeigen!
  end;


function TGPolygon.GetInfo: String;
  var s : String;
      i : Integer;
  begin
  s := MyObjTxt[37];
  For i := 0 to Pred(Parent.Count) do
    s := s + ' ? ;';
  Delete(s, Length(s), 1);
  s := s + '].';
  InsertNameOf(Self, s);
  For i := 0 to Pred(Parent.Count) do
    InsertNameOf(TGeoObj(Parent[i]), s);
  Result := s;
  end;



{-------------------------------------------}
{ TGRegPoly's Methods Implementation        }
{-------------------------------------------}


constructor TGRegPoly.Create(iObjList: TGeoObjListe; iP1, iP2: TGPoint;
                             ivCount: Integer; iReversed: Boolean);
  { Erzeugt ein reguläres Polygon mit vCount Ecken über der Strecke [P1,P2].
    Über die Orientierung entscheidet die Variable Reversed: geht man von P1
    nach P2, dann liegt die Polygonfläche genau dann links, wenn reversed
    den Wert FALSE hat. }
  var i : Integer;
  begin
  Inherited Create(iObjList, Nil, True);
  BecomesChildOf(iP1);
  BecomesChildOf(iP2);
  FVCount   := ivCount;
  FReversed := iReversed;
  Points := TVector3List.Create;
  For i := 1 to FVCount do
    Points.Add(TVector3.Create(0, 0, 0));
  SetLength(IntPointLists, 1, FVCount);
  If ClassType = TGRegPoly then  // Abgeleitete Typen müssen sich möglicher-
    UpdateParams;                //   weise erst fertig initialisieren !
  end;

constructor TGRegPoly.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var domPos : IXMLNode;
      i      : Integer;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  FReversed := False;
  domPos := DE.childNodes.findNode('position', '');
  If domPos <> Nil then begin
    FVCount := StrToInt(domPos.getAttribute('vcount'));
    If domPos.hasAttribute('reversed') then
      FReversed := StrToBoolDef(domPos.getAttribute('reversed'), False);
    end
  else
    FVCount := 3;  // Minimalwert
  Points := TVector3List.Create;
  For i := 1 to FVCount do
    Points.Add(TVector3.Create(0, 0, 0));
  SetLength(IntPointLists, 1, FVCount);
  end;

destructor TGRegPoly.Destroy;
  begin
  inherited Destroy;
  end;

procedure TGRegPoly.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  FVCount   := (BluePrint as TGRegPoly).VCount;
  FReversed := (BluePrint as TGRegPoly).IsReversed;
  end;

function TGRegPoly.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var domPos : IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  domPos := Result.childNodes.findNode('position', '');
  If domPos <> Nil then begin
    domPos.setAttribute('vcount', IntToStr(FVCount));
    If IsReversed then
      domPos.setAttribute('reversed', BoolToStr(IsReversed));
    end;
  end;

procedure TGRegPoly.AfterLoading(FromXML: Boolean = False);
  var co : TGeoObj;
      i: Integer;
  begin
  for i := 0 to Pred(VCount - 2) do
    while Not (TGeoObj(Children[i]) is TGPoint) do begin
      co := Children[i];
      Children.Remove(co);
      Children.Add(co);
      end;
  Inherited AfterLoading(FromXML);
  end;

function TGRegPoly.GetVCount: Integer;
  begin
  Result := FVCount;
  end;

function TGRegPoly.GetSegmentObj(nr: Integer): TGShortLine;
  { 12.09.2009 : Überschriebene Version für TGRegPoly  }
  var p_1, p_2 : TGPoint;
      res      : TGShortLine;
      i        : Integer;
  begin
  Result := Nil;
  If (nr >= 0) and (nr < VCount) then begin
    p_1 := Nil;
    p_2 := Nil;
    try
      if nr = 0 then begin
        p_1 := TGeoObj(Parent[0]) as TGPoint;
        p_2 := TGeoObj(Parent[1]) as TGPoint;
        end
      else if nr = 1 then begin
        p_1 := TGeoObj(Parent[1]) as TGPoint;
        if Children.Count > 0 then
          p_2 := TGeoObj(Children[0]) as TGPoint;
        end
      else if nr = Pred(VCount) then begin
        if (Children.Count > 0) and (Children.Count > VCount - 3) then
          p_1 := TGeoObj(Children[VCount-3]) as TGPoint;
        p_2 := TGeoObj(Parent[0]) as TGPoint;
        end
      else begin
        p_1 := TGeoObj(Children[nr - 2]) as TGPoint;
        p_2 := TGeoObj(Children[nr - 1]) as TGPoint;
        end;
    finally
      i := 0;
      While (Result = Nil) and (i <= ObjList.LastValidObjIndex) do begin
        If TGeoObj(ObjList.Items[i]).ClassType = TGShortLine then begin
          res := TGShortLine(ObjList.Items[i]);
          If (res.Parent.IndexOf(p_1) >= 0) and
             (res.Parent.IndexOf(p_2) >= 0) then
            Result := res;
          end;
        Inc(i);
        end;
    end; { of try finally }
    end; { of outer if }
  end;


function TGRegPoly.HasSameDataAs(GO: TGeoObj): Boolean;
  { Diese Implementierung des Objektvergleichs berücksichtigt, dass zum Zeit-
    punkt des Aufrufs das neue Objekt (also Self!) möglicherweise noch gar
    keine Kinder hat: zunächst sind nur die beiden als Eltern dienenden Ecken
    verbucht! Die weiteren Ecken werden - wie die Seiten auch - erst nach dem
    erfolgreichen Nachweis erzeugt, dass dieses Objekt (also Self!) wirklich
    neu ist!                                                                  }

  function MyParentsAreVerticesOf(RP: TGRegPoly): Boolean;
    { Vergleicht die beiden eigenen Elternpunkte mit allen aufeinander-
      folgenden Paaren von Eckpunkten des anderen, schon vorhandenen regu-
      lären N-Ecks. Die Funktion liefert genau dann TRUE, wenn die beiden
      Elternpunkte des aktuellen N-Ecks in derselben Reihenfolge in der
      (ringförmig geschlossenen) Liste der Eckpunkte des anderen regulären
      N-Ecks vorkommen. In diesem Fall würden die beiden N-Ecke nämlich die
      selbe Punktemenge enthalten, also topologisch äquivalent sein!         }
    var n : Integer;
    begin
    n := RP.Parent.IndexOf(Parent[0]);
    Case n of
      0 : Result := Parent[1] = RP.Parent[1];
      1 : Result := (RP.Children.Count > 0) and
                    (Parent[1] = RP.Children[0]);
    else { also n < 0, d.h. nichts gefunden ! }
      n := RP.Children.IndexOf(Parent[0]);
      If n >= 0 then
        If n = Pred(RP.Children.Count) then
          Result := Parent[1] = RP.Parent[0]
        else
          Result := Parent[1] = RP.Children[n + 1]
      else
        Result := False;
    end; { of case }
    end;

  begin
  Result := (GO.ClassType = Self.ClassType) and
            (TGRegPoly(GO).VCount = VCount) and
            (MyParentsAreVerticesOf(TGRegPoly(GO)));
  end;

procedure TGRegPoly.SetShowsAlways(vis: Boolean);
  var i   : Integer;
      seg : TGLine;
      fill: TGArea;
  begin
  DataCanShow := vis;
  If Children.Count >= VCount - 3 then begin
    For i := 0 to Pred(Parent.Count) do
      TGeoObj(Parent.Items[i]).ShowsAlways := vis;
    For i := 0 to Pred(Children.Count) do
      if i <= VCount - 3 then
        TGeoObj(Children[i]).ShowsAlways := vis;
    For i := 0 to Pred(VCount) do begin
      seg := GetSegmentObj(i);
      if seg <> Nil then
        seg.ShowsAlways := vis;
      end;
    If IsFilled(fill) then
      fill.ShowsAlways := vis;
    end;
  end;


function TGRegPoly.Dist(xm, ym: Double): Double;
  var d          : Double;
      k, v, n, i : Integer;
  begin
  Result := 1.0e300;
  k := -1;
  For i := 0 to Pred(FVCount) do begin
    d := Hypot(TVector3(Points[i]).x - xm, TVector3(Points[i]).y - ym);
    If d < Result then begin
      Result := d;
      k := i;      { k enthält den Index des Eckpunkts mit }
      end;         { der k_ürzesten Distanz zum Mauspunkt  }
    end;
  If k >= 0 then begin
    If k > 0 then
      v := k - 1         { Index des V_orgänger-Eckpunkts }
    else
      v := Pred(FVCount);
    If k < Pred(FVCount) then
      n := k + 1         { Index des N_achfolger-Eckpunkts }
    else
      n := 0;

    d := DistPt2ShortLn(TVector3(Points[v]).x, TVector3(Points[v]).y,
                        TVector3(Points[k]).x, TVector3(Points[k]).y,
                        xm, ym);
    If d < Result then Result := d;

    d := DistPt2ShortLn(TVector3(Points[k]).x, TVector3(Points[k]).y,
                        TVector3(Points[n]).x, TVector3(Points[n]).y,
                        xm, ym);
    If d < Result then Result := d;
    end;
  end;

function TGRegPoly.GetValue(selector: Integer): Double;
  begin
  If DataValid then
    Case selector of
      gv_len   : Result := circum;
      gv_area  : If SignedAreas then
                   Result := area
                 else
                   Result := Abs(area);
    else
      Result := Inherited GetValue(selector);
    end
  else
    Result := 0;
  end;

function TGRegPoly.GetInfo: String;
  var s : String;
  begin
  s := Format(MyObjTxt[101], [IntToStr(FVCount)]);
  InsertNameOf(Self, s);
  InsertNameOf(TGeoObj(Parent[0]), s);
  InsertNameOf(TGeoObj(Parent[1]), s);
  Result := s;
  end;

function TGRegPoly.GetVertice(selector: Integer; var vx, vy: Double): Boolean;
  begin
  If (Selector >= 0) and (Selector < FVCount) then begin
    vx := TVector3(Points[selector]).x;
    vy := TVector3(Points[selector]).y;
    Result := True;
    end
  else
    Result := False;
  end;

function TGRegPoly.GetFillHandle(Ori: Boolean): HRgn;
  begin
  Result := CreatePolygonRgn(IntPointLists[0,0], FVCount, PolyFillMode);
  end;

function TGRegPoly.Includes(xp, yp: Double): Boolean;
  var sp, ep : Integer;
  begin
  Result := False;
  sp := Pred(FVCount);
  ep := 0;
  While (Not Result) and (ep < FVCount) do begin
    Result := DistPt2ShortLn(TVector3(Points[sp]).x, TVector3(Points[sp]).y,
                             TVector3(Points[ep]).x, TVector3(Points[ep]).y,
                             xp, yp) < DistEpsilon;
    sp := ep;
    ep := ep + 1;
    end;
  end;

function TGRegPoly.IsNearMouse: Boolean;
  var d : Double;
  begin
  d := Dist(ObjList.LastLogMouseX, ObjList.LastLogMouseY);
  Result := d < CatchDist / ObjList.e1x;
  end;

function TGRegPoly.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var i      : Integer;
      fra,
      xa, ya,
      xb, yb : Double;
  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  param := Abs(param);
  i     := Trunc(param);
  fra   := Frac(param);
  If (i >= 0) and (i < VCount) then begin
    With TVector3(Points[i]) do begin
      xa := X; ya := Y; end;
    With TVector3(Points[(i+1) mod VCount]) do begin
      xb := X; yb := Y; end;
    px := xa + fra * (xb - xa);
    py := ya + fra * (yb - ya);
    Result := True;
    end;
  end;

function TGRegPoly.suc(n: Integer): Integer;
  begin
  Result := (n+1) Mod VCount;
  end;

function TGRegPoly.GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean;
  begin
  Result := Inherited GetLinePtWithMinMouseDist(xm, ym, quant, px, py);
  end;

function TGRegPoly.GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean;
  var T1x, T1y, T2x, T2y,
      _X, _Y, dr : Double;
      T1_valid,
      T2_valid   : Boolean;
      i          : Integer;

  procedure Check(valid: Boolean; sx, sy: Double; n: Integer);
    var tv, nr : Double;
    begin
    If valid then begin
      GetTV(TVector3(Points[    n ]).X, TVector3(Points[    n ]).Y,
            TVector3(Points[suc(n)]).X, TVector3(Points[suc(n)]).Y,
            sx, sy, tv);
      If (tv >= 0) and (tv <= 1) then begin
        nr := Hypot(sx - px, sy - py);
        if nr < dr then begin
          _X := sx;
          _Y := sy;
          dr := nr;
          end;
        end;
      end;
    end;

  begin
  dr := 1e20;
  _X := 1e10; _Y := 1e10;
  For i := 0 to Pred(VCount) do begin
    IntersectCircleWithLine(EP.X, EP.Y, r,
                            TVector3(Points[    i ]).X, TVector3(Points[    i ]).Y,
                            TVector3(Points[suc(i)]).X, TVector3(Points[suc(i)]).Y,
                            T1x, T1y, T2x, T2y, T1_valid, T2_valid);
    Check(T1_valid, T1x, T1y, i);
    Check(T2_valid, T2x, T2y, i);
    end;
  Result := Hypot(_X, _Y) < 1e10;
  If Result then begin
    px := _X;
    py := _Y;
    end;
  end;



function TGRegPoly.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var i          : Integer;
      t, dr, dp,
      xped, yped : Double;

  begin
  Result := True;
  param := -0.5;    { Zunächst alle Fußpunkte von Loten von der  }
  dr    := 1e20;    {    Maus auf die Polygonseiten testen       }
  For i := 0 to Pred(VCount) do begin
    t := -1;
    If GetPedalPoint(TVector3(Points[i     ]).X, TVector3(Points[i     ]).Y,
                     TVector3(Points[suc(i)]).X, TVector3(Points[suc(i)]).Y,
                     px, py, xped, yped) and
       GetTV(TVector3(Points[i     ]).X, TVector3(Points[i     ]).Y,
             TVector3(Points[suc(i)]).X, TVector3(Points[suc(i)]).Y,
             xped, yped, t) then begin
      dp := Hypot(xped - px, yped - py);
      If (t >= 0) and (t <= 1) and  { Punkt ist innerer Punkt der Seite  }
         (dp < dr) then begin       { und dichter an der Maus als bisher }
        dr    := dp;
        param := i + t;             { Nehmen ! }
        end;
      end;
    end;
  For i := 0 to Pred(VCount) do begin         { Bisheriges Ergebnis mit }
    dp := Hypot(TVector3(Points[i]).X - px,   {   den Abständen zu den  }
                TVector3(Points[i]).Y - py);  {   Polygon-Ecken         }
    If dp < dr then begin                     {   vergleichen           }
      dr    := dp;
      param := i;
      end;
    end;
  end;

procedure TGRegPoly.UpdateParams;
  var a, d, ds,
      mw, dw,
      dsx, dsy,
      drx, dry : Double;
      i : Integer;
  begin
  DataValid := False;
  X1  := TGPoint(Parent[0]).X;
  Y1  := TGPoint(Parent[0]).Y;
  X2  := TGPoint(Parent[1]).X;
  Y2  := TGPoint(Parent[1]).Y;
  a   := pi * (0.5 - 1 / FVCount);
  dsx := X2 - X1;
  dsy := Y2 - Y1;
  ds  := Hypot(dsx, dsy);
  If ds > epsilon then begin
    d   := tan(a) / 2;
    If IsReversed then begin
      X   := (X1 + X2) / 2 + d * dsy;
      Y   := (Y1 + Y2) / 2 - d * dsx;
      end
    else begin
      X   := (X1 + X2) / 2 - d * dsy;
      Y   := (Y1 + Y2) / 2 + d * dsx;
      end;
    mw  := 2 * pi / FVCount;
    dw  := 0;
    TVector3(Points[0]).x := X1;
    TVector3(Points[0]).y := Y1;
    TVector3(Points[1]).x := X2;
    TVector3(Points[1]).y := Y2;
    dsx := X2 - X;
    dsy := Y2 - Y;
    For i := 2 to Pred(FVCount) do begin
      dw := dw + mw;
      RotateVector2ByAngle(dsx, dsy, dw, drx, dry);
      TVector3(Points[i]).x := X + drx;
      TVector3(Points[i]).y := Y + dry;
      end;
    F_CBDI := TGeoObj(Parent[0]).Parent.Count +
              TGeoObj(Parent[1]).Parent.Count = 0;
    circum := ds * VCount;
    area   := circum * DistPt2Line(X1, Y1, X2, Y2, X, Y) / 2;
    DataValid := True;
    UpdateScreenCoords;
    end;
  end;

procedure TGRegPoly.UpdateScreenCoords;
  var i : Integer;
  begin     // IntPointLists füllen !
  If DataValid then
    For i := 0 to Pred(FVCount) do begin
      ObjList.GetWinCoords(TVector3(Points[i]).x, TVector3(Points[i]).y,
                           IntPointLists[0, i].x, IntPointLists[0, i].y);
      end;
  end;


{-------------------------------------------}
{ TGMappedRegPoly's Methods Implementation  }
{-------------------------------------------}

constructor TGMappedRegPoly.Create(iObjList: TGeoObjListe; iPP: TGRegPoly;
                                   iMap: TGTransformation);
  begin
  Inherited Create(iObjList, Nil, Nil, iPP.VCount, False);
  BecomesChildOf(iPP);
  BecomesChildOf(iMap);
  UpdateParams;
  end;

procedure TGMappedRegPoly.AfterLoading(FromXML: Boolean = False);
  begin
  end;

procedure TGMappedRegPoly.UpdateParams;
  var PP  : TGRegPoly;
      Map : TGTransformation;
      pt, bpt : TFloatPoint;
      i   : Integer;
  begin
  DataValid := True;
  PP  := TGeoObj(Parent[0]) as TGRegPoly;
  Map := TGeoObj(Parent[1]) as TGTransformation;
  FReversed := PP.IsReversed XOR Map.IsReversing;
  For i := 0 to Pred(VCount) do begin
    pt.x := TVector3(PP.points[i]).X;
    pt.y := TVector3(PP.points[i]).Y;
    If Map.GetMappedPoint(pt, bpt) then begin
      TVector3(points[i]).X := bpt.x;
      TVector3(points[i]).Y := bpt.y;
      end
    else
      DataValid := False;
    end;  
  UpdateScreenCoords;
  end;

function TGMappedRegPoly.GetInfo: String;
  var s : String;
  begin
  s := Format(MyObjTxt[103], [IntToStr(FVCount)]);
  InsertNameOf(Self, s);
  InsertNameOf(TGeoObj(Parent[0]), s);
  InsertNameOf(TGeoObj(Parent[1]), s);
  Result := s;
  end;


{=============================================================}
{==== Helper functions for the validation check process ======}
{=============================================================}

function maskBreaks(s: String): String;
  { Ersetzt im String s jeden Zeilenumbruch durch '; '. }
  var i : Integer;
  begin
  i := 1;
  While i < Length(s) do begin
    If CharInSet(s[i], [#13, #10]) then begin
      While (i <= Length(s)) and CharInSet(s[i], [#13, #10]) do
        Delete(s, i, 1);
      Insert('; ', s, i);
      end;
    i := i + 1;
    end;
  While CharInSet(s[Length(s)], [';', ' ']) do
    Delete(s, Length(s), 1);
  Result := s;
  end;

function rebuildBreaks(s: String): String;
  { Ersetzt im String s jedes ';' durch einen Standard-Zeilenumbruch
    und löscht alle eventuell auf das Semikolon folgenden Leerzeichen;
    enthält s überhaupt kein ';', wird ersatzweise vor jedem '@' ein
    Zeilenumbruch eingefügt.                                         }
  var i : Integer;
  begin
  i := Pos(';', s);
  If i > 0 then
    While i > 0 do begin
      Delete(s, i, 1);
      While (i <= Length(s)) and (s[i] = ' ') do
        Delete(s, i, 1);
      Insert(#13#10, s, i);
      i := Pos(';', s);
      end
  else begin
    i := PosEx('@', s, 3);
    While i > 0 do begin
      Insert(#13#10, s, i);
      i := PosEx('@', s, i + 3);
      end;
    end;
  Result := s;
  end;

  
function ValidationTermOk(    Drawing  : TGeoObjListe;
                              VTermStr,
                              VVars    : String;
                          var ErrMsg   : String;
                          var ErrNum   : Integer) : Boolean;
  { Zunächst wird die Korrektheits-Bedingung nur darauf überprüft,
    ob sie genau so viele schließende wie öffnende Klammern enthält.
    Falls ja, wird eine Probe-Kompilation des Terms durchgeführt. Das
    Ergebnis wird in ErrNum zurückgegeben:

       0 :  Alles okay !
       1 :  Anzahl der öffnenden Klammern <> Anzahl der schließenden Klammern
       2 :  Ungültige Bool'sche Bedingung
     < 0 :  Syntaxfehler im Korrektheits-Term VTermStr an der Stelle (-ErrNum)

    In ErrMsg wird gegebenenfalls eine Fehlermeldung zurückgegeben.
    Das Ergebnis der Funktion ist genau dann TRUE, wenn ErrNum = 0 ist.     }

  var s       : String;
      BB      : TBoolBaum;      //  "B"oole'scher "B"aum
      ob, cb,                   //  "o"pening and "c"losing "b"rackets
      n, i    : Integer;
  begin
  ErrMsg := '';     // optimistische Annahmen
  ErrNum :=  0;
  ob := 0; cb := 0;
  s := VTermStr;
  For i := 1 to Length(s) do begin
    n := Pos(s[i], brackets);
    If n > 0 then
      If Odd(n) then Inc(ob)
      else           Inc(cb);
    end;
  If ob <> cb then begin
    ErrMsg := MyMess[116];
    ErrNum := 1;
    end
  else begin
    BB := TBoolBaum.Create(Drawing, Deg, s);
    If Not BB.IsOkay then begin
      If Length(BB.ErrorMsg) > 0 then
        ErrMsg := MyMess[117] + ':'#13#10 + BB.ErrorMsg
      else
        ErrMsg := MyMess[117] + '.';
      If BB.ErrorSpot > 0 then
        ErrNum := -BB.ErrorSpot
      else
        ErrNum := 2;
      end;
    FreeAndNil(BB);
    end;
  Result := ErrNum = 0;
  end;



{-------------------------------------------}
{ TGCheckControl's Methods Implementation   }
{-------------------------------------------}


constructor TGCheckControl.Create(iObjList: TGeoObjListe;
                                  iValiTerm: WideString;
                                  iValiVars, iValiHint: String);
  begin
  Inherited Create(iObjList, False);
  FVTermStr := iValiTerm;
  FVVars := iValiVars;
  FVHint := iValiHint;
  FVBBaum := TBoolBaum.Create(ObjList, Deg, FVTermStr);
  If FVBBaum.IsOkay then
    FVBBaum.RegisterTermParentsIn(Self);
  end;

constructor TGCheckControl.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var ccData: IXMLNode;
  begin
  inherited CreateFromDomData(iObjList, DE);
  ccData := DE.childNodes.findNode('cc_data', '');
  If Assigned(ccData) then begin
    FVTermStr := literalLine(ccData.getAttribute('term'));
    FVVars    := rebuildBreaks(ccData.getAttribute('vars'));
    FVHint    := ccData.getAttribute('hint');
    end;
  end;

procedure TGCheckControl.AfterLoading(FromXML: Boolean);
  begin
  Inherited AfterLoading(FromXML);
  If Length(FVTermStr) > 0 then begin
    FVBBaum := TBoolBaum.Create(ObjList, Deg, FVTermStr);
    If FVBBaum.IsOkay then
      FVBBaum.RegisterTermParentsIn(Self);
    end;
  end;

function TGCheckControl.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var ccData: IXMLNode;
  begin
  Result := Inherited CreateObjNode(DomDoc);

  ccData := DomDoc.createNode('cc_data');
  ccData.setAttribute('term', maskDelimiters(FVTermStr));
  ccData.setAttribute('vars', maskBreaks(FVVars));
  ccData.setAttribute('hint', FVHint);
  Result.childNodes.add(ccData);
  end;

destructor TGCheckControl.Destroy;
  begin
  FVBBaum.Free;
  Inherited Destroy;
  end;

function TGCheckControl.GetVTermStr: WideString;
  begin
  If Assigned(FVBBaum) then
    Result := FVBBaum.SourceStr
  else
    Result := FVTermStr;
  end;

function TGCheckControl.GetHTMLString: WideString;
  begin
  If Assigned(FVBBaum) then
    Result := FVBBaum.GetHTMLString
  else
    If Length(FVTermStr) > 0 then
      Result := FVTermStr
    else
      Result := '';
  end;

function TGCheckControl.Dist(xm, ym: Double): Double;
  begin
  Result := 1e100;
  end;

function TGCheckControl.IsNearMouse: Boolean;
  begin
  Result := False;
  end;

procedure TGCheckControl.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  { Do nothing }
  end;

procedure TGCheckControl.DrawIt;
  begin
  { Do nothing }
  end;

procedure TGCheckControl.HideIt;
  begin
  { Do nothing }
  end;

function  TGCheckControl.GetVarObj(num: Integer): TGeoObj;
  begin
  Result := Nil;
  end;

procedure TGCheckControl.RebuildTermStrings;
  begin
  FVBBaum.RebuildSourceStr;
  If FVBBaum.IsOkay then
    FVTermStr := FVBBaum.SourceStr;
  end;


function TGCheckControl.CheckSolution(TargetObj: Array of TGeoObj): Integer;
  { Ermittelt Informationen über die Korrektheit der Konstruktion :
    Result:  |      Bedeutung:
        0    | Konstruktion ist korrekt              <TRUE>
        1    | Fehler in der Korrektheits-Bedingung  <unentscheidbar>
        2    | Konstruktion ist falsch               <FALSE>             }

  function GetCheckCount: Integer;
    var n, i : Integer;
    begin
    n := 0;
    For i := 0 to ObjList.LastValidObjIndex do
      If (TGeoObj(ObjList[i]).ClassType = TGPoint) or
         (TGeoObj(ObjList[i]).ClassType = TGNumberObj) then
        n := n + 1;
    If n > 0 then
      Result := CheckCount
    else
      Result := 0;
    end;

  var termStr : WideString;
      RT      : TStringList;   // "R"eplace "T"able
      VTB     : TBoolBaum;     // "V"alidation "T"erm-"B"aum
      tok     : Boolean;
      imax,
      fc,                      // "f"ail "c"ounter
      i       : Integer;
  begin
  RT  := TStringList.Create;
  try
    RT.Text := FVVars;
    For i := 0 to High(TargetObj) do
      RT.ValueFromIndex[i] := TargetObj[i].Name;
    termStr := ReplaceVarsIn(FVTermStr, RT);
  finally
    RT.Free;
  end;
  If (Length(termStr) > 0) and (Pos('@', termStr) = 0) then begin
    VTB := TBoolBaum.Create(Self.ObjList, Deg, termStr);
    try
      If VTB.IsOkay then begin
        ObjList.SimInit;
        Result := 0;
        i      := 0;
        fc     := 0;
        imax   := GetCheckCount;
        While (i <= imax) and (Result = 0) do begin
          ObjList.SimDrag(SimShow);   // Verziehen ausführen...
          tok := VTB.Calculate(0);    // ... und auswerten
          If VTB.IsOkay then          // Term korrekt ausgewertet
            If Not tok then               // Ergebnis: falsch !
              Result := 2
            else                          // Ergebnis: richtig !
          else                        // Fehler bei der Term-Auswertung
            fc := fc + 1;                 // Mitzählen für die Statistik !
          i := i + 1;                 // Weiterschalten
          end;

        { Gesamtergebnis der Simulation }
        If (i >= imax) and
           (fc <= imax * 3 Div 4) then begin // Konstruktion ist korrekt
          ObjList.SimDrag(SimShow, 1);      // => In Ausgangslage zurückführen !
          ObjList.SimClose;
          end
        else begin                           // Konstruktion ist nicht korrekt
          If Not SimShow then               // => gegebenenfalls einen
            ObjList.SimDrag(True, 2);      //    abgekürzten Zugvorgang zeigen !
          Result := 2;
          end;
        end
      else
        Result := 1;                  // Fehler in der Korrektheits-Bedingung !
    finally
      VTB.Free;
    end; { of try }
    end
  else
    Result := 1;                  // Fehler in der Korrektheits-Bedingung !
  end;

procedure TGCheckControl.UpdateScreenCoords;
  begin
  { Do nothing }
  end;

procedure TGCheckControl.UpdateParams;
  begin
  { Do nothing }
  end;

function TGCheckControl.GetInfo: String;
  begin
  { Do nothing }
  end;


{-------------------------------------------}
{ TGUnknown's Methods Implementation        }
{-------------------------------------------}

constructor TGUnknown.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  inherited CreateFromDomData(iObjList, DE);
  DataValid := False;
  end;

function TGUnknown.Dist(xm, ym: Double): Double;
  begin
  Result := 1.0e300;
  end;

function TGUnknown.IsNearMouse: Boolean;
  begin
  Result := False;
  end;

procedure TGUnknown.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  { do nothing }
  end;

procedure TGUnknown.UpdateParams;
  begin
  { do nothing }
  end;

procedure TGUnknown.UpdateScreenCoords;
  begin
  { do nothing }
  end;

procedure TGUnknown.DrawIt;
  begin
  { do nothing }
  end;

procedure TGUnknown.HideIt;
  begin
  { do nothing }
  end;

function TGUnknown.GetInfo: String;
  begin
  Result := '';
  end;


function TGUnknown.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := Nil;
  end;



{-------------------------------------------}
{ TGObjGroup's Methods Implementation       }
{-------------------------------------------}

constructor TGObjGroup.Create(iObjList: TGeoObjListe; members: TObjPtrList);
  var i : Integer;
  begin
  Inherited Create(iObjList, false);
  for i := 0 to members.Count - 1 do
    TGeoObj(members[i]).BecomesChildOf(self);
  self.ShowsAlways := true;
  end;

constructor TGObjGroup.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  inherited CreateFromDomData(iObjList, DE);
  end;

function TGObjGroup.DefaultName: WideString;
  begin
  DefaultName := ObjList.GetUniqueName('Gr');
  end;

function TGObjGroup.Dist(xm, ym: Double): Double;
  var i   : Integer;
      nd,
      res : Double;
  begin
  res := 1e10;
  for i := 0 to Children.Count - 1 do begin
    nd := TGeoObj(Children[i]).dist(xm, ym);
    if nd < res then
      res := Max(0, nd);
    end;
  Result := res;
  end;

procedure TGObjGroup.DrawIt;
  begin
  end;

procedure TGObjGroup.HideIt;
  begin
  end;

function TGObjGroup.GetInfo: String;
  var i : Integer;
      s : String;
  begin
  if Parent.Count < 5 then begin
    s := Format(MyObjTxt[113], [IntToStr(Parent.Count)]);
    InsertNameOf(Self, s);
    for i := 0 to Children.Count - 1 do begin
      s := s + TGeoObj(Children[i]).Name;
      if i < Children.Count - 1 then
        s := s + ', '
      else
        s := s + '.';
      end;
    end
  else begin
    s := Format(MyObjTxt[114], [IntToStr(Parent.Count)]);
    InsertNameOf(Self, s);
    end;
  Result := s;
  end;

function TGObjGroup.IsNearMouse: Boolean;
  var i   : Integer;
  begin
  Result := False;
  for i := 0 to Children.Count - 1 do
    if TGeoObj(Children[i]).IsNearMouse then
      Result := True;
  end;

procedure TGObjGroup.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  inherited LoadContextMenuEntriesInto(menu);

  end;

procedure TGObjGroup.UpdateParams;
  begin
  end;

procedure TGObjGroup.UpdateScreenCoords;
  begin
  end;


initialization

RegisterClass(TGDoubleIntersection);
RegisterClass(TGQuadIntersection);
RegisterClass(TGCheckControl);
RegisterClass(TGPolygon);
RegisterClass(TGRegPoly);
RegisterClass(TGMappedRegPoly);
RegisterClass(TGUnknown);
RegisterClass(TGObjGroup);

finalization

end.
