unit NetOptDlg;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Buttons, Dialogs,
  GlobVars, MenuCfgNew;

type
  TNetOptionsDlg = class(TForm)
    GroupBox2: TGroupBox;
    BtnSetAsDefaultMenuConfig: TButton;
    GroupBox3: TGroupBox;
    CB_AllowChooseMenu: TCheckBox;
    CB_AllowEditMenues: TCheckBox;
    BtnSaveNetOptions: TButton;
    LB_PrivCfgs: TListBox;
    LB_GlobCfgs: TListBox;
    btnShiftConfig2Global: TSpeedButton;
    btnShiftConfig2Privat: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    CB_AllowEditOptions: TCheckBox;
    CB_AllowSaveOptions: TCheckBox;
    Bevel1: TBevel;
    Label6: TLabel;
    btnNewCfg: TButton;
    btnEditCfg: TButton;
    btnDelCfg: TButton;
    Bevel2: TBevel;
    Label7: TLabel;
    Bevel3: TBevel;
    RG_UserOptFile: TRadioGroup;
    procedure BtnSetAsDefaultMenuConfigClick(Sender: TObject);
    procedure btnShiftConfig2GlobalClick(Sender: TObject);
    procedure BtnSaveNetOptionsClick(Sender: TObject);
    procedure btnShiftConfig2PrivatClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LB_CfgsClick(Sender: TObject);
    procedure CB_AllowEditOptionsClick(Sender: TObject);
    procedure btnNewCfgClick(Sender: TObject);
    procedure btnEditCfgClick(Sender: TObject);
    procedure btnDelCfgClick(Sender: TObject);
    procedure CB_AllowSvOptChMenuClick(Sender: TObject);
  protected
    PrivKeyList,
    GlobKeyList       : TStringList;
    StandardMenuIndex : Integer;
    procedure UpdateFormData;
  end;


implementation

{$R *.DFM}

uses MainWin;

procedure TNetOptionsDlg.FormCreate(Sender: TObject);
  begin
  PrivKeyList := TStringList.Create;
  GlobKeyList := TStringList.Create;
  PrivKeyList.Sorted := True;
  GlobKeyList.Sorted := True;
  UpdateFormData;
  end;

procedure TNetOptionsDlg.FormDestroy(Sender: TObject);
  begin
  PrivKeyList.Free;
  GlobKeyList.Free;
  end;

procedure TNetOptionsDlg.UpdateFormData;
  var s : String;
      i : Integer;
  begin
  CB_AllowEditOptions.Checked := EditOptionsAllowed;
  CB_AllowSaveOptions.Checked := SaveOptionsAllowed;
  CB_AllowChooseMenu.Checked := ChooseMenuAllowed;
  CB_AllowEditMenues.Checked := EditMenuesAllowed;
  If UserOptFileInExeDir then
    RG_UserOptFile.ItemIndex := 1
  else
    RG_UserOptFile.ItemIndex := 0;
  StandardMenuIndex := HauptFenster.IniFile.LoadStandardMenuIndex;
  With HauptFenster.IniFile do begin
    LoadMenuConfigKeys(True, PrivKeyList);
    LoadMenuConfigKeys(False, GlobKeyList);
    LB_PrivCfgs.Clear;
    For i := 0 to Pred(PrivKeyList.Count) do begin
      s := LoadMenuConfigName(PrivKeyList[i]);
      LB_PrivCfgs.Items.Add(s);
      end;
    LB_GlobCfgs.Clear;
    LB_GlobCfgs.Items.Add(MyMess[50]);
    For i := 0 to Pred(GlobKeyList.Count) do begin
      s := LoadMenuConfigName(GlobKeyList[i]);
      LB_GlobCfgs.Items.Add(s);
      end;
    If (StandardMenuIndex >= 0) and
       (StandardMenuIndex < LB_GlobCfgs.Count) then
      LB_GlobCfgs.Selected[StandardMenuIndex] := True;
    end;
  LB_CfgsClick(Nil);
  end;

procedure TNetOptionsDlg.LB_CfgsClick(Sender: TObject);
  begin
  btnShiftConfig2Global.Enabled := False;
  btnShiftConfig2Privat.Enabled := False;
  If Sender = LB_PrivCfgs then
    If LB_PrivCfgs.ItemIndex >= 0 then begin
      btnShiftConfig2Global.Enabled := True;
      LB_GlobCfgs.ItemIndex := -1;
      end;
  If Sender = LB_GlobCfgs then
    If LB_GlobCfgs.ItemIndex >= 0 then begin
      btnShiftConfig2Privat.Enabled := LB_GlobCfgs.ItemIndex >= 1;
      LB_PrivCfgs.ItemIndex := -1;
      end;
  btnSetAsDefaultMenuConfig.Enabled :=
     (LB_GlobCfgs.ItemIndex >= 0) and
     (LB_GlobCfgs.ItemIndex <> StandardMenuIndex);
  btnEditCfg.Enabled := LB_PrivCfgs.ItemIndex >= 0;
  btnDelCfg.Enabled  := LB_PrivCfgs.ItemIndex >= 0;
  end;

{===================== Daten speichern =================================}

procedure TNetOptionsDlg.BtnSaveNetOptionsClick(Sender: TObject);
  begin
  EditOptionsAllowed := CB_AllowEditOptions.Checked;
  SaveOptionsAllowed := CB_AllowSaveOptions.Checked;
  ChooseMenuAllowed := CB_AllowChooseMenu.Checked;
  EditMenuesAllowed := CB_AllowEditMenues.Checked;
  UserOptFileInExeDir := RG_UserOptFile.ItemIndex = 1;
  If Not HauptFenster.IniFile.SaveNetOptions then
    MessageDlg(MyMess[39], mtError, [mbOk], 0)
  else
    MessageDlg(MyMess[38], mtInformation, [mbOk], 0);
  end;

procedure TNetOptionsDlg.BtnSetAsDefaultMenuConfigClick(Sender: TObject);
  begin
  If Not HauptFenster.IniFile.SaveStandardMenuIndex(LB_GlobCfgs.ItemIndex) then
    MessageDlg(MyMess[31], mtError, [mbOk], 0)
  else
    MessageDlg(MyMess[38], mtInformation, [mbOk], 0);
  UpdateFormData;
  end;

{============= Menü-Konfigurationen verschieben ========================}

procedure TNetOptionsDlg.btnShiftConfig2GlobalClick(Sender: TObject);
  var key: String;
  begin
  key := PrivKeyList[LB_PrivCfgs.ItemIndex];
  If Not HauptFenster.IniFile.ShiftToGlobalMenuList(key) then
    MessageDlg(MyMess[30], mtError, [mbOk], 0);
  UpdateFormData;
  end;

procedure TNetOptionsDlg.btnShiftConfig2PrivatClick(Sender: TObject);
  var key: String;
  begin
  If LB_GlobCfgs.ItemIndex > 0 then begin
    key := GlobKeyList[LB_GlobCfgs.ItemIndex - 1];
    If Not HauptFenster.IniFile.ShiftToPrivatMenuList(key) then
      MessageDlg(MyMess[29], mtError, [mbOk], 0);
    UpdateFormData;
    end;
  end;

{=========== Private Menüs manipulieren ===============================}

procedure TNetOptionsDlg.btnNewCfgClick(Sender: TObject);
  var EditMenuConfigWin: TEditMenuConfigWin;
  begin
  EditMenuConfigWin := TEditMenuConfigWin.Create(Self);
  With EditMenuConfigWin do begin
    LoadCfgData(HauptFenster.IniFile.GetNewKeyStr(True));
    If ShowModal = mrOk then
      UpdateFormData;
    Release;
    end;
  end;

procedure TNetOptionsDlg.btnEditCfgClick(Sender: TObject);
  var EditMenuConfigWin: TEditMenuConfigWin;
  begin
  EditMenuConfigWin := TEditMenuConfigWin.Create(Self);
  With EditMenuConfigWin do begin
    LoadCfgData(PrivKeyList[LB_PrivCfgs.ItemIndex]);
    If ShowModal = mrOk then
      UpdateFormData;
    Release;
    end;
  end;

procedure TNetOptionsDlg.btnDelCfgClick(Sender: TObject);
  var key : String;
  begin
  key := PrivKeyList[LB_PrivCfgs.ItemIndex];
  Hauptfenster.IniFile.KillMenuConfig(key);
  UpdateFormData;
  end;

{========= Prozeduren für die Verwaltung gegenseitiger ====================}
{                Abhängigkeiten der Optionen                               }

procedure TNetOptionsDlg.CB_AllowEditOptionsClick(Sender: TObject);
  begin
  If Not CB_AllowEditOptions.Checked then begin
    CB_AllowSaveOptions.Checked := False;
    CB_AllowSaveOptions.Enabled := False;
    CB_AllowChooseMenu.Checked := False;
    CB_AllowChooseMenu.Enabled := False;
    CB_AllowEditMenues.Checked := False;
    CB_AllowEditMenues.Enabled := False;
    end
  else begin
    CB_AllowSaveOptions.Enabled := True;
    CB_AllowChooseMenu.Enabled := True;
    CB_AllowSvOptChMenuClick(Sender);
    end;
  end;

procedure TNetOptionsDlg.CB_AllowSvOptChMenuClick(Sender: TObject);
  begin
  If Not (CB_AllowChooseMenu.Checked and
          CB_AllowSaveOptions.Checked) then begin
    CB_AllowEditMenues.Checked := False;
    CB_AllowEditMenues.Enabled := False;
    end
  else
    CB_AllowEditMenues.Enabled := True;
  end;

end.
