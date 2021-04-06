unit RiemannSum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TermForm, FormatEdit;

type
  TRiemannForm = class(TTermForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    Label2: TLabel;
    Bevel1: TBevel;
    EditTerm: TFormatEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure AddObj2Term(GO: TObject); override;
  end;

implementation

{$R *.dfm}

Uses Declar, GeoTypes, GeoLocLines, MainWin;

procedure TRiemannForm.FormShow(Sender: TObject);
  begin
  SetLinksToMainWindow;
  HelpContext := cmd_Riemann;
  InsertTempParams;
  end;

procedure TRiemannForm.AddObj2Term(GO: TObject);
  var cur_pos : TPoint;
      oL, nL  : Integer;
  begin
  cur_pos := EditTerm.ActCursorPos;
  oL := Length(EditTerm.PlainText[0]);
  TGeoObj(GO).InsertMeasureInto(EditTerm);
  nL := Length(EditTerm.PlainText[0]);
  cur_pos.X := cur_pos.X + nL - oL;
  EditTerm.ActCursorPos := cur_pos;
  InsertTempParams;
  end;

procedure TRiemannForm.Button1Click(Sender: TObject);
  begin
  If ValidTermIn(EditTerm, HauptFenster.Drawing) then begin
    HauptFenster.LastValueWStr[0] := EditTerm.PlainText[0];
    If RadioGroup1.ItemIndex = 0 then
      HauptFenster.LastValueWStr[1] := '0'
    else
      HauptFenster.LastValueWStr[1] := '1';
    SendMessage(Hauptfenster.Handle, cmd_ExternCommand, cmd_Riemann, 1);
    Hide;
    end
  else
    MessageBeep(mb_IconHand);
  end;

procedure TRiemannForm.Button2Click(Sender: TObject);
  begin
  SendMessage(Hauptfenster.Handle, cmd_ExternCommand, cmd_Riemann, 0);
  Hide;
  end;

end.
