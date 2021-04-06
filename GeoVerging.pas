unit GeoVerging;

interface

uses Windows, Classes, Types, SysUtils, Menus, Dialogs,
     Graphics, XMLIntf, Math,
     GlobVars, MathLib, GeoTypes, Utility, TBaum;

type TGVergingLine = class(TGLongLine)
       protected
         FLength      : TTBaum;
         scrax, scray,
         scrbx, scrby : Integer;
         TempStr      : String;
         function  HasSameDataAs(GO: TGeoObj): Boolean; override;
         procedure UpdateScreenCoords; override;
         procedure DrawIt; override;
         procedure HideIt; override;
       public
         constructor Create(iGeoList: TGeoObjListe; iLenStr: String;
                            iP: TGPoint; iL1, iL2: TGStraightLine; iis_visible: Boolean);
         constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
         destructor  Destroy; override;
         function  CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
         procedure AfterLoading(FromXML : Boolean = True); override;
         function  GetParentPointOnSelf(nr: Integer): TGPoint; override;
         procedure UpdateParams; override;
         procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
         function GetParamFromCoords(px, py: Double; var param: Double): Boolean; override;
         function GetCoordsFromParam(param: Double; var px, py: Double): Boolean; override;
         function  GetInfo: String; override;
       end;


implementation

{================== Mathematische Hilfs-Funktionen =======================}

type  TSolutionPts   = Array[0..7, 1..3] of Double;
      TSolutionValid = Array[0..3] of Boolean;

procedure VergeParallel(    px, py,
                            gqx, gqy,
                            hqx, hqy, ux, uy,
                            d : Double;
                        var sol_pts   : TSolutionPts;
                        var sol_valid : TSolutionValid);
   { Voraussetzungen:
       1. g und h sind parallel
       2. d(P,g) > d(P,h) > 0
     Ergebnis:
       In sol_pts [0..3] werden die Lösungspunkte auf g zurückgegeben,
       in sol_pts [4..7] die zugehörigen Partnerpunkte auf h.
       In sol_valid [i] wird die Gültigkeit des Lösungs-Punktepaares
         (sol_pts[i]; sol_pts[i+4]) vermerkt                          }

  var gamma, _a, _b, _c,
      s1, s2 : Double;
      i : Integer;
  begin
  For i := 0 to 3 do sol_valid[i] := False;
  gamma := ((hqx - px)*uy - (hqy - py)*ux) / ((gqx - px)*uy - (gqy - py)*ux);
  If Abs(1-gamma) < epsilon then Exit;

  _a := Sqr(ux) + Sqr(uy);
  _b := -2*(ux*(px - gqx) + uy*(py - gqy));
  _c := Sqr(px - gqx) + Sqr(py - gqy) - Sqr(d/(1-gamma));
  i := SolveQuadraticEquation(_a, _b, _c, s1, s2);
  If i >= 1 then begin
    sol_valid[0] := True;
    sol_pts[0, 1] := gqx + s1*ux;
    sol_pts[0, 2] := gqy + s1*uy;
    sol_pts[4, 1] := px + gamma*(gqx - px + s1*ux);
    sol_pts[4, 2] := py + gamma*(gqy - py + s1*uy);
    If i >= 2 then begin
      sol_valid[1] := True;
      sol_pts[1, 1] := gqx + s2*ux;
      sol_pts[1, 2] := gqy + s2*uy;
      sol_pts[5, 1] := px + gamma*(gqx - px + s2*ux);
      sol_pts[5, 2] := py + gamma*(gqy - py + s2*uy);
      end;
    end;
  end;


procedure VergeNonParallel(     px, py,
                                gqx, gqy, gux, guy,
                                hqx, hqy, hux, huy,
                                d  : Double;
                            var sol_pts   : TSolutionPts;
                            var sol_valid : TSolutionValid);
   { Voraussetzungen:
       1. g und h sind nicht parallel
       2. d(P,g) > d(P,h) > 0
     Ergebnis:
       In sol_pts [0..3] werden die Lösungspunkte auf g zurückgegeben,
       in sol_pts [4..7] die zugehörigen Partnerpunkte auf h.
       In sol_valid [i] wird die Gültigkeit des Lösungs-Punktepaares
         (sol_pts[i]; sol_pts[i+4]) vermerkt                          }

  var usu, beta, alpha, bmina, pgq2, upgq, d2,
      _a, _b, _c, _d, _e,
      s1, s2, s3, s4  : Double;
      i : Integer;

  procedure LoadSolution(n : Integer; s : Double);
    var t {, wd} : Double;
    begin
    sol_valid[n] := True;
    sol_pts[n, 1] := gqx + s * gux;
    sol_pts[n, 2] := gqy + s * guy;
    t := alpha / (beta + s);
    sol_pts[n+4, 1] := px + t * (sol_pts[n, 1] - px);
    sol_pts[n+4, 2] := py + t * (sol_pts[n, 2] - py);

    // Der folgende Code diagnostiziert schlecht konditionierte
    // Konfigurationen. Es wird überprüft, ob die errechneten Punkte
    // auch wirklich den vorgegebenen Abstand d haben. Wenn P zu dicht
    // bei g und h liegt, kann das schief gehen!
{
    wd := myHypot(sol_pts[n+4,1] - sol_pts[n,1],
                  sol_pts[n+4,2] - sol_pts[n,2]);
    If Abs(wd - d) > 0.01 then
      ShowMessage('Wrong verging line length: '#13#10 +
                   FloatToStr(wd) + ' instead of ' + FloatToStr(d) + ' !');
}
    end;

  begin
  For i := 0 to 3 do sol_valid[i] := False;

  usu   := gux * huy - guy * hux;
  alpha := ((hqx - px) * huy - (hqy - py) * hux) / usu;
  beta  := ((gqx - px) * huy - (gqy - py) * hux) / usu;
  bmina := beta - alpha;
  pgq2  := Sqr(px - gqx) + Sqr(py - gqy);
  upgq  := gux * (px - gqx) + guy * (py - gqy);
  d2    := Sqr(d);

  _a    := Sqr(gux) + Sqr(guy);
  _b    := 2 * (_a * bmina - upgq);
  _c    := pgq2 - bmina * (4 * upgq - bmina * _a) - d2;
  _d    := 2 * (bmina * (pgq2 - bmina * upgq) - beta * d2);
  _e    := Sqr(bmina) * pgq2 - d2 * Sqr(beta);

  i := SolveForthOrderEquation(_a, _b, _c, _d, _e, s1, s2, s3, s4);
  If i >= 1 then begin
    LoadSolution(0, s1);
    If i >= 2 then begin
      LoadSolution(1, s2);
      If i >= 3 then begin
        LoadSolution(2, s3);
        If i >= 4 then
          LoadSolution(3, s4);
        end;
      end;
    end;
  end;

procedure GetNearestSolution(    sol_pts        : TSolutionPts;
                                 sol_valid      : TSolutionValid;
                             var X1, Y1, X2, Y2 : Double);

  function Dist2OldPos(Px, Py, Qx, Qy: Double): Double;
    var d1, d2 : Double;
    begin
    d1 := Hypot(Px-X1, Py-Y1) + Hypot(Qx-X2, Qy-Y2);
    d2 := Hypot(Px-X2, Py-Y2) + Hypot(Qx-X1, Qy-Y1);
    If d1 < d2 then
      Result := d1
    else
      Result := -d2;
    end;

  var d    : Double;
      n, i : Integer;

  begin
  i := 0;
  While (i < 4) and sol_valid[i] do begin
    d := Dist2OldPos(sol_pts[i    , 1], sol_pts[i    , 2],
                     sol_pts[i + 4, 1], sol_pts[i + 4, 2]);
    sol_pts[i    , 3] := Abs(d);
    sol_pts[i + 4, 3] := d;
    i := i + 1;
    end;
  n := i - 1;
  i := i - 2;
  While i >= 0 do begin
    If sol_pts[i, 3] < sol_pts[n, 3] then
      n := i;
    i := i - 1;
    end;
  If n >= 0 then
    If sol_pts[n + 4, 3] >= 0 then begin
      X1 := sol_pts[n    , 1];
      Y1 := sol_pts[n    , 2];
      X2 := sol_pts[n + 4, 1];
      Y2 := sol_pts[n + 4, 2];
      end
    else begin
      X1 := sol_pts[n + 4, 1];
      Y1 := sol_pts[n + 4, 2];
      X2 := sol_pts[n    , 1];
      Y2 := sol_pts[n    , 2];
      end;
  end;

{=================== TGVergingLine ==========================================}

constructor TGVergingLine.Create(iGeoList: TGeoObjListe; iLenStr: String;
                                 iP: TGPoint; iL1, iL2: TGStraightLine;
                                 iis_visible: Boolean);
  begin
  Inherited Create(iGeoList, iP, iL1, False);
  BecomesChildOf(iL2);
  FLength := TTBaum.Create(iGeoList, Rad);
  FLength.BuildTree(iLenStr);
  Assert(FLength.baum <> Nil, 'Invalid verging line''s length!');
  FLength.RegisterTermParentsIn(Self);
  UpdateParams;
  If iis_visible then
    ShowsAlways := True;
  end;

constructor TGVergingLine.CreateFromDOMData(iObjList: TGeoObjListe;
  DE: IXMLNode);
  begin
  inherited CreateFromDOMData(iObjList, DE);
  FLength := TTBaum.Create(ObjList, ObjList.GetDefAngleMode);
  TempStr := DE.childNodes.findNode('term', '').nodeValue;
  end;

function TGVergingLine.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var domLen, domPos : IXMLNode;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  { Geradenendpunkte durch Endpunkte der Einschiebestrecke ersetzen }
  domPos := Result.childNodes.findNode('position', '');
  domPos.setAttribute('x1', FloatToStr(X1));
  domPos.setAttribute('y1', FloatToStr(Y1));
  domPos.setAttribute('x2', FloatToStr(X2));
  domPos.setAttribute('y2', FloatToStr(Y2));
  { Länge hinzufügen }
  domLen := DOMDoc.createNode('term');
  domLen.childNodes.Add(DOMDoc.createNode(FLength.source_str, ntText));
  Result.childNodes.Add(domLen);
  end;

destructor TGVergingLine.Destroy;
  begin
  ShowsAlways := False;
  FLength.Free;
  inherited Destroy;
  end;

procedure TGVergingLine.AfterLoading(FromXML: Boolean = True);
  begin
  Inherited AfterLoading(FromXML);
  FLength.UpdateDegSourceAndBuildTree(TempStr, False);
  FLength.RegisterTermParentsIn(Self);
  end;

function TGVergingLine.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := Inherited HasSameDataAs(GO) and
            (Parent[2] = GO.Parent[2]) and
            FLength.HasSameDataAs((GO as TGVergingLine).FLength);
  end;

procedure TGVergingLine.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  inherited;
  end;

function TGVergingLine.GetParentPointOnSelf(nr: Integer): TGPoint;
  begin
  Result := Nil;
  end;

procedure TGVergingLine.UpdateParams;
  var px, py,
      g1px, g1py, g1qx, g1qy,
      g2px, g2py, g2qx, g2qy,
      dpg1, dpg2, d : Double;
      spts  : TSolutionPts;
      valid : TSolutionValid;
      i     : Integer;
  begin
  If Parent.Count < 3 then begin
    DataValid := False;
    Exit;
    end;
  DataValid := True;
  For i := 0 to Pred(Parent.Count) do
    If Not TGeoObj(Parent[i]).DataValid then
      DataValid := False;
  If DataValid then begin
    FLength.Calculate(0, d);
    DataValid := FLength.is_okay;
    If DataValid then begin
      px   := TGPoint(Parent[0]).X;
      py   := TGPoint(Parent[0]).Y;
      g1px := TGStraightLine(Parent[1]).X1;
      g1py := TGStraightLine(Parent[1]).Y1;
      g1qx := TGStraightLine(Parent[1]).X2;
      g1qy := TGStraightLine(Parent[1]).Y2;
      g2px := TGStraightLine(Parent[2]).X1;
      g2py := TGStraightLine(Parent[2]).Y1;
      g2qx := TGStraightLine(Parent[2]).X2;
      g2qy := TGStraightLine(Parent[2]).Y2;
      dpg1 := DistPt2Line(g1px, g1py, g1qx, g1qy, px, py);
      dpg2 := DistPt2Line(g2px, g2py, g2qx, g2qy, px, py);
      If dpg1 < DistEpsilon then begin
        { P liegt auf g1 }
        IntersectCircleWithLine(px, py, d, g2px, g2py, g2qx, g2qy,
                                spts[0, 1], spts[0, 2], spts[1, 1], spts[1, 2],
                                valid[0], valid[1]);
        If valid[0] then begin
          spts[4, 1] := px; spts[4, 2] := py; end;
        If valid[1] then begin
          spts[5, 1] := px; spts[5, 2] := py; end;
        end
      else If dpg2 < DistEpsilon then begin
        { P liegt auf g2 }
        IntersectCircleWithLine(px, py, d, g1px, g1py, g1qx, g1qy,
                                spts[0, 1], spts[0, 2], spts[1, 1], spts[1, 2],
                                valid[0], valid[1]);
        If valid[0] then begin
          spts[4, 1] := px;
          spts[4, 2] := py;
          end;
        If valid[1] then begin
          spts[5, 1] := px;
          spts[5, 2] := py;
          end;
        end
      else { P liegt weder auf g1 noch auf g2 }
        If are_parallel (g1px, g1py, g1qx, g1qy,
                         g2px, g2py, g2qx, g2qy) then
          If dpg1 > dpg2 then
            VergeParallel(px, py, g1px, g1py, g2px, g2py,
                          g1qx - g1px, g1qy - g1py, d, spts, valid)
          else
            VergeParallel(px, py, g2px, g2py, g1px, g1py,
                          g1qx - g1px, g1qy - g1py, d, spts, valid)
        else  { Dieser allgemeine Fall ist der einzige, der *nicht*
                mit Zirkel und Lineal alleine lösbar ist !  }
          If dpg1 > dpg2 then
            VergeNonParallel(px, py, g1px, g1py, g1qx - g1px, g1qy - g1py,
                             g2px, g2py, g2qx - g2px, g2qy - g2py, d, spts, valid)
          else
            VergeNonParallel(px, py, g2px, g2py, g2qx - g2px, g2qy - g2py,
                             g1px, g1py, g1qx - g1px, g1qy - g1py, d, spts, valid);
      { Ergebnis aus spts herausholen }
      GetNearestSolution(spts, valid, X1, Y1, X2, Y2);
      If valid[0] or valid[1] or valid[2] or valid[3] then begin
        GetHesseEqFromPtAndDir(X1, Y1, X2-X1, Y2-Y1, FHesseEq);
        UpdateScreenCoords;
        end
      else
        DataValid := False;
      end;
    end;
  end;

procedure TGVergingLine.UpdateScreenCoords;
  begin
  inherited UpdateScreenCoords;
  If DataValid then begin
    ObjList.GetWinCoords(X1, Y1, scrax, scray);
    ObjList.GetWinCoords(X2, Y2, scrbx, scrby);
    end;
  end;

procedure TGVergingLine.DrawIt;
  begin
  inherited DrawIt;
  If IsVisible then begin
    ObjList.TargetCanvas.Pen.width :=
      Round((MyLineWidth + 2) * ObjList.ScaleFactor);
    draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                 scrax, scray, scrbx, scrby, MyPenStyle);
    end;
  end;

procedure TGVergingLine.HideIt;
  begin
  inherited HideIt;
  If IsVisible then begin
    ObjList.TargetCanvas.Pen.width :=
      Round((MyLineWidth + 2) * ObjList.ScaleFactor);
    draw_line_on(ObjList.TargetCanvas, act_pixelPerXcm,
                 scrax, scray, scrbx, scrby, MyPenStyle);
    end;
  end;

function TGVergingLine.GetParamFromCoords(px, py: Double; var param: Double): Boolean;
  { Parameter-Bereich 0..1, sofern P(px|py) zwischen den
    Endpunkten (AX|AY) und (BX|BY) der Einschiebestrecke liegt }
  begin
  Result := GetTV(X1, Y1, X2, Y2, px, py, param);
  end;

function TGVergingLine.GetCoordsFromParam(param: Double; var px, py: Double): Boolean;
  begin
  If DataValid then begin
    px := X1 + param*(X2 - X1);
    py := Y1 + param*(Y2 - Y1);
    Result := True;
    end
  else
    Result := False;
  end;

function TGVergingLine.GetInfo: String;
  var i : Integer;
  begin
  Result := Format(MyObjTxt[66], [FLength.source_str]);
  InsertNameOf(Self, Result);
  For i := 0 to 2 do
    InsertNameOf(TGeoObj(Parent[i]), Result);
  end;


initialization

RegisterClass(TGVergingLine);

end.
