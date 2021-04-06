unit debuglog;

{ Excerpts from the sources of the "HTML Help helper functions"
  (Version 1.6 25/9/2001) of "The Helpware Group"

  Delphi 6 failed to transport help commands properly to the "new" Windows
  HTML help viewer. The original code of this unit fixed this problem with
  a patch. This is now obsolet with Delphi 2010 where the help interface
  has been redesigned completely.

  So only the portions of the original code concerning the "Debug file"
  are kept alive here. This text file can collect short messages from the
  surrounding program about its state and the errors detected. The file is
  created when the program is started with "_DebugMode" = TRUE.

  DynaGeo switches to the debug mode by a "/debug" command line parameter
  (or when a file named "debug.debug" is in the same folder as the EXE file
  of the program). The position of the debug text file is in the "User's
  temp folder".

  2011-04-18: Updatet to WideString/WideChar version.
  2012-04-01: Changed the position of the debug text file from the
              "DynaGeo application data folder" to the "User Temp Folder"

}

interface

uses Windows, SysUtils, Classes, Forms, Dialogs, ShellApi, Registry;

procedure DebugOut(msgStr: WideString; const Args: array of const);


implementation

uses GlobVars, Utility;       // DynaGeo tools

const _DebugMode: Boolean     = FALSE; { Set TRUE to enable debug file output. }
      _UnicodeSystem: Boolean = TRUE;

      WC_DosDel: WideChar = '\';

      PathDelimW: WideString = '\';
      DriveDelimW: WideString = ':';

      DBG_FILENAME: WideString = '\debug.txt';
      LOG_FILENAME: WideString = '\inst_log.txt';
      DBG_DIR     : WideString = '';

{ See Module initialization }
var
  { IE version info }
  _ieInstalled: Boolean = FALSE;          //Internet Explorer is installed
  _ieVerStr: WideString = '';             //eg. '5.00.0910.1309'

  { General }
  _RunDir: WideString = '';               //applications run directory. Or Host EXE directory if part of DLL.
  _ModulePath: WideString;                //If part of DLL this is the full path to the DLL
  _ModuleDir: WideString;                 //If part of DLL this is the DLL Dir and different from _RunDir
  _ModuleName: WideString;                //If part of DLL this is the DLL name otherwise it is host exe name



{---------------------------------------------------------------------]
   String Functions
[---------------------------------------------------------------------}

{Strip leading chars}
procedure StripL(var s: WideString; c: WideChar);
begin
  while (s <> '') and (s[1] = c) do
    Delete(s, 1, 1);
end;

{Strip trailing chars}
procedure StripR(var s: WideString; c: WideChar);
begin
  repeat
    if (s <> '') and (s[length(s)] = c) then
      SetLength(s, Length(s)-1)
    else
      break;
  until false;
end;

{Strip leading and trailing chars}
procedure StripLR(var s: WideString; c: Widechar);
begin
  StripL(s, c);
  StripR(s, c);
end;

{Strip trailing string}
procedure StripStrR(var s: WideString; find: WideString);
var tmp: WideString;
begin
  if length(s) >= length(find) then
  begin
    tmp := copy(s, length(s) - length(find) + 1, length(find));
    if WideCompareText(tmp, find) = 0 then
      Setlength(s, length(s) - length(find));
  end;
end;

{Make string of chars}
function MkStr(c: WideChar; count: Integer): WideString;
var i: Integer;
begin
  result := '';
  for i := 1 to count do
    result := result + c;
end;


{ Boolean to Yes / No }
function BoolToYN(b: Boolean): WideString;
begin
  if b then result := 'YES' else result := 'NO';
end;


function ExpandEnvStr(const s: WideString): WideString;
var P: array[0..4096] of WideChar;
begin
  ExpandEnvironmentStringsW(PWideChar(s), P, SizeOf(P));
  Result := P;
end;

{
  Get a value from the registry
  dataName = '' for default value.
  Returns '' if not found
}
function GetRegStr(rootkey: HKEY; const key, dataName: String): String;
var rg: TRegistry;
begin
  result := '';  //default return
  rg := TRegistry.Create;
  rg.RootKey :=  rootkey;

  if (rg.OpenKeyReadOnly(key) AND rg.ValueExists(dataName)) then //safer call under NT - Delphi 4 and above
  begin
    result := rg.ReadString(dataName);
    rg.CloseKey;
  end;
  rg.Free;

  //Expand %systemroot%
  Result := ExpandEnvStr(Result);
end;



{---------------------------------------------------------------------]
   Wide versions of ParamCount and ParamStr
[---------------------------------------------------------------------}


function WideGetModuleFileName: WideString;
var ws: array[0..300] of WideChar;
begin
  GetModuleFileNameW(HInstance, ws, SizeOf(ws));
  result := ws;
end;


function GetParamStrW(P: PWideChar; var Param: WideString): PWideChar;
var  i, Len: Integer; Start, S, Q: PWideChar;
begin
  while True do
  begin
    while (P[0] <> #0) and (P[0] <= ' ') do
      Inc(P);
    if (P[0] = '"') and (P[1] = '"') then Inc(P, 2) else Break;
  end;
  Len := 0;
  Start := P;
  while P[0] > ' ' do
  begin
    if P[0] = '"' then
    begin
      Inc(P);
      while (P[0] <> #0) and (P[0] <> '"') do
      begin
        Q := P + 1;
        Inc(Len, Q - P);
        P := Q;
      end;
      if P[0] <> #0 then
        Inc(P);
    end
    else
    begin
      Q := P + 1;
      Inc(Len, Q - P);
      P := Q;
    end;
  end;

  SetLength(Param, Len);

  P := Start;
  S := PWideChar(Param);
  i := 0;
  while P[0] > ' ' do
  begin
    if P[0] = '"' then
    begin
      Inc(P);
      while (P[0] <> #0) and (P[0] <> '"') do
      begin
        Q := P + 1;
        while P < Q do
        begin
          S[i] := P^;
          Inc(P);
          Inc(i);
        end;
      end;
      if P[0] <> #0 then Inc(P);
    end
    else
    begin
      Q := P + 1;
      while P < Q do
      begin
        S[i] := P^;
        Inc(P);
        Inc(i);
      end;
    end;
  end;
  Result := P;
end;

function ParamCountW: Integer;
var  P: PWideChar; S: WideString;
begin
  P := GetParamStrW(GetCommandLineW, S);
  Result := 0;
  while True do
  begin
    P := GetParamStrW(P, S);
    if S = '' then Break;
    Inc(Result);
  end;
end;

function ParamStrW(Index: Integer): WideString;
var  P: PWideChar;
begin
  if Index = 0 then
    Result := WideGetModuleFileName
  else
  begin
    P := GetCommandLineW;
    while True do
    begin
      P := GetParamStrW(P, Result);
      if (Index = 0) or (Result = '') then Break;
      Dec(Index);
    end;
  end;
end;



{---------------------------------------------------------------------]
   Path and Drive Functions
[---------------------------------------------------------------------}

function DirectoryExists_(dir: WideString): Boolean;
var SearchRec: TWIN32FindDataW; h: THandle;
begin
  Result := false;
  StripR(dir, WC_DosDel);
  If dir <> '' then
  begin
    h := FindFirstFileW(PWideChar(dir), SearchRec);
    Result := h <> INVALID_HANDLE_VALUE;
    if Result then
    begin
      result := (SearchRec.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0);  //a directory
      Windows.FindClose(h);
    end;
  end;
end;

{ Return Windows System Dir}
function GetWinSysDirW: WideString;
var path: array[0..260] of WideChar;
begin
  GetSystemDirectoryW(path, SizeOf(path));
  result := path;
  StripR(result, WideChar('\'));  //no trailing slash
end;

{ Get Windows Temp Dir - with no trailing slash}
function GetWinTempDirW: WideString;
  var dwLen: DWORD;
  begin
  SetLength(result, 300);
  dwLen := GetTempPathW(300, @result[1]);
  SetLength(result, dwLen);
  StripR(result, WideChar('\'));  //no trailing slash

  //In case of problems:
  if DirectoryExists_(result) = FALSE then
    result := 'c:';
  end;


{
  Sometimes the only way we can test if a drive is writable
  is to write a test file.
  aDir is some Dir on a valid disk drive
}
function IsDirWritable(aDir: WideString): Boolean;
var fn: WideString; h: THandle;
begin
  StripR(aDir, WC_DosDel);  //no trailing slash
  fn := aDir + '\$_Temp_$.$$$';   //Any abnormal filename will do
  h := Windows.CreateFileW(PWideChar(fn), GENERIC_WRITE,
    FILE_SHARE_WRITE or FILE_SHARE_READ or FILE_SHARE_DELETE,
    nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  result := h <> INVALID_HANDLE_VALUE;
  if Result then
  begin
    Windows.CloseHandle(h);
    Windows.DeleteFileW(PWideChar(fn));
  end;
end;



{---------------------------------------------------------------------]
   File and File Version Functions
[---------------------------------------------------------------------}

function FileExists_(fName: WideString): Boolean;
var SearchRec: TWIN32FindDataW; h: THandle;
begin
  h := FindFirstFileW(PWideChar(fName), SearchRec);
  Result := h <> INVALID_HANDLE_VALUE;
  if Result then
  begin
    result := (SearchRec.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY = 0);  //not a Directory (only looking for files)
    Windows.FindClose(h);
  end;
end;

function LastDelimiter_(const Delimiters, S: WideString): Integer;
var p, i: Integer;
begin
  result := 0;
  for i := length(s) downto 1 do
    for p := 1 to length(Delimiters) do
      if s[i] = Delimiters[p] then
      begin
        result := i;
        exit;
      end;
end;


function ExtractFilePath_(const FileName: WideString): WideString;
var I: Integer;
begin
  I := LastDelimiter_(PathDelimW + DriveDelimW, FileName);
  Result := Copy(FileName, 1, I);
end;


function ExtractFileName_(const FileName: Widestring): WideString;
var I: Integer;
begin
  I := LastDelimiter_(PathDelimW + DriveDelimW, FileName);
  Result := Copy(FileName, I + 1, MaxInt);
end;


{
  Get the product version number from a file (exe, dll, ocx etc.)
  Return '' if info not available - eg. file not found
  eg. Returns '7.47.3456.0', aV1=7, aV2=47, aV3=3456 aV4=0
  ie. major.minor.release.build
}
function GetFileVer(aFilename: WideString; var aV1, aV2, aV3, aV4: word): WideString;
var  InfoSize: DWORD; Wnd: DWORD; VerBuf: Pointer; VerSize: DWORD; FI: PVSFixedFileInfo;
begin
  result := '';
  aV1 := 0;  aV2 := 0;  aV3 := 0;  aV4 := 0;

  if (aFilename = '') or (not FileExists_(aFilename)) then exit;  //don't continue if file not found

  InfoSize := GetFileVersionInfoSizeW(PWideChar(aFilename), Wnd);

    //Note: we strip out the resource info for our dll to keep it small
    //Result := SysErrorMessage(GetLastError);

  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfoW(PWideChar(aFilename), Wnd, InfoSize, VerBuf) then
      begin
        if VerQueryValueW(VerBuf, '\', Pointer(FI), VerSize) then
        begin
          aV1 := HiWord(FI^.dwFileVersionMS);
          aV2 := LoWord(FI^.dwFileVersionMS);
          aV3 := HiWord(FI^.dwFileVersionLS);
          aV4 := LoWord(FI^.dwFileVersionLS);
          result := IntToStr( HiWord(FI^.dwFileVersionMS) ) + '.' +
                    IntToStr( LoWord(FI^.dwFileVersionMS) ) + '.' +
                    IntToStr( HiWord(FI^.dwFileVersionLS) ) + '.' +
                    IntToStr( LoWord(FI^.dwFileVersionLS) );
        end
      end
    finally
      FreeMem(VerBuf);
    end;
  end;
end; //GetFileVer



{
  Version Compare : returns -1 if Va < Vb, 0 if Va = Vb, 1 if Va > Vb
  eg. VerCompar(1,0,0,1, 1,0,0,2) will return -1
  eg. VerCompar(2,0,0,1, 1,0,6,90) will return 1 because 2.0.0.1 is > 1.0.6.90
}
function VerCompare(va1, va2, va3, va4, vb1, vb2, vb3, vb4: Word): Integer;
begin
  if (va1 = vb1) AND (va2 = vb2) AND (va3 = vb3) AND (va4 = vb4) then
    result := 0
  else if (va1 > vb1)
  or ((va1 = vb1) AND (va2 > vb2))
  or ((va1 = vb1) AND (va2 = vb2) AND (va3 > vb3))
  or ((va1 = vb1) AND (va2 = vb2) AND (va3 = vb3) AND (va4 > vb4)) then
    result := 1
  else
    result := -1;
end;


function GetIExploreExePath: WideString;
  function FileExists_StripOuterStuff(var fn: WideString): Boolean;
  begin
    StripStrR(fn, '%1');
    StripLR(fn, ' ');
    StripLR(fn, ',');
    StripLR(fn, ' ');
    StripLR(fn, '"');
    result := FileExists_(fn);
  end;
var s: WideString;
begin
  result := '';
  //Try a few different registry location the tell us IExplore.exe's location

  s := ExpandEnvStr('%ProgramFiles%\Internet Explorer\IExplore.exe');   //normal location
  if FileExists_(s) then
    result := s;

  if result = '' then
  begin
    s := GetRegStr(HKEY_CLASSES_ROOT, 'Applications\iexplore.exe\shell\open\command', '');
                                              //"C:\Program Files\Internet Explorer\IEXPLORE.EXE" %1
    if FileExists_StripOuterStuff(s) then
      result := s;
  end;
  if result = '' then
  begin
    s := GetRegStr(HKEY_CLASSES_ROOT, 'CLSID\{0002DF01-0000-0000-C000-000000000046}\LocalServer32', '');
                                              //"C:\Program Files\Internet Explorer\IEXPLORE.EXE"
    if FileExists_StripOuterStuff(s) then
      result := s;
  end;
  if result = '' then
  begin
    s := GetRegStr(HKEY_CLASSES_ROOT, 'CLSID\{871C5380-42A0-1069-A2EA-08002B30309D}\shell\OpenHomePage\Command', '');
                                              //"C:\Program Files\Internet Explorer\IEXPLORE.EXE"
    if FileExists_StripOuterStuff(s) then
      result := s;
  end;
  if result = '' then
  begin
    s := GetRegStr(HKEY_CLASSES_ROOT, 'CLSID\{871C5380-42A0-1069-A2EA-08002B30309D}\shell\OpenHomePage\Command', '');
                                              //"C:\Program Files\Internet Explorer\IEXPLORE.EXE"
    if FileExists_StripOuterStuff(s) then
      result := s;
  end;
end;


function GetIEVer(var v1, v2, v3, v4: word): WideString;
begin
  result := GetFileVer(GetIExploreExePath, v1,v2,v3,v4);  //for v 7+ we need to get version from iExplore.exe
  if (result = '') or (v1 <= 6) then
    result := GetFileVer(GetWinSysDirW + WideString('\Shdocvw.dll'), v1, v2, v3, v4); //for v 6- we need to get version from shdocvw.dll

  //trick -- Early versions of IE had only 3 numbers
  if (v1=4) and (v2<=70) and (v3=0) then
  begin
    v3 := v4;  v4 := 0;
    result := WideFormat('%d.%d.%d.%d',[v1,v2,v3,v4]);
  end;
end;


procedure DebugOut(msgStr: WideString; const Args: array of const);
var f: TextFile; s: WideString;
begin
  if _DebugMode then
  begin
    {$I-}
    AssignFile(f, DBG_DIR + DBG_FILENAME);
    if (not FileExists(DBG_DIR + DBG_FILENAME)) then
      Rewrite(f)  //create
    else
      Append(f);
    if ioresult = 0 then
    begin
      s := format(msgStr, Args);
      if (Length(s) = 1) and (s[1] = '-') then   //separator
        s := MkStr('-', 80);
      if (Length(s) = 1) and (s[1] = '=') then   //separator
        s := MkStr('=', 80);
      if (s <> '') and CharInSet(s[1], ['-', '=', '!']) then
        s := Copy(S, 2, maxint)
      else
        s := TimeToStr(now) + '   ' + s;
      Writeln(f, s);
      Flush(f);
      CloseFile(f);
    end;
  end;
end; //DebugOut


{Delete and start a new debug file}
procedure ResetDebugFile;
var i: Integer; s: String;
begin
  if FileExists(DBG_DIR + DBG_FILENAME) then
    DeleteFile(DBG_DIR + DBG_FILENAME);
  if _DebugMode then
  begin
    DebugOut('!Filename:             %s',[#0009 + DBG_DIR + DBG_FILENAME]);
    DebugOut('!Date:                 %s',[#0009 + DateTimeToStr(now)]);
    if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT
    then DebugOut('!Operating System:      %s %d.%d.%d',[#0009'Windows NT',Win32MajorVersion, Win32MinorVersion, Win32BuildNumber])
    else DebugOut('!Operating System:      %s %d.%d.%d',[#0009'Windows',Win32MajorVersion, Win32MinorVersion, Win32BuildNumber]);

    DebugOut('!SysLocale.DefaultLCID: %s',[#0009+'0x'+IntToHex(SysLocale.DefaultLCID, 4)]);
    DebugOut('!SysLocale.PriLangID:   %s',[#0009+'0x'+IntToHex(SysLocale.PriLangID, 4)]);
    DebugOut('!SysLocale.SubLangID:   %s',[#0009+'0x'+IntToHex(SysLocale.SubLangID, 4)]);
    DebugOut('!FormatSettings.DecimalSeparator:      %s',[#0009+FormatSettings.DecimalSeparator]);

    DebugOut('-', ['']);
    DebugOut('!EXE Path =          %s',[#0009 + ParamStr(0)]);
    DebugOut('!EXE Version =       %s',[#0009 + FullVersionString(Application.ExeName)]);
    DebugOut('!OCX Path =          %s',[#0009 + DGXPathRegistered]);
    If Length(DGXPathRegistered) > 0 then
      DebugOut('!OCX Version =       %s',[#0009 + FullVersionString(DGXPathRegistered)]);
    s := '';
    for i := 1 to ParamCount do
    begin
      if s <> '' then s := s + ' | ';
      s := s + ParamStr(i)
    end;
    DebugOut('!Cmdline Param(s) =  %s',[#0009 + s]);
    DebugOut('!_RunDir =           %s',[#0009 + _RunDir]);
    DebugOut('!_ModuleName =       %s',[#0009 + _ModuleName]);
    DebugOut('!_ModuleDir =        %s',[#0009 + _ModuleDir]);
    DebugOut('!_DebugDir =         %s',[#0009 + DBG_DIR]);
    DebugOut('-', ['']);
    DebugOut('!_ieInstalled =      %s', [#0009 + BoolToYN(_ieInstalled)]);
    DebugOut('!_ieVerStr =         %s', [#0009 + _ieVerStr]);
    DebugOut('=', ['']);
  end;
end;


{ Module initialization }


function LocalTempPathFound(var s: WideString): Boolean;
  begin
  s := GetActUsersTempFolder;
  Result := (Length(s) > 0);
  end;

procedure ModuleInit;
var
  v1,v2,v3,v4, i: Word;
  s : WideString;
begin
  _UnicodeSystem := (Win32Platform = VER_PLATFORM_WIN32_NT);

  //Get run dir & Progname - or DLL or EXE
  _ModulePath := WideGetModuleFileName;
  _ModuleDir := ExtractFilePath_(_ModulePath);
  _ModuleName := ExtractFileName_(_ModulePath);
  StripR(_ModuleDir, '\');

  { get run dir }
  _RunDir := ExtractFilePath_(ParamStr(0));
  StripR(_RunDir, '\');

  If LocalTempPathFound(s) then
    DBG_DIR := s
  else
    { Debug Dir is current dir, Or root of Windows dir if readonly. CD? }
    If IsDirWritable(_ModuleDir) then
      DBG_DIR := _ModuleDir        //Where EXE or DLL lives
    else
      DBG_DIR := GetWinTempDirW;    //Window Temp folder

  {debug mode enabled is file debug.debug found in the Modules dir OR
                         a /debug or -debug cmdline switch}
  _DebugMode := FileExists_(_ModuleDir + '\debug.debug');
  if not _DebugMode then
    for i := 1 to ParamCountW do begin
      s := ParamStrW(i);
      if (CompareText(s, '/debug') = 0) or
         (CompareText(s, '-debug') = 0) then
        begin
        _DebugMode := TRUE;
        break;
        end;
      end;
  {ie info}
  _ieVerStr := GetIEVer(v1,v2,v3,v4);
  _ieInstalled := (_ieVerStr <> '');

  ResetDebugFile;
end;


initialization
  ModuleInit;

finalization
  DebugOut('=', ['']);
end.
