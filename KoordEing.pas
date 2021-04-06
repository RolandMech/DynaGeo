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
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MyEditEnter(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure MyEditExit(Sender: TObject);
  private
    { Private-Deklarationen }
    ActEdit : TFormatEdit;
  public
    { Public-Deklarationen }
    procedure AddObj2Term(GO: TObject); override;
  end;


implementation

{$R *.DFM}

Uses Utility, Declar, GlobVars, MathLib, TBaum, GeoTypes, MainWin;

procedure TKoordEingabeDlg.FormShow(Sender: TObject);
  begin
  SetLinksToMainWindow;
  InsertTempParams;
  With Edit2 do begin
    DefaultFont := Hauptfenster.Drawing.StartFont;
    SelectActualLine;
    SetSize(12);
    RevokeActSelection;
    end;
  With Edit1 do begin
    DefaultFont := Hauptfenster.Drawing.StartFont;
    SelectActualLine;
    SetSize(12);
    SetFocus;
    end;
  Invalidate;
  ActEdit := Edit1;
  end;

procedure TKoordEingabeDlg.MyEditEnter(Sender: TObject);
  begin
  If Sender is TFormatEdit then begin
    ActEdit := Sender as TFormatEdit;
    With Sender as TFormatEdit do begin
      SelectActualLine;
      ActCursorPos := Point(LineLength(0), 0);
      end;
    end;
  end;

procedure TKoordEingabeDlg.MyEditExit(Sender: TObject);
  begin
  If Sender is TFormatEdit then
    (Sender as TFormatEdit).RevokeActSelection;
  end;

procedure TKoordEingabeDlg.AddObj2Term(GO: TObject);
  var cur_pos : TPoint;
      oL, nL  : Integer;
  begin
  cur_pos := ActEdit.ActCursorPos;
  oL := Length(ActEdit.PlainText[0]);
  TGeoObj(GO).InsertMeasureInto(ActEdit);
  nL := Length(ActEdit.PlainText[0]);
  cur_pos.X := cur_pos.X + nL - oL;
  ActEdit.ActCursorPos := cur_pos;
  InsertTempParams;
  end;

procedure TKoordEingabeDlg.OKBtnClick(Sender: TObject);
  begin
  If ValidTermIn(Edit1, HauptFenster.Drawing) and
     ValidTermIn(Edit2, HauptFenster.Drawing) then begin
    Hide;
    with HauptFenster do begin
      LastValueWStr[0] := HTMLString2WideString(Edit1.GetHTMLTextLine(0));
      LastValueWStr[1] := HTMLString2WideString(Edit2.GetHTMLTextLine(0));
      Case Modus of
        cmd_PtCoord    : SendMessage(Handle, cmd_ExternCommand,
                                     cmd_PtCoord, LongInt(0));
        cmd_EditCoords : SendMessage(Handle, cmd_PopupCommand,
                                     cmd_EditCoords, LongInt(1));
      end; { of case }
      end;
    end;
  end;

procedure TKoordEingabeDlg.CancelBtnClick(Sender: TObject);
  begin
  Hide;
  With HauptFenster do begin
    AutoRepeat   := False;
    LastValueWStr[0] := '';
    Reset2DragMode;
    end;
  end;

procedure TKoordEingabeDlg.FormHide(Sender: TObject);
  begin
  HauptFenster.ActiveTermWin := Nil;
  end;

end.
