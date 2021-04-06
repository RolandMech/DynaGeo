unit EditMappingWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  TermForm, FormatEdit, TBaum, GeoTransf;

type
  TEditMappingDlg = class(TTermForm)
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    FormatEdit1: TFormatEdit;
    FormatEdit3: TFormatEdit;
    FormatEdit4: TFormatEdit;
    FormatEdit2: TFormatEdit;
    Label8: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    FormatEdit5: TFormatEdit;
    FormatEdit6: TFormatEdit;
    Label10: TLabel;
    Label7: TLabel;
    InfoLbl: TLabel;
    Okay_Btn: TButton;
    Cancel_Btn: TButton;
    Bevel1: TBevel;
    procedure MyEditEnter(Sender: TObject);
    procedure MyEditExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Cancel_BtnClick(Sender: TObject);
    procedure Okay_BtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    ActEdit : TFormatEdit;
    CanEdit : Boolean;
    function AllTermsAreValid: Boolean;
  public
    ActMapping : TGMatrixMap;
    constructor CreateWMap(iParent: TComponent; iActMapping: TGMatrixMap);
    procedure AddObj2Term(GO: TObject); override;
  end;

Implementation

{$R *.dfm}

Uses Declar, GlobVars, Utility, GeoTypes, MainWin;


constructor TEditMappingDlg.CreateWMap(iParent: TComponent; iActMapping: TGMatrixMap);
  begin
  Inherited Create(iParent);
  ActMapping := iActMapping;
  CanEdit    := ActMapping.MapType = mapAffineMapMat;
  end;

{ ====== Hilfs-Funktionen ================== }

procedure TEditMappingDlg.AddObj2Term(GO: TObject);
  var cur_pos : TPoint;
      oL, nL  : Integer;
  begin
  If CanEdit then begin
    cur_pos := ActEdit.ActCursorPos;
    oL := Length(ActEdit.PlainText[0]);
    TGeoObj(GO).InsertMeasureInto(ActEdit);
    (GO as TGeoObj).IsBlinking := False;
    nL := Length(ActEdit.PlainText[0]);
    cur_pos.X := cur_pos.X + nL - oL;
    ActEdit.ActCursorPos := cur_pos;
    end;
  InsertTempParams;
  end;


function TEditMappingDlg.AllTermsAreValid: Boolean;
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
  end;
  end;


{ ===== Ereignisse =============== }

procedure TEditMappingDlg.FormShow(Sender: TObject);
  begin
  FormatEdit1.HTMLTextAsString := ActMapping.GetMatrixStr(0, 0);
  FormatEdit2.HTMLTextAsString := ActMapping.GetMatrixStr(0, 1);
  FormatEdit3.HTMLTextAsString := ActMapping.GetMatrixStr(1, 0);
  FormatEdit4.HTMLTextAsString := ActMapping.GetMatrixStr(1, 1);
  FormatEdit5.HTMLTextAsString := ActMapping.GetMatrixStr(2, 0);
  FormatEdit6.HTMLTextAsString := ActMapping.GetMatrixStr(2, 1);
  FormatEdit1.EditEnabled := CanEdit;
  FormatEdit2.EditEnabled := CanEdit;
  FormatEdit3.EditEnabled := CanEdit;
  FormatEdit4.EditEnabled := CanEdit;
  FormatEdit5.EditEnabled := CanEdit;
  FormatEdit6.EditEnabled := CanEdit;
  If CanEdit then begin
    Caption         := MyMess[136];
    InfoLbl.Caption := MyMess[137];
    FormatEdit1.SetFocus;
    ActEdit := FormatEdit1;
    InsertTempParams;
    end
  else begin
    Caption         := MyMess[134];
    InfoLbl.Caption := MyMess[135];
    Cancel_Btn.Visible := False;
    Okay_Btn.Left := (Width - Okay_Btn.Width) Div 2;
    ActEdit := Nil;
    Okay_Btn.SetFocus;
    end;
  end;


procedure TEditMappingDlg.MyEditEnter(Sender: TObject);
  begin
  If Sender is TFormatEdit then begin
    ActEdit := Sender as TFormatEdit;
    With Sender as TFormatEdit do begin
      SelectActualLine;
      ActCursorPos := Point(LineLength(0), 0);
      end;
    end;
  end;


procedure TEditMappingDlg.MyEditExit(Sender: TObject);
  begin
  If Sender is TFormatEdit then begin
    (Sender as TFormatEdit).RevokeActSelection;
    Okay_Btn.Enabled := AllTermsAreValid;
    end;
  end;

procedure TEditMappingDlg.Cancel_BtnClick(Sender: TObject);
  begin
  SendMessage(HauptFenster.Handle, cmd_ExternCommand, cmd_EditMap, LongInt(0));
  Close;
  end;

procedure TEditMappingDlg.Okay_BtnClick(Sender: TObject);
  var i : Integer;
  begin
  If CanEdit then begin
    if AllTermsAreValid then with HauptFenster do begin
      LastValueWStr[0] := HTMLString2WideString(FormatEdit1.GetHTMLTextLine(0));
      LastValueWStr[1] := HTMLString2WideString(FormatEdit2.GetHTMLTextLine(0));
      LastValueWStr[2] := HTMLString2WideString(FormatEdit3.GetHTMLTextLine(0));
      LastValueWStr[3] := HTMLString2WideString(FormatEdit4.GetHTMLTextLine(0));
      LastValueWStr[4] := HTMLString2WideString(FormatEdit5.GetHTMLTextLine(0));
      LastValueWStr[5] := HTMLString2WideString(FormatEdit6.GetHTMLTextLine(0));
      end;
    SendMessage(HauptFenster.Handle, cmd_ExternCommand, cmd_EditMap, LongInt(1));
    end
  else begin
    For i := 0 to 5 do
      HauptFenster.LastValueWStr[i] := '';
    SendMessage(HauptFenster.Handle, cmd_ExternCommand, cmd_EditMap, LongInt(0));
    end;
  Close;
  end;

procedure TEditMappingDlg.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
  Action := caFree;
  end;

end.
