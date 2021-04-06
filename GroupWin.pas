unit GroupWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, FormatEdit, ExtCtrls, StdCtrls,
  Declar, GlobVars, Utility, TBaum, GeoTypes, TermForm,
  GeoGroup;

type
  TEditGroupWin = class(TTermForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    GroupBox3: TGroupBox;
    RB_static: TRadioButton;
    RG_visible: TRadioGroup;
    RB_dynamic: TRadioButton;
    FormatEdit1: TFormatEdit;
    BtnAddObjs: TButton;
    BtnCancel: TButton;
    BtnClose: TButton;
    procedure BtnAddObjsClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure FormatEdit1Enter(Sender: TObject);
    procedure FormatEdit1Exit(Sender: TObject);
    procedure VisTypeClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FParentWinHandle : HWnd;
    FDrawing  : TGeoObjListe;
    FActGroup : TGeoGroup;
    function GetDataFromForm: Boolean;
  public
    { Public-Deklarationen }
    procedure InitWith(iHandle: HWnd; iDrawing: TGeoObjListe; iGroup: TGeoGroup);
    procedure AddObj2Term(GO: TObject); override;
    property ActGroup : TGeoGroup read FActGroup;
  end;

implementation

{$R *.dfm}

uses MainWin, MemberWin;

procedure TEditGroupWin.InitWith(iHandle: HWnd; iDrawing: TGeoObjListe; iGroup: TGeoGroup);
  begin
  FParentWinHandle := iHandle;
  FDrawing  := iDrawing;
  FActGroup := iGroup;
  If FActGroup.MemberCount > 0 then begin
    Caption := Format(MyMess[73], [FActGroup.comment]);
    Edit1.Text := FActGroup.comment;
    end
  else begin
    Caption := MyMess[74];
    Edit1.Text := '';
    end;
  SetLinksToMainWindow;
  end;

procedure TEditGroupWin.FormShow(Sender: TObject);
  var SL : TStringList;
  begin
  With FActGroup do begin
    BtnClose.Enabled := MemberCount > 0;
    RB_static.Checked := FActGroup.IsStatic;
    RB_dynamic.Checked := Not FActGroup.IsStatic;
    FormatEdit1.Clear;
    If FActGroup.IsStatic then begin
      RG_visible.Enabled := True;
      If FActGroup.IsVisible then
        RG_visible.ItemIndex := 0
      else
        RG_visible.ItemIndex := 1;
      end
    else begin
      RG_visible.Enabled := False;
      If Length(condition) > 0 then begin
        SL := TStringList.Create;
        try
          SL.Add(maskDelimiters(condition));   // Maskierung wegen "<"-Zeichen !
          FormatEdit1.Text := SL;
        finally
          SL.Free;
        end;
        end;
      end;
    end;
  If Length(Edit1.Text) = 0 then
    Edit1.SetFocus;
  end;

function TEditGroupWin.GetDataFromForm: Boolean;
  var BB : TBoolBaum;
      s  : String;
  begin
  Result := False;
  If Length(Edit1.Text) = 0 then
    ShowMessage(MyMess[65])
  else begin
    FActGroup.comment := Edit1.Text;
    FActGroup.IsStatic := RB_static.Checked;
    FActGroup.IsVisible := RG_visible.ItemIndex = 0;
    If (Not FActGroup.IsStatic) and
       (FormatEdit1.LineCount > 0) then begin
      s := FormatEdit1.PlainText[0];
      BB := TBoolBaum.Create(FDrawing, Rad, s);
      If BB.IsOkay then begin
        BB.Free;
        FActGroup.condition := FormatEdit1.PlainText[0];
        Result := True;
        end
      else begin
        BB.Free;
        ShowMessage(MyMess[59]);
        end;
      end
    else
      Result := True;
    end;
  end;

procedure TEditGroupWin.BtnAddObjsClick(Sender: TObject);
  { Reicht die aktuell editierte Gruppe an das AddMemberWin-Fenster weiter. }
  begin
  If GetDataFromForm then begin
    Close;
    THauptfenster(Owner).AddMemberWin.InitData(FParentWinHandle, FDrawing, FActGroup);
    FActGroup := Nil;
    SendMessage(FParentWinHandle, cmd_CloseEdGroup, mrYes, 0);
    end;
  end;

procedure TEditGroupWin.BtnCloseClick(Sender: TObject);
  begin
  If GetDataFromForm then begin
    FDrawing.EraseGroupMarks;
    FDrawing.HideHiddenObjects;
    FDrawing.UpdateGroupVisibility;
    FDrawing.IsDirty := True;
    Close;
    SendMessage(FParentWinHandle, cmd_CloseEdGroup, mrOk, 0);
    end;
  end;

procedure TEditGroupWin.BtnCancelClick(Sender: TObject);
  begin
  Close;
  If FDrawing.GroupList.IndexOf(ActGroup) < 0 then
    ActGroup.Free;   // Temporäre Gruppe wieder freigeben !
  FActGroup := Nil;
  FDrawing.EraseGroupMarks;
  SendMessage(FParentWinHandle, cmd_CloseEdGroup, mrCancel, 0);
  end;

procedure TEditGroupWin.FormatEdit1Enter(Sender: TObject);
  begin
  InsertTempParams;
  end;

procedure TEditGroupWin.FormatEdit1Exit(Sender: TObject);
  begin
  RestoreOldParams(0, 80);
  end;

procedure TEditGroupWin.AddObj2Term(GO: TObject);
  var cur_pos : TPoint;
      oL, nL  : Integer;
  begin
  cur_pos := FormatEdit1.ActCursorPos;
  oL := Length(FormatEdit1.PlainText[0]);
  TGeoObj(GO).InsertMeasureInto(FormatEdit1);
  nL := Length(FormatEdit1.PlainText[0]);
  cur_pos.X := cur_pos.X + nL - oL;
  FormatEdit1.ActCursorPos := cur_pos;
  InsertTempParams;
  end;

procedure TEditGroupWin.VisTypeClick(Sender: TObject);
  begin
  RG_visible.Enabled  := RB_static.Checked;
  FormatEdit1.Enabled := RB_dynamic.Checked;
  end;

end.
