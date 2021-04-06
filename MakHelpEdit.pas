unit MakHelpEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TMakHelpDlg = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Memo1: TMemo;
    Okay: TButton;
    Abbrechen: TButton;
    Bevel1: TBevel;
    procedure OkayClick(Sender: TObject);
    procedure AbbrechenClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


implementation

uses GlobVars, MainWin;

{$R *.DFM}

procedure TMakHelpDlg.OkayClick(Sender: TObject);
  begin
  ModalResult := mrOk;
  end;

procedure TMakHelpDlg.AbbrechenClick(Sender: TObject);
  begin
  ModalResult := mrCancel;
  end;

procedure TMakHelpDlg.FormShow(Sender: TObject);
  var R : TRect;
  begin
  With Memo1 do begin
    R.Left := 5;
    R.Top  := 5;
    R.Right := Memo1.Width - 10;
    R.Bottom := Memo1.Height - 10;
    Perform(em_SetRect, 0, Integer(@R));
    end;
  end;

end.
