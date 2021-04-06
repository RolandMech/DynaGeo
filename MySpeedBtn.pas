unit MySpeedBtn;

interface

Uses windows, classes, buttons;

type
     TSpBtnData     = class(TObject)
                        SpBtn    : TSpeedButton;
                        CmdId,
                        HelpId,
                        ToolPage : Integer;
                        constructor Create(iCmdId, iHelpId, iPage: Integer);
                      end;

     TSpBtnDataList = class(TList)
                        function GetSpeedBtnFromCommand(cmd : Integer): TSpeedButton;
                        function GetHelpIdFromCommand  (cmd : Integer): Integer;
                        function GetToolPageFromCommand(cmd : Integer): Integer;
                      end;

implementation

constructor TSpBtnData.Create(iCmdId,
                              iHelpId,
                              iPage: Integer);
  begin
  Inherited Create;
  CmdId    := iCmdId;
  HelpId   := iHelpId;
  ToolPage := iPage;
  end;

{ TSpBtnDataList }

function TSpBtnDataList.GetHelpIdFromCommand(cmd: Integer): Integer;
  var i : Integer;
  begin
  Result := -1;
  i := 0;
  While (Result < 0) and (i < Count) do
    If TSpBtnData(Items[i]).CmdId = cmd then
      Result := TSpBtnData(Items[i]).HelpId
    else
      Inc(i);
  end;

function TSpBtnDataList.GetSpeedBtnFromCommand(cmd: Integer): TSpeedButton;
  var i : Integer;
  begin
  Result := Nil;
  While (Result = Nil) and (i < Count) do
    If TSpBtnData(Items[i]).CmdId = cmd then
      Result := TSpBtnData(Items[i]).SpBtn
    else
      Inc(i);
  end;

function TSpBtnDataList.GetToolPageFromCommand(cmd: Integer): Integer;
  var i : Integer;
  begin
  Result := -1;
  While (Result < 0) and (i < Count) do
    If TSpBtnData(Items[i]).CmdId = cmd then
      Result := TSpBtnData(Items[i]).ToolPage
    else
      Inc(i);
  end;

end.
