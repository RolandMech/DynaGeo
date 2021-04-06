unit wmf;

interface

uses  wintypes, winprocs, sysutils, graphics;

type TWMF = class(TObject)
              private
                  FHandle : THandle;
                  FWidth  : integer;
                  FHeight : integer;
                  FCanvas : TCanvas;
                  procedure SetWidth (newWidth: Integer);
                  procedure SetHeight(newHeight: Integer);
              public
                  constructor Create(iWidth, iHeight: Integer);
                  destructor Destroy; override;
                  property Canvas : TCanvas read FCanvas write FCanvas;
                  procedure SaveToFile(name:pchar);
                  procedure TransferDataToClipboard;
                  procedure SaveToClipboard;
                  property Handle: THandle read FHandle;
                  property width : integer read Fwidth write SetWidth;
                  property height: integer read Fheight write SetHeight;
            end;

implementation


type
     PtrRec  = record
                 Lo, Hi: Word
               end;

     IOFunction = function(FP: integer; Buf: PChar; Size: Integer): Word;


constructor TWMF.Create(iWidth, iHeight: Integer);
  begin
  inherited Create;
{ initialisieren  hier ................................}
  FHandle := CreateMetaFile(NIL);
  SetBkColor(FHandle,$FFFFFF);
  SetBkMode(FHandle, 1);
  SelectObject(FHandle,GetStockObject(HOLLOW_BRUSH));
  SelectObject(FHandle,GetStockObject(BLACK_PEN));
  SetMapMode(FHandle, mm_anisotropic);
  FWidth  := iWidth;
  FHeight := iHeight;
  SetWindowExt(FHandle, FWidth, FHeight);
  SetWindowOrg(FHandle, 0, 0);
  FCanvas := TCanvas.Create;
  FCanvas.Handle := FHandle;
  end;

destructor TWMF.Destroy;
  begin
  DeleteMetafile(CloseMetaFile(FHandle));
  FCanvas.Free;
  inherited Destroy;
  end;

procedure TWMF.SetWidth(newWidth: Integer);
  begin
  If newWidth <> FWidth then begin
    FWidth := newWidth;
    SetWindowExt(FHandle, FWidth, FHeight);
    end;
  end;

procedure TWMF.SetHeight(newHeight: Integer);
  begin
  If newHeight <> FHeight then begin
    FHeight := newHeight;
    SetWindowExt(FHandle, FWidth, FHeight);
    end;
  end;

procedure AHIncr; far; external 'KERNEL' index 114;
const OneIO = 32768;

function HugeIO(IOFunc: IOFunction; F: Integer; P: Pointer; Size: Longint) : Word;
  var   L, N: Longint;
  begin
  HugeIO := 1;
  L := 0;
  while L < Size do begin
    N := Size - L;
    if N > OneIO then N := OneIO;
    if IOFunc(F,Ptr(PtrRec(P).Hi + PtrRec(L).Hi * Ofs(AHIncr),PtrRec(L).Lo),
               Integer(N)) <> N then begin
      HugeIO := 0;
      Exit;
      end;
    Inc(L, N);
    end;
  end;

procedure TWMF.SaveToClipboard;
  var b : boolean;
  begin
  b := OpenClipBoard(GetActiveWindow);
  b := EmptyClipBoard;
  TransferDataToClipboard;
  b := CloseClipBoard;
  end;

procedure TWMF.TransferDataToClipboard;
  var wmfha  : thandle;
      h      : thandle;
      htmp   : thandle;
      buf    : ^tmetafilepict;
  begin
  SetWindowExt(FHandle, FWidth, FHeight);
  wmfha    := CloseMetaFile(FHandle);
  htmp     := GlobalAlloc(gmem_moveable, sizeof(tmetafilepict));
  Buf      := GlobalLock(htmp);
  buf^.mm  := mm_anisotropic;
  buf^.xext:= FWidth*10;
  buf^.yext:= FHeight*10;
  buf^.hmf := copymetafile(wmfha,nil);
  GlobalUnlock(htmp);
  h := SetClipBoardData(CF_Metafilepict, htmp);
  DeleteMetafile(wmfha);
  end;

procedure TWMF.SaveToFile(name:pchar);
type extyp = record
               key1,
               key2,
               key3,
               key4    :byte;    { Kennzeichen }
               hmf     :thandle; { NULL }
               left,
               top,
               right,
               bottom  :integer;
               inch    :word;
               resv,
               resv1   :word;
               crc     :word;
             end;

var wmfha : THandle;
    wmfi  : ^TMetaheader;
    size  : longint;
    i,fp  : integer;
    buf   : Pointer;		{ Memory for bitmap }
    kopf  : extyp;
    kopfw : array[1..10] of word absolute kopf;

begin
     kopf.key1:=215; kopf.key2:=205; kopf.key3:=198; kopf.key4:=154;
     kopf.hmf :=0;
     kopf.left:=0; kopf.top:=0;
     kopf.right:= FWidth;
     kopf.bottom:=FHeight;
     kopf.inch:=254;                   { eine Einheit = 1/10 mmm   }
     kopf.resv:=0; kopf.resv1:=0;
     kopf.crc :=0;                      {Prüfsumme für ExtraHeader rücksetzen}
     for i := 1 to 10 do kopf.crc:= kopf.crc XOR kopfw[i];
     wmfha   := CloseMetafile(FHandle); { Speicher-WMF kopieren => Handle zurück }
     fp      := _lcreat(name, 0);      { Datei öffnen }
     if fp = -1 then Exit;              { bei Fehler Ausstieg }
     Buf     := GlobalLock(wmfha);      { Pointer auf Metadatei holen }
     wmfi    := buf;                    { Headerabfrage ...}
     size    := wmfi^.mtsize*2;         { mit Größenbestimmung }
     _lwrite(FP, @kopf, 22);            { Extra Header schreiben }
     HugeIO(_lwrite, FP, Buf, Size);    { Header + Metadatei schreiben }
     GlobalUnlock(wmfha);               { Tür wieder zumachen ...}
     _lclose(FP);
     deleteMetafile(wmfha);
end;

end.


