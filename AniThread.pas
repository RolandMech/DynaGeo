unit AniThread;

interface

uses
  Classes, Forms, GeoTypes;

type
  TAniThread = class(TThread)
  private
    { Private-Deklarationen }
    FMyForm     : TForm;
    FMyGeoListe : TGeoObjListe;
    FModus      : Integer;
  protected
    procedure Execute; override;
  public
    constructor Create(iForm: TForm; iGeoListe: TGeoObjListe; iModus: Integer);
  end;


implementation

uses Declar, GlobVars, MainWin;

{ Wichtig: Methoden und Eigenschaften von Objekten in VCL oder CLX können
   nur in Methoden verwendet werden, die Synchronize aufrufen, z.B.:

      Synchronize(UpdateCaption);

   wobei UpdateCaption so aussehen könnte:

    procedure TAniThread.UpdateCaption;
    begin
      Form1.Caption := 'In einem Thread aktualisiert';
    end; }

{ TAniThread }

constructor TAniThread.Create(iForm: TForm; iGeoListe: TGeoObjListe; iModus: Integer);
  begin
  Inherited Create(False);
  FreeOnTerminate := True;
  FMyForm     := iForm;
  FMyGeoListe := iGeoListe;
  FModus      := iModus;
  end;

procedure TAniThread.Execute;
  begin
  { Thread-Code hier einfügen }
  With FMyGeoListe do begin
    AnimationRunning := True;
    Repeat
      IsDoubleBuffered := True;
      FillDragList(AnimationSource);
      FModus := Animate(FModus);
    // SpeedBar.Repaint;
      Application.ProcessMessages;
    until Not (FModus in [cmd_RunAnimaFD, cmd_RunAnimaBK]);
    IsDoubleBuffered := Double_Buffered;
    AnimationRunning := False;
    THauptFenster(FMyForm).Reset2DragMode;
//    If AppShouldClose then begin
//      AppShouldClose := False;
//      Close;
//      end;
    end;
  end;

end.
