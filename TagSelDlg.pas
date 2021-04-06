unit TagSelDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TTagSelectDlg = class(TForm)
    OKBtn: TButton;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    ListBox1: TListBox;
    Label1: TLabel;
    RadioButton2: TRadioButton;
    Label2: TLabel;
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SelNr : Integer;
  end;


implementation

{$R *.dfm}

procedure TTagSelectDlg.ListBox1Click(Sender: TObject);
  begin
  RadioButton1.Checked := True;
  end;

end.
