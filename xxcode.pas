unit xxcode;

{
  XX-CODE:  (c) Roland Mechling,  2004,  Vers. 1.0

  Last change : 07.11.2004
  =================================================

  Diese Unit enthält eine Realisierung einer UU-Codierung. Allen diesen
  Codierungen ist gemeinsam, dass sie Gruppen von 3 Byte in 4 druckbaren
  Zeichen kodieren. Dazu wird stets ein Alphabet von 64 = 2^6 Zeichen
  benutzt:  3 Byte <=> 24 Bit <=> 4 Crypt-Zeichen zu je 6 Bit.

  Das hier verwendete Alphabet (siehe lokale Variable ccl) realisiert
  die XX-Kodierung. Deren Vorteil ist es, dass der verschlüsselte Text
  keinerlei HTML-Sonderzeichen enthält. Der implementierte Algorithmus
  funktioniert jedoch mit jedem beliebigen Alphabet aus paarweise
  verschiedenen Zeichen.

  Die Unit entstand aus Ärger über die schlecht gepflegte und miserabel
  dokumentierte UU-XX-Code-Implementierung in den Indy-Komponenten. Für
  die Codierung großer Datenmengen taugen die entsprechenden Indy-
  Komponenten nicht, weil die kodierten Strings höchstens die Länge 64
  haben dürfen - was aber nirgends steht. Der dortige Algorithmus ist
  auch nicht einfach auf längere Strings erweiterbar - zumindest habe
  ich das nicht geschafft.

  Einer der Gründe für diese Schwierigkeiten ist darin zu sehen, dass
  die Indy-Autoren das Problem einer unvollständigen 3-Byte-Gruppe
  (am Ende der zu verschlüsselnden Daten) bzw. 4-Char-Gruppe (am Ende
  der verschlüsselten Daten) durch ein zusätzliches Zähl-Byte lösen
  wollen, das die Information über diese "überzähligen" Zeichen trägt
  und dem gesamten String vorangestellt wird. Implemetiert wurde es
  als der *Index* des ersten überzähligen Bytes - was natürlich
  spätestens bei Strings länger als 255 Zeichen schief gehen muss,
  bei UU-basierten Codierungen aber schon bei mehr als 64 Zeichen.

  Der hier verwendete Algorithmus verzichtet auf diese Information,
  weil sie redundant ist. Wieviele Zeichen der codierte String lang
  sein muss, ergibt sich eindeutig aus der Anzahl der zu verschlüsselnden
  Bytes. Und umgekehrt gehört zu jeder möglichen(!) Länge des codierten
  Strings eindeutig die Anzahl der in diesem String verschlüsselten
  Bytes. Genauer: ist n die Anzahl der zu kodierenden Bytes und t die
  Länge des kodierten Strings, dann gilt (mit möglichst großem k) :

       n = k*3 + r      <=>      t = k*4 + s

  wobei (r;s) eines der drei Paare [(0;0), (1;2), (2;3) ] sein muss.
  Die Länge des kodierten Strings kann also *nie* den Viererrest 1
  haben! Damit ist jede Vieldeutigkeit ausgeräumt, und das explizite
  Abspeichern von Informationen über den "überzähligen Rest" ist
  entbehrlich. Die folgende Bit-Grafik verdeutlicht die Situation:

   3 Byte  :     a a a a a a a a b b b b b b b b c c c c c c c c
   4 Chars :     g g g g g g h h h h h h i i i i i i j j j j j j

  Die vorliegende Implementierung macht hemmungslosen Gebrauch von
  langen Strings - dafür haben wir sie schließlich! So lässt sich
  eine Datei von (z.B.) mehreren 100 kB in einem einzigen(!) String
  verschlüsseln.

  ===================================================================
}


interface

uses Classes, SysUtils;

function EncodeXXString(source : String): String;
function DecodeXXString(source : String): String;
  { Diese beiden Funktionen ver- bzw. entschlüsseln die übergebenen
    Strings und geben das Resultat der Transformation als
    Funktions-Ergebnis zurück. }

function EncryptFile2Strings(FileName: String; dest: TStrings): Boolean;
  { verschlüsselt die Byte-Folge aus der angegebenen Datei in
    "XX"-Codierung und schreibt das Ergebnis in die Zeilen der
    dest-String-Liste; das Ergebnis ist genau dann True, wenn die
    Konversion erfolgreich war. }

function DecryptStrings2File(source: TStrings; FileName: String): Boolean;
  { entschlüsselt die Zeilen-Strings der source-String-Liste in
    "XX"-Codierung in eine Byte-Folge und schreibt diese in die
    angegebene Datei; das Ergebnis ist genau dann True, wenn die
    Zieldatei erfolgreich geschrieben werden konnte. }

function EncryptStream2XXString(MS: TStream; var s : String) : Boolean;
  { verschlüsselt die Byte-Folge aus dem angegebenen Stream in
    "XX"-Codierung und schreibt das Ergebnis in den String s;
    das Ergebnis ist genau dann True, wenn die Konversion
    erfolgreich war. }

function DecryptXXString2Stream(s: String; MS: TStream) : Boolean;
  { entschlüsselt den "XX"-codierten String s in eine Byte-Folge
    und schreibt diese in den übergebenen Stream; das Ergebnis
    ist genau dann True, wenn die Konversion erfolgreich war. }



implementation

Type  TByteBlock  = Array of Byte;

const ccl : String =               // Crypted Character List
       '+-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
var   lut : Array[0..255] of Byte; // Look-Up-Table ( invers zu ccl )
       //  wird bei der Initialisierung der Unit mit Werten gefüllt;

function Bytes2String(bytes: TByteBlock): String;
  var n, i, pu : Integer;
  begin
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
    If n Mod 57 = 27 then
      Result := Result + #13#10;
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


function String2Bytes(cryptText: String): TByteBlock;
  var msi,    // Maximal string index
      bc,     // Block Count
      a,      // Additional
      pu,     // Data Buffer
      n, i : Integer;
  begin
  // Alle Steuerzeichen (z.B. Zeilenvorschübe!) und Leerzeichen raus:
  For i := Length(cryptText) DownTo 1 do
    If cryptText[i] <= ' ' then Delete(cryptText, i, 1);

  // Ausgabe-Array dimensionieren:
  msi := Length(cryptText);
  bc := msi Div 4;
  If msi Mod 4 > 0 then       // kann niemals 1 sein !!!
    a := Pred(msi Mod 4)
  else
    a := 0;
  n := bc * 3 + a;
  SetLength(Result, n);

  // CryptText in Blöcken zu 4 Zeichen dekodieren:
  n := 0;
  a := 4;
  While a <= bc * 4 do begin
    pu := 0;
    For i := a downto a - 3 do
      pu := pu SHL 6 + lut[Ord(cryptText[i])];
    For i := n to n + 2 do begin
      Result[i] := Byte(pu);
      pu := pu SHR 8;
      end;
    n := n + 3;
    a := a + 4;
    end;

  // Rest des CryptTextes bearbeiten:
  Delete(cryptText, 1, a - 4);
  If Length(cryptText) > 0 then begin
    pu := 0;
    For i := Length(cryptText) downto 1 do
      pu := pu SHL 6 + lut[Ord(cryptText[i])];
    For i := n to n + Length(cryptText) - 2 do begin
      Result[i] := Byte(pu);
      pu := pu SHR 8;
      end;
    end;
  end;


{=========== String-Konversion ====================== }

function EncodeXXString(source : String): String;
  var buf : TByteBlock;
      i   : Integer;
  begin
  SetLength(buf, Length(source));
  For i := 0 to High(buf) do
    buf[i] := Byte(source[Succ(i)]);
  Result := Bytes2String(buf);
  buf := Nil;
  end;


function DecodeXXString(source : String): String;
  var buf : TByteBlock;
      i   : Integer;
  begin
  buf := String2Bytes(source);
  SetLength(Result, Succ(High(buf)));
  For i := 1 to Succ(High(buf)) do
    Result[i] := Char(buf[Pred(i)]);
  buf := Nil;
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
    buf    := Nil;
    Result := True;
  finally
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


function EncryptStream2XXString(MS: TStream; var s : String): Boolean;
  var outlen : Integer;
      buf    : TByteBlock;
  begin
  If MS.Size > 0 then
    If MS.Size < (MaxInt Div 4) * 3 - 2 then begin
      outlen := ((MS.Size + 2) Div 3) * 4;
      SetLength(s, outlen);
      SetLength(buf, MS.Size);
      MS.Position := 0;
      MS.Read(buf[0], MS.Size);
      s := Bytes2String(buf);
      buf := Nil;
      Result := True;
      end
    else
      Result := False
  else begin
    s := '';
    Result := True;
    end;
  end;


function DecryptXXString2Stream(s: String; MS: TStream): Boolean;
  var buf : TByteBlock;
  begin
  MS.Position := 0;
  MS.Size     := 0;
  buf := String2Bytes(s);
  MS.Write(buf[0], Succ(High(buf)));
  Result := True;
  end;


{========= Look-Up-Table laden =============================}

procedure LoadLUT;
  var i : Integer;
  begin
  For i := 0 to 255 do
    lut[i] := 255;
  For i := 1 to Length(ccl) do
    lut[Ord(ccl[i])] := i - 1;
  end;

initialization
  LoadLUT;

finalization

end.
