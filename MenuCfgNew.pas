unit MenuCfgNew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, ExtCtrls;

type
  TEditMenuConfigWin = class(TForm)
    CheckListBox1: TCheckListBox;
    Label1: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    btnSave: TButton;
    btnCancel: TButton;
    Bevel1: TBevel;
    btnHelp: TButton;
    procedure btnHelpClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private-Deklarationen }
    key : String;
  public
    { Public-Deklarationen }
    procedure LoadCfgData(newKey: String);
  end;

const
  MaxMenuCmdIndex = 70;
  MenuCmdId : Array [0..MaxMenuCmdIndex] of String[4] =
  ('101 ', '102 ', '103 ', '104 ', '105 ', '106 ', '203 ', '204 ',
   '112 ', '118 ', '113 ', '114 ', '115 ', '116 ', '117 ', '090 ',
   '091 ', '152 ', '153 ', '109 ', '042 ', '126 ', '127 ', '125 ',
   '131 ', '158 ', '235 ', '133 ', '128 ', '135 ', '136 ', '137 ',
   '138 ', '139 ', '129 ', '045 ', '047 ', '049 ', '051 ', '053 ',
   '055 ', '056 ', '156 ', '155 ', '159 ', '079 ', '078 ', '154 ',
   '242 ', '244 ', '243 ', '241 ', '141 ', '146 ', '142 ', '143 ',
   '144 ', '092 ', '230 ', '231 ', '233 ', '222 ', '223 ', '224 ',
   '225 ', '226 ', '228 ', '227 ', '221 ', '034 ', '035 ');
                { siehe Unit DECLAR.PAS }

implementation

{$R *.DFM}

Uses Declar, GlobVars, MainWin;

procedure TEditMenuConfigWin.btnHelpClick(Sender: TObject);
  begin
  Application.HelpCommand(Help_Context, idh_opt_newcfg);
  end;

procedure TEditMenuConfigWin.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
  begin
  CanClose := True;
  If (Sender = btnSave) and
     (Length(Edit1.Text) = 0) then begin
    CanClose := False;
    MessageDlg(MyOptMsg[9], mtWarning, [mbOk], 0);
    end;
  end;

procedure TEditMenuConfigWin.btnSaveClick(Sender: TObject);
  var buf : String;
      k   : Integer;
  begin
  HauptFenster.IniFile.KillMenuConfig(key);  { Konfig. komplett löschen ! }
  Hauptfenster.Inifile.SaveMenuConfigName(key, Edit1.Text);
  buf := '';
  k   := 0;
  While k <= MaxMenuCmdIndex do begin
    If CheckListBox1.Checked[k] then
      buf := buf + String(MenuCmdId[k]);
    Inc(k);
    end;
  Hauptfenster.IniFile.SaveMenuConfigData(key, buf);
  ModalResult := mrOk;
  end;

procedure TEditMenuConfigWin.LoadCfgData(newKey: String);
  var buf, ts : String;
      i       : Integer;
  begin
  key := newKey;
  buf := Hauptfenster.IniFile.LoadMenuConfigName(key);
  For i := 0 to Pred(CheckListBox1.Items.Count) do
    CheckListBox1.Checked[i] := False;
  If Length(buf) = 0 then begin     { neue Menü-Konfiguration erstellen       }
    buf := Format(MyMess[72], [newkey]);
    Edit1.Text := buf;
    end
  else begin                        { vorhandene Menü-Konfiguration editieren }
    Edit1.Text := buf;
    buf := Hauptfenster.IniFile.LoadMenuConfigData(key) + ' ';
    For i := 0 to MaxMenuCmdIndex do begin
      ts := String(MenuCmdId[i]);
      CheckListBox1.Checked[i] := Pos(ts, buf) > 0;
      end;
    end;
  end;

end.
