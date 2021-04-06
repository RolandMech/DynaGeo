unit WertEing;

interface

uses Windows, SysUtils, Classes, Graphics, Forms,
     Controls, StdCtrls, Buttons, ExtCtrls, ComCtrls,
     TermForm, FormatEdit;

type
  TWertEingabeDlg = class(TTermForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Edit1: TFormatEdit;
    procedure FormShow(Sender: TObject);
    procedure EditExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddObj2Term(GO: TObject); override;
  end;


implementation

{$R *.DFM}

Uses Dialogs, Utility, MathLib, TBaum, Declar, GlobVars,
     GeoTypes, GeoLocLines;

procedure TWertEingabeDlg.FormShow(Sender: TObject);
  var s : String;
  begin
  SetBounds(FPos.X, FPos.Y, Width, Height);
  Case FMode of
    cmd_MCreate      : begin
                       Edit1.HTMLTextAsString := '2';
                       Caption := MyMess[35];
                       end;
    cmd_EditRadius   : begin
                       Edit1.HTMLTextAsString := TGXCircle(EditedObj).rTerm.source_str;
                       Caption := MyMess[35];
                       end;
    cmd_GRichtTerm   : begin
                       Edit1.HTMLTextAsString := '45°';
                       Caption := MyMess[36];
                       end;
    cmd_EditAngle    : begin
                       Edit1.HTMLTextAsString := TGXLine(EditedObj).wTerm.source_str;
                       Caption := MyMess[36];
                       end;
    cmd_TermObj      : begin
                       Edit1.HTMLTextAsString := '';
                       Caption := MyMess[90];
                       end;
    cmd_Graph        : begin
                       Edit1.HTMLTextAsString := '';
                       Caption := MyMess[95];
                       end;
    cmd_EditFunktion : begin
                       s := TGFunktion(EditedObj).TermString;
                       Edit1.HTMLTextAsString := maskDelimiters(s);
                       Caption := MyMess[95];
                       end;
  else
    Edit1.HTMLTextAsString := '';
  end; { of case }
  With Edit1 do begin
    DefaultFont := GlobalDefaultFont;
    SelectActualLine;
    SetFocus;
    end;
  end;

procedure TWertEingabeDlg.AddObj2Term(GO: TObject);
  begin
  TGeoObj(GO).InsertMeasureInto(Edit1);
  end;

procedure TWertEingabeDlg.EditExit(Sender: TObject);
  begin
  If Sender is TFormatEdit then
    TFormatEdit(Sender).RevokeActSelection;
  end;

procedure TWertEingabeDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  begin
  If CancelBtn.Focused then
    CanClose := True
  else begin
    FValidResult := ValidTermIn(Edit1, ObjList);
    CanClose := FValidResult;
    If Not CanClose then
      Edit1.SetFocus;
    end;
  end;

end.
