unit ascrypt;

interface

uses Classes, SysUtils;

{ Schwache Kodierung mit öffentlicher DecodeList-Tabelle }

function EncryptFile2Strings(FileName: String; dest: TStrings): Boolean;
  { verschlüsselt die Byte-Folge aus der angegebenen Datei in
    "8=>6"-Codierung und schreibt das Ergebnis in die Zeilen des
    dest-Stringarrays; das Ergebnis ist genau dann True, wenn die
    Konversion erfolgreich war. }

function DecryptStrings2File(source: TStrings; FileName: String): Boolean;
  { entschlüsselt die Zeilen-Strings des source-Stringarrays in
    "8=>6"-Codierung in eine Byte-Folge und schreibt diese in die
    angegebene Datei; das Ergebnis ist genau dann True, wenn die
    Zieldatei erfolgreich geschrieben werden konnte. }

{ Starke Kodierung mit geheimer EncodeList-Tabelle }

function Encode86String(source : String): String;
function Decode86String(source : String): String;

procedure ASCInit(id: String); // ermöglicht Initialisierung von außen !!!


implementation

{ Verschlüsselung in 6-Bit-Blöcken: 3 Byte <=> 24 Bit <=> 4 Crypt-Zeichen }

const DecodeList : String =   // öffentlich !!!
        '!0123456789?ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_';
      UUList     : String =   // sehr öffentlich !!!
        '+-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
      EncodeList : String =   // geheim, wird zur Laufzeit initialisiert !!
        '';      // '&84@B6CNdOc7' erzeugt die Standardtabelle "DecodeList"

type  TByteBlock  = Array of Byte;

function Bytes2String(bytes: TByteBlock; sec: Boolean = False): String;
  var n, i, pu : Integer;
      ccl      : String;
  begin
  // Übersetzungstabelle wählen:
  If sec then
    ccl := EncodeList
  else
    ccl := DecodeList;

  // Daten in Blöcken zu 3 Byte kodieren
  n := 0;
  Result := '';
  While n <= High(bytes) - 2 do begin
    pu := 0;
    For i := n + 2 downto n do
      pu := pu SHL 8 + bytes[i];
    For i := 0 to 3 do begin
      Result := Result + ccl[Succ(pu and $0000003F)];
      pu := pu SHR 6;
      end;
    n := n + 3;
    end;

  // Rest-Daten bearbeiten
  If n <= High(bytes) then begin
    pu := 0;
    For i := High(bytes) downto n do
      pu := pu SHL 8 + bytes[i];
    For i := 0 to Succ(High(bytes) - n) do begin
      Result := Result + ccl[Succ(pu and $0000003F)];
      pu := pu SHR 6;
      end;
    end;
  end;


function String2Bytes(cryptText: String; sec: Boolean = False): TByteBlock;
  var n, i, pu : Integer;
      ccl      : String;
  begin
  // Übersetzungstabelle wählen:
  If sec then
    ccl := EncodeList
  else
    ccl := DecodeList;

  // Alle Steuerzeichen (z.B. Zeilenvorschübe!) raus:
  For i := Length(cryptText) DownTo 1 do
    If cryptText[i] < ' ' then Delete(cryptText, i, 1);

  // Ausgabe-Array dimensionieren:
  n := (Length(cryptText) Div 4) * 3;
  If Length(cryptText) Mod 4 > 0 then       // kann niemals 1 sein !!!
    n := n + Pred(Length(cryptText) Mod 4);
  SetLength(Result, n);

  // CryptText in Blöcken zu 4 Zeichen dekodieren:
  n := 0;
  While Length(cryptText) >= 4 do begin
    pu := 0;
    For i := 4 downto 1 do
      pu := pu SHL 6 + Pred(Pos(cryptText[i], ccl));
    For i := n to n + 2 do begin
      Result[i] := Byte(pu);
      pu := pu SHR 8;
      end;
    n := n + 3;
    Delete(cryptText, 1, 4);
    end;

  // Rest des CryptTextes bearbeiten:
  If Length(cryptText) > 0 then begin
    pu := 0;
    For i := Length(cryptText) downto 1 do
      pu := pu SHL 6 + Pred(Pos(cryptText[i], ccl));
    For i := n to n + Length(cryptText) - 2 do begin
      Result[i] := Byte(pu);
      pu := pu SHR 8;
      end;
    end;
  end;


{=========== Datei-Konversion ======================= }

function EncryptFile2Strings(FileName: String; dest: TStrings): Boolean;
  var sf : File of Byte;    // source file
      buf: TByteBlock;
      oldFileMode,
      i  : Integer;
  begin
  oldFileMode := FileMode;
  FileMode    := fmOpenRead;
  AssignFile(sf, FileName);
  Try
    Reset(sf);
    SetLength(buf, 81);
    dest.Clear;
    Repeat
      BlockRead(sf, buf[0], 81, i);
      If i < 81 then SetLength(buf, i);
      dest.Add(bytes2String(buf));
    until i < 81;
    Result := True;
  finally
    buf := Nil;
    CloseFile(sf);
    FileMode := oldFileMode;
  end; { of try }
  end;


function DecryptStrings2File(source: TStrings; FileName: String): Boolean;
  var df : File of Byte;    // destination file
      buf: TByteBlock;
      oldFileMode,
      i  : Integer;
  begin
  oldFileMode := FileMode;
  FileMode    := fmOpenReadWrite + fmShareExclusive;
  AssignFile(df, FileName);
  Try
    Rewrite(df);
    For i := 0 to Pred(source.Count) do
      If Length(source.Strings[i]) > 0 then begin
        buf := String2Bytes(source.Strings[i]);
        BlockWrite(df, buf[0], Succ(High(buf)));
        end;
    buf    := Nil;
    Result := True;
  finally
    CloseFile(df);
    FileMode := oldFileMode;
  end; { of try }
  end;


{=========== String-Konversion ====================== }

function Encode86String(source : String): String;
  var buf : TByteBlock;
      i   : Integer;
  begin
  SetLength(buf, Length(source));
  For i := 0 to High(buf) do
    buf[i] := Byte(source[Succ(i)]);
  Result := Bytes2String(buf, True);
  end;


function Decode86String(source : String): String;
  var buf : TByteBlock;
      i   : Integer;
  begin
  buf := String2Bytes(source, True);
  SetLength(Result, Succ(High(buf)));
  For i := 1 to Succ(High(buf)) do
    Result[i] := Char(buf[Pred(i)]);
  end;


{======== Initialisierung der geheimen Übersetzungstabelle =============}

procedure InitTable(cc : String);
  { Initialisiert die Übersetzungstabelle EncodeList; der String cc muss
    beim Aufruf der Funktion die Information über den Inhalt der Über-
    setzungstabelle in verschlüsselter Form enthalten. Dabei haben die
    Zeichen des beschreibenden Strings folgende Bedeutung:
      - jeweils 2 Zeichen bilden einen Block:
              1. Zeichen = (Succ^d)(Startzeichen der Sequenz)
              2. Zeichen = Char(Ord("2") + d +
                                Anzahl der Zeichen in dieser Sequenz)
      - das Displacement d hat den Startwert 5, verringert sich von
        Block zu Block um 1, bis es den Wert 2 erreicht hat, danach
        steigt es wieder an bis 5, usw.usw.                           }

  var Result,
      s     : String;
      c     : Char;
      down  : Boolean;
      d, n,
      i     : Integer;
  begin
  // Initialisierung
  s    := cc;
  d    := 5;
  down := True;
  Result := '';

  // Rekonstruktion der EncodeList-Tabelle
  While Length(s) > 0 do begin
    c := Chr(Ord(s[1]) - d);
    n := Ord(s[2]) - (50 + d);
    For i := 1 to n do begin
      Result := Result + c;
      Inc(c);
      end;
    Delete(s, 1, 2);
    If down then Dec(d) else Inc(d);
    If (d = 5) or (d = 2) then
      down := Not down;
    end;

  // Ergebnis abspeichern
  EncodeList := Result;
  end;


procedure ASCInit(id: String);
  { entschlüsselt den Initialisierungs-String und ruft InitTable auf,
    um die geheime EncodeList-Tabelle zu rekonstruieren              }

  function Decode(source: String): String;
    var buf : TByteBlock;
        i   : Integer;
    begin
    buf := String2Bytes(source, False);    // schwache Kodierung !
    SetLength(Result, Succ(High(buf)));
    For i := 1 to Succ(High(buf)) do
      Result[i] := Char(buf[Pred(i)]);
    end;

  var s : String;
      i : Integer;
  begin
  s := id;
  For i := 1 to 3 do
    s := Decode(s);
  // Jetzt muss s = '(CQDx>C@3?_9@;' sein !
  InitTable(s);
  end;

{
initialization
  ASCInit('MFHG6VXEMdoJ5ZJEfRrG4JbIWRYAo3nHh41'); // Auslagern in andere Unit!
}
end.
