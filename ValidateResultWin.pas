unit ValidateResultWin;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TValidationResultWin = class(TForm)
    Panel1: TPanel;
    SuccessPic: TImage;
    ResMess: TLabel;
    OKButton: TButton;
    CB_GoToNext: TCheckBox;
    FailPic: TImage;
    Label1: TLabel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    constructor CreateWD(AOwner: TComponent; Success, GoOn: Boolean;
                         ManualPos: Boolean = False);
  end;


implementation

{$R *.dfm}

uses GlobVars;

constructor TValidationResultWin.CreateWD(AOwner: TComponent; Success, GoOn: Boolean;
                                          ManualPos: Boolean = False);
  var R  : TRect;
      Pos: TPoint;
  begin
  Inherited Create(AOwner);
  CB_GoToNext.Visible := GoOn;
  CB_GoToNext.Checked := GoOn;
  If ManualPos then begin
    Position := poDesigned;
    With TWinControl(AOwner) do begin
      R   := BoundsRect;
      Pos := ClientToScreen(R.TopLeft);
      end;
    Left := Pos.X + (R.Right - R.Left - Self.Width) div 2;
    Top  := Pos.Y + (R.Bottom - R.Top - Self.Height) div 2;
    end;
  If Success then begin
    Caption := MyMess[112];
    ResMess.Caption := MyMess[113];
    FailPic.Visible := False;
    SuccessPic.Visible := True;
    Label1.Visible := False;
    end
  else begin
    Caption := MyMess[114];
    ResMess.Caption := MyMess[115];
    FailPic.Visible := True;
    SuccessPic.Visible := False;
    Label1.Visible := Not GoOn;
    end;
  end;


end.

