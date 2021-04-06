unit TermEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  TermForm, Spin, FormatEdit;

type
  TTermEditDlg = class(TTermForm)
    Okay: TButton;
    Cancel: TButton;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    EditComment: TEdit;
    Label3: TLabel;
    CB_ShowName: TCheckBox;
    CB_ShowComment: TCheckBox;
    SE_Decimals: TSpinEdit;
    Label1: TLabel;
    CB_ShowTerm: TCheckBox;
    EditTerm: TFormatEdit;
    procedure OkayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure CB_ShowCommentClick(Sender: TObject);
    procedure CB_ShowTermClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure AddObj2Term(GO: TObject); override;
  end;


implementation

{$R *.DFM}

uses Declar, GlobVars, Utility, TBaum, GeoTypes;

procedure TTermEditDlg.FormShow(Sender: TObject);
  var s : String;
  begin
  SetBounds(FPos.X, FPos.Y, Width, Height);
  If EditedObj <> Nil then
    With TGTermObj(EditedObj) do begin
      s := GetTermString;  
      CB_ShowTerm.Checked    := ShowTerm; { früher: TOStatus and tos_NoTermDisp = 0; }
      CB_ShowName.Checked    := ShowName;
      CB_ShowComment.Checked := Length(Comment) > 0;
      SE_Decimals.Value      := DeciDigits;
      EditComment.Text       := Comment;
      CB_ShowName.Enabled    := CB_ShowTerm.Checked;
      CB_ShowComment.Enabled := CB_ShowTerm.Checked;
      EditComment.Enabled    := CB_ShowTerm.Checked and CB_ShowComment.Checked;
      end
  else begin
    s := '';
    CB_ShowTerm.Checked    := True;
    CB_ShowName.Checked    := True;
    CB_ShowComment.Checked := False;
    SE_Decimals.Value      := TermDigits;
    EditComment.Text       := '';
    CB_ShowName.Enabled    := CB_ShowTerm.Checked;
    CB_ShowComment.Enabled := CB_ShowTerm.Checked;
    EditComment.Enabled    := CB_ShowTerm.Checked and CB_ShowComment.Checked;
    end;
  With EditTerm do begin
    Clear;
    DefaultFont := EditedObj.ObjList.StartFont;
    HTMLTextAsString := maskDelimiters(s);
    SelectActualLine;
    SetFocus;
    end;
  end;

procedure TTermEditDlg.CB_ShowCommentClick(Sender: TObject);
  begin
  EditComment.Enabled := CB_ShowComment.Checked;
  If EditComment.Enabled then
    EditComment.SetFocus;
  end;

procedure TTermEditDlg.CB_ShowTermClick(Sender: TObject);
  begin
  CB_ShowName.Enabled    := CB_ShowTerm.Checked;
  CB_ShowComment.Enabled := CB_ShowTerm.Checked;
  EditComment.Enabled    := CB_ShowTerm.Checked and CB_ShowComment.Checked;
  end;

procedure TTermEditDlg.AddObj2Term(GO: TObject);
  begin
  TGeoObj(GO).InsertMeasureInto(EditTerm);
  end;

procedure TTermEditDlg.OkayClick(Sender: TObject);
  begin
  If ValidTermIn(EditTerm, ObjList) then begin
    With TGTermObj(EditedObj) do begin
      SetNewTerm(EditTerm.GetPlainASCIITextLine(0));
      ShowName   := CB_ShowName.Checked;
      DeciDigits := SE_Decimals.Value;
      ShowTerm   := CB_ShowTerm.Checked;
      If CB_ShowComment.Checked then
        Comment := EditComment.Text
      else
        Comment := '';
      ReDimData;
      end;
    ObjList.SortObjects;
    ModalResult := mrOk;
    end
  else
    MessageBeep(mb_IconHand);
  end;

procedure TTermEditDlg.FormHide(Sender: TObject);
  begin
  If EditedObj <> Nil then
    ObjList.UpdateAllDescendentsOf(EditedObj);
  end;

end.
