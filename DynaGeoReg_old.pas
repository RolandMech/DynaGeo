//--------------------------------------------------------------------------
//  ÜberprüfungsObjekt "TAffin" DynaGeo-Shareware-Registrierung
//  (c) 2001 by Michael Moosbauer
//  exclusiv für Roland Mechling
//
//  Einsatz:

//    0. Beim Erzeugen des Formulars ein Objekt "DynaGeoReg" erzeugen,
//       also z.B.: DynaGeoReg1:=TAffin.Create;
//
//    1. Nach dem Einlesen der Regdaten (kompletter Dateiinhalt) die Funktion
//       "init" aufrufen. Diese parst Name etc. heraus, liefert diese zurück
//       und speichert alle Daten in dem Objekt. Es findet noch keinerlei
//       Auswertung statt (wichtig zur Verwirrung).
//
//    2. Irgendwo, möglichst zwischen anderen rechenintensiven
//       Initialisierungen, "check1" bis "check3" aufrufen. Die Daten
//       werden ausgewertet, aber kein Ergebnis zurückgegeben.
//       Möglichst viele andere Berechnungen vor, nach und zwischen(!) diesen
//       Prozeduren.
//
//       Diese und die param- Prozeduren sollten keinesfalls diese Namen
//       tragen! Ansonsten machen sie sich verdächtig! Ich habe sie daher
//       nach geometrischen Figuren benannt.
//
//    3. Nun kann der Erfolg der Registrierung mit der Funktion
//       "isregged" überprüft werden. Dies sollte offensichtliche Merkmale
//       der (Un-)Registrierung schalten. Cracker werden diese Funktion
//       patchen, daher sollte diese Funktion die "Optik" steuern.
//       Der Cracker muß den Eindruck bekommen, daß nach Patchen dieser
//       Funktion das Programm geknackt ist.
//
//    4. Irgendwann später (im Programmlauf) mit den Funktionen "param1/2"
//       einige globale Variable setzen. Die Werte werden aus den
//       Lizenzdaten gewonnen. Wichtig: NUR aufrufen, wenn das Programm
//       meint, registriert zu sein ("isregged" liefert true).
//
//       Der Witz: Während die "Unregistriert"-Optik gezeigt wird (und nur
//       dann, überprüfen!) belegt man einige der globalen Variable mit den
//       richtigen Werten vor.
//
//       Es gibt also zwei Möglichkeiten, die richtigen Werte in die
//       Variable zu bekommen:
//         1. Durch Ausführen des "Unregistriert"-Codes (Nag-Screen o.a.)
//            -> einige Werte stimmen, oder
//         2. Mit korrekten Lizenzdaten durch Aufruf von "Param".
//            -> alle Werte stimmen.
//
//    5. Noch später werden zufallsgesteuert ab und zu obige Parameterwerte
//       überprüft. Sollten die Werte falsch sein, treten nichtdeterministische
//       Programmfehler auf (z.B. Koordinaten zuerst mit den "Sollwerten" und
//       dann mit der globalen Variable XORen, HALTS, NullpointerExceptions
//       o.ä.). Somit laufen gecrackte Versionen nicht mehr richtig.
//
//       Besonders gut ist es, wenn die Parameterüberprüfung keinen
//       unmittelbaren Effekt hat, sondern Daten so verändert, daß
//       es später beim normalen Ablauf zum Crash kommt.
//
//       (Beispiel: Ein Objekt, z.B. einen Punkt, auf NIL setzen (hart löschen).
//       Die NullPointerException kommt dann erst beim nächsten Zugriff.)
//
//       In Funktionen, die normalerweise gesperrt sind, werden bevorzugt
//       die Variablen überprüft, die NUR durch richtige Lizenzdaten
//       korrekt gesetzt werden, andere Funktionen durch die anderen
//       (damit sie auch im unregistrierten Falle korrekt arbeiten).
//
//       GANZ WICHTIG: Offensichtliches muß durch "isregged" gesteuert
//       werden, damit ein Cracker nach dem Patchen dieser Funktion
//       glaubt, am Ziel zu sein.
//       Die Parameterwerte "vergällen" dann subtil die weitere
//       Nutzung des Programms. Es macht Sinn, eine Zeitverzögerung von
//       einigen Minuten vor der ersten Fehlfunktion einzubauen, damit
//       ein Test des Programms durch den Cracker positiv ausfällt.
//       Außerdem sollten die Fehlfunktionen nicht auf Absicht schließen
//       lassen, sondern den Eindruck erwecken, das Programm sei durch
//       den Patch zerstört worden.
//
//    6. Die durch die Kontroll-Variablen gesteuerten Schadensroutinen
//       wurden in der Version 3.0 deaktiviert, weil sie offenbar mehr
//       Schaden anrichteten als sie verhinderten! Speziell auf langsamen
//       WinME-Systemen scheinen diese Schadensroutinen zugeschlagen zu
//       haben, obwohl eine gültige DynaGeo-Lizenz vorlag!
//
//--------------------------------------------------------------------------


unit DynaGeoReg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Integers;

type
  TAffin = class(TObject)

  private
    { Private declarations }
    FInputString          : string;
    FOutputString         : string;
    FHexMode              : Boolean;
    FKeyString,
    FName, FAddr1, FAddr2 : string;
    CSum,
    C1, C2, C3, C4, notes : string;
    pm1, pm2, pm3, pm4,
    pm5, pm6, pm7, pm8    : char;
    OK                    : Boolean;
    function  EncryptionEngine (Src:String; Key : String):String;
    procedure cmp(var rand,key,simoutput: array of byte);
    function  pot2(n:integer):integer;
    procedure Execute;
    procedure Execute128;
    function  LicenseTypeValid: Boolean;

  protected
    { Protected declarations }

  public
    { Public declarations }
    Constructor Create;
    procedure init(    rawdata           :string;
                   var Name, Addr1, Addr2:String );
    procedure gerade;                          // check1
    procedure strecke;                         // check2
    procedure punkt;                           // check3

    procedure dreieck(var p1, p2, p3, p4: char);  // param1
    procedure polygon(var p5, p6, p7, p8: char);  // param2
    function  isregged: boolean;

  end;



implementation

Uses Tables, GlobVars;

//--------------------------------------------------------------------------
// Die Geheimnis-Datenbasis
//--------------------------------------------------------------------------

var
st0: string = #$50#$4B#$03#$04#$14#$00#$02#$00#$08#$00#$36#$19;
st1: string = #$74#$61#$6C#$6C#$2E#$74#$78;
st2: string = #$45#$ED#$4F#$21#$30#$EA#$42#$24#$C7#$1A#$F9#$C9#$AF#$61#$CD#$AD;
st3: string = #$94#$56#$68#$4A#$AC#$DC#$CB#$82#$10#$99#$5A#$12#$44#$A3#$83;
st4: string = #$43#$9C#$70#$40#$B0#$7D#$6F#$BA#$8C#$B1#$A3#$2F#$F4#$C6#$1B#$0C#$2D;
stw: string;

//--------------------------------------------------------------------------
// Hilfsprozeduren zur Stringverarbeitung
//--------------------------------------------------------------------------

// Vom Anfang eines Strings bis zu einem <CR><LF> lesen,
// den ersten Teil zurückliefern und den String entsprechend kürzen.

function readline(var s:string):string;
  var i : integer;
  begin
  i := 1;
  result := '';
  if length(s) < 2 then exit;

  while i+1 <= length(s)do begin
    i:=i+1;
    if (s[i-1]+s[i]=#13#10) then break;
    end;

  if (s[i-1]+s[i]=#13#10) then begin
    result := copy(s, 1, i-2);
    s := copy(s, i+1, length(s)-i);
    end;
  end;

//---------------------------------------------------------------------------
// Hilfs-Funktion zur Vermeidung leerer Schlüssel
//---------------------------------------------------------------------------

// Generiert aus dem (nichtleeren) String s einen Schlüssel der Länge len;
// ist s = '', dann wird ein ebenfalls leerer String zurückgegeben.

function CopyCat(s : String; start, len : Integer): String;
  var pu : String;
  begin
  If Length(s) > 0 then begin
    pu := s;
    If Length(pu) < start then
      While Length(pu) < start + len do
        pu := pu + s;
    Result := Copy(pu, start, len);
    end
  else
    Result := '';
  end;

//--------------------------------------------------------------------------
// DynaGeoReg-Objekt erzeugen
//--------------------------------------------------------------------------

Constructor TAffin.Create;
  var i      : Integer;
      s1, s2 : String;
  begin
  stw:='';
  s1 := st3 + st2 + st4 + st0 + st1;
  s2 := st4 + st2 + st1 + st3 + st0;
  for i:=0 to 25 do begin
    FInputString := copy(s1, 5+i, 16);
    FKeyString   := copy(s2, 18, 10);
    execute128;
    stw := stw + FOutputString;
    end;
  end;

//--------------------------------------------------------------------------
// Registrierdaten hier speichern
//--------------------------------------------------------------------------

procedure TAffin.init(rawdata:string; var Name,Addr1,Addr2:String);
  var s : string;
  begin
  OK := False;
  s  := rawdata;
  Name  := readline(s);
  Addr1 := readline(s);
  Addr2 := readline(s);

  FName  :=Name;
  FAddr1 :=Addr1;
  FAddr2 :=Addr2;
  Csum   :=s;
  end;


//--------------------------------------------------------------------------
// Prüfen der Registrierdaten (alle drei in richtiger Reihenfolge aufrufen!)
//--------------------------------------------------------------------------


procedure TAffin.gerade;                          // check1
  var i : integer;

  begin
  OK := False;
  c1 := '';
  c2 := '';
  c3 := '';
  c4 := '';

// Generiere Kontrollwerte...

  for i := 0 to 5 do begin
    Finputstring := Fname;
    Fkeystring   := copy(stw, 7+i*17, 16);
    Execute128;
    c2 := c2 + Foutputstring;
    end;
  c2:=copy(c2, 1, 60);

  for i := 0 to 5 do begin
    Finputstring := Faddr1;
    Fkeystring   := copy(stw, 3+i*13, 16);
    Execute128;
    c3 := c3 + Foutputstring;
    end;
  c3:=copy(c3, 1, 60);

  for i:=0 to 5 do begin
    Finputstring := Faddr2;
    FKeyString   := copy(stw, 11+i*5, 16);
    Execute128;
    c4 := c4 + Foutputstring;
    end;
  c4:=copy(c4, 1, 60);

  FKeyString:='';
end;

//--------------------------------------------------------------------------

procedure TAffin.strecke;                          // check2
  var st      : string;
      I_X, I_N,
      I_E     : TInteger;
      i, k    : integer;
      buf     : TDynByteArray;
      correct : Byte;
  begin
  If Length(CSum) < 50 then Exit;

  OK := False;
  FHexmode := false;

// Auseinanderbauen Zweite Stufe:
  I_N := TInteger.Create;
  SetLength(Buf, 172);
  Move(table[2, 163], Buf[0], 172);
  I_N.SetDigits(Buf[0], 172);
  Correct := table[1, 363];  { = $B5 }
  for i := 0 to I_N.ByteSize-1 do begin
    I_N.Byte[i] := I_N.Byte[i] XOR Correct;
    Correct := Byte(Integer(Correct) + table[1, 78]); { + $13 }
    end;

  I_E := TInteger.Create;
  SetLength(Buf, 17);
  Move(table[3, 162], Buf[0], 17);
  I_E.SetDigits(Buf[0], 17);
  Correct := table[2, 191];  { = $B5 }
  for i := 0 to I_E.ByteSize-1 do begin
    I_E.Byte[i] := I_E.Byte[i] XOR Correct;
    Correct := Byte(Integer(Correct) + table[0,105]); { + $13 }
    end;

  I_X := TInteger.Create;

  st := Copy(CSum, 2, Ord(CSum[1]));
  CSum := Copy(CSum, 1 + 1 + Length(st), Length(CSum));
  I_X.SetDigits(st[1], Length(st));
  ReAdjustPtCoords(I_X,I_E,I_N);
  SetLength(Buf, 0);
  SetLength(st, I_X.GetDigits(Buf));
  For I:=1 to Length(buf) do
    ST[i] := chr(Buf[I-1]);
  c1 := st;

  st := Copy(CSum, 2, Ord(CSum[1]));
  CSum := Copy(CSum, 1 + 1 + Length(st), Length(CSum));
  I_X.SetDigits(st[1], Length(st));
  ReAdjustPtCoords(I_X,I_E,I_N);
  SetLength(Buf, 0);
  SetLength(st, I_X.GetDigits(Buf));
  For I:=1 to Length(buf) do
    st[i] := chr(Buf[I-1]);
  c1 := c1 + st;

  I_X.Free;
  I_N.Free;
  I_E.Free;

// Noch nicht nötig: Magic Number-Auswertung:
// Bei Bedarf unkommentieren und passend auswerten
// (z.B. ähnlich wie die Parameter unten!)

//  Magic Number B4: #$56#$41#$F7#$EE - synchron zur Deklaration halten !
{
  FInputString:=copy(c1,1,5);
  FKeyString:=CopyCat(Fname,4,4);
  Execute;
  if FOutputString = #$56#$41#$F7#$EE then showmessage('B4 OK');
}
//  Magic Number B3: #$EB#$80#$DB#$86 - synchron zur Deklaration halten !
{
  FInputString:=copy(c1,6,5);
  FKeyString:=CopyCat(Faddr2,2,4);
  Execute;
  if FOutputString = #$EB#$80#$DB#$86 then showmessage('B3 OK');
}

//  Die folgende Magic Number wird zum Transport der Lizenzdaten benutzt:
//  Magic Number B2: #$64#$ED#$1C#$B2  (ursprünglicher Wert)

  FInputString := copy(c1, 11, 5);
  FKeyString   := CopyCat(Faddr1, 3, 4);
  Execute;
  notes := FOutputString;

// if FOutputString = #$64#$ED#$1C#$B2 then showmessage('B2 OK');

//  Magic Number B1: #$5F#$DC#$DF#$99 - synchron zur Deklaration halten !
{
  FInputString:=copy(c1,16,5);
  FKeyString:=CopyCat(Fname,2,4);
  Execute;
  if FOutputString = #$5F#$DC#$DF#$99 then showmessage('B1 OK');
}

// Inhalt der ersten Stufe:
  k := 0;
  for i := 1 to length(Faddr2) do
    k := k + ord(Faddr2[i]);
  k:=k mod 69;
  FInputString := copy(c1, 21, 209);
  FKeyString   := copy(stw, k+50, 99);
  Execute;
  c1 := FOutputString;
  end;

//--------------------------------------------------------------------------

procedure TAffin.punkt;                          // check3
  const g : Integer = 0;

  begin
  OK:=False;
// Erste Stufe:

// Nochmals Magic Numbers, die noch nicht ausgewertet werden:
//  Magic Number A1: #$6E#$95#$F6#$BD
{
  FInputString:=copy(c1,1,5);
  FKeyString:=CopyCat(Fname,3,4);
  Execute;
  if FOutputString = #$6E#$95#$F6#$BD then showmessage('A1 OK');
}
//  Magic Number A2: #$F5#$A9#$27#$FE
{
  FInputString:=copy(c1,6,5);
  FKeyString:=CopyCat(FAddr1,4,4);
  Execute;
  if FOutputString = #$F5#$A9#$27#$FE then showmessage('A2 OK');
}
//  Magic Number A3: #$98#$30#$F0#$E7
{
  FInputString:=copy(c1,11,5);
  FKeyString:=CopyCat(Faddr2,1,4);
  Execute;
  if FOutputString = #$98#$30#$F0#$E7 then showmessage('A3 OK');
}

// Folgende Magic Numbers verwenden wir als Parameter-Lieferanten:
//  Magic Number A4: #$6B#$AD#$F8#$3C
  FInputString := copy(c1, 77, 5);
  FKeyString   := CopyCat(Fname, 6, 4);
  Execute;
  if length(FOutputString)>= 4 then begin
    pm1:=FOutputString[1];
    pm2:=FOutputString[2];
    pm3:=FOutputString[3];
    pm4:=FOutputString[4];
    end;

//  Magic Number A5: #$A3#$D6#$39#$A1
  FInputString := copy(c1, 82, 5);
  FKeyString   := CopyCat(Faddr1, 5, 4);
  Execute;
  if length(FOutputString)>= 4 then begin
    pm5:=FOutputString[1];
    pm6:=FOutputString[2];
    pm7:=FOutputString[3];
    pm8:=FOutputString[4];
    end;

// Benutzerdaten:

  FInputString:=copy(c1,16,61);
  FKeyString:=Fname;
  Execute;
  if FOutputString = C3 then Inc(g); // else showmessage ('C3 false');

  FInputString:=copy(c1,87,61);
  FKeyString:=Faddr1;
  Execute;
  if FOutputString = C4 then Inc(g); // else showmessage ('C4 false');

  FInputString:=copy(c1,148,61);
  FKeyString:=Faddr2;
  Execute;
  if FOutputString = C2 then Inc(g); // else showmessage ('C2 false');

{ Notes interpretieren }
  if LicenseTypeValid then Inc(g);  // else showmessage ('Invalid license');

  Ok := (g = 4);
  end;

//--------------------------------------------------------------------------
// Rückgabefunktionen (Registriert, Parameter)
//--------------------------------------------------------------------------

function TAffin.isregged:boolean;
  begin
  Result:=OK;
// Result:=true;  // Unkommentieren Sie diese Zeile, um  eine
                  // gecrackte Version zu simulieren!
  end;

//--------------------------------------------------------------------------

procedure  TAffin.dreieck(var p1,p2,p3,p4 : char);
  begin
  p1:=pm1;p2:=pm2;p3:=pm3;p4:=pm4;
  end;

//--------------------------------------------------------------------------

procedure  TAffin.polygon(var p5,p6,p7,p8 : char);
  begin
  p5:=pm5;p6:=pm6;p7:=pm7;p8:=pm8;
  end;

//--------------------------------------------------------------------------
// Diverses Kryptozeugs
//--------------------------------------------------------------------------

Function TAffin.LicenseTypeValid: Boolean;
  var day, month, year : Integer;
  begin
  If Length(Notes) = 4 then begin
    RegLicType := Ord(Notes[1]);
    If Notes[2] = 'n' then begin
      RegLicEnd := 3.75;
      Result := True;
      end
    else begin
      day   := 1;
      month := Ord(Notes[3]);
      year  := Ord(Notes[4]) Mod 100 + 2000;
      If month < 12 then
        Inc(month)
      else begin
        month := 1;
        Inc(year);
        end;
      RegLicEnd := EncodeDate(year, month, day);
      Result := Now <= RegLicEnd;
      end;
    end
  else
    Result := False;
  end;

Function TAffin.EncryptionEngine (Src:String; Key:String):string;

// Hinweis: Diese Version kann nur ENTschlüsseln.

  var                               // XOR mit Offset-Verschlüsselung
                                    // Auf hinreichend lange Schlüssel
                                    // achten!!
   KeyLen      :Integer;
   KeyPos      :Integer;
   offset      :Integer;
   dest        :string;
   SrcPos      :Integer;
   SrcAsc      :Integer;
   TmpSrcAsc   :Integer;
   Range       :Integer;

  begin
  dest := '';
  if Length(Key) > 0 then begin
    KeyLen :=Length(Key);
    KeyPos := 0;
    Range  := 256;
    if FHexMode then begin
      offset := StrToIntDef('$'+ copy(src,1,2),random(range));
      SrcPos := 3;
      end
    else begin
      offset := ord(src[1]);
      SrcPos := 2;
      end;
    repeat
      if FHexMode then
        SrcAsc:=StrToIntDef('$'+ copy(src,SrcPos,2),random(range))
      else SrcAsc:=ord(src[srcpos]);

      if KeyPos < KeyLen Then
        KeyPos := KeyPos + 1
      else KeyPos :=1;
      TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= offset then
        TmpSrcAsc := 256 + TmpSrcAsc - offset
      else
        TmpSrcAsc := TmpSrcAsc - offset;
      dest := dest + chr(TmpSrcAsc);
      offset:=offset+SrcAsc;
      if FHexMode then
        SrcPos:=SrcPos + 2
      else
        SrcPos:=SrcPos + 1;
    until SrcPos > Length(Src);
    end;
  Result := dest;
  end;

//--------------------------------------------------------------------------

procedure TAffin.Execute;           // Verschlüsselung ausführen
  begin
  if length(FInputString)=0 then
    FOutputString:=''
  else
    FOutputString:=EncryptionEngine(FInputString,FKeyString);
  end;

//--------------------------------------------------------------------------

function TAffin.pot2(n:integer):integer;       // 2^n umständlich
  var t, i: integer;
  begin
  t := 1;
  for i := 1 to n do
    t := t * 2;
  result := t;
  end;

//--------------------------------------------------------------------------

procedure TAffin.cmp(var rand,key,simoutput: array of byte);
                                                   // Der Comp128-Algorithmus
var
 x:   array[0..31] of byte;
 bit: array[0..127] of byte;
 i, j, k, l, m, n, y, z, next_bit: integer;
begin

	// ( Load RAND into last 16 bytes of input )
	for i:=16 to 31 do
		x[i] := rand[i-16];

	// ( Loop eight times )
	for i:=1 to 8 do begin
		// ( Load key into first 16 bytes of input )
		for j:=0 to 15 do
			x[j] := key[j];
		// ( Perform substitutions )
		for j:=0 to 4 do
			for k:=0 to pot2(j)-1 do
				for l:=0 to (pot2(4-j))-1 do
                                     begin
					m := l + k*(pot2(5-j));
					n := m + (pot2(4-j));
					y := (x[m]+2*x[n]) mod (pot2(9-j));
					z := (2*x[m]+x[n]) mod (pot2(9-j));
					x[m] := table[j][y];
					x[n] := table[j][z];
				     end;
		// ( Form bits from bytes )
		for j:=0 to 31 do
			for k:=0 to 3 do
				bit[4*j+k] := (x[j] and pot2(3-k) ) div pot2(3-k);
		// ( Permutation but not on the last loop )
		if (i < 8) then
			for j:=0 to 15 do begin
				x[j+16] := 0;
				for k:=0 to 7 do begin
					next_bit := ((8*j + k)*17) mod 128;
					x[j+16] := x[j+16] or (bit[next_bit]* pot2(7-k));
				end;  //k
			end; //j
	end; //i

	(*
	 * ( At this stage the vector x[] consists of 32 nibbles.
	 *   The first 8 of these are taken as the output SRES. )
	 *)

	(* The remainder of the code is not given explicitly in the
	 * standard, but was derived by reverse-engineering.
	 *)

	for i:=0 to 3 do
		simoutput[i] := ((x[2*i]*2*2*2*2) mod 256) or x[2*i+1];
	for i:=0 to 5 do
		simoutput[4+i] := ((x[2*i+18]*2*2*2*2*2*2) mod 256) or ((x[2*i+18+1]*2*2) mod 256)
				   or (x[2*i+18+2] div (2*2));
	simoutput[4+6] := ((x[2*6+18]*2*2*2*2*2*2) mod 256) or ((x[2*6+18+1]*2*2) mod 256);
	simoutput[4+7] := 0;
end;

//--------------------------------------------------------------------------

procedure TAffin.Execute128;  // Comp128-Alg. ausführen
  var rand, key : array[0..15] of byte;    { 16 Byte }
      simoutput : array[0..11] of byte;    { 12 Byte }
      i : integer;
  begin
  FInputString:=copy(FInputstring+'0123456789abcdef',1,16);
  for i:=0 to 15 do
    rand[i] := Ord(FInputString[i+1]);

  FKeyString  :=copy(FKeyString+'0123456789abcdef',1,16);
  for i:=0 to 15 do
    key[i] := Ord(FKeyString[i+1]);

  cmp(key, rand, simoutput);

  FOutputString:='';
  for i:=0 to 10 do
    FOutputString:=FOutputString + Chr(simoutput[i]);
  end;

//--------------------------------------------------------------------------

end.


