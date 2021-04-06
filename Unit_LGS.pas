unit Unit_LGS;

interface

{
   Gegeben sei das folgende Gleichungssystem aus m linearen Gleichungen
   in den n Unbekannten x1, x2, x3, ..... , xn:

      a11 x1 + a12 x2 + a13 x3 + ..... + a1n xn = y1
      a21 x1 + a22 x2 + a23 x3 + ..... + a2n xn = y2
      a31 x1 + a32 x2 + a33 x3 + ..... + a3n xn = y3
      a41 x1 + a42 x2 + a43 x3 + ..... + a4n xn = y4
       |        |        |                |       |
      am1 x1 + am2 x2 + am3 x3 + ..... + amn xn = ym

   Ein TLGS-Objekt stellt intern ein Koeffizienten-Feld mit (m+1) Zeilen
   und (n+1) Spalten zur Verfügung:

      k00   k01   k02   k03 .......... k0n
      k10   k11   k12   k13 .......... k1n
      k20   k21   k22   k23 .......... k2n
      k30   k31   k32   k33 .......... k3n
       |     |     |     |              |
      km0   km1   km2   km3 .......... kmn

   Damit ein TLGS-Objekt für ein gegebenes LGS einen aussichtsreichen
   Lösungsversuch starten kann, muss das LGS korrekt ins Koeffizienten-
   feld eingetragen werden:

      1.)  apq ==> kpq für p = 1...m, q = 1...n
      2.)  yp  ==> kp0 für p = 1...m

   Dies kann zeilenweise erledigt werden, durch Aufrufe der Methode
   "SetEquation(p, eq)", wobei das Array eq mit den Koeffizienten der
   Gleichung vom aufrufenden Programm zur Verfügung gestellt werden
   muss (Variablen-Parameter!).

   Der Lösungsversuch wird durch einen Aufruf der Methode "Diagonalize"
   gestartet. Intern wird ein Gauß-Algorithmus mit Spalten-Pivotisierung
   verwendet. Die errechneten Lösungsinformationen werden in die erste
   Zeile ( also [k00 k01 k02 k03 ......k0n] ) des Koeffizienten-Arrays
   eingetragen und können mit "GetEquation(0, eq)" ausgelesen werden,
   wobei auch hier wieder eq vom aufrufenden Programm zur Verfügung
   gestellt werden muss (Variablen-Parameter).
   Dabei können 3 Fälle auftreten:

      1.) Es gibt keine Lösung:
          Dann wird in k00 der Wert "0" geschrieben, die folgenden
          Felder tragen keine Information.

      2.) Es gibt genau eine Lösung:
          Dann wird in k00 der Wert "1" geschrieben und in die folgenden
          Felder [k01 k02 k03 k04 ..... k0n] wird der gesuchte Lösungsvektor
          [x1 x2 x3 x4 .... xn] eingetragen.

      3.) Es gibt unendlich viele Lösungen:
          Dann wird in k00 der Wert "2" geschrieben. Das LGS ist in
          diagonalisierter Form im Feld k enthalten. die Interpretation
          bzw. die Konstruktion der Lösungsmenge muss vom aufrufenden
          Programm geleistet werden.
}

type TEquation = Array of Double;

     TLGS = class(TObject)
              protected
                ko : Array of TEquation;
                function EquaCount: Integer;
                function VarCount: Integer;
                function IntSpur: Integer;
                function Contradiction: Boolean;
                procedure Redim(iEquaCount, iVarCount: Integer);
                procedure ExchangeEquations(n1, n2: Integer);
                procedure DivideEquation(nr: Integer; factor: Double);
                procedure SubtEquation(dest: Integer; factor: Double; source: Integer);
                procedure PivotExchange(n: Integer);
              public
                constructor Create(iEquaCount, iVarCount: Integer);
                destructor  Destroy; override;
                procedure SetEquation(nr: Integer; koeff: TEquation);
                 { Schreibt die Koeffizienten der übergebenen Gleichung als
                   nr-te Gleichung in das Gleichungssystem, wobei nr >= 1 sein
                   muss. Dabei wird das Absolutglied der Gleichung in koeff[0]
                   erwartet, die Koeffizienten der i-ten Unbekannten in den
                   folgenden Feldern koeff[i] }
                procedure Diagonalize;
                 { Bringt das Gleichungssystem auf Diagonalform.
                   Speichert Informationen über die Lösbarkeit in ko[0,0]:
                      0 : keine Lösung;
                      1 : genau eine Lösung;
                      2 : mehr als eine Lösung.
                   Im Falle eindeutiger Lösbarkeit wird zudem der Lösungsvektor
                   in den Feldern ko[0,i], (i = 1...VarCount) abgelegt.
                   Im Falle mehrdeutiger Lösungen enthält das Koeffizienten-
                   Array das LGS in Dreiecksform. Die Konstruktion des
                   Lösungsraumes bleibt dem aufrufenden Programm überlassen. }
                procedure GetEquation(nr: Integer; var koeff: TEquation);
                 { Liest die Koeffizienten der nr-ten Gleichung aus dem
                   Gleichungssystem und übergibt sie in der Gleichung koeff }
              end;


implementation

uses MathLib;

const epsilon  = 1e-12;  { Muss stets kleiner sein als die Genauigkeit der
                           für die Darstellung der Koeffizienten verwendeten
  Fließkomma-Zahlen; nur dann kann "SafeSub" funktionieren! Die verwendeten
  Double-Variablen haben etwa 15-16 geltende Stellen, so dass mit epsilon =
  1e-12 noch 3 bis 4 Dezimalen Sicherheitsabstand vorhanden sind.           }


{======= Lebenslauf von LGS-Instanzen ===============}

constructor TLGS.Create(iEquaCount, iVarCount: Integer);
  begin
  Inherited Create;
  Redim(iEquaCount, iVarCount);
  end;

destructor TLGS.Destroy;
  begin
  ko := Nil;
  Inherited Destroy;
  end;

{======= Hilfs-Funktionen ============================}

function TLGS.EquaCount: Integer;
  begin
  Result := Pred(Length(ko));
  end;

function TLGS.VarCount: Integer;
  begin
  If Length(ko) > 0 then
    Result := Pred(Length(ko[0]))
  else
    Result := 0;
  end;

function TLGS.IntSpur: Integer;
  var i, n : Integer;

  begin
  n := 0;
  i := 1;
  While (i <= EquaCount) and (i <= VarCount) do begin
    n := n + Round(ko[i, i]);
    Inc(i);
    end;
  Result := n;
  end;

function TLGS.Contradiction: Boolean;
  var i : Integer;
  begin
  Result := False;
  i := 1;
  While (i <= EquaCount) and (i <= VarCount) do begin
    If (Abs(ko[i, i]) < epsilon) and
       (Abs(ko[i, 0]) > epsilon) then
      Result := True;
    Inc(i);
    end;
  end;


{====== Interne Bearbeitungsprozeduren ===============}

procedure TLGS.Redim(iEquaCount, iVarCount: Integer);
  var i : Integer;
  begin
  SetLength(ko, iEquaCount + 1);
  For i := 0 to EquaCount do
    SetLength(ko[i], iVarCount + 1);
  ko[0, 0] := -1;    {System noch nicht diagonalisiert ! }
  end;

procedure TLGS.ExchangeEquations(n1, n2: Integer);
  { vertauscht die Gleichungen mit den Nummern n1 und n2,
    indem die Koeffizienten ausgetauscht werden }
  var pu : Double;
      i  : Integer;
  begin
  If n1 <> n2 then
    For i := 0 to VarCount do begin
      pu        := ko[n1, i];
      ko[n1, i] := ko[n2, i];
      ko[n2, i] := pu;
      end;
  end;

procedure TLGS.DivideEquation(nr: Integer; factor: Double);
  { dividiert alle Koeffizienten der nr-ten Gleichung durch factor }
  var i : Integer;
  begin
  For i := 0 to VarCount do
    ko[nr, i] := ko[nr, i] / factor;
  end;

procedure TLGS.SubtEquation(dest: Integer; factor: Double; source: Integer);
  { subtrahiert von der dest-ten Gleichung das factor-fache der
    source-ten Gleichung und schreibt die neuen Koeffizienten in die
    dest-te Gleichung zurück }
  var i : Integer;
  begin
  For i := 0 to VarCount do
    ko[dest, i] := SafeSub(ko[dest, i], ko[source, i] * factor);
  end;

procedure TLGS.PivotExchange(n: Integer);
  var i, k : Integer;
      sf   : Double;
  begin
  If n < EquaCount then begin    // Falls überhaupt was zum Vertauschen da ist
    For k := n to EquaCount do begin // Normieren
      sf := 0;
      For i := k to VarCount do
        sf := sf + SQR(ko[k, i]);
      If sf > 0 then begin             // Gibt's überhaupt Koeffizienten <> 0 ?
        sf := SQRT(sf);
        For i := n to VarCount do
          ko[k, i] := ko[k, i] / sf;     // Dann wirklich normieren !
        ko[k, 0] := ko[k, 0] / sf;       // Rechte Seite nicht vergessen !!
        end;
      end;
    i := n;
    For k := n + 1 to EquaCount do   // Größten Koeffizienten suchen
      If Abs(ko[k, n]) > Abs(ko[i, n]) then
        i := k;
    ExchangeEquations(n, i);         // Entsprechende Gleichung nach oben !
    end;
  end;


{======== Interface-Prozeduren =======================}

{ Das interne Koeffizienten-Array ko[gnr, vnr] ist "verkehrt herum"
  organisiert:
    der erste Parameter gnr enthält die Nummer der angesprochenen Gleichung,
    der zweite Parameter vnr die Nummer des angesprochenen Koeffizienten. }

procedure TLGS.SetEquation(nr: Integer; koeff: TEquation);
  var i : Integer;
  begin
  For i := 0 to Varcount do
    ko[nr, i] := koeff[i];
  end;


procedure TLGS.GetEquation(nr: Integer; var koeff: TEquation);
  var i : Integer;
  begin
  For i := 0 to VarCount do
    koeff[i] := ko[nr, i];
  end;


procedure TLGS.Diagonalize;
  var i, k, m : Integer;
  begin
  If EquaCount >= VarCount then      // korrekte Grenze für nicht-
    m := VarCount                    //   quadratische Systeme bestimmen
  else
    m := EquaCount;
  For k := 1 to m do begin
    PivotExchange(k);
    If ko[k,k] <> 0 then begin       // nötig für Gleichungssysteme mit
      DivideEquation(k, ko[k,k]);    //   nicht genau einer Lösung
      For i:= 1 to EquaCount do
        If i <> k then
          SubtEquation(i, ko[i, k], k);
      end;
    end;
  k := IntSpur;
  If k = VarCount then begin  // So viele Einsen auf der Hauptdiagonalen wie
    ko[0, 0] := 1;            // Variablen vorhanden sind => eindeutig lösbar
    For i := 1 to VarCount do
      ko[0, i] := ko[i, 0];
    end
  else begin                  // Nicht eindeutig lösbare Systeme
    If Contradiction then
      ko[0, 0] := 0           // Keine Lösung
    else
      ko[0, 0] := 2;          // n-dimensionaler Lösungsraum mit n > 0
    end;
  end;

end.
