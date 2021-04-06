unit AssAffAbb_3a;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TAffAbb_3a_Dlg = class(TForm)
    Bevel1: TBevel;
    Label2: TLabel;
    Image1: TImage;
    FinishBtn: TButton;
    Label1: TLabel;
    Label3: TLabel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure InitTexts(s: String);
  end;


implementation

{$R *.dfm}

procedure TAffAbb_3a_Dlg.InitTexts(s: String);
  function Patch(t: String): String;
    var n : Integer;
    begin
    n := Pos('#', t);
    If n > 0 then begin
      Delete(t, n, 1);
      Insert(s, t, n);
      end;
    Result := t;
    end;
  begin
  Caption := Patch(Caption);
  Label2.Caption := Patch(Label2.Caption);
  Label3.Caption := Patch(Label3.Caption);
  end;


end.
