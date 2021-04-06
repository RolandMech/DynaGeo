unit GeoLocLines;

interface

uses Windows, Classes, Types, Menus, Graphics, XMLIntf,
     MathLib, Utility, TBaum, GeoTypes, GeoMakro, GeoTransf,
     Unit_LGS, Generics.Collections;

type

  TGLocLine = class (TGCurve)
    protected
      ParentInitData : TPPInitDataList;
      FOLStatus : Integer; { -2 : alte 1.4er Ortslinie, statisch  }
                           { -1 : während der Aufzeichnung        }
         {     falls >= 0 und < 2^16 :                            }
         {  Bit-Nr.       Wert = 0                     Wert = 1                    }
         {=========================================================================}
         {   0          statische Spur            dynamische Ortslinie             } {00000001h}
         {   1    als Punkte-Serie dargestellt    als Spline dargestellt           } {00000002h}
         {   2      Punkteliste ist statisch      Punkteliste stets neu berechnen  } {00000004h} // DEPRECATED!
         {     falls >= 2^16 :                                                     }
         {  16              ---                   OL ist Gerade                    } {00010000h}
         {  17              ---                   OL ist Kreis                     } {00020000h}
         {  18              ---                   OL ist Kegelschnitt (???)        } {00040000h}
      function  DefaultName: WideString; override;
//      procedure SetShowsAlways(vis: Boolean); override;
      function  GetIsDynamic: Boolean;
      procedure SetIsDynamic(flag: Boolean);
      function  GetIsSpline: Boolean;
      procedure SetIsSpline(flag: Boolean);
      function  GetIsStraightLine: Boolean;
      procedure SetIsStraightLine(flag: Boolean);
      function  GetIsCircle: Boolean;
      procedure SetIsCircle(flag: Boolean);
      function  GetIsConic: Boolean;
      procedure SetIsConic(flag: Boolean);
      function  GetIsStandardLine: Boolean;
      function  GetIsVisible: Boolean; override;
      function  IsReallySpline: Boolean; virtual;
      function  GetStandardLineChild: TGLine;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure VirtualizeCoords; override;
      procedure RecalculatePointList; virtual;
      procedure UpdateScreenCoords; override;
      procedure UpdateNameCoordsIn(TextObj: TGTextObj); override;
      procedure SetNewNameParamsIn(TextObj: TGTextObj); override;
      procedure SetNewTempRelationships;
      procedure ResetTempRelationships;
      procedure DrawIt; override;
      procedure HideIt; override;
      procedure Invalidate; override;
      procedure Revalidate; override;
    public
      constructor Create (iObjList: TGeoObjListe; GeneratorPt: TGPoint);
      constructor CreateFromI2G(iObjList : TGeoObjListe; GeneratorPt, DraggedObj: TGeoObj; iis_visible: Boolean);
      constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      constructor Load (S: TFileStream; iObjList: TGeoObjListe);
      constructor Load32(R: TReader; iObjList: TGeoObjListe); override;
      destructor  Destroy; override;
      procedure AfterLoading(FromXML: Boolean); override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      function  Check4StandardLine(var SLTyp: Integer): Boolean;
      function  SLChildrenCount: Integer;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      procedure ResetOLCPList(PointList : TVector3List); override;
      procedure CheckOLState(DraggedObj: TGParentObj);
      procedure RebuildPointers; override;
      procedure ResetParentList;
      procedure UpdateParams; override;
      procedure AutoUpdate; virtual;
      procedure RegisterAsMacroStartObject; override;
      procedure SetNameRefPtCoords;
      procedure SetNewName(NewName: WideString); override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  Includes(xp, yp: Double): Boolean; override;
      function  GetTangentIn(bx, by: Double; var tanCoeff: TVector3): Boolean; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      function  GetInfo: String; override;
      property  OLStatus       : Integer read FOLStatus;
      property  IsDynamic      : Boolean read GetIsDynamic      write SetIsDynamic;
      property  IsSpline       : Boolean read GetIsSpline       write SetIsSpline;
      property  IsStraightLine : Boolean read GetIsStraightLine write SetIsStraightLine;
      property  IsCircle       : Boolean read GetIsCircle       write SetIsCircle;
      property  IsConic        : Boolean read GetIsConic        write SetIsConic;
      property  IsStandardLine : Boolean read GetIsStandardLine;
    end;


  TGMappedLocLine = class(TGLocLine)
    public
      constructor Create (iObjList: TGeoObjListe; iPLL: TGLocLine; iMO: TGTransformation);
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      procedure UpdateParams; override;
      function  GetInfo: String; override;
    end;


  TGEnvelopLine = class(TGLocLine)
    protected
      { FOLStatus : Integer;  geerbt von TGLocLine, (*) <==>  neue Interpretation     }
         { während der Aufzeichnung des Objekts :  = -1 ;                             }
         {                                                                            }
         { nach der Aufzeichnung des Objekts:  bitweise Interpretation                }
         {       falls >= 0 und < 2^16 :                                              }
         {  Bit-Nr.          Wert = 0                     Wert = 1                    }
         {============================================================================}
         {   0            statische Spur             dynamische Hüllkurve             } {00000001h}
         {   1      als Punkte-Serie dargestellt    als Spline dargestellt            } {00000002h}
         {   2(*)      Hüllkurve unterdrücken        Hüllkurve darstellen             } {00000004h}
         {   3(*)    Geradenschar unterdrücken      Geradenschar darstellen           } {00000008h}
         {       falls >= 2^16 :                                                      }
         {  16                 ---                   OL ist Gerade                    } {00010000h}
         {  17                 ---                   OL ist Kreis                     } {00020000h}
         {  18                 ---                   OL ist Kegelschnitt (???)        } {00040000h}
      lines : TVector3List;
      function DefaultName: WideString; override;
      function GetShowLines: Boolean;
      procedure SetShowLines(nv: Boolean);
      function GetShowCurve: Boolean;
      procedure SetShowCurve(nv: Boolean);
      procedure RecalculatePointList; override;
      procedure DrawIt; override;
      procedure HideIt; override;
    public
      constructor Create (iObjList: TGeoObjListe; GeneratorLn: TGStraightLine);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      procedure AfterLoading(FromXML: Boolean); override;
      function CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      destructor Destroy; override;
      procedure UpdateParams; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function GetInfo: String; override;
      property ShowLines: Boolean read GetShowLines write SetShowLines;
      property ShowCurve: Boolean read GetShowCurve write SetShowCurve;
    end;


  TGFunktion = class(TGLocLine)
    protected
      BufTermStr : WideString;
      FTerm,
      FDerive1   : TTBaum;
      FDerivable : Boolean;
      FStepCount : Integer;
      FCurLen    : Double;
      function  GetTermString: WideString;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure Rescale; override;
      procedure SetTermString(nv: WideString);
      function  DefaultName: WideString; override;
      procedure UpdateScreenCoords; override;
    public
      constructor Create (iObjList: TGeoObjListe; iFunkTerm: WideString);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      destructor Destroy; override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure AfterLoading(FromXML : Boolean = True); override;
      function  IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
      function  IsTrigWithBigVariation: Boolean;
      function  GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
      function  GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
      function  GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean; override;
      function  GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean; override;
      function  Dist(xm, ym: Double): Double; override;
      procedure UpdateParams; override;
      procedure AutoUpdate; override;
      procedure ResetOLCPList(PointList : TVector3List); override;
      procedure ResetStepCount;
      procedure RebuildTermStrings; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
      function  GetTangentIn(bx, by: Double; var tanCoeff: TVector3): Boolean; override;
      function  GetFunctionValue(x: Double; var y: Double): Boolean;
      function  GetDerivationValue(x: Double; n: Integer; var y: Double): Boolean;
      function  GetMaxValueIn(xmin, xmax: Double; var ymax: Double): Boolean;
      function  GetMinValueIn(xmin, xmax: Double; var ymin: Double): Boolean;
      function  GetInfo: String; override;
      function  GetDataStr: String; override;
      function  GetHTMLString: String;
      property IsDerivable: Boolean read FDerivable;
      property TermString: WideString read GetTermString write SetTermString;
    end;

  TGIPolynomFkt = class(TGFunktion)
    private
      polyGrad  : Integer;
      polyCoeff : TEquation;
      procedure SetNewTermString(nv: WideString);
      function Points2Polynom: Boolean;
    public
      constructor Create (iObjList: TGeoObjListe; iPList: TList<TGPoint>);
      procedure AfterLoading(FromXML : Boolean = True); override;
      procedure UpdateParams; override;
      function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
      procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
    end;

  TGIntArea = class(TGArea)
    protected
      FxA, y1A, y2A,
      FxB, y1B, y2B,
      FIntVal        : Double;
      sxli, sxre,
      sylio, syreo,
      syliu, syreu   : Integer;
      DoubleBordered : Boolean;
      function  SetFillHandle: Boolean; virtual;
      function  DefaultName: WideString; override;
      function  AllParentsAreEqual(GO: TGeoObj): Boolean;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure UpdateScreenCoords; override;
      procedure AdjustGraphTools(todraw : Boolean); override;
      procedure DrawLimitLines; override;
      procedure DrawIt; override;
      procedure HideIt; override;
    public
      constructor Create (iObjList: TGeoObjListe; iF1, iF2: TGFunktion; iA, iB: TGPoint);
      procedure AfterLoading(FromXML : Boolean = True); override;
      procedure SaveState; override;
      procedure RestoreState; override;
      function  GetValue(selector: Integer): Double; override;
      procedure UpdateParams; override;
      function  CanBeDragged: Boolean; override;
      function  GetInfo: String; override;
      property  Integral: Double read FIntVal;
    end;


  TGRiemannArea = class(TGIntArea)
    protected
      FRType    : Integer;   { "R"iemann-"Typ":
                                 0 : Untersumme
                                 1 : Obersumme     }
      FIntCount : Integer;   { Anzahl der Teil-Intervalle }
      FIntCTerm : TTBaum;    { Termbaum für den FIntCount-Wert }
      Points    : Array of TFloatPoint;
      IntPtList : Array of TPoint;
      function  HasSameDataAs(GO: TGeoObj): Boolean; override;
      procedure SetRType(newVal: Integer);
      procedure SetIntCount(newVal: Integer);
      function  SetFillHandle: Boolean; override;
      function  GetIntCountStr: String;
      procedure UpdateScreenCoords; override;
      procedure DrawLimitLines; override;
    public
      constructor Create (iObjList: TGeoObjListe; iF1: TGFunktion; iA, iB: TGPoint;
                          iRType: Integer; iIntCount: String);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
      destructor Destroy; override;
      function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
      procedure AfterLoading(FromXML: Boolean); override;
      procedure SaveState; override;
      procedure RestoreState; override;
      procedure SortSiblings;
      procedure LoadContextMenuEntriesInto(menu: TPopupMenu); override;
      function  HasSibling(var GO: TGeoObj): Boolean;
      function  CanBeDragged: Boolean; override;
      procedure SetNewIntCountTerm(nt: String);
      procedure UpdateParams; override;
      function  GetInfo: String; override;
      property  Intervals : Integer read FIntCount;
      property  IntervalStr : String read GetIntCountStr;
      property  RiemannType : Integer read FRType write SetRType;
    end;


implementation

Uses Forms, Math, SysUtils, Declar, GlobVars, GeoConic;

{-------------------------------------------}
{ TGLocLine's Methods Implementation        }
{-------------------------------------------}

constructor TGLocLine.Create(iObjList : TGeoObjListe; GeneratorPt: TGPoint);
  begin
  Inherited Create(iObjList, False);     // zunächst unsichtbar erzeugen !
  If GeneratorPt <> Nil then
    FMyColour  := GeneratorPt.MyColour
  else
    FMyColour := clRed;
  MyPenStyle := psSolid;
  If Odd(DefLocLineStyle) then
    MyLineWidth := 3
  else
    MyLineWidth := 1;
  F_CCTP := True;
  If GeneratorPt <> Nil then begin
    BecomesChildOf (GeneratorPt);
    ParentInitData := TPPInitDataList.Create;
    ParentInitData.Insert(0, TPointParams.CreateWithDataFrom(GeneratorPt));
    end;
  LastDist   := 1.0e300;
  points    := TVector3List.Create;
  FOLStatus := -1;  // Ermöglicht die punktweise Aufzeichnung der Ortslinie !
  FStatus   := FStatus or gs_ShowsAlways;   // erst hier sichtbar schalten !
  end;

constructor TGLocLine.CreateFromI2G(iObjList : TGeoObjListe; GeneratorPt, DraggedObj: TGeoObj; iis_visible: Boolean);
  begin
  Inherited Create(iObjList, False);
  If GeneratorPt <> Nil then
    FMyColour  := GeneratorPt.MyColour
  else
    FMyColour := clRed;
  MyPenStyle := psSolid;
  If Odd(DefLocLineStyle) then
    MyLineWidth := 3
  else
    MyLineWidth := 1;
  F_CCTP := True;
  BecomesChildOf (DraggedObj);
  BecomesChildOf (GeneratorPt);
  ParentInitData := TPPInitDataList.Create;
  ParentInitData.Insert(0, TPointParams.CreateWithDataFrom(GeneratorPt));
  ParentInitData.Insert(0, TPointParams.CreateWithDataFrom(DraggedObj));
  LastDist   := 1.0e300;
  points    := TVector3List.Create;
  FOLStatus := 3;
  FStatus   := FStatus or gs_ShowsAlways; // erst hier sichtbar schalten !
  end;

constructor TGLocLine.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Halt;  // Gewaltsamer Abbruch !!
  end;

constructor TGLocLine.Load (S: TFileStream; iObjList: TGeoObjListe);
  var id, n, i : Integer;
      OldTOLPt : TOLPoint;
  begin
  Inherited Load(S, iObjList);
  F_CCTP    := True;
  FOLStatus := -2;  { Markiert die OL als Vers. 1.4, statisch }
  Parent.Clear;     { Löscht die Parent-Liste komplett        }
  points    := TVector3List.Create;
  id := ReadOldIntFromStream(S);
  If id = $32 then begin
    n := ReadOldIntFromStream(S);
    ReadOldIntFromStream(S);
    ReadOldIntFromStream(S);
    For i := 0 to Pred(n) do begin
      id := ReadOldIntFromStream(S);  { muß 169 sein ! }
      If id = 169 then begin
        OldTOLPt := TOLPoint.Load(S);
        points.Add(TVector3.Create(OldTOLPt.X, OldTOLPt.Y, 0));
        OldTOLPt.Free;
        end
      else
        Raise EStreamError.Create('OrtsLinienPunkt erwartet!');
      end;
    end
  else
    Raise EStreamError.Create('PunkteListe erwartet!');
  ParentInitData := TPPInitDataList.Create;
  end;

constructor TGLocLine.Load32(R: TReader; iObjList: TGeoObjListe);
  begin
  Inherited Load32(R, iObjList);
  F_CCTP    := True;
  FOLStatus := R.ReadInteger;
  points    := TVector3List.Load32(R);
  R.ReadInteger; { 23.04.03: Die frühere Variable "NameRefPtIndex" wurde ab-
                   geschafft. Damit ist hier ein Integer-Puffer entstanden. }
  ParentInitData := TPPInitDataList.Load32(R);
  end;

constructor TGLocLine.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var dompoints : IXMLNode;
      ActParent : TGeoObj;
      i         : Integer;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  F_CCTP := True;

  dompoints := DE.childNodes.findNode('points', '');
  points := TVector3List.CreateFromString(dompoints.nodeValue);

  If ClassType = TGLocLine then begin
    ParentInitData := TPPInitDataList.Create;
    For i := 0 to Pred(Parent.Count) do begin
      ActParent := iObjList.GetObj(Integer(Parent.Items[i]));
      If ActParent is TGPoint then
        ParentInitData.Add(TPointParams.CreateWithDataFrom(ActParent))
      else
        ParentInitData.Add(TPointParams.Create);
      end;
    end;  

  If DE.hasAttribute('trace_status') then
    FOLStatus := StrToInt(DE.getAttribute('trace_status'))
  else
    if ClassType = TGLocLine then begin
      FOLStatus := 0;         { Vorsichtshalber: Statische Spur }
      IsMakMarked := True;    { Nötig ? Später prüfen !         }
      end
    else
      FOLStatus := 7;
  end;

procedure TGLocLine.AfterLoading(FromXML: Boolean);
  { 22.06.08 : Fehlermeldung von Magister Johann Winkler: Aufruf von
               "ResetParentList" (für Parent.Count > 0) ersatzlos entfernt,
    weil er bei bei Ortslinien, die von Strecken fester Länge abhängen, zu
    dauernder Ungültigkeit führen konnte: der zweite Streckenendpunkt wurde
    nicht mehr in der Elternliste aufgeführt! (Bug-Datei: "vierblatt.geo")
    Dieser Fehler war in der Version "3.0 f" noch nicht vorhanden; es
    handelte sich also um einen frisch eingbauten "3.1"-Bug, der auch auf
    den Viewer durchschlug !

    18.08.08 : Fehlermeldung von Elschenbroich/Henn: Ortslinie "mit Sprung"
               kann nicht mehr wiederhergestellt werden. Die Ortslinie wird
    dauerhaft ungültig! (Bug-Datei: "beispiel-26.geo" von W. Henn [Regen-
    bogen])  Daher "ResetParentList" modifiziert (siehe dort!) und den
    Aufruf hier wieder eingefügt, so dass nun beide Dateien korrekt
    geladen werden können.                                                 }

  begin
  Inherited AfterLoading(FromXML);
  If Self.ClassType = TGLocLine then begin
    If Parent.Count = 0 then
      FOLStatus := -2     // alte statische Spuren !
    else
      ResetParentList;    // Nun doch wieder !
    end;
  end;

function  TGLocLine.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var DOMPos,
      DOMPoints : IXMLNode;
      s : String;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  DOMPos := Result.childNodes.findNode('position', '');
  Result.childNodes.remove(DOMPos);

  Result.setAttribute('trace_status', IntToStr(OLStatus));

  DOMPoints := DOMDoc.createNode('points');
  s := points.GetContentsString;
  DOMPoints.nodeValue := s;
  Result.childNodes.add(DOMPoints);
  end;

procedure TGLocLine.RebuildPointers;
  { 12.10.2006: Rekonstruktion der Children-Listen aus den Parent-Listen;
                spart die Notwendigkeit des Abspeicherns der eigentlich
                redundanten Children-Listen ein.
    27.11.2006: Bei Ortslinien wird nur in die Kinderliste des
                Generatorpunkts eingetragen.
    09.04.2008: "Children.Insert(0, Self)" ersetzt durch "Children.Add(Self)"
                (Klement-Bug vom 30.03.08: Namensobjekte von Funktionen
                 tauchten als 2. Eintrag(!) in der Children-Liste auf
                 statt als 1. Eintrag, wie es der Standard fordert    )     }
  var i : Integer;
  begin
  Parent.ResolveGeoNums(ObjList);
  If ClassType = TGLocLine then
    TGeoObj(Parent.Last).Children.Add(Self)
  else
    For i := 0 to Pred(Parent.Count) do
      TGeoObj(Parent[i]).Children.Add(Self);
  end;

function TGLocLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = Self.ClassType) and
            (TGLocLine(GO).IsDynamic and Self.IsDynamic) and
            (GO.Parent.Count = Self.Parent.Count) and
            ((GO.Parent.Count = 0) or
             ((GO.Parent[0] = Self.Parent[0]) and
              (GO.Parent.Last = Self.Parent.Last)));
  end;

function TGLocLine.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('OL');
  end;

procedure TGLocLine.RegisterAsMacroStartObject;
  begin
  TMakro(ObjList.MakroList.Last).MakroStatus := -8;
  end;


function TGLocLine.GetIsSpline: Boolean;
  begin
  Result := (OLStatus >= 0) and
            (OLStatus and ols_IsSpline > 0);
  end;

procedure TGLocLine.SetIsSpline(flag: Boolean);
  { Wenn bei einer dynamischen Ortslinie IsSpline eingeschaltet wird,
    dann wird automatisch auch IsAutomatic eingeschaltet.
    Bei Spuren hingegen hat das Setzen von IsAutomatic keinen Erfolg,
    weil diese nicht dynamisch sind.                                  }
  begin
  If flag <> IsSpline then begin
    If IsVisible then
      HideIt;
    If flag then
      FOLStatus := OLStatus or ols_IsSpline
    else
      FOLStatus := OLStatus and Not ols_IsSpline;
    If IsVisible then begin
      UpdateScreenCoords;
      DrawIt;
      end;
    end;
  end;

function TGLocLine.GetIsDynamic: Boolean;
  begin
  Result := (OLStatus >= 0) and
            (OLStatus and ols_IsDynamic > 0);
  end;

procedure TGLocLine.SetIsDynamic(flag: Boolean);
  { Wenn für eine Ortslinie IsDynamic eingeschaltet wird,
    dann wird auch gleichzeitig IsAutomatic eingeschaltet. }
  begin
  If flag <> IsDynamic then
    If flag then begin
      FOLStatus := OLStatus or ols_IsDynamic;
      UpdateParams;
      end
    else begin
      IsStraightLine := False;
      IsCircle := False;
      FOLStatus := OLStatus and Not ols_IsDynamic;
      end;
  end;

function TGLocLine.GetIsVisible: Boolean;
  begin
  Result := (Inherited GetIsVisible) and
            Assigned(IntPointLists) and
            (High(IntPointLists) >= 0);
  end;

function TGLocLine.GetStandardLineChild: TGLine;
  var i : Integer;
  begin
  i := 0;
  Result := Nil;
  While (Result = Nil) and (i < Children.Count) do
    If TGeoObj(Children[i]) is TGLine then
      Result := TGeoObj(Children[i]) as TGLine
    else
      Inc(i);
  end;

function  TGLocLine.GetIsStraightLine: Boolean;
  begin
  Result := (OLStatus >= 0) and
            (OLStatus and ols_IsStraightLine > 0);
  end;

procedure TGLocLine.SetIsStraightLine(flag: Boolean);
  var ErrNum   : Integer;
      SL_Child : TGeoObj;
  begin
  If IsStraightLine <> flag then
    If flag then
      If IsDynamic then begin
        ObjList.InsertObject
           (TGOLLongLine.Create(ObjList, Self, True), ErrNum);
        FOLStatus := (OLStatus and $0000FFFF) or ols_IsStraightLine;
        end
      else
        { Nix machen! }
    else begin
      SL_Child := GetStandardLineChild;
      If SL_Child <> Nil then
        ObjList.FreeObject(SL_Child);
      FOLStatus   := OLStatus and $0000FFFF;
      ShowsAlways := True;
      end;
  end;

function  TGLocLine.GetIsCircle: Boolean;
  begin
  Result := (OLStatus >= 0) and
            (OLStatus and ols_IsCircle > 0);
  end;

procedure TGLocLine.SetIsCircle(flag: Boolean);
  var ErrNum  : Integer;
      SL_Child: TGeoObj;
  begin
  If IsCircle <> flag then
    If flag then
      If IsDynamic then begin
        ObjList.InsertObject
           (TGOLCircle.Create(ObjList, Self, True), ErrNum);
        FOLStatus := (OLStatus and $0000FFFF) or ols_IsCircle;
        end
      else
        { Nix machen! }
    else begin
      SL_Child := GetStandardLineChild;
      If SL_Child <> Nil then
        ObjList.FreeObject(SL_Child);
      FOLStatus   := OLStatus and $0000FFFF;
      ShowsAlways := True;
      end;
  end;

function  TGLocLine.GetIsConic: Boolean;
  begin
  Result := (OLStatus >= 0) and
            (OLStatus and ols_IsConic > 0);
  end;

procedure TGLocLine.SetIsConic(flag: Boolean);
  var ErrNum  : Integer;
      SL_Child: TGeoObj;
  begin
  If IsConic <> flag then
    If flag then
      If IsDynamic then begin
        ObjList.InsertObject
           (TGOLConic.Create(ObjList, Self, True), ErrNum);
        FOLStatus := (OLStatus and $0000FFFF) or ols_IsConic;
        end
      else
        { Nix machen! }
    else begin
      SL_Child := GetStandardLineChild;
      If SL_Child <> Nil then
        ObjList.FreeObject(SL_Child);
      FOLStatus   := OLStatus and $0000FFFF;
      ShowsAlways := True;
      end;
  end;

function TGLocLine.GetIsStandardLine: Boolean;
  begin
  Result := (OLStatus and $FFFF0000) > 0;
  end;

function TGLocLine.IsReallySpline: Boolean;
  var slc : TGLine;
  begin
  Result := IsSpline;
  If IsStandardLine then begin
    slc := GetStandardLineChild;
    If Assigned(slc) then
      Result := slc.DataValid;
    end;
  end;

procedure TGLocLine.SetNewTempRelationships;
  { Löscht zunächst in allen Punkten der Parent-Liste die
    *temporären* Eltern; ist also ein Punkt über eine Strecke
    fester Länge an einen anderen gebunden, dann wird eine daraus
    resultierende Elternschaft nun (vorübergehend) aufgelöst.
    Dies erledigt der Aufruf von TGPoint.SaveState!
    Danach werden die Elternschaften für solche Strecken fester
    Länge wieder konstruiert, für die beide Endpunkte Eltern der
    Ortslinie sind, wobei automatisch auf die richtige Richtung der
    Elternschaft geachtet wird: der Elter kommt in der Parent-Liste
    stets *vor* dem Kind!                                           }
  var i, k         : Integer;
      XL_P0, XL_P1 : TGPoint;
  begin
  For i := 0 to Pred(Parent.Count) do
    TGeoObj(Parent[i]).SaveState;

  For i := 0 to Pred(Parent.Count) do
    If TGeoObj(Parent[i]).ClassType = TGPoint then begin
      XL_P0 := TGPoint(Parent[i]);
      For k := Succ(i) to Pred(Parent.Count) do
        If TGeoObj(Parent[k]).ClassType = TGPoint then begin
          XL_P1 := TGPoint(Parent[k]);
          If ObjList.GetFixLineLength(XL_P0, XL_P1) >= 0 then
            XL_P1.BecomesChildOf(XL_P0);
          end;
      end;
  end;

procedure TGLocLine.ResetTempRelationships;
  { Stellt die ursprünglichen temporären Verwandtschaften zwischen
    den Punkten der Parent-Liste wieder her, macht also rückgängig,
    was von SetTempRelationships eingerichtet wurde.               }
  var i : Integer;
  begin
  For i := 0 to Pred(Parent.Count) do
    TGeoObj(Parent[i]).RestoreState;
  end;

function TGLocLine.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var pv   : TVector3;
      odbm : TGeoObj;   { "O"ld "D"ragged "B"y "M"ouse }
      i    : Integer;

  procedure Simulate(v : TVector3);
    var i : Integer;
    begin
    If TGPoint(Parent.First).SetLinePosition(v.z) then begin
      For i := 1 to Pred(Parent.Count) do
        TGeoObj(Parent[i]).UpdateParams;
      With TGPoint(Parent.Last) do
        If DataValid then begin
          v.x := X;
          v.y := Y;
          end
        else
          v.IsValid := False;
      end
    else
      v.IsValid := False;
    end;

  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  If Parent.IndexOf(ObjList.DraggedObj) >= 0 then begin
    odbm := ObjList.DraggedObj;
    ObjList.DraggedObj := Nil;
    end
  else
    odbm := Nil;
  pv := TVector3.Create(0, 0, param);
  try
    SetNewTempRelationships;
    For i := 0 to Pred(Parent.Count) do
      If TGeoObj(Parent[i]) is TGPoint then
        TPointParams(ParentInitData[i]).WriteDataTo(Parent[i])
      else
        TGeoObj(Parent[i]).SaveState;

    Simulate(pv);

    For i := 0 to Pred(Parent.Count) do
      If TGeoObj(Parent[i]) is TGPoint then
        TPointParams(ParentInitData[i]).LoadDataFrom(Parent[i])
      else
        TGeoObj(Parent[i]).RestoreState;
    ResetTempRelationships;

    If pv.IsValid then begin
      px := pv.x;
      py := pv.y;
      Result := True;
      end;
  finally
    pv.Free;
  end;
  If odbm <> Nil then
    ObjList.DraggedObj := odbm;
  end;

function TGLocLine.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var n, i : Integer;
      p    : Array[-1..1] of TVector3;
      q    : Array[ 0..1] of TVector3;
  begin
  Result := False;
  n := points.GetPtIndexNextToXY(px, py);
  If n >= 0 then begin
    If (n = 0) or (n = Pred(points.Count)) then
      param := TVector3(points.Items[n]).z
    else begin
      For i := -1 to 1 do
        p[i] := TVector3(points.Items[n+i]);
      For i := 0 to 1 do begin
        q[i] := TVector3.Create(0, 0, 0);
        GetPedalPoint(p[i-1].X, p[i-1].Y, p[i].X, p[i].Y,
                      px, py, q[i].X, q[i].Y);
        If not GetTV(p[i-1].X, p[i-1].Y, p[i].X, p[i].Y,
                     q[i].X, q[i].Y, q[i].Z) then
          q[i].Z := -1;
        end;
      If (q[0].z >= 0) and (q[0].z <= 1) then
        If (q[1].z >= 0) and (q[1].z <= 1) then
          If Hypot(q[0].x - px, q[0].y - py) < Hypot(q[1].x - px, q[1].y - py) then
            param := p[-1].z + (p[0].z - p[-1].z) * q[0].z
          else
            param := p[ 0].z + (p[1].z - p[ 0].z) * q[1].z
        else
          param := p[-1].z + (p[0].z - p[-1].z) * q[0].z
      else
        If (q[1].z >= 0) and (q[1].z <= 1) then
          param := p[ 0].z + (p[1].z - p[ 0].z) * q[1].z
        else
          param := p[ 0].z;
      For i := 0 to 1 do
        q[i].Free;
      end;
    Result := True;
    end;
  end;

procedure TGLocLine.ResetOLCPList(PointList : TVector3List);
  var DraggedObj  : TGParentObj;
      CarrierLine : TGLine;
  begin
  DraggedObj := TGParentObj(Parent.First);
  If DraggedObj.IsLineBound(CarrierLine) then
    CarrierLine.ResetOLCPList(PointList)
  else
    Inherited ResetOLCPList(PointList);  { Sollte nie passieren ! }
  end;

function TGLocLine.Includes(xp, yp: Double): Boolean;
  { Sehr schwache Bedingung wegen der geringen Messgenauigkeit }
  begin
  Result := Dist(xp, yp) < 1/act_PixelPerXcm;
  end;

procedure TGLocLine.ResetParentList;
  { 18.08.2008 : Wegen Bug-Meldung von Elschenbroich/Henn (siehe
                 TGLocLine.AfterLoading) werden nun mit einem Elternpunkt
    auch dessen Freunde (falls es welche gibt) als Ortslinien-Eltern
    verbucht (siehe unten [*]. }

  var DraggedObj  : TGParentObj;
      GeneratorPt : TGPoint;
      GO   : TGeoObj;
      i, k : Integer;
  begin
  If Not IsDynamic then Exit;
  DraggedObj  := TGParentObj(Parent.First);{ das von der Maus gezogene Objekt }
  GeneratorPt := TGPoint(Parent.Last);   { der die Ortslinie erzeugende Punkt }
  If (DraggedObj <> Nil) and (GeneratorPt <> Nil) then
    If DraggedObj <> GeneratorPt then begin
      { Parent-Liste aktualisieren : }
      Parent.Clear;
      Parent.Add(DraggedObj);
      For i := 0 to Pred(ObjList.Count) do begin
        GO := TGeoObj(ObjList[i]);
        If DraggedObj.IsAncestorOf(GO) and
           GO.IsAncestorOf(GeneratorPt) then begin
          Parent.Add(GO);
          If (GO is TGPoint) and (TGPoint(GO).friends.Count > 0) then //  [*]
            For k := 0 to Pred(TGPoint(GO).friends.Count) do          //  [*]
              Parent.Add(TGPoint(GO).friends[k]);                     //  [*]
          end;
        end;
      Parent.Add(GeneratorPt);
      { ParentInitData-Liste aktualisieren : }
      While ParentInitData.Count > 2 do begin
        TPointParams(ParentInitData.Items[1]).Free;
        ParentInitData.Delete(1);
        end;
      For i := Parent.Count - 2 downTo 1 do begin
        GO := Parent[i];
        If GO is TGPoint then
          ParentInitData.Insert(1, TPointParams.CreateWithDataFrom(GO))
        else
          ParentInitData.Insert(1, TPointParams.Create);
        end;
      end
    else  { statische Spur }
      If OLStatus > -2 then
        FOLStatus := OLStatus and 2
      else
        { nix zu tun: es bleibt bei -2 ! }
  else
    DataValid := False;
  end;

procedure TGLocLine.CheckOLState(DraggedObj: TGParentObj);
  { Falls der Zugpunkt *nicht* an eine Linie gebunden ist,
    kann die Ortslinie nicht dynamisch sein !              }
  begin
  If (Parent.Count > 0) and
     (Parent.First = DraggedObj) then begin
    IsDynamic := False;
    UpdateParams;
    end;
  end;

procedure TGLocLine.UpdateParams;
  var DraggedObj    : TGParentObj; { dragged object  }
      GeneratorPt   : TGPoint;     { generator point }
      old_DragObj   : TGeoObj;     { Puffer für altes gezogenes Objekt }
      PtParams      : TPointParams;
      i             : Integer;

  begin { of UpdateParams }
  If ObjList.IsLoading then Exit;
  If (OLStatus = -2) or           { Alte 1.4er Ortslinien kriegen kein Update! }
     (ObjList.UpdatingLocLine <> nil) then  { Andere Ortslinie wird ge-updatet }
    Exit;

  ObjList.UpdatingLocLine := Self;
  GeneratorPt := TGPoint(Parent.Last);    { der die Ortslinie erzeugende Punkt }

  { Zu Beginn der Aufzeichnung:        }
  If OLStatus = -1 then
    With ObjList.DragList do begin        { Eltern suchen }
      i := Pred(Count);
      While (i >= 0) and
            (Items[i] <> GeneratorPt) do Dec(i);
      Dec(i);
      While (i >= 0) do begin
        If TGeoObj(Items[i]).IsAncestorOf(GeneratorPt) then begin
          Parent.Insert(0, Items[i]);  { Dies führt automatisch zur logisch
                           richtigen Reihenfolge, weil die Objekte schon so
                           geordnet in Drawing.DragList stehen !!! }
          If TGeoObj(Items[i]) is TGPoint then
            PtParams := TPointParams.CreateWithDataFrom(Items[i])
          else
            PtParams := TPointParams.Create;
          ParentInitData.Insert(0, PtParams);
          end;
        Dec(i);
        end;
      DataValid  := True;
      FOLStatus  := 0;
      end;

  DraggedObj  := TGParentObj(Parent.First); { das von der Maus gezogene Objekt }
  old_DragObj := ObjList.dragged_by_mouse;
  ObjList.dragged_by_mouse := DraggedObj;

  { Während der laufenden Aufzeichnung :    }
  If (OLStatus <= 0) then
    If (OLineMode = 4) and (DraggedObj <> Nil) and
       (GeneratorPt <> Nil) and GeneratorPt.DataValid  then
      points.InsertZSortedWithXYDist(OLMinDist/act_pixelPerXcm,
                                     GeneratorPt.X, GeneratorPt.Y,
                                     DraggedObj.BoundParam)
    else

  { Nach der Aufzeichnung der Ortslinie:   }
  else
    If IsDynamic then   { Alles neu bauen bei "Dynamischen + automatischen OL" }
      RecalculatePointList;

  SetNameRefPtCoords;
  UpdateScreenCoords;
  ObjList.UpdatingLocLine  := Nil;         { Vorigen Zustand wieder herstellen }
  ObjList.dragged_by_mouse := old_DragObj;
  end; { of UpdateParams }


procedure TGLocLine.RecalculatePointList;
  var DraggedObj    : TGParentObj; { dragged object  }
      CarrierLine   : TGLine;      { Trägerlinie     }
      GeneratorPt   : TGPoint;     { generator point }
      old_MousedObj : TGeoObj;
      old_MouseDir  : TDirection;
      i             : Integer;

  procedure CalculateOLPoint(v : TVector3);
    { v.tag erhält das Ergebnis der Sichtbarkeitsprüfung:
        1   wenn v einen Punkt im sichtbaren Fenster beschreibt;
        0   wenn v einen unsichtbaren Punkt dicht beim Rand beschreibt;
       -1   wenn v einen unsichtbaren Punkt weit entfernt vom Rand angibt;
       -2   wenn v einen ungültigen Punkt beschreibt                    }
    var i  : Integer;
    begin
    If DraggedObj.SetLinePosition(v.z) then
      try
        For i := 1 to Pred(Parent.Count) do
          TGeoObj(Parent[i]).UpdateParams;
        If GeneratorPt.DataValid then begin
          v.x := GeneratorPt.X;
          v.y := GeneratorPt.Y;
          v.tag := ObjList.LogWinKnows(GeneratorPt.X, GeneratorPt.Y);
          end
        else
          v.IsValid := False;
      except
        v.IsValid := False;
      end
    else
      v.IsValid := False;
    end;

  procedure InsertPointsBetween(v0, v1, v2: TVector3);
    { Ergänzt die Punktliste rekursiv um weitere Punkte, so dass die
      Richtungsänderung aufeinanderfolgender Punktpaare nicht zu groß
      ist. Ein Klon dieser Routine wird in TGConic.FillList() verwendet! }
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
      { 29.11.03 : Auch wenn der neue Punkt nicht für weitere rekursive
                   Aufrufe verwendet wird, muss er eingefügt werden!
        Andernfalls bleibt der Algorithmus hängen! (Grund noch unklar,
        aber Effekt zuverlässig reproduzierbar bei Schwebungs-Kurven)      }

      If v0.IsValid and vm.IsValid and v1.IsValid and
         ((v0.tag > 0) or (vm.tag > 0) or (v1.tag > 0)) then
        InsertPointsBetween(v0, vm, v1);

//    If (v1.tag > 0) or (vn.tag > 0) or (v2.tag > 0) then
//        InsertPointsBetween(v1, vn, v2);

      { 29.11.03 : Dieser naheliegende rekursive Aufruf in der 2. Hälfte
                   des aktuellen Intervalls wurde aus Performance-Gründen
        deaktiviert. Er findet effektiv bei späteren Aufrufen statt - und
        dafür muss in FillUpPointList der Zähler i durch *alle* möglichen
        Indizes von "Points" laufen!                                       }
      end;
    end;

  procedure FillUpPointList;
    var v0, v1, v2: TVector3;
        i         : Integer;
    begin
    For i := 0 to Pred(points.Count) do     { Alle Stützpunkte berechnen   }
      CalculateOLPoint(TVector3(points[i]));
//    SpyOut('Initialisierung:', []);
//    For i := { points.Count - 1} 0 to points.Count - 1 do
//      With TVector3(points[i]) do
//        SpyOut('%3d. Punkt: X = %10.3g, Y = %10.3g, Z = %8.6g, tag = %3d',
//               [i, X, Y, Z, tag]);
    If Not IsSpline then Exit;
    i := 0;                                 { Stützpunktliste auffüllen    }
    While i <= points.Count-3 do begin
      v0   := TVector3(points[i]);
      v1   := TVector3(points[i+1]);
      v2   := TVector3(points[i+2]);
      InsertPointsBetween(v0, v1, v2);
      i    := i + 1;
      { 29.11.03 : Versuchsweise wurde i := max(i+1, points.IndexOf(v1)-1
                   gesetzt. Dies kann aber zu unvollständig ausgefahrenen
        Kurvenstücken führen; insgesamt wird die Kurve mit i := i+1
        deutlich genauer durchfahren. Dafür kann man in der Prozedur
        InsertPointsBetween() Arbeit einsparen (siehe oben!).              }
      end;
    InsertPointsBetween(TVector3(points[points.Count - 1]),
                        TVector3(points[points.Count - 2]),
                        TVector3(points[points.Count - 3]));
//    SpyOut('Nach dem Auffüllen:', []);
//    For i := points.Count - 10 to points.Count - 1 do
//      With TVector3(points[i]) do
//        SpyOut('%3d. Punkt: X = %10.3g, Y = %10.3g, Z = %8.6g, tag = %3d',
//               [i, X, Y, Z, tag]);
    end;

  procedure Check4Jumps;
    { Wenn der Gradient (dx/dz, dy/dz) zwischen zwei Punkten P1 und P2 der
      Kurve einen zu großen Betrag hat, dann wird dort eine Unstetigkeits-
      stelle vermutet. Dann wird zwischen P1 und P2 ein ungültiger Punkt
      eingefügt, um eine Unterbrechung der Ortslinie an dieser Stelle zu
      erzwingen.                                                           }
    var i       : Integer;
        dr, dz  : Double;
        v1, v2  : TVector3;   { nur Zeiger ! }
    begin
    If points.Count >= 2 then begin
      i := 1;
      While i < points.Count do begin
        v1 := points[i-1];
        v2 := points[i  ];
//        If v1.IsValid and v2.IsValid then begin     { geändert 10.12.06 }
        If (v1.tag >= 0) or (v1.tag >= 0) then begin
          dr := Hypot(v2.X - v1.X, v2.Y - v1.Y);
          dz := Abs(v2.Z - v1.Z);
          If MaxGradient * dz < dr then begin
            points.InsertZSorted(1.1e100, 1.1e100, (v1.Z + v2.Z)/2, -2);
            Inc(i);
            end;
          end;
        Inc(i);
        end;
      end;
    end;

  begin { of RecalculatePointList }
  DraggedObj := TGParentObj(Parent.First);  { der von der Maus gezogene Punkt    }
  If DraggedObj.IsLineBound(CarrierLine) then begin  { Hier wird aktualisiert !!! }
    GeneratorPt := TGPoint(Parent.Last);   { der die Ortslinie erzeugende Punkt }
    old_MouseDir  := ObjList.MouseGoes;
    ObjList.MouseGoes := ForwardMove;
    old_MousedObj := ObjList.DraggedObj;
    ObjList.DraggedObj := DraggedObj;
    SetNewTempRelationships;

    For i := 0 to Pred(Parent.Count) do
      If TGeoObj(Parent[i]) is TGPoint then
        TPointParams(ParentInitData[i]).LoadDataFrom(Parent[i])
      else
        TGeoObj(Parent[i]).SaveState;

    CarrierLine.ResetOLCPList(points);
    FillUpPointList;
    DataValid := points.ValidPointCount > 3;
    If DataValid then
      Check4Jumps;

    For i := 0 to Pred(Parent.Count) do
      If TGeoObj(Parent[i]) is TGPoint then
        TPointParams(ParentInitData[i]).WriteDataTo(Parent[i])
      else
        TGeoObj(Parent[i]).RestoreState;

    ResetTempRelationships;
    ObjList.DraggedObj := old_MousedObj;
    ObjList.MouseGoes  := old_MouseDir;
    end;
  end; { of RecalculatePointList }


procedure TGLocLine.UpdateScreenCoords;
  var i, j,
      k, n  : Integer;
      pt    : TPoint;
      VList : TVector3List;

  procedure PointListAdd(v: TVector3);
    var s_x, s_y : Double;
    begin
    If v.IsValid then begin
      ObjList.GetFWinCoords(v.X, v.Y, s_x, s_y);
      VList.Add(TVector3.Create(s_x, s_y, v.Z, v.tag));
      end;
    end;

  begin
  IntPointLists := Nil;
  DataCanShow   := False;
  If IsSpline then begin
    i := 0;
    k := 0;    { Letzter gültiger Index von IntPointLists }
    VList := TVector3List.Create;
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
        If IsDynamic then begin
          SetLength(IntPointLists[k], VList.Count);   { Höchstens ! }
          IntPointLists[k,0].X := Round(TVector3(VList[0]).X);
          IntPointLists[k,0].Y := Round(TVector3(VList[0]).Y);
          n := 1;
          For j := 1 to Pred(VList.Count) do
            if TVector3(VList[j]).IsValid then begin
              pt.X := Round(TVector3(VList[j]).X);
              pt.Y := Round(TVector3(VList[j]).Y);
              If (pt.X <> IntPointLists[k,n-1].X) or
                 (pt.Y <> IntPointLists[k,n-1].Y) then begin
                IntPointLists[k,n].X := pt.X;
                IntPointLists[k,n].Y := pt.Y;
                n := n + 1;
                end;
              end;
          SetLength(IntPointLists[k], n);             { Genau ! }
          end
        else begin
          SetLength(IntPointLists[k], VList.Count * 3 - 2);
          MakeBezierShapingPointList(VList, IntPointLists[k]);
          end;
        DataCanShow := True;
        Inc(k);
        end;
      VList.Clear;
      end;
    VList.Free;
    end
  else
    If points.Count > 0 then begin
      k := 0;
      SetLength(IntPointLists, 1, points.Count); { Mehrdimensionale Variante! }
      For i := 0 to Pred(points.Count) do
        If TVector3(points[i]).IsValid and
           ObjList.LogWinContains(TVector3(points[i]).X,
                                  TVector3(points[i]).Y) then begin
          ObjList.GetWinCoords(TVector3(points[i]).X,
                               TVector3(points[i]).Y,
                               pt.X, pt.Y);
          IntPointLists[0, k] := pt;
          DataCanShow := True;
          Inc(k);
          end;
      SetLength(IntPointLists[0], k);
      end;
  end;


procedure TGLocLine.AutoUpdate;
  begin
  RecalculatePointList;
  UpdateScreenCoords;
  end;


procedure TGLocLine.VirtualizeCoords;
  var TL    : TGLine;
      GO    : TGeoObj;
      log_x,
      log_y : Double;
      n1, n2,
      i     : Integer;
  begin
  If IsDynamic then
    If (Parent.Count = 0) or
       (Not TGPoint(Parent[0]).IsLineBound(TL)) then      { Vorsichtshalber ! }
      FOLStatus := FOLStatus - ols_IsDynamic
    else
  else
    If (Parent.Count >= 2) and (TGeoObj(Parent[0]) is TGPoint) and
       (TGPoint(Parent[0]).IsLineBound(TL)) then
      FOLStatus := FOLStatus + ols_IsDynamic;

  If IsDynamic then
    For i := 0 to Pred(Parent.Count) do             { ParentInitData besorgen }
      If TGeoObj(Parent[i]) is TGPoint then
        TPointParams(ParentInitData[i]).LoadDataFrom(Parent[i]);

  For i := 0 to Pred(Points.Count) do            { Points-Liste aktualisieren }
    If TVector3(Points[i]).IsValid then begin
      ObjList.GetLogCoords(SafeRound(TVector3(Points[i]).X),
                           SafeRound(TVector3(Points[i]).Y),
                           log_x, log_y);
      TVector3(Points[i]).Assign(log_x, log_y, 0);
      end;


  If IsDynamic then
    If Parent.Count = 2 then begin               { Elternliste vervollständigen }
      n1 := ObjList.IndexOf(Parent[0]);
      n2 := ObjList.IndexOf(Parent[1]);
      For i := Pred(n2) downto Succ(n1) do begin
        GO := ObjList.Items[i];
        If GO.IsAncestorOf(Parent.Last) and
           TGeoObj(Parent.First).IsAncestorOf(GO) then begin
          Parent.Insert(1, GO);  { erzwingt korrekte Position des Elternobjekts }
          BecomesChildOf(GO);    { macht entsprechenden Children-Eintrag in GO  }
          If GO is TGPoint then
            ParentInitData.Insert(1, TPointParams.CreateWithDataFrom(GO))
          else
            ParentInitData.Insert(1, TPointParams.Create);
          end;
        end;
      end
    else
      // Dann ist die Elternliste schon komplett !
  else begin             // Für alte statische 1.x-Spuren:
    Parent.Clear;
{
    i := 0;
    While Parent.Count > i do begin     // Elternliste überprüfen
      n1 := ObjList.IndexOf(Parent[i]);
      If n1 >= 0 then
        i := i + 1
      else
        Parent.Delete(i);
      end;
}
    UpdateScreenCoords;                 // Liste der Bildschirmpunkte füllen.
    end;
  SetNameRefPtCoords;
  end;

function TGLocLine.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  If (ClassType = TGLocLine) and (nr = 1) then
    Result := Parent.Last
  else
    Result := Nil;
  end;

function TGLocLine.GetTangentIn(bx, by: Double; var tanCoeff: TVector3): Boolean;
  { Liefert in tanCoeff die Koeffizienten der Gleichung ax + by + c = 0
    der Tangenten an die Ortslinien-Kurve in demjenigen Kurvenpunkt,
    der dem übergebenen Punkt B(bx, by) am nächsten liegt.           }
  var dx, dy, dr : Double;
      n,  nv, nh : Integer;
  begin
  Result := False;
  n := points.GetPtIndexNextToXY(bx, by);
  If TVector3(points[n]).IsValid then begin
    If (n > 0) and (TVector3(points[n-1]).IsValid) then
      nv := n-1
    else
      nv := n;
    If (n < Pred(points.Count)) and (TVector3(points[n+1]).IsValid) then
      nh := n + 1
    else
      nh := n;
    If nv <> nh then begin
      dx := TVector3(points[nh]).X - TVector3(points[nv]).X;
      dy := TVector3(points[nh]).Y - TVector3(points[nv]).Y;
      dr := Hypot(dx, dy);
      If dr > epsilon then begin
        tanCoeff.X :=  dy/dr;
        tanCoeff.Y := -dx/dr;
        tanCoeff.Z := -tanCoeff.X * bx - tanCoeff.Y * by;
        Result     := True;
        end;
      end;
    end;  
  end;

procedure TGLocLine.SetNewName(NewName: WideString);
  begin
  SetNameRefPtCoords;
  Inherited SetNewName(NewName);
  end;

procedure TGLocLine.SetNameRefPtCoords;
  var i : Integer;
  begin
  X := 0;
  Y := 0;
  If points.Count > 0 then begin
    For i := 0 to Pred(points.Count) do
      If ObjList.LogWinContains(TVector3(points[i]).X,
                                TVector3(points[i]).Y) then begin
        X := X + TVector3(points[i]).X;
        Y := Y + TVector3(points[i]).Y;
        end;
    X := X / points.Count;
    Y := Y / points.Count;
    end;
  end;

procedure TGLocLine.SetNewNameParamsIn(TextObj: TGTextObj);
  begin
  SetNameRefPtCoords;
  Inherited SetNewNameParamsIn(TextObj);
  end;

procedure TGLocLine.UpdateNameCoordsIn(TextObj: TGTextObj);
  begin
  SetNameRefPtCoords;            { Neue Bezugspunktkoordinaten setzen }
  Inherited UpdateNameCoordsIn(TextObj);
  end;

procedure TGLocLine.DrawIt;
  var i, k : Integer;
  begin
  If IsVisible then with ObjList.TargetCanvas do begin
    AdjustGraphTools(True);
    Brush.Style := bsClear; // MyBrushStyle;
    If IsReallySpline then begin
      If IsDynamic then
        For i := 0 to High(IntPointLists) do
          ObjList.TargetCanvas.Polyline(IntPointLists[i])    { Streckenzug malen }
      else
        For i := 0 to High(IntPointLists) do
          ObjList.TargetCanvas.PolyBezier(IntPointLists[i]); { Bezierkurve malen }
      If ShowLocLinePts and (High(IntPointLists) >= 0) then
        For k := 0 to High(IntPointLists) do
          For i := 0 to High(IntPointLists[k]) do   { Punkte ausgeben }
            ObjList.TargetCanvas.Ellipse(IntPointLists[k, i].X - Pred(PointSize),
                                         IntPointLists[k, i].Y - Pred(PointSize),
                                         IntPointLists[k, i].X + PointSize,
                                         IntPointLists[k, i].Y + PointSize);

      end
    else
      If High(IntPointLists) >= 0 then
        For i := 0 to High(IntPointLists[0]) do   { Punkte ausgeben }
          ObjList.TargetCanvas.Ellipse(IntPointLists[0, i].X - Pred(PointSize),
                                       IntPointLists[0, i].Y - Pred(PointSize),
                                       IntPointLists[0, i].X + PointSize,
                                       IntPointLists[0, i].Y + PointSize);
    end;
  end;

procedure TGLocLine.HideIt;
  var i : Integer;
  begin
  If IsVisible then with ObjList.TargetCanvas do begin
    AdjustGraphTools(False);
    Brush.Color := MyColour;
    Brush.Style := MyBrushStyle;
    If IsReallySpline then
      If IsDynamic then
        For i := 0 to High(IntPointLists) do
          ObjList.TargetCanvas.Polyline(IntPointLists[i])    { Streckenzug malen }
      else
        For i := 0 to High(IntPointLists) do
          ObjList.TargetCanvas.PolyBezier(IntPointLists[i])  { Bezierkurve malen }
    else
      If High(IntPointLists) >= 0 then begin
        For i := 0 to High(IntPointLists[0]) do   { Punkte löschen }
          ObjList.TargetCanvas.Ellipse(IntPointLists[0, i].X - Pred(PointSize),
                            IntPointLists[0, i].Y - Pred(PointSize),
                            IntPointLists[0, i].X + PointSize,
                            IntPointLists[0, i].Y + PointSize);
        end;
    end;
  end;

function TGLocLine.Check4StandardLine(var SLTyp: Integer): Boolean;
  var pt, dir : TVector3;
      pts     : TCoeff6;
      radius,
      quality : Double;
  begin
  If IsDynamic then begin
    SLTyp := 0;
    UpdateParams;
    pt := TVector3.Create(0, 0, 0);
    dir := TVector3.Create(0, 0, 0);
    try
      If BestLineApprox(points, quality, pt, dir) and
         (quality > LocSL_LineLimit) then
        SLTyp := ols_IsStraightLine
      else
      if BestCircleApprox(points, quality, pt, radius) and
         (quality > LocSL_CircleLimit) then
        SLTyp := ols_IsCircle
      else
      if BestConicApprox(points, quality, pts) and
         (quality > LocSL_ConicLimit) then
        SLTyp := ols_IsConic;
      Result := SLTyp > 0;
    finally
      dir.Free;
      pt.Free;
    end;
    end
  else
    Result := False;
  end;

function TGLocLine.SLChildrenCount: Integer;
  var SL : TGLine;
  begin
  SL := GetStandardLineChild;
  If SL = Nil then
    Result := -1
  else
    Result := SL.Children.Count;
  end;

procedure TGLocLine.Invalidate;
  var p : TGPoint;
  begin
  p := TGPoint(Parent.Last);
  If p <> Nil then begin
    Stops2BeChildOf(p);
    Parent.Add(p);    { Elter in Parent.List merken ! }
    end;
  If IsDynamic then
    Points.Clear;
  Inherited Invalidate;
  end;

procedure TGLocLine.Revalidate;
  var p  : TGPoint;
  begin
  p := TGPoint(Parent.Last);
  Parent.Remove(p);      { Elter zunächst aus der Parent-Liste entfernen, }
  BecomesChildOf(p);     { damit BecomesChildOf(..) korrekt funktioniert. }
  Inherited Revalidate;  { Dies ruft auch UpdateParams auf und füllt      }
  end;                   {   damit die Points-Liste neu!                  }

procedure TGLocLine.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  var TL : TGLine;

  function DynamicEquivalentOLExists : Boolean;
    var CLL : TGLocLine; { "C"oncurrent "L"ocus "L"ine }
        i : Integer;
    begin
    Result := False;
    For i := 5 to ObjList.LastValidObjIndex do
      If (TGeoObj(ObjList[i]).ClassType = TGLocLine) then begin
        CLL := TGLocLine(ObjList[i]);
        If (CLL <> Self) and CLL.IsDynamic and
           (CLL.Parent.Count = Parent.Count) and
           (CLL.Parent.First = Parent.First) and
           (CLL.Parent.Last  = Parent.Last) then begin
          Result := True;
          Exit;
          end;
        end;
    end;

  begin
  menu.Items.Clear;    { "Free"d auch die einzelnen Items ! }
  AddPopupMenuItemTo(menu, cme_hide, CME_PopupClick, cmd_ToggleVis);
  AddPopupMenuItemTo(menu, cme_name, CME_PopupClick, cmd_NameObj);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_col, CME_PopupClick, cmd_EditColour);
  If MyLineWidth > 1 then
    AddPopupMenuItemTo(menu, cme_leanline, CME_PopupClick, cmd_EditLocLineStyle)
  else
    AddPopupMenuItemTo(menu, cme_fatline, CME_PopupClick, cmd_EditLocLineStyle);
  If (Parent.Count > 0) then begin     // Nicht für alte 1.x - Spuren !!!
    If IsSpline then
      AddPopupMenuItemTo(menu, cme_locpoints, CME_PopupClick, cmd_EditLocLineCurve)
    else
      AddPopupMenuItemTo(menu, cme_loccurve, CME_PopupClick, cmd_EditLocLineCurve);
    If TGPoint(Parent[0]).IsLineBound(TL) and
       Not DynamicEquivalentOLExists then begin
      AddPopupMenuItemTo(menu, '-', Nil, 0);
      AddPopupMenuItemTo(menu, cme_locdyna, CME_PopupClick, cmd_EditLocLineDyna,
                         IsDynamic);
      end;
    If IsDynamic then begin
//    AddPopupMenuItemTo(menu, cme_locauto, CME_PopupClick, cmd_EditLocLineAuto,
//                       IsAutomatic);
      AddPopupMenuItemTo(menu, cme_locstnd, CME_PopupClick, cmd_EditLocLineStnd,
                         IsStandardLine);
      end;
    end;
  end;

function TGLocLine.GetInfo: String;
  var n : Integer;
  begin
  If IsDynamic then begin
    Result := MyObjTxt[31];
    InsertNameOf(Self, Result);
    InsertNameOf(TGeoObj(Parent.Last), Result);
    InsertNameOf(TGeoObj(Parent.First), Result);
    end
  else
    if Parent.Count > 0 then begin
      n := ObjList.IndexOf(Parent.Last);
      If n >= 0 then begin
        Result := MyObjTxt[34];
        InsertNameOf(TGeoObj(Parent.Last), Result);
        end
      else begin
        Result := MyObjTxt[80];
        Parent.Remove(Parent.Last);
        end;
      end
    else
      Result := MyObjTxt[80];
  end;

destructor TGLocLine.Destroy;
  begin
  HideIt;
  FStatus := FStatus and not gs_IsVisible;
  IntPointLists := Nil;
  ParentInitData.Free;
  Inherited Destroy;
  end;



{-------------------------------------------}
{ TGMappedLocLine's Methods Implementation  }
{-------------------------------------------}

constructor TGMappedLocLine.Create(iObjList: TGeoObjListe; iPLL: TGLocLine;
                                   iMO: TGTransformation);
  begin
  Inherited Create(iObjList, Nil);
  BecomesChildOf(iPLL);
  BecomesChildOf(iMO);
  FOLStatus := 0;
  IsSpline  := iPLL.IsSpline;
  MyColour  := iPLL.MyColour;
  MyLineWidth := iPLL.MyLineWidth;
  UpdateParams;
  end;

function TGMappedLocLine.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var PLL : TGLocLine;
      MO  : TGTransformation;
      p1, p2 : TFloatPoint;
  begin
  Result := False;
  PLL := TGeoObj(Parent[0]) as TGLocLine;
  MO := TGeoObj(Parent[1]) as TGTransformation;
  IF PLL.GetCoordsFromParam(param, px, py) then begin
    p1.x := px;
    p1.y := py;
    If MO.GetMappedPoint(p1, p2) then begin
      px := p2.x;
      py := p2.y;
      Result := True;
      end;
    end;
  end;

function TGMappedLocLine.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  var PLL : TGLocLine;
      MO  : TGTransformation;
      p1, p2 : TFloatPoint;
  begin
  PLL := TGeoObj(Parent[0]) as TGLocLine;
  MO := TGeoObj(Parent[1]) as TGTransformation;
  p1.x := px;
  p1.y := py;
  Result := MO.GetInvMapPoint(p1, p2) and
            PLL.GetParamFromCoords(p2.x, p2.y, param);
  end;

procedure TGMappedLocLine.UpdateParams;
  var PLL : TGLocLine;
      MO  : TGTransformation;
      i   : Integer;
      src : TVector3;
      up,
      bp  : TFloatPoint;
  begin
  PLL := TGeoObj(Parent[0]) as TGLocLine;
  MO  := TGeoObj(Parent[1]) as TGTransformation;
  If PLL.DataValid and MO.DataValid then begin
    DataValid := True;
    points.Clear;
    For i := 0 to Pred(PLL.points.Count) do begin
      src  := PLL.Points[i];
      up.x := src.x;
      up.y := src.y;
      MO.GetMappedPoint(up, bp);
      points.InsertZSorted(bp.x, bp.y, src.z, src.tag);
      end;
    UpdateScreenCoords;
    end
  else
    DataValid := False;
  end;

function TGMappedLocLine.GetInfo: String;
  var s1, s2 : String;
  begin
  s1 := MyObjTxt[58];
  InsertNameOf(Self, s1);
  InsertNameOf(TGeoObj(Parent[0]), s1);
  s2 := TGTransformation(Parent[1]).GetLinkableInfo;
  Result := s1 + s2;
  end;



{-------------------------------------------}
{ TGEnvelopLine's Methods Implementation    }
{-------------------------------------------}

constructor TGEnvelopLine.Create(iObjList : TGeoObjListe; GeneratorLn: TGStraightLine);
  begin
  Inherited Create(iObjList, Nil);     // zunächst unsichtbar erzeugen !
  If GeneratorLn <> Nil then
    FMyColour  := GeneratorLn.MyColour
  else
    FMyColour := clRed;
  MyPenStyle := psSolid;
  If Odd(DefLocLineStyle) then
    MyLineWidth := 3
  else
    MyLineWidth := 1;
  F_CCTP := True;
  If GeneratorLn <> Nil then begin
    BecomesChildOf (GeneratorLn);
    ParentInitData := TPPInitDataList.Create;
    ParentInitData.Insert(0, TPointParams.CreateWithDataFrom(GeneratorLn));
    end;
  LastDist  := 1.0e300;
  if Not Assigned(points) then
    points  := TVector3List.Create;
  IsDynamic := False;
  FOLStatus := -1;    // Ermöglicht die punktweise Aufzeichnung der Ortslinie !
  FStatus   := FStatus or gs_ShowsAlways;   // erst hier sichtbar schalten !
  end;


constructor TGEnvelopLine.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var domlines  : IXMLNode;
      ActParent : TGeoObj;
      i         : Integer;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  F_CCTP := False;

  If (ClassType = TGEnvelopLine) and Not Assigned(ParentInitData) then begin
    ParentInitData := TPPInitDataList.Create;
    For i := 0 to Pred(Parent.Count) do begin
      ActParent := iObjList.GetObj(Integer(Parent.Items[i]));
      If ActParent is TGPoint then
        ParentInitData.Add(TPointParams.CreateWithDataFrom(ActParent))
      else
        ParentInitData.Add(TPointParams.Create);
      end;
    end;

  domlines := DE.childNodes.findNode('lines', '');
  if domlines <> Nil then
    lines := TVector3List.CreateFromString(domlines.nodeValue);
  end;


procedure TGEnvelopLine.AfterLoading(FromXML: Boolean);
  begin
  Inherited AfterLoading(FromXML);
  If Not Assigned(lines) then
    lines := TVector3List.Create;
  end;


function TGEnvelopLine.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var DOMLines : IXMLNode;
      s : String;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  DOMLines := DOMDoc.createNode('lines');
  s := lines.GetContentsString;
  DOMLines.nodeValue := s;
  Result.childNodes.add(DOMLines);
  end;


function TGEnvelopLine.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('Env');
  end;

function TGEnvelopLine.GetShowLines: Boolean;
  begin
  Result := (FOLStatus and env_ShowLines) > 0;
  end;

procedure TGEnvelopLine.SetShowLines(nv: Boolean);
  begin
  if nv then
    FOLStatus := FOLStatus or env_ShowLines
  else
    FOLStatus := FOLStatus and (Not env_ShowLines);
  end;

function TGEnvelopLine.GetShowCurve: Boolean;
  begin
  Result := (FOLStatus and env_ShowCurve) > 0;
  end;

procedure TGEnvelopLine.SetShowCurve(nv: Boolean);
  begin
  if nv then
    FOLStatus := FOLStatus or env_ShowCurve
  else
    FOLStatus := FOLStatus and (Not env_ShowCurve);
  end;


procedure TGEnvelopLine.UpdateParams;
  var DraggedObj  : TGParentObj;    { dragged object  }
      GeneratorLn : TGStraightLine; { die die Einhüllende erzeugende Gerade }
      old_DragObj : TGeoObj;        { Puffer für altes gezogenes Objekt }
      PtParams    : TPointParams;
      g0, g1, g2,
      epv         : TVector3;
      i, j        : Integer;

  procedure Simulate(v : TVector3);

    function getGenLineEq(param: Double; eq: TVector3): Boolean;
      var i : Integer;
      begin
      Result := False;
      If DraggedObj.SetLinePosition(param) then begin
        For i := 1 to Pred(Parent.Count) do
          TGeoObj(Parent[i]).UpdateParams;
        If GeneratorLn.DataValid then begin
          GeneratorLn.GetDataVector(eq);
          Result := True;
          end;
        end;
      end;

    var s0, s1, s2, p1, p2 : Boolean;
        u1x, u1y, u2x, u2y : Double;
    begin  // of Simulate()
    s0 := getGenLineEq(v.z - DistEpsilon, g0);
    s1 := getGenLineEq(v.Z, g1);
    s2 := getGenLineEq(v.z + DistEpsilon, g2);
    if s0 and s1 then
      MathLib.IntersectLines(g0, g1, u1x, u1y, p1);
    if s1 and s2 then
      MathLib.IntersectLines(g1, g2, u2x, u2y, p2);
    if p1 and p2 then begin
      v.X := (u1x + u2x) * 0.5;
      v.Y := (u1y + u2y) * 0.5;
      end
    else
      if p1 then begin
        v.X := u1x;
        v.Y := u1y;
        end
      else
        if p2 then begin
          v.X := u2x;
          v.Y := u2y;
          end;
    if p1 or p2 then
      v.tag := ObjList.LogWinKnows(v.X, v.Y)
    else
      v.IsValid := False;
    end; // of simulate()

  begin { of UpdateParams }
  If ObjList.IsLoading then Exit;
  If (ObjList.UpdatingLocLine <> nil) then   { Andere Ortslinie wird ge-updatet }
    Exit;

  ObjList.UpdatingLocLine := Self;
  GeneratorLn := TGStraightLine(Parent.Last);

  { Zu Beginn der Aufzeichnung:        }
  If OLStatus = -1 then begin
    if Not Assigned(lines) then begin
      lines := TVector3List.Create;
      end;
    With ObjList.DragList do begin        { Eltern suchen }
      i := Pred(Count);
      While (i >= 0) and
            (Items[i] <> GeneratorLn) do Dec(i);
      Dec(i);
      While (i >= 0) do begin
        If TGeoObj(Items[i]).IsAncestorOf(GeneratorLn) then begin
          Parent.Insert(0, Items[i]);  { Dies führt automatisch zur logisch
                           richtigen Reihenfolge, weil die Objekte schon so
                           geordnet in Drawing.DragList stehen !!! }
          If TGeoObj(Items[i]) is TGPoint then
            PtParams := TPointParams.CreateWithDataFrom(Items[i])
          else
            PtParams := TPointParams.Create;
          ParentInitData.Insert(0, PtParams);
          end;
        Dec(i);
        end;
      DataValid  := True;
      FOLStatus  := 0; // zeigt während der Aufzeichnung die Geradenschar an!
      end;
    end;

  DraggedObj  := TGParentObj(Parent.First); { das von der Maus gezogene Objekt }
  old_DragObj := ObjList.dragged_by_mouse;
  ObjList.dragged_by_mouse := DraggedObj;

  { Während der laufenden Aufzeichnung :    }
  If (OLStatus <= 0) then
    If (OLineMode = 4) and (DraggedObj <> Nil) and
       (GeneratorLn <> Nil) and GeneratorLn.DataValid then begin
      epv := TVector3.Create(0, 0, DraggedObj.BoundParam);
      g0 := TVector3.Create(0, 0, 0);
      g1 := TVector3.Create(0, 0, 0);
      g2 := TVector3.Create(0, 0, 0);
      Simulate(epv);
      if epv.IsValid then begin
        j := points.InsertZSortedWithXYDist(OLMinDist/act_pixelPerXcm,
                                            epv.x, epv.y, epv.z);
        if j >= 0 then
          lines.Insert(j, TVector3.CreateCopyOf(g1));
        end;
      g2.Free;
      g1.Free;
      g0.Free;
      epv.Free;
      end
    else

  { Nach der Aufzeichnung der Ortslinie:   }
  else
    If IsDynamic then   { Alles neu bauen bei "Dynamischen + automatischen OL" }
      RecalculatePointList;

  SetNameRefPtCoords;
  UpdateScreenCoords;
  ObjList.UpdatingLocLine  := Nil;         { Vorigen Zustand wieder herstellen }
  ObjList.dragged_by_mouse := old_DragObj;
  end; { of UpdateParams }


procedure TGEnvelopLine.RecalculatePointList;
  var DraggedObj    : TGParentObj;    { dragged object  }
      CarrierLine   : TGLine;         { Trägerlinie     }
      GeneratorLn   : TGStraightLine; { die die Einhüllende erzeugende Gerade }
      old_MousedObj : TGeoObj;
      g0, g1, g2    : TVector3;
      old_MouseDir  : TDirection;
      i             : Integer;

  procedure Simulate(v : TVector3);
    { v.tag erhält das Ergebnis der Sichtbarkeitsprüfung:
        1   wenn v einen Punkt im sichtbaren Fenster beschreibt;
        0   wenn v einen unsichtbaren Punkt dicht beim Rand beschreibt;
       -1   wenn v einen unsichtbaren Punkt weit entfernt vom Rand angibt;
       -2   wenn v einen ungültigen Punkt beschreibt                    }

    function getGenLineEq(param: Double; eq: TVector3): Boolean;
      var i : Integer;
      begin
      Result := False;
      If DraggedObj.SetLinePosition(param) then begin
        For i := 1 to Pred(Parent.Count) do
          TGeoObj(Parent[i]).UpdateParams;
        If GeneratorLn.DataValid then begin
          GeneratorLn.GetDataVector(eq);
          Result := True;
          end;
        end;
      end;

    var s0, s1, s2, p1, p2 : Boolean;
        u1x, u1y, u2x, u2y : Double;
    begin  // of Simulate()
    s0 := getGenLineEq(v.z - DistEpsilon, g0);
    s1 := getGenLineEq(v.Z, g1);
    s2 := getGenLineEq(v.z + DistEpsilon, g2);
    if s0 and s1 then
      MathLib.IntersectLines(g0, g1, u1x, u1y, p1);
    if s1 and s2 then
      MathLib.IntersectLines(g1, g2, u2x, u2y, p2);
    if p1 and p2 then begin
      v.X := (u1x + u2x) * 0.5;
      v.Y := (u1y + u2y) * 0.5;
      end
    else
      if p1 then begin
        v.X := u1x;
        v.Y := u1y;
        end
      else
        if p2 then begin
          v.X := u2x;
          v.Y := u2y;
          end;
    if p1 or p2 then
      v.tag := ObjList.LogWinKnows(v.X, v.Y)
    else
      v.IsValid := False;
    end; // of Simulate()


  procedure InsertPointsBetween(v0, v1, v2: TVector3);
    { Ergänzt die Punktliste rekursiv um weitere Punkte, so dass die
      Richtungsänderung aufeinanderfolgender Punktpaare nicht zu groß
      ist. Ein Klon dieser Routine wird in TGConic.FillList() verwendet! }
    var vm, vn : TVector3;
        dist   : Double;
    begin
    dist := Hypot(v1.X-v0.X, v1.Y-v0.Y) + Hypot(v2.X - v1.X, v2.Y - v1.Y);
    If (dist > ObjList.PixelDist * 5) and
       (Abs(v2.Z-v0.Z) > ParamEpsilon) and
       TooMuchBending(v0, v1, v2) then begin
      vm := TVector3.Create(0, 0, (v0.Z + v1.Z)/2);
      Simulate(vm);
      points.InsertZSorted(vm);
      // lines.Insert(n, TVector3.CreateCopyOf(g1));

      vn := TVector3.Create(0, 0, (v1.Z + v2.Z)/2);
      Simulate(vn);
      points.InsertZSorted(vn);
      // lines.Insert(n, TVector3.CreateCopyOf(g1));
      { 29.11.03 : Auch wenn der neue Punkt nicht für weitere rekursive
                   Aufrufe verwendet wird, muss er eingefügt werden!
        Andernfalls bleibt der Algorithmus hängen! (Grund noch unklar,
        aber Effekt zuverlässig reproduzierbar bei Schwebungs-Kurven)      }

      If v0.IsValid and vm.IsValid and v1.IsValid and
         ((v0.tag > 0) or (vm.tag > 0) or (v1.tag > 0)) then
        InsertPointsBetween(v0, vm, v1);

//    If (v1.tag > 0) or (vn.tag > 0) or (v2.tag > 0) then
//        InsertPointsBetween(v1, vn, v2);

      { 29.11.03 : Dieser naheliegende rekursive Aufruf in der 2. Hälfte
                   des aktuellen Intervalls wurde aus Performance-Gründen
        deaktiviert. Er findet effektiv bei späteren Aufrufen statt - und
        dafür muss in FillUpPointList der Zähler i durch *alle* möglichen
        Indizes von "Points" laufen!                                       }
      end;
    end;

  procedure FillUpPointList;
    var v0, v1, v2: TVector3;
        i         : Integer;
    begin
    For i := 0 to Pred(points.Count) do begin { Alle Stützpunkte berechnen }
      Simulate(TVector3(points[i]));
      lines.Add(TVector3.CreateCopyOf(g1));
//    SpyOut('Initialisierung:', []);
//    For i := { points.Count - 1} 0 to points.Count - 1 do
//      With TVector3(points[i]) do
//        SpyOut('%3d. Punkt: X = %10.3g, Y = %10.3g, Z = %8.6g, tag = %3d',
//               [i, X, Y, Z, tag]);
      end;
    If Not IsSpline then Exit;
    i := 0;                                 { Stützpunktliste auffüllen    }
    While i <= points.Count-3 do begin
      v0   := TVector3(points[i]);
      v1   := TVector3(points[i+1]);
      v2   := TVector3(points[i+2]);
      InsertPointsBetween(v0, v1, v2);
      i    := i + 1;
      { 29.11.03 : Versuchsweise wurde i := max(i+1, points.IndexOf(v1)-1
                   gesetzt. Dies kann aber zu unvollständig ausgefahrenen
        Kurvenstücken führen; insgesamt wird die Kurve mit i := i+1
        deutlich genauer durchfahren. Dafür kann man in der Prozedur
        InsertPointsBetween() Arbeit einsparen (siehe oben!).              }
      end;
    InsertPointsBetween(TVector3(points[points.Count - 1]),
                        TVector3(points[points.Count - 2]),
                        TVector3(points[points.Count - 3]));
//    SpyOut('Nach dem Auffüllen:', []);
//    For i := points.Count - 10 to points.Count - 1 do
//      With TVector3(points[i]) do
//        SpyOut('%3d. Punkt: X = %10.3g, Y = %10.3g, Z = %8.6g, tag = %3d',
//               [i, X, Y, Z, tag]);
    end;

  procedure Check4Jumps;
    { Wenn der Gradient (dx/dz, dy/dz) zwischen zwei Punkten P1 und P2 der
      Kurve einen zu großen Betrag hat, dann wird dort eine Unstetigkeits-
      stelle vermutet. Dann wird zwischen P1 und P2 ein ungültiger Punkt
      eingefügt, um eine Unterbrechung der Ortslinie an dieser Stelle zu
      erzwingen.                                                           }
    var i       : Integer;
        dr, dz  : Double;
        v1, v2  : TVector3;   { nur Zeiger ! }
    begin
    If points.Count >= 2 then begin
      i := 1;
      While i < points.Count do begin
        v1 := points[i-1];
        v2 := points[i  ];
        If (v1.tag >= 0) or (v1.tag >= 0) then begin
          dr := Hypot(v2.X - v1.X, v2.Y - v1.Y);
          dz := Abs(v2.Z - v1.Z);
          If MaxGradient * dz < dr then begin
            points.InsertZSorted(1.1e100, 1.1e100, (v1.Z + v2.Z)/2, -2);
            Inc(i);
            end;
          end;
        Inc(i);
        end;
      end;
    end;

  begin { of RecalculatePointList }
  DraggedObj := TGParentObj(Parent.First);    { der von der Maus gezogene Punkt    }
  If DraggedObj.IsLineBound(CarrierLine) then begin   { Hier wird aktualisiert !!! }
    GeneratorLn := TGStraightLine(Parent.Last); { Erzeuger-Gerade der Einhüllenden }
    old_MouseDir  := ObjList.MouseGoes;
    ObjList.MouseGoes := ForwardMove;
    old_MousedObj := ObjList.DraggedObj;
    ObjList.DraggedObj := DraggedObj;
    SetNewTempRelationships;

    For i := 0 to Pred(Parent.Count) do
      If TGeoObj(Parent[i]) is TGPoint then
        TPointParams(ParentInitData[i]).LoadDataFrom(Parent[i])
      else
        TGeoObj(Parent[i]).SaveState;

    lines.Clear;
    g0 := TVector3.Create(0, 0, 0);
    g1 := TVector3.Create(0, 0, 0);
    g2 := TVector3.Create(0, 0, 0);
    CarrierLine.ResetOLCPList(points);
    FillUpPointList;
    DataValid := points.ValidPointCount > 3;
    If DataValid then
      Check4Jumps;
    g2.Free;
    g1.Free;
    g0.Free;

    For i := 0 to Pred(Parent.Count) do
      If TGeoObj(Parent[i]) is TGPoint then
        TPointParams(ParentInitData[i]).WriteDataTo(Parent[i])
      else
        TGeoObj(Parent[i]).RestoreState;

    ResetTempRelationships;
    ObjList.DraggedObj := old_MousedObj;
    ObjList.MouseGoes  := old_MouseDir;
    end;
  end; { of RecalculatePointList }


procedure TGEnvelopLine.DrawIt;
  var i,
      ix1, iy1, ix2, iy2 : Integer;
      x1,  y1,  x2,  y2  : Double;
      ok : Boolean;
  begin
  If IsVisible then with ObjList.TargetCanvas do begin
    if (OLStatus <= 0) or ShowLines then begin
      Pen.Width := 1;
      Pen.Color := LightCol(MyColour);
      for i := 0 to lines.Count - 1 do begin
        IntersectRectangleWithLine(
            ObjList.xMin, ObjList.xMax, ObjList.yMin, ObjList.yMax,
            lines.Items[i], x1, y1, x2, y2, ok);
        if ok then begin
          ObjList.GetWinCoords(x1, y1, ix1, iy1);
          ObjList.GetWinCoords(x2, y2, ix2, iy2);
          MoveTo(ix1, iy1);
          LineTo(ix2, iy2);
          end;
        end;
      end;
    if ShowCurve then
      Inherited DrawIt;           // Zeichnet die eigentliche Einhüllende !
    TGeoObj(Parent.Last).Redraw;  // Verbessert die Sichtbarkeit !
    end;
  end;

procedure TGEnvelopLine.HideIt;
  begin
  Inherited HideIt;
  end;


procedure TGEnvelopLine.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  menu.Items.Clear;    { "Free"d auch die einzelnen Items ! }
  AddPopupMenuItemTo(menu, cme_hide, CME_PopupClick, cmd_ToggleVis);
  AddPopupMenuItemTo(menu, cme_name, CME_PopupClick, cmd_NameObj);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_col, CME_PopupClick, cmd_EditColour);
  If ShowCurve then
    if MyLineWidth > 1 then
      AddPopupMenuItemTo(menu, cme_leanline, CME_PopupClick, cmd_EditLocLineStyle)
    else
      AddPopupMenuItemTo(menu, cme_fatline, CME_PopupClick, cmd_EditLocLineStyle);
  If ShowCurve and ShowLines then begin
    If IsSpline then
      AddPopupMenuItemTo(menu, cme_locpoints, CME_PopupClick, cmd_EditLocLineCurve)
    else
      AddPopupMenuItemTo(menu, cme_loccurve, CME_PopupClick, cmd_EditLocLineCurve);
    AddPopupMenuItemTo(menu, cme_envhidelines, CME_PopupClick, cmd_EditEnvLines);
    AddPopupMenuItemTo(menu, cme_envhidecurve, CME_PopupClick, cmd_EditEnvcurve);
    end
  else
  if ShowCurve then begin  // ShowCurve is TRUE and ShowLines is TRUE
    If IsSpline then
      AddPopupMenuItemTo(menu, cme_locpoints, CME_PopupClick, cmd_EditLocLineCurve)
    else
      AddPopupMenuItemTo(menu, cme_loccurve, CME_PopupClick, cmd_EditLocLineCurve);
    AddPopupMenuItemTo(menu, cme_envshowlines, CME_PopupClick, cmd_EditEnvLines);
    end
  else begin  // Showlines is TRUE and ShowCurve is FALSE
    AddPopupMenuItemTo(menu, cme_envshowcurve, CME_PopupClick, cmd_EditEnvCurve);
    end;
  end;


function TGEnvelopLine.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var pv          : TVector3;
      DraggedObj  : TGParentObj;
      GeneratorLn : TGLine;
      odbm        : TGeoObj;   { "O"ld "D"ragged "B"y "M"ouse }
      i           : Integer;

  procedure Simulate(v : TVector3);

    function getGenLineEq(param: Double; eq: TVector3): Boolean;
      var i : Integer;
      begin
      Result := False;
      If DraggedObj.SetLinePosition(param) then begin
        For i := 1 to Pred(Parent.Count) do
          TGeoObj(Parent[i]).UpdateParams;
        If GeneratorLn.DataValid then begin
          GeneratorLn.GetDataVector(eq);
          Result := True;
          end;
        end;
      end;

    var s0, s1, s2, p1, p2 : Boolean;
        u1x, u1y, u2x, u2y : Double;
        g0, g1, g2         : TVector3;
    begin  // of Simulate()
    g0 := TVector3.Create(0, 0, 0);
    g1 := TVector3.Create(0, 0, 0);
    g2 := TVector3.Create(0, 0, 0);
    try
      s0 := getGenLineEq(v.z - DistEpsilon, g0);
      s1 := getGenLineEq(v.Z, g1);
      s2 := getGenLineEq(v.z + DistEpsilon, g2);
      if s0 and s1 then
        MathLib.IntersectLines(g0, g1, u1x, u1y, p1);
      if s1 and s2 then
        MathLib.IntersectLines(g1, g2, u2x, u2y, p2);
      if p1 and p2 then begin
        v.X := (u1x + u2x) * 0.5;
        v.Y := (u1y + u2y) * 0.5;
        end
      else
        if p1 then begin
          v.X := u1x;
          v.Y := u1y;
          end
        else
          if p2 then begin
            v.X := u2x;
            v.Y := u2y;
            end;
      if p1 or p2 then
        v.tag := ObjList.LogWinKnows(v.X, v.Y)
      else
        v.IsValid := False;
    finally
      g0.Free;
      g1.Free;
      g2.Free;
    end; // of try
    end; // of simulate()

  begin
  Result := False;
  If ObjList.IsLoading then Exit;
  If Parent.IndexOf(ObjList.DraggedObj) >= 0 then begin
    odbm := ObjList.DraggedObj;
    ObjList.DraggedObj := Nil;
    end
  else
    odbm := Nil;

  DraggedObj  := TGParentObj(parent.First);
  GeneratorLn := TGStraightLine(parent.Last);
  pv := TVector3.Create(0, 0, param);
  try
    SetNewTempRelationships;
    For i := 0 to Pred(Parent.Count) do
      If TGeoObj(Parent[i]) is TGPoint then
        TPointParams(ParentInitData[i]).WriteDataTo(Parent[i])
      else
        TGeoObj(Parent[i]).SaveState;

    Simulate(pv);

    For i := 0 to Pred(Parent.Count) do
      If TGeoObj(Parent[i]) is TGPoint then
        TPointParams(ParentInitData[i]).LoadDataFrom(Parent[i])
      else
        TGeoObj(Parent[i]).RestoreState;
    ResetTempRelationships;

    If pv.IsValid then begin
      px := pv.x;
      py := pv.y;
      Result := True;
      end;
  finally
    pv.Free;
  end;
  If odbm <> Nil then
    ObjList.DraggedObj := odbm;
  end;


function TGEnvelopLine.GetInfo: String;
  var n : Integer;
  begin
  If IsDynamic then begin
    Result := MyObjTxt[112];
    InsertNameOf(Self, Result);
    InsertNameOf(TGeoObj(Parent.Last), Result);
    InsertNameOf(TGeoObj(Parent.First), Result);
    end
  else
    if Parent.Count > 0 then begin
      n := ObjList.IndexOf(Parent.Last);
      If n >= 0 then begin
        Result := MyObjTxt[110];
        InsertNameOf(TGeoObj(Parent.Last), Result);
        end
      else begin
        Result := MyObjTxt[111];
        Parent.Remove(Parent.Last);
        end;
      end
    else
      Result := MyObjTxt[111];
  end;

destructor TGEnvelopLine.Destroy;
  begin
  lines.Free;
  inherited Destroy;
  end;




{-------------------------------------------}
{ TGFunktion's Methods Implementation       }
{-------------------------------------------}

constructor TGFunktion.Create(iObjList: TGeoObjListe; iFunkTerm: WideString);
  var n : Integer;
  begin
  Inherited Create(iObjList, Nil);
  FStatus := FStatus and Not gs_ShowsAlways;  // erst mal unsichtbar schalten!
  FOLStatus := ols_IsDynamic + ols_IsSpline;
  FDerivable := False;
  FTerm := TTBaum.Create(ObjList, Rad);
  if Length(iFunkTerm) > 0 then begin
    With FTerm do begin
      BuildTree(iFunkTerm);
      RegisterTermParentsIn(Self);
      FDerivable := Not ContainsADescendentOf(Self, n);
      IsSpline := Not FTerm.is_random;
      end;
    ResetStepCount;
    If FTerm.is_okay then begin
      UpdateParams;
      if FDerivable then begin
        FDerive1    := TTBaum.CreateDerivationOf(FTerm);
        FDerivable  := FDerive1.is_okay;
        end;
      end;
    end;
  MyLineWidth := 1;
  end;

constructor TGFunktion.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  BufTermStr := literalLine(DE.getAttribute('term'));
  FTerm := TTBaum.Create(ObjList, Rad);
  end;

function TGFunktion.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  Result.setAttribute('term', maskDelimiters(FTerm.source_str));
  end;

destructor TGFunktion.Destroy;
  begin
  ShowsAlways := False;
  FreeAndNil(FTerm);
  FreeAndNil(FDerive1);
  Inherited Destroy;
  end;

procedure TGFunktion.AfterLoading(FromXML : Boolean = True);
  begin
  Inherited AfterLoading(FromXML);
  FTerm.BuildTree(BufTermStr);
  DataValid := FTerm.is_okay;
  If DataValid then begin
    IsSpline := Not FTerm.is_random;
    ResetStepCount;
    BufTermStr := '';
    FDerive1   := TTBaum.CreateDerivationOf(FTerm);
    FDerivable := Assigned(FDerive1) and FDerive1.is_okay;
    end;
  end;


function TGFunktion.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('Fn');
  end;


function TGFunktion.GetTermString: WideString;
  begin
  If Assigned(FTerm) then
    Result := FTerm.GetHTMLString(True)
  else
    Result := '';
  end;

function TGFunktion.GetDataStr: String;
  var s : String;
  begin
  s := WideString2HTMLString(GetTermString);
  If Length(s) > 0 then
    if ShowNameInNameObj then
      Result := '(x) = ' + s
    else
      Result := 'y = ' + s
  else
    Result := '';
  end;

function TGFunktion.GetHTMLString: String;
  begin
  Result := FTerm.GetHTMLString;
  end;

function TGFunktion.Dist(xm, ym: Double): Double;
  begin
  Result := Inherited Dist(xm, ym);
  end;

procedure TGFunktion.Rescale;
  begin
  ResetStepCount;
  UpdateParams;
  end;

procedure TGFunktion.SetTermString(nv: WideString);
  var ov  : WideString;
      nfd : TTBaum;
      n   : Integer;
  begin
  If Not Assigned(FTerm) then
    FTerm := TTBaum.Create(ObjList, Rad);
  FTerm.UnregisterTermParentsIn(Self);
  ov := FTerm.source_str;
  FTerm.BuildTree(nv);
  If FTerm.is_okay then begin
    FTerm.RegisterTermParentsIn(Self);
    FreeAndNil(FDerive1);
    If RecursionAllowed and FTerm.ContainsADescendentOf(Self, n) then
      FDerivable := False
    else begin
      nfd := TTBaum.CreateDerivationOf(FTerm);
      If nfd.is_okay then begin
        FDerive1   := nfd;
        FDerivable := True;
        end
      else begin
        nfd.Free;
        FDerivable := False;
        end;
      end;
    end
  else begin
    FTerm.BuildTree(ov);
    FTerm.RegisterTermParentsIn(Self);
    end;
  IsSpline := Not FTerm.is_random;
  ResetStepCount;
  UpdateParams;
  end;

function TGFunktion.GetFunctionValue(x: Double; var y: Double): Boolean;
  begin
  FTerm.Calculate(x, y);
  Result := FTerm.is_okay;
  end;

function TGFunktion.GetDerivationValue(x: Double; n: Integer; var y: Double): Boolean;
  { liefert derzeit bestenfalls die 1. Ableitung }
  begin
  Case n of
    0 : Result := GetFunctionValue(x, y);
    1 : If IsDerivable then begin
          FDerive1.Calculate(x, y);
          Result := FDerive1.is_okay;
          end
        else
          Result := False;
  else
    Result := False;
  end;
  end;

function TGFunktion.GetTangentIn(bx, by: Double; var tanCoeff: TVector3): Boolean;
  { Liefert in tanCoeff die Koeffizienten der Gleichung ax + by + c = 0
    der Tangente an das Funktions-Schaubild im Punkt B(bx, by). Dabei
    wird ohne Überprüfung vorausgesetzt, dass B auf dem Schaubild liegt,
    dass also  by = f(bx)  ist.                                         }
  var dy, dr : Double;
  begin
  If IsDerivable then begin
    FDerive1.Calculate(bx, dy);
    If FDerive1.is_okay then begin
      dr := Hypot(1, dy);   // Es ist dr >= 1 für alle dy !
      tanCoeff.X := dy/dr;
      tanCoeff.Y := -1/dr;
      tanCoeff.Z := -tanCoeff.X * bx - tanCoeff.Y * by;
      Result     := True;
      end
    else          // Berechnung der Ableitung ging schief !
      Result := Inherited GetTangentIn(bx, by, tanCoeff);
    end
  else         // Ableitung nicht verfügbar !
    Result := Inherited GetTangentIn(bx, by, tanCoeff);
  end;


function TGFunktion.GetMaxValueIn(xmin, xmax: Double; var ymax: Double): Boolean;
  { liefert TRUE, wenn alle Berechnungen im Intervall [xmin, xmax]
    erfolgreich waren; dann wird in ymax das Maximum zurückgegeben.
    Geht auch nur *eine* Berechnung schief, ist das Ergebnis FALSE
    und ymax wird ungeändert zurückgegeben.                        }
  var dx,               // Schrittweite
      rx, ry,           // "r"unning...
      y_max : Double;   // bisheriges Maximum
  begin
  Result := True;
  y_max  := -1.0e20;
  If xmax < xmin then begin
    dx := xmin; xmin := xmax; xmax := dx; end;
  dx := 0.1 / ObjList.e1x;    // führt zu 10 Werten pro Pixelbreite !
  rx := xmax;
  Repeat
    FTerm.Calculate(rx, ry);
    If FTerm.is_okay then
      If ry > y_max then y_max := ry
      else  { nix machen }
    else
      Result := False;
    rx := rx - dx;
  until rx < xmin;
  If Result then
    ymax := y_max;  // Ergebnis zurückliefern !
  end;


function TGFunktion.GetMinValueIn(xmin, xmax: Double; var ymin: Double): Boolean;
  { liefert TRUE, wenn alle Berechnungen im Intervall [xmin, xmax]
    erfolgreich waren; dann wird in ymin das Minimum zurückgegeben.
    Geht auch nur *eine* Berechnung schief, ist das Ergebnis FALSE
    und ymin wird ungeändert zurückgegeben.                        }
  var dx,               // Schrittweite
      rx, ry,           // "r"unning...
      y_min : Double;   // bisheriges Minimum
  begin
  Result := True;
  y_min  := 1.0e20;
  If xmax < xmin then begin
    dx := xmin; xmin := xmax; xmax := dx; end;
  dx := 0.1 / ObjList.e1x;    // führt zu 10 Werten pro Pixelbreite !
  rx := xmin;
  Repeat
    FTerm.Calculate(rx, ry);
    If FTerm.is_okay then
      If ry < y_min then y_min := ry
      else  { nix machen !}
    else
      Result := False;
    rx := rx + dx;
  until (rx > xmax) or Not Result;
  If Result then
    ymin := y_min;  // Ergebnis zurückliefern !
  end;


function TGFunktion.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccFunktion, ccFunktionOrAxis, ccCurveWithTans]) or
            Inherited IsCompatibleWith(ClassGroupId);
  end;


function TGFunktion.IsTrigWithBigVariation: Boolean;
  { Gibt an ob eine periodische Funktion mit großer Variation vorliegt;
    die Darstellung solcher Funktionen kann problematisch und/oder zeit-
    aufwändig sein. }
  begin
  Result := FTerm.is_trig and (FCurLen > ObjList.GetMaxCurveLength);
  end;

function TGFunktion.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO.ClassType = Self.ClassType) and
            (GO.Parent.Count = Self.Parent.Count) and
            (TGFunktion(GO).FTerm.HasSameDataAs(Self.FTerm));
  end;

procedure TGFunktion.ResetOLCPList(PointList : TVector3List);
  var min_x, max_x, dx : Double;
  begin
  min_x := ObjList.xMin;
  max_x := ObjList.xMax;
  dx := (max_x - min_x) / 10;
  PointList.Reset2StandardList(min_x - dx, max_x + dx, 43);
  end;

procedure TGFunktion.ResetStepCount;
  begin
  FStepCount := 37;
  GetAntialiasedStepCount(FTerm, ObjList.xMin, ObjList.xMax, FStepCount);
  end;

function TGFunktion.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  var npy: Double;
  begin
  FTerm.Calculate(param, npy);
  If FTerm.is_okay then begin
    px := param;
    py := npy;
    Result := True;
    end
  else
    Result := False;
  end;

function TGFunktion.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  begin
  param  := px;
  Result := True;
  end;


function TGFunktion.GetLinePtWithMinMouseDist(xm, ym, quant: Double; var px, py: Double): Boolean;
  var qxm, ny : Double;
  begin
  qxm := Quantisized(xm, quant);
  if GetFunctionValue(qxm, ny) then begin
    px := qxm;
    py := ny;
    Result := True;
    end
  else
    Result := False;
  end;

function TGFunktion.GetLinePtWithDistFrom(EP: TGPoint; r: Double; var px, py: Double): Boolean;
  begin
  Result := Inherited GetLinePtWithDistFrom(EP, r, px, py);
  end;


procedure TGFunktion.RebuildTermStrings;
  begin
  FTerm.BuildString;
  If IsDerivable then
    FDerive1.BuildString;
  end;

procedure TGFunktion.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  menu.Items.Clear;    { "Free"d auch die einzelnen Items ! }
  AddPopupMenuItemTo(menu, cme_hide, CME_PopupClick, cmd_ToggleVis);
  AddPopupMenuItemTo(menu, cme_name, CME_PopupClick, cmd_NameObj);
  If ShowDataInNameObj then
    AddPopupMenuItemTo(menu, cme_hideequation, CME_PopupClick, cmd_NoData)
  else
    AddPopupMenuItemTo(menu, cme_showequation, CME_PopupClick, cmd_AddData);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_col, CME_PopupClick, cmd_EditColour);
  if Not IsTrigWithBigVariation then
    AddPopupMenuItemTo(menu, cme_linestyle, CME_PopupClick, cmd_EditLineStyle);

  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_editfunc, CME_PopupClick, cmd_EditFunktion);
  AddPopupMenuItemTo(menu, cme_functable, CME_PopupClick, cmd_ShowFunkTable);
  end;


procedure TGFunktion.UpdateParams;
  var asp,            { Aspekt-Faktor (für anisotrope Koordinatensysteme) }
      min_x,          { sichtbarer x-Bereich des Fensters                 }
      max_x : Double;

  procedure CalculateOLPoint(v : TVector3);
    { v.tag erhält das Ergebnis der Sichtbarkeitsprüfung:
        1   wenn v einen Punkt im sichtbaren Fenster beschreibt;
        0   wenn v einen unsichtbaren Punkt dicht beim Rand beschreibt;
       -1   wenn v einen unsichtbaren Punkt weit entfernt vom Rand angibt;
       -2   wenn v einen ungültigen Punkt beschreibt                    }
    begin
    If DataValid then begin
      v.X := v.Z;
      FTerm.Calculate(v.X, v.Y);
      If FTerm.is_okay then begin
        v.IsValid := True;
        v.tag := ObjList.LogWinKnows(v.X, v.Y);
        end
      else begin
        v.IsValid := False;
        v.tag := -2;
        end;
      end
    else
      v.IsValid := False;
    end;

  function TooMuchBending(u1, u2, u3: TVector3): Boolean;
    { 17.02.08 : Die "Biegung" des Graphen wird mit korrigierten
                 y-Werte berechnet, um anisotrope Koordinatensystemen
      gerecht zu werden. Sie ist damit eine rein geometrische Größe,
      die sich direkt auf die am Bildschirm dargestellte Linie bezieht. }
    var du12x, du12y, du12b,
        du23x, du23y, du23b,
        bz, bn : Double;
    begin
    du12x := u2.x - u1.x;
    du12y := (u2.y - u1.y) / asp;
    du12b := Hypot(du12x, du12y);
    If Abs(du12b) > 1e-50 then begin
      du12x := du12x / du12b;
      du12y := du12y / du12b;
      du23x := u3.x - u2.x;
      du23y := (u3.y - u2.y) / asp;
      du23b := Hypot(du23x, du23y);
      If Abs(du23b) > 1e-50 then begin
        du23x := du23x / du23b;
        du23y := du23y / du23b;
        bz := Hypot(du23x - du12x, du23y - du12y);
        bn := Hypot(du23x + du12x, du23y + du12y);
        Result := bz > bn * MaxBending;
        end
      else
        Result := False
      end
    else
      Result := False;
    end;

  procedure InsertPointsBetween(v0, v1, v2: TVector3);
    var vm, vn : TVector3;
        dist   : Double;
    begin
    dist := Hypot(v1.X-v0.X, (v1.Y-v0.Y) / asp) + Hypot(v2.X - v1.X, (v2.Y - v1.Y) / asp);
    If (dist > ObjList.PixelDist * 5) and
       (Abs(v2.Z-v0.Z) > ParamEpsilon) and
       TooMuchBending(v0, v1, v2) then begin
      vm := TVector3.Create(0, 0, (v0.Z + v1.Z)/2);
      try
        CalculateOLPoint(vm);
        points.InsertZSorted(vm.X, vm.Y, vm.Z, vm.tag);

        vn := TVector3.Create(0, 0, (v1.Z + v2.Z)/2);
        try
          CalculateOLPoint(vn);
          points.InsertZSorted(vn.X, vn.Y, vn.Z, vn.tag);
        { 29.11.03 : Auch wenn der neue Punkt nicht für weitere rekursive
                     Aufrufe verwendet wird, muss er eingefügt werden!
          Andernfalls bleibt der Algorithmus hängen! (Grund noch unklar,
          aber Effekt zuverlässig reproduzierbar bei Schwebungs-Kurven)      }

          If (v0.tag > 0) or (vm.tag > 0) or (v1.tag > 0) then
            InsertPointsBetween(v0, vm, v1);
        finally
          vn.Free;
        end;
      finally
        vm.Free;
      end;
      end;
    end;

  procedure FillUpPointList;
    var v0, v1, v2 : TVector3;
        i          : Integer;
    begin
    For i := 0 to Pred(points.Count) do     { Alle Stützpunkte berechnen   }
      CalculateOLPoint(TVector3(points[i]));
    If IsSpline then begin
      i := 0;                                 { Stützpunktliste auffüllen    }
      While i < points.Count-3 do begin
        v0   := TVector3(points[i]);
        v1   := TVector3(points[i+1]);
        v2   := TVector3(points[i+2]);
        InsertPointsBetween(v0, v1, v2);
        i    := i + 1;
        { 29.11.03 : Versuchsweise wurde i := max(i+1, points.IndexOf(v1)-1
                     gesetzt. Dies kann aber zu unvollständig ausgefahrenen
          Kurvenstücken führen; insgesamt wird die Kurve mit i := i+1
          deutlich genauer durchfahren. Dafür kann man in der Prozedur
          InsertPointsBetween() Arbeit einsparen (siehe oben!).              }
        end;
      end;
    end;

  procedure Check4JumpsAndCurLen;
    { Wenn der Gradient dr/dz = (dx/dz, dy/dz) zwischen zwei Punkten P1
      und P2 der Kurve einen zu großen Betrag hat, dann wird dort eine
      Unstetigkeitsstelle vermutet. Dann wird zwischen P1 und P2 ein
      ungültiger Punkt eingefügt, um eine Unterbrechung der Ortslinie an
      dieser Stelle zu erzwingen.

      Bei der Berechnung des Gradienten wird der Aspekt berücksichtigt,
      weshalb dieser eine rein geometrische Größe der auf dem Bildschirm
      dargestellten Kurve ist (siehe auch oben in "TooMuchBending()" !).
      Die Berechnung der Kurvenlänge wird hingegen *ohne* Rücksicht auf
      den Aspekt durchgeführt und liefert damit die Kurvenlänge im vor-
      gegebenen Koordinatensystem.                                        }

    var i      : Integer;
        v1, v2 : TVector3;   { nur Zeiger ! }
    begin
    FCurLen := 0;
    If points.Count >= 2 then begin
      i := 1;
      While i < points.Count do begin
        v1 := points[i-1];
        v2 := points[i  ];
        If v1.IsValid and v2.IsValid then
          If MaxGradient * Abs(v2.Z - v1.Z) < Hypot(v2.X - v1.X, (v2.Y - v1.Y) / asp) then begin
            points.InsertZSorted(1.1e100, 1.1e100, (v1.Z + v2.Z)/2, -2);
            Inc(i);
            end
          else
            FCurLen := FCurLen + Hypot(v2.X - v1.X, v2.Y - v1.Y);
        Inc(i);
        end;
      end;
    end;

  procedure Check4ConstLines;
    { 30.04.2008: Neu-Implementierung für Version 3.1 b:
                  Verkürzt alle horizontalen Strecken auf einen Anfangs-
      und einen Endpunkt; fügt danach in jede horizontale Strecke, die
      innerhalb des x-Bereichs des Fensters beginnt oder endet, 1 bis 2
      weitere Punkte ein, damit der Bezier-Darstellungs-Algorithmus
      korrekte Kurvenverläufe liefern kann. Liegen der Anfangspunkt links
      vom linken Rand des Fenster-x-Bereiches und der Endpunkt rechts vom
      rechten Rand, dann werden zusätzliche Punkte eingefügt, die die
      Sichtbarkeit der im Fenster verlaufenden Teilstrecke garantieren.

      28.05.2008: Bereichs-Check [*] hinzugefügt in der Schleife, die
                  nach dem nächsten gültigen Kurvenpunkt sucht.
      }
    var av, ev : TVector3;
        i, k   : Integer;
    begin
    i := -1;
    Repeat i := i + 1 // Punkte ausserhalb des Fensters überspringen
    until TVector3(Points[i + 1]).X >= min_x;
    i := 0;
    While i < points.Count do begin
      Repeat          // Nächsten gültigen Anfangspunkt suchen
        av := TVector3(points[i]);
        i := i + 1;
      until av.IsValid or (i >= points.Count);  // [*]
      ev := av;
      While (i < points.Count) and
            IsZero(TVector3(points[i]).Y - av.Y, epsilon) and
            TVector3(points[i]).IsValid do begin
        ev := TVector3(points[i]);
        i := i + 1;
        end;          // Alle Punkte von av bis ev sind gültig und
                      //   stimmen in den y-Werten überein.
      If ev.Z > av.Z then begin
        k := points.IndexOf(av) + 1;  // Alle alten Zwischenpunkte löschen und ...
        While points[k] <> ev do
          points.DeleteItem(k);
        If (av.X >= min_x) or (ev.X <= max_x) then
          If av.X + 2 * ParamEpsilon < ev.X then begin
            points.InsertZSorted(av.X + ParamEpsilon, av.Y, av.Z + ParamEpsilon);
            points.InsertZSorted(ev.Z - ParamEpsilon, ev.Y, ev.Z - ParamEpsilon);
            end
          else
            points.InsertZSorted((av.X + ev.X)/2, av.Y, (av.Z + ev.Z)/2)
        else
          if (av.X < min_x) and (ev.X > max_x) then begin
            points.InsertZSorted(min_x,                av.Y, min_x               );
            points.InsertZSorted(min_x + ParamEpsilon, av.Y, min_x + ParamEpsilon);
            points.InsertZSorted(max_x - ParamEpsilon, ev.Y, max_x - ParamEpsilon);
            points.InsertZSorted(max_x,                ev.Y, max_x               );
            end;
        end;                          // ... neue Zwischenpunkte einfügen!
      i := points.GetPtIndexWithZequals(ev.Z) + 1;
      end;
    end; { of Check4ConstLines }

  var dx  : Double;
      psc : Integer;
  begin { of UpdateParams }
  DataValid := True;
  min_x := ObjList.xMin;
  max_x := ObjList.xMax;
  dx := (max_x - min_x) / 10;
  If IsSpline then
    points.Reset2StandardList(min_x - dx, max_x + dx, FStepCount)
  else begin
    psc := Round(max_x - min_x) * 100;
    points.Reset2StandardList(min_x - dx, max_x + dx, psc);
    end;
  asp := Abs(ObjList.e1x / ObjList.e2y);
  FillUpPointList;
  DataValid := points.ValidPointCount > 3;
  If DataValid then begin
    If IsSpline then begin
      Check4JumpsAndCurLen;
    //  Check4ConstLines;
      end;
    UpdateScreenCoords;
    end;
  end; { of UpdateParams }


procedure TGFunktion.UpdateScreenCoords;
  begin
  Inherited UpdateScreenCoords;
  end;


procedure TGFunktion.AutoUpdate;
  begin
  UpdateParams;
  end;


function TGFunktion.GetInfo: String;
  var s : String;
  begin
  s := WideString2HTMLString(FTerm.source_str);
  Result := Format(MyObjTxt[67], [s]);
  InsertNameOf(Self, Result);
  InsertNameOf(Self, Result);
  end;



{-------------------------------------------}
{ TGIntArea's Methods Implementation        }
{-------------------------------------------}


constructor TGIntArea.Create(iObjList: TGeoObjListe; iF1, iF2: TGFunktion;
                             iA, iB: TGPoint);
  begin
  Inherited Create(iObjList, Nil, False, True);
  BecomesChildOf(iA);
  BecomesChildOf(iB);
  BecomesChildOf(iF1);
  If iF2 = Nil then
    DoubleBordered := False
  else begin
    BecomesChildOf(iF2);
    DoubleBordered := True;
    end;
  FMyBrushStyle := bsDiagCross;  
  FStatus := gs_Normal;   // schaltet auch "IsVisible" ein
  If ClassType = TGIntArea then begin
    UpdateParams;
    DrawIt;
    end;
  end;

procedure TGIntArea.AfterLoading(FromXML: Boolean);
  begin
  inherited AfterLoading(FromXML);
  DoubleBordered := (Parent.Count > 3) and
                    (TGeoObj(Parent[3]) is TGFunktion);
  end;

function TGIntArea.DefaultName: WideString;
  begin
  DefaultName := ObjList.GetUniqueName('Int');
  end;

function TGIntArea.GetValue(selector: Integer): Double;
  begin
  Case selector of
    gv_area : Result := FIntVal;
  else
    Result := Inherited GetValue(selector);
  end;
  end;

function TGIntArea.CanBeDragged: Boolean;
  begin
  Result := False;
  end;

function TGIntArea.AllParentsAreEqual(GO: TGeoObj): Boolean;
  var i : Integer;
  begin
  Result := True;
  For i := 0 to Pred(Parent.Count) do
    If Parent[i] <> GO.Parent[i] then
      Result := False;
  end;

function TGIntArea.HasSameDataAs(GO: TGeoObj): Boolean;
  { 26.01.07 : Eigene Version ergänzt, weil die geerbte Voraussetzungen
               benötigt hat, die hier nicht erfüllt sind. Daher darf die
               Vorfahr-Methode hier auch nicht aufgerufen werden !       }
  begin
  Result := (GO.ClassType = TGIntArea) and
            (Parent.Count = GO.Parent.Count) and
            AllParentsAreEqual(GO);
  end;


procedure TGIntArea.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@FxA, SizeOf(FxA));
  Old_Data.push(@FxB, SizeOf(FxB));
  Old_Data.push(@y1A, SizeOf(y1A));
  Old_Data.push(@y1B, SizeOf(y1B));
  Old_Data.push(@y2A, SizeOf(y2A));
  Old_Data.push(@y2B, SizeOf(y2B));
  Old_Data.push(@FIntVal, SizeOf(FIntVal));
  Old_Data.push(@sxli, SizeOf(sxli));
  Old_Data.push(@sxre, SizeOf(sxre));
  Old_Data.push(@sylio, SizeOf(sylio));
  Old_Data.push(@syreo, SizeOf(syreo));
  Old_Data.push(@syliu, SizeOf(syliu));
  Old_Data.push(@syreu, SizeOf(syreu));
  end;

procedure TGIntArea.RestoreState;
  begin
  Old_Data.pop(@syreu);
  Old_Data.pop(@syliu);
  Old_Data.pop(@syreo);
  Old_Data.pop(@sylio);
  Old_Data.pop(@sxre);
  Old_Data.pop(@sxli);
  Old_Data.pop(@FIntVal);
  Old_Data.pop(@y2B);
  Old_Data.pop(@y2A);
  Old_Data.pop(@y1B);
  Old_Data.pop(@y1A);
  Old_Data.pop(@FxB);
  Old_Data.pop(@FxA);
  Inherited RestoreState;
  SetFillHandle;
  end;

procedure TGIntArea.UpdateParams;
  var I2 : Double;
      R  : TRect;
      tb : TTBaum;
  begin
  DataValid := False;
  FxA := TGPoint(Parent[0]).X;
  FxB := TGPoint(Parent[1]).X;
  tb  := TGFunktion(Parent[2]).FTerm;
  With tb do begin
    Calculate(FxA, y1A);
    If tb.status = tbOkay then begin
      Calculate(FxB, y1B);
      If tb.Status = tbOkay then
        Integrate(FxA, FxB, FIntVal);
      end;
    end;
  If tb.Status = tbOkay then begin
    If DoubleBordered then begin
      tb := TGFunktion(Parent[3]).FTerm;
      With tb do begin
        Calculate(FxA, y2A);
        If tb.status = tbOkay then begin
          Calculate(FxB, y2B);
          If tb.Status = tbOkay then
            Integrate(FxA, FxB, I2);
          end;
        end;
      If tb.Status = tbOkay then begin
        FIntVal := FIntVal - I2;
        DataValid := True;
        UpdateScreenCoords;
        end;
      end
    else begin
      DataValid := True;
      UpdateScreenCoords;
      end;

    { Schätzwert für den "Mittelpunkt" der Fläche berechnen,
      wird von einem eventuellen Namens-Objekt benutzt.
      Dabei wird das "alte" Handle verwendet: das neue wird erst in
      DrawIt erzeugt! Zwar ist das alte Handle nicht mehr ganz aktuell,
      aber die Wahrscheinlichkeit, dass das neue einen recht ähnlichen
      "Mittelpunkt" liefern würde, ist einigermaßen groß.             }
    If DataValid and (Handle <> 0) then begin
      GetRgnBox(Handle, R);
      ObjList.GetLogCoords((R.Left + R.Right) Div 2,
                           (R.Top + R.Bottom) Div 2, X, Y);
      end;
    end;
  end;

function TGIntArea.SetFillHandle : Boolean;
  var VList   : Array of TPoint;
      imax,
      n, k, i : Integer;

  procedure VAdd(ix, iy: Integer);
    begin
    If High(VList) < n then
      SetLength(VList, High(VList) + 20);
    VList[n] := Point(ix, iy);
    n        := n + 1;
    end;

  begin
  If Handle <> 0 then begin
    HideIt;
    DeleteObject(Handle);
    Handle := 0;
    end;
  SetLength(VList, 100);
  n := 0;
  VAdd(sxli, sylio);
  With TGFunktion(Parent[2]) do begin
    k := 0;
    While k <= High(IntPointLists) do begin
      i    := 0;
      imax := High(IntPointLists[k]);
      While (i <= imax) and (IntPointLists[k,i].x < sxli) do Inc(i);
      While (i <= imax) and (IntPointLists[k,i].x < sxre) do begin
        VAdd(IntPointLists[k,i].x, IntPointLists[k,i].Y);
        Inc(i);
        end;
      k := k + 1;
      end;
    end;
  VAdd(sxre, syreo);
  VAdd(sxre, syreu);
  If DoubleBordered then
    With TGFunktion(Parent[3]) do begin
      k := High(IntPointLists);
      While k >= 0 do begin
        i := High(IntPointLists[k]);
        While (i >= 0) and (IntPointLists[k,i].x > sxre) do Dec(i);
        While (i >= 0) and (IntPointLists[k,i].x > sxli) do begin
          VAdd(IntPointLists[k,i].x, IntPointLists[k,i].Y);
          Dec(i);
          end;
        k := k - 1;
        end;
      end;
  VAdd(sxli, syliu);
  Handle := CreatePolygonRgn(VList[0], n, PolyFillMode);
  Result := Handle <> 0;
  VList  := Nil;
  end;


procedure TGIntArea.UpdateScreenCoords;
  var xA, yA,
      xB, yB : Double;

  procedure Switch(var n1, n2: Integer);
    var p : Integer;
    begin
    p := n1; n1 := n2; n2 := p;
    end;

  procedure MoveInsideWindow(var y: Integer);
    begin
    If y < ObjList.WindowRect.Top then
      y := ObjList.WindowRect.Top
    else
      If y > ObjList.WindowRect.Bottom then
        y := ObjList.WindowRect.Bottom;
    end;

  begin
  If DataValid then
    With ObjList, ObjList.TargetCanvas do begin
      { Grenzen des Zeichenbereiches festlegen }
      If FxA > xMin then
        If FxA < xMax then begin
          xA := FxA; yA := y1A; end
        else begin
          xA := xMax; TGFunktion(Parent[2]).FTerm.Calculate(xA, yA); end
      else begin
        xA := xMin; TGFunktion(Parent[2]).FTerm.Calculate(xA, yA); end;
      ObjList.GetWinCoords(xA, yA, sxli, sylio);
      If FxB < xMax then
        If FxB > xMin then begin
          xB := FxB; yB := y1B; end
        else begin
          xB := xMin; TGFunktion(Parent[2]).FTerm.Calculate(xB, yB); end
      else begin
        xB := xMax; TGFunktion(Parent[2]).FTerm.Calculate(xB, yB); end;

      { Bildschirmkoordinaten der Integrationsbereichsgrenzen berechnen }
      ObjList.GetWinCoords(xB, yB, sxre, syreo);
      If DoubleBordered then begin
        If Abs(xB - FxB) < epsilon then yB := y2B
        else TGFunktion(Parent[3]).FTerm.Calculate(xB, yB);
        ObjList.GetWinCoords(xB, yB, sxre, syreu);
        If Abs(xA - FxA) < epsilon then yA := y2A
        else TGFunktion(Parent[3]).FTerm.Calculate(xA, yA);
        ObjList.GetWinCoords(xA, yA, sxli, syliu);
        end
      else begin
        ObjList.GetWinCoords(xB, 0, sxre, syreu);
        ObjList.GetWinCoords(xA, 0, sxli, syliu);
        end;

      { Korrektur für Bildschirmkoordinaten oberhalb und unterhalb des Fensters }
      MoveInsideWindow(sylio);
      MoveInsideWindow(syreo);
      MoveInsideWindow(syreu);
      MoveInsideWindow(syliu);

      { Bei "Integration nach links" werden einfach die Grenzen vertauscht ! }
      If sxli > sxre then begin
        Switch(sxli,  sxre );
        Switch(sylio, syreo);
        Switch(syliu, syreu);
        end;

      { Handle für die Füllung besorgen }
      DataValid := SetFillHandle;
      end;
  end;

procedure TGIntArea.AdjustGraphTools(todraw : Boolean);
  var orgMyColour : TColor;
  begin
  orgMyColour := MyColour;
  FMyColour := LightCol(MyColour, 0.2);
  Inherited AdjustGraphTools(todraw);
  FMyColour := orgMyColour;
  If todraw then with ObjList.TargetCanvas do begin
    Pen.Color   := MyColour;
    Pen.Style   := psSolid;
    Pen.Width   := 1;
    end
  else with ObjList.TargetCanvas do begin
    Pen.Color   := Brush.Color;
    Pen.Style   := psSolid;
    end;
  end;

procedure TGIntArea.DrawLimitLines;
  var syori: Integer;
  begin
  With ObjList.TargetCanvas do begin
    MoveTo(sxli, syliu);
    LineTo(sxli, sylio);
    MoveTo(sxre, syreu);
    LineTo(sxre, syreo);
    Pen.Style := psDot;
    syori := ObjList.WindowOrigin.Y;
    If syliu > sylio then
      If syori > syliu then begin
        MoveTo(sxli, syliu);
        LineTo(sxli, syori);
        end
      else if syori < sylio then begin
        MoveTo(sxli, sylio);
        LineTo(sxli, syori);
        end;
    If syreu > syreo then
      If syori > syreu then begin
        MoveTo(sxre, syreu);
        LineTo(sxre, syori);
        end
      else if syori < syreo then begin
        MoveTo(sxre, syreo);
        LineTo(sxre, syori);
        end;
    end;
  end;

procedure TGIntArea.DrawIt;
  begin
  If IsVisible then begin
    Inherited DrawIt;
    DrawLimitLines;
    end;
  end;

procedure TGIntArea.HideIt;
  begin
  If IsVisible then begin
    Inherited HideIt;
    DrawLimitLines;
    end;
  end;

function TGIntArea.GetInfo: String;
  begin
  If Not DoubleBordered then begin
    Result := MyObjTxt[91];
    InsertNameOf(Self, Result);
    InsertNameOf(TGeoObj(Parent[2]), Result);
    end
  else begin
    Result := MyObjTxt[92];
    InsertNameOf(Self, Result);
    InsertNameOf(TGeoObj(Parent[2]), Result);
    InsertNameOf(TGeoObj(Parent[3]), Result);
    end;
  end;


{-------------------------------------------}
{ TGRiemannArea's Methods Implementation    }
{-------------------------------------------}

constructor TGRiemannArea.Create(iObjList: TGeoObjListe; iF1: TGFunktion;
                                 iA, iB: TGPoint; iRType: Integer; iIntCount: String);
  begin
  Inherited Create(iObjList, iF1, Nil, iA, iB);
  FRType    := iRType;
  FIntCTerm := TTBaum.Create(iObjList, Rad);
  try
    SetNewIntCountTerm(iIntCount);
    UpdateParams;
    DrawIt;
  except
    DataValid := False;
  end;  { of try }
  end;

constructor TGRiemannArea.CreateFromDomData(iObjList: TGeoObjListe;
                                            DE: IXMLNode);
  begin
  inherited CreateFromDomData(iObjList, DE);
  If LowerCase(DE.getAttribute('type')) = 'uppersum' then
    FRType := 1
  else
    FRType := 0;
  FIntCTerm := TTBaum.Create(iObjList, Rad);
  FIntCTerm.source_str := DE.getAttribute('intervals');
  end;

destructor TGRiemannArea.Destroy;
  begin
  ShowsAlways := False;
  FreeAndNil(FIntCTerm);
  Points := Nil;
  IntPtList := Nil;
  Inherited Destroy;
  end;

procedure TGRiemannArea.AfterLoading(FromXML: Boolean);
  begin
  inherited AfterLoading(FromXML);
  SetNewIntCountTerm(FIntCTerm.source_str);
  end;

function TGRiemannArea.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  Case FRType of
    0 : Result.setAttribute('type', 'lowersum');
    1 : Result.setAttribute('type', 'uppersum');
  end;
  Result.setAttribute('intervals', FIntCTerm.source_str);
  end;

function TGRiemannArea.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (GO is TGRiemannArea) and
            (Parent.Count = GO.Parent.Count) and
            (Intervals = (GO as TGRiemannArea).Intervals) and
            (FRType = (GO as TGRiemannArea).FRType) and
            AllParentsAreEqual(GO);
  end;

function TGRiemannArea.HasSibling(var GO: TGeoObj): Boolean;

  function IsSiblingOf(RO: TGRiemannArea): Boolean;
    var i : Integer;
    begin
    If (RO.ClassType = TGRiemannArea) and
       (RO.Parent.Count = Parent.Count) and
       (RO.Intervals = Intervals) and
       (RO.FIntCTerm.HasSameDataAs(FIntCTerm)) then begin
      Result := True;
      For i := 0 to Pred(Parent.Count) do
        if RO.Parent[i] <> Parent[i] then
          Result := False;
      If Result then
        Result := RO.RiemannType <> RiemannType;
      end
    else
      Result := False;
    end;

  var n : Integer;
  begin
  GO := Nil;
  n  := 0;
  While (GO = Nil) and (n <= ObjList.LastValidObjIndex) do
    If IsSiblingOf(ObjList[n]) then
      GO := ObjList[n]
    else
      n := n + 1;
  Result := GO <> Nil;
  end;


function TGRiemannArea.CanBeDragged: Boolean;
  begin
  Result := False;
  end;

function TGRiemannArea.SetFillHandle: Boolean;
  begin
  If Handle <> 0 then
    DeleteObject(Handle);
  Handle := CreatePolygonRgn(IntPtList[0], 2*(Intervals + 1), PolyFillMode);
  Result := Handle <> 0;
  end;


procedure TGRiemannArea.LoadContextMenuEntriesInto(menu: TPopupMenu);
  { Die Umschaltung zwischen Unter- und Obersumme wurden auf Anraten
    von Ella deaktiviert. Es sollte besser gleich bei der Erzeugung
    endgültig über den Typ der Riemann-Summe entschieden werden.

    16.02.08     Hm. Franz Klement will den Befehl unbedingt. Also
                 aktivieren wir ihn wieder, aber etwas smarter.     }
  var SO : TGeoObj;     // "S"ibling "O"bject
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  AddPopupMenuItemTo(menu, '-', Nil, 0);
  AddPopupMenuItemTo(menu, cme_editRIcnt, CME_PopupClick, cmd_EditRieIntCount);
  If Not HasSibling(SO) then begin
    If FRType = 1 then
      AddPopupMenuItemTo(menu, cme_lowersum, CME_PopupClick, cmd_Switch2LowerSum)
    else
      AddPopupMenuItemTo(menu, cme_uppersum, CME_PopupClick, cmd_Switch2UpperSum);
    end;
  end;

procedure TGRiemannArea.SetRType(newVal: Integer);
  begin
  If newVal <> FRType then begin
    FRType := newVal;
    UpdateParams;
    end;
  end;

procedure TGRiemannArea.SetNewIntCountTerm(nt: String);
  var nv : Double;
  begin
  Try
    DataValid := True;
    If FIntCTerm.baum <> Nil then
      FIntCTerm.UnregisterTermParentsIn(Self);
    FIntCTerm.BuildTree(nt);
    If FIntCTerm.is_okay then begin
      FIntCTerm.RegisterTermParentsIn(Self);
      FIntCTerm.Calculate(0, nv);
      If FIntCTerm.is_okay then
        SetIntCount(Trunc(nv))
      else
        DataValid := False;
      end
    else
      DataValid := False;
  except
    DataValid := False;
  end; { of try }
  end;


procedure TGRiemannArea.SetIntCount(newVal: Integer);
  begin
  If (newVal <> FIntCount) or
     ObjList.IsLoading then begin
    If newVal <    1 then newVal :=    1;
    If newVal > MaxRiemannCount then newVal := MaxRiemannCount;
    FIntCount := newVal;
    SetLength(Points, newVal + 1);
    SetLength(IntPtList, 2*(newVal + 1));
    end;
  end;

function TGRiemannArea.GetIntCountStr: String;
  begin
  If Assigned(FIntCTerm) then
    Result := FIntCTerm.source_str
  else
    Result := IntToStr(FIntCount);
  end;


procedure TGRiemannArea.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@IntPtList[0], 2 * (Intervals + 1) * SizeOf(TPoint));
  Old_Data.push(@Points[0], (Intervals + 1) * SizeOf(TFloatPoint));
  Old_Data.push(@FIntCount, SizeOf(FIntCount));
  end;

procedure TGRiemannArea.RestoreState;
  var n : Integer;
  begin
  Old_Data.pop(@n);   // Alten Wert von "Intervals" holen und dann ....
  SetIntCount(n);     // ... die dynamischen Datenfelder redimansionieren !
  Old_Data.pop(@Points[0]);
  Old_Data.pop(@IntPtList[0]);
  Inherited RestoreState;  // Ruft auch SetFillHandle auf !
  end;


procedure TGRiemannArea.SortSiblings;
  var SO    : TGeoObj;
      m, n  : Integer;
  begin
  If HasSibling(SO) then begin
    n := ObjList.IndexOf(SO);
    m := ObjList.IndexOf(Self);
    If (m > n) XOR (RiemannType < (SO as TGRiemannArea).RiemannType) then begin
      If m > n then begin
        ObjList.Delete(m);
        ObjList.Insert(n, Self);
        end
      else begin  // n > m !!
        ObjList.Delete(n);
        ObjList.Insert(m, SO);
        end;
      end;
    end;
  end;


procedure TGRiemannArea.UpdateParams;
  var PF    : TGFunktion;
      ib, dx,
      rx, ry,
      ysum  : Double;
      i     : Integer;

  function GetFuncHeight(x1, x2: Double; var f: Double): Boolean;
    begin
    Case FRType of
      0 : Result := PF.GetMinValueIn(x1, x2, f);
      1 : Result := PF.GetMaxValueIn(x1, x2, f);
    else
      Result := False;
    end; { of case }
    end;

  begin
  DataValid := True;
  FIntCTerm.Calculate(0, dx);
  If FIntCTerm.is_okay then begin
    SetIntCount(Trunc(dx));
    FxA := (TGeoObj(Parent[0]) as TGPoint).X;
    FxB := (TGeoObj(Parent[1]) as TGPoint).X;
    ib  := FxB - FxA;
    dx  := ib / Intervals;
    PF  := TGeoObj(Parent[2]) as TGFunktion;
    rx := FxA;
    i := 0;
    ysum := 0;
    While (i < Intervals) and DataValid do
      If GetFuncHeight(rx, rx + dx, ry) then begin
        Points[i].x := rx;
        Points[i].y := ry;
        ysum := ysum + ry;
        rx := rx + dx;
        i  := i + 1;
        end
      else
        DataValid := False;
    If DataValid then begin
      FIntVal := ysum * dx;
      Points[Intervals].x := FxB;
      X := (FxA + FxB) / 2;
      Y := ysum / (2 * Intervals);
      UpdateScreenCoords;
      end;
    end
  else
    DataValid := False;
  end;

procedure TGRiemannArea.UpdateScreenCoords;
  var i : Integer;
  begin
  ObjList.GetWinCoords(FxA, 0, IntPtList[0].x, IntPtList[0].y);
  For i := 0 to Pred(Intervals) do begin
    ObjList.GetWinCoords(points[i].x, points[i].y,
                         IntPtList[2*i + 1].x, IntPtList[2*i + 1].y);
    ObjList.GetWinCoords(points[i + 1].x, points[i].y,
                         IntPtList[2*i + 2].x, IntPtList[2*i + 2].y);
    end;
  ObjList.GetWinCoords(FxB, 0, IntPtList[2*Intervals + 1].x,
                               IntPtList[2*Intervals + 1].y);
  { Das folgende Handle wird für die Interaktion mit der Maus gebraucht. }
  SetFillHandle;
  end;

procedure TGRiemannArea.DrawLimitLines;
  var i : Integer;
  begin
  With ObjList.TargetCanvas do begin
    ObjList.TargetCanvas.Polygon(IntPtList);
    For i := 1 to Pred(Intervals) do begin
      MoveTo(IntPtList[2*i].X, IntPtList[2*i].Y);
      LineTo(IntPtList[2*i].X, IntPtList[0].Y);
      end;
    end;
  end;


function TGRiemannArea.GetInfo: String;
  begin
  If FRType = 0 then
    Result := MyObjTxt[104]    // Untersumme
  else
    Result := MyObjTxt[105];   // Obersumme
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[2]), Result);
  end;


{-------------------------------------------}
{ TGIPolynomFkt's Methods Implementation    }
{-------------------------------------------}

constructor TGIPolynomFkt.Create(iObjList: TGeoObjListe; iPList: TList<TGPoint>);
  var i: Integer;
  begin
  Inherited Create(iObjList, '');
  polyGrad := iPList.Count - 1;    // Grad ist um 1 kleiner als die Anzahl der Punkte
  SetLength(polyCoeff, polyGrad + 1);  // Koeffizienten gibt's so viele wie Punkte
  for i := 0 to polyGrad do
    BecomesChildOf(iPList[i]);
  Points2Polynom;  // setzt auch DataValid !
  ShowsAlways := DataValid;
  MyColour := clBlack;
  UpdateParams;
  end;

procedure TGIPolynomFkt.AfterLoading(FromXML : Boolean = True);
  begin
  Inherited AfterLoading(FromXML);
  polyGrad := Parent.Count - 1;
  end;

function TGIPolynomFkt.Points2Polynom: Boolean;
  var lgs  : TLGS;
      eq   : TEquation;
      i, k : Integer;
      x, xp: Double;
      fs   : String;
  begin
  lgs := TLGS.Create(polyGrad + 1, polyGrad + 1);
  SetLength(eq, polyGrad + 2);
  // Daten aus den Punkten auslesen und nach lgs schreiben
  for i := 0 to polyGrad do begin
    x := (TGeoObj(Parent[i]) as TGPoint).X;
    eq[0] := (TGeoObj(Parent[i]) as TGPoint).Y;
    xp := 1;
    for k := 1 to polyGrad + 1 do begin
      eq[k] := xp;
      xp := xp * x;
      end;
    lgs.SetEquation(i + 1, eq);
    end;
  // Berechnung ausführen (lassen)
  lgs.Diagonalize;
  // Ergebnis nach polyCoeff schreiben (?)
  lgs.GetEquation(0, eq);
  if eq[0] = 1 then begin
    fs := '';
    if Abs(eq[1]) > mathlib.epsilon then  // eq[1] <> 0
      fs := FloatToStr(eq[1])
    else                                  // eq[1] == 0
      fs := '';
    if Abs(eq[2]) > mathlib.epsilon then  // eq[2] <> 0
      if eq[2] > 0 then begin
        if Length(fs) > 0 then
          fs := fs + ' + ';
        fs := fs + FloatToStr(eq[2]) + ' * x ';
        end
      else begin  // eq[2] < 0
        if Length(fs) > 0 then
          fs := fs + ' - '
        else
          fs := '-';
        fs := fs + FloatToStr(Abs(eq[2])) + ' * x ';
        end
    else                                  // eq[2] == 0
      ;   // Do nothing !
    for k := 3 to polyGrad + 1 do begin
      if Abs(eq[k]) > mathlib.epsilon then // eq[k] <> 0
        if eq[k] > 0 then begin
          if Length(fs) > 0 then
            fs := fs + ' + ';
          fs := fs + FloatToStr(eq[k]) + ' * x^' + IntToStr(k-1);
          end
        else begin // eq[k] < 0
          if Length(fs) > 0  then
            fs := fs + ' - '
          else
            fs := '-';
          fs := fs + FloatToStr(Abs(eq[k])) + ' * x^' + IntToStr(k-1);
          end
      else                               // eq[k] == 0
        ;   // Do nothing !
      end;
    SetNewTermString(fs);
    DataValid := true;
    end
  else
    DataValid := false;
  eq := Nil;
  lgs.Free;
  Result := DataValid;
  end;

procedure TGIPolynomFkt.SetNewTermString(nv: WideString);
  var ov  : WideString;
      nfd : TTBaum;
      n   : Integer;
  begin
  If Not Assigned(FTerm) then
    FTerm := TTBaum.Create(ObjList, Rad);
  FTerm.UnregisterTermParentsIn(Self);
  ov := FTerm.source_str;
  FTerm.BuildTree(nv);
  If FTerm.is_okay then begin
    FTerm.RegisterTermParentsIn(Self);
    FreeAndNil(FDerive1);
    If RecursionAllowed and FTerm.ContainsADescendentOf(Self, n) then
      FDerivable := False
    else begin
      nfd := TTBaum.CreateDerivationOf(FTerm);
      If nfd.is_okay then begin
        FDerive1   := nfd;
        FDerivable := True;
        end
      else begin
        nfd.Free;
        FDerivable := False;
        end;
      end;
    end
  else begin
    FTerm.BuildTree(ov);
    FTerm.RegisterTermParentsIn(Self);
    end;
  IsSpline := Not FTerm.is_random;
  ResetStepCount;
  end;

procedure TGIPolynomFkt.UpdateParams;
  begin
  Points2Polynom;
  if DataValid then
    inherited UpdateParams;
  end;

procedure TGIPolynomFkt.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  var nr : Integer;
  begin
  Inherited LoadContextMenuEntriesInto(menu);
  nr := menu.Items.Count - 2;
  menu.Items.Delete(nr);
  end;

function TGIPolynomFkt.GetParentPointOnSelf(nr: Integer): TGPoint;
  { Liefert den nr-ten Punkt aus der Elternliste, der auf der
    Kurve selbst liegt, oder Nil. Dabei startet nr mit 1.     }
  begin
  if (nr >= 1) and (nr <= parent.Count)  then
    Result := TGeoObj(parent.Items[nr - 1]) as TGPoint
  else
    Result := Nil;
  end;


initialization

  RegisterClass(TGLocLine);
  RegisterClass(TGEnvelopLine);
  RegisterClass(TGFunktion);
  RegisterClass(TGMappedLocLine);
  RegisterClass(TGIntArea);
  RegisterClass(TGRiemannArea);
  RegisterClass(TGIPolynomFkt);

finalization

end.
