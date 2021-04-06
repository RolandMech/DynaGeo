unit GameAngles1Dlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, GeoTypes;

type
  TAngles1Dlg = class(TForm)
    BtnEnde: TButton;
    BtnHelp: TButton;
    RGAngleGroup: TRadioGroup;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    BtnNextAngle: TButton;
    Label2: TLabel;
    Ed_Angle: TEdit;
    procedure BtnEndeClick(Sender: TObject);
    procedure BtnNextAngleClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnHelpClick(Sender: TObject);
    procedure RGAngleGroupClick(Sender: TObject);
  private
    GeoListe : TGeoObjListe;
    t_1, t_2 : TGTermObj;
    n_1, n_2,
    aup, rc  : Integer; // "a"ccumulated "u"ser "p"oints, "r"ow "c"ount
    noteStr  : String;
    function df(n: Integer): Integer; // Distributionsfunktion (s.u.)
    function getKindPt: Integer;
    function getPoints(a1, a2: Integer): Integer;  // Bewertungsfunktion
    function getNote(pt_sum: Integer): String;     // Benotungsfunktion
    procedure initMove;
    procedure initRound;
  public
    constructor CreateWD(Parent: TComponent; iGeoListe: TGeoObjListe);
  end;


implementation

{$R *.dfm}

uses Math, Utility, Declar, GlobVars, GameRes1;

//=============== Constructor ========================

constructor TAngles1Dlg.CreateWD(Parent: TComponent; iGeoListe: TGeoObjListe);
  begin
  Inherited Create(Parent);
  GeoListe := iGeoListe;
  t_1 := GeoListe.GetGeoObjByName('T1') as TGTermObj;
  t_2 := GeoListe.GetGeoObjByName('T2') as TGTermObj;
  Randomize;
  initRound;
  end;

//============== Component's Methods =====================

procedure TAngles1Dlg.BtnHelpClick(Sender: TObject);
  begin
  Application.HelpCommand(HELP_CONTEXT, idh_game_01);
  end;

procedure TAngles1Dlg.BtnNextAngleClick(Sender: TObject);
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

procedure TAngles1Dlg.RGAngleGroupClick(Sender: TObject);
  begin
  Ed_Angle.SetFocus;
  end;

procedure TAngles1Dlg.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TAngles1Dlg.BtnEndeClick(Sender: TObject);
  begin
  Close;
  end;

//============== Private Helpers =====================

function TAngles1Dlg.getKindPt: Integer;
  var rk: Integer;  // "r"eal "k"ind
  begin
  if n_2 =   0 then rk := 0 else   // Nullwinkel          (zero angle     )
  if n_2 <  90 then rk := 1 else   // Spitzer Winkel      (acute angle    )
  if n_2 =  90 then rk := 2 else   // Rechter Winkel      (right angle    )
  if n_2 < 180 then rk := 3 else   // Stumpfer Winkel     (obtuse angle   )
  if n_2 = 180 then rk := 4 else   // Gestreckter Winkel  (straight angle )
  if n_2 < 360 then rk := 5 else   // Überstumpfer Winkel (convex angle   )
                    rk := 6;       // Vollwinkel          (full angle     )
  if RGAngleGroup.ItemIndex = rk then
    Result := 1
  else
    Result := 0;
  end;

function TAngles1Dlg.getPoints(a1, a2: Integer): Integer;
  const param : Integer = 3; // Parameter für die Strenge der Bewertung:
                             // 2: streng;  3: normal;  4: lasch
  var d, e : Integer;
  begin
  d := abs(a2 - a1);
  e := max(9 - d div param, 0) + getKindPt;
  Result := e;
  end;

function TAngles1Dlg.getNote(pt_sum: Integer): String;
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

procedure TAngles1Dlg.initRound;
  var i, k: Integer;
  begin
  With StringGrid1 do begin
    for i := 0 to 3 do
      for k := 0 to 11 do
        Cells[i, k] := '';
    Cells[0, 0] := '  Winkel Nr.';
    Cells[1, 0] := ' Schätzwert';
    Cells[2, 0] := 'realer Wert';
    Cells[3, 0] := '  Punkte';
    Cells[2,11] := '   Note:';
    end;
  rc := 1;
  initMove;
  end;

procedure TAngles1Dlg.initMove;
  begin
  RGAngleGroup.ItemIndex := -1;
  Ed_Angle.Text := '';
  StringGrid1.Cells[0, rc] := IntToStr(rc);
  n_1 :=    Random(360);
  n_2 := df(Random(360));
  t_1.SetNewTerm(IntToStr(n_1) + '°');
  t_2.SetNewTerm(IntToStr(n_2) + '°');
  GeoListe.UpdateAllObjects();
  GeoListe.Repaint;
  end;

// The following distribution function changes the uniform distribution
// of the random numbers n, so that acute angles are preferred and will
// appear more often than obtuse or convex angles.
function TAngles1Dlg.df(n: Integer): Integer;
  var x, y : Double;
  begin
  x := n / 360.0;
  y := x / 3 + 2 / 3 * Math.Power(x, 3);
  Result := Round(y * 360);
  end;

end.
