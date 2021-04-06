unit PrnCfg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TPrinterCfgDlg = class(TForm)
    BtnClose: TButton;
    Bevel1: TBevel;
    BtnPrint: TButton;
    BtnCancel: TButton;
    BtnPreview: TButton;
    PaperOutFormat: TRadioGroup;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    SkalFaktor: TEdit;
    RandBreite: TEdit;
    GroupBox2: TGroupBox;
    BtnEditPrinter: TButton;
    ActPrinter: TEdit;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure BtnEditPrinterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SkalFaktorExit(Sender: TObject);
    procedure RandBreiteExit(Sender: TObject);
    procedure BtnPreviewClick(Sender: TObject);
    procedure PaperOutFormatClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    old_UserScaleF,
    old_UserBorder   : Double;
    old_PrinterIndex,
    old_PaperFormat  : Integer;
    old_Orientation  : TPrinterOrientation;
  public
    { Public-Deklarationen }
  end;


implementation

uses Printers, GlobVars, Preview, MainWin;

{$R *.DFM}

{======= Initialisierung ==============}

procedure TPrinterCfgDlg.FormShow(Sender: TObject);
  begin
  { Alte Einstellungen merken }
  old_UserScaleF   := prn_UserScaleF;
  old_UserBorder   := prn_UserBorder;
  old_PrinterIndex := Printer.PrinterIndex;
  old_Orientation  := Printer.Orientation;
  old_PaperFormat  := prn_PaperFormat;

  { Formular-Elemente initialisieren }
  PaperOutFormat.ItemIndex := prn_PaperFormat;
  If prn_PaperFormat = 2 then
    Printer.Orientation := poLandscape
  else
    Printer.Orientation := poPortrait;
  SkalFaktor.Text := FloatToStrF(prn_UserScaleF, ffFixed, 6, 3);
  RandBreite.Text := FloatToStrF(prn_UserBorder, ffFixed, 6, 0);
  ActPrinter.Text := Printer.Printers[Printer.PrinterIndex];
  BtnClose.SetFocus;
  end;

{======= Einstellungen ändern =========}

procedure TPrinterCfgDlg.PaperOutFormatClick(Sender: TObject);
  begin
  prn_PaperFormat := PaperOutFormat.ItemIndex;
  If prn_PaperFormat = 2 then
    Printer.Orientation := poLandscape
  else
    Printer.Orientation := poPortrait;
  end;

procedure TPrinterCfgDlg.BtnEditPrinterClick(Sender: TObject);
  var old_PO : TPrinterOrientation;
  begin
  old_PO := Printer.Orientation;
  PrinterSetupDialog1.Execute;
  ActPrinter.Text := Printer.Printers[Printer.PrinterIndex];
  If Printer.Orientation <> old_PO then begin
    If Printer.Orientation = poPortrait then
      PaperOutFormat.ItemIndex := 0   // Hochformat, obere halbe Seite
    else
      PaperOutFormat.ItemIndex := 2;  // Querformat
    prn_PaperFormat := PaperOutFormat.ItemIndex;
    end;
  end;

procedure TPrinterCfgDlg.SkalFaktorExit(Sender: TObject);
  var db : Double;
  begin
  try
    db := StrToFloat(SkalFaktor.Text);
    If (db <= 10) and (db >= 0.1) then
      prn_UserScaleF := db
    else
      raise ERangeError.CreateFmt
              ('%6.3f liegt nicht im Bereich 0,1 ... 10', [db]);
  except
    SkalFaktor.Text := FloatToStrF(prn_UserScaleF, ffFixed, 6, 3);
    raise;
  end;
  end;

procedure TPrinterCfgDlg.RandBreiteExit(Sender: TObject);
  var db : Double;
  begin
  try
    db := StrToFloat(RandBreite.Text);
    If (db <= 50) and (db >= 0) then
      prn_UserBorder := db
    else
      raise ERangeError.CreateFmt
              ('%6.0f liegt nicht im Bereich 0 ... 50', [db]);
  except
    RandBreite.Text := FloatToStrF(prn_UserBorder, ffFixed, 6, 0);
    raise;
  end;
  end;

{======== Preview aufrufen ============}

procedure TPrinterCfgDlg.BtnPreviewClick(Sender: TObject);
  var PreviewDlg : TPrintPreview;
  begin
  PreViewDlg := TPrintPreview.CreateWithParams
                     (Self, Hauptfenster.Drawing,
                      prn_UserScaleF, prn_UserBorder);
  PreViewDlg.ShowModal;
  PreViewDlg.Release;
  end;

{======== Dialog schließen ============}

{ Der Dialog enthält *keine* OnClick-Methoden für die beendenden Knöpfe
  BtnClose, BtnPrint und BtnCancel; alle Änderungen werden gleich ernst-
  haft in die entsprechenden globalen Variablen
       prn_UserBorder,
       prn_UserScaleF,
       prn_PaperFormat
  geschrieben. Erst beim Schließen des Formulars wird überprüft, ob die
  Änderungen wirklich permanent übernommen werden sollen: ist der Rück-
  gabewert der ShowModal-Routine gleich "mrCancel", dann werden alle
  eventuell vorgenommenen Änderungen rückgängig gemacht.              }

procedure TPrinterCfgDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  { Entscheidet, ob die Änderungen permanent übernommen werden oder nicht.
    Sowohl der Klick auf BtnCancel als auch der Klick auf das "Schließen"-
    Kreuz in der rechten oberen Fensterecke führen dazu, dass ModalResult
    den Wert "mrCancel" annimmt.                                          }
  begin
  If ModalResult = mrCancel then begin   // Alle Änderungen rückgängig machen !
    prn_UserScaleF   := old_UserScaleF;
    prn_UserBorder   := old_UserBorder;
    prn_PaperFormat  := old_PaperFormat;
    With Printer do begin
      If PrinterIndex <> old_PrinterIndex then
        PrinterIndex := old_PrinterIndex;
      If Orientation <> old_Orientation then
        Orientation  := old_Orientation;
      end;
    end;
  CanClose := True;
  end;

end.
