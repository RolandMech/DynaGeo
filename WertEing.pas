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
    procedure CancelBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure EditExit(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    isCreating : Boolean;
  public
    { Public declarations }
    procedure AddObj2Term(GO: TObject); override;
  end;


implementation

{$R *.DFM}

Uses Dialogs, Utility, MathLib, TBaum, Declar, GlobVars, GeoTypes, MainWin;

procedure TWertEingabeDlg.FormShow(Sender: TObject);
  begin
  SetLinksToMainWindow;
  InsertTempParams;
  With Edit1 do begin
    DefaultFont := Hauptfenster.Drawing.StartFont;
    SelectActualLine;
    SetSize(12);
    SetFocus;
    end;
  end;

procedure TWertEingabeDlg.AddObj2Term(GO: TObject);
  var cur_pos : TPoint;
      oL, nL  : Integer;
  begin
  cur_pos := Edit1.ActCursorPos;
  oL := Length(Edit1.PlainText[0]);
  TGeoObj(GO).InsertMeasureInto(Edit1);
  nL := Length(Edit1.PlainText[0]);
  cur_pos.X := cur_pos.X + nL - oL;
  Edit1.ActCursorPos := cur_pos;
  InsertTempParams;
  end;

procedure TWertEingabeDlg.CancelBtnClick(Sender: TObject);
  begin
  Hide;
  With HauptFenster do begin
    AutoRepeat   := False;
    LastValueWStr[0] := '';
    Reset2DragMode;
    end;
  end;

procedure TWertEingabeDlg.OKBtnClick(Sender: TObject);
  begin
  If ValidTermIn(Edit1, HauptFenster.Drawing) then begin
    HauptFenster.LastValueWStr[0] := GetWideTextFrom(Edit1);
    Case HauptFenster.Modus of
      cmd_MCreate        : RestoreOldParams(1, 24);
      cmd_EditRadius     : SendMessage(HauptFenster.Handle, cmd_PopupCommand,
                                       cmd_EditRadius, 1);
      cmd_EditFunktion   : SendMessage(Hauptfenster.Handle, cmd_PopupCommand,
                                       cmd_EditFunktion, 1);
      cmd_GRichtTerm,
      cmd_SRichtTerm     : If UnsignedConstantIn(Edit1) then
                             RestoreOldParams(3, 28)
                           else
                             RestoreOldParams(2, 44);
      cmd_EditAngle      : SendMessage(HauptFenster.Handle, cmd_PopupCommand,
                                       cmd_EditAngle, 1);
      cmd_EditRieIntCount: SendMessage(HauptFenster.Handle, cmd_PopupCommand,
                                       cmd_EditRieIntCount, 1);
      cmd_EditXCoord     : SendMessage(Hauptfenster.Handle, cmd_PopupCommand,
                                         cmd_EditXCoord, 1);

      cmd_TermObj        : If ConstantIn(Edit1) then
                             SendMessage(Hauptfenster.Handle, cmd_ExternCommand,
                                         cmd_TermObj, 0)
                           else
                             SendMessage(Hauptfenster.Handle, cmd_ExternCommand,
                                         cmd_TermObj, 1);
      cmd_verging        : SendMessage(Hauptfenster.Handle, cmd_ExternCommand,
                                         cmd_verging, 0);
      cmd_Graph          : SendMessage(Hauptfenster.Handle, cmd_ExternCommand,
                                         cmd_Graph, 0);
      cmd_Riemann        : SendMessage(Hauptfenster.Handle, cmd_ExternCommand,
                                         cmd_Riemann, 0);
    end; { of case }
    Hide;   { Hier wird das Fenster verborgen. }
    end
  else
    ModalResult := mrNone;
  end;

procedure TWertEingabeDlg.FormHide(Sender: TObject);
  begin
  HauptFenster.ActiveTermWin := Nil;
  end;

procedure TWertEingabeDlg.EditExit(Sender: TObject);
  begin
  If Sender is TFormatEdit then
    TFormatEdit(Sender).RevokeActSelection;
  end;

procedure TWertEingabeDlg.FormResize(Sender: TObject);
  var dx, mx : Integer;
  begin
  If isCreating then
    Exit;
  dx := Edit1.Left - Bevel1.Left;
  Bevel1.Width   := ClientWidth - dx - Edit1.Left;
  Bevel1.Height  := ClientHeight - Bevel1.Top * 3 - OKBtn.Height;
  Edit1.Width    := Bevel1.Width - 2 * dx;
  Edit1.Height   := Bevel1.Height - 2 * dx;
  mx := ClientWidth Div 2;
  OkBtn.Left     := mx - 10 - OKBtn.Width;
  CancelBtn.Left := mx + 10;
  OKBtn.Top      := Bevel1.Top * 2 + Bevel1.Height;
  CancelBtn.Top  := OKBtn.Top;
  end;

procedure TWertEingabeDlg.FormCreate(Sender: TObject);
  var new_cw, new_ch : Integer;
  begin
  isCreating := True;
  new_cw := 2 * Bevel1.Left + Bevel1.Width;
  If ClientWidth < new_cw then
    ClientWidth := new_cw;
  new_ch := Bevel1.Top * 3 + Bevel1.Height + OKBtn.Height;
  If ClientHeight < new_ch then
    ClientHeight := new_ch;
  Constraints.MinWidth := Width;
  Constraints.MinHeight := Height;
  isCreating := False;
  FormResize(Sender);
  end;

end.
