unit MakHelpShow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TMakHelpWin = class(TForm)
    Memo1: TMemo;
    Okay: TButton;
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.DFM}

Uses GlobVars, MainWin, GeoMakro;


procedure TMakHelpWin.FormShow(Sender: TObject);
  var R : TRect;
  begin
  With Memo1 do begin
    R.Left := 5;
    R.Top  := 5;
    R.Right := Memo1.Width - 10;
    R.Bottom := Memo1.Height - 10;
    Perform(em_SetRect, 0, Integer(@R));
    end;
  Left := HauptFenster.Left + 60;
  Top  := HauptFenster.Top + 120;
  With TMakro(Hauptfenster.Drawing.MakroList[Hauptfenster.MakroNum]) do begin
    Caption := Format(MyMakMsg[20], [Name]);
    Memo1.Text := HelpText;
    end;
  end;

end.
