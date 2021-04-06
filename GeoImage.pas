unit GeoImage;

interface

uses Windows, Classes, Types, Controls, SysUtils, Menus,
     Graphics, JPEG, PNGImage, Math, XMLIntf, ComCtrls,
     xxcode, Declar, GlobVars, MathLib, Utility,
     GeoTypes, GeoTransf, GeoLocLines, Generics.Collections;

type TGFramePt = class;

     TGZoomFrame = class(TGeoObj)
       protected
         // Der geerbte Punkt (X,Y) enthält die User-Koordinaten der Zoom-Quadrat-Mitte.
         fh           : Double;  // Enthält den Wert h = "dx" in User-Koordinaten
         fShowSecants,
         fShowSlopeFuncs,
         fShowCurvatureCircle,
         fShowCurvatureParabola : Boolean;
         hSource      : TGNumberObj;
         centerPt     : TGPoint;
         fFramePt     : Array[0..1] of TGFramePt;
         // sli, sre     : TGShortLine;
         // sPtLi, sPtRe : TGXPoint;
         // sFnLi, sFnRe : TGLocLine;
         vertex       : TFloatPointList;
         scrVertex    : Array[0..3] of TPoint;
         procedure setH(nh : Double);
         procedure setShowSecants(nv : Boolean);
         procedure setShowSlopeFuncs(nv : Boolean);
         procedure setShowCurvatureCircle(nv : Boolean);
         procedure setShowCurvatureParabola(nv : Boolean);
         procedure UpdateScreenCoords; override;
         procedure AdjustGraphTools(todraw : Boolean); override;
         procedure DrawIt; override;
         procedure HideIt; override;
         procedure DragIt; override;
         procedure ExportIt; override;
       public
         // The following two integer numbers hold the displacement from the
         MGWin_dx,            // upper-left vertex of the MainWindow to the
         MGWin_dy  : Integer; // upper-left vertex of the MagnGlassWindow.
         constructor Create(iGeoList: TGeoObjListe; iCenterPt: TGPoint;
                            iHSource: TGNumberObj; iMGWin_dx, iMGWin_dy: Integer);
         constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
         procedure AfterLoading(FromXML: Boolean = True); override;
         function CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
         procedure UpdateParams; override;
         procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
         function IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
         function Dist (xm, ym: Double): Double; override;
         function IsNearMouse: Boolean; override;
         procedure SaveState; override;
         procedure RestoreState; override;
         procedure setFramePt(nfp : TGFramePt);
         function getFramePt(left : Boolean): TGFramePt;
         function getCenterPt: TGPoint;
         function GetInfo: String; override;
         property h: Double read fh write setH;
         property ShowSecants   : Boolean read fShowSecants    write setShowSecants;
         property ShowSlopeFuncs: Boolean read fShowSlopeFuncs write setShowSlopeFuncs;
         property ShowCurvatureCircle  : Boolean read fShowCurvatureCircle   write setShowCurvatureCircle;
         property ShowCurvatureParabola: Boolean read fShowCurvatureParabola write setShowCurvatureParabola;
       end;

     TGFramePt = class(TGPoint)
       protected
         ZoomFrame: TGZoomFrame;
         left     : Boolean;
         function HasSameDataAs(GO: TGeoObj): Boolean; override;
       public
         constructor Create(iGeoList: TGeoObjListe; iZoomFrame: TGZoomFrame; iLeft: Boolean);
         constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
         function CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
         procedure AfterLoading(FromXML : Boolean = True); override;
         procedure UpdateParams; override;
       end;

     TGImage = class(TGeoObj)
       protected
         Pic      : TPicture;
         FPicRect : TRect;
         // Der geerbte Punkt (X;Y) beschreibt die linke obere Ecke des Bildes,
         X2, Y2   : Double;   // (X2; Y2) die rechte untere Ecke !
         function  HasSameDataAs(GO: TGeoObj): Boolean; override;
         function  GetHasPic: Boolean; virtual;
         function  SavePNGtoXXString: String;
         procedure LoadPNGfromXXString(s : String);
         procedure CalcDist(sm: TPoint); virtual;
         procedure UpdateScreenCoords; override;
         procedure AdjustGraphTools(todraw : Boolean); override;
         procedure DrawIt; override;
         procedure HideIt; override;
         procedure DragIt; override;
       public
         IsLocked : Boolean;
         constructor Create(iGeoList: TGeoObjListe; FileName: String);
         constructor CreateFromBMP(iGeoList: TGeoObjListe; BMP: TBitmap; iX1, iY1, iX2, iY2: Double);
         constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
         destructor  Destroy; override;
         function CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
         procedure UpdateParams; override;
         procedure LoadContextMenuEntriesInto(menu: TPopUpMenu); override;
         function IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
         function Dist (xm, ym: Double): Double; override;
         function IsNearMouse: Boolean; override;
         function GetMatchingCursor(mpt: TPoint): TCursor; override;
         function GetVertices(var v: Array of TFloatPoint): Boolean; virtual;
         function GetInfo: String; override;
         property PicRect: TRect read FPicRect;
         property HasPic: Boolean read GetHasPic;
       end;

     TGMappedImage = class(TGImage)
       protected
         // (X;Y) wird geerbt und enthält die Position des Abbildes der
         //                     linken oberen Ecke des Originalbildes,
         X1, Y1    : Double; // (X1;Y1) ist Position des Abbildes
                             // der *rechten oberen* (!) Ecke,
         // (X2;Y2) wird geerbt und enthält die Position des Abbildes der
         //                     rechten unteren Ecke des Originalbildes.
         { Ist das Ur-Bild ebenfalls ein TGMappedImage, dann werden (X;Y),
           (X1;Y1) und (X2;Y2) über die neue Transformation "durchgereicht".
           So können damit Abbildungsketten entstehen. Für DrawIt muss
           diese Kette aber bis zu einem TGImage-Objekt zurückverfolgt
           werden, dem man dann die Urbilddaten entnehmen kann.   }
         scrpt    : Array [0..2] of TPoint;    // "Scr"een "P"oin"t"
         para     : Array [0..3] of TPoint;
         AreaHnd  : THandle;  // Handle des umschließenden Parallelogramms
         function  GetHasPic: Boolean; override;
         procedure UpdateScreenCoords; override;
         procedure DrawIt; override;
         procedure HideIt; override;
         procedure DragIt; override;
       public
         constructor Create(iGeoList: TGeoObjListe; iPImage: TGImage;
                            iTransf: TGTransformation; iisVisible: Boolean);
         constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
         function CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
         function IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
         function GetVertices(var v: Array of TFloatPoint): Boolean; override;
         function Dist (xm, ym: Double): Double; override;
         function IsNearMouse: Boolean; override;
         procedure LoadContextMenuEntriesInto(menu: TPopupMenu); override;
         procedure UpdateParams; override;
         function GetInfo: String; override;
       end;

     TGSetsquare = class(TGMappedImage)
       protected
         ResWinHandle : THandle;
         halflen,
         X0, Y0    : Double;    // Position der Geo3eck-Nullpunkts
         sx0, sy0  : Integer;   // ... mit den zugehörigen Screen-Koordinaten
         sx,  sy   : Integer;
         VertexFocussed,
         AngleFocussed,
         Rotating  : Boolean;
         MouseHnd  : THandle;
         BufBMP    : TBitmap;
         SelVertex : TGPoint;
         SelAngle  : TGeoObj;
         FPosFlag  : Integer;
         procedure SetPosFlag(newPF: Integer);
         procedure Rescale; override;
         procedure UpdateScreenCoords; override;
         procedure DrawIt; override;
         procedure Check4Angle2Measure;
         function  SSDirOnLegOfAngle(ALPt: TGPoint) : Boolean;
       public
         constructor Create(iGeoList: TGeoObjListe; iisVisible: Boolean);
         constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode); override;
         destructor Destroy; override;
         function CreateObjNode(DOMDoc: IXMLDocument): IXMLNode; override;
         procedure AfterLoading(FromXML: Boolean = True); override;
         function IsCompatibleWith(ClassGroupId: Integer): Boolean; override;
         function Dist (xm, ym: Double): Double; override;
         function IsNearMouse: Boolean; override;
         procedure LoadContextMenuEntriesInto(menu: TPopupMenu); override;
         procedure UpdateParams; override;
         procedure MoveAndTurnRandomly;
         function GetInfo: String; override;
         procedure SetResWinHandle(newHandle: THandle);
         property PosFlag: Integer read FPosFlag write SetPosFlag;
       end;


implementation

uses MainWin;

{=============== TGZoomFrame ====================}

constructor TGZoomFrame.Create(iGeoList: TGeoObjListe; iCenterPt: TGPoint;
                               iHSource: TGNumberObj; iMGWin_dx, iMGWin_dy: Integer);
  begin
  Inherited Create(iGeoList, true);
  centerPt := iCenterPt;
  hSource := iHSource;
  BecomesChildOf(centerPt);
  BecomesChildOf(hSource);
  hSource.Value := hSource.MaxValue;
  fh := hSource.Value;
  fShowSecants := False;
  fShowSlopeFuncs := False;
  fShowCurvatureCircle := False;
  fShowCurvatureParabola := False;
  MGWin_dx := iMGWin_dx;
  MGWin_dy := iMGWin_dy;
  // AdjustMGWinDisplacement;
  SetLength(vertex, 4);
  UpdateParams;
  end;

constructor TGZoomFrame.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var zoomStatus,
      MGWinDisp : IXMLNode;
      s         : String;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  hSource := ObjList.GetLogSlider;
  fh := hSource.Value;

  fShowSecants := False;
  fShowSlopeFuncs := False;
  fShowCurvatureCircle := False;
  fShowCurvatureParabola := False;
  MGWin_dx := 0;
  MGWin_dy := 0;

  zoomStatus := DE.ChildNodes.FindNode('zoomstatus');
  if zoomStatus <> Nil then begin
    if zoomStatus.HasAttribute('showSecants') then begin
      s := zoomStatus.GetAttribute('showSecants');
      if s = '1' then fShowSecants := True;
      end;
    if zoomStatus.HasAttribute('showSlopeFuncs') then begin
      s := zoomStatus.GetAttribute('showSlopeFuncs');
      if s = '1' then fShowSlopeFuncs := True;
      end;
    if zoomStatus.HasAttribute('showCurvatureCircle') then begin
      s := zoomStatus.GetAttribute('showCurvatureCircle');
      if s = '1' then fShowCurvatureCircle := True;
      end;
    if zoomStatus.HasAttribute('showCurvatureParabola') then begin
      s := zoomStatus.GetAttribute('showCurvatureParabola');
      if s = '1' then fShowCurvatureParabola := True;
      end;
    end;
  SetLength(vertex, 4);

  MGWinDisp := DE.ChildNodes.FindNode('MGWinDisp');
  if MGWinDisp <> Nil then begin
    s := MGWinDisp.GetAttribute('dx');
    try
      MGWin_dx := StrToInt(s);
    except
      MGWin_dx := 0;
    end; { of try }
    s := MGWinDisp.GetAttribute('dy');
    try
      MGWin_dy := StrToInt(s);
    except
      MGWin_dy := 0;
    end; { of try }
    end; { of if }
  if MGWin_dx * MGWin_dy = 0 then begin
    MGWin_dx := 800;
    MGWin_dy := 200;
    end;
  end;

procedure TGZoomFrame.AfterLoading(FromXML: Boolean = True);
  var i, n : Integer;
  begin
  Inherited AfterLoading(FromXML);
  centerPt := TGeoObj(Parent[0]) as TGPoint;
  i := ObjList.LastValidObjIndex;
  n := 0;
  while (i > 0) and (n < 2) do begin
    if TGeoObj(ObjList.Items[i]) is TGFramePt  then begin
      setFramePt(TGeoObj(ObjList.Items[i]) as TGFramePt);
      n := n + 1 ;
      end;
    i := i - 1;
    end;
  end;

function TGZoomFrame.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var zoomstatus,
      MGWinPos  : IXMLNode;
      s : String;
  begin
  Result := Inherited CreateObjNode(DOMDoc);
  zoomstatus := DOMDoc.CreateNode('zoomstatus');
  if ShowSecants then s := '1' else s := '0';
  zoomstatus.setAttribute('showSecants', s);
  if ShowSlopeFuncs then s := '1' else s := '0';
  zoomstatus.setAttribute('showSlopeFuncs', s);
  if ShowCurvatureCircle then s := '1' else s := '0';
  zoomstatus.setAttribute('showCurvatureCircle', s);
  if ShowCurvatureParabola then s := '1' else s := '0';
  zoomstatus.setAttribute('showCurvatureParabola', s);
  Result.childNodes.add(zoomstatus);

  // Erst aktualisieren...
  MGWin_dx := Hauptfenster.MagnGlassWin.Left - Hauptfenster.Left;
  MGWin_dy := Hauptfenster.MagnGlassWin.Top  - Hauptfenster.Top;
  // ...dann verbuchen !
  MGWinPos := DOMDoc.CreateNode('MGWinDisp');
  s := IntToStr(MGWin_dx);
  MGWinPos.SetAttribute('dx', s);
  s := IntToStr(MGWin_dy);
  MGWinPos.SetAttribute('dy', s);
  Result.ChildNodes.Add(MGWinPos);
  end;

procedure TGZoomFrame.UpdateParams;
  begin
  h := hSource.Value;
  centerPt.x := (TGeoObj(Parent[0]) as TGPoint).x;
  centerPt.y := (TGeoObj(Parent[0]) as TGPoint).y;
  if assigned(fFramePt[0]) then
    fFramePt[0].UpdateParams; // X := centerPt.X - h;
  if assigned(fFramePt[1]) then
    fFramePt[1].UpdateParams; // X := centerPt.X + h;
  vertex[0].x := centerPt.x + h;
  vertex[0].y := centerPt.y + h;
  vertex[1].x := centerPt.x - h;
  vertex[1].y := centerPt.y + h;
  vertex[2].x := centerPt.x - h;
  vertex[2].y := centerPt.y - h;
  vertex[3].x := centerPt.x + h;
  vertex[3].y := centerPt.y - h;
  UpdateScreenCoords;
  end;

procedure TGZoomFrame.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  // Don't call the Inherited method! It doesn't fit at all!
  while menu.Items.Count > 0 do
    menu.Items.Delete(0);
  if ShowSecants then
    AddPopupMenuItemTo(menu, cme_SecantSlopes + cme_ZF_kill, CME_PopupClick, cmd_SecantSlopes)
  else
    AddPopupMenuItemTo(menu, cme_SecantSlopes + cme_ZF_show, CME_PopupClick, cmd_SecantSlopes);
  if ShowSlopeFuncs then
    AddPopupMenuItemTo(menu, cme_SecSlopeFuncs + cme_ZF_kill, CME_PopupClick, cmd_SecSlopeFuncs)
  else
    AddPopupMenuItemTo(menu, cme_SecSlopeFuncs + cme_ZF_show, CME_PopupClick, cmd_SecSlopeFuncs);
  if ShowCurvatureCircle then
    AddPopupMenuItemTo(menu, cme_CurvatureCircle + cme_ZF_kill, CME_PopupClick, cmd_CurvatureCircle)
  else
    AddPopupMenuItemTo(menu, cme_CurvatureCircle + cme_ZF_show, CME_PopupClick, cmd_CurvatureCircle);
  if ShowCurvatureParabola then
    AddPopupMenuItemTo(menu, cme_CurvatureParabo + cme_ZF_kill, CME_PopupClick, cmd_CurvatureParabo)
  else
    AddPopupMenuItemTo(menu, cme_CurvatureParabo + cme_ZF_show, CME_PopupClick, cmd_CurvatureParabo);
  end;

function TGZoomFrame.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := False;
  end;

function TGZoomFrame.Dist (xm, ym: Double): Double;
  begin
  if (xm < centerPt.X + h) and (centerPt.X - h < xm) and
     (ym < centerPt.Y + h) and (centerPt.Y - h < ym) then
    LastDist := 0
  else
    LastDist := 10000;
  Result := LastDist;
  end;

function TGZoomFrame.IsNearMouse: Boolean;
  var mx, my: Integer;
  begin
  mx := ObjList.LastMousePos.X;
  my := ObjList.LastMousePos.Y;
  Result := (scrVertex[1].x < mx) and (mx < scrVertex[3].x) and
            (scrVertex[1].y < my) and (my < scrVertex[3].y);
  end;

procedure TGZoomFrame.SaveState;
  var i : Integer;
  begin
  Old_Data.push(@FStatus, SizeOf(FStatus));
  Old_Data.push(@X, SizeOf(X));
  Old_Data.push(@Y, SizeOf(Y));
  for i := 0 to 3 do begin
    Old_Data.push(@scrVertex[i].X, SizeOf(scrVertex[i].X));
    Old_Data.push(@scrVertex[i].Y, SizeOf(scrVertex[i].Y));
    end;
  for i := 0 to 3 do begin
    Old_Data.push(@vertex[i].x, SizeOf(vertex[i].x));
    Old_Data.push(@vertex[i].y, SizeOf(vertex[i].y));
    end;
  end;

procedure TGZoomFrame.RestoreState;
  var i : Integer;
  begin
  for i := 3 downto 0 do begin
    Old_Data.pop(@vertex[i].y);
    Old_Data.pop(@vertex[i].x);
    end;
  for i := 3 downto 0 do begin
    Old_Data.pop(@scrVertex[i].Y);
    Old_Data.pop(@scrVertex[i].X);
    end;
  Old_Data.pop(@Y);
  Old_Data.pop(@X);
  Old_Data.pop(@FStatus);
  end;

procedure TGZoomFrame.setFramePt(nfp : TGFramePt);
  begin
  if nfp.left then
    fFramePt[0] := nfp
  else
    fFramePt[1] := nfp;
  end;

function TGZoomFrame.getFramePt(left : Boolean): TGFramePt;
  begin
  if left then
    Result := fFramePt[0]
  else
    Result := fFramePt[1];
  end;

function TGZoomFrame.getCenterPt: TGPoint;
  begin
  Result := centerPt;
  end;

function TGZoomFrame.GetInfo: String;
  begin
  Result := MyObjTxt[117];
  InsertNameOf(Self, Result);
  end;


//------------ Private Helpers ---------------//


procedure TGZoomFrame.setH(nh : Double);
  begin
  if abs(fh - nh) > epsilon  then
    fh := nh;
  end;

procedure TGZoomFrame.setShowSecants(nv : Boolean);

  function findSecant(sn: Integer): TGShortLine;
    var GO : TGShortLine;
    begin
    Result := Nil;
    sn := sn + 1;
    while (Result = Nil) and (sn <= ObjList.LastValidObjIndex) do begin
      if TGeoObj(ObjList.Items[sn]) is TGShortLine then begin
        GO := TGeoObj(ObjList.Items[sn]) as TGShortLine;
        If centerPt.IsAncestorOf(GO) and
           ( getFramePt(true).IsAncestorOf(GO) or
             getFramePt(false).IsAncestorOf(GO) ) then
          Result := GO;
        end; { of if }
      sn := sn + 1;
      end; { of while }
    end;

  var sli, sre : TGShortLine;
      n,
      err_num  : Integer;
  begin
  if nv <> ShowSecants then
    if nv then begin
      sli := TGShortLine.Create(ObjList, centerPt, getFramePt(true), true);
      sre := TGShortLine.Create(ObjList, centerPt, getFramePt(false), true);
      ObjList.InsertObject(sli, err_num);
      ObjList.InsertObject(sre, err_num);
      fShowSecants := True;
      end
    else begin
      n := ObjList.IndexOf(Self);
      sli := findSecant(n);
      if sli <> Nil then
        ObjList.FreeObject(sli);
      sre := findSecant(n);
      if sre <> Nil then
        ObjList.FreeObject(sre);
      fShowSecants := False;
      end;
  end;

procedure TGZoomFrame.setShowSlopeFuncs(nv : Boolean);

  function stringEqual_nb(s1, s2: String): Boolean;
    // prüft die übergebenen beiden Strings auf Gleichheit,
    // wobei Leerzeichen nicht berücksichtigt werden.
    var i : Integer;
    begin
    for i := Length(s1) downto 1 do
      if s1[i] = ' ' then Delete(s1, i, 1);
    for i := Length(s2)  downto 1 do
      if s2[i] = ' ' then Delete(s2, i, 1);
    Result := s1 = s2;
    end;

  function findSlopePt(sn: Integer; _xt, _yt: String): TGXPoint;
    var GO : TGXPoint;
    begin
    Result := Nil;
    sn := sn + 1;
    while (Result = Nil) and (sn <= ObjList.LastValidObjIndex) do begin
      if TGeoObj(ObjList.Items[sn]) is TGXPoint then begin
        GO := TGeoObj(ObjList.Items[sn]) as TGXPoint;
        If centerPt.IsAncestorOf(GO) and
           stringEqual_nb(GO.XTerm.source_str, _xt) and
           stringEqual_nb(GO.YTerm.source_str, _yt) then
          Result := GO;
        end; { of if }
      sn := sn + 1;
      end; { of while }
    end;

  var fn, cp,
      xt, yt1, yt2 : String;
      sPtLi, sPtRe : TGXPoint;
      sFnLi, sFnRe : TGLocLine;
      n, err_num   : Integer;
  begin
  if nv <> ShowSlopeFuncs then begin
    fn := TGeoObj(centerPt.Parent[0]).Name;  // Funktions-Name
    cp := centerPt.Name;     // Name des zentralen Zoom-Punkts
    xt := 'x(' + cp + ')';
    yt1 := '(' + fn + '(x) - ' + fn + '(x - h) ) / h';
    yt2 := '(' + fn + '(x + h) - ' + fn + '(x) ) / h';

    if nv then begin
      sPtLi := TGXPoint.Create(ObjList, xt, yt1, true);
      sPtLi := ObjList.InsertObject(sPtLi, err_num) as TGXPoint;
      sFnLi := TGLocLine.CreateFromI2G(ObjList, sPtLi, centerPt, true);
      sFnLi := ObjList.InsertObject(sFnLi, err_num) as TGLocLine;
      sFnLi.UpdateParams;

      sPtRe := TGXPoint.Create(ObjList, xt, yt2, true);
      sPtRe := ObjList.InsertObject(sPtRe, err_num) as TGXPoint;
      sFnRe := TGLocLine.CreateFromI2G(ObjList, sPtRe, centerPt, true);
      sFnRe := ObjList.InsertObject(sFnRe, err_num) as TGLocLine;
      sFnRe.UpdateParams;

      fShowSlopeFuncs := True;
      end
    else begin
      n := ObjList.IndexOf(Self);
      sPtLi := findSlopePt(n, xt, yt1);
      if (sPtLi <> Nil) and (ObjList.IndexOf(sPtLi) > 0) then
        ObjList.FreeObject(sPtLi);
      sPtRe := findSlopePt(n, xt, yt2);
      if (sPtRe <> Nil) and (ObjList.IndexOf(sPtRe) > 0) then
        ObjList.FreeObject(sPtRe);

      fShowSlopeFuncs := False;
      end;
    end;
  end;

procedure TGZoomFrame.setShowCurvatureCircle(nv : Boolean);

  function findCurvatureCircle(sn : Integer): TGCircle3P;
    var GO : TGCircle3P;
    begin
    Result := Nil;
    sn := sn + 1;
    while (Result = Nil) and (sn <= ObjList.LastValidObjIndex) do begin
      if TGeoObj(ObjList.Items[sn]) is TGCircle3P then begin
        GO := TGeoObj(ObjList.Items[sn]) as TGCircle3P;
        if (GO.Parent.Count = 3) and
           centerPt.IsAncestorOf(GO) and
           getFramePt(true).IsAncestorOf(GO) and
           getFramePt(false).IsAncestorOf(GO) then
          Result := GO;
        end;  { of outer if }
      sn := sn + 1;
      end; { of while }
    end;

  var CC      : TGCircle3P;
      n,
      err_num : Integer;
  begin
  if nv <> ShowCurvatureCircle then
    if nv then begin
      CC := TGCircle3P.Create(ObjList,
                 getFramePt(true), centerPt, getFramePt(false), true);
      ObjList.InsertObject(CC, err_num);
      fShowCurvatureCircle := True;
      end
    else begin
      n := ObjList.IndexOf(Self);
      CC := findCurvatureCircle(n);
      if CC <> Nil then
        ObjList.FreeObject(CC);
      fShowCurvatureCircle := False;
      end;
  end;

procedure TGZoomFrame.setShowCurvatureParabola;

  function findCurvatureParabola(sn : Integer): TGIPolynomFkt;
    var GO : TGIPolynomFkt;
    begin
    Result := Nil;
    sn := sn + 1;
    while (Result = Nil) and (sn <= ObjList.LastValidObjIndex) do begin
      if TGeoObj(ObjList.Items[sn]) is TGIPolynomFkt then begin
        GO := TGeoObj(ObjList.Items[sn]) as TGIPolynomFkt;
        if (GO.Parent.Count = 3) and
           getFramePt(true).IsAncestorOf(GO) and
           centerPt.IsAncestorOf(GO) and
           getFramePt(false).IsAncestorOf(GO) then
          Result := GO;
        end;  { of outer if }
      sn := sn + 1;
      end; { of while }
    end;

  var CP:  TGIPolynomFkt;
      PL:  TList<TGPoint>;
      n,
      err_num : Integer;
  begin
  if nv <> ShowCurvatureParabola then
    if nv then begin
      PL := TList<TGPoint>.Create;
      PL.add(getFramePt(true));
      PL.add(centerPt);
      PL.add(getFramePt(false));
      CP := TGIPolynomFkt.Create(ObjList, PL);
      ObjList.InsertObject(CP, err_num);
      FreeAndNil(PL);
      fShowCurvatureParabola := True;
      end
    else begin
      n := ObjList.IndexOf(Self);
      CP := findCurvatureParabola(n);
      if CP <> Nil then
        ObjList.FreeObject(CP);
      fShowCurvatureParabola := False;
      end;
  end;


procedure TGZoomFrame.UpdateScreenCoords;
  var i, sx, sy : Integer;
  begin
  for i := 0 to 3 do begin
    ObjList.GetWinCoords(vertex[i].x, vertex[i].y, sx, sy);
    scrVertex[i].X := sx;
    scrVertex[i].Y := sy;
    end;
  if Assigned(Hauptfenster.MagnGlassWin) then begin
    Hauptfenster.MagnGlassFrame.MGWin_dx :=
          Hauptfenster.MagnGlassWin.Left - Hauptfenster.Left;
    Hauptfenster.MagnGlassFrame.MGWin_dy :=
          Hauptfenster.MagnGlassWin.Top  - Hauptfenster.Top;
    Hauptfenster.MagnGlassWin.Invalidate;
    end;
  end;

procedure TGZoomFrame.AdjustGraphTools(todraw : Boolean);
  begin
  Inherited AdjustGraphTools(todraw);
  With ObjList.TargetCanvas do begin
    Brush.Style := bsSolid;
    Brush.Color := LightCol(clYellow, 0.25);
    Pen.Width := 3;
    if todraw then
      Pen.Color := clGray
    else
      Pen.Color := clWhite;
    end;
  end;

procedure TGZoomFrame.DrawIt;
  begin
  AdjustGraphTools(true);
  ObjList.TargetCanvas.Rectangle(scrVertex[1].x,     scrVertex[1].y,
                                 scrVertex[3].x + 1, scrVertex[3].y - 1);
  end;

procedure TGZoomFrame.HideIt;
  begin
  AdjustGraphTools(false);
  ObjList.TargetCanvas.Rectangle(scrVertex[1].x,     scrVertex[1].y,
                                 scrVertex[3].x + 1, scrVertex[3].y - 1);
  end;


procedure TGZoomFrame.ExportIt;
  begin
  // Nothing to do here.
  end;


procedure TGZoomFrame.DragIt;
  var fpli, fpre : TGFramePt;
  begin
  UpdateParams;
  fpli := getFramePt(true);
  fpre := getFramePt(false);
  if assigned(fpli) then
    fpli.UpdateParams;
  if assigned(fpre) then
    fpre.UpdateParams;
  end;


{================ TGFramePt =======================}

constructor TGFramePt.Create(iGeoList: TGeoObjListe; iZoomFrame: TGZoomFrame; iLeft: Boolean);
  begin
  Inherited Create(iGeoList, 0.0, 0.0, false);
  left      := iLeft;
  if left then
    SetNewName('Ali')
  else
    SetNewName('Are');
  ZoomFrame := iZoomFrame;
  BecomesChildOf(ZoomFrame);
  UpdateParams;
  MyShape := 1;
  ShowsAlways := True;
  end;

constructor TGFramePt.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var pos  : IXMLNode;
  begin
  Inherited CreateFromDomData(iObjList, DE);
  pos := DE.ChildNodes.FindNode('position');
  if StrToInt(pos.getAttribute('left')) = 1 then
    left := True
  else
    left := False;
  end;

function TGFramePt.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var res, pos : IXMLNode;
      sleft    : String;
  begin
  res := Inherited CreateObjNode(DOMDoc);
  pos := res.ChildNodes.FindNode('position');
  if Assigned(pos) then begin
    if left then
      sleft := '1'
    else
      sleft := '0';
    pos.setAttribute('left', sleft);
    end;
  Result := res;
  end;

procedure TGFramePt.AfterLoading(FromXML : Boolean);
  begin
  Inherited AfterLoading(FromXML);
  ZoomFrame := TGeoObj(Parent[0]) as TGZoomFrame;
  end;

procedure TGFramePt.UpdateParams;
  var h, fx : Double;
      f     : TGFunktion;
  begin
  DataValid := False;
  h := ZoomFrame.h;
  if left then
    X := ZoomFrame.centerPt.X - h
  else
    X := ZoomFrame.centerPt.X + h;
  if TGeoObj(ZoomFrame.centerPt.Parent[0]) is TGFunktion then begin
    f := TGeoObj(ZoomFrame.centerPt.Parent[0]) as TGFunktion;
    if f.GetFunctionValue(X, fx) then begin
      Y := fx;
      DataValid := True;
      end;
    end;
  if DataValid then
    UpdateScreenCoords;
  end;

function TGFramePt.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := (inherited HasSameDataAs(GO)) and
            ( (GO as TGFramePt).left = Self.left );
  end;


{=============== TGImage ========================}

constructor TGImage.Create(iGeoList: TGeoObjListe; FileName: String);
  var xmid, ymid : Integer;
      bmp        : TBitmap;
  begin
  Inherited Create(iGeoList, False); // Vorsichtshalber unsichtbar erzeugen !!!
  MyPenStyle   := psSolid;
  MyLineWidth  := 3;
  MyColour     := clGray;
  MyBrushStyle := bsSolid;
  IsLocked     := True;
  FName        := ObjList.GetUniqueName(id_picname);
  If Length(FileName) > 0 then begin
    pic := TPicture.Create;
    try
      pic.LoadFromFile(FileName);
      bmp := TBitmap.Create;
      try      // Erzwingt korrektes Clipping an picRect, auch für krude WMF/EMF!
        bmp.Width  := pic.Graphic.Width;
        bmp.Height := pic.Graphic.Height;
        bmp.Canvas.Draw(0, 0, pic.Graphic);
        pic.Assign(bmp);
      finally
        bmp.Free;
      end;
      ObjList.GetWinCoords(ObjList.xCenter, ObjList.yCenter, xmid, ymid);
      scrx := xmid - pic.Graphic.Width Div 2;
      scry := ymid - pic.Graphic.Height Div 2;
      FPicRect := Rect(scrx, scry,
                       scrx + pic.Graphic.Width, scry + pic.Graphic.Height);
      ObjList.GetLogCoords(scrx, scry, X, Y);
      ObjList.GetLogCoords(scrx + pic.Graphic.Width, scry + pic.Graphic.Height,
                           X2, Y2);
      ShowsAlways := True;
    except
      FreeAndNil(pic);
    end;  { of try }
    end; { of if }
  end;


constructor TGImage.CreateFromBMP(iGeoList: TGeoObjListe; BMP: TBitmap; iX1, iY1, iX2, iY2: Double);
  var scrx2, scry2 : Integer;
  begin
  Inherited Create(iGeoList, False); // Vorsichtshalber unsichtbar erzeugen !!!
  MyPenStyle   := psSolid;
  MyLineWidth  := 3;
  MyColour     := clGray;
  MyBrushStyle := bsSolid;
  IsLocked     := True;
  pic := TPicture.Create;
  try
    pic.Assign(BMP);
    X := iX1;
    Y := iY1;
    X2 := iX2;
    Y2 := iY2;
    ObjList.GetWinCoords(X,  Y,  scrx,  scry);
    ObjList.GetWinCoords(X2, Y2, scrx2, scry2);
    FPicRect := Rect(scrx, scry, scrx2, scry2);
    ShowsAlways := True;
  except
    FreeAndNil(pic);
  end;  { of try }
  end;


constructor TGImage.CreateFromDOMData(iObjList: TGeoObjListe; DE: IXMLNode);
  var pos,
      data  : IXMLNode;
      s     : String;
      scrx2, scry2 : Integer;
      start : Cardinal;
  begin
  Inherited CreateFromDOMData(iObjList, DE);
  FMyPenStyle   := psSolid;
  FMyLineWidth  := 3;
  FMyColour     := clGray;
  FMyBrushStyle := bsSolid;
  IsLocked      := True;

  pos := DE.childNodes.findNode('position', '');
  s   := pos.getAttribute('lefttop');
  GetFloatPair(s, X, Y);
  s   := pos.getAttribute('rightbottom');
  GetFloatPair(s, X2, Y2);

  pic := TPicture.Create;
  data := DE.childNodes.findNode('data', '');
  If data <> Nil then
    begin
    SpyOut(#0009#0009 + 'Start building picture from XML data', []);
    start := GetTickCount;
    s := data.nodeValue;
    LoadPNGfromXXString(s);
    s := '';
    SpyOut(#0009#0009 + 'Ready building picture after %6.3f sec.',
            [ (GetTickCount - start)/1000 ]);
    ObjList.GetWinCoords(X,  Y,  scrx,  scry);
    ObjList.GetWinCoords(X2, Y2, scrx2, scry2);
    FPicRect := Rect(scrx, scry, scrx2, scry2);
    ShowsAlways := True;
    end;
  end;


function TGImage.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var position,
      data : IXMLNode;
      s    : String;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  position := DOMDoc.createNode('position');
  s := FloatToStr(X) + ';' + FloatToStr(Y);
  position.setAttribute('lefttop', s);
  s := FloatToStr(X2) + ';' + FloatToStr(Y2);
  position.setAttribute('rightbottom', s);
  Result.childNodes.add(position);

  If HasPic then begin
    data := DOMDoc.createNode('data');
    s := SavePNGtoXXString;
    data.childNodes.add(DOMDoc.createNode(s, ntCData));
    Result.childNodes.add(data);
    end;
  end;


destructor TGImage.Destroy;
  begin
  ShowsAlways := False;
  pic.Free;
  Inherited Destroy;
  end;


function TGImage.SavePNGtoXXString: String;
  var PNG : TPngImage;
      BMP : TBitmap;
      MS  : TMemoryStream;
      s   : String;
  begin
  Result := '';
  MS := TMemoryStream.Create;
  try
    If pic.Graphic is TPngImage then
      TPngImage(pic.Graphic).SaveToStream(MS)
    else begin
      PNG := TPngImage.Create;
      try
        if pic.Graphic is TBitmap then
          PNG.Assign(TBitmap(pic.Graphic))
        else begin
          BMP := TBitmap.Create;
          try
            BMP.Assign(pic.Graphic);
            PNG.Assign(BMP);
          finally
            BMP.Free;
          end;
        end;
        PNG.CompressionLevel := 9;
        PNG.SaveToStream(MS);
      finally
        PNG.Free;
      end; { of try }
      end; { of else }
    If (MS.Size > 0) and
       EncryptStream2XXString(MS, s) and
       (Length(s) > 0) then begin
      Result := s;
      end;
  finally
    MS.Free;
  end;
  end;


procedure TGImage.LoadPNGfromXXString(s : String);
  var MS  : TMemoryStream;
      PNG : TPngImage;
  begin
  MS  := TMemoryStream.Create;
  MS.SetSize(Length(s));
  try
    DecryptXXString2Stream(s, MS);
    PNG := TPngImage.Create;
    try
      MS.Position := 0;
      PNG.LoadFromStream(MS);
      pic.Bitmap.Width := PNG.Width;
      pic.Bitmap.Height := PNG.Height;
      PNG.Draw(pic.Bitmap.Canvas,
               Rect(0, 0, PNG.Width, PNG.Height));
    finally
      PNG.Free;
    end;
  finally
    MS.Free;
  end;
  end;

function TGImage.GetHasPic: Boolean;
  begin
  GetHasPic := pic <> Nil;
  end;


function TGImage.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccAnyGeoObj, ccMappableObj]) or
            ((Not IsLocked) and (ClassGroupId = ccDragableObj));
  end;


function TGImage.HasSameDataAs(GO: TGeoObj): Boolean;
  begin
  Result := False;
  end;


procedure TGImage.AdjustGraphTools(todraw : Boolean);
  begin
  With ObjList.TargetCanvas do begin
    If todraw then begin
      Pen.Width   := MyLineWidth;
      If ShowsAlways then begin
        Pen.Color   := MyColour;
        Pen.Style   := MyPenStyle;       { My Pen }
        Brush.Style := bsClear;          { Keine Füllung ! }
        end
      else
        If ShowsOnlyNow then begin
          Pen.Color   := clSilver;
          Pen.Style   := psDash;         { TempPen }
          Brush.Color := clWhite;
          Brush.Style := bsDiagCross;
          end;
      end
    else begin
      Pen.Style := MyPenStyle;  {Am 28.12.99 durch psSolid ersetzt; }
           { am 12.01.00 wieder rückgängig gemacht wg. Pixelresten !}
      Pen.Color   := ObjList.BackGroundColor;
      Pen.Width   := MyLineWidth;
      Brush.Color := ObjList.BackgroundColor;
      Brush.Style := bsSolid;
      end;
    end;
  end;


procedure TGImage.DrawIt;
  var oldCopyMode : Integer;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    If ShowsOnlyNow then with ObjList.TargetCanvas do begin
      FillRect(picRect);
      oldCopyMode := CopyMode;
      CopyMode    := cmSrcPaint;
      StretchDraw(picRect, pic.Graphic);
      CopyMode    := oldCopyMode;
      end
    else begin
      ObjList.TargetCanvas.StretchDraw(picRect, pic.Graphic);
      If Not IsLocked then
        ObjList.TargetCanvas.Rectangle(picRect);
      end;  
    end;
  end;


procedure TGImage.HideIt;
  var R : TRect;
  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    If (Not IsLocked) or ShowsOnlyNow then begin
      R := picRect;
      InflateRect(R, 1, 1);
      ObjList.TargetCanvas.Rectangle(R);
      end
    else
      ObjList.TargetCanvas.Rectangle(picRect);
    end;
  end;


procedure TGImage.CalcDist(sm: TPoint);
  var InnerRect,
      OuterRect : TRect;
  begin
  InnerRect := PicRect; InflateRect(InnerRect, -CatchDist, -CatchDist);
  OuterRect := PicRect; InflateRect(OuterRect, CatchDist, CatchDist);
  If PtInRect(OuterRect, sm) then begin
    LastDist := 0;
    If (Not PtInRect(InnerRect, sm)) and
       (Not IsLocked) then begin
      If sm.x > InnerRect.Right then
        LastDist := LastDist - 1
      else
        If sm.x < InnerRect.Left then
          LastDist := LastDist - 4;
      If sm.y < InnerRect.Top then
        LastDist := LastDist - 2
      else
        If sm.y > InnerRect.Bottom then
          LastDist := LastDist - 8;
      end
    end
  else
    LastDist := 10000;
  end;

function TGImage.Dist(xm, ym: Double): Double;
  { Im Innern des Bildes ist Dist = 0, außerhalb ist Dist = 10000.
    Dicht beim Rand ist Dist < 0. Die einzelnen Bits von
    Integer(-Dist) haben folgende Bedeutung:
         Bit 0 (LSB) : rechter Rand
         Bit 1       : oberer Rand
         Bit 2       : linker Rand
         Bit 4       : unterer Rand                                  }
  var sm: TPoint;
  begin
  ObjList.GetWinCoords(xm, ym, sm.x, sm.y);
  CalcDist(sm);
  Result := LastDist;
  end;


function TGImage.IsNearMouse: Boolean;
  begin
  CalcDist(ObjList.LastMousePos);
  Result := LastDist <= 0;
  end;


function TGImage.GetMatchingCursor(mpt: TPoint): TCursor;
  begin
  If IsLocked then
    Result := crDefault
  else
    Case SafeRound(LastDist) of
       0      : Result := crSizeAll;
      -1,  -4 : Result := crSizeWE;
      -2,  -8 : Result := crSizeNS;
      -3, -12 : Result := crSizeNESW;
      -6,  -9 : Result := crSizeNWSE;
    else
      Result := crDefault;
    end; { of case }
  end;


function TGImage.GetVertices(var v: Array of TFloatPoint): Boolean;
  begin
  If DataValid then begin
    v[0].x := X;   v[0].y := Y;
    v[1].x := X2;  v[1].y := Y;
    v[2].x := X2;  v[2].y := Y2;
    Result := True;
    end
  else
    Result := False;
  end;


procedure TGImage.UpdateParams;
  { 06.09.05 :  Beim Ziehen an den Ecken wird die Größe des Bildes geändert,
                wobei aber das Seitenverhältnis stets auf das des Original-
                Bildes zurückgesetzt wird. Die Mausposition bestimmt dabei
                die neue Größe der jeweils längeren Bildkante.
    25.05.06 :  Verriegelung gegen das Überschlagen des Bildes beim Ver-
                ziehen eingebaut. Dies sichert, dass zwar Position und
                Größe des Bildes mit der Maus geändert werden können,
                nicht aber die Orientierung !                            }
  var minWH : Double;    // Minimale Breite und Höhe des Bildes 
  begin
  If Not IsLocked then begin
    minWH := 4 * CatchDist / act_PixelPerXcm;
    Case SafeRound(LastDist) of
        0 : With picRect do begin  { Ganzes Bild verschieben }
              X  := X  + ObjList.LastLogMouseDX;
              Y  := Y  + ObjList.LastLogMouseDY;
              X2 := X2 + ObjList.LastLogMouseDX;
              Y2 := Y2 + ObjList.LastLogMouseDY;
              end;
       -1 : X2 := Max(ObjList.LastLogMouseX, X  + minWH);  //  Right
       -2 : Y  := Max(ObjList.LastLogMouseY, Y2 + minWH);  //  Top
       -3 : If Pic.Width > Pic.Height then begin           //  TopRight
              X2 := Max(ObjList.LastLogMouseX, X + minWH);
              Y  := Y2 + (X2 - X) * Pic.Height / Pic.Width;
              end
            else begin
              Y  := Max(ObjList.LastLogMouseY, Y2 + minWH);
              X2 := X + (Y - Y2) * Pic.Width / Pic.Height;
              end;
       -4 : X  := Min(ObjList.LastLogMouseX, X2 - minWH);  //  Left
       -6 : If Pic.Width > Pic.Height then begin           //  TopLeft
              X  := Min(ObjList.LastLogMouseX, X2 - minWH);
              Y  := Y2 + (X2 - X) * Pic.Height / Pic.Width;
              end
            else begin
              Y  := Max(ObjList.LastLogMouseY, Y2 + minWH);
              X  := X2 - (Y - Y2) * Pic.Width / Pic.Height;
              end;
       -8 : Y2 := Min(ObjList.LastLogMouseY, Y - minWH);   //  Bottom
       -9 : If Pic.Width > Pic.Height then begin           //  BottomRight
              X2 := Max(ObjList.LastLogMouseX, X + minWH);
              Y2 := Y - (X2 - X) * Pic.Height / Pic.Width;
              end
            else begin
              Y2 := Min(ObjList.LastLogMouseY, Y - minWH);
              X2 := X + (Y - Y2) * Pic.Width / Pic.Height;
              end;
      -12 : If Pic.Width > Pic.Height then begin           //  BottomLeft
              X  := Min(ObjList.LastLogMouseX, X2 - minWH);
              Y2 := Y - (X2 - X) * Pic.Height / Pic.Width;
              end
            else begin
              Y2 := Min(ObjList.LastLogMouseY, Y - minWH);
              X  := X2 - (Y - Y2) * Pic.Width / Pic.Height;
              end;
    end; { of case }
    end { of if }
  else begin
    // nix zu tun !
    end;
  UpdateScreenCoords;
  end;


procedure TGImage.UpdateScreenCoords;
  var sx, sy : Integer;
  begin
  ObjList.GetWinCoords(X, Y, sx, sy);
  FPicRect.TopLeft := Point(sx, sy);
  ObjList.GetWinCoords(X2, Y2, sx, sy);
  FPicRect.BottomRight := Point(sx, sy);
  end;


procedure TGImage.DragIt;
  begin
  If Not IsLocked then
    Inherited DragIt;
  end;


procedure TGImage.LoadContextMenuEntriesInto(menu: TPopUpMenu);
  begin
  menu.Items.Clear;    { "Free"d auch die einzelnen Items ! }
  AddPopupMenuItemTo(menu, cme_imagehide, CME_PopupClick, cmd_ToggleVis);
  If IsLocked then
    AddPopupMenuItemTo(menu, cme_frameedit, CME_PopupClick, cmd_ImageEdit)
  else
    AddPopupMenuItemTo(menu, cme_framelock, CME_PopupClick, cmd_ImageEdit);
  end;


function TGImage.GetInfo: String;
  begin
  Result := MyObjTxt[81];
  InsertNameOf(Self, Result);
  end;



{=============== TGMappedImage ========================}

constructor TGMappedImage.Create(iGeoList: TGeoObjListe; iPImage: TGImage;
                                 iTransf: TGTransformation; iisVisible: Boolean);
  begin
  Inherited Create(iGeoList, '');
  BecomesChildOf(iPImage);
  BecomesChildOf(iTransf);
  If Pic = Nil then
    Pic := TPicture.Create;
  UpdateParams;
  ShowsAlways := iisVisible;
  end;

constructor TGMappedImage.CreateFromDOMData(iObjList: TGeoObjListe; DE: IXMLNode);
  var domPos : IXMLNode;
      s      : String;
  begin
  Inherited CreateFromDOMData(iObjList, DE);

  domPos := DE.childNodes.findNode('position', '');
  If domPos <> Nil then begin
    s   := domPos.getAttribute('leftbottom');
    If Length(s) > 0 then
      GetFloatPair(s, X1, Y1);
    end;
  end;

function TGMappedImage.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var domPos : IXMLNode;
      s      : String;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  domPos := Result.childNodes.findNode('position', '');
  If domPos <> Nil then begin
    s := FloatToStr(X1) + ';' + FloatToStr(Y1);
    domPos.setAttribute('leftbottom', s);
    end;
  end;

function TGMappedImage.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := (ClassGroupId in [ccAnyGeoObj, ccMappableObj]);
  end;

function TGMappedImage.Dist(xm, ym: Double): Double;
  { Im Innern des Bildes ist Dist = 0, außerhalb ist Dist = 10000. }
  var sx, sy : Integer;
  begin
  ObjList.GetWinCoords(xm, ym, sx, sy);
  If PtInRegion(AreaHnd, sx, sy) then
    Result := 0
  else
    Result := 10000;
  end;

function TGMappedImage.IsNearMouse: Boolean;
  begin
  Result := PtInRegion(AreaHnd,
                       ObjList.LastMousePos.X,
                       ObjList.LastMousePos.Y);
  end;

function TGMappedImage.GetHasPic: Boolean;
  { übergibt immer FALSE, auch wenn das Objekt eine Kopie des Bildes
    speichert; diese wird nur zum Beschleunigen der Ausgabe gebraucht }
  begin
  Result := False;
  end;

function TGMappedImage.GetVertices(var v: Array of TFloatPoint): Boolean;
  begin
  If DataValid then begin
    v[0].x := X;   v[0].y := Y;
    v[1].x := X1;  v[1].y := Y1;
    v[2].x := X2;  v[2].y := Y2;
    Result := True;
    end
  else
    Result := False;
  end;


procedure TGMappedImage.LoadContextMenuEntriesInto(menu: TPopupMenu);
  begin
  menu.Items.Clear;    { "Free"d auch die einzelnen Items ! }
  AddPopupMenuItemTo(menu, cme_imagehide, CME_PopupClick, cmd_ToggleVis);
  end;

procedure TGMappedImage.UpdateParams;
  var pv : Array [0..3] of TFloatPoint;
      pp : TGImage;
      pm : TGTransformation;
  begin
  try
    DataValid := False;
    pp := TGeoObj(Parent[0]) as TGImage;
    pp.GetVertices(pv);  { Ecken des Urbildes holen ! }

    While Not pp.HasPic do
      pp := TGeoObj(pp.Parent[0]) as TGImage;
    If (pp.Pic.Width <> Pic.Width) or
       (pp.Pic.Height <> Pic.Height) then begin
      Pic.Bitmap.Width  := pp.Pic.Width;
      Pic.Bitmap.Height := pp.Pic.Height;
      Pic.Bitmap.Canvas.Draw(0, 0, pp.Pic.Graphic);
      end;

    pm := TGeoObj(Parent[1]) as TGTransformation;
    If pm.GetMappedPoint(pv[0], pv[3]) then begin
      X := pv[3].x; Y := pv[3].y;
      If pm.GetMappedPoint(pv[1], pv[3]) then begin
        X1 := pv[3].x; Y1 := pv[3].y;
        If pm.GetMappedPoint(pv[2], pv[3]) then begin
          X2 := pv[3].x; Y2 := pv[3].y;
          DataValid := True;
          UpdateScreenCoords;
          end;
        end;
      end;
  except
    DataValid := False;
  end; { 0f try }
  end;

procedure TGMappedImage.UpdateScreenCoords;
  var i : Integer;
  begin
  ObjList.GetWinCoords(X,  Y,  scrpt[0].X, scrpt[0].Y);
  ObjList.GetWinCoords(X1, Y1, scrpt[1].X, scrpt[1].Y);
  ObjList.GetWinCoords(X2, Y2, scrpt[2].X, scrpt[2].Y);
  For i := 0 to 2 do
    para[i] := scrpt[i];
  { Jetzt enthält scrpt[2] die Koordinaten der *rechten* unteren Ecke.
    Für die Ausgabe werden jedoch stattdessen die Koordinaten der
    *linken* unteren Ecke gebraucht :        }
  scrpt[2].X := scrpt[2].X - (scrpt[1].X - scrpt[0].X);
  scrpt[2].Y := scrpt[2].Y - (scrpt[1].Y - scrpt[0].Y);
  para[3] := scrpt[2];
  If AreaHnd <> 0 then
    DeleteObject(AreaHnd);
  AreaHnd := CreatePolygonRgn(para, 4, Winding);
  end;


procedure TGMappedImage.DragIt;
  begin
  HideIt;
  UpdateParams;
  DrawIt;
  end;

procedure TGMappedImage.DrawIt;
  var oldCopyMode : Integer;
  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    PlgBlt(ObjList.TargetCanvas.Handle, scrpt,
           Pic.Bitmap.Canvas.Handle, 0, 0,
           Pic.Width, Pic.Height, 0, 0, 0);
    If ShowsOnlyNow then with ObjList.TargetCanvas do begin
      oldCopyMode := CopyMode;
      CopyMode    := cmSrcPaint;
      FillRgn(Handle, AreaHnd, Brush.Handle);
      CopyMode    := oldCopyMode;
      end;
    end;
  end;

procedure TGMappedImage.HideIt;
  begin
  If IsVisible then begin
    AdjustGraphTools(False);
    FillRgn(ObjList.TargetCanvas.Handle, AreaHnd,
            ObjList.TargetCanvas.Brush.Handle);
    end;
  end;

function TGMappedImage.GetInfo: String;
  begin
  Result := MyObjTxt[82];
  InsertNameOf(Self, Result);
  InsertNameOf(TGeoObj(parent[0]), Result);
  end;



{=============== TGSetsquare ========================}


constructor TGSetsquare.Create(iGeoList: TGeoObjListe; iisVisible: Boolean);
  begin
  Inherited Create(iGeoList, Nil, Nil, False);
  If Pic = Nil then
    Pic := TPicture.Create;
  Pic.Bitmap.LoadFromResourceName(HInstance, 'SETSQUARE');
  BufBMP   := TBitmap.Create;

  halflen := SetSquareHalfLen;
  BufBMP.PixelFormat := GetScreenPixelFormat;
  BufBMP.Width := Ceil(halfLen * 2 * ObjList.e1x);
  BufBMP.Height := Ceil(halfLen * 2 * ObjList.e2y);
  Rotating := True;

  X  := -halflen;  Y  := 0;
  X0 :=        0;  Y0 := 0;
  UpdateParams;

  If iisVisible then
    ShowsAlways := True;
  end;

constructor TGSetsquare.CreateFromDOMData(iObjList: TGeoObjListe; DE: IXMLNode);
  var domPos : IXMLNode;
      s      : String;
  begin
  inherited CreateFromDOMData(iObjList, DE);
  If Pic = Nil then
    Pic := TPicture.Create;
  Pic.Bitmap.LoadFromResourceName(HInstance, 'SETSQUARE');

  domPos := DE.childNodes.findNode('position', '');
  If domPos <> Nil then begin
    s   := domPos.getAttribute('midtop');
    If Length(s) > 0 then
      GetFloatPair(s, X0, Y0);
    end;
  end;

destructor TGSetsquare.Destroy;
  begin
  ShowsAlways := False;
  FreeAndNil(BufBMP);
  inherited Destroy;
  end;

procedure TGSetsquare.AfterLoading(FromXML : Boolean = True);
  begin
  Inherited AfterLoading(FromXML);
  halflen  := Hypot(X - X0, Y - Y0);
  BufBMP   := TBitmap.Create;
  BufBMP.PixelFormat := GetScreenPixelFormat;
  BufBMP.Width  := Ceil(halfLen * 2 * ObjList.e1x);
  BufBMP.Height := Ceil(halfLen * 2 * ObjList.e2y);
  Rotating := True;
  end;

function TGSetsquare.CreateObjNode(DOMDoc: IXMLDocument): IXMLNode;
  var domPos : IXMLNode;
      s      : String;
  begin
  Result := Inherited CreateObjNode(DOMDoc);

  domPos := Result.childNodes.findNode('position', '');
  If domPos <> Nil then begin
    s := FloatToStr(X0) + ';' + FloatToStr(Y0);
    domPos.setAttribute('midtop', s);
    end;
  end;

function TGSetsquare.Dist(xm, ym: Double): Double;
  { Im Innern des Bildes ist Dist <= 0, außerhalb ist Dist = 10000. }
  var sx, sy : Integer;
  begin
  ObjList.GetWinCoords(xm, ym, sx, sy);
  If PtInRegion(MouseHnd, sx, sy) then
    If Hypot(xm - X0, ym - Y0) * 2 < halflen then
      LastDist := -1    // im inneren Kreis...
    else
      LastDist := 0     // ... bzw. außen angepackt
  else
    LastDist := 10000;
  Result := LastDist;
  end;

function TGSetsquare.IsNearMouse: Boolean;
  begin
  Result := PtInRegion(MouseHnd,
                       ObjList.LastMousePos.X,
                       ObjList.LastMousePos.Y);
  end;

procedure TGSetsquare.Check4Angle2Measure;
  var i : Integer;
      vPt  : TGPoint;
      aObj : TGeoObj;
  begin
  SelAngle  := Nil;
  SelVertex := Nil;
  aObj      := Nil;
  for i := 5 to ObjList.Count - 1 do
    if TGeoObj(ObjList.Items[i]) is TGPoint then begin
      vPt := ObjList.Items[i];
      if vPt.IsAngleVertex(aObj) and
         (Hypot(vPt.X - X0, vPt.Y - Y0) < 0.1) then begin
        SelAngle  := aObj;
        SelVertex := vPt;
        end;
      end;
  end;

procedure TGSetsquare.Rescale;
  begin
  BufBMP.Width  := Ceil(halfLen * 2 * Abs(ObjList.e1x));
  BufBMP.Height := Ceil(halfLen * 2 * Abs(ObjList.e2y));
  Rotating := True;
  UpdateScreenCoords;
  end;

procedure TGSetsquare.DrawIt;

  procedure MarkLineOnFirstLegOfAngle;
    var dx, dy : Integer;
    begin
    dx := sx - sx0;
    dy := sy - sy0;
    With ObjList.TargetCanvas do begin
      MoveTo(Round(sx0 + 0.1 * dx), Round(sy0 + 0.1 * dy));
      LineTo(Round(sx0 + 0.9 * dx), Round(sy0 + 0.9 * dy));
      end;
    end;

  begin
  If IsVisible then begin
    AdjustGraphTools(True);
    With ObjList.TargetCanvas do begin
      Pen.Width := 5;
      Pen.Color := LightCol(clBlue);
      if AngleFocussed then
        MarkLineOnFirstLegOfAngle;
      Pen.Width := 3;
      if VertexFocussed then
        Arc(sx0 - 10, sy0 - 10, sx0 + 10, sy0 + 10, sx0 + 10, sy0, sx0 + 10, sy0);
      end;
    BitBlt(ObjList.TargetCanvas.Handle,
           sx0 - BufBMP.Width Div 2,
           sy0 - BufBMP.Height Div 2,
           BufBMP.Width, BufBMP.Height,
           BufBMP.Canvas.Handle, 0, 0, SRCAND);
    end;
  end;

function TGSetsquare.IsCompatibleWith(ClassGroupId: Integer): Boolean;
  begin
  Result := ClassGroupId in [ccDragableObj, ccAnyGeoObj];
  end;

function TGSetSquare.SSDirOnLegOfAngle(ALPt : TGPoint) : Boolean;
  var LineEq: TVector3;
      d : Double;
  begin
  Result := False;
  LineEq := TVector3.Create(0, 0, 0);
  Try
    If GetHesseEqFromPtAndDir(X0, Y0, X - X0, Y - Y0, LineEq) then begin
      d := DistPt2Line(LineEq, ALPt.X, ALPt.Y);
      Result := d < 0.1;
      end;
  Finally
    FreeAndNil(LineEq);
  End;
  end;

procedure TGSetsquare.UpdateParams;
  var X_alt, Y_alt,
      X_neu, Y_neu,
      dx, dy,
      rotangl,
      d           : Double;
  begin
  If ObjList.dragged_by_mouse = Self then begin
    d := Hypot(ObjList.LastLogMouseX - X0, ObjList.LastLogMouseY - Y0);
    If d * 2 < halflen then begin  // Verschieben: (X;Y) und (X0;Y0) synchron verschieben
      X := X + ObjList.LastLogMouseDX;
      Y := Y + ObjList.LastLogMouseDY;
      X0 := X0 + ObjList.LastLogMouseDX;
      Y0 := Y0 + ObjList.LastLogMouseDY;
      Rotating := False;
      end
    else begin                     // Drehen: (X;Y) um (X0;Y0) drehen
      X_neu := ObjList.LastLogMouseX;
      Y_neu := ObjList.LastLogMouseY;
      X_alt := X_neu - ObjList.LastLogMouseDX;
      Y_alt := Y_neu - ObjList.LastLogMouseDY;
      rotangl := Signed_Angle(X_alt - X0, Y_alt - Y0, X_neu - X0, Y_neu - Y0);
      If Abs(rotangl) > epsilon then begin
        RotateVector2ByAngle(X - X0, Y - Y0, rotangl, dx, dy);
        X := X0 + dx;
        Y := Y0 + dy;
        Rotating := True;
        end;
      end;
    end;
  X1 := X0 + (X0 - X);
  Y1 := Y0 + (Y0 - Y);
  X2 := X1 + (Y0 - Y);
  Y2 := Y1 - (X0 - X);

  Check4Angle2Measure;
  VertexFocussed := (SelVertex <> Nil) and
                    (Hypot(SelVertex.X - X0, SelVertex.Y - Y0) < 0.1);
  AngleFocussed  := (SelAngle <> Nil) and (VertexFocussed) and
                    (SSDirOnLegOfAngle(SelAngle.Parent[0]));
  PosFlag := BuildPosFlag(VertexFocussed, AngleFocussed);
  UpdateScreenCoords;
  end;

procedure TGSetSquare.MoveAndTurnRandomly;
  var rx, ry, ra    : Integer;
      dx, dy, angle : Double;
  begin
  // Choose random data
  rx := Random(1001) - 500;
  ry := Random(1001) - 500;
  dx := 0.01 * rx;
  dy := 0.01 * ry;
  ra := Random(3600) - 1800;
  angle := pi / 1800 * ra;
  // Transform the vertizes
  X := X + dx;
  Y := Y + dy;
  X0 := X0 + dx;
  Y0 := Y0 + dy;
  RotateVector2ByAngle(X - X0, Y - Y0, angle, dx, dy);
  X := X0 + dx;
  Y := Y0 + dy;
  X1 := X0 + (X0 - X);
  Y1 := Y0 + (Y0 - Y);
  X2 := X1 + (Y0 - Y);
  Y2 := Y1 - (X0 - X);
  Rotating := True;

  Check4Angle2Measure;
  VertexFocussed := (SelVertex <> Nil) and
                    (Hypot(SelVertex.X - X0, SelVertex.Y - Y0) < 0.1);
  AngleFocussed  := (SelAngle <> Nil) and (VertexFocussed) and
                    (SSDirOnLegOfAngle(SelAngle.Parent[0]));
  PosFlag := BuildPosFlag(VertexFocussed, AngleFocussed);
  UpdateScreenCoords;
  end;

procedure TGSetSquare.SetResWinHandle(newHandle: THandle);
  begin
  ResWinHandle := newHandle;
  end;

procedure TGSetSquare.SetPosFlag(newPF: Integer);
  var oldPF : Integer;
  begin
  oldPF := PosFlag;
  if newPF <> oldPF then begin
    FPosFlag := newPF;
    if ResWinHandle > 0 then
      SendMessage(ResWinHandle, cmd_PosFlagChange, newPF, 0);
    end;
  end;

procedure TGSetsquare.UpdateScreenCoords;
  var OriPt : TPoint;
      dx, dy,
      i     : Integer;
  begin
  Inherited UpdateScreenCoords;
  ObjList.GetWinCoords(X0, Y0, sx0, sy0);
  ObjList.GetWinCoords(X,  Y,  sx,  sy );

  // Area-Handle für IsNearMouse-Test besorgen
  para[2].X := (para[2].X + para[3].X) div 2;
  para[2].Y := (para[2].Y + para[3].Y) div 2;
  If MouseHnd <> 0 then
    DeleteObject(MouseHnd);
  MouseHnd := CreatePolygonRgn(para, 3, Winding);

  // Neue Vorlage erstellen?
  If Rotating then begin
    With BufBMP.Canvas do begin
      Brush.Style := bsSolid;
      Brush.Color := clWhite;
      BufBMP.Canvas.FillRect(Rect(0, 0, BufBMP.Width, BufBMP.Height));
      end;
    OriPt.X := BufBMP.Width Div 2;
    OriPt.Y := BufBMP.Width Div 2;
    para[2] := scrpt[2];
    dx := (para[0].X + para[1].X) div 2 - OriPt.X;
    dy := (para[0].Y + para[1].Y) div 2 - OriPt.Y;
    For i := 0 to 2 do begin
      para[i].X := para[i].X - dx;
      para[i].Y := para[i].Y - dy;
      end;
    PlgBlt(BufBMP.Canvas.Handle, para,
           Pic.Bitmap.Canvas.Handle, 0, 0,
           Round(Pic.Bitmap.Width * ObjList.ScaleFactor),
           Round(Pic.Bitmap.Height* ObjList.ScaleFactor),
           0, 0, 0);
    Rotating := False;
    end;
  end;

procedure TGSetsquare.LoadContextMenuEntriesInto(menu: TPopupMenu);
  begin
  inherited LoadContextMenuEntriesInto(menu);
  menu.Items[0].Caption := cme_hideSQO;
  end;

function TGSetsquare.GetInfo: String;
  begin
  Result := '';
  end;



initialization

RegisterClass(TGImage);
RegisterClass(TGMappedImage);
RegisterClass(TGSetsquare);
RegisterClass(TGZoomFrame);
RegisterClass(TGFramePt);

finalization

end.
