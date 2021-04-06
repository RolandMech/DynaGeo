unit OKCANCL1;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TOKBottomDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  OKBottomDlg: TOKBottomDlg;

implementation

{$R *.dfm}

end.
