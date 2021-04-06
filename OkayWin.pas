unit OkayWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TOkayButton = class(TForm)
    OkayBtn: TButton;
    procedure OkayBtnClick(Sender: TObject);
    procedure OkayBtnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

Uses GlobVars, GeoTypes, GeoMakro, MainWin;

{$R *.DFM}

procedure TOkayButton.OkayBtnClick(Sender: TObject);
  begin
  With Hauptfenster do begin
    If OLineMode = 2 then
      RecordTraceClick;
    If MakroMode > 0 then
      SetNewMakroMode(Succ(MakroMode));
    end;
  end;

procedure TOkayButton.OkayBtnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
  If Key = vk_Escape then
    Hauptfenster.FormKeyDown(Sender, Key, Shift);
  end;

end.
