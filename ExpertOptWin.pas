unit ExpertOptWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GlobVars;

type
  TExpertOptWin = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    RG_DragStrategy: TRadioGroup;
    BtnSetExpertOpts: TButton;
    BtnCancel: TButton;
    GroupBox2: TGroupBox;
    CB_Recursion: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure RG_DragStrategyClick(Sender: TObject);
    procedure BtnSetExpertOptsClick(Sender: TObject);
  private
    { Private-Deklarationen }
    ActStrat  : Integer;
    ActRecurs : Boolean;
  public
    { Public-Deklarationen }
  end;


implementation

{$R *.dfm}

Uses MainWin;

procedure TExpertOptWin.FormShow(Sender: TObject);
  begin
  ActStrat := Hauptfenster.Drawing.DragStrategy;
  RG_DragStrategy.ItemIndex := ActStrat;
  ActRecurs := GlobVars.RecursionAllowed;
  CB_Recursion.Checked := ActRecurs;
  BtnSetExpertOpts.Enabled := False;
  end;

procedure TExpertOptWin.RG_DragStrategyClick(Sender: TObject);
  begin
  BtnSetExpertOpts.Enabled := (RG_DragStrategy.ItemIndex <> ActStrat) or
                              (CB_Recursion.Checked <> ActRecurs);
  end;

procedure TExpertOptWin.BtnSetExpertOptsClick(Sender: TObject);
  var mess : String;
  begin
  If Hauptfenster.Drawing.DragStrategy <> RG_DragStrategy.ItemIndex then begin
    Hauptfenster.Drawing.DragStrategy := RG_DragStrategy.ItemIndex;
    If Hauptfenster.Drawing.DragStrategy = 0 then
      mess := MyMess[23]
    else
      mess := MyMess[22];
    MessageDlg(mess, mtInformation, [mbOk], 0);
    end;
  If RecursionAllowed <> CB_Recursion.Checked then
    RecursionAllowed := CB_Recursion.Checked;
  end;

end.
