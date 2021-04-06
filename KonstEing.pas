unit KonstEing;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TKonstEingabeDlg = class(TForm)
    Bevel1: TBevel;
    OKBtn: TButton;
    CancelBtn: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


implementation

{$R *.DFM}

Uses MathLib, GlobVars, GeoTypes, MainWin;

procedure TKonstEingabeDlg.FormCreate(Sender: TObject);
  begin
  //SlHauptFenster.Affin.Gerade;
  end;

procedure TKonstEingabeDlg.FormShow(Sender: TObject);
  var w : Double;
  begin
  w := Hauptfenster.TPt[1].x;
  If Abs(w) < epsilon then
    w := 3.0;
  Edit1.Text := FloatToStr(w);
  Edit1.SelectAll;
  Edit1.SetFocus;
  end;

procedure TKonstEingabeDlg.OKBtnClick(Sender: TObject);
  var CC  : Boolean;
  begin
  CC := False;
  try
    with HauptFenster do begin
      TPt[1].x := AsFloat(Edit1.Text);
      CC := True;
      end;
  except
    MessageDlg(MyMess[33], mtError, [mbOK], 0);
  end; { of try }
  If CC then
    ModalResult := mrOk;
  end;

procedure TKonstEingabeDlg.CancelBtnClick(Sender: TObject);
  begin
  ModalResult := mrCancel;
  end;

end.
