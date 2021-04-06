unit GameAngles2Dlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, GeoTypes, GeoImage, Declar;

type
  TAngles2Dlg = class(TForm)
    StringGrid1: TStringGrid;
    Ed_Angle: TEdit;
    BtnNextAngle: TButton;
    BtnHelp: TButton;
    BtnEnde: TButton;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    CB_MidPt: TCheckBox;
    CB_Ruler: TCheckBox;
    procedure BtnHelpClick(Sender: TObject);
    procedure BtnNextAngleClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnEndeClick(Sender: TObject);
  private
    GeoListe : TGeoObjListe;
    t_1, t_2 : TGTermObj;
    s_sq     : TGSetSquare;
    n_1, n_2,
    aup, rc  : Integer; // "a"ccumulated "u"ser "p"oints, "r"ow "c"ount
    noteStr  : String;
    function df(n: Integer): Integer; // Distributionsfunktion (s.u.)
    function getPoints(a1, a2: Integer): Integer;  // Bewertungsfunktion
    function getNote(pt_sum: Integer): String;     // Benotungsfunktion
    procedure initMove;
    procedure initRound;
    procedure ReceiveSSPosFlags(var Msg: TMessage); message cmd_PosFlagChange;
  public
    constructor CreateWD(Parent: TComponent; iGeoListe: TGeoObjListe);
  end;


implementation

{$R *.dfm}

uses Math, Utility, GlobVars, GameRes1;

//=============== Constructor ========================

constructor TAngles2Dlg.CreateWD(Parent: TComponent; iGeoListe: TGeoObjListe);
  var go : TGeoObj;
  begin
  Inherited Create(Parent);
  GeoListe := iGeoListe;
  t_1 := GeoListe.GetGeoObjByName('T1') as TGTermObj;
  t_2 := GeoListe.GetGeoObjByName('T2') as TGTermObj;
  if GeoListe.HasSetsquare(go) then begin
    s_sq := go as TGSetSquare;
    end;
  Randomize;
  initRound;
  end;

//============== Component's Methods =====================

procedure TAngles2Dlg.BtnHelpClick(Sender: TObject);
  begin
  Application.HelpCommand(HELP_CONTEXT, idh_game_02);
  end;

procedure TAngles2Dlg.BtnNextAngleClick(Sender: TObject);
  begin
  if rc <= 0 then
    initRound  // new game
  else
    if (Length(StringGrid1.Cells[0, rc]) > 0) and
       (Length(StringGrid1.Cells[1, rc]) = 0) then begin
      MessageDlg(MyMess[158], mtWarning, [mbOk], 0);
      Ed_Angle.SetFocus;
      end
    else
      initMove; // next angle
  end;

procedure TAngles2Dlg.FormKeyPress(Sender: TObject; var Key: Char);
  const allowedChars : WideString = '0123456789° '#08;
  var dataStr : WideString;
      asu, up : Integer;  // "a"ngle "s"uggested by "u"ser, "u"ser "p"oints
      n       : Integer;  // "n"ote level
      ResDlg  : TGameRes1Dlg;
  begin
  if (Word(Key) = VK_RETURN) then
    if (Length(StringGrid1.Cells[0, rc]) > 0) and
       (Length(StringGrid1.Cells[1, rc]) = 0) then begin
      dataStr := Ed_Angle.Text;
      DeleteChars(' ', dataStr);
      if (Length(dataStr) > 0) and (dataStr[Length(dataStr)] = '°') then begin
        Delete(dataStr, Length(dataStr), 1);
        asu := StrToInt(dataStr);
        up := getPoints(asu, n_2);
        StringGrid1.Cells[1, rc] := IntToStr(asu) + '°';
        StringGrid1.Cells[2, rc] := IntToStr(n_2) + '°';
        StringGrid1.Cells[3, rc] := IntToStr(up);
        aup := aup + up; // Add "user points" to "accumulated user points"
        rc  := rc + 1;
        if rc > 10 then begin
          noteStr := getNote(aup);
          StringGrid1.Cells[3, rc] := noteStr;
          rc := 0;
          // MessageDlg with praise (if deserved)
          n := Ord(noteStr[1]) - Ord('0');
          ResDlg := TGameRes1Dlg.CreateWD(Self, noteStr, MyMess[160 + n]);
          try
            if ResDlg.ShowModal = mrYes then
              initRound  // restart game
            else
              Close;     // exit game
          finally
            ResDlg.Release;
          end;
          end;
        end
      else
        MessageDlg(MyMess[156], mtWarning, [mbOk], 0);
      end
    else
      MessageDlg(MyMess[157], mtWarning, [mbOk], 0)
  else { Alle unerwünschten Zeichen ausfiltern }
    if Pos(Key, allowedChars) <= 0 then begin
      Key := #0;
      Beep;
      end;
  end;

procedure TAngles2Dlg.BtnEndeClick(Sender: TObject);
  begin
  SendMessage(GeoListe.HostWinHandle, cmd_ExternCommand, cmd_ExitGame02, 0);
  Close;
  end;

//============== Private Helpers =====================

procedure TAngles2Dlg.ReceiveSSPosFlags(var Msg: TMessage);
  var w : Word;
  begin
  w := Msg.wParam;
  CB_MidPt.Checked := w and $0001 > 0;
  CB_Ruler.Checked := w and $0002 > 0;
  end;

function TAngles2Dlg.getPoints(a1, a2: Integer): Integer;
  var d, e : Integer;
  begin
  d := abs(a2 - a1);
  e := max(8 - d, 0);
  if CB_MidPt.Checked then e := e + 1;
  if CB_Ruler.Checked then e := e + 1;
  Result := e;
  end;

function TAngles2Dlg.getNote(pt_sum: Integer): String;
  begin
  if pt_sum > 95 then Result := '1'   else
  if pt_sum > 91 then Result := '1-2' else
  if pt_sum > 87 then Result := '2'   else
  if pt_sum > 83 then Result := '2-3' else
  if pt_sum > 79 then Result := '3'   else
  if pt_sum > 74 then Result := '3-4' else
  if pt_sum > 68 then Result := '4'   else
  if pt_sum > 60 then Result := '4-5' else
  if pt_sum > 52 then Result := '5'   else
  if pt_sum > 42 then Result := '5-6' else
                      Result := '6';
  end;

procedure TAngles2Dlg.initRound;
  var i, k: Integer;
  begin
  With StringGrid1 do begin
    for i := 0 to 3 do
      for k := 0 to 11 do
        Cells[i, k] := '';
    Cells[0, 0] := ' Winkel Nr. ';
    Cells[1, 0] := '  Messwert  ';
    Cells[2, 0] := 'exakter Wert';
    Cells[3, 0] := '  Punkte';
    Cells[2,11] := '   Note:';
    end;
  rc := 1;
  initMove;
  end;

procedure TAngles2Dlg.initMove;
  begin
  Ed_Angle.Text := '';
  StringGrid1.Cells[0, rc] := IntToStr(rc);
  n_1 :=    Random(360);
  n_2 := df(Random(360));
  t_1.SetNewTerm(IntToStr(n_1) + '°');
  t_2.SetNewTerm(IntToStr(n_2) + '°');
  if Assigned(s_sq) then
    s_sq.MoveAndTurnRandomly;
  GeoListe.UpdateAllObjects();
  GeoListe.Repaint;
  end;

// The following distribution function changes the uniform distribution
// of the random numbers n, so that acute angles are preferred and will
// appear more often than obtuse or convex angles.
function TAngles2Dlg.df(n: Integer): Integer;
  var x, y : Double;
  begin
  x := n / 360.0;
  y := x / 3 + 2 / 3 * Math.Power(x, 3);
  Result := Round(y * 360);
  end;

end.
