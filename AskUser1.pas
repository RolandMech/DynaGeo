unit AskUser1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TAskUser1Dlg = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Button1: TButton;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    function Selected: Integer;
  end;

implementation

{$R *.dfm}

function TAskUser1Dlg.Selected: Integer;
  begin
  If RadioButton1.Checked then
    Result := 0
  else if RadioButton2.Checked then
    Result := 1
  else if RadioButton3.Checked then
    Result := 2
  else
    Result := -1;
  end;

end.
