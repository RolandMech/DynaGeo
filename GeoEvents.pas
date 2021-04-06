unit GeoEvents;

interface

uses Windows, Messages, Classes, Controls, ExtCtrls, Declar, GeoTypes;

type TGeoTimer = class(TTimer)
        private
          FStatus,
          FGroupNr,
          gnCount   : Integer;
          WinHandle : THandle;
          GeoListe  : TGeoObjListe;
          ActNumObj : TGNumberObj;
        public
          constructor GeoCreate(iOwner: TComponent; iHandle: THandle; iDrawing: TGeoObjListe);
          procedure InitLoading;
          procedure InitBaseObjBlinking(iGeoListe: TGeoObjListe);
          procedure InitObjBlinking(iGeoListe: TGeoObjListe);
          procedure InitNumberAdjust(iActNum: TGNumberObj);
          procedure InitShowCRMsg(iGeoListe: TGeoObjListe);
          procedure InitShowGroupName(iGroupNr: Integer);
          procedure TimerEventProc(Sender: TObject);
          procedure Reset(iGeoListe: TGeoObjListe);
          property  Status: Integer read FStatus;
        end;

implementation


constructor TGeoTimer.GeoCreate(iOwner: TComponent; iHandle: THandle; iDrawing: TGeoObjListe);
  begin
  Create(iOwner);
  GeoListe  := iDrawing;
  WinHandle := iHandle;
  FStatus   := 0;
  Enabled   := False;
  OnTimer   := TimerEventProc;
  end;

procedure TGeoTimer.InitLoading;
  begin
  If Status <> cmd_Load then begin
    FStatus  := cmd_Load;
    Interval := 250;
    Enabled  := True;
    end;
  end;

procedure TGeoTimer.InitObjBlinking(iGeoListe: TGeoObjListe);
  begin
  If FStatus <> cmd_EnableBlink then begin
    Reset(iGeoListe);
    FStatus  := cmd_EnableBlink;
    Interval := 333;
    Enabled  := True;
    end;
  end;

procedure TGeoTimer.InitBaseObjBlinking(iGeoListe: TGeoObjListe);
  begin
  If FStatus <> cmd_BlinkBaseObj then begin
    Reset(iGeoListe);
    FStatus  := cmd_BlinkBaseObj;
    Interval := 333;
    Enabled  := True;
    GeoListe.StartBaseObjBlinking(True);
    end;
  end;

procedure TGeoTimer.InitNumberAdjust(iActNum: TGNumberObj);
  begin
  If FStatus <> cmd_AdjNumObj then begin
    Reset(GeoListe);
    ActNumObj := iActNum;
    FStatus   := cmd_AdjNumObj;
    Interval  := 500;
    Enabled   := True;
    ActNumObj.AdjustValue;
    end;
  end;

procedure TGeoTimer.InitShowCRMsg(iGeoListe: TGeoObjListe);
  begin
  If FStatus <> cmd_InitCRMsg then begin
    Reset(iGeoListe);
    FStatus  := cmd_InitCRMsg;
    GeoListe.ShowingCRText := True;
    Interval := 2500;
    Enabled  := True;
    end;
  end;

procedure TGeoTimer.InitShowGroupName(iGroupNr: Integer);
  begin
  If (FStatus = 0) or (FStatus = cmd_GroupShowName) then begin
    If iGroupNr <> FGroupNr then begin
      SendMessage(Winhandle, cmd_ExternCommand, cmd_GroupHideName, FGroupNr);
      FGroupNr := iGroupNr;
      end;
    FStatus  := cmd_GroupShowName;
    Interval := 1000;
    Enabled  := True;
    gnCount  := 0;
    end;
  end;

procedure TGeoTimer.TimerEventProc(Sender: TObject);
  begin
  Case FStatus of
    cmd_Load         : begin
                       PostMessage(WinHandle, cmd_TryLoading, 0, 0);
                       Reset(GeoListe);
                       end;
    cmd_EnableBlink,
    cmd_BlinkBaseObj : If GeoListe <> Nil then
                         GeoListe.ToggleBlinkingObjs;
    cmd_AdjNumObj    : If ActNumObj.AdjustValue then begin
                         GeoListe.Repaint;
                         If Interval > 50 then
                           Interval := Interval * 3 Div 4;
                         end
                       else Reset(GeoListe);
    cmd_InitCRMsg    : begin
                       GeoListe.ShowingCRText := False;
                       GeoListe.DrawFirstObjects(GeoListe.LastValidObjIndex, True);
                       Reset(GeoListe);
                       end;
    cmd_GroupShowName: If gnCount < 10 then begin
                         SendMessage(Winhandle, cmd_ExternCommand, cmd_GroupShowName, FGroupNr);
                         gnCount := gnCount + 1;
                         end
                       else begin
                         SendMessage(Winhandle, cmd_ExternCommand, cmd_GroupHideName, FGroupNr);
                         FStatus := 0;
                         end;
    cmd_GroupHideName: begin
                       SendMessage(Winhandle, cmd_ExternCommand, cmd_GroupHideName, FGroupNr);
                       Reset(GeoListe);
                       end;
  end; { of case }
  end;

procedure TGeoTimer.Reset(iGeoListe: TGeoObjListe);
  var os : Integer;
  begin
  If GeoListe <> iGeoListe then
    GeoListe := iGeoListe;
  If FStatus <> 0 then begin
    os       := FStatus;
    FStatus  := 0;
    Enabled  := False;
    If GeoListe <> Nil then
      GeoListe.EndBlinkingMode;
    If os = cmd_GroupShowName then
      SendMessage(Winhandle, cmd_ExternCommand, cmd_GroupHideName, -1);
    end; { of if }
  end;

end.
