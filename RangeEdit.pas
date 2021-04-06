unit RangeEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, FloatEdit, GeoTypes;

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
    nq  : Integer;
    EZO : TGNumberObj;     { "E"ditiertes "Z"ahl-"O"bjekt }
  public
    { Public-Deklarationen }
  end;


implementation

{$R *.DFM}

uses Math, MathLib, GlobVars, MainWin;

procedure TRangeEditWin.FormShow(Sender: TObject);
  var pt : TPoint;
      dz : Integer;
  begin
  pt := HauptFenster.PaintBox1.ClientToScreen(Point(0, 0));
  EZO := TGNumberObj(Hauptfenster.ActPopupObj);
  caption := Format(MyMess[25], [EZO.Name]);
  With EZO do begin
    Left := pt.x + WinPos.X + 35;
    Top  := pt.y + WinPos.Y + 20;
    q    := GetValue(gv_quant);
    if q > 0 then
      dz := Max(Abs(Round(log10(q))), 3)
    else
      dz := 3;
    FloatEdit1.Text := FloatToStrF(Quantisized(GetValue(gv_min),0), ffGeneral, dz,     0);
    FloatEdit2.Text := FloatToStrF(Quantisized(GetValue(gv_val),q), ffGeneral, dz + 1, 0);
    FloatEdit3.Text := FloatToStrF(Quantisized(GetValue(gv_max),0), ffGeneral, dz,     0);
    FloatEdit4.Text := FloatToStrF(q, ffGeneral, 4, 0);
    Checkbox1.Enabled := True;
    If FloatEdit4.Value < epsilon then begin
      FloatEdit4.Value := 0;
      FloatEdit4.Enabled := False;
      Checkbox1.Checked := False;
      end
    else begin
      FloatEdit4.Enabled := True;
      Checkbox1.Checked := True;
      end;
    if EZO.ClassType = TGLogSlider then begin
      Groupbox1.Visible := False;
      Checkbox1.Visible := False;
      FloatEdit4.Visible := False;
      end
    else begin
      Groupbox1.Visible := True;
      Checkbox1.Visible := True;
      FloatEdit4.Visible := True;
      end;
    end; { of with }
  end; { of FormShow }

procedure TRangeEditWin.OkayBtnClick(Sender: TObject);
  begin
  if EZO.ClassType = TGLogSlider then begin
    q  := 0.0001;
    nq := Round(FloatEdit4.Value);
    TGNumberObj(HauptFenster.ActPopupObj).SetAllValues
                    (Quantisized(FloatEdit1.Value, q),
                     Quantisized(FloatEdit2.Value, q),
                     Quantisized(FloatEdit3.Value, q),
                     nq);
    end
  else begin
    If CheckBox1.Checked then
      q := FloatEdit4.Value
    else begin
      q := 0;   // Womit auf die Quantisierung verzichtet wird.
      end;
    TGNumberObj(HauptFenster.ActPopupObj).SetAllValues
                    (Quantisized(FloatEdit1.Value, q),
                     Quantisized(FloatEdit2.Value, q),
                     Quantisized(FloatEdit3.Value, q),
                     q);
    end;
  ModalResult := mrOk;
  end;

procedure TRangeEditWin.FloatEdit1Exit(Sender: TObject);
  begin
  if EZO.ClassType = TGLogSlider then begin

    end
  else begin
    FloatEdit1.Value := Quantisized(FloatEdit1.Value, q);
    If FloatEdit1.Value > FloatEdit2.Value then
      FloatEdit2.Value := FloatEdit1.Value;
    If FloatEdit1.Value > FloatEdit3.Value - q then
      FloatEdit3.Value := FloatEdit1.Value + 10*q;
    end;
  end;

procedure TRangeEditWin.FloatEdit2Exit(Sender: TObject);
  begin
  if EZO.ClassType = TGLogSlider then begin

    end
  else begin
    FloatEdit2.Value := Quantisized(FloatEdit2.Value, q);
    If FloatEdit2.Value < FloatEdit1.Value then
      FloatEdit1.Value := FloatEdit2.Value;
    If FloatEdit2.Value > FloatEdit3.Value then
      FloatEdit3.Value := FloatEdit2.Value;
    end;
  end;

procedure TRangeEditWin.FloatEdit3Exit(Sender: TObject);
  begin
  if EZO.ClassType = TGLogSlider then begin

    end
  else begin
    FloatEdit3.Value := Quantisized(FloatEdit3.Value, q);
    If FloatEdit3.Value < FloatEdit2.Value then
      FloatEdit2.Value := FloatEdit3.Value;
    If FloatEdit3.Value < FloatEdit1.Value + q then
      FloatEdit1.Value := FloatEdit3.Value - 10*q;
    end;
  end;

procedure TRangeEditWin.FloatEdit4Exit(Sender: TObject);
  var b_low, b_high,
      w : Double;
  begin
  if EZO.ClassType = TGLogSlider then begin

    end
  else begin
    q := Abs(FloatEdit4.Value);
    If q < 1e-8 then q := 1e-8;
    FloatEdit4.Value := q;
    b_low  := FloatEdit1.Value;
    b_high := FloatEdit3.Value;
    w := b_high - b_low;
    If (0 < w) and (w < 10 * q) then begin
      b_low  := FloatEdit2.Value - 5 * q;
      b_high := FloatEdit2.Value + 5 * q;
      FloatEdit4.Value := q;
      end;
    FloatEdit1.Value := Quantisized(b_low,            q);
    FloatEdit2.Value := Quantisized(FloatEdit2.Value, q);
    FloatEdit3.Value := Quantisized(b_high,           q);
    end;
  end;

procedure TRangeEditWin.CheckBox1Click(Sender: TObject);
  begin
  FloatEdit4.Enabled := CheckBox1.Checked;
  If CheckBox1.Checked then begin
    FLoatEdit4.Value := TGNumberObj(Hauptfenster.ActPopupObj).GetValue(gv_quant);
    If FloatEdit4.Value < NumberQuant then
      FloatEdit4.Value := NumberQuant;
    end
  else
    FloatEdit4.Value := 0;
  FloatEdit4Exit(Sender);
  end;

end.
