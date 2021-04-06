unit AssAffAbb_2c;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AssAffAbb_2, StdCtrls, ExtCtrls;

type
  TAffAbb_2c_Dlg = class(TAffAbb_2_Dlg)
    Label6: TLabel;
    Label7: TLabel;
  protected
    procedure SetVisState(newVal: Integer); override;
  public
    { Public-Deklarationen }
  end;


implementation

{$R *.dfm}

procedure TAffAbb_2c_Dlg.SetVisState(newVal: Integer);
  begin
  FVisState := newVal;
  Label3.Visible := VisState >= 1;
  Label4.Visible := VisState >= 2;
  Label5.Visible := VisState >= 3;
  Label6.Visible := VisState >= 4;
  Label7.Visible := VisState >= 5;
  OKBtn.Enabled  := VisState >= 6;
  end;


end.
