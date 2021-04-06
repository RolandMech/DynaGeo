unit Preview;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms,
  Utility, GlobVars, GeoTypes, Printers;

type
  TPrintPreview = class(TForm)
    PaintBox1: TPaintBox;
    procedure FormShow(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { verborgenes }
    Drawing    : TGeoObjListe;
    UserScaleF,
    UserBorder,
    sf         : Double;  { "s"caling "f"actor = Größe der Vorschau     }
                          {    durch Größe des Bildschirm-Bildes        }
    Old_ILStyle,
    Old_ICStyle: Boolean;
    PreViewPageWidth,
    PreViewPageHeight,
    w_rf,                 { Rand um das Bild der Druckseite in Scr_Pixel }
    w_rdx,                { Rand um den bedruckten Bereich auf der       }
    w_rdy      : Integer; {    Druckseite in Scr_Pixel                   }
    Clip_Rect  : TRect;   { Clipping-Rechteck in Fenster-Koordinaten     }
    OldWorldRect,         { Welt-Rechteck vor PrintPreview-Aufruf        }
    LBackRect,            { fensterfüllendes Hintergrund-Rechteck        }
    LShadowRect,          { Schatten-Rechteck                            }
    LPageRect,            { Rechteck für das Bild der Druckseite         }
    DrawRect   : TRect;   { Rechteck für die Zeichnung                   }
       { Diese 3 Rechtecke sind in dem durch den Drucker
         induzierten logischen Koordinatensystem angegeben !!! }
  public
    { öffentliches }
    constructor CreateWithParams(AOwner:   TComponent;
                                 iDrawing: TGeoObjListe;
                                 iUserScaleF,
                                 iUserBorder : Double);
  end;


implementation

{$R *.DFM}

constructor TPrintPreview.CreateWithParams(AOwner:   TComponent;
                                           iDrawing: TGeoObjListe;
                                           iUserScaleF,
                                           iUserBorder : Double);
  begin
  Inherited Create(AOwner);
  Drawing      := iDrawing;
  UserScaleF   := iUserScaleF;
  UserBorder   := iUserBorder;
  w_rf         := 21;
  end;

procedure TPrintPreview.FormShow(Sender: TObject);
  var prn_XSize : Double;
  begin
  { Fenstergröße einstellen }
  If Printer.Orientation = poPortrait then begin
    PreViewPageHeight := (Screen.Height - 50) * 5 Div 6;
    PreViewPageWidth  := PreViewPageHeight * Printer.PageWidth
                                        Div Printer.PageHeight;
    ClientHeight := PreViewPageHeight + 3 * w_rf;
    ClientWidth  := PreviewPageWidth  + 3 * w_rf;
    end
  else begin
    PreViewPageWidth  := (Screen.Width - 60) * 4 Div 5;
    PreViewPageHeight := PreViewPageWidth * Printer.PageHeight
                                        Div Printer.PageWidth;
    ClientWidth  := PreViewPageWidth  + 3 * w_rf;
    ClientHeight := PreViewPageHeight + 3 * w_rf;
    end;

  { Drucker-Daten ermitteln }

  prn_XSize  := GetDeviceCaps(Printer.Handle, HorzSize) / 10; { Breite in Zentimetern }
  sf := (PreViewPageWidth / act_pixelPerXcm) / prn_XSize;

  { Randbreiten in Bildschirmpixeln ermitteln }
  w_rdx := Round(PreViewPageWidth * UserBorder / 100);
  w_rdy := Round(PreViewPageHeight * UserBorder / 100);

  { Clipping-Rechteck skalieren:
    Das Clipping-Rechteck wird stets in absoluten Windows-Fenster-
    koordinaten angegeben, also mit (0|0) in der linken oberen Ecke,
    selbst wenn das Clipping-Rechteck erst gesetzt wird, nachdem der
    Ursprung des User-Koordinatensystems schon verschoben wurde !!! }
  Case prn_PaperFormat of
    0 : begin
        w_rdy := w_rdy Div 2;    { bei "Portrait": obere halbe Seite }
        Clip_Rect := Bounds(w_rf + w_rdx, w_rf + w_rdy,
                            PreViewPageWidth - 2*w_rdx,
                            PreViewPageHeight Div 2 - 2*w_rdy);
        end;
    1 : begin
        Clip_Rect := Bounds(w_rf + w_rdx, w_rf + w_rdy,
                            PreViewPageWidth - 2*w_rdx,
                            PreViewPageHeight - 2*w_rdy);
        end;
    else
      Clip_Rect := Bounds(w_rf + w_rdx, w_rf + w_rdy,
                          PreViewPageWidth - 2*w_rdx,
                          PreViewPageHeight - 2*w_rdy);
    end; { of case }

  { Ausgabe-Rechtecke setzen:
    Diese Rechtecke werden in relativen Koordinaten angegeben,
    d.h. (0|0) ist die linke obere Ecke des Druckbereiches !       }
  With LBackRect do begin
    left := -w_rdx - w_rf;
    top  := -w_rdy - w_rf;
    right := PreViewPageWidth - w_rdx + 2*w_rf;
    bottom := PreViewPageHeight - w_rdy + 2*w_rf;
    end;
  With LShadowRect do begin
    left := -w_rdx + w_rf;
    top  := -w_rdy + w_rf;
    right := PreViewPageWidth - w_rdx + w_rf;
    bottom := PreViewPageHeight - w_rdy + w_rf;
    end;
  With LPageRect do begin
    left := -w_rdx;
    top  := -w_rdy;
    right := -w_rdx + PreViewPageWidth;
    bottom := -w_rdy + PreViewPageHeight;
    end;
  With DrawRect do begin
    left := 0;
    top  := 0;
    right := PreViewPageWidth - 2 * w_rdx + 1;
    If prn_PaperFormat = 0 then
      bottom := PreViewPageHeight Div 2 - 2 * w_rdy
    else
      bottom := PreViewPageHeight - 2 * w_rdy;
    end;
  end;

procedure TPrintPreview.PaintBox1Paint(Sender: TObject);
  var scale : Double;
  begin
  With PaintBox1.Canvas do begin
    { Nullpunkt in die linke obere Ecke des bedruckbaren Bereichs setzen: }
    SetViewportOrgEx(Handle, w_rdx + w_rf, w_rdy + w_rf, Nil);

    Pen.Width   := 1;
    Pen.Style   := psSolid;
    Brush.Style := bsSolid;

    Brush.Color := clGreen;
    Pen.Color   := clGreen;
    Rectangle(LBackRect);

    Brush.Color := clBlack;
    Pen.Color   := clBlack;
    Rectangle(LShadowRect);

    Brush.Color := clWhite;
    Pen.Color   := clBlack;
    Rectangle(LPageRect);

    SelectClipRgn(Handle, CreateRectRgnIndirect(Clip_Rect));
    end;

  Drawing.OutputStatus := outPreview;
  OldWorldRect := Drawing.WindowRect;     { puffern }
  Old_ILStyle  := InternalLineStyle;      {  "      }
  Old_ICStyle  := InternalCurvStyle;      {  "      }
  InternalLineStyle := PrnNeedsLineSupport;
  InternalCurvStyle := PrnNeedsCurvSupport;

  scale := UserScaleF * sf * act_pixelPerXcm / ScreenPPCMx;
  Drawing.Export_To(PaintBox1.Canvas, DrawRect, scale);   { DrawRect statt Clip_Rect !}

  InternalLineStyle  := Old_ILStyle;
  InternalCurvStyle  := Old_ICStyle;
  Drawing.WindowRect := OldWorldRect;
  Drawing.RescaleDrawing(1.00);
  Drawing.OutputStatus := outScreen;
  end;

procedure TPrintPreview.FormKeyPress(Sender: TObject; var Key: Char);
  begin
  Case key of
    #13 : ModalResult := mrOk;
    #27 : ModalResult := mrAbort;
  end;
  end;

procedure TPrintPreview.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
  begin
  CanClose := True;
  end;

end.
