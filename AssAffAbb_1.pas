unit AssAffAbb_1;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, OKCANCL1;

type
  TAffAbb_1_Dlg = class(TOKBottomDlg)
    HelpBtn: TButton;
    Label2: TLabel;
    Label1: TLabel;
    RB_Scherung: TRadioButton;
    RB_OrthAxStreckung: TRadioButton;
    RB_SchraegSpiegelung: TRadioButton;
    RB_AllgAxAff: TRadioButton;
    Label3: TLabel;
    RB_EulerAff: TRadioButton;
    RB_AffDrehung: TRadioButton;
    Label4: TLabel;
    RB_AllgAff6Pt: TRadioButton;
    RB_AllgAffMat: TRadioButton;
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    function TagOfCheckedRB: Integer;
  end;

implementation

{$R *.dfm}

uses Declar;

procedure TAffAbb_1_Dlg.HelpBtnClick(Sender: TObject);
  begin
  Application.HelpCommand(Help_Context, cmd_DefineAffin);
  end;

function TAffAbb_1_Dlg.TagOfCheckedRB: Integer;
  var i : Integer;
  begin
  Result := -1;
  For i := 0 to Pred(ControlCount) do
    If (Controls[i] is TRadioButton) and
      (Controls[i] as TRadioButton).Checked then
      Result := TRadioButton(Controls[i]).Tag;
  end;

end.

