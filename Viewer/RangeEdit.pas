unit RangeEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, GeoTypes, FloatEdit;

type
  TRangeEditWin = class(TForm)
    FloatEdit1: TFloatEdit;
    FloatEdit2: TFloatEdit;
    FloatEdit3: TFloatEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    OkayBtn: TButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    FloatEdit4: TFloatEdit;
    procedure FormShow(Sender: TObject);
    procedure OkayBtnClick(Sender: TObject);
    procedure FloatEdit1Exit(Sender: TObject);
    procedure FloatEdit3Exit(Sender: TObject);
    procedure FloatEdit2Exit(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FloatEdit4Exit(Sender: TObject);
  private
    { Private-Deklarationen }
    q   : Double;
    EZO : TGNumberObj;     { "E"ditiertes "Z"ahl-"O"bjekt }
  public
    { Public-Deklarationen }
    constructor CreateWithData(AOwner: TControl; AEZO: TGeoObj);
  end;


implementation

{$R *.DFM}

uses Math, MathLib, GlobVars;

constructor TRangeEditWin.CreateWithData(AOwner: TControl; AEZO: TGeoObj);
  begin
  Inherited Create(AOwner);
  If AEZO is TGNumberObj then
    EZO := TGNumberObj(AEZO)
  else
    EZO := Nil;
  end;

procedure TRangeEditWin.FormShow(Sender: TObject);
  var pt : TPoint;
  begin
  pt := TControl(Owner).ClientToScreen(EZO.WinPos);
  pt.X := pt.x + 35;
  pt.Y := pt.y + 20;
  If pt.X > Screen.DesktopWidth - Width then
    pt.X := Screen.DesktopWidth - Width;
  If pt.Y > Screen.DesktopHeight - Height then
    pt.Y := Screen.DesktopHeight - Height;
  If pt.X < 0 then Left := 0 else Left := pt.X;
  If pt.Y < 0 then Top  := 0 else Top  := pt.Y;

  caption := Format(MyMess[25], [EZO.Name]);
  With EZO do begin
    q := GetValue(gv_quant);
    FloatEdit1.Text := FloatToStrF(Quantisized(GetValue(gv_min),q), ffGeneral, 4, 0);
    FloatEdit2.Text := FloatToStrF(Quantisized(GetValue(gv_val),q), ffGeneral, 4, 0);
    FloatEdit3.Text := FloatToStrF(Quantisized(GetValue(gv_max),q), ffGeneral, 4, 0);
    FloatEdit4.Text := FloatToStrF(q, ffGeneral, 4, 0);
    If FloatEdit4.Value < epsilon then begin
      FloatEdit4.Value := 0;
      FloatEdit4.Enabled := False;
      Checkbox1.Checked := False;
      end
    else begin
      FloatEdit4.Enabled := True;
      Checkbox1.Checked := True;
      end;
    end;
  end;

procedure TRangeEditWin.OkayBtnClick(Sender: TObject);
  begin
  If CheckBox1.Checked then
    q := FloatEdit4.Value
  else
    q := 0;
  EZO.SetAllValues(Quantisized(FloatEdit1.Value, q),
                   Quantisized(FloatEdit2.Value, q),
                   Quantisized(FloatEdit3.Value, q),
                   q);
  ModalResult := mrOk;
  end;

procedure TRangeEditWin.FloatEdit1Exit(Sender: TObject);
  begin
  FloatEdit1.Value := Quantisized(FloatEdit1.Value, q);
  If FloatEdit1.Value > FloatEdit2.Value then
    FloatEdit2.Value := FloatEdit1.Value;
  If FloatEdit1.Value > FloatEdit3.Value - epsilon then
    FloatEdit3.Value := FloatEdit1.Value + 1.0;
  end;

procedure TRangeEditWin.FloatEdit2Exit(Sender: TObject);
  begin
  FloatEdit2.Value := Quantisized(FloatEdit2.Value, q);
  If FloatEdit2.Value < FloatEdit1.Value then
    FloatEdit1.Value := FloatEdit2.Value;
  If FloatEdit2.Value > FloatEdit3.Value then
    FloatEdit3.Value := FloatEdit2.Value;
  end;

procedure TRangeEditWin.FloatEdit3Exit(Sender: TObject);
  begin
  FloatEdit3.Value := Quantisized(FloatEdit3.Value, q);
  If FloatEdit3.Value < FloatEdit2.Value then
    FloatEdit2.Value := FloatEdit3.Value;
  If FloatEdit3.Value < FloatEdit1.Value + epsilon then
    FloatEdit1.Value := FloatEdit3.Value - 1.0;
  end;

procedure TRangeEditWin.FloatEdit4Exit(Sender: TObject);
  var w : Double;
  begin
  q := Abs(FloatEdit4.Value);
  w := FloatEdit3.Value - FloatEdit1.Value;
  If q > w then begin
    Power(10, Floor(Log10(w)), q);
    FloatEdit4.Value := q;
    end;
  FloatEdit1.Value := Quantisized(FloatEdit1.Value, q);
  FloatEdit2.Value := Quantisized(FloatEdit2.Value, q);
  FloatEdit3.Value := Quantisized(FloatEdit3.Value, q);
  FloatEdit3Exit(Sender);     { Minimale Intervallbreite sichern ! }
  end;

procedure TRangeEditWin.CheckBox1Click(Sender: TObject);
  begin
  FloatEdit4.Enabled := CheckBox1.Checked;
  If CheckBox1.Checked then begin
    FLoatEdit4.Value := EZO.GetValue(gv_quant);
    If FloatEdit4.Value < NumberQuant then
      FloatEdit4.Value := NumberQuant;
    end
  else
    FloatEdit4.Value := 0;
  FloatEdit4Exit(Sender);
  end;

end.
