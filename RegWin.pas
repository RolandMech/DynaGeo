unit RegWin;

interface

{$IFDEF NO_PLATFORMWARNINGS}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TRegisterDlg = class(TForm)
    Bevel1: TBevel;
    CancelBtn: TButton;
    RegisterBtn: TButton;
    HelpButton: TButton;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    procedure HelpButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RegisterBtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


implementation

{$R *.DFM}

Uses Declar, GlobVars, IniFDlg, MainWin, MathLib;

procedure TRegisterDlg.HelpButtonClick(Sender: TObject);
  begin
  Application.HelpContext(cmd_Register);
  end;

procedure TRegisterDlg.FormCreate(Sender: TObject);
  var sr   : TSearchRec;
      path : String;
  begin
  path := ExtractFilePath(Application.ExeName);
  OpenDialog1.InitialDir := path;
  If FindFirst(path + '*.dgl', faReadOnly + faHidden, sr) = 0 then
    Edit1.Text := path + sr.FindData.cFileName
  else
    Edit1.Text := path + '*.dgl';
  FindClose(sr);
  end;

procedure TRegisterDlg.Button1Click(Sender: TObject);
  begin
  If OpenDialog1.Execute then
    Edit1.Text := OpenDialog1.FileName;
  end;

procedure TRegisterDlg.RegisterBtnClick(Sender: TObject);
  begin
  If FileExists(Edit1.Text) then
    If Hauptfenster.IniFile.CopyLicenceDataFile(Edit1.Text) then
      ModalResult := mrOk
    else
      MessageDlg(Format(MyStartMsg[5], [Edit1.Text]), mtError, [mbOk], 0)
  else
    MessageDlg(Format(MyFileMsg[6], [Edit1.Text]), mtError, [mbOk], 0);
  end;

end.
