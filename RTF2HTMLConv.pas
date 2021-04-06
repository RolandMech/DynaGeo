unit RTF2HTMLConv;

interface

uses Graphics;

function RTF2HTML  (source: String): String;
  { interpretiert den RTF-String "source" und baut einen entsprechenden
    HTML-String auf; dabei werden neben dem ASCII-Text auch die Fonts
    (Name, Größe), die Zeichenattribute (fett, unterstrichen, kursiv,
    tief- bzw. hochgestellt) sowie die Zeilenumbrüche übernommen. }

function RTFColor  (source: String): TColor;
  { überprüft, ob der übergebene RTF-String "source" eine Farbtabelle
    enthält; falls ja, wird als Funktionsergebnis die erste Farbe dieser
    Tabelle übergeben, andernfalls wird "clBlack" zurückgegeben.  }


implementation

uses classes, sysutils, strutils, utility;

var LastFontNum,
    LastFontSize,
    RelBottomLine  : Integer;
    AttrStr        : String;
    FontList       : TStringList;

function GetNextChar(s: String): Char;
  begin
  IF Length(s) > 0 then
    Result := s[1]
  else
    Result := #0;
  end;


function ReadNextCommandFrom(var s: String): String;
  var c: Char;
  begin
  Result := '';
  c := GetNextChar(s);
  If c = '''' then begin
    Result := c;
    Delete(s, 1, 1);
    end
  else
    While CharInSet(c, ['A'..'Z', 'a'..'z']) do begin
      Result := Result + c;
      Delete(s, 1, 1);
      c := GetNextChar(s);
      end;
  If (Length(Result) > 0) and
     (s[1] = ' ') then
    Delete(s, 1, 1);
  end;


function ReadIntegerFrom(var s: String): Integer;
  var c : Char;
      z : String;
  begin
  z := '';
  c := GetNextChar(s);
  While CharInSet(c, ['0'..'9']) do begin
    Delete(s, 1, 1);
    z := z + c;
    c := GetNextChar(s);
    end;
  Result := StrToInt(z);
  If (Length(z) > 0) and
     (s[1] = ' ') then
    Delete(s, 1, 1);
  end;


procedure ClearEmbeddedTags(var s: String);
  var level, n, op, cp : Integer;
  begin
  level := 1;
  op := 0;
  cp := 0;
  n  := 1;
  While (level > 0) and (n <= Length(s)) do begin
    Case s[n] of
      '{' : begin
            level := level + 1;
            op := n;
            cp := 0;
            end;
      '}' : begin
            level := level - 1;
            cp := n;
            end;
    end; { of case }
    If (op > 0) and (cp > op) then begin
      Delete(s, op, cp-op);
      s[op] := ' ';  // überschreibt die (schließende) Klammer
      level := 1;
      op := 0;
      cp := 0;
      n  := 1;       // wieder von vorne anfangen !
      end;
    n := n + 1;
    end; { of while }
  end;


procedure ReadFontFrom(var s: String);
  var n : Integer;
  begin
  ClearEmbeddedTags(s);
  n := Pos(' ', s);       { Skip all font params    }
  Delete(s, 1, n);
  n := POS(';', s);       { Get only the font name  }
  If n > 0 then begin
    FontList.Add(Copy(s, 1, n-1));
    Delete(s, 1, n);      { Delete closing ';' too  }
    end;
  end;


procedure ReadOverCurlyBraces(var s: String);
  var c : Char;
      n : Integer;
  begin
  c := GetNextChar(s);
  If c = '{' then begin
    Delete(s, 1, 1);
    n := 1;
    While n > 0 do begin
      c := GetNextChar(s);
      Delete(s, 1, 1);
      Case c of
        '{' : n := n + 1;
        '}' : n := n - 1;
      end; { of case }
      end; { of while }
    end;   { of if }
  end;


function ProcessCommand(var s: String): String;
  var cs   : String;
      c    : Char;
      m, n : Integer;

  procedure SkipFollowingFontDescription;
    begin
    If Pos('\fs', s) = 1 then begin
      Delete(s, 1, 3);
      n := ReadIntegerFrom(s);
      end
    else If Pos('\f', s) = 1 then begin
      Delete(s, 1, 2);
      n := ReadIntegerFrom(s);
      end;
    end;

  begin
  Result := '';
  cs := ReadNextCommandFrom(s);
  If cs = '''' then begin       // special chars
    n := StrToInt('$' + Copy(s, 1, 2));
    Delete(s, 1, 2);
    Result := Char(n);
    end else
  If cs = 'f' then begin        // set font face
    LastFontNum := ReadIntegerFrom(s);
    If LastFontNum < FontList.Count then
      Result := '</font><font face="' + FontList[LastFontNum] +
                           '" size="' + IntToStr(LastFontSize) + '">';
    end else
  If cs = 'fs' then begin       // set font size
    n := ReadIntegerFrom(s);
    If RelBottomLine = 0 then begin  { Nur für nicht-hoch/tiefgestellte     }
      LastFontSize := n Div 2;       { Zeichen die Fontgröße einstellen ... }
      Result := '</font><font face="' + FontList[LastFontNum] +
                           '" size="' + IntToStr(LastFontSize) + '">';
      end;                    { ...andernfalls aktuelle Größe beigehalten ! }
    end else
  If cs = 'i' then begin        // italic...
    If s[1] = '0' then begin
      Result := '</i>';
      Delete(s, 1, 1);
      n := Pos('i', AttrStr);
      If n > 0 then
        Delete(AttrStr, n, 1);
      end
    else begin
      Result := '<i>';
      AttrStr := AttrStr + 'i';
      end
    end else
  If cs = 'b' then begin        // bold...
    If s[1] = '0' then begin
      Result := '</b>';
      Delete(s, 1, 1);
      n := Pos('b', AttrStr);
      If n > 0 then
        Delete(AttrStr, n, 1);
      end
    else begin
      Result := '<b>';
      AttrStr := AttrStr + 'b';
      end
    end else
  If cs = 'ul' then begin       // underlined...
    If s[1] = '0' then begin
      Result := '</u>';
      Delete(s, 1, 1);
      n := Pos('u', AttrStr);
      If n > 0 then
        Delete(AttrStr, n, 1);
      end
    else begin
      Result := '<u>';
      AttrStr := AttrStr + 'u';
      end
    end else
  If cs = 'ulnone' then         // end of underline
    Result := '</u>' else
  If cs = 'par' then            // line break
    Result := '<br>' else
  If cs = 'tab' then            // tab
    Result := '  ' else
  If cs = 'dn' then begin       // sub script
    n := ReadIntegerFrom(s);
    If n > 0 then begin
      RelBottomLine := -1;
      Result := '<sub>';
      AttrStr := AttrStr + 'l';     { "l"ow }
      end
    else begin { should be  n = 0 }
      If RelBottomLine < 0 then
        Result := '</sub>'
      else
        Result := '</sup>';
      RelBottomLine := 0;
      DeleteChars('l', AttrStr);
      SkipFollowingFontDescription;
      end;
    end else
  If cs = 'super' then begin    // super script, 1. Version, ein- und ...
    Result := '<sup>';
    SkipFollowingFontDescription;
    AttrStr := AttrStr + 'h';
    end else
  If cs = 'nosupersub' then begin              // ... wieder ausschalten
    Result := '</sup>';
    SkipFollowingFontDescription;
    DeleteChars('h', AttrStr);
    end else
  If cs = 'up' then begin       // super script, 2. Version
    n := ReadIntegerFrom(s);
    If n > 0 then begin
      RelBottomLine := 1;
      Result := '<sup>';
      AttrStr := AttrStr + 'h';     { "h"igh }
      end
    else begin { should be  n = 0 }
      If RelBottomLine > 0 then
        Result := '</sup>'
      else
        Result := '</sub>';
      RelBottomLine := 0;
      DeleteChars('h', AttrStr);
      SkipFollowingFontDescription;
      end;
    end else
  If cs = 'plain' then begin    // plain
    If RelBottomLine = 0 then begin { Hoch- oder Tiefstellen vorbereiten : }
      n := Pos(' ', s);              { Prüfen, ob im selben Befehlsblock    }
      m := Pos('\up', s);            { noch auf hoch- oder tiefgestellte    }
      If (m <= 0) or (m > n) then     { Schrift umgeschaltet wird            }
        m := Pos('\dn', s);
      If (m > 0) and (m < n) then begin { Falls ja :                        }
        m := Pos('\fs', s);
        If m < n then begin          { Fontgrößenumstellung löschen, weil   }
          Delete(s, m, 3);           {    HTMLEdit das automatisch macht.   }
          While CharInSet(s[m], ['0'..'9']) do
            Delete(s, m, 1);
          end;                          { Falls nein : nix zu tun !         }
        end;
      end;
    While Length(AttrStr) > 0 do begin  { Zeichenattribute zurücksetzen     }
      c := AttrStr[Length(AttrStr)];
      Case c of
        'b' : Result := Result + '</b>';
        'i' : Result := Result + '</i>';
        'u' : Result := Result + '</u>';
        'h' : begin
              Result := Result + '</sup>';
              RelBottomLine := 0;
              end;
        'l' : begin
              Result := Result + '</sub>';
              RelBottomLine := 0;
              end;
      end; { of case }
      Delete(AttrStr, Length(AttrStr), 1);
      end;
    end else { of  "cs = 'plain'" }
  If cs = 'u' then begin    // UniCode-(Sonder)-Zeichen
    n := ReadIntegerFrom(s);
    Case n of
      8729 : begin
             Result := Result + '<font face="Symbol"> ' + #215 + ' </font>';
             Delete(s, 1, 1);     // Das nächste Zeichen überlesen !
             end;
    end; { of case }              // Bei unbekanntem Zeichen das (hoffentlich!)
    end  { of if }                // folgende "?" ausgeben
  else begin
    While (Length(s) > 0) and CharInSet(s[1], ['0'..'9', '-', '+']) do
      Delete(s, 1, 1);
    Result := '';
    end;
  end;


procedure ReadThroughText(var s, t: String);
  var c         : Char;
      CharCount : Integer;
      cmdstr    : String;
  begin
  CharCount := 0;
  While Length(s) > 0 do begin
    c := GetNextChar(s);
    Case c of
      '\' : begin
            Delete(s, 1, 1);
            cmdstr := ProcessCommand(s);
            t := t + cmdstr;
            end;
      '<' : begin
            Delete(s, 1, 1);
            t := t + '&lt;';
            end;
      '>' : begin
            Delete(s, 1, 1);
            t := t + '&gt;';
            end;            
      '{' : ReadOverCurlyBraces(s);
      '}',
      #08,
      #13 : begin
            Delete(s, 1, 1);
            If CharCount > 0 then begin
              t := t + ' '; { Replace these chars by a blank ! }
              Inc(CharCount);
              end;
            end;
      #10 : Delete(s, 1, 1);          { Ignore these chars ! }
    else
      Delete(s, 1, 1);
      t := t + c;
      Inc(CharCount);
    end; { of case }
    end; { of while }

  end; { of ReadThroughText }

procedure KillLeadingDelimiters(var s: String);
  begin
  end;

function KillEmptyFontTags(ss: String): String;

  function ExtractOpeningFontTag(fulltext: String; start: Integer): String;
    var n, d : Integer;
    begin
    Result := '';
    n := PosEx('<font', fulltext, start);
    If n > 0 then begin
      d := PosEx('>', fulltext, n);
      If d > 0 then
        Result := Copy(fulltext, n, d - n + 1);
      end;
    end;

  function ExtractFullFontTag(fulltext: String; start: Integer): String;
    var n, d : Integer;
    begin
    Result := '';
    n := PosEx('<font', fulltext, start);
    If n > 0 then begin
      d := PosEx('</font>', fulltext, n);
      If d > 0 then
        Result := Copy(fulltext, n, d - n + 7);
      end;
    end;

  function VisCharCount(s: String): Integer;
    var i : Integer;
    begin
    Result := 0;
    i := 1;
    While i <= Length(s) do begin
      Case s[i] of
        '<' : Repeat                    // Tags komplett überspringen
                i := i + 1
              until (i > Length(s)) or (s[i] = '>');
        ' ' : If Result > 0 then        // Führende Leerzeichen überspringen
                Result := Result + 1;
        #0..
        #31 : ;                         // Steuerzeichen überspringen
      else
        Result := Result + 1;
      end; { of case }
      i := i + 1;
      end; { of While }
    end;

  function FontTagIsEmpty(fulltext: String; var cont: String): Boolean;
    var n, z : Integer;
    begin
    cont   := '';
    Result := False;
    n := Pos('<font', fulltext);
    If n > 0 then begin
      z := PosEx('>', fulltext, n + 5);
      If z > 0 then begin
        Delete(fulltext, n, z - n + 1);
        n := Pos('</font>', fulltext);
        If n > 0 then begin
          Delete(fulltext, n, 7);
          cont := fulltext;
          Result := VisCharCount(cont) = 0;
          end;
        end;
      end;
    end;

  function DeleteDoubleFontTags(fulltext: String): String;
    var fontStr : String;
        start, n, m : Integer;
    begin
    start := 1;
    fontStr := ExtractOpeningFontTag(fulltext, start);
    While Length(fontStr) > 0 do begin
      start := start + Length(fontStr);
      n := PosEx('</font>', fulltext, start);
      m := PosEx('</font>' + fontStr, fulltext, start);
      While (n > 0) and (m = n) do begin
        Delete(fulltext, m, Length(fontStr) + 7);
        n := PosEx('</font>', fulltext, start);
        m := PosEx('</font>' + fontStr, fulltext, start);
        end;
      If n > 0 then
        start := n + 7;
      fontStr := ExtractOpeningFontTag(fulltext, start);
      end;
    Result := fulltext;
    end;

  var fontStr,
      cont     : String;
      start, n : Integer;
  begin
  KillLeadingDelimiters(ss);
  start := 1;
  fontStr := ExtractFullFontTag(ss, start);
  While Length(fontStr) > 0 do begin
    If FontTagIsEmpty(fontStr, cont) then begin
      Delete(ss, PosEx(fontStr, ss, start), Length(fontStr));
      If Length(cont) > 0 then begin
        n := PosEx('<font', ss, start);
        If n > 0 then begin
          n := PosEx('>', ss, n + 5);
          If (n > 0) and (n < Length(ss)) then
            Insert(cont, ss, n + 1);
          end;
        end;
      end
    else
      start := start + Length(fontStr);
    fontStr := ExtractFullFontTag(ss, start);
    end;
  Result := DeleteDoubleFontTags(ss);
  end;


function RTF2HTML(source: String): String;
  var c     : Char;
      ftext : String;
      n     : Integer;
  begin
  AttrStr := '';

  // Delete trailing special chars
  While (Length(source) > 0) and
        (source[Length(source)] < #32) do
    Delete(source, Length(source), 1);

  // Skip the "{\rtf..." entry - no valuable info there
  n := POS('\deff', source);
  If n > 0 then begin
    Delete(source, 1, n+4);
    LastFontNum := ReadIntegerFrom(source);
    end
  else
    LastFontNum := -1;
  LastFontSize := 12;

  n := POS('{\fonttbl', source);  // Read font table
  If n > 0 then begin
    FontList := TStringList.Create;
    Delete(source, 1, n+8);
    c := GetNextChar(source);
    Repeat
      If c = '{' then begin
        Delete(source, 1, 1);     //  Delete opening '{'
        ReadFontFrom(source);     //  Read and register font name
        Delete(source, 1, 1);     //  Delete closing '}'
        end
      else
        ReadFontFrom(source);     //  Read font name without braces
      c := GetNextChar(source);
    until c = '}';
    Delete(source, 1, 1);         //  Delete closing '}'
    end
  else
    FreeAndNil(FontList);

  If LastFontNum >= 0 then        // Set default start font
    ftext := '<font face="' + FontList[LastFontNum] +
                  '" size="' + IntToStr(LastFontSize) + '">'
  else
    ftext := '<font face="Arial" size="12">';
  ReadOverCurlyBraces(source);    // Skip further header entries
  RelBottomLine := 0;

  ReadThroughText(source, ftext); // Read formatted text
  ftext := KillEmptyFontTags(ftext);

  While (Length(ftext) > 0) and   // Delete trailing special chars
        (ftext[Length(ftext)] <= #32) do begin
    Delete(ftext, Length(ftext), 1);
    If LowerCase(Copy(ftext, Length(ftext)-3, 4)) = '<br>' then
      Delete(ftext, Length(ftext)-3, 4);
    end;

  ftext := ftext + '</font>';     // Add closing font tag.
  ftext := HTMLKillNonsenseTags(ftext);
  Result := HTMLKillEmptyTags(ftext);
  end;


function RTFColor(source: String): TColor;
  var n, nr, ng, nb : Integer;
      b, g, r : Byte;

  function ColUsed(n: Integer): Boolean;
    var t : String;
    begin
    t := 'cf' + IntToStr(n);
    Result := Pos(t, source) > 0;
    end;

  function GetColVal(j: Integer): Byte;
    var s : String;
    begin
    s := '';
    While (j <= Length(source)) and CharInSet(source[j], ['0'..'9']) do begin
      s := s + source[j];
      j := j + 1;
      end;
    If Length(s) > 0 then
      Result := Byte(StrToInt(s))
    else
      Result := 0;
    end;

  function max(a, b, c : Integer): Integer;
    begin
    If a > b      then Result := a else Result := b;
    If c > Result then Result := c;
    end;

  begin
  Result := clBlack;
  n := Pos('colortbl', source);
  If n > 0 then begin
    Delete(source, 1, n + 7);
    While (Length(source) > 0) and (source[1] <> '\') do
      Delete(source, 1, 1);
    n := 0;
    Repeat
      nr := Pos('\red', source);
      ng := Pos('\green', source);
      nb := Pos('\blue', source);
      If (nr*ng*nb > 0) and ColUsed(n) then begin
        r := GetColVal(nr + 4);
        g := GetColVal(ng + 6);
        b := GetColVal(nb + 5);
        Result := (((b SHL 8) + g) SHL 8) + r;
        end;
      Delete(source, 1, max(nr + 3, ng + 5, nb + 4));
      While CharInSet(source[1], ['0'..'9', ' ', ';']) do
        Delete(source, 1, 1);
      n := n + 1;
    until source[1] = '}';
    end;
  end;

initialization
  FontList := Nil;

finalization
  if Assigned(FontList) then
    FreeAndNil(FontList);

end.
