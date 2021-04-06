unit MagnGlassWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
  GeoTypes, GeoLocLines, GeoImage;

type
  TMyMagnGlassWin = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    hLen      : Integer;  // half of the length of one side of the quadratic PaintBox
    Scale     : Double;   // actual magnification value
    MyMainWin : TForm;
    MyCenterPt: TGPoint;
    MyFunktion: TGFunktion;
    MyDrawing : TGeoObjListe;
    MyBuffer  : TBitMap;
    procedure ShowSlopeTriangles(h: Double);
    procedure ShowSecantSlopes(h: Double);
  public
    constructor CreateWD(iOwner: TComponent; iCenterPt: TGPoint;
                         iMGWin_dx, iMGWin_dy: Integer);
    procedure RefreshBuffer;
  end;


implementation

uses MainWin, Declar, GlobVars, Utility, Math;

{$R *.dfm}

constructor TMyMagnGlassWin.CreateWD(iOwner: TComponent; iCenterPt: TGPoint;
                                     iMGWin_dx, iMGWin_dy: Integer);
  begin
  Inherited Create(iOwner);
  hLen  := 150;
  Scale := 1;
  MyMainWin  := iOwner as TForm;
  MyDrawing  := (MyMainWin as THauptFenster).Drawing;
  MyCenterPt := iCenterPt;
  MyFunktion := MyCenterPt.Parent[0];
  MyBuffer   := TBitMap.Create();
  Self.Left := MyMainWin.Left + iMGWin_dx;
  Self.Top  := MyMainWin.Top  + iMGWin_dy;
  MyBuffer.SetSize(2*hLen, 2*hLen);
  RefreshBuffer;
  end;

procedure TMyMagnGlassWin.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
  FreeAndNil(MyBuffer);
  With (MyMainWin as THauptFenster) do begin
    Drawing.FreeObject(MagnGlassFrame);
    MagnGlassFrame := Nil;
    MagnGlassWin := Nil;
    RefreshSpecialImageButtons;
    Invalidate;
    end;
  Action := caFree;
  end;

procedure TMyMagnGlassWin.PaintBox1Paint(Sender: TObject);
  begin
  PaintBox1.Canvas.Draw(0, 0, MyBuffer);
  end;

procedure TMyMagnGlassWin.RefreshBuffer;
  var h, wh, relScale : Double;
  begin
  h := (MyMainWin as THauptfenster).MagnGlassFrame.h;
  Label2.Caption := 'h = ' + Float2Str(h, 6) + ' cm';
  // Vergrößerung muss aktuelle Auflösung (ppcm!) berücksichtigen!
  //     "hLen - 10" statt nur "hLen" verlagert die Punkte Ali und
  //     Are etwas ins Innere der PaintBox.
  relScale := (hLen - 10) / act_PixelPerXcm / h;
  Label1.Caption := 'Vergrößerung: ' + Float2Str(relScale, 2) + '-fach';
  with MyBuffer.Canvas do begin
    Pen.Color   := clBlack;
    Pen.Width   := 3;
    Brush.Color := clWhite;
    Rectangle(Rect(0, 0, 2 * hlen, 2 * hlen));
    Pen.Color   := clGray;
    Brush.Color := LightCol(clYellow, 0.25);
    Rectangle(Rect(10, 10, 2 * hlen - 10, 2 * hlen - 10));
    end;
  With (MyMainWin as THauptfenster) do begin
    MagnGlassFrame.MGWin_dx := Self.Left - MyMainWin.Left;
    MagnGlassFrame.MGWin_dy := Self.Top  - MyMainWin.Top;
    if MagnGlassFrame.ShowSecants then begin
      ShowSlopeTriangles(h);
      ShowSecantSlopes(h);
      end;
    end;

  wh := hlen / act_PixelPerXcm / relScale;
  MyDrawing.ExportZoomed_To(MyBuffer.Canvas,
                            MyCenterPt.X - wh, MyCenterPt.Y + wh,
                            MyCenterPt.X + wh, MyCenterPt.Y - wh, relScale);
  Invalidate;
  end;

//========== Private Internal Helpers ================================ //

procedure TMyMagnGlassWin.ShowSlopeTriangles(h: Double);
  var pts : Array of TPoint;
      dy  : Double;
      du  : Integer;
  begin
  with (MyMainWin as THauptfenster).MagnGlassFrame do
    dy := getFramePt(true).Y - getCenterPt.Y;
  du := Round((hlen - 10) / h * dy);

  SetLength(pts, 3);
  pts[0] := Point(hlen, hlen   );
  pts[1] := Point(13, hlen     );
  pts[2] := Point(13, hlen - du);
  With MyBuffer.Canvas do begin
    Pen.Color := clGray;
    Brush.Color := clGray;
    Brush.Style := bsDiagCross;
    Polygon(pts);
    end;

  with (MyMainWin as THauptfenster).MagnGlassFrame do
    dy := getFramePt(false).Y - getCenterPt.Y;
  du := Round((hlen - 10) / h * dy);

  pts[1] := Point(286, hlen);
  pts[2] := Point(286, hlen - du);
  MyBuffer.Canvas.Polygon(pts);
  end;

procedure TMyMagnGlassWin.ShowSecantSlopes(h: Double);
  var dy1, dy2,
      ms1, ms2  : Double;
      s1, s2    : String;

  function f(x : Double): Double;
    var y : Double;
    begin
    MyFunktion.GetFunctionValue(x, y);
    Result := y;
    end;

  begin
  dy1 := MyCenterPt.Y - f(MyCenterPt.X - h);
  dy2 := f(MyCenterPt.X + h) - MyCenterPt.Y;
  ms1 := dy1 / h;
  ms2 := dy2 / h;

  With MyBuffer.Canvas do begin
    Font.Color := clBlack;
    Brush.Style := bsClear;
    s1 := 'm1 = ' + FloatToStrF(ms1, ffFixed, 8, 4);
    if ms1 > 0 then
      TextOut(30, hlen - 30, s1)
    else
      TextOut(30, hlen + 15, s1);
    s2 := 'm2 = ' + FloatToStrF(ms2, ffFixed, 8, 4);
    if ms2 > 0 then
      TextOut(hlen + 30, hlen + 15, s2)
    else
      TextOut(hlen + 30, hlen - 30, s2);
    end;
  end;


end.
