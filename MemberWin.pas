unit MemberWin;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Dialogs,
  Declar, GlobVars, Utility, GeoTypes, GeoGroup;

type
  TAddMemberWin = class(TForm)
    BtnOkay: TButton;
    BtnCancel: TButton;
    StaticText1: TStaticText;
    BtnSelectAll: TButton;
    BtnUnselectAll: TButton;
    Bevel1: TBevel;
    procedure BtnOkayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnSelectAllClick(Sender: TObject);
    procedure BtnUnselectAllClick(Sender: TObject);
  private
    FParentWinHandle : HWnd;
    FDrawing : TGeoObjListe;
    FGroup   : TGeoGroup;
    function SelectedObjCount: Integer;
  public
    procedure InitData(iHandle: HWnd; iDrawing: TGeoObjListe; iGroup: TGeoGroup);
  end;


implementation

{$R *.DFM}

procedure TAddMemberWin.InitData(iHandle: HWnd; iDrawing: TGeoObjListe; iGroup: TGeoGroup);
  begin
  FParentWinHandle := iHandle;
  FDrawing  := iDrawing;
  FGroup    := iGroup;
  end;

procedure TAddMemberWin.FormShow(Sender: TObject);
  begin
  FGroup.ShowMembers;
  end;

function TAddMemberWin.SelectedObjCount: Integer;
  var n, i : Integer;
  begin
  n := 0;
  For i := 0 to FDrawing.LastValidObjIndex do
    If TGeoObj(Fdrawing[i]).IsGrouped then
      n := n + 1;
  Result := n;    
  end;

procedure TAddMemberWin.BtnOkayClick(Sender: TObject);
  var n : Integer;
  begin
  n := FDrawing.GroupList.IndexOf(FGroup);
  If SelectedObjCount > 0 then begin
    Close;
    If n < 0 then
      FDrawing.GroupList.Add(FGroup);
    FGroup.RegisterAllGroupMembers;
    FDrawing.EraseGroupMarks;
    FDrawing.HideHiddenObjects;
    FDrawing.Repaint;
    SendMessage(FParentWinHandle, cmd_ExternCommand, cmd_Group, mrOk);
    end
  else  // Keine Objekte in der Gruppe
    If MessageDlg(Format(MyMess[64], [FGroup.comment]),
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      Close;
      If n >= 0 then
        FDrawing.GroupList.Delete(n);
      FGroup := Nil;
      FDrawing.EraseGroupMarks;
      FDrawing.HideHiddenObjects;
      FDrawing.Repaint;
      SendMessage(FParentWinHandle, cmd_ExternCommand, cmd_Group, mrCancel);
      end;
  end;

procedure TAddMemberWin.BtnCancelClick(Sender: TObject);
  var n : Integer;
  begin
  Close;
  n := FDrawing.GroupList.IndexOf(FGroup);
  If n < 0 then
    FGroup.Free;
  FGroup := Nil;
  FDrawing.EraseGroupMarks;
  FDrawing.HideHiddenObjects;
  FDrawing.Repaint;
  SendMessage(FParentWinHandle, cmd_ExternCommand, cmd_Group, mrCancel);
  end;

procedure TAddMemberWin.BtnSelectAllClick(Sender: TObject);
  begin
  FGroup.MarkAllObjects;
  end;

procedure TAddMemberWin.BtnUnselectAllClick(Sender: TObject);
  begin
  FGroup.RevokeAllMarks;
  end;

end.
