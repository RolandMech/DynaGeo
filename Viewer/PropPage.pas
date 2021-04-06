unit PropPage;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses SysUtils, Windows, Messages, Classes, Graphics, Controls, StdCtrls,
  ExtCtrls, Forms, ComServ, ComObj, StdVcl, AxCtrls, Dialogs;

type
  TDGXPropPage1 = class(TPropertyPage)
    Ed_DataFile: TEdit;
    Label1: TLabel;
    Btn_Browse: TButton;
    OpenDialog1: TOpenDialog;
    procedure Btn_BrowseClick(Sender: TObject);
  private
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
  public
    { Public-Deklarationen }
    procedure UpdatePropertyPage; override;
    procedure UpdateObject; override;
  end;

const
  Class_DGXPropPage1: TGUID = '{821AAC6B-26F5-4898-9966-A2957425E6B3}';

implementation

{$R *.DFM}

procedure TDGXPropPage1.UpdatePropertyPage;
  begin   { Elemente mit Daten aus OleObject aktualisieren }
  Ed_DataFile.Text := OleObject.DataFile;
  end;

procedure TDGXPropPage1.UpdateObject;
  begin   { OleObject mit Daten aus den Elementen aktualisieren }
  OleObject.DataFile := Ed_DataFile.Text;
  end;

procedure TDGXPropPage1.Btn_BrowseClick(Sender: TObject);
  begin
  If OpenDialog1.Execute then
    Ed_DataFile.Text := OpenDialog1.FileName;
  end;

initialization
  TActiveXPropertyPageFactory.Create(
    ComServer,
    TDGXPropPage1,
    Class_DGXPropPage1);
end.
