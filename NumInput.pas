unit NumInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;


type
  TIntInp = class(TObject)
    protected
      source : TEdit;
      function  GetValue: Integer;
      procedure SetValue(nv: Integer);
      procedure MyKeyPress(Sender: TObject; var Key: Char);
    public
      constructor Create(Edit: TEdit);
      property Value: Integer read GetValue write SetValue;
  end;

  TFloatInp = class(TObject)
    private
      function E_before(spot: Integer): Boolean;
    protected
      source : TEdit;
      function GetValue: Double;
      procedure SetValue(nv: Double);
      procedure MyKeyPress(Sender: TObject; var Key: Char);
    public
      constructor Create(Edit: TEdit);
      property Value: Double read GetValue write SetValue;
  end;

  TTBaum = class;
  TAngleMode = (Deg, Rad);

  TTermInp = class(TObject)
    private
      LastValidStr,
      LastErrorMsg : String;
      Term         : TTBaum;
      procedure RebuildTree;
      function  GetAngleMode: TAngleMode;
      procedure SetAngleMode(NewMode: TAngleMode);
    protected
      source : TEdit;
      procedure DoExit(Sender: TObject);
      procedure Change(Sender: TObject);
    public
      constructor Create(Edit: TEdit);
      destructor Destroy; override;
      function  f(x: Double) : Double;
      function  isOkay : Boolean;
      function  GetConstant (cname : Char) : DOUBLE;
      procedure SetConstant (cname : Char; cwert : DOUBLE);
    published
      property AngleMode: TAngleMode read GetAngleMode write SetAngleMode default Rad;
      property ErrorMsg: String read LastErrorMsg;
    end;


  { Hier endet die Komponenten-Deklaration. Die folgenden Objekte sind
    nicht-visuelle Hilfsobjekte für die TermEdit-Komponente; leider
    müssen diese auch hier deklariert werden. Einfach ignorieren !!!    }

  {=========== TKnoten ========================}

  TKnoten = class (TObject)
    public
      token    : BYTE;
      value    : DOUBLE;
      left_ch,
      right_ch : TKnoten;
      constructor CreateWD (iToken: Byte; iValue: Double; iLeft_Ch, iRight_Ch: TKnoten);
      destructor Destroy; override;
      procedure SwitchChildren;
    end;

   { Bedeutung der Token :
     0 = reelle Konstante;       12 = natuerlicher Logarithmus
     1 = Funktionsvariable(x);   13 = natuerliche Exponentialfunktion
     2 = Plus                    14 = Zehnerlogarithmus
     3 = Minus                   15 = Arcus-Tangens
     4 = Mal                     16 = (-1) * ......      ( Change sign )
     5 = Geteilt                 17 = Absolutbetrag
     6 = Hoch                    18 = Quadrat
     7 = Klammerterm             19 = Ganzzahliger Anteil( INT )
     8 = Sinus                   20 = Nachkomma-Anteil   ( FRAC )
     9 = Cosinus                 21 = Normalverteilung   ( GAUSSFUNKTION )
    10 = Tangens                 22 = Signum             ( Vorzeichenfunktion)
    11 = Quadratwurzel                   }

  {============ TTBaum ==================}

  TTbStatus  = (tbEmpty, tbCompError, tbCalcError, tbNotDefined, tbOkay);
  TTBaum = class(TObject)
      epsilon,
      ln10,
      g_nach_b  : Double;
      digits    : SET OF CHAR;
      op_name   : STRING [6];
      brackets  : STRING [6];
      f_name    : ARRAY [1..15] OF STRING [6];
      constants : ARRAY [1..13] of DOUBLE; { abcdpqrstuvwe }
      params    : ARRAY [1..4, 1..12] of DOUBLE;
      c_name    : STRING [13];
      priority  : Array [0 .. 22] of Integer;
      AngleMode : TAngleMode;
      baum      : TKnoten;
      status    : TTbStatus;
      source_str,
      error_str : STRING;
      error_spot: INTEGER;
      constructor CreateWD (st: STRING);
      destructor Destroy; override;

      procedure CutFirst_wB (Var st: String; count: Integer);
      procedure upper (var s : string);
      function power (basis, hochzahl : Double) : Double;
      function bogen (grad : Double) : Double;
      function grad (bogen : Double) : Double;
      function log (x : Double) : Double;
      function signum (x: Double) : Double;
      procedure SetConstant (cname : Char; cwert : DOUBLE);
      function  GetConstant (cname : Char) : DOUBLE;
      procedure BuildTree(st : STRING);
      function  GetString: String;
      procedure BuildString;
      procedure Reset;
      function  Value(x : DOUBLE) : Double;
      function  is_okay           : Boolean;
    end;


implementation

{ TIntInp }

Constructor TIntInp.Create(Edit: TEdit);
begin
  inherited Create();
  source := Edit;
  source.OnKeyPress := MyKeyPress;
end;

function TIntInp.GetValue: Integer;
var nv, ec : Integer;
begin
  Val(source.Text, nv, ec);
  if ec = 0 then
    Result := nv
  else begin
    Result := 0;
    MessageBeep($FFFF);
    end;
end;

procedure TIntInp.SetValue(nv: Integer);
begin
  source.Text := IntToStr(nv);  // Geht immer.
end;

procedure TIntInp.MyKeyPress(Sender: TObject; var Key: Char);
var buf  : String;
begin
if Sender = source then begin
  Case Key of
    #8, #13,
    '0'..'9' : ;
    '+', '-' : If source.SelStart > 0 then
                 Key := #0
               else
                 if source.Text[1] In ['+', '-'] then begin
                   buf := source.Text;
                   Delete(buf, 1, 1);
                   source.Text := buf;
                   source.SelStart := 0;
                   end;
  else
    Key := #0;
  end;
  If Key = #0 then
    MessageBeep(0);
  end;
end;


{ TFloatInp }

Constructor TFloatInp.Create(Edit: TEdit);
begin
  inherited Create();
  source := Edit;
  source.OnKeyPress := MyKeyPress;
end;

function TFloatInp.E_before (spot : Integer) : Boolean;
  var e : Integer;
  begin
  e := Pos('e', source.Text);
  If e = 0 then e := Pos('E', source.Text);
  If e = 0 then
    Result := False
  else
    Result := e < spot;
  end;

function TFloatInp.GetValue: Double;
var buf : String;
    nv : Double;
    n,
    ec : Integer;
begin
  buf := source.Text;
  n := Pos (',', buf);
  While n > 0 do begin
    buf[n] := '.';
    n := Pos (',', buf);
    end;
  Val(buf, nv, ec);
  if ec = 0 then
    Result := nv
  else begin
    Result := 0;
    MessageBeep($FFFF);
    end;
end;

procedure TFloatInp.SetValue(nv: Double);
begin
  source.Text := FloatToStr(nv);  // Geht immer.
end;

procedure TFloatInp.MyKeyPress(Sender: TObject; var Key: Char);
  var buf : String;
      oss : Integer;
  begin
  if Sender = source then begin
    Case Key of
      #8, #13,
      '0'..'9' : ;
      '.', ',' : If (source.SelStart = 0) or
                    Not(source.Text[source.SelStart] in ['0'..'9']) or
                    (Pos('.', source.Text) > 0) or
                    (Pos(',', source.Text) > 0) or
                    E_before(source.SelStart) then
                   Key := #0;
      'e', 'E' : If (source.SelStart = 0) or
                    (Pos('e', source.Text) > 0) or
                    (Pos('E', source.Text) > 0) then
                   Key := #0;
      '+', '-' : If (source.SelStart > 0) and
                     Not(source.Text[source.SelStart] in ['e', 'E']) then
                   Key := #0
                 else
                   If source.Text[source.SelStart + 1] in ['+', '-'] then begin
                     oss := source.SelStart;
                     buf := source.Text;
                     Delete(buf, source.SelStart + 1, 1);
                     source.Text := buf;
                     source.SelStart := oss;
                     end;
    else
      Key := #0;
    end; { of case }
    If Key = #0 then
      MessageBeep(0);
    end;
  end;


{ TTermInp }

constructor TTermInp.Create(Edit: TEdit);
  begin
  Inherited Create();
  source := Edit;
  Term := TTBaum.CreateWD(source.Text);
  source.OnExit   := DoExit;
  source.OnChange := Change;
  end;

destructor TTermInp.Destroy;
  begin
  Term.Free;
  Inherited Destroy;
  end;

procedure TTermInp.Change(Sender: TObject);
{ Das automatische Rebuild des Termbaums darf nicht aufgerufen werden,
  wenn TermEdit den Focus hat: während der Eingabe ist der Term sicher
  syntaktisch unvollständig und würde deshalb ständig Fehlermeldungen
  produzieren.                                                         }
  begin
  If Not source.Focused then
    RebuildTree;
  end;

procedure TTermInp.DoExit(Sender: TObject);
{ Verliert das Term-Edit-Feld den Focus, wird stets versucht, den darin
  gespeicherten String als mathematischen Term zu interpretieren und einen
  entsprechenden Termbaum aufzubauen. Falls das schief geht, erscheint eine
  entsprechende Fehlermeldung und das Term-Edit-Feld erhält den Fokus gleich
  wieder. Somit kann das Edit-Feld nur dann verlassen werden, wenn es einen
  gültigen Term enthält - notfalls tragen Sie einfach "0" ein ;-)           }
  begin
  RebuildTree;
  if Not isOkay then
    source.SetFocus;
  end;

procedure TTermInp.RebuildTree;
  begin
  with Term do begin
    LastValidStr := GetString;
    BuildTree(source.Text);
    If is_okay then begin
      LastErrorMsg := '';
      LastValidStr := source.Text;
      end
    else begin
      LastErrorMsg := error_str;
      MessageBeep(mb_IconAsterisk);
      If MessageDlg('"' + source.Text + '"'#13#10 +
                    'ist kein gültiger mathematischer Term:'#13#10#10 +
                    LastErrorMsg,
                    mtError, [mbOk, mbCancel], 0) = mrOk then begin
        source.SetFocus;
        If error_spot > 0 then
          source.SelStart := Pred(error_spot);
        end;
      end;
    end;
  end;

function TTermInp.GetAngleMode: TAngleMode;
  begin
  Result := Term.AngleMode;
  end;

procedure TTermInp.SetAngleMode(NewMode: TAngleMode);
  begin
  Term.AngleMode := NewMode;
  end;

procedure TTermInp.SetConstant (cname : Char; cwert : DOUBLE);
  BEGIN
  Term.SetConstant (cname, cwert);
  If Term.GetConstant (cname) <> cwert then
    LastErrorMsg := 'Die Konstante ' + cname +
                    ' konnte nicht gesetzt werden.'
  else
    LastErrorMsg := '';
  end;

function TTermInp.GetConstant (cname : Char) : DOUBLE;
  BEGIN
  Result := Term.GetConstant(cname);
  end;

function TTermInp.f(x: Double) : Double;
  begin
  With Term do begin
    If Status <= tbCompError then
      RebuildTree;
    f := Value(x);
    If is_okay then
      LastErrorMsg := ''
    else
      LastErrorMsg := error_str;
    end;
  end;

function TTermInp.isOkay : Boolean;
  begin
  isOkay := (Term <> Nil) and Term.is_Okay;
  end;


{ Es folgen die Implementierungen der Hilfsobjekte für TTermEdit. }
{ TKnoten }


constructor TKnoten.CreateWD (iToken: Byte; iValue: Double;
                              iLeft_Ch, iRight_Ch: TKnoten);
  begin
  Inherited Create;
  Token := iToken;
  Value := iValue;
  left_ch  := iLeft_Ch;
  right_ch := iRight_Ch;
  end;

destructor TKnoten.Destroy;
  begin
  left_ch.Free;
  right_ch.Free;
  Inherited Destroy;
  end;

procedure TKnoten.SwitchChildren;
  var pu : TKnoten;
  begin
  pu       := right_ch;
  right_ch := left_ch;
  left_ch  := pu;
  end;


{ TTBaum }

CONSTRUCTOR TTBaum.CreateWD (st : STRING);
  var i : Integer;
  BEGIN
  Inherited Create;
  epsilon   := 1e-40;
  ln10      := ln(10);
  g_nach_b  := PI / 180;
  c_name    := 'ABCDPQRSTUVWE';
  SetConstant('e', exp(1));

  digits    := ['0'..'9'];
  op_name   := 'x+-*/^';
  brackets  := '()[]{}';

  f_name[1] := 'SIN';
  f_name[2] := 'COS';
  f_name[3] := 'TAN';
  f_name[4] := 'SQRT';
  f_name[5] := 'LN';
  f_name[6] := 'EXP';
  f_name[7] := 'LOG';
  f_name[8] := 'ARCTAN';
  f_name[9] := 'CS';
  f_name[10] := 'ABS';
  f_name[11] := 'SQR';
  f_name[12] := 'INT';
  f_name[13] := 'FRAC';
  f_name[14] := 'NORMAL';
  f_name[15] := 'SGN';

  For i := 0 to 22 do
    priority[i] := 4;
  priority[2] := 1;
  priority[3] := 1;
  priority[4] := 2;
  priority[5] := 2;
  priority[6] := 3;

  AngleMode   := Rad;

  baum        := NIL;
  source_str  := '';
  error_str   := '';
  error_spot  := 0;
  status      := tbEmpty;
  If st <> '' then
    BuildTree(st);
  END;

PROCEDURE TTBaum.CutFirst_wB (Var st: String; count: Integer);
  { löscht die ersten count Zeichen aus st, sowie alle direkt
    darauf folgenden Leerzeichen }
  BEGIN
  IF count > 0 THEN
    DELETE(st, 1, count);
  WHILE (LENGTH(st) > 0) AND
        (st[1] = ' ') DO
    DELETE(st, 1, 1);
  END;

PROCEDURE TTBaum.upper (var s : string);
  var  i : Integer;
  begin
  for i := 1 to Length (s) do
    s[i] := Upcase (s[i]);
  end;

FUNCTION TTBaum.power (basis, hochzahl : Double) : Double;
  VAR pr : Double;
      i  : Integer;
  begin
  If ABS (hochzahl - Round(hochzahl)) < epsilon then begin
    pr := 1.0;
    for i := 1 to ABS (Round(hochzahl)) do
      pr := pr * basis;
    If hochzahl < 0 then
      pr := 1 / pr;
    end
  else
    pr := EXP (hochzahl * LN (basis));
  power := pr;
  end;

function TTBaum.bogen (grad : Double) : Double;
  begin
  bogen := grad * g_nach_b;
  end;


function TTBaum.grad (bogen : Double) : Double;
  begin
  grad := bogen / g_nach_b;
  end;

function TTBaum.log (x : Double) : Double;
  begin
  log := ln(x)/ ln10;
  end;

function TTBaum.signum (x: Double) : Double;
  begin
  If Abs(x) < epsilon then
    signum := 0
  else
    If x > 0 then
      signum := 1
    else
      signum := -1;
  end;


PROCEDURE TTBaum.SetConstant (cname : Char; cwert : DOUBLE);
  VAR i : INTEGER;
  BEGIN
  i := POS(Upcase(cname), c_name);
  IF (i > 0) and (i <= 13) then
    constants[i] := cwert;
  END;


FUNCTION TTBaum.GetConstant (cname : Char) : DOUBLE;
  VAR i : INTEGER;
  BEGIN
  i := POS(Upcase(cname), c_name);
  IF (i > 0) and (i <= 13) then
    Result := constants[i]
  ELSE
    Result := 0;    { Dummy-Wert }
  END;


FUNCTION TTBaum.is_okay : BOOLEAN;
  BEGIN
  is_okay := status = tbOkay;
  END;


PROCEDURE TTBaum.BuildTree (st : STRING);

  FUNCTION term (VAR s : STRING) : TKnoten;

    VAR tm    : TKnoten;
        tk    : Integer;
        fsneg : Boolean; {F_irst S_ummand Neg_ativ}

    FUNCTION summand : TKnoten;

      VAR sd : TKnoten;
          tk : Integer;

      FUNCTION faktor : TKnoten;

        VAR fr,
            expo : TKnoten;

        FUNCTION vorz_faktor : TKnoten;

          VAR sign : BOOLEAN;

          FUNCTION real_zahl : TKnoten;

            VAR exp_sign   : BOOLEAN;
                vorkomma,
                nachkomma,
                exponent,
                wert       : DOUBLE;
                lnk,
                i          : INTEGER;

            FUNCTION n0_zahl (VAR wert : DOUBLE) : BOOLEAN;

              BEGIN
              n0_zahl := FALSE;
              IF (LENGTH (s) > 0) AND
                 (s[1] IN digits) THEN BEGIN
                n0_zahl := TRUE;
                wert := 0;
                WHILE (LENGTH (s) > 0) AND
                      (s[1] IN digits) DO BEGIN
                  wert := wert * 10 + ORD (s[1]) - ORD ('0');
                  CutFirst_wB (s, 1);
                  END;
                END;
              END; { of n0_zahl }


            BEGIN { of real_zahl }
            real_zahl := NIL;
            IF n0_zahl(vorkomma) THEN BEGIN
              wert := vorkomma;
              IF (Length(s) > 0) and
                 ((s[1] = '.') OR
                  (s[1] = ',')) THEN BEGIN
                CutFirst_wB (s, 1);
                lnk := 0;
                WHILE (lnk < LENGTH (s)) AND
                      (s [SUCC (lnk)] IN digits) DO
                  INC(lnk);
                IF n0_zahl (nachkomma) THEN BEGIN
                  FOR i := 1 TO lnk DO
                    nachkomma := nachkomma / 10.0;
                  wert := wert + nachkomma;
                  END
                ELSE BEGIN
                  error_str := 'Ziffer erwartet !';
                  EXIT;
                  END;
                END;
              IF (Length(s) > 0) AND
                 (s[1] = 'E') THEN BEGIN
                CutFirst_wB (s, 1);
                IF (Length(s) > 0) AND
                   ((s[1] = '+') OR
                    (s[1] = '-')) THEN BEGIN
                  exp_sign := s[1] = '-';
                  CutFirst_wB (s, 1);
                  END
                ELSE
                  exp_sign := FALSE;
                IF n0_zahl(exponent) THEN
                  IF exp_sign THEN
                    FOR i := 1 TO ROUND (exponent) DO
                      wert := wert / 10.0
                  ELSE
                    FOR i := 1 TO ROUND (exponent) DO
                      wert := wert * 10.0
                ELSE BEGIN
                  error_str := 'Exponent erwartet !';
                  EXIT;
                  END;
                END;
              real_zahl := TKnoten.CreateWD(0, wert, Nil, Nil);
              END;
            END; { of real_zahl }


          FUNCTION funktion : TKnoten;

            VAR argu  : TKnoten;
                f_num,
                i, p  : INTEGER;

            BEGIN { of funktion }
            funktion := NIL;
            IF LENGTH (s) > 0 THEN BEGIN
              f_num := 0;
              i     := 1;
              REPEAT
                p := POS (f_name [i], s);
                IF p = 1 THEN BEGIN
                  CutFirst_wB (s, LENGTH (f_name[i]));
                  f_num := i;
                  i     := 16; { = Anzahl d. Fkt. + 1 }
                  END
                ELSE
                  INC (i);
              UNTIL i > 15; { = Anzahl d. Fkt. }

              IF (LENGTH (s) > 0) THEN BEGIN
                p := POS (s[1], brackets);
                IF (p > 0) AND Odd(p) THEN BEGIN
                  CutFirst_wB (s, 1);
                  IF f_num <= 14 THEN
                    argu := term (s)
                  ELSE BEGIN
                    argu := Nil;
                    error_str := 'Unbekannte Funktion !';
                    END;
                  IF argu = NIL THEN
                    IF error_str = '' THEN
                      error_str := 'Syntaxfehler !'
                    ELSE
                  ELSE
                    IF (LENGTH (s) > 0) AND (s[1] = brackets[Succ(p)]) THEN BEGIN
                      CutFirst_wB (s, 1);
                      If f_num > 0 then
                        funktion := TKnoten.CreateWD(f_num + 7, p, Nil, argu)
                      else
                        funktion := argu;
                      END
                    ELSE
                      IF error_str = '' THEN
                        error_str := '''' + brackets[Succ(p)] + ''' erwartet !';
                  END
                ELSE  { Keine Argumentenklammer nach dem Funktionsnamen ! }
                  If f_num > 0 then
                    error_str := '''('' erwartet !';
                END
              ELSE
                IF f_num > 0 THEN
                  error_str := '''('' erwartet !';
              END;
            END;  { of funktion }

          function konstante : TKnoten;
            VAR i : INTEGER;
            BEGIN
            Result := NIL;
            IF s[1] = 'X' THEN BEGIN
              CutFirst_wB (s, 1);
              Result := TKnoten.CreateWD(1, 0.0, Nil, Nil);
              END
            ELSE BEGIN
              i := POS(s[1], c_name);
              IF i = 0 THEN
                error_str := 'Unbekannter Bezeichner !'
              ELSE
                IF c_name[i] = 'P' THEN
                  IF (Length(s) >= 2) and (s[2] = 'I') THEN BEGIN
                    CutFirst_wB (s, 2);
                    Result := TKnoten.CreateWD(0, PI, NIL, NIL);
                    END
                  ELSE BEGIN
                    CutFirst_wB (s, 1);
                    Result := TKnoten.CreateWD(1, i, NIL, NIL);
                    END
                ELSE BEGIN
                  CutFirst_wB (s, 1);
                  Result := TKnoten.CreateWD(1, i, NIL, NIL);
                  END;
              END;
            END;

          BEGIN { of vorz_faktor }
          { Ein Vorzeichenbehafteter Faktor
              kann ein Vorzeichen haben;
              danach kommt entweder
                -- eine Zahl,
                -- eine Funktion
                     (dies kann auch ein Term
                      in Klammern sein!), oder
                -- eine Konstante.   }
          IF Length(s) > 0 THEN BEGIN
            sign   := FALSE;
            IF (s[1] = '+') OR
               (s[1] = '-') THEN BEGIN
              sign := s[1] = '-';
              CutFirst_wB (s, 1);
              END;

            IF Length(s) > 0 THEN BEGIN
              Result := real_zahl;
              IF (Result = NIL) and (error_str = '') THEN BEGIN
                Result := funktion;
                IF (Result = NIL) and (error_str = '') THEN
                  Result := Konstante;
                END;
              END
            ELSE
              Result := NIL;

            IF (Result <> NIL) AND sign THEN
              Result := TKnoten.CreateWD(16, 0.0, Nil, Result);
            END
          ELSE
            Result := NIL;

          vorz_faktor := Result;
          END; { of vorz_faktor }


        BEGIN { of faktor }
        { Ein Faktor ist eine Potenz:
            Basis und (eventuell vorhandener) Exponent sind
            Vorzeichenbehaftete Faktoren.   }
        faktor := NIL;
        fr     := vorz_faktor;
        IF fr = NIL THEN EXIT;
        WHILE (fr <> NIL ) AND
              (LENGTH (s) > 0) AND
              (s[1] = '^') DO BEGIN
          CutFirst_wB (s, 1);
          expo := vorz_faktor;
          IF expo = NIL THEN BEGIN
            error_str := 'Exponent erwartet !';
            EXIT;
            END;
    {
          IF fr.token = 16 THEN
            fr.right_ch := TKnoten.CreateWD(6, 0.0, fr.right_ch, expo)
          ELSE
    }
          fr := TKnoten.CreateWD(6, 0.0, fr, expo);
          END;
        faktor := fr;
        END;  { of faktor }


      BEGIN { of summand }
      { Ein Summand ist ein Produkt aus
        (eventuell mehreren) Faktoren. }
      sd := faktor;
      WHILE (sd <> NIL) AND
            (LENGTH (s) > 0) AND
            ((s[1] = '*') OR (s[1] = '/')) DO BEGIN
        IF s[1] = '/' THEN tk := 5 ELSE tk := 4;
        CutFirst_wB (s, 1);
        IF Length(s) > 0 THEN
          sd := TKnoten.CreateWD(tk, 0.0, sd, faktor)
        ELSE
          error_str := 'Faktor erwartet !';
        END;
      summand := sd;
      END;  { of summand }


    BEGIN { of term }
    { Ein Term ist eine Summe von
      (eventuell mehreren) Summanden.}
    term := NIL;
    IF LENGTH (s) = 0 THEN EXIT;
    CutFirst_wB (s, 0);  { löscht führende Blanks }

    fsneg := s[1] = '-';
    If fsneg then CutFirst_wB(s, 1);
    tm := summand;
    If fsneg then
      tm := TKnoten.CreateWD(16, 0.0, Nil, tm);
    WHILE (tm <> NIL) AND
       (LENGTH (s) > 0) AND
       ((s[1] = '+') OR (s[1] = '-')) DO BEGIN
      IF s[1] = '+' THEN tk := 2 ELSE tk := 3;
      CutFirst_wB (s, 1);
      IF Length(s) > 0 THEN
        tm := TKnoten.CreateWD(tk, 0.0, tm, summand)
      ELSE
        error_str := 'Summand erwartet !';
      END;
    term := tm;
    END; { of term }


  BEGIN  { of BuildTree }
  Reset;
  source_str := st;
  Upper (st);
  IF st <> '' THEN BEGIN
    baum := term (st);
    IF (st        > '') OR
       (error_str > '') THEN BEGIN
      IF error_str = '' THEN
        error_str := 'Syntaxfehler !';
      error_spot := SUCC (LENGTH (source_str) - LENGTH (st));
      status     := tbCompError;
      END
    ELSE BEGIN
      error_spot := 0;
      status     := tbOkay;
      END;
    END;
  END;   { of BuildTree }

FUNCTION TTBaum.GetString: STRING;
  BEGIN
  Result := source_str;
  END;

FUNCTION TTBaum.Value (x : DOUBLE) : DOUBLE;

  FUNCTION tbw (tb : TKnoten) : DOUBLE;

    VAR arg, denom : DOUBLE;

    BEGIN
    tbw := 0;
    CASE tb.token OF
       0 : tbw := tb.value;
       1 : If ROUND(tb.value) = 0 then tbw := x
           else tbw := constants[ROUND(tb.value)];
       2 : tbw := tbw (tb.left_ch) + tbw (tb.right_ch);
       3 : tbw := tbw (tb.left_ch) - tbw (tb.right_ch);
       4 : tbw := tbw (tb.left_ch) * tbw (tb.right_ch);
       5 : BEGIN
           denom := tbw (tb.right_ch);
           If ABS (denom) >= epsilon THEN
             tbw := tbw (tb.left_ch) / denom
           ELSE
             error_str := 'Division durch Null !';
           END;
       6 : tbw := power (tbw (tb.left_ch), tbw (tb.right_ch));
       7 : tbw := tbw (tb.right_ch);
       8 : IF AngleMode = Rad THEN
             tbw := SIN (tbw (tb.right_ch))
           ELSE
             tbw := SIN (bogen(tbw(tb.right_ch)));
       9 : IF AngleMode = Rad THEN
             tbw := COS (tbw (tb.right_ch))
           ELSE
             tbw := COS (bogen(tbw(tb.right_ch)));
      10 : BEGIN
           IF AngleMode = Rad THEN
             arg := tbw(tb.right_ch)
           ELSE
             arg := bogen(tbw(tb.right_ch));
           denom := COS (arg);
           IF ABS (denom) >= epsilon THEN
             tbw := SIN (arg) / denom
           ELSE
             error_str := 'Unzulässiges TAN-Argument !';
           END;
      11 : BEGIN
           arg := tbw(tb.right_ch);
           IF arg >= 0.0 THEN
             tbw := SQRT (arg)
           ELSE
             error_str := 'Negativer Radikand !';
           END;
      12 : BEGIN
           arg := tbw(tb.right_ch);
           IF arg >= 0.0 THEN
             tbw := LN  (arg)
           ELSE
             error_str := 'Negatives LN-Argument !';
           END;
      13 : tbw := EXP (tbw (tb.right_ch));
      14 : BEGIN
           arg := tbw(tb.right_ch);
           IF arg > 0.0 THEN
             tbw := LN  (tbw (tb.right_ch)) / LN (10.0)
           ELSE
             error_str := 'Negatives LOG-Argument !';
           END;
      15 : tbw := ARCTAN (tbw (tb.right_ch));
      16 : tbw := -1.0 * tbw (tb.right_ch);
      17 : tbw := ABS (tbw (tb.right_ch));
      18 : tbw := SQR (tbw (tb.right_ch));
      19 : tbw := INT (tbw (tb.right_ch));
      20 : tbw := FRAC (tbw (tb.right_ch));
      21 : tbw := 1 / SQRT (2*PI) * exp (-SQR (tbw(tb.right_ch)));
      22 : begin
           arg := tbw(tb.right_ch);
           If abs(arg) < epsilon then
             tbw := 0.0
           else
             if arg > 0 then
               tbw := 1
             else
               tbw := -1;
           end;
    ELSE
      error_str := 'Unbekannter Operator !';
      tbw := 0;
    END; { of case }
    END;

  BEGIN
  Result := 0;
  IF status >= tbCalcError THEN BEGIN
    status := tbOkay;
    error_str := '';
    IF baum <> NIL THEN BEGIN
      TRY
        Result := tbw (baum);
      EXCEPT
        status := tbCalcError;
      END;
      If error_str <> '' THEN
        status := tbCalcError;
      END;
    END;
  END;


PROCEDURE TTBaum.BuildString;
  VAR rt : Integer;     { Rekursionstiefe            }
      sl : Integer;     { Länge des Ergebnis-Strings }

  FUNCTION tbs (tb : TKnoten) : STRING;
    VAR pu       : String[20];
        ka1, kz1,
        ka2, kz2 : String[1];
        i        : Integer;
    BEGIN
    Inc(rt);
    If rt > 20 then Abort;
    ka1 := ''; kz1 := '';
    ka2 := ''; kz2 := '';
    CASE tb.token OF
       0 : BEGIN
           STR(tb.value:12:3, pu);
           WHILE (LENGTH(pu) >= 1) and (pu[1] = ' ') DO DELETE(pu, 1, 1);
           WHILE (LENGTH(pu) >= 1) and (pu[LENGTH(pu)] = '0') DO DELETE(pu, LENGTH(pu), 1);
           IF (LENGTH(pu) >= 1) and (pu[LENGTH(pu)] = '.') THEN DELETE(pu, LENGTH(pu), 1);
           Inc(sl, Length(pu));
           If sl < 255 then
             tbs := pu
           else Abort;
           END;
       1 : If sl < 255 then begin
             Inc(sl);
             IF ROUND(tb.value) = 0 then tbs := 'x'
             ELSE tbs := c_name[ROUND(tb.value)];
             end
           else Abort;
       2 : If sl < 252 then begin
             Inc(sl, 3);
             tbs := tbs (tb.left_ch) + ' + ' + tbs (tb.right_ch);
             end
           else Abort;
       3 : If sl < 252 then begin
             Inc(sl, 3);
             tbs := tbs (tb.left_ch) + ' - ' + tbs (tb.right_ch);
             end
           else Abort;
       4 : If sl < 248 then begin
             Inc(sl, 3);
             If priority[tb.left_ch.token] < 2 then begin
               ka1 := '('; kz1 := ')'; Inc(sl, 2); end;
             If priority[tb.right_ch.token] < 2 then begin
               ka2 := '('; kz2 := ')'; Inc(sl, 2); end;
             tbs := ka1 + tbs (tb.left_ch) + kz1 + ' * ' +
                    ka2 + tbs (tb.right_ch) + kz2;
             end
           else Abort;
       5 : If sl < 248 then begin
             Inc(sl, 3);
             If priority[tb.left_ch.token] < 2 then begin
               ka1 := '('; kz1 := ')'; Inc(sl, 2); end;
             If priority[tb.right_ch.token] < 2 then begin
               ka2 := '('; kz2 := ')'; Inc(sl, 2); end;
             tbs := ka1 + tbs (tb.left_ch) + kz1 + ' / ' +
                    ka2 + tbs (tb.right_ch) + kz2;
             end
           else Abort;
       6 : If sl < 248 then begin
             Inc(sl, 3);
             If priority[tb.left_ch.token] < 3 then begin
               ka1 := '('; kz1 := ')'; Inc(sl, 2); end;
             If priority[tb.right_ch.token] < 3 then begin
               ka2 := '('; kz2 := ')'; Inc(sl, 2); end;
             tbs := ka1 + tbs (tb.left_ch) + kz1 + ' ^ ' +
                    ka2 + tbs (tb.right_ch) + kz2;
             end
           else Abort;
       7 : If sl < 251 then begin
             Inc(sl, 4);
             i   := Round(tb.value);
             tbs := brackets[i] + ' ' +
		    tbs (tb.right_ch) + ' ' +
		    brackets[Succ(i)];
             end
           else Abort;
       8 : If sl < 247 then begin
             Inc(sl, 8);
             tbs := 'SIN ( ' + tbs (tb.right_ch) + ' )';
             end
           else Abort;
       9 : If sl < 247 then begin
             Inc(sl, 8);
             tbs := 'COS ( ' + tbs (tb.right_ch) + ' )';
             end
           else Abort;
      10 : If sl < 247 then begin
             Inc(sl, 8);
             tbs := 'TAN ( ' + tbs (tb.right_ch) + ' )';
             end
           else Abort;
      11 : If sl < 246 then begin
             Inc(sl, 9);
             tbs := 'SQRT ( ' + tbs (tb.right_ch) + ' )';
             end
           else Abort;
      12 : If sl < 248 then begin
             Inc(sl, 7);
             tbs := 'LN ( '  + tbs (tb.right_ch) + ' )';
             end
           else Abort;
      13 : If sl < 247 then begin
             Inc(sl, 8);
             tbs := 'EXP ( ' + tbs (tb.right_ch) + ' )';
             end
           else Abort;
      14 : If sl < 247 then begin
             Inc(sl, 8);
             tbs := 'LOG ( ' + tbs (tb.right_ch) + ' )';
             end
           else Abort;
      15 : If sl < 244 then begin
             Inc(sl, 11);
             tbs := 'ARCTAN ( ' + tbs (tb.right_ch) + ' )';
             end
           else Abort;
      16 : If sl < 253 then begin
             Inc(sl, 2);
             tbs := '- ' + tbs (tb.right_ch);
             end
           else Abort;
      17 : If sl < 247 then begin
             Inc(sl, 8);
             tbs := 'ABS ( ' + tbs (tb.right_ch) + ' )';
             end
           else Abort;
      18 : If sl < 247 then begin
             Inc(sl, 8);
             tbs := 'SQR ( ' + tbs (tb.right_ch) + ' )';
             end
           else Abort;
      19 : If sl < 247 then begin
             Inc(sl, 8);
             tbs := 'INT ( ' + tbs (tb.right_ch) + ' )';
             end
           else Abort;
      20 : If sl < 246 then begin
             Inc(sl, 9);
             tbs := 'FRAC ( ' + tbs (tb.right_ch) + ' )';
             end
           else Abort;
      21 : If sl < 244 then begin
             Inc(sl, 11);
             tbs := 'NORMAL ( ' + tbs(tb.right_ch) + ' )';
             end
           else Abort;
      22 : If sl < 247 then begin
             Inc(sl, 8);
             tbs := 'SGN ( ' + tbs(tb.right_ch) + ' )';
             end
           else Abort;
      23 : If sl < 254 then begin
             Inc(sl);
      tbs := 'a';
             end
           else Abort;
      24 : If sl < 254 then begin
             Inc(sl);
             tbs := 'b';
             end
           else Abort;
      25 : If sl < 254 then begin
             Inc(sl);
             tbs := 'c';
             end
           else Abort;
      26 : If sl < 254 then begin
             Inc(sl);
             tbs := 'd';
             end
           else Abort;
      27 : If sl < 254 then begin
             Inc(sl);
             tbs := 'e';
             end
           else Abort;
      28 : If sl < 254 then begin
             Inc(sl);
             tbs := 'p';
             end
           else Abort;
      29 : If sl < 254 then begin
             Inc(sl);
             tbs := 'q';
             end
           else Abort;
      30 : If sl < 254 then begin
             Inc(sl);
             tbs := 'r';
             end
           else Abort;
      31 : If sl < 254 then begin
             Inc(sl);
             tbs := 's';
             end
           else Abort;
      32 : If sl < 254 then begin
             Inc(sl);
             tbs := 't';
             end
           else Abort;
    ELSE
      error_str := 'Unbekannter Operator !';
      tbs := '';
    END; { of case }
    Dec(rt);
    END;

  BEGIN
  IF (baum <> Nil) and
     (status = tbOkay) THEN BEGIN
    error_str := '';
    rt := 0;
    sl := 0;
    try
      source_str := tbs (baum);
    except
      On EAbort do source_str := '';
    end;
    END;
  END;

PROCEDURE TTBaum.Reset;
  BEGIN
  baum.Free;
  baum       := Nil;
  error_spot :=  0;
  error_str  := '';
  source_str := '';
  status     := tbEmpty;
  END;

DESTRUCTOR TTBaum.Destroy;
  BEGIN
  Reset;
  Inherited Destroy;
  END;


end.
