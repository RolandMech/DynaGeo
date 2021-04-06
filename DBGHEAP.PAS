Unit DbgHeap;  // 1999 by Matthias Withopf / c't 10/99

Interface

Type
  LongWord = Cardinal;

Const
  _TotalMemMax     : LongWord = 0;
  _TotalMem        : LongWord = 0;  // entspricht AllocMemSize  aus System-Unit
  _TotalMemBlock   : LongWord = 0;  // entspricht AllocMemCount aus System-Unit
  _TotalAllocCount : LongWord = 0;
  _TotalFreeCount  : LongWord = 0;

Implementation

Uses
  Windows,SysUtils;

  Function ErrDlg(s : PChar) : Boolean;
  Var
    tmp : Array[0..511] of Char;
  Begin
    StrCopy(tmp,'Heap-Fehler: ');
    StrCat(tmp,s);
    StrCat(tmp,^M'Breakpoint aktivieren?');
    Result := MessageBox(0,tmp,'DbgHeap',MB_YESNO) = IDYES;
  End;

Var
  MemStatistics_CS : TRTLCriticalSection;
Const
  MemStatistics_CS_Initialized : Boolean  = False;

  Procedure Heap_Init;
  Begin
    If Not(MemStatistics_CS_Initialized) then
      Begin
        InitializeCriticalSection(MemStatistics_CS);
        MemStatistics_CS_Initialized := True;
      End
  End;

Type
  TDbgHeapInternal =
    Record
      dhi_StartAddr : Pointer;
      dhi_Size      : LongWord;
      dhi_Pages     : LongWord;
      dhi_Magic     : LongWord;
    End;
  PDbgHeapInternal = ^TDbgHeapInternal;

Const
  PageSize : LongWord = 0;
  DbgHeapMagic = $AB01CD02;

  Function GetDbgHeapInternal(p : Pointer) : PDbgHeapInternal;
  Var
    p1 : PChar;
    p2 : PDbgHeapInternal;
    I  : TMemoryBasicInformation;
  Begin
    p1 := PChar(p) - SizeOf(TDbgHeapInternal);
    While (LongWord(p1) And (SizeOf(Integer) - 1)) <> 0 do Dec(p1);
    p2 := PDbgHeapInternal(p1);     // Alignment!
    VirtualQuery(p1,I,SizeOf(I));
    If (I.State <> MEM_COMMIT) Or (p2^.dhi_Magic <> DbgHeapMagic) then
      Begin
        Result := Nil;  // ungültiger Heap-Block!
        Exit;
      End;
    Result := p2;
  End;

  Function AllocDbgHeap(Size : LongWord;Clear : Boolean) : Pointer;
  Var
    SI            : TSYSTEMINFO;
    OrigSize      : LongWord;
    PageCount     : Integer;
    p             : Pointer;
    p1            : PChar;
    OrigPtr       : Pointer;
    OfsInLastPage : LongWord;
    LastAccess    : DWORD;
    p2            : PDbgHeapInternal;
  Const
    InternalSize = (SizeOf(Integer) - 1) + SizeOf(TDbgHeapInternal);
  Begin
    If PageSize = 0 then
      Begin
        GetSystemInfo(SI);
        PageSize := SI.dwPageSize;
      End;
    OrigSize := Size;
    Inc(Size,InternalSize);
    PageCount := (Size + PageSize - 1) Div PageSize;   // auf Pagegröße runden
    p := VirtualAlloc(Nil,(PageCount + 1) * PageSize,MEM_COMMIT,PAGE_READWRITE);
    If p <> Nil then
      Begin
        OrigPtr := p;
        VirtualProtect(@PChar(p)[PageCount * PageSize],PageSize,PAGE_NOACCESS,@LastAccess);
        FillChar(p^,PageCount * PageSize,$AA);
        OfsInLastPage := Size Mod PageSize;
        If OfsInLastPage <> 0 then
          p := PChar(p) + (PageSize - OfsInLastPage);    // Block am Seitenende positionieren
        p1 := PChar(p);                                  // Alignment!
        While (LongWord(p1) And (SizeOf(Integer) - 1)) <> 0 do Inc(p1);
        p2 := PDbgHeapInternal(p1);
        p2^.dhi_StartAddr := OrigPtr;
        p2^.dhi_Size      := OrigSize;
        p2^.dhi_Pages     := PageCount;
        p2^.dhi_Magic     := LongWord(DbgHeapMagic);
        p := PChar(p) + InternalSize;
        If Clear then FillChar(p^,OrigSize,0);
      End;
    Result := p;
  End;

  Function FreeDbgHeap(p : Pointer) : Boolean;
  Var
    p1 : PDbgHeapInternal;
  Begin
    Result := False;
    p1 := GetDbgHeapInternal(p);
    If p1 = Nil then Exit;
    // ändere Status auf 'Reserved'
    If Not(VirtualFree(p1^.dhi_StartAddr,p1^.dhi_Pages * PageSize,MEM_DECOMMIT)) then
      Exit;
    Result := True;
  End;

  Function MyGetMem(Size : Integer) : Pointer;
  Begin
    Result := AllocDbgHeap(Size,False);
    If Result <> Nil then
      Begin
        EnterCriticalSection(MemStatistics_CS);
        Inc(_TotalAllocCount);
        Inc(_TotalMem,Size);
        Inc(_TotalMemBlock);
        If _TotalMemMax < _TotalMem then _TotalMemMax := _TotalMem;
        LeaveCriticalSection(MemStatistics_CS);
      End;
  End;

  Function MyFreeMem(p : Pointer) : Integer;
  Var
    Size : LongWord;
    p1   : PDbgHeapInternal;
  Begin
    Size   := 0;
    Result := 0;
    p1     := GetDbgHeapInternal(p);
    If p1 <> Nil then Size := p1^.dhi_Size;
    If (p1 <> Nil) And FreeDbgHeap(p) then
      Begin
        EnterCriticalSection(MemStatistics_CS);
        Inc(_TotalFreeCount);
        Dec(_TotalMem,Size);
        Dec(_TotalMemBlock);
        LeaveCriticalSection(MemStatistics_CS);
      End
    else
      Begin
        If ErrDlg('Ungültiger Speicherblock für FreeMem') then
          DebugBreak;   // ungültiger Heap-Block!
      End;
  End;

  Function MyReallocMem(Block : Pointer;Size : Integer) : Pointer;
  Var
    OldSize : LongWord;
    p       : Pointer;
    p1      : PDbgHeapInternal;
    S       : Integer;
  Begin
    Result := Nil;
    If (Size = 0) And (Block <> Nil) then
      Begin
        MyFreeMem(Block);
        Exit;
      End;
    If Block = Nil then
      Begin
        Result := MyGetMem(Size);
        Exit;
      End;
    OldSize := 0;
    p  := MyGetMem(Size);
    p1 := GetDbgHeapInternal(Block);
    If p1 <> Nil then
      OldSize := p1^.dhi_Size
    else
      If ErrDlg('Ungültiger Speicherblock für ReallocMem') then
        DebugBreak;   // ungültiger Heap-Block!
    If p  <> Nil then
      Begin
        S := OldSize;
        If S > Size then
          S := Size;
        If S <> 0 then Move(PChar(Block)^,PChar(p)^,S);
      End;
    MyFreeMem(Block);
    Result := p;
  End;

Var
  OldMMgr : TMemoryManager;

  Procedure MyHeapManager_Init;
  Var
    MMgr : TMemoryManager;
  Begin
    Heap_Init;
    GetMemoryManager(OldMMgr);
    MMgr.GetMem     := MyGetMem;
    MMgr.FreeMem    := MyFreeMem;
    MMgr.ReallocMem := MyReallocMem;
    SetMemoryManager(MMgr);
  End;

  Procedure MyHeapManager_Done;
  Var
    Arg : Array[0..1] of Pointer;
    tmp : Array[0..255] of Char;
  Begin
    If _TotalMemBlock <> 0 then
      Begin
        Arg[0] := Pointer(_TotalMemBlock);
        Arg[1] := Pointer(_TotalMem);
        wvsprintf(tmp,'%u Speicherblöcke der Gesamtgröße von %u Bytes wurden nicht freigegeben!',@Arg[0]);
        If ErrDlg(tmp) then
          DebugBreak;
      End;
    SetMemoryManager(OldMMgr);
  End;

Initialization
  MyHeapManager_Init;

Finalization
  MyHeapManager_Done;

End.

