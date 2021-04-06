unit AssAffAbb_2e;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, FormatEdit, AssAffAbb_2,
  TBaum;

type
  TAffAbb_2e_Dlg = class(TAffAbb_2_Dlg)
    Label1: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    FormatEdit2: TFormatEdit;
    FormatEdit3: TFormatEdit;
    FormatEdit4: TFormatEdit;
    FormatEdit1: TFormatEdit;
    FormatEdit5: TFormatEdit;
    FormatEdit6: TFormatEdit;
    Label8: TLabel;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure MyEditEnter(Sender: TObject);
    procedure MyEditExit(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    ActEdit : TFormatEdit;
    function AllTermsAreValid: Boolean;
  public
    { Public-Deklarationen }
    procedure AddObj2Term(GO: TObject); override;
  end;


implementation

{$R *.dfm}

Uses Declar, GlobVars, Utility, GeoTypes, MainWin;

procedure TAffAbb_2e_Dlg.FormShow(Sender: TObject);
  var SL : TStringList;
  begin
  SetLinksToMainWindow;
  InsertTempParams;
  OKBtn.Enabled := True;
  SL := TStringList.Create;
  try
    SL.Add('1');
    FormatEdit1.Text := SL;
    FormatEdit4.Text := SL;
    SL[0] := '0';
    FormatEdit2.Text := SL;
    FormatEdit3.Text := SL;
    FormatEdit5.Text := SL;
    FormatEdit6.Text := SL;
    MyEditEnter(FormatEdit1);
  finally
    SL.Free;
  end;
  end;

procedure TAffAbb_2e_Dlg.AddObj2Term(GO: TObject);
  var cur_pos : TPoint;
      oL, nL  : Integer;
  begin
  cur_pos := ActEdit.ActCursorPos;
  oL := Length(ActEdit.PlainText[0]);
  TGeoObj(GO).InsertMeasureInto(ActEdit);
  (GO as TGeoObj).IsBlinking := False;
  nL := Length(ActEdit.PlainText[0]);
  cur_pos.X := cur_pos.X + nL - oL;
  ActEdit.ActCursorPos := cur_pos;
  InsertTempParams;
  end;

procedure TAffAbb_2e_Dlg.MyEditEnter(Sender: TObject);
  begin
  If Sender is TFormatEdit then begin
    ActEdit := Sender as TFormatEdit;
    With Sender as TFormatEdit do begin
      SelectActualLine;
      ActCursorPos := Point(LineLength(0), 0);
      end;
    end;
  end;

procedure TAffAbb_2e_Dlg.MyEditExit(Sender: TObject);
  begin
  If Sender is TFormatEdit then begin
    (Sender as TFormatEdit).RevokeActSelection;
    OkBtn.Enabled := AllTermsAreValid;
    end;
  end;

function TAffAbb_2e_Dlg.AllTermsAreValid: Boolean;
  var tb   : TTBaum;
      s    : WideString;
      ok   : Boolean;
      e, i : Integer;
  begin
  tb := TTBaum.Create(Hauptfenster.Drawing, Rad);
  Result := True;
  try
    i := 0;
    While Result and (i < ComponentCount) do begin
      If Components[i] is TFormatEdit then begin
        s := HTMLString2WideString((Components[i] as TFormatEdit).GetHTMLTextLine(0));
        If Length(s) > 0 then begin
          tb.BuildTree(s);
          ok := tb.is_okay;
          e := tb.error_spot;
          end
        else begin
          ok := False;
          e  := 0;
          end;
        If Not ok then begin
          Result := False;
          MyEditEnter(Components[i]);
          (Components[i] as TFormatEdit).ActCursorPos := Point(e, 0);
          MessageDlg(MyMess[109], mtWarning, [mbOk], 0);
          end;
        end;
      i := i + 1;
      end;
  finally
    tb.Free;
    OKBtn.Enabled := Result;
  end;
  end;

procedure TAffAbb_2e_Dlg.CancelBtnClick(Sender: TObject);
  begin
  Close;
  HauptFenster.Reset2DragMode;
  end;

procedure TAffAbb_2e_Dlg.OKBtnClick(Sender: TObject);
  begin
  If AllTermsAreValid then begin
    Close;
    with HauptFenster do begin
      LastValueWStr[0] := HTMLString2WideString(FormatEdit1.GetHTMLTextLine(0));
      LastValueWStr[1] := HTMLString2WideString(FormatEdit2.GetHTMLTextLine(0));
      LastValueWStr[2] := HTMLString2WideString(FormatEdit3.GetHTMLTextLine(0));
      LastValueWStr[3] := HTMLString2WideString(FormatEdit4.GetHTMLTextLine(0));
      LastValueWStr[4] := HTMLString2WideString(FormatEdit5.GetHTMLTextLine(0));
      LastValueWStr[5] := HTMLString2WideString(FormatEdit6.GetHTMLTextLine(0));
      PostMessage(Handle, cmd_ExternCommand, cmd_DefineAffin, LongInt(0));
      end;
    end;
  end;

end.
