unit GeoTransf;

interface

uses Windows, Classes, Menus, Math, MathLib, TBaum, GeoTypes, XMLIntf;

const  mapReflectionLine  =  1;   { Achsenspiegelung             }
       mapReflectionPoint =  2;   { Punktspiegelung              }
       mapTranslation     =  3;   { Verschiebung                 }
       mapRotation        =  4;   { Drehung                      }
       mapCongruency      =  5;   { Allg. Kongruenzabbildung als Verkettung
                                    elementarer Kongruenz-Abbildungen;
                                    noch nicht verwendet !!!     }

       mapDilation        =  7;   { Zentrische Streckung         }
       mapSimilarity      =  8;   { Allg. Ähnlichkeitsabbildung als Verkettung einer
                                    Kongruenzabb. mit einer zentr. Streckung;
                                    noch nicht verwendet !!!     }

       mapSheer           = 10;   { Scherung                     }
       mapOrthAxDilation  = 11;   { Orthogonale axiale Streckung }
       mapSheerReflection = 12;   { Schrägspiegelung             }
       mapAxAffinMapping  = 13;   { Achsenaffinität              }
       mapEulerMapping    = 14;   { Euler'sche Affinität         }
       mapAffRotation     = 15;   { Affine Drehung               }

       mapAffineMap3PP    = 18;   { Allg. Affine Abbildung (3 Pkt-BildPkt-Paare) }
       mapAffineMapMat    = 19;   { Allg. Affine Abbildung (Matrix)              }

       mapInversion       = 20;   { Inversion am Kreis           }

type
    TGTransformation = class(TGeoObj)
      protected
        fType : Integer;    { eine der obigen map*-Konstanten }
        function  DefaultName: WideString; override;
        function  AllParentsAreEqual(GO: TGeoObj): Boolean; virtual;
        function  HasSameDataAs(GO: TGeoObj): Boolean; override;
        function  GetIsReversing: Boolean; virtual;
        procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
        procedure UpdateScreenCoords; override;
        procedure DrawIt; override;
        procedure HideIt; override;
      public
        constructor Create(iObjList: TGeoObjListe; iType: Integer);
        constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
        constructor CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1); override;
        function CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
        function GetMappedPoint(pt: TFloatPoint; var bpt: TFloatPoint): Boolean; virtual; abstract;
        function GetInvMapPoint(pt: TFloatPoint; var bpt: TFloatPoint): Boolean; virtual;
        function GetMappedLine(lineEq : TVector3; var res: TVector3): Boolean; virtual; abstract;
        function GetMappedCircle(circ : TVector3; var res: TVector3): Boolean; virtual; abstract;
        function GetMappedConic(cnc: TCoeff6; var res: TCoeff6): Boolean; virtual; abstract;
        function Dist(xm, ym: Double): Double; override;
        function IsNearMouse: Boolean; override;
        function GetInfo: String; override;
        function GetLinkableInfo: String; virtual;
        procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
        property MapType : Integer read fType;
        property IsReversing : Boolean read GetIsReversing;
      end;

    TGMatrixMap = class(TGTransformation)
      protected
        Mat  : TMatrix32;  { die Transformations-Matrix      }
        detM : Double;     { Determinante der Matrix         }
        procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
        function GetIsReversing: Boolean; override;
        function LoadMatrixFrom3PtPairs(x, y: Array of Double): Boolean;
        function GetMappedVector(uv: TFloatPoint; var mv: TFloatPoint): Boolean;
      public
        constructor Create(iObjList: TGeoObjListe; iType: Integer);
        constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
        procedure AfterLoading(FromXML: Boolean); override;
        function GetMappedPoint(pt: TFloatPoint; var bpt: TFloatPoint): Boolean; override;
        function GetInvMapPoint(pt: TFloatPoint; var bpt: TFloatPoint): Boolean; override;
        function GetMappedLine(lineEq : TVector3; var res: TVector3): Boolean; override;
        function GetMappedCircle(circ : TVector3; var res: TVector3): Boolean; override;
        function GetMappedConic(cnc: TCoeff6; var res: TCoeff6): Boolean; override;
        function  GetMatrixStr(c, r: Integer): String; virtual;
        procedure SetMatrixStr(c, r: Integer; s: String); virtual;
        procedure SaveState; override;
        procedure RestoreState; override;
      end;

    TGSimiliarity = class(TGMatrixMap)
      protected
        function GetIsReversing: Boolean; override;
      public
        constructor Create(iObjList: TGeoObjListe; iType: Integer; iRefObj, iMeasureObj: TGeoObj);
        function  GetMappedCircle(circ : TVector3; var res: TVector3): Boolean; override;
        function  IsReverse: Boolean;
        procedure UpdateParams; override;
        function  GetInfo: String; override;
        function  GetLinkableInfo: String; override;
      end;

    TGAffinMapping = class(TGMatrixMap)
      protected
        g1, g2     : TVector3;
        MatStrings : TStringList;
        Terms      : Array[0..2, 0..1] of TTBaum;
        procedure CheckType(px, py: Array of Double);
        function  HasSameDataAs(GO: TGeoObj): Boolean; override;
        function  AllParentsAreEqual(GO: TGeoObj): Boolean; override;
      public
        constructor CreateAxAff   (iObjList: TGeoObjListe; iMapType: Integer;
                                   iAx: TGStraightLine; iP1, iB1: TGPoint);
        constructor CreateEuler   (iObjList: TGeoObjListe;
                                   ig1, ig2: TGStraightLine; iP1, iB1: TGPoint);
        constructor CreateAffRot  (iObjList: TGeoObjListe;
                                   iFP, iP1, iB1, iP2, iB2: TGPoint);
        constructor CreateGen3PP  (iObjList: TGeoObjListe;
                                   iP1, iB1, iP2, iB2, iP3, iB3: TGPoint);
        constructor CreateGenTerms(iObjList: TGeoObjListe;
                                   iT1, iT2, iT3, iT4, iT5, iT6: String);
        constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
        destructor Destroy; override;
        function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
        procedure AfterLoading(FromXML: Boolean); override;
        procedure BecomesChildOf(GO: TGeoObj); override;
        procedure UpdateParams; override;
        function  GetMatrixStr(c, r: Integer): String; override;
        procedure SetMatrixStr(c, r: Integer; s: String); override;
        function GetInfo: String; override;
        function GetLinkableInfo: String; override;
      end;

    TGInversion = class(TGTransformation)
      protected
        invData : TVector3;
        function GetIsReversing: Boolean; override;
        procedure GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer); override;
      public
        constructor Create(iObjList: TGeoObjListe; iCircle: TGeoObj);
        constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
        destructor Destroy; override;
        procedure UpdateParams; override;
        function GetMappedPoint(pt: TFloatPoint; var bpt: TFloatPoint): Boolean; override;
        function GetMappedLine  (lineEq : TVector3; var res: TVector3): Boolean; override;
        function GetMappedCircle(circ : TVector3; var res: TVector3): Boolean; override;
        function GetMappedConic(cnc: TCoeff6; var res: TCoeff6): Boolean; override;
        function GetInfo: String; override;
      end;


function IndexOfTransformationIn(GL: TGeoObjListe; map_type: Integer; PO1, PO2: TGeoObj): Integer;
function ConvertOldMappedObj2NewMappingObj(oldObj: TGeoObj): Boolean;


implementation

uses Declar, GlobVars, Unit_LGS, SysUtils, Utility, GeoMakro;



{---------------------------------------------------------------------}
{ Konvertierungs-Dienst für alte "abgebildete Objekte"                }
{---------------------------------------------------------------------}

function IndexOfTransformationIn(GL: TGeoObjListe; map_type: Integer; PO1, PO2: TGeoObj): Integer;
  var i  : Integer;
  begin
  Result := -1;
  For i := Succ(GL.IndexOf(PO1)) to GL.LastValidObjIndex do
    If (TGeoObj(GL.Items[i]) is TGTransformation) and
       (TGTransformation(GL.Items[i]).MapType = map_type) and
       (TGeoObj(GL.Items[i]).Parent[0] = PO1) and
       (((TGeoObj(GL.Items[i]).Parent.Count = 1) and (PO2 = Nil)) or
        (TGeoObj(GL.Items[i]).Parent[1]  = PO2)) then
      Result := i;
  end;


function ConvertOldMappedObj2NewMappingObj(oldObj: TGeoObj): Boolean;
  { setzt die alten "abgebildeten" Objekte der Version 2.7 um in
    die neuen TGSimiliarity-basierten Objekte der Version 2.8ff. }

  var GeoListe : TGeoObjListe;

  function GetTransformationFromOldObj: TGTransformation;
    var oldMDefO1,             // old mapping defining objects
        oldMDefO2 : TGeoObj;
        map_type,
        map_index,
        ooi       : Integer;
    begin
    map_type  := 0;
    if oldObj.Parent.Count > 1 then
      oldMDefO1 := oldObj.Parent[1]
    else                       // 06.09.07 ergänzt wegen Krisenfall des Punktes,
      oldMDefO1 := oldObj.Parent[0];   // der an sich selbst gespiegelt wird !
    If (oldObj is TGMirrorPt) or (oldObj is TGMirrorLine) or
       (oldObj is TGMirrorLongLine) or (oldObj is TGMirrorCircle) then begin
      If oldMDefO1 is TGStraightLine then
        map_type := mapReflectionLine
      else if oldMDefO1 is TGPoint then
        map_type := mapReflectionPoint
      else if oldMDefO1 is TGCircle then
        map_type := mapInversion;
      end
    else
    if (oldObj is TGMovedPt) or (oldObj is TGMovedLongLine) or
       (oldObj is TGMovedCircle) then
      map_type := mapTranslation
    else
    if (oldObj is TGRotatedPt) or (oldObj is TGRotatedLongLine) or
       (oldObj is TGRotatedCircle) then
      map_type := mapRotation
    else
    if (oldObj is TGStretchedPt) or (oldObj is TGStretchedLongLine) or
       (oldObj is TGStretchedCircle) then
      map_type := mapDilation;

    If map_type > 0 then begin
      If oldObj.Parent.Count > 2 then
        oldMDefO2 := oldObj.Parent[2]
      else
        oldMDefO2 := Nil;
      map_index := IndexOfTransformationIn(GeoListe, map_type,
                                           oldMDefO1, oldMDefO2);
      ooi := GeoListe.IndexOf(oldObj);
      If map_index >= 0 then begin  // Schon vorhanden ?
        Result := TGSimiliarity(GeoListe[map_index]);
        If map_index > ooi then           // Position überprüfen,
          GeoListe.Move(map_index, ooi);  // falls nötig: korrigieren !
        end
      else begin                    // Neu erzeugen und in Liste einfügen !
        If map_type = mapInversion then
          Result := TGInversion.Create(GeoListe, oldMDefO1)
        else
          Result := TGSimiliarity.Create(GeoListe, map_type, oldMDefO1, oldMDefO2);
        GeoListe.Insert(ooi, Result);
        end;
      end
    else
      Result := Nil;
    end;

  procedure Substitute(old, new: TGeoObj);
    { 28.03.06 : Überarbeitet, so dass die Reihenfolge der Einträge in den
                 Eltern-Listen der Kindern von "old" beim Substituieren nicht
      mehr durcheinandergeworfen wird. Außerdem wird die effektive Länge der
      GeoListe an die Zahl der eingefügten Objekte angepasst, indem jetzt
      "GeoListe.LastValidObjIndex" nach jeder Substitution neu gesetzt wird.

      16.10.06 : "GetDataFromOldMappedObj()"-Aufrufe ergänzt, weil das neu-
                 erzeugte Abbildungs-Objekt möglicherweise zunächst noch nicht
      über gültige interne Daten verfügt, z.B. im Fall einer Drehung, die den
      Drehwinkel von einem noch nicht fertig initialisierten Bogen holt.
      (Fehlermeldung von Dietmar Viertel, Datei "schiefer Kreiskegel.geo" }

    var ch   : TGeoObj;   // "ch"ild buffer var
        n, i : Integer;
    begin
    For i := Pred(old.Parent.Count) downTo 0 do
      old.Stops2BeChildOf(old.Parent[i]);
    For i := Pred(old.Children.Count) downTo 0 do begin
      ch := old.Children[i];
      n  := ch.Parent.IndexOf(old);
      If n >= 0 then
        ch.Parent[n] := new
      else
        ch.Parent.Add(new);    // Sollte niemals passieren !!!
      end;
    new.Children.Assign(old.Children); // Alle Kinder übernehmen und ...
    old.Children.Clear;                // ... im alten Objekt löschen

    n := GeoListe.IndexOf(old);
    GeoListe[n] := new;
    new.GetDataFromOldMappedObj(old);  // Siehe oben !
    old.Free;
    end;

  var newMap : TGTransformation;
      newMPt : TGMappedPoint;
      newMLn : TGMappedLine;
      newMCr : TGMappedCircle;
  begin
  Result := True;
  GeoListe := oldObj.ObjList;
  newMap := GetTransformationFromOldObj;
  If newMap <> Nil then begin
    If oldObj is TGPoint then begin
      newMPt := TGMappedPoint.Create(GeoListe, oldObj.Parent[0], newMap, False);
      Substitute(oldObj, newMPt);
      end
    else if oldObj is TGLongLine then begin
      newMLn := TGMappedLine.Create(GeoListe, oldObj.Parent[0], newMap, False);
      Substitute(oldObj, newMLn);
      end
    else begin // Fall "oldObj is TGCircle"
      newMCr := TGMappedCircle.Create(GeoListe, oldObj.Parent[0], newMap, False);
      Substitute(oldObj, newMCr);
      end;
    GeoListe.LastValidObjIndex := Pred(GeoListe.Count);
    end
  else
    Result := False;
  end;


{--------------------------------------------------}
{ TGTransformation's method implementations:       }
{--------------------------------------------------}


constructor TGTransformation.Create(iObjList: TGeoObjListe; iType: Integer);
  { *Kein* Aufruf von UpdateParams! Erst nach Registrierung der Eltern!  }
  begin
  Inherited Create(iObjList, False);
  FType := iType;
  end;

constructor TGTransformation.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var s : String;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  if DE.HasAttribute('map_type') then begin
    s := DE.getAttribute('map_type');
    If Length(s) > 0 then
      fType := StrToInt(s);
    end;
  end;

constructor TGTransformation.CreateBlueprintOf(GO: TGeoObj; iGeoNum: Integer = -1);
  begin
  Inherited CreateBlueprintOf(GO, iGeoNum);
  FType := (GO as TGTransformation).fType;
  end;

function TGTransformation.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  Result.setAttribute('map_type', IntToStr(MapType));
  end;

procedure TGTransformation.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  FType := (BluePrint as TGTransformation).fType;
  end;

function TGTransformation.AllParentsAreEqual(GO: TGeoObj): Boolean;
  var i : Integer;
  begin
  Result := Parent.Count = GO.Parent.Count;
  If Result then
    For i := 0 to Pred(Parent.Count) do
      If Parent[i] <> GO.Parent[i] then
        Result := False;
  end;

function TGTransformation.GetIsReversing: Boolean;
  begin
  Result := False;
  end;

function TGTransformation.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (ClassType = GO.ClassType) and
            (MapType = TGTransformation(GO).MapType) and
            AllParentsAreEqual(GO);
  end;

function TGTransformation.GetInvMapPoint(pt: TFloatPoint; var bpt: TFloatPoint): Boolean;
  { Implementiert die Umkehrung für alle involutorischen (also
    selbst-inversen) Abbildungen (Spiegelungen);  alle anderen
    Abbildungen müssen diese Routine selbst implementieren !  }
  begin
  Result := GetMappedPoint(pt, bpt);
  end;

function TGTransformation.DefaultName: WideString;
  begin
  Result := ObjList.GetUniqueName('Abb');
  end;

procedure TGTransformation.UpdateScreenCoords;
  begin
  end;

procedure TGTransformation.DrawIt;
  begin
  end;

procedure TGTransformation.HideIt;
  begin
  end;

function TGTransformation.Dist(xm, ym: Double): Double;
  begin
  Result := 10000;
  end;

function TGTransformation.IsNearMouse: Boolean;
  begin
  Result := False;
  end;

function TGTransformation.GetInfo;
  begin
  Result := '';
  end;

function TGTransformation.GetLinkableInfo: String;
  var s : String;
      n : Integer;
  begin
  s := GetInfo;
  if Length(s) > 0 then begin
    n := Pos('ist eine', s);
    Delete(s, 1, n + 8);
    end;
  Result := s;
  end;

procedure TGTransformation.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  end;


{--------------------------------------------------}
{ TGMatrixMap's method implementations:            }
{--------------------------------------------------}

constructor TGMatrixMap.Create(iObjList: TGeoObjListe; iType: Integer);
  { Kein Aufruf von UpdateParams! Erst nach Registrierung der Eltern! }
  begin
  Inherited Create(iObjList, iType);
  Mat[0,0] := 1; Mat[1,0] := 0; Mat[2,0] := 0;
  Mat[0,1] := 0; Mat[1,1] := 1; Mat[2,1] := 0;
  end;

procedure TGMatrixMap.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  Mat[0,0] := 1; Mat[1,0] := 0; Mat[2,0] := 0;
  Mat[0,1] := 0; Mat[1,1] := 1; Mat[2,1] := 0;
  detM := 1;
  end;

constructor TGMatrixMap.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  Mat[0,0] := 1; Mat[1,0] := 0; Mat[2,0] := 0;
  Mat[0,1] := 0; Mat[1,1] := 1; Mat[2,1] := 0;
  end;

procedure TGMatrixMap.AfterLoading(FromXML: Boolean);
  begin
  Inherited AfterLoading(FromXML);
  detM := Mat[0,0]*Mat[1,1] - Mat[0,1]*Mat[1,0];
  end;

function TGMatrixMap.GetIsReversing: Boolean;
  begin
  Result := detM < 0;
  end;

function TGMatrixMap.LoadMatrixFrom3PtPairs(x, y: Array of Double): Boolean;
  var LGS : TLGS;
      eq  : TEquation;
      i   : Integer;
  begin
  Result := False;
  LGS := TLGS.Create(3, 3);
  SetLength(eq, 4);
  For i := 0 to 2 do begin
    eq[0] := x[2*i + 1];  // TGPoint(Parent[2*i]).X;
    eq[1] := x[2*i    ];  // TGPoint(Parent[2*i - 1]).X;
    eq[2] := y[2*i    ];  // TGPoint(Parent[2*i - 1]).Y;
    eq[3] := 1;
    LGS.SetEquation(i+1, eq);
    end;
  LGS.Diagonalize;
  LGS.GetEquation(0, eq);
  If Round(eq[0]) = 1 then begin  // Erstes LGS eindeutig lösbar
    Mat[0,0] := eq[1];
    Mat[1,0] := eq[2];
    Mat[2,0] := eq[3];
    For i := 0 to 2 do begin
      eq[0] := y[2*i + 1];  // TGPoint(Parent[2*i]).Y;
      eq[1] := x[2*i    ];  // TGPoint(Parent[2*i - 1]).X;
      eq[2] := y[2*i    ];  // TGPoint(Parent[2*i - 1]).Y;
      eq[3] := 1;
      LGS.SetEquation(i+1, eq);
      end;
    LGS.Diagonalize;
    LGS.GetEquation(0, eq);
    If Round(eq[0]) = 1 then begin  // Zweites LGS eindeutig lösbar
      Mat[0,1] := eq[1];
      Mat[1,1] := eq[2];
      Mat[2,1] := eq[3];
      detM   := Mat[0,0]*Mat[1,1] - Mat[0,1]*Mat[1,0];
      Result := True;    // Auch im Fall detM = 0 !
      end;
    end;
  eq := Nil;
  LGS.Free;
  end;

function TGMatrixMap.GetMappedVector(uv: TFloatPoint; var mv: TFloatPoint): Boolean;
  begin
  If DataValid then begin
    mv.x := Mat[0,0] * uv.x + Mat[1,0] * uv.y;
    mv.y := Mat[0,1] * uv.x + Mat[1,1] * uv.y;
    Result := True;
    end
  else
    Result := False;
  end;


function TGMatrixMap.GetMappedPoint(pt: TFloatPoint; var bpt: TFloatPoint): Boolean;
  begin
  If DataValid then begin
    bpt.x := Mat[0,0] * pt.x + Mat[1,0] * pt.y + Mat[2, 0];
    bpt.y := Mat[0,1] * pt.x + Mat[1,1] * pt.y + Mat[2, 1];
    Result := True;
    end
  else
    Result := False;
  end;


function TGMatrixMap.GetInvMapPoint(pt: TFloatPoint; var bpt: TFloatPoint): Boolean;
  { Liefert das Urbild bpt eines Punktes pt bei einer durch eine Matrix
    gegebenen Abbildung, also das Bild von pt unter der inversen Abbildung   }
  begin
  If DataValid and (Abs(detM) > epsilon) then begin
    pt.x := pt.x - Mat[2, 0];
    pt.y := pt.y - Mat[2, 1];
    bpt.x := ( Mat[1,1] * pt.x - Mat[1,0] * pt.y) / detM;
    bpt.y := (-Mat[0,1] * pt.x + Mat[0,0] * pt.y) / detM;
    Result := True;
    end
  else
    Result := False;
  end;

function TGMatrixMap.GetMappedLine(lineEq : TVector3; var res: TVector3): Boolean;
  var p, q, dir : TFloatPoint;
  begin
  Result := GetPedalPoint(lineEq, 0, 0, p.x, p.y) and GetMappedPoint(p, q) and
            GetNormalizedDirFromHesseEq(lineEq, p) and GetMappedVector(p, dir) and
            GetHesseEqFromPtAndDir(q.x, q.y, dir.x, dir.y, res);
  end;


function TGMatrixMap.GetMappedCircle(circ : TVector3; var res: TVector3): Boolean;
  { Gibt immer False zurück, weil das affine Bild eines Kreises i.A.
    kein Kreis mehr ist. Stattdessen muss für Bilder von Kreisen
    GetMappedConic benutzt werden!                                   }
  begin
  Result := False;
  end;


function TGMatrixMap.GetMappedConic(cnc: TCoeff6; var res: TCoeff6): Boolean;
  var m, n : Double;
      UMat : TMatrix32;  // Pufferspeicher für die Umkehrabbildung
  begin
  If DataValid and (Abs(detM) > epsilon) then begin
    UMat[0,0] :=  Mat[1,1]/detM;
    UMat[1,0] := -Mat[1,0]/detM;
    UMat[0,1] := -Mat[0,1]/detM;
    UMat[1,1] :=  Mat[0,0]/detM;
    UMat[2,0] := -UMat[0,0]*Mat[2,0] - UMat[1,0]*Mat[2,1];
    UMat[2,1] := -UMat[0,1]*Mat[2,0] - UMat[1,1]*Mat[2,1];

    res[0] := cnc[0]*Sqr(UMat[0,0]) + 2*cnc[1]*UMat[0,0]*UMat[0,1] + cnc[2]*Sqr(UMat[0,1]);
    res[1] := cnc[0]*UMat[0,0]*UMat[1,0] + cnc[1]*(UMat[0,0]*UMat[1,1] + UMat[1,0]*UMat[0,1]) +
              cnc[2]*UMat[0,1]*UMat[1,1];
    res[2] := cnc[0]*Sqr(UMat[1,0]) + 2*cnc[1]*UMat[1,0]*UMat[1,1] + cnc[2]*Sqr(UMat[1,1]);
    m := cnc[0]*UMat[2,0] + cnc[1]*UMat[2,1] + cnc[3];
    n := cnc[1]*UMat[2,0] + cnc[2]*UMat[2,1] + cnc[4];
    res[3] := m*UMat[0,0] + n*UMat[0,1];
    res[4] := m*UMat[1,0] + n*UMat[1,1];
    res[5] := cnc[0]*Sqr(UMat[2,0]) + 2*cnc[1]*UMat[2,0]*UMat[2,1] +
              cnc[2]*Sqr(UMat[2,1]) + 2*(cnc[3]*UMat[2,0] + cnc[4]*UMat[2,1]) + cnc[5];
    Result := True;
    end
  else
    Result := False;
  end;

function  TGMatrixMap.GetMatrixStr(c, r: Integer): String;
  begin
  Result := FloatToStrF(Mat[c, r], ffFixed, 10, 4);
  end;

procedure TGMatrixMap.SetMatrixStr(c, r: Integer; s: String);
  var oldVal, newVal : Double;
  begin
  oldVal := Mat[c, r];
  try
    newVal := StrToFloat(s);
    Mat[c, r] := newVal;
  except
    Mat[c, r] := oldVal;
  end; { of try }
  end;

procedure TGMatrixMap.SaveState;
  begin
  Inherited SaveState;
  Old_Data.push(@Mat, SizeOf(Mat));
  Old_Data.push(@detM, SizeOf(detM));
  end;

procedure TGMatrixMap.RestoreState;
  begin
  Old_Data.pop(@detM);
  Old_Data.pop(@Mat);
  Inherited RestoreState;
  end;


{--------------------------------------------------}
{ TGSimiliarity's method implementations:          }
{--------------------------------------------------}

constructor TGSimiliarity.Create(iObjList: TGeoObjListe; iType: Integer; iRefObj, iMeasureObj: TGeoObj);
  begin
  Inherited Create(iObjList, iType);
  BecomesChildOf(iRefObj);
  If iMeasureObj <> Nil then
    BecomesChildOf(iMeasureObj);
  If MapType in [mapReflectionLine..mapDilation] then
    UpdateParams;
  end;


procedure TGSimiliarity.UpdateParams;
  var p, q      : TFloatPointList;
      dir       : TFloatPoint;
      f, sf, cf : Extended;
      i         : Integer;
  begin
  DataValid := True;
  For i := 0 to Pred(Parent.Count) do
    If Not TGeoObj(Parent[i]).DataValid then
      DataValid := False;
  If DataValid then begin
    SetLength(p, 3);
    SetLength(q, 3);
    Case MapType of
      mapReflectionLine   : begin
                            With TGStraightLine(Parent[0]) do begin
                              dir    := GetNormalizedDirection;
                              p[0].x := X1;  p[0].y := Y1;
                              end;
                            q[0]   := p[0];
                            p[1].x := p[0].x + dir.x; p[1].y := p[0].y + dir.y;
                            q[1]   := p[1];
                            p[2].x := p[0].x - dir.y; p[2].y := p[0].y + dir.x;
                            q[2].x := p[0].x + dir.y; q[2].y := p[0].y - dir.x;
                            DataValid := GetAffineMapFromPts(p, q, Mat);
                            end;
      mapReflectionPoint  : begin
                            With TGeoObj(Parent[0]) do begin
                              p[0].x := GetValue(gv_x);
                              p[0].y := GetValue(gv_y);
                              end;
                            q[0]   := p[0];
                            p[1].x := p[0].x + 1; p[1].y := p[0].y;
                            q[1].x := p[0].x - 1; q[1].y := p[0].y;
                            p[2].x := p[0].x;     p[2].y := p[0].y + 1;
                            q[2].x := p[0].x;     q[2].y := p[0].y - 1;
                            DataValid := GetAffineMapFromPts(p, q, Mat);
                            end;
      mapTranslation      : With TGeoObj(Parent[0]) do begin
                              Mat[2,0] := GetValue(gv_x);
                              Mat[2,1] := GetValue(gv_y);
                              end;
      mapRotation         : begin
                            With TGPoint(Parent[0]) do begin
                              p[0].X := GetValue(gv_x);
                              p[0].Y := GetValue(gv_y);
                              end;
                            f := TGeoObj(Parent[1]).GetValue(gv_val);
                            SinCos(f, sf, cf);
                            q[0]   := p[0];
                            p[1].x := p[0].x + 1;   p[1].y := p[0].y;
                            q[1].x := p[0].x + cf;  q[1].y := p[0].y + sf;
                            p[2].x := p[0].x;       p[2].y := p[0].y + 1;
                            q[2].x := p[0].x - sf;  q[2].y := p[0].y + cf;
                            DataValid := GetAffineMapFromPts(p, q, Mat);
                            end;
      mapDilation         : begin
                            With TGPoint(Parent[0]) do begin
                              p[0].x := GetValue(gv_x);
                              p[0].y := GetValue(gv_y);
                              end;
                            f := TGeoObj(Parent[1]).GetValue(gv_val);
                            q[0]   := p[0];
                            p[1].x := p[0].x + 1;  p[1].y := p[0].y;
                            q[1].x := p[0].x + f;  q[1].y := p[0].y;
                            p[2].x := p[0].x;      p[2].y := p[0].y + 1;
                            q[2].x := p[0].x;      q[2].y := p[0].y + f;
                            DataValid := GetAffineMapFromPts(p, q, Mat);
                            p := Nil;
                            q := Nil;
                            end;
    end; { of case }
    detM := Mat[0,0]*Mat[1,1] - Mat[0,1]*Mat[1,0];
    p := Nil;
    q := Nil;
    end;
  end;

function TGSimiliarity.GetMappedCircle(circ : TVector3; var res: TVector3): Boolean;
  var p, q : TFloatPoint;
  begin
  p.x := circ.X;  p.y := circ.Y;
  If GetMappedPoint(p, q) then begin
    res.X := q.x;
    res.Y := q.y;
    res.Z := circ.Z;
    If MapType = mapDilation then         // Nur bei Zentrischer Streckung:
      res.Z := res.Z * Abs(Mat[0,0]);     //   Radius korrigieren !
    res.tag := circ.tag;                  // Datentyp stabil halten
    Result  := True;
    end
  else
    Result := False;
  end;

function TGSimiliarity.GetIsReversing: Boolean;
  begin
  Result := MapType = mapReflectionLine;
  end;

function TGSimiliarity.IsReverse: Boolean;
  begin
  Result := (MapType = mapRotation) and
            (TGeoObj(Parent[1]).GetValue(gv_val) < 0);
  end;

function TGSimiliarity.GetInfo: String;
  var vs : String;
  begin
  Case MapType of
    mapReflectionLine  : Result := MyObjTxt[48];
    mapReflectionPoint : Result := MyObjTxt[49];
    mapTranslation     : Result := MyObjTxt[51];
    mapRotation : begin
                  vs := Float2Str(grad(TGeoObj(Parent[1]).GetValue(gv_val)), 3);
                  Result := Format(MyObjTxt[50], [vs]);
                  end;
    mapDilation : begin
                  vs := Float2Str(TGeoObj(Parent[1]).GetValue(gv_val), 3);
                  Result := Format(MyObjTxt[56], [vs]);
                  end;
  end; { of case }
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  end;

function TGSimiliarity.GetLinkableInfo: String;
  begin
  If MapType = mapDilation then begin
    Result := Format(MyObjTxt[57], [Float2Str(TGeoObj(Parent[1]).GetValue(gv_val), 3)]);
    InsertNameOf(TGeoObj(Parent[0]), Result);
    end
  else
    Result := Inherited GetLinkableInfo;
  end;


{--------------------------------------------------}
{ TGAffinMapping's method implementations:          }
{--------------------------------------------------}

constructor TGAffinMapping.CreateAxAff(iObjList: TGeoObjListe; iMapType: Integer;
                                      iAx: TGStraightLine; iP1, iB1: TGPoint);
  begin
  Inherited Create(iObjList, iMapType);
  BecomesChildOf(iAx);
  BecomesChildOf(iP1);
  BecomesChildOf(iB1);
  UpdateParams;
  end;

constructor TGAffinMapping.CreateEuler(iObjList: TGeoObjListe;
                                      ig1, ig2: TGStraightLine;
                                      iP1, iB1: TGPoint);
  begin
  Inherited Create(iObjList, mapEulerMapping);
  BecomesChildOf(ig1);
  BecomesChildOf(ig2);
  BecomesChildOf(iP1);
  BecomesChildOf(iB1);
  g1 := TVector3.Create(0, 0, 0);
  g2 := TVector3.Create(0, 0, 0);
  UpdateParams;
  end;

constructor TGAffinMapping.CreateAffRot(iObjList: TGeoObjListe;
                                       iFP, iP1, iB1, iP2, iB2: TGPoint);
  begin
  Inherited Create(iObjList, mapAffRotation);
  Parent.DuplicatesAllowed := True;
  BecomesChildOf(iFP);
  BecomesChildOf(iP1);
  BecomesChildOf(iB1);
  BecomesChildOf(iP2);
  BecomesChildOf(iB2);
  UpdateParams;
  end;

constructor TGAffinMapping.CreateGen3PP(iObjList: TGeoObjListe;
                                       iP1, iB1, iP2, iB2, iP3, iB3: TGPoint);
  begin
  Inherited Create(iObjList, mapAffineMap3PP);
  Parent.DuplicatesAllowed := True;
  BecomesChildOf(iP1);
  BecomesChildOf(iB1);
  BecomesChildOf(iP2);
  BecomesChildOf(iB2);
  BecomesChildOf(iP3);
  BecomesChildOf(iB3);
  UpdateParams;
  end;

constructor TGAffinMapping.CreateGenTerms(iObjList: TGeoObjListe;
                                         iT1, iT2, iT3, iT4, iT5, iT6: String);
  { Die Terme werden in der Reihenfolge von Spalten-Vektoren übergeben:
              x' = ( T1 ) * x  + ( T3 ) * y  + ( T5 );
              y' = ( T2 ) * x  + ( T4 ) * y  + ( T6 );                  }
  var i, j : Integer;
  begin
  Inherited Create(iObjList, mapAffineMapMat);
  For i := 0 to 2 do
    For j := 0 to 1 do
      Terms[i,j] := TTBaum.Create(ObjList, Rad);
  Terms[0,0].BuildTree(iT1);  Terms[0,0].RegisterTermParentsIn(Self);
  Terms[1,0].BuildTree(iT3);  Terms[1,0].RegisterTermParentsIn(Self);
  Terms[2,0].BuildTree(iT5);  Terms[2,0].RegisterTermParentsIn(Self);
  Terms[0,1].BuildTree(iT2);  Terms[0,1].RegisterTermParentsIn(Self);
  Terms[1,1].BuildTree(iT4);  Terms[1,1].RegisterTermParentsIn(Self);
  Terms[2,1].BuildTree(iT6);  Terms[2,1].RegisterTermParentsIn(Self);
  UpdateParams;
  end;

constructor TGAffinMapping.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var domMat, domPList : IXMLNode;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  Case MapType of
    mapEulerMapping: begin
            g1 := TVector3.Create(0, 0, 0);
            g2 := TVector3.Create(0, 0, 0);
            end;
    mapAffineMapMat: begin
            domMat := DE.childNodes.findNode('matrix', '');
            MatStrings := TStringList.Create;
            MatStrings.Add(domMat.getAttribute('a11'));
            MatStrings.Add(domMat.getAttribute('a12'));
            MatStrings.Add(domMat.getAttribute('a21'));
            MatStrings.Add(domMat.getAttribute('a22'));
            MatStrings.Add(domMat.getAttribute('a31'));
            MatStrings.Add(domMat.getAttribute('a32'));
            end;
    mapAffRotation,
    mapAffineMap3PP: begin               { Eltern neu einlesen wegen         }
            Parent.Clear;                {   eventueller Mehrfach-Nennungen! }
            Parent.DuplicatesAllowed := True;
            domPList := DE.childNodes.findNode('parents', '');
            If domPList <> Nil then
              Parent.SetGeoNumString(domPList.NodeValue);
            end;
  end; { of case }
  end;

destructor TGAffinMapping.Destroy;
  var i, j : Integer;
  begin
  FreeAndNil(g1);
  FreeAndNil(g2);
  if Assigned(MatStrings) then begin
    while MatStrings.Count > 0 do
      MatStrings.Delete(0);
    FreeAndNil(MatStrings);
    end;
  For i := 0 to 2 do
    For j := 0 to 1 do
      FreeAndNil(Terms[i,j]);
  Inherited Destroy;
  end;

function TGAffinMapping.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var DOMmat : IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  If MapType = mapAffineMapMat then begin
    DOMmat := DOMDoc.createNode('matrix');
    DOMmat.setAttribute('a11', Terms[0,0].source_str);
    DOMmat.setAttribute('a12', Terms[0,1].source_str);
    DOMmat.setAttribute('a21', Terms[1,0].source_str);
    DOMmat.setAttribute('a22', Terms[1,1].source_str);
    DOMmat.setAttribute('a31', Terms[2,0].source_str);
    DOMmat.setAttribute('a32', Terms[2,1].source_str);
    Result.childNodes.add(DOMmat);
    end;
  end;

procedure TGAffinMapping.AfterLoading(FromXML: Boolean);
  var i, j : Integer;
  begin
  Inherited AfterLoading(FromXML);
  If MapType = mapAffineMapMat then begin
    For i := 0 to 2 do
      For j := 0 to 1 do
        Terms[i,j] := TTBaum.Create(ObjList, Rad);
    Terms[0,0].BuildTree(MatStrings[0]);
    Terms[0,1].BuildTree(MatStrings[1]);
    Terms[1,0].BuildTree(MatStrings[2]);
    Terms[1,1].BuildTree(MatStrings[3]);
    Terms[2,0].BuildTree(MatStrings[4]);
    Terms[2,1].BuildTree(MatStrings[5]);
    For i := 0 to 2 do
      For j := 0 to 1 do begin
        Terms[i,j].RegisterTermParentsIn(Self);
        Terms[i,j].Calculate(0, Mat[i, j]);
        end;
    end;
  Inherited AfterLoading(FromXML);  
  end;

procedure TGAffinMapping.BecomesChildOf(GO: TGeoObj);
  { Lässt Mehrfach-Einträge in der Elternliste zu, weil bei affinen
    Abbildungen nicht alle Eltern stets paarweise voneinander ver-
    schieden sein müssen. In der "Children"-Liste des Elters wird
    jedoch immer nur *ein* Eintrag gemacht!                         }
  begin
  If GO <> Nil then begin   { Falls es kein Eltern-Objekt gibt: raus!          }
    If (Parent.IndexOf(GO) < 0) then { falls "GO" schon permanenter Elter ist: }
      GO.Children.Add(Self);         {  kein mehrfacher Eintrag in "Children"  }
    Parent.Add(GO);         { Aber: Mehrfacheintrag in eigener "Parent"-Liste  }
    end;
  end;


function TGAffinMapping.HasSameDataAs(GO: TGeoObj): Boolean;

  function AllMatrixTermsAreEqual: Boolean;
    var i, j : Integer;
    begin
    Result := True;
    For i := 0 to 2 do
      For j := 0 to 1 do
        If Not (GO as TGAffinMapping).Terms[i, j].HasSameDataAs(Terms[i, j]) then
          Result := False;
    end;

  begin
  Result := Inherited HasSameDataAs(GO);
  If Result and (MapType = mapAffineMapMat) then
    Result := AllMatrixTermsAreEqual;
  end;


function TGAffinMapping.AllParentsAreEqual(GO: TGeoObj): Boolean;
  { ermöglicht den korrekten Vergleich der Elternlisten unter Berücksich-
    tigung der möglichen Vertauschbarkeit einzelner Punkt-Bildpunkt-Paare }
  begin
  Result := (Parent.Count = GO.Parent.Count);
  If Result then
    Case MapType of
      mapEulerMapping  : Result :=
        (Parent[2] = GO.Parent[2]) and
        (Parent[3] = GO.Parent[3]) and
        (((Parent[0] = GO.Parent[0]) and (Parent[1] = GO.Parent[1])) or
         ((Parent[0] = GO.Parent[1]) and (Parent[1] = GO.Parent[0])));
      mapAffRotation   : Result :=
        (Parent[0] = GO.Parent[0]) and
        (((Parent[1] = GO.Parent[1]) and (Parent[2] = GO.Parent[2])) or
         ((Parent[1] = GO.Parent[3]) and (Parent[2] = GO.Parent[4]))) and
        (((Parent[3] = GO.Parent[3]) and (Parent[4] = GO.Parent[4])) or
         ((Parent[3] = GO.Parent[1]) and (Parent[4] = GO.Parent[2])));
      mapAffineMap3PP : Result :=
        (((Parent[0] = GO.Parent[0]) and (Parent[1] = GO.Parent[1])) or
         ((Parent[0] = GO.Parent[2]) and (Parent[1] = GO.Parent[3])) or
         ((Parent[0] = GO.Parent[4]) and (Parent[1] = GO.Parent[5]))) and
        (((Parent[2] = GO.Parent[0]) and (Parent[3] = GO.Parent[1])) or
         ((Parent[2] = GO.Parent[2]) and (Parent[3] = GO.Parent[3])) or
         ((Parent[2] = GO.Parent[4]) and (Parent[3] = GO.Parent[5]))) and
        (((Parent[4] = GO.Parent[0]) and (Parent[5] = GO.Parent[1])) or
         ((Parent[4] = GO.Parent[2]) and (Parent[5] = GO.Parent[3])) or
         ((Parent[4] = GO.Parent[4]) and (Parent[5] = GO.Parent[5])));
    else
      Result := Inherited AllParentsAreEqual(GO);
    end; { of case }
  end;

procedure TGAffinMapping.CheckType(px, py: Array of Double);
  { Diese Prozedur versucht für Achsen-Affinitäten den möglichst genauen
    Typ der Abbildung aus den Punkt-Bildpunkt-Paaren zu ermitteln. Stimmt
    der aktuelle Typ nicht mit den Daten überein, wird er verändert und
    eine entsprechende Botschaft ans Hauptfenster gesendet, damit dort
    die Abbildungsmenüs an die veränderte Lage angepasst werden können. }
  var OldMapType : Integer;
      d1, d2, dm : Double;
  begin
  OldMapType := MapType;
  Case MapType of
    mapSheer,
    mapSheerReflection:
             begin
             d1 := DistPt2Line(px[0], py[0], px[2], py[2], px[4], py[4]);
             d2 := DistPt2Line(px[0], py[0], px[2], py[2], px[5], py[5]);
             If Abs(d1 - d2) > DistEpsilon then
               fType := mapAxAffinMapping;
             end;
    mapOrthAxDilation:
             begin
             If abs((px[2] - px[0]) * (px[5] - px[4]) +
                    (py[2] - py[0]) * (py[5] - py[4])) > DistEpsilon then
               fType := mapAxAffinMapping;
             end;
    mapAxAffinMapping:
             begin
             d1 := DistPt2Line(px[0], py[0], px[2], py[2], px[4], py[4]);
             d2 := DistPt2Line(px[0], py[0], px[2], py[2], px[5], py[5]);
             dm := DistPt2Line(px[0], py[0], px[2], py[2],
                               (px[4] + px[5]) / 2, (py[4] + py[5]) / 2);
             If Abs(dm) < DistEpsilon then
               fType := mapSheerReflection
             else if Abs(d2 - d1) < DistEpsilon then
               fType := mapSheer
             else if abs((px[2] - px[0]) * (px[5] - px[4]) +
                         (py[2] - py[0]) * (py[5] - py[4])) < DistEpsilon then
               fType := mapOrthAxDilation;
             end;
  end; { of case }
  If MapType <> OldMapType then
    PostMessage(ObjList.HostWinHandle, cmd_ExternCommand,
                cmd_MappingChanged, 0);
  end;

procedure TGAffinMapping.UpdateParams;
  var px, py : Array [0..5] of Double;
        { Punkt-Bildpunkt-Paare:  p[0] => p[1]; p[2] => p[3];  p[4] => p[5] }
      a      : TGStraightLine;
      ok     : Boolean;
      i, j   : Integer;
  begin
  DataValid := True;
  For i := 0 to Pred(Parent.Count) do
    If Not TGeoObj(Parent[i]).DataValid then
      DataValid := False;
  If DataValid then begin
    Case MapType of
      mapSheer..
      mapAxAffinMapping  : begin
                           a := TGStraightLine(Parent[0]);
                           a.GetCoordsFromParam(-2, px[0], py[0]);
                           px[1] := px[0]; py[1] := py[0];
                           a.GetCoordsFromParam( 2, px[2], py[2]);
                           px[3] := px[2]; py[3] := py[2];
                           For i := 1 to 2 do begin
                             px[i+3] := TGPoint(Parent[i]).X;
                             py[i+3] := TGPoint(Parent[i]).Y;
                             end;
                           CheckType(px, py);
                           end;
      mapEulerMapping    : begin
                           TGStraightLine(Parent[0]).GetDataVector(g1);
                           TGStraightLine(Parent[1]).GetDataVector(g2);
                           IntersectLines(g1, g2, px[0], py[0], ok);
                           If ok then begin
                             px[1] := px[0];  py[1] := py[0];
                             DataValid :=
                               GetProjPoints(g1, g2, TGPoint(Parent[2]).X, TGPoint(Parent[2]).Y,
                                             px[2], py[2], px[4], py[4]) and
                               GetProjPoints(g1, g2, TGPoint(Parent[3]).X, TGPoint(Parent[3]).Y,
                                             px[3], py[3], px[5], py[5]);
                             end
                           else
                             DataValid := False;
                           end;
      mapAffRotation     : begin
                           px[0] := TGPoint(Parent[0]).X;
                           py[0] := TGPoint(Parent[0]).Y;
                           px[1] := px[0]; py[1] := py[0];
                           For i := 1 to 4 do begin
                             px[i+1] := TGPoint(Parent[i]).X;
                             py[i+1] := TGPoint(Parent[i]).Y;
                             end;
                           end;
      mapAffineMap3PP    : For i := 0 to 5 do begin
                             px[i] := TGPoint(Parent[i]).X;
                             py[i] := TGPoint(Parent[i]).Y;
                             end;
      mapAffineMapMat    : begin
                           For i := 0 to 2 do
                             For j := 0 to 1 do begin
                               Terms[i,j].Calculate(0, Mat[i,j]);
                               If Not Terms[i,j].is_okay then
                                 DataValid := False;
                               end;
                           detM := Mat[0,0]*Mat[1,1] - Mat[1,0]*Mat[0,1];
                           end;
    end;
    If DataValid and (MapType <> mapAffineMapMat) then
      DataValid := LoadMatrixFrom3PtPairs(px, py);
    end;
  end;

function  TGAffinMapping.GetMatrixStr(c, r: Integer): String;
  begin
  If Terms[c, r] <> Nil then
    Result := Terms[c, r].source_str
  else
    Result := FloatToStr(Mat[c, r]);
  end;

procedure TGAffinMapping.SetMatrixStr(c, r: Integer; s: String);
  begin
  If Terms[c, r] <> Nil then
    Terms[c, r].UnregisterTermParentsIn(Self)
  else
    Terms[c, r] := TTBaum.Create(Self.ObjList, Rad);
  Terms[c, r].BuildTree(s);
  Terms[c, r].RegisterTermParentsIn(Self);
  Terms[c, r].Calculate(0, Mat[c, r]);
  end;

function TGAffinMapping.GetInfo: String;
  begin
  Case MapType of
    mapSheer          : begin
                        Result := MyObjTxt[83];
                        InsertNameOf(Self, Result);
                        InsertNameOf(TGeoObj(Parent[0]), Result);
                        InsertNameOf(TGeoObj(Parent[1]), Result);
                        InsertNameOf(TGeoObj(Parent[2]), Result);
                        end;
    mapOrthAxDilation : begin
                        Result := MyObjTxt[84];
                        InsertNameOf(Self, Result);
                        InsertNameOf(TGeoObj(Parent[0]), Result);
                        InsertNameOf(TGeoObj(Parent[1]), Result);
                        InsertNameOf(TGeoObj(Parent[2]), Result);
                        end;
    mapSheerReflection: begin
                        Result := MyObjTxt[86];
                        InsertNameOf(Self, Result);
                        InsertNameOf(TGeoObj(Parent[0]), Result);
                        InsertNameOf(TGeoObj(Parent[1]), Result);
                        InsertNameOf(TGeoObj(Parent[2]), Result);
                        end;
    mapAxAffinMapping : begin
                        Result := MyObjTxt[87];
                        InsertNameOf(Self, Result);
                        InsertNameOf(TGeoObj(Parent[0]), Result);
                        InsertNameOf(TGeoObj(Parent[1]), Result);
                        InsertNameOf(TGeoObj(Parent[2]), Result);
                        end;
    mapEulerMapping   : begin
                        Result := MyObjTxt[89];
                        InsertNameOf(Self, Result);
                        InsertNameOf(TGeoObj(Parent[0]), Result);
                        InsertNameOf(TGeoObj(Parent[1]), Result);
                        InsertNameOf(TGeoObj(Parent[2]), Result);
                        InsertNameOf(TGeoObj(Parent[3]), Result);
                        end;
    mapAffRotation    : begin
                        Result := MyObjTxt[90];
                        InsertNameOf(Self, Result);
                        InsertNameOf(TGeoObj(Parent[0]), Result);
                        InsertNameOf(TGeoObj(Parent[1]), Result);
                        InsertNameOf(TGeoObj(Parent[2]), Result);
                        InsertNameOf(TGeoObj(Parent[3]), Result);
                        InsertNameOf(TGeoObj(Parent[4]), Result);
                        end;
    mapAffineMap3PP   : begin
                        Result := MyObjTxt[76];
                        InsertNameOf(Self, Result);
                        InsertNameOf(TGeoObj(Parent[0]), Result);
                        InsertNameOf(TGeoObj(Parent[2]), Result);
                        InsertNameOf(TGeoObj(Parent[4]), Result);
                        InsertNameOf(TGeoObj(Parent[1]), Result);
                        InsertNameOf(TGeoObj(Parent[3]), Result);
                        InsertNameOf(TGeoObj(Parent[5]), Result);
                        end;
    mapAffineMapMat   : begin
                        Result := MyObjTxt[78];
                        InsertNameOf(Self, Result);
                        end;

  else
    Result := '';
  end;  { of case }
  end;

function TGAffinMapping.GetLinkableInfo: String;
  begin
  Case MapType of
    mapOrthAxDilation : begin
                        Result := MyObjTxt[85];
                        InsertNameOf(TGeoObj(Parent[0]), Result);
                        InsertNameOf(TGeoObj(Parent[1]), Result);
                        InsertNameOf(TGeoObj(Parent[2]), Result);
                        end;
    mapAxAffinMapping : begin
                        Result := MyObjTxt[88];
                        InsertNameOf(TGeoObj(Parent[0]), Result);
                        InsertNameOf(TGeoObj(Parent[1]), Result);
                        InsertNameOf(TGeoObj(Parent[2]), Result);
                        end;
    mapAffineMap3PP   : begin
                        Result := MyObjTxt[77];
                        InsertNameOf(TGeoObj(Parent[0]), Result);
                        InsertNameOf(TGeoObj(Parent[2]), Result);
                        InsertNameOf(TGeoObj(Parent[4]), Result);
                        InsertNameOf(TGeoObj(Parent[1]), Result);
                        InsertNameOf(TGeoObj(Parent[3]), Result);
                        InsertNameOf(TGeoObj(Parent[5]), Result);
                        end;
    mapAffineMapMat   : begin
                        Result := MyObjTxt[79];
                        end;
  else
    Result := Inherited GetLinkableInfo;
  end; { of case }
  end;


{--------------------------------------------------}
{ TGInversion's method implementations:            }
{--------------------------------------------------}

{ Wird ein Kreis mit Mittelpunkt (mx, my) und Radius r
  in einer TVector3-Variablen invData gespeichert, dann so:
           (invData.X, invData.Y, invData.Z) = (mx, my, r)              }

constructor TGInversion.Create(iObjList: TGeoObjListe; iCircle: TGeoObj);
  begin
  Inherited Create(iObjList, mapInversion);
  BecomesChildOf(iCircle);
  invData := TVector3.Create(0, 0, 0);
  UpdateParams;
  end;

constructor TGInversion.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  begin
  Inherited CreateFromDomData(iObjList, DE);
  fType := mapInversion;
  invData := TVector3.Create(0, 0, 0);
  end;

destructor TGInversion.Destroy;
  begin
  invData.Free;
  Inherited Destroy;
  end;

function TGInversion.GetIsReversing: Boolean;
  begin
  Result := True;
  end;

procedure TGInversion.GetSpecialDataFrom(BluePrint: TGeoObj; MakNum: Integer);
  begin
  Inherited GetSpecialDataFrom(BluePrint, MakNum);
  invData := TVector3.Create(0, 0, 0);
  end;

procedure TGInversion.UpdateParams;
  begin
  If TGeoObj(Parent[0]).DataValid then begin
    DataValid := True;
    With TGCircle(Parent[0]) do begin
      invData.X := X1;
      invData.Y := Y1;
      invData.Z := Radius;
      end;
    end
  else
    DataValid := False;
  end;

function TGInversion.GetMappedPoint(pt: TFloatPoint; var bpt: TFloatPoint): Boolean;
  var dx1, dy1, d1, d2 : Double;
  begin
  If DataValid then begin
    dx1 := pt.x - invData.X;
    dy1 := pt.y - invData.Y;
    d1 := Hypot(dx1, dy1);
    If d1 < DistEpsilon then
      Result := False
    else begin
      d2 := Sqr(invData.Z / d1);
      bpt.x := invData.X + dx1 * d2;
      bpt.y := invData.Y + dy1 * d2;
      Result := True;
      end;
    end
  else
    Result := False;
  end;

function TGInversion.GetMappedLine(lineEq : TVector3; var res: TVector3): Boolean;
  { Der Wert von TVector3.tag entscheidet über das
    Datenformat in lineEq und res:
      tag = 0 :  Variable enthält eine Geradengleichung !
      tag = 1 :  Variable enthält Kreisdaten !            }
  var d : Double;
      np, mp: TFloatPoint;
  begin
  If lineEq.tag = 1 then
    Result := GetMappedCircle(lineEq, res)
  else begin       // Hier wird nur der Fall der Urbild-Geraden bearbeitet!
    Result := False;
    If DataValid then begin
      d := lineEq.X * invData.X + lineEq.Y * invData.Y + lineEq.Z;
      If Abs(d) < epsilon then begin
        res.Assign(lineEq);           // Fixgerade durch (v.X; v.Y)
        res.tag := 0;
        Result := True;
        end
      else begin
        np.x := invData.X - d * lineEq.X;   //  np enthält dann die Koordinaten des
        np.y := invData.Y - d * lineEq.Y;   //  Lotfußpunktes von (v.X; v.Y) auf lineEq
        If GetMappedPoint(np, mp) then begin
          res.X := (invData.X + mp.x) / 2;
          res.Y := (invData.Y + mp.y) / 2;
          res.Z := Hypot(invData.X - mp.x, invData.Y - mp.y) / 2;
          res.tag := 1;
          Result := True;
          end;
        end;
      end;
    end;
  end;

function TGInversion.GetMappedCircle(circ : TVector3; var res: TVector3): Boolean;
  { Der Wert von TVector3.tag entscheidet über das
    Datenformat in circ und res:
      tag = 0 :  Variable enthält eine Geradengleichung !
      tag = 1 :  Variable enthält Kreisdaten !            }
  var d          : Double;
      dir, P1, P2,
      Q1, Q2     : TFloatPoint;
      valid1,
      valid2     : Boolean;
  begin
  If circ.tag = 0 then
    Result := GetMappedLine(circ, res)
  else begin       // Hier wird nur der Fall des Urbild-Kreises bearbeitet!
    Result := False;
    If DataValid then begin
      dir.x := circ.X - invData.X;
      dir.y := circ.Y - invData.Y;
      d := Hypot(dir.x, dir.y);
      If d < epsilon then begin  // Abzubildender Kreis ist konzentrisch
        dir.x := 1;              //   zum Spiegelkreis !
        dir.y := 0;
        end;
      IntersectCircleWithLine(circ.X, circ.Y, circ.Z, circ.X, circ.Y,
                              circ.X + dir.x, circ.Y + dir.y,
                              P1.x, P1.y, P2.x, P2.y, valid1, valid2);
      If valid1 and valid2 then begin     // Es gibt 2 gültige "Extrem-Punkte"
        valid1 := GetMappedPoint(P1, Q1);
        valid2 := GetMappedPoint(P2, Q2);
        If valid1 and valid2 then begin   // 2 gültige "Bild-Extrem-Punkte"
          res.X := (Q1.x + Q2.x) / 2;
          res.Y := (Q1.y + Q2.y) / 2;
          res.Z := Hypot(Q1.x - Q2.x, Q1.y - Q2.y) / 2;
          res.tag := 1;
          Result := True;
          end
        else if valid1 then begin   // Nur 1 gültiger "Bild-Extrem-Punkt" Q1
          GetHesseEqFromPtAndNormal(Q1.x, Q1.y, dir.x, dir.y, res);
          Result := True;
          end
        else if valid2 then begin   // Nur 1 gültiger "Bild-Extrem-Punkt" Q2
          GetHesseEqFromPtAndNormal(Q2.x, Q2.y, dir.x, dir.y, res);
          Result := True;
          end;
        end;
      end;
    end;
  end;

function TGInversion.GetMappedConic(cnc: TCoeff6; var res: TCoeff6): Boolean;
  begin
  Result := False;
  end;

function TGInversion.GetInfo: String;
  begin
  Result := MyObjTxt[52];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(Parent[0]), Result);
  end;



initialization

  RegisterClass(TGSimiliarity);
  RegisterClass(TGAffinMapping);
  RegisterClass(TGInversion);

finalization


end.
