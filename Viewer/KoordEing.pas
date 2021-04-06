unit KoordEing;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, TermForm, FormatEdit;

type
  TKoordEingabeDlg = class(TTermForm)
    Bevel1: TBevel;
    OKBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TFormatEdit;
    Edit2: TFormatEdit;
    procedure FormShow(Sender: TObject);
    procedure MyEditEnter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private-Deklarationen }
    ActEdit : TFormatEdit;
  public
    { Public-Deklarationen }
    procedure AddObj2Term(GO: TObject); override;
  end;


implementation

{$R *.DFM}

Uses Utility, Declar, GlobVars, MathLib, TBaum, GeoTypes;

procedure TKoordEingabeDlg.FormShow(Sender: TObject);
  begin
  SetBounds(FPos.X, FPos.Y, Width, Height);
  If EditedObj <> Nil then begin
    With Edit2 do begin
      Clear;
      DefaultFont := ObjList.StartFont;
      HTMLTextAsString := maskDelimiters(TGXPoint(EditedObj).YTerm.source_str);
      end;
    With Edit1 do begin
      Clear;
      DefaultFont := ObjList.StartFont;
      HTMLTextAsString := maskDelimiters(TGXPoint(EditedObj).XTerm.source_str);
      SetFocus;
      end;
    end
  else begin
    Edit1.Clear;
    Edit2.Clear;
    end;
  Invalidate;
  ActEdit := Edit1;
  end;

procedure TKoordEingabeDlg.MyEditEnter(Sender: TObject);
  begin
  If Sender is TFormatEdit then begin
    ActEdit := Sender as TFormatEdit;
    With ActEdit do
      ActCursorPos := Point(LineLength(0), 0);
    end;
  end;

procedure TKoordEingabeDlg.AddObj2Term(GO: TObject);
  begin
  TGeoObj(GO).InsertMeasureInto(ActEdit);
  end;

procedure TKoordEingabeDlg.FormCloseQuery(Sender: TObject;
                                          var CanClose: Boolean);
  begin
  If CancelBtn.Focused then
    CanClose := True
  else begin
    FValidResult := ValidTermIn(Edit1, ObjList) and
                    ValidTermIn(Edit2, ObjList);
    CanClose := FValidResult or (Sender = CancelBtn);
    If Not CanClose then
      ActEdit.SetFocus;
    end;  
  end;

end.
