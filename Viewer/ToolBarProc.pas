unit ToolBarProc;

interface

uses Windows, SysUtils, ComCtrls, Declar, GlobVars;

const     MaxSelXCmdIndex = 40;

function  SelXCmdId(n: Integer) : Integer;
procedure InitializeToolCommands(Toolbar : TToolBar; CmdStr: String);
procedure AdjustAnimationButton(img_id, cmd_id: Integer);


implementation

type  tTBDataLine = record
                      img_id   : Integer;
                      cmd_id   : Integer;
                      btn_style: TToolButtonStyle;
                      hint_str : String;
                    end;

const TBData : Array[0..MaxSelXCmdIndex] of tTBDataLine =
                 ((img_id:  0; cmd_id: 121; btn_style: tbsCheck;  hint_str : 'Basispunkt'),
                  (img_id:  1; cmd_id: 109; btn_style: tbsCheck;  hint_str : 'Punkt auf einer Linie'),
                  (img_id:  7; cmd_id: 132; btn_style: tbsCheck;  hint_str : 'Schnittpunkt(e) zweier Linien'),
                  (img_id:  8; cmd_id: 133; btn_style: tbsCheck;  hint_str : 'Mittelpunkt'),
                  (img_id:  2; cmd_id: 122; btn_style: tbsCheck;  hint_str : 'Strecke zwischen 2 Punkten'),
                  (img_id:  4; cmd_id:  45; btn_style: tbsCheck;  hint_str : 'Vektor'),
                  (img_id:  3; cmd_id: 123; btn_style: tbsCheck;  hint_str : 'Gerade durch 2 Punkte'),
                  (img_id: 27; cmd_id: 139; btn_style: tbsCheck;  hint_str : 'Gerade in bestimmtem Winkel'),
                  (img_id: 12; cmd_id: 138; btn_style: tbsCheck;  hint_str : 'Lot'),
                  (img_id: 11; cmd_id: 137; btn_style: tbsCheck;  hint_str : 'Parallele'),
                  (img_id:  9; cmd_id: 135; btn_style: tbsCheck;  hint_str : 'Mittelsenkrechte'),
                  (img_id: 10; cmd_id: 136; btn_style: tbsCheck;  hint_str : 'Winkelhalbierende'),
                  (img_id: 39; cmd_id:  43; btn_style: tbsCheck;  hint_str : 'Halbgerade'),
                  (img_id:  5; cmd_id: 124; btn_style: tbsCheck;  hint_str : 'Kreis um Mittelpunkt durch Kreispunkt'),
                  (img_id: 28; cmd_id: 129; btn_style: tbsCheck;  hint_str : 'Kreis mit bestimmtem Radius'),
                  (img_id:  6; cmd_id: 131; btn_style: tbsCheck;  hint_str : 'N-Eck'),
                  (img_id: 38; cmd_id: 152; btn_style: tbsCheck;  hint_str : 'Punkt an Linie binden'),
                  (img_id: 37; cmd_id: 153; btn_style: tbsCheck;  hint_str : 'Punktbindung lösen'),
                  (img_id: 13; cmd_id:  47; btn_style: tbsCheck;  hint_str : 'Objekt an Achse spiegeln'),
                  (img_id: 14; cmd_id:  49; btn_style: tbsCheck;  hint_str : 'Objekt an Punkt spiegeln'),
                  (img_id: 15; cmd_id:  51; btn_style: tbsCheck;  hint_str : 'Objekt verschieben'),
                  (img_id: 16; cmd_id:  53; btn_style: tbsCheck;  hint_str : 'Objekt drehen'),
                  (img_id: 17; cmd_id:  55; btn_style: tbsCheck;  hint_str : 'Objekt zentrisch strecken'),
                  (img_id: 18; cmd_id:  56; btn_style: tbsCheck;  hint_str : 'Objekt an Kreis spiegeln'),
                  (img_id: 19; cmd_id: 158; btn_style: tbsCheck;  hint_str : 'Ortslinie aufzeichnen'),
                  (img_id: 20; cmd_id: 114; btn_style: tbsCheck;  hint_str : 'Objekt löschen'),
                  (img_id: 21; cmd_id: 156; btn_style: tbsCheck;  hint_str : 'Abstand messen'),
                  (img_id: 22; cmd_id: 155; btn_style: tbsCheck;  hint_str : 'Winkelweite messen'),
                  (img_id: 40; cmd_id: 159; btn_style: tbsCheck;  hint_str : 'Flächeninhalt messen'),
                  (img_id: 23; cmd_id: 104; btn_style: tbsButton; hint_str : 'Zeichnung speichern unter...'),
                  (img_id: 24; cmd_id: 215; btn_style: tbsButton; hint_str : 'Animation'),
                  (img_id: 26; cmd_id:  90; btn_style: tbsCheck;  hint_str : 'Neue Textbox'),
                  (img_id: 30; cmd_id:  78; btn_style: tbsCheck;  hint_str : 'Zahlobjekt'),
                  (img_id: 29; cmd_id:  79; btn_style: tbsCheck;  hint_str : 'Termobjekt'),
                  (img_id: 31; cmd_id: 145; btn_style: tbsCheck;  hint_str : 'Makros'),                   // (*)
                  (img_id: 32; cmd_id:  30; btn_style: tbsCheck;  hint_str : 'Korrektheits-Prüfung'),     // (*)
                  (img_id: 33; cmd_id: 222; btn_style: tbsCheck;  hint_str : 'Ellipse'),
                  (img_id: 34; cmd_id: 225; btn_style: tbsCheck;  hint_str : 'Parabel'),
                  (img_id: 35; cmd_id: 228; btn_style: tbsCheck;  hint_str : 'Hyperbel'),
                  (img_id: 36; cmd_id: 230; btn_style: tbsCheck;  hint_str : 'Funktion'),
                  (img_id: 37; cmd_id: 235; btn_style: tbsCheck;  hint_str : 'Einhüllende aufzeichnen'));

      CmdsUnknown2DynaGeoJ = [ 30, 145 ]; //   Also : keine Korrektheitsprüfung und keine Makros!

var FToolBtnAnimation : TToolButton;

function SelXCmdId(n : Integer): Integer;
  begin
  If (n >= 0) and (n <= MaxSelXCmdIndex) then
    Result := TBData[n].cmd_id
  else
    Result := -1;
  end;

function Switch2NewCmd(oldcmd: Integer): Integer;
  begin
  Result := oldcmd;    // Standard-Fall
  If (Length(GeoFileVersion) > 0) and
     (GeoFileVersion < '2.8') then
    Case oldcmd of
      47 : Result := 51;
      49 : Result := 52;
      51 : Result := 53;
      53 : Result := 54;
    end;
  end;

procedure InitializeToolCommands(Toolbar : TToolBar; CmdStr: String);
  var cn, bn, i : Integer;
  begin
  FToolBtnAnimation := Nil;
  For i := 0 to Pred(ToolBar.ButtonCount) do
    ToolBar.Buttons[i].Visible := False;
  If Length(CmdStr) > 0 then begin
    If Length(CmdStr) > 2 * ToolBar.ButtonCount then
      CmdStr := Copy(CmdStr, 1, 2*ToolBar.ButtonCount);
    bn := 0;
    While (Length(cmdstr) > 0) and
          (bn < ToolBar.ButtonCount) do begin
      cn := StrToInt('$' + Copy(cmdstr, 1, 2));
      Delete(cmdstr, 1, 2);
      i := -1;
      Repeat
        i := i + 1
      until (i > MaxSelXCmdIndex) or (TBData[i].cmd_id = cn);
      If i <= MaxSelXCmdIndex then begin
        With ToolBar.Buttons[bn] do begin
          ImageIndex := TBData[i].img_id;
          Tag        := TBData[i].cmd_id;
          Style      := TBData[i].btn_style;
          Hint       := TBData[i].hint_str;
          Visible    := True;
          end;
        If TBData[i].cmd_id = cmd_RunAnimaFD then
          FToolBtnAnimation := ToolBar.Buttons[bn];
        bn := bn + 1;
        end;
      end;
    end
  else begin

    end;
  end;


procedure AdjustAnimationButton(img_id, cmd_id: Integer);
  begin
  If FToolBtnAnimation <> Nil then
    try
      FToolBtnAnimation.ImageIndex := img_id;
      FToolBtnAnimation.Tag        := cmd_id;
    except
      FToolBtnAnimation := Nil;
    end;  { of try }
  end;



initialization
  FToolBtnAnimation := Nil;
end.
