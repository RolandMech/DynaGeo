unit MyXMLTools;

interface

uses  Classes, SysUtils, StrUtils, Math, UnicodeConv, XDOM_2_4, GlobVars;

type  TParserState = (psNoTag,
                      psStartTagOpen, psStartTagClose,
                      psCommentOpen, psCommentClose,
                      psEndTagOpen, psInsideEndTag, psEndTagClose);

      TXMLPPOutputSource = class(TXMLOutputSource)
        protected
          Status       : TParserState;
          TabWidth,
          OpenTagCount,
          LenOfLine    : Integer;
          xmlFormat    : TXMLOutputFormat;
          procedure WriteDATA  (const WS: wideString);
        public
          constructor createWF (const stream : TStream;
                                const bufSize: integer;
                                const OutFormat: TXMLOutputFormat);
          procedure writeCDATA (const S: wideString); override;
          procedure writePCDATA(const S: wideString); override;
        end;

      TDomToPPXMLParser = class(TDomToXMLParser)
        public
          function writeToStream(const wnode: TdomNode;
                                 const encoding: wideString;
                                 const destination: TStream): boolean; override;
        end;

implementation

const  MaxLOL    : Integer = 70;
       CheckLOL  : Integer = 50;
       TAB_char  : char =  #9;
       LF_char   : char = #10;
       CR_char   : char = #13;
       SPACE_char: char = #32;
       CRLF_str  : string = #13#10;  // Standard-Zeilenvorschub für UTF-8
       ERROR_STR : string = 'Invalid Character';


constructor TXMLPPOutputSource.createWF(const stream : TStream;
                                        const bufSize: integer;
                                        const OutFormat: TXMLOutputFormat);
  begin
  Inherited create(stream, bufSize);
  Status       := psNoTag;
  xmlFormat    := OutFormat;
  OpenTagCount := 0;
  LenOfLine    := 0;
  If xmlFormat = fofPrettyPrint then
    TabWidth   := 2
  else
    TabWidth   := 0;
  end;


procedure TXMLPPOutputSource.WriteDATA(const WS: wideString);

  function InsertTabbedLFAfter(n: Integer; s: String): String;
    var i : Integer;
    begin
    Assert(n >= 1, 'InsertTabbedLFAfter called with n <= 0 !');
    If (n <= Length(s)) then
      Assert(s[n] in ['>', ' '], '">" or " " expected, but "' + s[n] + '" found.');
    While (Length(s) >= n + 1) and (s[n + 1] in [CR_char, LF_char]) do
      Delete(s, n+1, 1);
    Insert(CRLF_str, s, n+1);
    If xmlFormat = fofPrettyPrint then
      For i := 1 to OpenTagCount do
        Insert(TAB_char, s, n+3);
    Result := s;
    LenOfLine := OpenTagCount * TabWidth;
    end;

  function InsertTabbedLFBefore(n: Integer; s: String): String;
    var i : Integer;
    begin
    If n <= 0 then n := 1;
    While (Length(s) >= n) and (s[n] in [CR_char, LF_char]) do
      Delete(s, n, 1);
    Insert(CRLF_str, s, n);
    If xmlFormat = fofPrettyPrint then
      For i := 1 to OpenTagCount do
        Insert(TAB_char, s, n+2);
    Result := s;
    LenOfLine := OpenTagCount * TabWidth;
    end;

  function InsertAdditionalLF(s: String): String;
    { Fügt Umbrüche in Text außerhalb der Tags ein }
    var cpl : Integer;   // "C"haracters "p"er "l"ine

    function GetBreakPos(ws: String): Integer;
      var i, k : Integer;
      begin
      i := Pos(SPACE_char, ws);
      k := i;    // Position merken
      While i > 0 do begin
        i := PosEx(SPACE_char, ws, i + 1);
        If (i > 0) and (i <= cpl) then
          k := i;
        end;
      If k <= 0 then begin
        k := cpl;
        While (k > 0) and (ws[k] <> ';') and (ws[k] <> ',') do
          k := k - 1;
        If k > 0 then
          Result := k + 1
        else
          Result := Length(ws) + 1;
        end
      else
        Result := k + 1;
      end;

    var lbp : Integer;   // "L"ast "B"reak "P"osition
        SL  : TStringList;
        fs  : String;
        i   : Integer;
    begin
    Result := s;
    cpl := MaxLOL - LenOfLine;
    If cpl < 0 then cpl := 0;
    SL := TStringList.Create;
    try
      While Length(s) > cpl do begin
        lbp := GetBreakPos(s);
        fs := Copy(s, 1, lbp - 1);
        If (xmlFormat = fofPrettyPrint) and (SL.Count > 0) then
          For i := 1 to OpenTagCount do
            Insert(TAB_char, fs, 1);
        SL.Add(fs);
        Delete(s, 1, lbp - 1);
        end;
      If (xmlFormat = fofPrettyPrint) and (SL.Count > 0) then
        For i := 1 to OpenTagCount do
          Insert(TAB_char, s, 1);
      Result := SL.Text + s;
    finally
      SL.Free;
    end
    end;

  function CheckTag4Length(s: String): String;
    { Fügt Umbrüche in (zu) lange Tags ein;
      06.03.2008 : neu programmiert, weil die vorige Version bei zu langen
                   unteilbaren Strings in einer Endlosschleife hängen blieb }
    var ps,                 // "p"ostition of "s"pace
        start,              // "start" position of the search for spaces
        leos : Integer;     // "l"ogical ""e"nd "o"f "s"tring
    begin
    leos  := Length(s);
    start := leos - MaxLOL;
    While start > 0 do begin
      ps := PosEx(SPACE_char, s, start);
      If (ps >= start) and (ps < leos) then begin
        s := InsertTabbedLFAfter(ps, s);
        leos  := ps;
        start := leos - MaxLOL;
        end
      else begin
        start := start - 10;
        end
      end; { of while }
    Result := s;
    end;

  function CheckComment4Length(s: String): String;

    function FindSpace(ws: String; start: Integer): Integer;
      var i : Integer;
      begin
      i := Min(start, Length(ws));
      While (i > 0) and (ws[i] <> SPACE_char) do
        i := i - 1;
      Result := i;
      end;

    var LocalMaxLOL,
        ps, i, k : Integer;
        ws       : String;
        SL       : TStringList;
    begin
    Result := s;
    If LenOfLine + Length(s) > MaxLOL then begin
      SL := TStringList.Create;
      try
        SL.Add('');
        LocalMaxLOL := MaxLOL - TabWidth * OpenTagCount;
        ps := 1;
        While (Length(s) > LocalMaxLOL) and (ps > 0) do begin
          ps := FindSpace(s, LocalMaxLOL);
          If ps > 0 then begin
            SL.Add(Copy(s, 1, ps));
            Delete(s, 1, ps);
            end;
          end;
        SL.Add(s);
        If xmlFormat = fofPrettyPrint then begin
          For i := 1 to Pred(SL.Count) do begin
            ws := SL.Strings[i];
            For k := 1 to OpenTagCount do
              ws := TAB_char + ws;
            SL.Strings[i] := ws;
            end;
          ws := SL.Text;
          For k := 1 to OpenTagCount do
            ws := ws + TAB_char;
          Result := ws;
          end
        else
          Result := SL.Text;
      finally
        SL.Free;
      end; { of try }
      end;
    end;

  var s : String;
      n : Integer;
  begin
  try
    s := UTF16BEToUTF8Str(WS);
    n := 0;
    Case Status of   // Zustandswechsel
      psNoTag         : begin
                        n := Pos('<', s);
                        If n > 0 then begin
                          Status := psStartTagOpen;
                          If Length(s) > n then
                            Case s[n+1] of
                              '/' : Status := psEndTagOpen;
                              '?',
                              '!' : Status := psCommentOpen;
                            end;
                          end;
                        end;
      psStartTagOpen  : begin
                        n := Pos('>', s);
                        If n > 0 then
                          If (n > 1) and (s[n-1] in ['/', '?', ']']) then
                            Status := psEndTagClose
                          else
                            Status := psStartTagClose
                        end;
      psCommentOpen   : begin
                        n := Pos('>', s);
                        If ((n > 2) and (s[n-2] = ']') and (s[n-1] = ']')) or
                           ((n > 1) and (s[n-1] in ['?', '!'])) then
                          Status := psCommentClose
                        end;
      psInsideEndTag  : begin
                        n := Pos('>', s);
                        If n > 0 then
                          Status := psEndTagClose;
                        end;
    end; { of case }
    Case Status of   // Ausgabe im neuen Zustand
      psNoTag         : If LenOfLine + Length(s) > MaxLOL then
                          s := InsertAdditionalLF(s);
      psStartTagOpen  : s := CheckTag4Length(s);
      psStartTagClose : begin
                        OpenTagCount := OpenTagCount + 1;
                        s := InsertTabbedLFAfter(n, s);
                        Status := psNoTag;
                        end;
      psCommentOpen   : s := CheckComment4Length(s);
      psCommentClose  : begin
                        s := InsertTabbedLFAfter(n, s);
                        Status := psNoTag;
                        end;
      psEndTagOpen    : begin
                        If OpenTagCount > 0 then
                          OpenTagCount := OpenTagCount - 1;
                        s := InsertTabbedLFBefore(n, s);
                        Status := psInsideEndTag;
                        end;
      psEndTagClose   : begin
                        s := InsertTabbedLFAfter(n, s);
                        Status := psNoTag;
                        end;
    end; { of case }
    write(pointer(s)^, Length(s));
    LenOfLine := LenOfLine + Length(s);
  except
    on EConvertError do raise EWriteError.Create(ERROR_STR);
  end; { of try }
  end;

procedure TXMLPPOutputSource.writeCDATA(const S: wideString);
  begin
  If (Encoding = etUTF_8) and (xmlFormat >= fofShortLines) then
    WriteDATA(S)
  else
    Inherited writeCDATA(S);
  end;

procedure TXMLPPOutputSource.writePCDATA(const S: wideString);
  begin
  If (Encoding = etUTF_8) and (xmlFormat >= fofShortLines) then
    WriteDATA(S)
  else
    Inherited writePCDATA(S);
  end;

function TDomToPPXmlParser.writeToStream(const wnode: TdomNode;
                                         const encoding: wideString;
                                         const destination: TStream): boolean;
  var outputSource: TXmlOutputSource;
  begin
  if not assigned(DOMImpl)
    then raise EAccessViolation.create('DOMImplementation not specified.');
  if not assigned(destination)
    then raise EAccessViolation.create('Destination stream not specified.');
  if not assigned(wnode)
    then raise EAccessViolation.create('Source node not specified.');

  FDomReader.DOMImpl:= DOMImpl;
{$IFDEF LINUX}
  FStreamBuilder.defaultEncoding:= encoding;  // Raises an ENot_Supported_Err, if the specified encoding is not supported
{$ELSE}
  if UseActiveCodePage then
    FStreamBuilder.defaultEncoding:= GetACPEncodingName
  else
    FStreamBuilder.defaultEncoding:= encoding;  // Raises an ENot_Supported_Err, if the specified encoding is not supported
{$ENDIF}
  if encoding = 'UTF-8' then
    outputSource:= TXmlPPOutputSource.createWF(destination,FBufferSize,XMLOutputFormat)
  else
    outputSource:= TXmlOutputSource.create(destination,FBufferSize);
  try
    outputSource.newLine := FNewLine;
    FStreamBuilder.outputSource:= outputSource;
    result:= FDomReader.parse(wnode);
  finally
    FStreamBuilder.outputSource:= nil;
    outputSource.free;
  end; { of try }
  end;

end.
