unit DragDrop;

interface

uses Windows, ActiveX, ComObj;

const CLSID_TOleDragDrop : TGUID = '{E10B6140-DAA7-11D4-ABBA-82E8E39ACA5E}';

type  TOleDragDrop = class(TComObject, IDropTarget)
      public
        function DragEnter(const dataObj     : IDataObject;
                                 grfKeyState : LongInt;
                                 pt          : TPoint;
                            var  dwEffect    : LongInt): HResult; stdcall;

        function DragOver (      grfKeyState : LongInt;
                                 pt          : TPoint;
                            var  dwEffect    : LongInt): HResult; stdcall;

        function DragLeave                             : HResult; stdcall;

        function Drop     (const dataObj     : IDataObject;
                                 grfKeyState : LongInt;
                                 pt          : TPoint;
                           var   dwEffect    : LongInt): HResult; stdcall;
      end;

implementation

uses ComServ, ShellApi, Messages, SysUtils,

{------ Applikations-spezifischer Teil --------------------}

     MainWin;

function DataFormatOkay(dataObj: IDataObject; var FormatEtc: TFormatEtc): Boolean;
  var hRes       : HResult;
      StgMedium  : TStgMedium;
      szFileName : array [0..MAX_PATH] of char;
      n          : Integer;
      f_ext      : String;
  begin
  Result := False;
  hRes := dataObj.GetData(FormatEtc, StgMedium);
  If hRes = S_Ok then begin
    n := DragQueryFile(StgMedium.hGlobal, $FFFFFFFF, nil, 0);
    If n = 1 then begin  { nur 1 Datei zulassen ! }
      DragQueryFile(StgMedium.hGlobal, 0, szFileName, MAX_PATH);
      f_ext := UpperCase(ExtractFileExt(szFileName));
      Result := (f_ext = '.GEO') or (f_ext = '.GEOX');
      end;
    end;
  end;

function PointInTargetWindow(pt: TPoint): Boolean;
  begin
  With HauptFenster.PaintBox1 do begin
    pt := ScreenToClient(pt);
    Result := PtInRect(ClientRect, pt);
    end;
  end;

function FilesProcessed(StgMedium: TStgMedium): Boolean;
  var szFileName : array [0..MAX_PATH] of char;
  begin
  DragQueryFile(StgMedium.hGlobal, 0, szFileName, MAX_PATH);
  HauptFenster.LoadOLEDroppedFile(szFileName);
  Result := True;
  end;

{------ Allgemeingültiger Teil ----------------------------}

function TOleDragDrop.DragEnter(const dataObj     : IDataObject;
                                      grfKeyState : LongInt;
                                      pt          : TPoint;
                                 var  dwEffect    : LongInt): HResult;
  var hRes      : HResult;
      FormatEtc : TFormatEtc;
  begin
  with FormatEtc do begin
    cfFormat := CF_HDROP;
    ptd      := nil;
    dwAspect := DVASPECT_CONTENT;
    lindex   := -1;
    tymed    := TYMED_HGLOBAL;
    end;
  hRes := dataObj.QueryGetData(FormatEtc);
  if (hRes = S_OK) and
     DataFormatOkay(dataObj, FormatEtc) then begin
    dwEffect := DROPEFFECT_COPY;
    Result := S_Ok;
    end
  else begin
    dwEffect := DROPEFFECT_NONE;
    Result := S_False;
    end;
  end;

function TOleDragDrop.DragOver (grfKeyState  : LongInt;
                                pt           : TPoint;
                                var dwEffect : LongInt): HResult;
  begin
  if PointInTargetWindow(pt) then
    dwEffect := DROPEFFECT_COPY
  else
    dwEffect := DROPEFFECT_NONE;
  Result := S_Ok;
  end;

function TOleDragDrop.DragLeave: HResult;
  begin
  Result := S_Ok;
  end;

function TOleDragDrop.Drop (const dataObj : IDataObject;
                            grfKeyState   : LongInt;
                            pt            : TPoint;
                            var dwEffect  : LongInt): HResult;
  var hRes       : HResult;
      FormatEtc  : TFormatEtc;
      StgMedium  : TStgMedium;
  begin
  with FormatEtc do begin
    cfFormat := CF_HDROP;
    ptd      := nil;
    dwAspect := DVASPECT_CONTENT;
    lindex   := -1;
    tymed    := TYMED_HGLOBAL;
    end;
  hRes := dataObj.GetData(FormatEtc, StgMedium);
  if (hRes = S_OK) and
     FilesProcessed(StgMedium) then begin
    dwEffect := DROPEFFECT_COPY;
    Result := S_Ok;
    end
  else begin
    dwEffect := DROPEFFECT_NONE;
    Result := S_False;
    end;
  end;


initialization
TComObjectFactory.Create(ComServer, TOleDragDrop, CLSID_TOleDragDrop,
                         'TOleDragDrop', 'TOleDragDrop class',
                         ciMultiInstance);
end.
