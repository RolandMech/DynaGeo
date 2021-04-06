unit TermEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  TermForm, Spin, FormatEdit, ExtCtrls;

type
  TTermEditDlg = class(TTermForm)
    Okay: TButton;
    Cancel: TButton;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    EditComment: TEdit;
    CB_ShowName: TCheckBox;
    CB_ShowComment: TCheckBox;
    SE_Decimals: TSpinEdit;
    Label1: TLabel;
    CB_ShowTerm: TCheckBox;
    EditTerm: TFormatEdit;
    RG_Format: TRadioGroup;
    procedure OkayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure CB_ShowCommentClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SE_DecimalsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    isLoading: Boolean;
  public
    { Public-Deklarationen }
    procedure AddObj2Term(GO: TObject); override;
  end;


implementation

{$R *.DFM}

uses Declar, GlobVars, Utility, TBaum, GeoTypes, MainWin;

procedure TTermEditDlg.FormShow(Sender: TObject);
  var s : WideString;
  begin
  SetLinksToMainWindow;
  caption := Format(MyMess[58], [EditedObj.Name]);
  With TGTermObj(EditedObj) do begin
    CB_ShowTerm.Checked    := ShowTerm;
    CB_ShowName.Checked    := ShowName;
    CB_ShowComment.Checked := Length(Comment) > 0;
    SE_Decimals.Value      := DeciDigits;
    EditComment.Text       := Comment;
    EditComment.Enabled    := CB_ShowComment.Checked;
    RG_Format.ItemIndex    := OutFormat;
    end;
  With EditTerm do begin
    Clear;
    DefaultFont := EditedObj.ObjList.StartFont;
    s := TGTermObj(EditedObj).GetHTMLString;  // WideString2HTMLString(HauptFenster.LastValueStr[0]);
    HTMLTextAsString := s;
    SelectActualLine;
    SetFocus;
    end;
  InsertTempParams;
  end;

procedure TTermEditDlg.CB_ShowCommentClick(Sender: TObject);
  begin
  EditComment.Enabled := CB_ShowComment.Checked;
  If EditComment.Enabled then
    EditComment.SetFocus;
  end;

procedure TTermEditDlg.AddObj2Term(GO: TObject);
  var cur_pos : TPoint;
      oL, nL  : Integer;
  begin
  cur_pos := EditTerm.ActCursorPos;
  oL := Length(EditTerm.PlainText[0]);
  TGeoObj(GO).InsertMeasureInto(EditTerm);
  nL := Length(EditTerm.PlainText[0]);
  cur_pos.X := cur_pos.X + nL - oL;
  EditTerm.ActCursorPos := cur_pos;
  InsertTempParams;
  end;

procedure TTermEditDlg.OkayClick(Sender: TObject);
  begin
  If ValidTermIn(EditTerm, HauptFenster.Drawing) then begin
    With TGTermObj(EditedObj) do begin
      SetNewTerm(GetWideTextFrom(EditTerm));
      ShowName   := CB_ShowName.Checked;
      DeciDigits := SE_Decimals.Value;
      ShowTerm   := CB_ShowTerm.Checked;
      OutFormat  := RG_Format.ItemIndex;
      If CB_ShowComment.Checked then
        Comment := EditComment.Text
      else
        Comment := '';
      ReDimData;
      end;
    HauptFenster.Drawing.SortObjects;
    Hide;   { Hier wird das Fenster verborgen. }
    Hauptfenster.Drawing.Repaint;
    end
  else
    MessageBeep(mb_IconHand);
  end;

procedure TTermEditDlg.CancelClick(Sender: TObject);
  begin
  Hide;
  end;

procedure TTermEditDlg.FormHide(Sender: TObject);
  begin
  With Hauptfenster do begin
    ActiveTermWin := Nil;
    If EditedObj <> Nil then
      Drawing.UpdateAllDescendentsOf(EditedObj);
    Reset2DragMode;
    end;
  end;


procedure TTermEditDlg.FormCreate(Sender: TObject);
  var cw, ch : Integer;
  begin
  isLoading := True;
  cw := GroupBox1.Left * 2 + GroupBox1.Width;
  If cw > ClientWidth then
    ClientWidth := cw;
  ch := Okay.Height + GroupBox1.Height + EditTerm.Height + 4 * EditTerm.Top;
  If ch > ClientHeight then
    ClientHeight := ch;
  Constraints.MinWidth := Width;
  Constraints.MinHeight := Height;
  isLoading := False;
  FormResize(Sender);
  end;

procedure TTermEditDlg.FormResize(Sender: TObject);
  var dx, dx1, dx2, dy: Integer;
  begin
  If isLoading then
    Exit;
  dy := EditTerm.Top;
  Okay.Top := ClientHeight - Okay.Height - dy;
  Cancel.Top := Okay.Top;
  GroupBox1.Top := Okay.Top - GroupBox1.Height - dy;
  EditTerm.Height := GroupBox1.Top - 2 * dy;
  dx := ClientWidth - GroupBox1.Width;
  GroupBox1.Left := dx Div 2;
  dx  := Cancel.Left - Okay.Left;  // Verschiebung der zwei Knöpfe
  dx1 := (ClientWidth - (dx + Cancel.Width)) Div 2;
  dx2 := dx1 + dx;
  Cancel.Left := dx2;
  Okay.Left   := dx1;
  EditTerm.Width :=  ClientWidth - EditTerm.Left - 20;
  EditTerm.Height := GroupBox1.Top - EditTerm.Top - 20;
  end;

procedure TTermEditDlg.SE_DecimalsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  { Bei fokussiertem SpinEdit-Feld die Tastendrücke
    "Enter" und "Esc" ans Formular durchreichen !   }
  begin
  if Key = vk_Return then
    OkayClick(Sender)
  else if Key = vk_Escape then
    CancelClick(Sender);
  end;

end.
