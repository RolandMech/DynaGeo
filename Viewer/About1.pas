unit About1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TDynaGeoXAbout = class(TForm)
    CtlImage: TSpeedButton;
    OkBtn: TButton;
    CopyrightLbl: TLabel;
    DescLbl: TLabel;
    Label1: TLabel;
    Image1: TImage;
  end;

procedure ShowDynaGeoXAbout(sc_x, sc_y: Integer; vers_str: String);

implementation

{$R *.DFM}

procedure ShowDynaGeoXAbout(sc_x, sc_y: Integer; vers_str: String);
  begin
  with TDynaGeoXAbout.Create(Nil) do
    try
      sc_x := sc_x - Width Div 2;
      sc_y := sc_y - Height Div 2;
      Label1.Caption := 'Version ' + vers_str;
      If sc_x < 10 then
        sc_x := 10;
      If sc_x + Width > Screen.DesktopWidth - 10 then
        sc_x := Screen.DesktopWidth - 10 - Width;
      If sc_y < 10 then
        sc_y := 10;
      If sc_y + Height > Screen.DesktopHeight - 10 then
        sc_y := Screen.DesktopHeight - 10 - Height;
      Left := sc_x;
      Top  := sc_y;
      ShowModal;
    finally
      Free;
    end;
  end;

end.
