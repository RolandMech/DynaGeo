unit SelectXCmd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls;

type
  TSelectXCmdForm = class(TForm)
    CmdListBox: TCheckListBox;
    Label1: TLabel;
    BtnOkay: TButton;
    BtnCancel: TButton;
    BtnDelSel: TButton;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure BtnDelSelClick(Sender: TObject);
    procedure CmdListBoxClickCheck(Sender: TObject);
  private
    { Private-Deklarationen }
    max_n  : Integer;
    CmdStr : String;
  public
    { Public-Deklarationen }
    constructor CreateWithCmdStr(iParent: TComponent; iCmdStr: String);
    function GetCommands: String;
  end;

implementation

{$R *.dfm}

uses GlobVars, Utility, ToolBarProc;

constructor TSelectXCmdForm.CreateWithCmdStr(iParent: TComponent; iCmdStr: String);
  begin
  Inherited Create(iParent);
  CmdStr := iCmdStr;
  CmdListBox.MultiSelect := True;
  end;

procedure TSelectXCmdForm.FormCreate(Sender: TObject);
  var s        : String;
      cn, n, i : Integer;
  begin
  // ShareWareNag gekillt 04.01.2016;
  // If IsShareWare then max_n :=  3
  // else
  max_n := 12;
  For i := 0 to MaxSelXCmdIndex do
    CmdListBox.Selected[i] := False;
  s := CmdStr;
  n := 0;
  While (Length(s) > 0) and (n < max_n) do begin
    cn := CutByteFromHexStr(s);
    For i := 0 to MaxSelXCmdIndex do
      If (cn = SelXCmdId(i)) then begin
        CmdListBox.Checked[i] := True;
        n := n + 1;
        end;
    end;
  CmdListBoxClickCheck(Sender);
  end;

function TSelectXCmdForm.GetCommands: String;
  var pu : String;
      i  : Integer;
  begin
  pu := '';
  For i := 0 to MaxSelXCmdIndex do
    If CmdListBox.Checked[i] then
      pu := pu + IntToHex(SelXCmdId(i), 2);
  Result := pu;
  end;

procedure TSelectXCmdForm.BtnDelSelClick(Sender: TObject);
  var i : Integer;
  begin
  With CmdListBox do begin
    For i := 0 to MaxSelXCmdIndex do begin
      Checked[i] := False;
      ItemEnabled[i] := True;
      end;
    Repaint;
    end;
  end;

procedure TSelectXCmdForm.CmdListBoxClickCheck(Sender: TObject);
  var n, i : Integer;
  begin
  With CmdListBox do begin
    n := 0;
    For i := 0 to MaxSelXCmdIndex do
      If CmdListBox.Checked[i] then
        n := n + 1;
    If n >= max_n then begin
      For i := 0 to MaxSelXCmdIndex do
        If Not Checked[i] then
          ItemEnabled[i] := False;
      end
    else begin
      n := 0;
      For i := 0 to MaxSelXCmdIndex do
        If Not ItemEnabled[i] then begin
          ItemEnabled[i] := True;
          n := n + 1;
          end;
      If n > 0 then Repaint;
      end;
    end;
  end;

end.
