unit ValidateSuccessWin;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox1 = class(TForm)
    Panel1: TPanel;
    SplashPic: TImage;
    ProductName: TLabel;
    OKButton: TButton;
    CB_GoToNext: TCheckBox;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  AboutBox1: TAboutBox1;

implementation

{$R *.dfm}

end.
 
