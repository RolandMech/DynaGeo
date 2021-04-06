unit CTextWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TConstrTextWin = class(TForm)
    Memo1: TMemo;
    procedure FormActivate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.DFM}

Uses GeoTypes, Eukl20;

procedure TConstrTextWin.FormActivate(Sender: TObject);
  var buf : String;
      i   : Integer;
  begin
  Memo1.Clear;
  With Drawing, Memo1 do
    For i := 5 to LastValidObject do with TGeoObj(Items[i]) do begin
      GetInfo(buf);
      If Status >= gs_DataValid then
        If IsVisible then
          lines[i-5] := '   ' + buf + #13#10
        else
          lines[i-5] := '    ( ' + buf + ' )'#13#10
      else
        lines[i-5] := '    {{ ' + buf + ' }}'#13#10;
      end;
  end;

end.
