unit QuantPoint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FloatEdit, GeoTypes;

type
  TQuantPtWin = class(TForm)
    BtnAbort: TButton;
    BtnHelp: TButton;
    BtnOkay: TButton;
    GroupBox1: TGroupBox;
    RB_Smooth: TRadioButton;
    RB_Stepped: TRadioButton;
    Label1: TLabel;
    FE_Quant: TFloatEdit;
    procedure FormShow(Sender: TObject);
    procedure RB_SmoothClick(Sender: TObject);
    procedure RB_SteppedClick(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
    procedure BtnOkayClick(Sender: TObject);
  private
    { Private-Deklarationen }
    ActPoint : TGPoint;
  public
    { Public-Deklarationen }
  end;


implementation

{$R *.dfm}

Uses MathLib, GlobVars, MainWin;

procedure TQuantPtWin.FormShow(Sender: TObject);
  begin
  ActPoint := TGPoint(Hauptfenster.ActPopupObj);
  If ActPoint.Quant > 0 then begin
    RB_Smooth.Checked  := False;
    RB_Stepped.Checked := True;
    FE_Quant.Value     := ActPoint.Quant;  // Aktuellen Value übernehmen
    FE_Quant.Enabled   := True;
    FE_Quant.SetFocus;
    end
  else begin
    RB_Smooth.Checked  := True;
    RB_Stepped.Checked := False;
    FE_Quant.Enabled   := False;            // Value nicht ändern
    RB_Smooth.SetFocus;
    end;
  FE_Quant.Hint := ' >= ' + FloatToStrF(PointQuant, ffGeneral, 4, 0) + ' ';
  end;

procedure TQuantPtWin.RB_SmoothClick(Sender: TObject);
  begin
  RB_Stepped.Checked := Not RB_Smooth.Checked;
  If RB_Smooth.Checked then begin
    FE_Quant.Enabled := False;
    end
  else begin
    If ActPoint.Quant > PointQuant then
      FE_Quant.Value := ActPoint.Quant;
    FE_Quant.Enabled := True;
    FE_Quant.SetFocus;
    end;
  end;

procedure TQuantPtWin.RB_SteppedClick(Sender: TObject);
  begin
  RB_Smooth.Checked := Not RB_Stepped.Checked;
  If RB_Stepped.Checked then begin
    If ActPoint.Quant > PointQuant then
      FE_Quant.Value := ActPoint.Quant;
    FE_Quant.Enabled := True;
    FE_Quant.SetFocus;
    end
  else begin
    FE_Quant.Enabled := False;
    FE_Quant.Value := 0;
    end;
  end;

procedure TQuantPtWin.BtnHelpClick(Sender: TObject);
  begin
  HauptFenster.HilfezumAktuellenBefehlClick(Self);
  end;

procedure TQuantPtWin.BtnOkayClick(Sender: TObject);
  begin
  If RB_Smooth.Checked then
    ActPoint.Quant := 0
  else
    If FE_Quant.Value > PointQuant then
      ActPoint.Quant := FE_Quant.Value
    else
      ActPoint.Quant := PointQuant;
  end;

end.
