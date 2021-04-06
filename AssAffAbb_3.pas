unit AssAffAbb_3;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, pngimage;

type
  TAffAbb_3_Dlg = class(TForm)
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    FinishBtn: TButton;
    CheckBox1: TCheckBox;
    Image1: TImage;
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure InitTexts(s: String);
  end;

  
implementation

{$R *.dfm}

procedure TAffAbb_3_Dlg.InitTexts(s: String);
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
  end;


procedure TAffAbb_3_Dlg.CheckBox1Click(Sender: TObject);
  begin
  If CheckBox1.Checked then
    FinishBtn.ModalResult := mrOK
  else
    FinishBtn.ModalResult := mrCancel;
  end;

end.
