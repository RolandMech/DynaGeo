unit AssAffAbb_2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TermForm;

type
  TAffAbb_2_Dlg = class(TTermForm)
    Bevel1: TBevel;
    OKBtn: TButton;
    CancelBtn: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    HelpBtn: TButton;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  protected
    FVisState: Integer;
    procedure SetVisState(newVal: Integer); virtual;
  public
    PatchStr : String;
    procedure InitTexts(s: String); virtual;
    procedure AddObj2Term(GO: TObject); override;
    property VisState: Integer read FVisState write SetVisState;
  end;


implementation

{$R *.dfm}

Uses Declar, MainWin;  // um auf die Daten und Methoden des
                       // Hauptfensters zugreifen zu können

procedure TAffAbb_2_Dlg.SetVisState(newVal: Integer);
  begin
  FVisState := newVal;
  Label3.Visible := VisState >= 1;
  Label4.Visible := VisState >= 2;
  Label5.Visible := VisState >= 3;
  OKBtn.Enabled  := VisState >= 4;
  end;

procedure TAffAbb_2_Dlg.FormShow(Sender: TObject);
  begin
  VisState := 1;
  end;

procedure TAffAbb_2_Dlg.InitTexts(s: String);
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
  PatchStr := s;
  Caption := Patch(Caption);
  Label3.Caption := Patch(Label3.Caption);
  Label4.Caption := Patch(Label4.Caption);
  Label5.Caption := Patch(Label5.Caption);
  end;

procedure TAffAbb_2_Dlg.AddObj2Term(GO: TObject);
  // Hier zunächst als leere Prozedur implementiert !
  begin
  end;

procedure TAffAbb_2_Dlg.CancelBtnClick(Sender: TObject);
  begin
  THauptFenster(Owner).Reset2DragMode;
  Close;
  end;

procedure TAffAbb_2_Dlg.HelpBtnClick(Sender: TObject);
  begin
  Application.HelpCommand(Help_Context, cmd_DefineAffin);
  end;

end.
