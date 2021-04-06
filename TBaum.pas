UNIT TBaum;

  { 26.03.97 Neue 32-Bit-Beta-Fassung mit alten Features:
    Erkennung der Stelle eines Syntaxfehlers im Term;
    sollte alle Terme korrekt berechnen, erkennt auch falsche
    Argumentwerte von Funktionen und Division durch Null !

    29.09.00 Token 26..30 ergänzt: Werte von EUKLID-Objekten
    wie Koordinatenwerte, Längen, Flächeninhalte usw. können
    nun auch verarbeitet werden.

    01.06.01 Token 31..32 ergänzt: val() für numerische Objekt-
    Daten und tv() für Teilverhältnisse

    07.06.02 Token 33..37 ergänzt: floor(), ceil(), sgn(),
                                   grad(), bogen()

    12.02.05 BoolBaum ergänzt zur Vorbereitung der
             Implementierung einer if()-Funktion

    18.10.05 if()-Funktion implementiert

    21.06.06 Random-Funktion implementiert

    14.11.06 BoolBaum um Token 113 ergänzt für korrekte
             Verwaltung der Klammern

    03.01.07 Konstruktoren für TTBaum und TBoolBaum ergänzt
             um Initialisierungs-Parameter für AngleMode

    16.02.07 In TTBaum.messwertnumobj neben ';' auch ',' als
             Trennzeichen in einer Argumentliste zugelassen

    03.01.08 Diagnosefunktion is_trig() implementiert }


INTERFACE

USES windows, classes;

TYPE  TKnoten   = class(TPersistent)
                  public
                    token    : BYTE;
                    value    : DOUBLE;
                    left_ch,
                    right_ch : TKnoten;
                    constructor Create(iToken: Byte; iValue: Double; iLeft_Ch, iRight_Ch: TKnoten);
                    constructor Init4Int(iToken: Byte; i0, i1, i2, i3: Integer; iLeft_Ch, iRight_Ch: TKnoten);
                    constructor Load(S: TFileStream);
                    constructor Load32(R: TReader);
                    destructor  Destroy; override;
                    procedure   Write4Int(    n0, n1, n2, n3 : Integer);
                    procedure   Read4Int (var n0, n1, n2, n3 : Integer);
                    function    GetVInt(i: Integer): Integer;
                    function    IsEqual(kn: TKnoten): Boolean;
                    procedure   SwitchChildren;
                    procedure   OverwriteWithLeftChild;
                    procedure   OverwriteWithRightChild;
                  end;

      { TOKEN für TT(erm)Baum :

                  0 = reelle Konstante;
                  1 = Funktionsvariable   ( üblicherweise x );
                  2 = Plus
                  3 = Minus
                  4 = Mal
                  5 = Geteilt
                  6 = Hoch
                  7 = Klammerterm
                  8 = Sinus                                  [f_num =  1]
                  9 = Cosinus                                [f_num =  2]
                 10 = Tangens                                [f_num =  3]
                 11 = Quadratwurzel                          [f_num =  4]
                 12 = natuerlicher Logarithmus               [f_num =  5]
                 13 = natuerliche Exponentialfunktion        [f_num =  6]
                 14 = Zehnerlogarithmus                      [f_num =  7]
                 15 = Arcus-Tangens                          [f_num =  8]
                 16 = (-1) * ......       ( Change sign )    [f_num =  9]
                 17 = Absolutbetrag                          [f_num = 10]
                 18 = Quadrat                                [f_num = 11]
                 19 = Ganzzahliger Anteil ( INT )            [f_num = 12]
                 20 = Nachkomma-Anteil    ( FRAC )           [f_num = 13]
                 21 = Normalverteilung    ( GAUSSFUNKTION )  [f_num = 14]

                 22 = Abstandsobjekt      ( nur für EUKLID ) [f_num = 15]
                 23 = Winkelweitenobjekt  ( nur für EUKLID ) [f_num = 16]

                 24 = Arcus-Sinus                            [f_num = 17]
                 25 = Arcus-Cosinus                          [f_num = 18]

                 26 = x-Koordinate        ( nur für EUKLID ) [f_num = 19]
                 27 = y-Koordinate        ( nur für EUKLID ) [f_num = 20]
                 28 = Strecken-/Bogenlänge( nur für EUKLID ) [f_num = 21]
                 29 = Kreisradius         ( nur für EUKLID ) [f_num = 22]
                 30 = Fläche              ( nur für EUKLID ) [f_num = 23]
                 31 = Zahlobjekt-Wert oder
                      Streckenlänge       ( nur für EUKLID ) [f_num = 24]
                 32 = Teilverhältnis      ( nur für EUKLID ) [f_num = 25]

                 33 = floor  ( "GrößteGanze"-Funktion, [x] ) [f_num = 26]
                 34 = ceil   ( "KleinsteGanze"-Funktion    ) [f_num = 27]
                 35 = Vorzeichen-Funktion                    [f_num = 28]
                 36 = Grad   ( Bogenmaß in Gradmaß )         [f_num = 29]
                 37 = Bogen  ( Gradmaß in Bogenmaß )         [f_num = 30]
                 38 = Rnd    ( Rundungs-Funktion, ROUND )    [f_num = 31]

                 39 = if     ( Schalter-Funktion )           [f_num = 32]
                 40 = Random ( Zufallszahlen )               [f_num = 33]

                 41 = Steigung            ( nur für EUKLID ) [f_num = 34]

                 49 = Funktionsobjekt     ( nur für EUKLID ) [f_num = 42]

                 50 = Gradzeichen (°, wandelt ins Bogenmaß um)
                      [ohne Kompatibilitätsprobleme verallgemeinerbar
                       zu einer universellen Maßeinheiten-Funktion mit
                       Selektor-Feld "value":
                          value = 0  <==>  °-Funktion
                          value = 1  <==>  ???
                          value = 2  <==>  ??? ....                    ] }

      { TOKEN für TBoolBaum :

                101 : '='
                102 : '<'
                103 : '<='
                104 : '>'
                105 : '>='
                106 : '<>'
                107 : 'OR'
                108 : 'XOR'
                109 : 'AND'
                110 : 'NOT'
                111 : 'TRUE'
                112 : 'FALSE'
                113 : '('...')' ( Klammerterm )

                141 : 'PARALL'  ( Parallelitäts-Test )     [f_num = 1]
                142 : 'ORTHO'   ( Orthogonalitäts-Test )   [f_num = 2]
                143 : 'INCID'   ( Inzidenz-Test )          [f_num = 3]
                144 : 'VALID'   ( Gültigkeits-Test )       [f_num = 4]

                200 : Term-Vergleich                                }


     tbStatTyp    = (tbEmpty, tbCompError, tbCalcError, tbOkay);
     AngleModeTyp = (Deg, Rad);

     TTBaum = class(TPersistent)
              private
                FAngleMode : AngleModeTyp;
                function IsEuklidFunc(fn: Integer): Boolean;
                function TVCalculated(knot: TKnoten; var tv: Double): Boolean;
                function OldCoordFuncUsed(s: String): Boolean;
                function Convert2OnlyRAD(st : WideString; isAngleTerm: Boolean): WideString;
                function CopyKnot (source_knot: TKnoten) : TKnoten;
//              function GetParentNode(knot: TKnoten):  TKnoten;
                function Derive(knot: TKnoten): TKnoten;
                function messwertnumobj(f_num : Integer; var s : WideString) : TKnoten;
                function term (VAR s : WideString) : TKnoten;
                function tbs (tb : TKnoten; GeometriaExport: Boolean = False) : WideString;
                function SubstGeoNumsWithNames(gns: String; MakNum: Integer): String;
                procedure transformDegTerm2Rad(tb: TKnoten);
                procedure transformTrig(tb: TKnoten);
                procedure deleteTrigLoops(knot: TKnoten);
                procedure Simplify(knot: TKnoten);
                procedure AdjustSourceStr;
              public
                baum       : TKnoten;
                Drawing    : TObject;
                source_str : WideString;
                fgeonum_str,
                error_str  : STRING;
                error_spot : Integer;
                status     : tbStatTyp;
                constructor Create(iDrawing: TObject; iAngleMode: AngleModeTyp);
                constructor CopyFrom(source: TTBaum);
                constructor CreateFromGeoNumString(gns: String; MakNum: Integer; iDrawing: TObject);
                constructor CreateDerivationOf(source: TTBaum);
                constructor Load (iDrawing: TObject; S: TFileStream);
                constructor Load32 (iDrawing: TObject; R: TReader);
                destructor  Destroy; override;

                function  is_okay      : Boolean;
                function  is_const     : Boolean;
                function  is_angle     : Boolean;
                function  is_trig      : Boolean;
                function  is_random    : Boolean;
                function  is_estimated : Boolean;
                function  HasSameDataAs(vb: TTBaum): Boolean;
                function  GetHTMLString(calculateValues: Boolean = false): String;
                function  containsToken(t_id: Integer): Boolean;
                function  ContainsADescendentOf(GO: TObject;
                                                var si: Integer): Boolean;
                procedure RegisterTermParentsIn(GO: TObject);
                procedure UnregisterTermParentsIn(GO: TObject);
                procedure UpdateDegSourceAndBuildTree(st: WideString; isAngleTerm: Boolean);
                procedure BuildTree(st: WideString);
                procedure BuildTreeAndReturn(var st: WideString);
                procedure Calculate(x     : Double; var y : Double);
                procedure Integrate(aa, bb: Double; var ss: Double);
                procedure BuildString;
                procedure ChangeSign;
                procedure SetNewNames(MakroNum: Integer);
                procedure KillDirectMOLinks;
                procedure GetInfo(var info : STRING; NameList: TList);
                procedure ConvertSource2GeoNumString;
                function  GeoNumString: String;
                procedure Reset;
              end;

     TBoolBaum = class(TPersistent)
              protected
                FBaum      : TKnoten;
                FOkay      : Boolean;
                FSourceStr : WideString;
                FErrMsg    : String;
                FErrSpot   : Integer;
                FAngleMode : AngleModeTyp;
                Drawing    : TObject;
                function BoolExpr(var s: WideString) : TKnoten;
                function BoolTerm(var s: WideString) : TKnoten;
                function OrTerm(var s: WideString) : TKnoten;
                function AndTerm(var s: WideString) : TKnoten;
                function GetBoolFuncIndex(s: WideString): Integer;
                function GetGeoNumFrom(var s: WideString): Integer;
                function BFArgsValid(fn: Integer; nr: Array of Integer): Boolean;
                function BoolFunc(var s: WideString): TKnoten;
                function BoolConst(var s: WideString): TKnoten;
                function CompRTerm(var s: WideString): TKnoten;
                procedure transformTrig(k: TKnoten);
                procedure transformAngleRefs(k: TKnoten);
              public
                constructor Create(iDrawing: TObject; iAngleMode: AngleModeTyp; s: WideString);
                destructor  Destroy; override;
                function BuildTreeAndReturn(var s: WideString): Boolean;
                function Calculate(x: Double): Boolean;
                function GetHTMLString: String;
                function GeoNumStr: String;
                function ContainsADescendentOf(GO: TObject;
                                               var si: Integer): Boolean;
                procedure RegisterTermParentsIn(GO: TObject);
                procedure UnregisterTermParentsIn(GO: TObject);
                procedure RebuildSourceStr;
                property IsOkay: Boolean read FOkay;
                property SourceStr: WideString read FSourceStr;
                property ErrorMsg: String read FErrMsg;
                property ErrorSpot: Integer read FErrSpot;
              end;

CONST  EuklidToken : SET OF BYTE = [22, 23, 26..32, 41, 49];

FUNCTION TreesAreEquivalent      (    tb1, tb2   : TKnoten): Boolean;
function GetAntialiasedStepCount (    tb         : TTBaum;
                                      xmin, xmax : Double;
                                  var steps      : Integer): Boolean;


IMPLEMENTATION

USES Math, SysUtils, GlobVars, Utility, MathLib,
     GeoTypes, GeoHelper, GeoConic, GeoLocLines, Graphics, GeoMakro;

resourcestring

  tbmsg00 = 'Unbekanntes Objekt !';
  tbmsg01 = '";" erwartet !';
  tbmsg02 = 'Ungültiges Winkelmaß-Objekt !';
  tbmsg03 = 'Syntaxfehler !';
  tbmsg04 = ''' erwartet !';
  tbmsg05 = '"(" erwartet !';
  tbmsg06 = 'Unbekannter Bezeichner !';
  tbmsg07 = 'Faktor erwartet !';
  tbmsg08 = 'Exponent erwartet !';
  tbmsg09 = 'Division durch Null !';
  tbmsg10 = 'Unzulässiges Argument !';
  tbmsg11 = 'Negativer Radikand !';
  tbmsg12 = 'LN-Argument muss positiv sein!';
  tbmsg13 = 'LOG-Argument muss positiv sein!';
  tbmsg14 = 'Abstand nicht gefunden !';
  tbmsg15 = 'Winkelweite nicht gefunden !';
  tbmsg16 = 'Unbekannter Operator !';
  tbmsg17 = 'Summand erwartet !';
  tbmsg18 = 'Kein passendes Objekt gefunden !';
  tbmsg19 = 'Falscher Objekttyp !';
  tbmsg20 = 'Bereichsüberschreitung !';
  tbmsg21 = 'Sie haben die alten Funktionsbezeichner cx( ) bzw. cy( ) für den Zugriff'#13#10 +
            'auf Punkt-Koordinaten verwendet. Diese werden nicht mehr unterstützt.'#13#10 +
            'Benutzen Sie bitte stattdessen die neuen Funktionen x( ) und y( ) !';
  tbmsg22 = 'Eine benutzerdefinierte Funktion konnte nicht ausgewertet werden!';
  tbmsg23 = 'Wert nicht verfügbar!';

  bbmsg00 = 'Unerwartetes Zeichen!';
  bbmsg01 = 'Unerwarteter Operator!';
  bbmsg02 = 'Bool''scher Ausdruck erwartet!';
  bbmsg03 = '%s erwartet!';


const anz_f       = 34;
      op_name     : STRING  = 'x+-*/';
      f_name      : ARRAY [1..anz_f] OF STRING =
                          ('SIN', 'COS', 'TAN', 'SQRT',
                           'LN', 'EXP', 'LOG', 'ARCTAN',
                           'CS', 'ABS', 'SQR', 'INT',
                           'FRAC', 'NORMAL',
                           'D',               { Distanz             }
                           'W',               { Winkelweite         }
                           'ARCSIN', 'ARCCOS',
                           'X', 'Y',          { Koordinaten-Werte   }
                           'LEN', 'RADIUS',   { lineare Abmessungen }
                           'AREA',            { Flächeninhalte      }
                           'VAL',             { Zahlobjekt-Wert     }
                           'TV',              { Teilverhältnis      }
                           'FLOOR',     { GrößteGanzeKleinerGleich  }
                           'CEIL',      { KleinsteGanzeGrößerGleich }
                           'SGN',       { Vorzeichen-Funktion       }
                           'GRAD',      { vom Bogenmaß ins Gradmaß  }
                           'BOGEN',     { vom Gradmaß ins Bogenmaß  }
                           'RND',       { Rundungs-Funktion         }
                           'IF',        { Schalter-Funktion         }
                           'RANDOM',    { Zufallszahlen-Funktion    }
                           'SLOPE');    { Steigungs-Funktion        }
      anz_bf      = 4;
      bf_name     : ARRAY [1..anz_bf] of String =
                          ('PARALL',    { Parallelitäts-Test,   [token = 141] }
                           'ORTHO',     { Orthogonalitäts-Test, [token = 142] }
                           'INCID',     { Inzidenz-Test,        [token = 143] }
                           'VALID');    { Gültigkeits-Test,     [token = 144] }

      bfBase      = 140;                { bei (bfBase + 1) beginnen die Token
                                          der bool'schen DynaGeo-Funktionen }

      MaxTBMsgIndex = 23;
      TBMsg       : Array [0..MaxTBMsgIndex] of String =
                          (tbmsg00, tbmsg01, tbmsg02, tbmsg03, tbmsg04,
                           tbmsg05, tbmsg06, tbmsg07, tbmsg08, tbmsg09,
                           tbmsg10, tbmsg11, tbmsg12, tbmsg13, tbmsg14,
                           tbmsg15, tbmsg16, tbmsg17, tbmsg18, tbmsg19,
                           tbmsg20, tbmsg21, tbmsg22, tbmsg23);


{ Hilfsprozeduren fürs Lesen aus Streams (für alte Dateien *vor* 2.7 }

function GetKnot(S : TFileStream) : TKnoten;
  var idNum : Word;
  begin
  GetKnot := Nil;
  S.Read(idNum, SizeOf(idNum));
  If idNum = 141 then
    GetKnot := tKnoten.Load(S);
  end;

function GetKnot32(R: TReader): tKnoten;
  begin
  If R.ReadBoolean then
    GetKnot32 := tKnoten.Load32(R)
  else
    GetKnot32 := Nil;
  end;


{ Weitere Hilfs-Prozeduren }

function GetDynaGeoObjsFrom(kn: TKnoten; Drawing: TGeoObjListe;
                            var GO1, GO2, GO3, GO4: TGeoObj): Boolean;
  var gn : Array[0..3] of Integer;
  begin
  kn.Read4Int(gn[0], gn[1], gn[2], gn[3]);
  try
    GO1 := TGeoObjListe(Drawing).GetValidObj(gn[0]);
    GO2 := TGeoObjListe(Drawing).GetValidObj(gn[1]);
    GO3 := TGeoObjListe(Drawing).GetValidObj(gn[2]);
    GO4 := TGeoObjListe(Drawing).GetValidObj(gn[3]);
    Result := True;
  except
    Result := False;
  end; { of try }
  end;


function GetBFParamListFrom(Drawing: TGeoObjListe; kn: TKnoten): String;
  var gn : Array[0..3] of Integer;
      GO : TGeoObj;
      s  : String;
      i  : Integer;
  begin
  kn.Read4Int(gn[0], gn[1], gn[2], gn[3]);
  For i := 0 to 3 do
    If gn[i] > 0 then begin
      GO := TGeoObjListe(Drawing).GetValidObj(gn[i]);
      If GO <> Nil then
        s := s + GO.Name + '; '
      else
        s := s + '?; ';
      end
    else if gn[i] < 0 then
      s := s + '@' + IntToStr(Abs(gn[i])) + '; ';
  Delete(s, Length(s) - 1, 2);
  Result := s;
  end;


function GetBFGeoNumParamList(Drawing: TGeoObjListe; kn: TKnoten): String;
  var gn : Array[0..3] of Integer;
      GO : TGeoObj;
      s  : String;
      i  : Integer;
  begin
  kn.Read4Int(gn[0], gn[1], gn[2], gn[3]);
  For i := 0 to 3 do
    If gn[i] > 0 then begin
      GO := TGeoObjListe(Drawing).GetValidObj(gn[i]);
      If GO <> Nil then
        s := s + '%' + IntToStr(GO.GeoNum) + '; '
      else
        s := s + '???; ';
      end
    else if gn[i] < 0 then
      s := s + '@' + IntToStr(Abs(gn[i])) + '; ';
  Delete(s, Length(s) - 1, 2);
  Result := s;
  end;


function IsParallelPointPairs(GO1, GO2, GO3, GO4: TGPoint): Boolean;
  var dx1, dy1, dx2, dy2, d1, d2 : Double;
  begin
  dx1 := GO2.X - GO1.X;  dy1 := GO2.Y - GO1.Y;
  dx2 := GO4.X - GO3.X;  dy2 := GO4.Y - GO3.Y;
  d1 := Hypot(dx1, dy1); d2 := Hypot(dx2, dy2);
  If (d1 > epsilon) and (d2 > epsilon) then begin
    dx1 := dx1 / d1;   dy1 := dy1 / d1;
    dx2 := dx2 / d2;   dy2 := dy2 / d2;
    Result := dx1 * dy2 - dy1 * dx2 < epsilon;
    end
  else
    Result := False;
  end;


function IsOrthogonalPointPairs(GO1, GO2, GO3, GO4: TGPoint): Boolean;
  var dx1, dy1, dx2, dy2, d1, d2 : Double;
  begin
  dx1 := GO2.X - GO1.X;  dy1 := GO2.Y - GO1.Y;
  dx2 := GO4.X - GO3.X;  dy2 := GO4.Y - GO3.Y;
  d1 := Hypot(dx1, dy1); d2 := Hypot(dx2, dy2);
  If (d1 > epsilon) and (d2 > epsilon) then begin
    dx1 := dx1 / d1;   dy1 := dy1 / d1;
    dx2 := dx2 / d2;   dy2 := dy2 / d2;
    Result := dx1 * dx2 + dy1 * dy2 < epsilon;
    end
  else
    Result := False;
  end;


function GetAntialiasedStepCount (    tb         : TTBaum;
                                      xmin, xmax : Double;
                                  var steps      : Integer): Boolean;
  var ttb: TTBaum;

  procedure CheckKnot(knot: TKnoten);
    { Mustert alle Term-Knoten durch, ob problematische Funktionen darin
      enthalten sind. Falls welche gefunden werden, wird die Belegung des
      Intervalls mit Stützpunkten entsprechend verfeinert.               }

    procedure CheckPeriod(PT: Double);
      { Wenn bei Erhöhung der Variablen x um 1 der Argument-Term der proble-
        matischen Funktion um einmal die übergebene Periodendauer PT wächst,
        dann werden auf dieser Strecke 3 Punkte eingefügt, im ganzen x-Anzeige-
        Intervall also Round(3 * (xmax - xmin)). Drängeln sich mehr als eine
        Periode auf der Einheitsstrecke, wird die Dichte der Stützpunkte ent-
        sprechend erhöht. Die maximal zugelassene Stützpunkt-Anzahl ist 350.   }
      var k, x,
          arg1, arg2 : Double;
          n : Integer;
      begin
      ttb.baum.Free;
      ttb.baum := ttb.CopyKnot(knot.right_ch);
      k := 3 / PT * (xmax - xmin);
      x := xmin;
      ttb.Calculate(x, arg2);
      While x < xmax do begin
        arg1 := arg2;
        x    := x + 1;
        ttb.Calculate(x, arg2);
        n  := Round(Abs(arg2 - arg1) * k);
        If n > steps then
          steps := Min(n, 350);
        end;
      end;

    begin
    Case knot.token of
       8,                          // sin
       9,                          // cos
      10 : CheckPeriod(2*pi);      // tan
      19,                          // int
      20,                          // frac
      40 : If steps < 100 then     // random
             steps := 100;
      33,                          // floor
      34,                          // ceil
      38 : CheckPeriod(1);         // round
    end;
    Case knot.token of
      39 : begin
           CheckKnot(TBoolBaum(knot.left_ch).FBaum);
           CheckKnot(knot.right_ch);
           end;
     200 : begin
           CheckKnot(TTBaum(knot.left_ch).baum);
           CheckKnot(TTBaum(knot.right_ch).baum);
           end;
    else
      If knot.left_ch  <> Nil then CheckKnot(knot.left_ch );
      If knot.right_ch <> Nil then CheckKnot(knot.right_ch);
    end;
    end;

  begin
  ttb := TTBaum.Create(tb.Drawing, tb.FAngleMode);
  try
    CheckKnot(tb.baum);
    Result := True;
  finally
    ttb.Free;
  end;
  end;


{-----------------------------------------------}
{ TKnoten's Methods Implementation              }
{-----------------------------------------------}


constructor tknoten.Create(iToken: Byte; iValue: Double; iLeft_Ch, iRight_Ch: TKnoten);
  begin
  Inherited Create;
  Token := iToken;
  Value := iValue;
  left_ch  := iLeft_Ch;
  right_ch := iRight_Ch;
  end;

constructor tknoten.Init4Int(iToken: Byte; i0, i1, i2, i3: Integer; iLeft_Ch, iRight_Ch: TKnoten);
  begin
  Inherited Create;
  Token := iToken;
  Write4Int(i0, i1, i2, i3);
  left_ch  := iLeft_Ch;
  right_ch := iRight_Ch;
  end;

constructor tknoten.Load(S: TFileStream);
  begin
  S.Read(token, SizeOf(token));
  S.Read(value, SizeOf(value));
  left_ch  := TKnoten(GetKnot(S));
  right_ch := TKnoten(GetKnot(S));
  end;

constructor tKnoten.Load32(R: TReader);
  begin
  token := R.ReadInteger;
  value := R.ReadFloat;
  left_ch  := GetKnot32(R);
  right_ch := GetKnot32(R);
  end;

procedure tknoten.Write4Int(n0, n1, n2, n3 : Integer);
  var ibuf : Array [0..3] of SmallInt;
      dbuf : Double Absolute ibuf;
  begin
  ibuf[0] := n0;
  ibuf[1] := n1;
  ibuf[2] := n2;
  ibuf[3] := n3;
  value := dbuf;
  end;

procedure tknoten.Read4Int(var n0, n1, n2, n3 : Integer);
  var ibuf : Array [0..3] of SmallInt;
      dbuf : Double Absolute ibuf;
  begin
  dbuf := value;
  n0 := ibuf[0];
  n1 := ibuf[1];
  n2 := ibuf[2];
  n3 := ibuf[3];
  end;

function tknoten.GetVInt(i: Integer): Integer;
  var ibuf : Array [0..3] of SmallInt;
      dbuf : Double Absolute ibuf;
  begin
  dbuf   := value;
  Result := ibuf[i];
  end;

function tknoten.IsEqual(kn: TKnoten): Boolean;
  begin
  If (kn = Nil) or (token <> kn.token) or (value <> kn.value) then
    Result := false
  else begin
    if left_ch = Nil then
      Result := kn.left_ch = Nil
    else
      Result := left_ch.IsEqual(kn.left_ch);
    if Result then
      if right_ch = Nil then
        Result := kn.right_ch = Nil
      else
        Result := right_ch.IsEqual(kn.right_ch);
    end;
  end;

procedure tknoten.SwitchChildren;
  var pu : tknoten;
  begin
  pu       := right_ch;
  right_ch := left_ch;
  left_ch  := pu;
  end;

procedure tknoten.OverwriteWithLeftChild;
  var to_del : TKnoten;
  begin
  If left_ch <> Nil then begin
    to_del := left_ch;
    token := to_del.token;
    value := to_del.value;
    right_ch.Free;
    right_ch := to_del.right_ch;
    to_del.right_ch := Nil;
    left_ch := to_del.left_ch;
    to_del.left_ch := Nil;
    to_del.Free;
    end;
  end;

procedure tknoten.OverwriteWithRightChild;
  var to_del : TKnoten;
  begin
  If right_ch <> Nil then begin
    to_del := right_ch;
    token := to_del.token;
    value := to_del.value;
    left_ch.Free;
    left_ch := to_del.left_ch;
    to_del.left_ch := Nil;
    right_ch := to_del.right_ch;
    to_del.right_ch := Nil;
    to_del.Free;
    end;
  end;

destructor tknoten.Destroy;
  begin
  Case token of
     39 : begin
          FreeAndNil(TBoolBaum(left_ch));
          FreeAndNil(TTBaum(right_ch.left_ch));
          FreeAndNil(TTBaum(right_ch.right_ch));
          FreeAndNil(right_ch);
          end;
    200 : begin
          FreeAndNil(TTBaum(left_ch));
          FreeAndNil(TTBaum(right_ch));
          end;
  else
    FreeAndNil(left_ch);
    FreeAndNil(right_ch);
  end; { of case }
  Inherited Destroy;
  end;


{ ============ Hilfsprozeduren ================================}


FUNCTION TreesAreEquivalent(tb1, tb2 : TKnoten): BOOLEAN;
  begin
  If tb1 <> Nil then
    If tb2 <> Nil then
      If tb1.token = tb2.token then
        Case tb1.token of
           0 : TreesAreEquivalent := tb1.value = tb2.value;
          22,
          23,
          49 : TreesAreEquivalent :=
                 TreesAreEquivalent(tb1.right_ch.right_ch,
                                    tb2.right_ch.right_ch);
        else
          TreesAreEquivalent :=
            TreesAreEquivalent(tb1.left_ch,  tb2.left_ch ) and
            TreesAreEquivalent(tb1.right_ch, tb2.right_ch);
        end { of case }
      else
        TreesAreEquivalent := False
    else
      TreesAreEquivalent := False
  else
    TreesAreEquivalent := tb2 = Nil;
  end;


PROCEDURE CutFirst_wB (var St: WideString; count: Integer);
  { löscht die ersten count Zeichen aus st, sowie alle direkt darauf folgenden Leerzeichen }
  BEGIN
  IF count > 0 THEN
    DELETE(st, 1, count);
  WHILE (LENGTH(st) > 0) AND
        (st[1] = ' ') DO
    DELETE(st, 1, 1);
  END;


PROCEDURE KillLeadingBlanks (Var st: WideString);
  BEGIN
  WHILE (Length(st) > 0) and (st[1] = ' ') DO
    DELETE(st, 1, 1);
  END;


{-----------------------------------------------}
{ TTBaum's Methods Implementation               }
{-----------------------------------------------}


CONSTRUCTOR TTBaum.Create(iDrawing: TObject; iAngleMode: AngleModeTyp);
  BEGIN
  Inherited Create;
  baum       := NIL;
  Drawing    := iDrawing;
  FAngleMode := iAngleMode;
  source_str := '';
  error_str  := '';
  error_spot := 0;
  status     := tbEmpty;
  END;


CONSTRUCTOR TTBaum.CopyFrom (source: TTBaum);
  BEGIN
  Inherited Create;
  source_str := source.source_str;
  error_str  := source.error_str;
  error_spot := source.error_spot;
  status     := source.status;
  FAngleMode := source.FAngleMode;
  baum       := CopyKnot(source.baum);
  END;


CONSTRUCTOR TTBaum.CreateFromGeoNumString(gns: String; MakNum: Integer; iDrawing: TObject);
  var ss : String;
  BEGIN
  Inherited Create;
  baum       := NIL;
  Drawing    := iDrawing;
  FAngleMode := Deg;
  error_str  := '';
  error_spot := 0;
  Status     := tbEmpty;
  ss := SubstGeoNumsWithNames(gns, MakNum);
  If Status = tbEmpty then
    BuildTree(ss);
  END;


CONSTRUCTOR TTBaum.CreateDerivationOf(source: TTBaum);
  var v1, v2    : Double;
      oriSource : String;
  BEGIN
  Create(source.Drawing, source.FAngleMode);
  try
    baum   := Derive(source.baum);
    if Assigned(baum) then begin
      Calculate(1, v1);
      if Status = tbOkay then begin
        BuildString;
        oriSource := source_str;
        Simplify(baum);
        Calculate(1, v2);
        if (Status <> tbOkay) or (Not IsEqual(v1, v2)) then begin
          BuildTree(oriSource);
          SpyOut('Failed to simplify f'' with f''(x) = %s',
                 [oriSource]);
          end;
        end;
      end
    else
      Status := tbCompError;
  except
    Status := tbCompError;
  end;
  END;


CONSTRUCTOR TTBaum.Load(iDrawing: TObject; S: TFileStream);
  var pu : String[255];
      n  : SmallInt;
  BEGIN
  Drawing := iDrawing;
  n := ReadOldIntFromStream(S);
  If n = 140 then
    n := ReadOldIntFromStream(S);
  status := tbStatTyp(Lo(n));
  S.Position := S.Position - 1;
  S.Read(pu, SizeOf(pu));
  source_str := WideString(pu);
  AdjustSourceStr;
  FAngleMode := Deg;
  error_str  := '';
  error_spot := 0;
  baum := TKnoten(GetKnot(S));
  END;


CONSTRUCTOR TTBaum.Load32(iDrawing: TObject; R: TReader);
  BEGIN
  Drawing    := iDrawing;
  Status     := TBStatTyp(R.ReadInteger);
  source_str := R.ReadString;
  AdjustSourceStr;
  If (R.NextValue in [vaString, vaLString, vaWString]) and
     (R.ReadString = 'AngleMode') then
    FAngleMode := AngleModeTyp(R.ReadInteger)
  else
    FAngleMode := Deg;
  baum := TKnoten(GetKnot32(R));
  END;


FUNCTION TTBaum.CopyKnot (source_knot: TKnoten) : TKnoten;
  { Creates a "deep copy" of the object ! }
  begin
  If source_knot <> Nil then with source_knot do
    Result := TKnoten.Create(token, value, CopyKnot(left_ch), CopyKnot(right_ch))
  else
    Result := Nil;
  end;

(*
function TTBaum.GetParentNode(knot: TKnoten): TKnoten;
  function knotIsChildOf(seed: TKnoten): TKnoten;
    begin
    If seed <> Nil then
      If (seed.left_ch = knot) or (seed.right_ch = knot) then
        Result := seed
      else begin
        Result := knotIsChildOf(seed.left_ch);
        If Result = Nil then
          Result := knotIsChildOf(seed.right_ch);
        end
    else
      Result := Nil;
    end;

  begin
  Result := knotIsChildOf(baum);
  end;
*)

FUNCTION TTBaum.is_okay : BOOLEAN;
  BEGIN
  is_okay := status = tbOkay;
  END;


function TTBaum.is_const : Boolean;
  function ic(k: TKnoten): Boolean;
    begin
    Result := (k.token = 0) or
              ((k.token = 16) and ic(k.right_ch)) or
              ((k.token = 50) and ic(k.left_ch))
    end;
  begin
  is_const := (baum <> Nil) and ic(baum);
  end;


function TTBaum.is_angle : Boolean;

  function isAngle(knot: TKnoten): Boolean;
    begin
    If Assigned(knot) then
      Case knot.token of
         2,  3 : Result := isAngle(knot.left_ch) and // Addition, Subtraktion
                           isAngle(knot.right_ch);
         4     : Result := isAngle(knot.left_ch) or  // Multiplikation
                           isAngle(knot.right_ch);
         5,  6 : Result := isAngle(knot.left_ch);    // Division, Potenzieren
         7, 16,                                      // Klammern, ChangeSign,
        17     : Result := isAngle(knot.right_ch);   // Betrag
        23, 50 : Result := True;                     // Winkelmaß, Gradzeichen
      else
        Result := False;
      end { of case }
    else
      Result := False;
    end;

  begin
  Result := isAngle(baum);
  end;


function TTBaum.is_trig : Boolean;
  { Liefert genau dann true, wenn die Funktion (quasi-)
    periodisch zu sein scheint (daher zusätzlich "frac" ! }
  const trig_token = [8, 9, 10, 20];  // sin, cos, tan, frac

  function trig(knot: TKnoten): Boolean;
    begin
    If knot = Nil then
      Result := False
    else
      if knot.token = 39 then
        Result := trig(TTBaum(knot.right_ch.left_ch).baum) or
                  trig(TTBaum(knot.right_ch.right_ch).baum)
      else
        Result := (knot.token in trig_token)
                  or trig(knot.left_ch)
                  or trig(knot.right_ch);
    end;

  begin
  Result := trig(baum);
  end;

  
function TTBaum.is_random : Boolean;

  function isRandom(knot: TKnoten): Boolean;
    begin
    If knot = Nil then
      Result := False
    else
      if knot.token = 39 then
        Result := isRandom(TTBaum(knot.right_ch.left_ch).baum) or
                  isRandom(TTBaum(knot.right_ch.right_ch).baum)
      else
        Result := (knot.token = 40)
                  or isRandom(knot.left_ch)
                  or isRandom(knot.right_ch);
    end;

  begin
  Result := isRandom(baum);
  end;


function TTBaum.is_estimated : Boolean;

  function estimated (knot: TKnoten): Boolean;
    var GeoObj : TGeoObj;
    begin
    If knot = Nil then
      Result := False
    else
      Case knot.token of
        30 : begin
             GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(knot.right_ch.value));
             If (GeoObj = NIL) or (GeoObj is TGIntArea) then
               Result := False
             else
               Result := (GeoObj is TGArea) and
                         ((GeoObj.Parent.Count > 1) or
                          (Not TGLine(GeoObj.Parent[0]).IsClosedLine));
             end;
        31 : begin
             GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(knot.right_ch.value));
             If GeoObj = Nil then
               Result := False
             else
               Result := (GeoObj is TGTermObj) and
                         (GeoObj as TGTermObj).IsEstimated;
             end;
        39 : Result := estimated(TTBaum(knot.right_ch.left_ch).baum) or
                       estimated(TTBaum(knot.right_ch.right_ch).baum);
      else
        Result := estimated(knot.left_ch) or
                  estimated(knot.right_ch);
      end; { of case }
    end;

  begin
  Result := estimated(baum);
  end; { of is_estimated }

function TTBaum.IsEuklidFunc(fn: Integer): Boolean;
  begin
  Result := (fn + 7) in EuklidToken;
  end;


function TTBaum.OldCoordFuncUsed(s : String): Boolean;
  begin
  DeleteChars(' ', s);
  s := UpperCase(s);
  Result := (POS('CX(', s) = 1) or
            (Pos('CY(', s) = 1)
  end;


function TTBaum.ContainsADescendentOf(GO: TObject; var si: Integer): Boolean;
  { si enthält die Position vom Namen des gefundenen
       Abkömmlings im Source-String "source_str"      }
  procedure Check(knot : TKnoten);
    var MO : TGeoObj;
    begin
    If (Not Result) and
       (knot <> Nil) then
      with knot do begin
        If token In EuklidToken then begin
          if token = 41 then
            MO := TGeoObj(GO).Objlist.GetValidObj(right_ch.GetVInt(0))
          else
            MO := TGeoObj(GO).ObjList.GetValidObj(ROUND(right_ch.value));
          If (TGeoObj(GO) = MO) or TGeoObj(GO).IsAncestorOf(MO) then begin
            Result := True;
            si := POS(MO.Name, source_str);
            If si < 0 then
              si := 0;
            end;
          end
        else
          if token = 39 then begin
            Result := TBoolBaum(left_ch).ContainsADescendentOf(GO, si);
            If Not Result then
              Check(TTBaum(right_ch.left_ch).baum);
            If Not Result then
              Check(TTBaum(right_ch.right_ch).baum);
            end
          else begin
            Check(left_ch);
            Check(right_ch);
            end;
        end;
    end;

  begin
  si := 0;
  Result := False;
  If GO <> Nil then
    Check(baum);
  end;


function TTBaum.SubstGeoNumsWithNames(gns: String; MakNum: Integer): String;
  var zs    : String;
      GO    : TGeoObj;
      n, gn : Integer;
      Makro : TMakro;
  begin
  Result := '';
  Status := tbEmpty;
  n := Pos('%', gns);
  Makro := TGeoObjListe(Drawing).MakroList[MakNum];
  While (Status = tbEmpty) and
        (n > 0) do begin
    Delete(gns, n, 1);
    zs := '';
    While (Length(gns) >= n) and
          CharInSet(gns[n], ['0'..'9']) do begin
      zs := zs + gns[n];
      Delete(gns, n, 1);
      end;
    gn := StrToInt(zs);
    GO := Makro.GetNewObj(gn);
    If GO <> Nil then begin
      Insert(GO.Name, gns, n);
      n := Pos('%', gns);
      end
    else
      Status := tbCompError;
    end;
  If Status = tbEmpty then
    Result := gns;
  end;

procedure TTBaum.Simplify(knot: TKnoten);

  procedure ShiftConstantFactorsToTheLeft(kn: TKnoten);
    begin
    If (kn.token = 4) and
       (kn.right_ch.token = 0) and
       (kn.left_ch.token <> 0) then
      kn.SwitchChildren;
    If kn.left_ch  <> Nil then ShiftConstantFactorsToTheLeft(kn.left_ch);
    If kn.right_ch <> Nil then ShiftConstantFactorsToTheLeft(kn.right_ch);
    end;

  procedure UniteNearbyFactors(kn: TKnoten);
    var sn,           //  buffer for the "s"uperfluous "n"ode
        tn : TKnoten; //  buffer for the "t"arget "n"ode
    begin
    if (kn.token = 4) and
       (kn.left_ch.token = 0) then begin
      if kn.right_ch.token = 0 then begin                    // Fall 1
        kn.value := kn.right_ch.value * kn.left_ch.value;
        kn.token := 0;
        FreeAndNil(kn.left_ch);
        FreeAndNil(kn.right_ch);
        end
      else
      if (kn.right_ch.token = 4) and
         (kn.right_ch.left_ch.token = 0) then begin          // Fall 2
        sn := kn.right_ch;
        tn := kn.left_ch;
        tn.value := tn.value * sn.left_ch.value;  // 10.01.10: ".left_ch" inserted here
        kn.right_ch := sn.right_ch;               //   (BugReport of Guenther Weber)
        sn.right_ch := Nil;
        sn.Free;
        end;
      end
    else
    if (kn.token = 5) and
       (kn.right_ch.token = 4) and
       (kn.right_ch.left_ch.token = 0) then begin
      sn := kn.right_ch;
      if (kn.left_ch.token = 0) then
        tn := kn.left_ch                                     // Fall 4
      else if (kn.left_ch.token = 4) and
         (kn.left_ch.left_ch.token = 0) then
        tn := kn.left_ch.left_ch                             // Fall 3
      else
        tn := Nil;
      if (tn <> Nil) and (abs(sn.left_ch.value) > MathLib.epsilon) then begin
        tn.value := tn.value / sn.left_ch.value;
        kn.right_ch := sn.right_ch;
        sn.right_ch := Nil;
        sn.Free;
        end;
      end;
    If kn.left_ch  <> Nil then UniteNearbyFactors(kn.left_ch );
    If kn.right_ch <> Nil then UniteNearbyFactors(kn.right_ch);
    end;

  procedure FreeSingleConstantFromBrackets(kn: TKnoten);
    var to_del : TKnoten;
    begin
    If (kn.token = 7) and (kn.right_ch.token = 0) then begin
      to_del := kn.right_ch;
      kn.token := 0;                  // Daten vom Konstanten-Knoten
      kn.value := kn.right_ch.value;  //   in den (bisherigen) Klammer-
      kn.right_ch := Nil;             //   Knoten übernehmen !
      to_del.Free;
      end
    else begin
      if kn.left_ch <> Nil then FreeSingleConstantFromBrackets(kn.left_ch);
      if kn.right_ch <> Nil then FreeSingleConstantFromBrackets(kn.right_ch);
      end;
    end;

  procedure KillUnityFactors(kn: TKnoten);
    var to_del : TKnoten;
    begin
    If (kn.left_ch <> Nil) and       // Linkes Kind vorhanden
       (kn.left_ch.token = 4) and    // Linkes Kind ist Produkt-Knoten
       (kn.left_ch.left_ch.token = 0) and      // mit einer ±1-Konstanten
       (Abs(Abs(kn.left_ch.left_ch.value) - 1) < epsilon) then  // als 1.Faktor
      if kn.left_ch.left_ch.value < 0 then begin  // Fall "-1"
        kn.left_ch.left_ch.Free;                      // Produkt-Knoten in
        kn.left_ch.left_ch := Nil;                    // ChangeSign-Knoten
        kn.left_ch.token := 16;                       // verwandeln
        end
      else begin                                  // Fall "+1"
        to_del := kn.left_ch;                         // Produkt-Knoten
        kn.left_ch := to_del.right_ch;                // ganz entfernen
        to_del.right_ch := Nil;
        to_del.Free;
        end;
    If (kn.right_ch <> Nil) and       // Rechtes Kind vorhanden
       (kn.right_ch.token = 4) and    // Rechtes Kind ist Produkt-Knoten
       (kn.right_ch.left_ch.token = 0) and       // mit einer ±1-Konstanten
       (Abs(Abs(kn.right_ch.left_ch.value) - 1) < epsilon) then  // als 1.Faktor
      if kn.right_ch.left_ch.value < 0 then begin  // Fall "-1"
        kn.right_ch.left_ch.Free;                      // Produkt-Knoten in
        kn.right_ch.left_ch := Nil;                    // ChangeSign-Knoten
        kn.right_ch.token := 16;                       // verwandeln
        end
      else begin                                   // Fall "+1"
        to_del := kn.right_ch;                         // Produkt-Knoten
        kn.right_ch := to_del.right_ch;                // ganz entfernen
        to_del.right_ch := Nil;
        to_del.Free;
        end;
    If kn.left_ch  <> Nil then KillUnityFactors(kn.left_ch );
    If kn.right_ch <> Nil then KillUnityFactors(kn.right_ch);
    end;

  procedure ShiftCSIntoConstants(kn: TKnoten);
    var to_del : TKnoten;
    begin
    If (kn.token = 4) and                   // Produkt
       (kn.left_ch.token = 0) and
       (kn.right_ch.token = 16) then begin  // ChangeSign
      kn.left_ch.value := - kn.left_ch.value;
      to_del := kn.right_ch;
      kn.right_ch := kn.right_ch.right_ch;
      to_del.right_ch := Nil;
      to_del.Free;
      end;
    If kn.left_ch  <> Nil then ShiftCSIntoConstants(kn.left_ch);
    If kn.right_ch <> Nil then ShiftCSIntoConstants(kn.right_ch);
    end;


  procedure MergeNegativeSummandsWithAddOp(kn: TKnoten);
    begin
    If ((kn.token = 2) or (kn.token = 3)) and   // Plus oder Minus
       (kn.right_ch.token = 0) and
       (kn.right_ch.value < 0) then begin
      kn.right_ch.value := -kn.right_ch.value;
      If kn.token = 2 then kn.token := 3
      else                 kn.token := 2;
      end;
    If kn.left_ch  <> Nil then MergeNegativeSummandsWithAddOp(kn.left_ch );
    If kn.right_ch <> Nil then MergeNegativeSummandsWithAddOp(kn.right_ch);
    end;

  procedure KillZeroProducts(kn: TKnoten);
    begin
    If ((kn.token = 4) and             // Produkt : beide Faktoren überprüfen !
        (((kn.left_ch.token = 0) and
          (Abs(kn.left_ch.value) < epsilon)) or
         ((kn.right_ch.token = 0) and
          (Abs(kn.right_ch.value) < epsilon)))) or
       ((kn.token = 5) and             // Quotient : nur Zähler überprüfen !
        (kn.left_ch.token = 0) and
        (Abs(kn.left_ch.value) < epsilon)) then begin
      kn.token := 0;
      kn.value := 0;
      kn.left_ch.Free;
      kn.left_ch := Nil;
      kn.right_ch.Free;
      kn.right_ch := Nil;
      end;
    If kn.left_ch  <> Nil then KillZeroProducts(kn.left_ch );
    If kn.right_ch <> Nil then KillZeroProducts(kn.right_ch);
    end;

  procedure KillZeroSummands(kn: TKnoten);
    var to_del : TKnoten;
    begin
    If (kn.token = 2) or (kn.token = 3) then
      If (kn.right_ch.token = 0) and
         (Abs(kn.right_ch.value) < epsilon) then begin
        kn.right_ch.Free;
        to_del := kn.left_ch;
        kn.right_ch := to_del.right_ch;
        to_del.right_ch := Nil;
        kn.left_ch := to_del.left_ch;
        to_del.left_ch := Nil;
        kn.token := to_del.token;
        kn.value := to_del.value;
        to_del.Free;
        end
      else
      If (kn.left_ch.token = 0) and
         (Abs(kn.left_ch.value) < epsilon) then
        if kn.token = 2 then begin  // also Summe
          kn.left_ch.Free;
          to_del := kn.right_ch;
          kn.right_ch := to_del.right_ch;
          to_del.right_ch := Nil;
          kn.left_ch := to_del.left_ch;
          to_del.left_ch := Nil;
          kn.token := to_del.token;
          kn.value := to_del.value;
          to_del.Free;
          end
        else begin // dann: token = 3, also Differenz
          kn.left_ch.Free;
          kn.left_ch := Nil;
          kn.token := 16;
          end;
    If kn.left_ch  <> Nil then KillZeroSummands(kn.left_ch );
    If kn.right_ch <> Nil then KillZeroSummands(kn.right_ch);
    end;

  var so, sv, sn : String;   // "s"tring "o"riginal, "v"orher, "n"achher
      n          : Integer;
  begin
  If knot <> Nil then
    If knot.token = 39 then begin  // Sonderfall IF-Funktion
      Simplify(TTBaum(knot.right_ch.left_ch ).baum);
      Simplify(TTBaum(knot.right_ch.right_ch).baum);
      end
    else begin                     // Normalfall
      n := 0;
      BuildString;
      so := source_str;
      sn := so;
      Repeat
        sv := sn;
        try
          ShiftConstantFactorsToTheLeft(knot);
          BuildString;
          UniteNearbyFactors(knot);
          ShiftCSIntoConstants(knot);
          FreeSingleConstantFromBrackets(knot);
          KillUnityFactors(knot);
          MergeNegativeSummandsWithAddOp(knot);
          KillZeroProducts(knot);
          KillZeroSummands(knot);
          BuildString;
          sn := source_str;
          n := n + 1;
        except
          n := 21;
        end; { of try }
      until (sv = sn) or (n > 20);
      If n > 20 then begin  // Fehlerfall !!!
        BuildTree(so);
        SpyOut('TTBaum.Simplify() failed: f(x) = %s, n = %d', [so, n]);
        end;
      end;
  end;



procedure TTBaum.RegisterTermParentsIn(GO : TObject);

  procedure RTP(knot: TKnoten);
    var n : Array[1..4] of Integer;
        i : Integer;
    begin
    If knot <> Nil then with knot do
      If token in EuklidToken then
        Case token of
         32 : begin
              right_ch.Read4Int(n[1], n[2], n[3], n[4]);
              For i := 1 to 3 do
                TGeoObj(GO).BecomesChildOf(TGeoObjListe(Drawing).GetObj(n[i]));
              end;
         49 : begin
              right_ch.Read4Int(n[1], n[2], n[3], n[4]);
              TGeoObj(GO).BecomesChildOf(TGeoObjListe(Drawing).GetObj(n[1]));
              RTP(right_ch.right_ch);
              end;
        else
          TGeoObj(GO).BecomesChildOf(TGeoObjListe(Drawing).GetObj(Round(right_ch.value)));
        end { of case }
      else
        If token = 39 then begin
          TBoolBaum(knot.left_ch).RegisterTermParentsIn(GO);
          RTP(TTBaum(knot.right_ch.left_ch).baum);
          RTP(TTBaum(knot.right_ch.right_ch).baum);
          end
        else begin
          RTP(left_ch);
          RTP(right_ch);
          end;
    end;

  begin
  RTP(baum);
  end;


procedure TTBaum.UnregisterTermParentsIn(GO : TObject);

  procedure UTP(knot: TKnoten);
    var PO : TGeoObj;
        n  : Array[1..4] of Integer;
        i  : Integer;
    begin
    If knot <> Nil then with knot do
      If token in EuklidToken then
        Case token of
         32 : begin
              right_ch.Read4Int(n[1], n[2], n[3], n[4]);
              For i := 1 to 3 do begin
                PO := TGeoObjListe(Drawing).GetObj(n[i]);
                TGeoObj(GO).Stops2BeChildOf(PO);
                end;
              end;
         49 : begin
              right_ch.Read4Int(n[1], n[2], n[3], n[4]);
              PO := TGeoObjListe(Drawing).GetObj(n[1]);
              TGeoObj(GO).Stops2BeChildOf(PO);
              UTP(right_ch.right_ch);
              end;
        else
          PO := TGeoObjListe(Drawing).GetObj(Round(right_ch.value));
          TGeoObj(GO).Stops2BeChildOf(PO);
        end { of case }
      else
        If token = 39 then begin
          TBoolBaum(knot.left_ch).UnRegisterTermParentsIn(GO);
          UTP(TTBaum(knot.right_ch.left_ch).baum);
          UTP(TTBaum(knot.right_ch.right_ch).baum);
          end
        else begin
          UTP(left_ch);
          UTP(right_ch);
          end;
    end;

  begin
  UTP(baum);
  end;


FUNCTION TTBaum.HasSameDataAs(vb: TTBaum): Boolean;
  BEGIN
  Result := TreesAreEquivalent(vb.Baum, Baum);
  END;


FUNCTION TTBaum.containsToken(t_id: Integer): Boolean;
  function ct(k : TKnoten): Boolean;
    begin
    if k <> Nil then begin
      if k.token = t_id then
        Result := True
      else
        Case k.token of
          39 : Result := ct(TTBaum(k.right_ch.left_ch).baum) or
                         ct(TTBaum(k.right_ch.right_ch).baum);
        else
          Result := ct(k.left_ch) or ct(k.right_ch);
        end; { of case }
      end
    else
      Result := False;
    end;
  BEGIN
  Result := ct(baum);
  END;

PROCEDURE TTBaum.AdjustSourceStr;
  var i   : Integer;
      buf : String;
  BEGIN
  For i := Length(source_str) downto 1 do
    If source_str[i] = ' ' then
      Delete(source_str, i, 1);
  buf := source_str;
  Replace('cx(', 'x(', buf);
  Replace('cy(', 'y(', buf);
  source_str := buf;
  END;


FUNCTION TTBaum.messwertnumobj(f_num : Integer; var s : WideString) : TKnoten;
  { Diese Funktion enthält die komplette Schnittstelle zu "Geotypes";  }

  FUNCTION GetGeoObjNumByName (ExpType: TClass; VAR st : WideString) : Integer;
    { gibt die GeoNum-Id eines gültigen GeoObjekts mit dem Namen st zurück;
      falls kein solches Objekt gefunden wurde, oder nur ein gelöschtes
      Objekt dieses Namens existiert, wird 0 zurückgegeben.
      Nov. 2006 :  Erweiterung für die Korrektheits-Prüfung der Version 3.0:
                   Falls st eine "@"-Variable enthält, wird das Negative von
      deren Nummer zurückgegeben, also z.B. für "@3" der Ergebnis "-3".     }

    VAR np, zs : WideString;
        TGO    : TGeoObj;
        n, i   : Integer;

    FUNCTION LastToMatchName : TGeoObj;
      VAR i    : Integer;
          AGO,             { "Aktuelles Geo-Objekt" }
          LTMN : TGeoObj;
      BEGIN
      LTMN := Nil;
      i := Pred(TGeoObjListe(Drawing).Count);
      WHILE (i >= 0) and (LTMN = Nil) DO BEGIN
        AGO := TGeoObj(TGeoObjListe(Drawing).Items[i]);
        IF AGO.ClassType.InheritsFrom(ExpType) AND {Objekt vom rechten Typ}
           (AGO.Name = np) THEN
          LTMN := AGO;
        Dec(i);
        END;
      LastToMatchName := LTMN;
      END;

    BEGIN { of GetGeoObjNumByName }
    Result := 0;
    i := 1;
    WHILE (i <= Length(st)) and IsNameChar(st[i]) DO INC (i);
    np := Copy(st, 1, Pred(i));
    IF Length(np) > 0 THEN BEGIN
      TGO := LastToMatchName;
      IF (TGO <> Nil) AND
         (TGeoObjListe(Drawing).IndexOf(TGO) <=
          TGeoObjListe(Drawing).LastValidObjIndex) THEN BEGIN
        Result := TGO.GeoNum;
        CutFirst_wB(st, Pred(i));
        END;
      END;
    If Result = 0 then begin
      While (Length(st) > 0) and IsDelimiter(st[1]) do
        System.Delete(st, 1, 1);         { Führende Leerzeichen entfernen }
      If (Length(st) > 0) and (st[1] = '@') then begin
        System.Delete(st, 1, 1);
        zs := '';
        While (Length(st) > 0) and IsDigit(st[1]) do begin
          zs := zs + st[1];
          System.Delete(st, 1, 1);
          end;
        If Length(zs) > 0 then begin
          n := StrToInt(zs);
          If n > 0 then
            Result := - n;
          end;
        end;
      end;
    END;  { of GetGeoObjNumByName }

  FUNCTION AbstandsMassNumObj : TKnoten;
    VAR nr   : Array [0..2] of Integer;
        err  : Integer;
        GOL  : TGeoObjListe;
        MObj : TGeoObj;   { MaßObjekt }
    BEGIN
    AbstandsMassNumObj := Nil;
    nr[1] := GetGeoObjNumByName(TGParentObj, s);
    IF nr[1] <> 0 THEN
      IF (s[1] = ';') or (s[1] = ',') THEN BEGIN
        CutFirst_wB(s, 1);
        nr[2] := GetGeoObjNumByName(TGParentObj, s);
        IF nr[2] <> 0 THEN BEGIN
          If (nr[1] > 0) and (nr[2] > 0) then begin
            GOL := TGeoObjListe(Drawing);
            MObj := GOL.InsertObject(TGDistLine.Create(GOL,
                                                       GOL.GetObj(nr[1]),
                                                       GOL.GetObj(nr[2]), False), err);
            nr[0] := MObj.GeoNum;
            end
          else
            nr[0] := 0;
          AbstandsMassNumObj :=
            TKnoten.Create(0, nr[0], Nil,
                           TKnoten.Init4Int(0, nr[1], nr[2], 0, 0, Nil, Nil));
          END
        ELSE
          error_str := TBMsg[0];   {'Unbekanntes Objekt !'}
        END
      ELSE
        error_str := TBMsg[1]   {'";" erwartet !'}
    ELSE
      error_str := TBMsg[0];  {'Unbekanntes Objekt !'}
    END;

  FUNCTION WinkelMassNumObj : TKnoten;
    VAR nr   : Array [0..3] of Integer;
        GOL  : TGeoObjListe;
        WO,              { *W*inkel*o*bjekt }
        MObj : TGeoObj;  { *M*aß*obj*ekt }
        wNum,
        err,
        i    : Integer;

    function ThreeArguments(s: String): Boolean;
      { 21.04.07 : Diese Funktion wurde ergänzt, um durch doppelte Namen
                   verursachten Fehlinterpretationen aus dem Weg zu gehen.
        Nun wird auch der Fall korrekt abgewickelt, dass ein Winkel alpha
        ( = a) einen Punkt mit Namen a (statt A) auf dem ersten Schenkel hat.
        (Fehlermeldung von Jürgen Roth, Datei "aenderungsverhalten_b1.geox") }
      var pcb, ns,
          i      : Integer;
      begin
      Result := False;
      pcb := Pos(')', s);
      If pcb > 0 then begin
        ns := 0;
        For i := 1 to Pred(pcb) do
          If (s[i] = ';') or (s[i] = ',') then
            ns := ns + 1;
        Result := ns = 2;
        end;
      end;

    FUNCTION FirstThatMatches : TGeoObj;
      var i : Integer;
      BEGIN
      Result := Nil;
      i := 0;
      While (Result = Nil) and (i < TGeoObjListe(Drawing).Count) do begin
        WITH TGeoObj(TGeoObjListe(Drawing).Items[i]) DO
          If (ClassType = TGAngleWidth) and (Parent.List[0] = WO) then
            Result := TGeoObj(TGeoObjListe(Drawing).Items[i]);
        Inc(i);
        end;
      END;

    BEGIN
    WinkelMassNumObj := Nil;
    nr[0] := 0;
    If ThreeArguments(s)then begin  { Es gibt 3 Punktobjekte als Argument. }
      nr[1] := GetGeoObjNumByName(TGPoint, s);
      IF nr[1] <> 0 THEN
        IF (s[1] = ';') or (s[1] = ',') THEN BEGIN
          CutFirst_wB(s, 1);
          nr[2] := GetGeoObjNumByName(TGPoint, s);
          If nr[2] <> 0 THEN
            IF (s[1] = ';') or (s[1] = ',') THEN BEGIN
              CutFirst_wB(s, 1);
              nr[3] := GetGeoObjNumByName(TGPoint, s);
              IF nr[3] <> 0 THEN WITH TGeoObjListe(Drawing) DO BEGIN
                If (nr[1] > 0) and (nr[2] > 0) and (nr[3] > 0) then begin
                  GOL := TGeoObjListe(Drawing);
                  WO := InsertObject(TGAngle.Create(GOL,
                                                    GOL.GetObj(nr[1]),
                                                    GOL.GetObj(nr[2]),
                                                    GOL.GetObj(nr[3]), False),
                                     err);
                  MObj := FirstThatMatches;
                  IF MObj = Nil THEN BEGIN
                    MObj := TGAngleWidth.Create(TGeoObjListe(Drawing), WO, False);
                    InsertObject(MObj, err);
                    END;
                  WinkelMassNumObj :=
                    TKnoten.Create(0, MObj.GeoNum,
                                   Nil, TKnoten.Init4Int(0,
                                                         nr[1], nr[2], nr[3], 0,
                                                         Nil, Nil));
                  END
                ELSE
                  error_str := TBMsg[0];   {'Unbekanntes Objekt !'}
                END
              ELSE
                error_str := TBMsg[0];  {'Unbekanntes Objekt !'}
              END
            ELSE
              error_str := TBMsg[1]   {'";" erwartet !'}
          ELSE
            error_str := TBMsg[0];  {'Unbekanntes Objekt !'}
          END
        ELSE
          error_str := TBMsg[1]   {'";" erwartet !'}
      ELSE
        error_str := TBMsg[0];  {'Unbekanntes Objekt !'}
      END
    ELSE BEGIN  { Offenbar gibt es nur 1 Winkelobjekt als Argument }
      wNum := GetGeoObjNumByName(TGAngle, s);
      IF wNum > 0 THEN BEGIN
        WO := TGeoObjListe(Drawing).GetValidObj(wNum);
        FOR i := 0 TO 2 DO
          nr[i+1] := TGeoObj(WO.Parent[i]).GeoNum;
        MObj := FirstThatMatches;
        If MObj = Nil THEN BEGIN
          MObj := TGAngleWidth.Create(TGeoObjListe(Drawing), WO, False);
          TGeoObjListe(Drawing).InsertObject(MObj, err);
          END;
        WinkelMassNumObj :=
           TKnoten.Create(0, MObj.GeoNum,
                          Nil, TKnoten.Init4Int(0, nr[1], nr[2], nr[3], 0,
                                                Nil, Nil));
        END
      ELSE
        error_str := TBMsg[2];  {'Ungültiges Winkelmaß-Objekt !'}
      END;
    END;

  function EuklidObj: TKnoten;
    VAR GO : TGeoObj;
        GN : Integer;

    function ExpectedTypeOK : Boolean;
      { 18.10.03 : Strenge Typ-Prüfung ergänzt wegen Fehlermeldung von
                   Herrn Seebach: Punkt mit Namen "x" übernahm fälschlicher-
                   weise die Rolle eines Zahlobjekts mit Namen "x"! }
      begin
      Case f_num of
        19,                                    // x()
        20 : Result := (GO is TGPoint) or      // y()
                       (GO is TGVector) or
                       (GO is TGCircle) or
                       (GO is TGConic);
        21 : Result := (GO is TGShortLine) or  // len()
                       (GO is TGCircle) or
                       ((GO is TGConic) and (GO as TGConic).IsEllipse) or
                       (GO is TGPolygon);
        22 : Result := GO is TGCircle;         // radius()
        23 : Result := (GO is TGArea) or       // area()
                       (GO is TGCircle) or
                       ((GO is TGConic) and (GO as TGConic).IsEllipse) or
                       (GO is TGPolygon);
        24 : Result := (GO is TGNumber) or     // direkte Referenz auf ein
                       (GO is TGShortLine);    // Zahl-, Term- oder Strecken-Objekt
      else
        Result := FALSE;   { Sollte nie vorkommen. }
      end;
      end;

    BEGIN  { of function EuklidObject }
    EuklidObj := Nil;
    GN := GetGeoObjNumByName(TGeoObj, s);
    IF GN > 0 THEN begin
      GO := TGeoObjListe(Drawing).GetValidObj(GN);
      IF ExpectedTypeOK THEN
        EuklidObj := TKnoten.Create(0, GN, Nil, Nil)
      ELSE
        error_str := TBMsg[19]  {'Falscher Objekttyp !'}
      end
    ELSE begin
      If GN < 0 then
        EuklidObj := TKnoten.Create(0, GN, Nil, Nil)
      else
        error_str := TBMsg[0];  {'Unbekanntes Objekt !'}
      end;
    end; { of function EuklidObject }

  function PointTriple: TKnoten;
    var GN1, GN2, GN3 : Integer;
    begin
    Result := Nil;
    GN1 := GetGeoObjNumByName(TGPoint, s);
    If GN1 > 0 then
      If (s[1] = ';') or (s[1] = ',') then begin
        CutFirst_wB(s, 1);
        GN2 := GetGeoObjNumByName(TGPoint, s);
        If GN2 > 0 then
          If (s[1] = ';') or (s[1] = ',') then begin
            CutFirst_wB(s, 1);
            GN3 := GetGeoObjNumByName(TGPoint, s);
            If GN3 > 0 then begin
              Result := TKnoten.Init4Int(0, GN1, GN2, GN3, 0, Nil, Nil);
              end
            else
              error_str := TBMsg[0];
            end
          else
            error_str := TBMsg[1]
        else
          error_str := TBMsg[0];
        end
      else
        error_str := TBMsg[1]
    else
      error_str := TBMsg[0];
    end;

  function UserDefinedFunction : TKnoten;
    var fo_num, p : Integer;
        argu      : TKnoten;
    begin
    Result := Nil;
    fo_num := GetGeoObjNumByName(TGFunktion, s);
    If (fo_num > 0) and (Length(s) > 0) then begin
      p := POS (s[1], brackets);
      If (p > 0) and Odd(p) then begin
        CutFirst_wB (s, 1);
        argu := term(s);
        If argu = Nil then
          If error_str = '' then
            error_str := TBMsg[3]   {'Syntaxfehler !'}
          else
        else
          if (Length(s) > 0) and (s[1] = brackets[Succ(p)]) then begin
            CutFirst_wB (s, 1);
            Result := TKnoten.Init4Int(0, fo_num, p, 0, 0, Nil, argu);
            end
          else
            if error_str = '' then  {'[Schließende Klammer] erwartet !' }
              error_str := '''' + Char(brackets[Succ(p)]) + TBMsg[4];
        end
      else
        error_str := TBMsg[5];  {'"(" erwartet !' }
      end
    else
      error_str := TBMsg[0];  { 'Unbekanntes Objekt !' }
    end;

  function SlopeFunction : TKnoten;
    var nr : Integer;
    begin
    Result := Nil;
    try
      nr := GetGeoObjNumByName(TGParentObj, s);
      If nr <> 0 then
        Result := TKnoten.Create(0, nr, Nil, Nil);
    except
      Result := Nil;
    end;
    end;

  BEGIN { of messwertnumobj }
  CASE f_num OF
    15 : messwertnumobj := AbstandsMassNumObj;
    16 : messwertnumobj := WinkelMassNumObj;
    19..
    24 : messwertnumobj := EuklidObj;
    25 : messwertnumobj := PointTriple;  { für tv() }
    34 : messwertnumobj := SlopeFunction;
    42 : messwertnumobj := UserDefinedFunction;
  ELSE
    messwertnumobj := Nil;
  END;  { of case }
  END;  { of messwertnumobj }


FUNCTION TTBaum.term (VAR s : WideString) : TKnoten;

  VAR tm : TKnoten;
      tk : Integer;

  FUNCTION summand : TKnoten;

    VAR sd : TKnoten;
        tk : Integer;

    FUNCTION faktor : TKnoten;

      VAR fr,
          expo,
          nk   : TKnoten;

      FUNCTION vorz_faktor : TKnoten;

        VAR vf   : TKnoten;
            sign : BOOLEAN;

        FUNCTION real_zahl : TKnoten;

          VAR exp_sign   : BOOLEAN;
              vorkomma,
              nachkomma,
              exponent,
              wert       : DOUBLE;
              lnk,
              i          : Integer;


          FUNCTION n0_zahl (VAR wert : DOUBLE) : BOOLEAN;

            BEGIN
            n0_zahl := FALSE;
            IF (LENGTH (s) > 0) AND
               (IsDigit(s[1])) THEN BEGIN
              n0_zahl := TRUE;
              wert := 0;
              WHILE (LENGTH (s) > 0) AND
                    (IsDigit(s[1])) DO BEGIN
                wert := wert * 10 + ORD (s[1]) - ORD ('0');
                CutFirst_wB (s, 1);
                END;
              END;
            END; { of n0_zahl }


          BEGIN { of real_zahl }
          real_Zahl := Nil;
          IF n0_zahl (vorkomma) THEN BEGIN
            wert := vorkomma;
            IF (Length(s) > 0) and
               ((s[1] = '.') OR (s[1] = ',')) THEN BEGIN
              CutFirst_wB (s, 1);
              lnk := 0;
              WHILE (lnk < LENGTH (s)) AND
                    (IsDigit(s [SUCC (lnk)])) DO
                INC(lnk);
              IF n0_zahl (nachkomma) THEN BEGIN
                FOR i := 1 TO lnk DO
                  nachkomma := nachkomma / 10.0;
                wert := wert + nachkomma;
                END;
              END;
            IF (Length(s) > 0) AND (s[1] = 'E') THEN BEGIN
              CutFirst_wB (s, 1);
              exp_sign := FALSE;
              IF (s[1] = '+') THEN CutFirst_wB (s, 1);
              IF (s[1] = '-') THEN BEGIN
                exp_sign := TRUE;
                CutFirst_wB (s, 1);
                END;
              IF n0_zahl (exponent) THEN
                IF exp_sign THEN
                  FOR i := 1 TO ROUND (exponent) DO
                    wert := wert / 10.0
                ELSE
                  FOR i := 1 TO ROUND (exponent) DO
                    wert := wert * 10.0
              ELSE BEGIN
                error_str := TBMsg[8];
                Exit;
                END;
              END;
            real_zahl := TKnoten.Create(0, wert, Nil, Nil);
            END;
          END; { of real_zahl }


        FUNCTION funktion : TKnoten;
          VAR argu1,
              argu2  : TKnoten;
              t1, t2 : TTBaum;
              tv     : TBoolBaum;
              ns     : WideString;
              f_num,
              i, p   : Integer;

          BEGIN { of funktion }
          Result := NIL;
          f_num := 0;
          ns := s;
          IF LENGTH (s) > 0 THEN BEGIN
            i := 1;
            REPEAT
              p := POS (f_name [i], AnsiUpperCase(s));
              IF p = 1 THEN BEGIN
                CutFirst_wB (s, LENGTH (f_name[i]));
                f_num := i;
                i     := anz_f + 1;
                END
              ELSE
                INC (i);
            UNTIL i > anz_f;
            END;
          IF (LENGTH (s) > 0) THEN BEGIN
            p := POS (s[1], brackets);
            IF (p > 0) AND Odd(p) THEN BEGIN   { s beginnt mit einer öffnenden Klammer }
              CutFirst_wB (s, 1);
              argu1 := Nil;
              IF IsEuklidFunc(f_num) THEN
                argu2 := messwertnumobj(f_num, s)  { enthält die GeoNummer des Maßobjekts }
              ELSE
                IF f_num = 32 THEN BEGIN    // token = 39, also IF()-Funktion
                  tv := TBoolBaum.Create(Drawing, FAngleMode, '');
                  tv.BuildTreeAndReturn(s);
                  IF tv.IsOkay and (s[1] = ';') THEN BEGIN
                    CutFirst_wB(s, 1);
                    t1 := TTBaum.Create(Drawing, FAngleMode);
                    t1.BuildTreeAndReturn(s);
                    IF t1.is_okay and (s[1] = ';') THEN BEGIN
                      CutFirst_wB(s, 1);
                      t2 := TTBaum.Create(Drawing, FAngleMode);
                      t2.BuildTreeAndReturn(s);
                      IF t2.is_okay THEN BEGIN
                        argu1 := Pointer(tv);
                        argu2 := tknoten.Create(200, 0, Pointer(t1), Pointer(t2));
                        END
                      ELSE BEGIN
                        t2.Free;
                        t1.Free;
                        tv.Free;
                        Exit;
                        END;
                      END
                    ELSE BEGIN
                      t1.Free;
                      tv.Free;
                      Exit;
                      END;
                    END
                  ELSE BEGIN
                    tv.Free;
                    Exit;
                    END;
                  END
                ELSE
                  argu2 := term(s);
              IF argu2 = NIL THEN
                IF error_str = '' THEN
                  error_str := TBMsg[3]   {'Syntaxfehler !'}
                ELSE
              ELSE
                IF (LENGTH (s) > 0) AND (s[1] = brackets[Succ(p)]) THEN BEGIN
                  CutFirst_wB (s, 1);
                  Result := TKnoten.Create(f_num + 7, p, argu1, argu2);
                  END
                ELSE
                  IF error_str = '' THEN  {'[Schließende Klammer] erwartet !' }
                    error_str := '''' + Char(brackets[Succ(p)]) + TBMsg[4];
              END;
            END;
          If Result = Nil then begin   { Es folgt *keine* öffnende Klammer : }
            s := ns;                { Also liegt *kein* Funktionssymbol vor, }
                           { und der ursprüngliche String wird restauriert ! }
            ns := '';      { Jetzt : Versuch einer direkten Namens-Erkennung }
            i  := 1;       {           für Zahl- und Termobjekte !           }
            While (i <= Length(s)) and IsNameChar(s[i]) do begin
              ns := ns + s[i];
              Inc(i);
              end;
            If Length(ns) > 0 then begin
              f_num := 24;  { Zahl- oder Term-Objekt ?? }
              argu2 := messwertnumobj(f_num, ns);
              If argu2 <> Nil then begin   { Objekt gefunden! }
                Result := TKnoten.Create(f_num + 7, 0, Nil, argu2);
                CutFirst_wB (s, Pred(i));
                end
              else begin    { argu2 = Nil, also nix gefunden! }
                ns := s;    { Kopie des ganzen Source-Strings weiterreichen }
                f_num := 42;  { Benutzerdefinierte Funktion ?? }
                argu2 := messwertnumobj(f_num, ns);
                if argu2 <> Nil then begin
                  s := ns;       { Neuen Source-String-Rest übernehmen }
                  Result := TKnoten.Create(f_num + 7, 0, Nil, argu2);
                  end
                else
                  error_str := TBMsg[6];  {'Unbekannter Bezeichner !'}
                end;
              end;
            end;
          END; { of funktion }


        BEGIN { of vorz_faktor }
        sign := FALSE;
        vf   := Nil;
        IF Length(s) > 0 THEN BEGIN
          IF s[1] = '+' THEN CutFirst_wB (s, 1);
          IF s[1] = '-' THEN BEGIN
            sign := TRUE;
            CutFirst_wB (s, 1);
            END;

          vf := real_zahl;
          IF vf = NIL THEN BEGIN
            vf := funktion;
            IF vf = NIL THEN
              IF WideUpperCase(s[1]) = 'X' THEN BEGIN
                CutFirst_wB (s, 1);
                vf := TKnoten.Create(1, 0.0, Nil, Nil);
                END
              ELSE
                IF WideUpperCase(s[1]) = 'E' THEN BEGIN
                  CutFirst_wB (s, 1);
                  vf := TKnoten.Create(0, euler, Nil, Nil);
                  END
                ELSE
                  IF WideUpperCase(s[1]) = 'P' THEN BEGIN
                    CutFirst_wB (s, 1);
                    IF WideUpperCase(s[1]) = 'I' THEN BEGIN
                      CutFirst_wB (s, 1);
                      vf := TKnoten.Create(0, Pi, Nil, Nil);
                      END;
                    END;
            END;

          IF (vf <> NIL)THEN BEGIN
            IF sign THEN BEGIN
              nk := TKnoten.Create(16, 0.0, Nil, vf);  { Knoten fuer "CS" -Token }
              vf := nk;
              END;
            error_str := '';   { Fehlermeldung löschen ! }
            END
          ELSE
            IF error_str = '' THEN
              error_str := TBMsg[7];  {'Faktor erwartet !'}
          END;

        vorz_faktor := vf;
        END; { of vorz_faktor }


      BEGIN { of faktor }
      faktor := NIL;
      fr := vorz_faktor;
      WHILE (fr <> NIL ) AND
            (LENGTH (s) > 0) AND
            (s[1] = '^') DO BEGIN
        CutFirst_wB (s, 1);
        expo := vorz_faktor;
        IF expo = NIL THEN BEGIN
          error_str := TBMsg[8];  {'Exponent erwartet !'}
          EXIT;
          END
        else  
          If (expo.token = 16) and                  { Fall des negativen und }
             (expo.right_ch.token = 0) then begin   { konstanten Exponenten  }
            nk := expo;
            expo := nk.right_ch;
            nk.right_ch := Nil;
            nk.Free;
            expo.value := - expo.value;
            end;
        IF fr.token = 16 THEN                                       { Fall der Minus-Potenz : z.B.           }
          fr.right_ch := TKnoten.Create(6, 0.0, fr.right_ch, expo)  {    -2**4  = -(2**4), und nicht (-2)**4 }
        ELSE                                                        { fr zeigt auf "CS (2)", also muss man   }
          fr := TKnoten.Create(6, 0.0, fr, expo);                   { "CS" vor die gesamte Potenz stellen !  }
        END;
      IF (LENGTH(s) > 0) AND (s[1] = '°') THEN BEGIN
        CutFirst_wB (s, 1);
        fr := TKnoten.Create(50, 0.0, fr, nil);
        END;
      faktor := fr;
      END;  { of faktor }


    BEGIN { of summand }
    sd := faktor;
    WHILE (sd <> NIL) AND
          (LENGTH (s) > 0) AND
          ((s[1] = '*') OR (s[1] = '/')) DO BEGIN    { später hier Toleranz gegenüber   }
      IF s[1] = '/' THEN tk := 5 ELSE tk := 4;       { fehlenden Malpunkten nachrüsten !}
      CutFirst_wB (s, 1);
      If Length(s) > 0 then
        sd := TKnoten.Create(tk, 0.0, sd, faktor)
      else
        error_str := TBMsg[7];
      END;
    summand := sd;
    END;  { of summand }


  BEGIN { of term }
  term := NIL;
  IF LENGTH (s) = 0 THEN EXIT;
  CutFirst_wB (s, 0);  { löscht führende Blanks }

  tm := summand;
  WHILE (tm <> NIL) AND
     (LENGTH (s) > 0) AND
     ((s[1] = '+') OR (s[1] = '-')) DO BEGIN
    IF s[1] = '+' THEN tk := 2 ELSE tk := 3;
    CutFirst_wB (s, 1);
    If Length(s) > 0 then
      tm := TKnoten.Create(tk, 0.0, tm, summand)
    else
      error_str := TBMsg[17];  { Summand erwartet }
    END;
  term := tm;
  END; { of term }


procedure TTBaum.transformDegTerm2Rad(tb: TKnoten);
  { Stellt tb einen "bogen()"-Knoten voran }
  var nkn : TKnoten;
  begin
  nkn := TKnoten.Create(tb.token, tb.value, tb.left_ch, tb.right_ch);  // flat copy !!
  tb.token    := 37;   //  Bogen-Funktion
  tb.right_ch := nkn;
  tb.left_ch  := Nil;
  Inc(TGeoObjListe(Drawing).OldAngleTermCount);
  end;

procedure TTBaum.transformTrig(tb: TKnoten);
  var nkn : TKnoten;
      bb  : TBoolBaum;
  begin
  If tb <> Nil then begin
    Case tb.token of
      8,               // sin, cos, tan ==>
      9,               //     bogen() vor dem Argument-Knoten einfügen!
     10 : begin
          nkn := TKnoten.Create(37, 0, Nil, tb.right_ch);  //
          tb.right_ch := nkn;
          Inc(TGeoObjListe(Drawing).OldAngleTermCount);
          end;
     15,               // arctan, arcsin, arccos, Winkelmaßreferenz ==>
     24,               //     grad() vor dem Funktions-Knoten einfügen!
     25,
     23 : begin
          nkn := TKnoten.Create(tb.token, tb.value, Nil, tb.right_ch);
          tb.token    := 36;    // tb umfunktionieren
          tb.right_ch := nkn;   //   zur grad()-Funktion
          Inc(TGeoObjListe(Drawing).OldAngleTermCount);
          tb := nkn;   // vermeidet eine Rekursions-Katastrophe!
          end;
    end; { of case }
    If tb.token = 39 then begin  // Spezialfall if-Funktion
      bb := TBoolBaum(tb.left_ch);
      bb.transformTrig(bb.FBaum);
      transformTrig(TTBaum(tb.right_ch.left_ch).baum);
      transformTrig(TTBaum(tb.right_ch.right_ch).baum);
      end
    else begin                  // Andernfalls: Kinder untersuchen!
      transformTrig(tb.left_ch);
      transformTrig(tb.right_ch);
      end;
    end; { of if }
  end;

procedure TTBaum.deleteTrigLoops(knot: TKnoten);
  var todel1, todel2 : TKnoten;
  begin
  If knot <> Nil then
    If ( (knot.token = 36) and (knot.right_ch.token = 37) ) or
       ( (knot.token = 37) and (knot.right_ch.token = 36) ) then begin
      todel1 := knot.right_ch;
      todel2 := knot.right_ch.right_ch;
      knot.token := todel2.token;
      knot.value := todel2.value;
      knot.left_ch := todel2.left_ch;
      knot.right_ch := todel2.right_ch;
      todel2.left_ch := Nil;
      todel2.right_ch := Nil;
      todel1.Free; // löscht auch todel2!
      end
    else if knot.token = 39 then begin
      { to be continued later - if ever! }
      end
    else begin
      deleteTrigLoops(knot.left_ch);
      deleteTrigLoops(knot.right_ch);
    end;
  end;

FUNCTION TTBaum.tbs (tb : TKnoten; GeometriaExport: Boolean = False) : WideString;

  FUNCTION GetNewName (NewNameStart : WideString; knot : TKnoten) : WideString;
    VAR n    : ARRAY [0..3] OF Integer;
        i    : Integer;
        GNN  : WideString;
        TGO  : TGeoObj;
    BEGIN
    GNN := NewNameStart + '(';
    IF knot <> NIL THEN BEGIN
      knot.Read4Int(n[0], n[1], n[2], n[3]);
      FOR i := 0 TO 3 DO
        IF n[i] > 0 THEN BEGIN
          TGO := TGeoObjListe(Drawing).GetValidObj(n[i]);
          IF TGO <> Nil THEN
            GNN := GNN + TGO.Name + ';';
          END
        ELSE If n[i] < 0 THEN
          GNN := GNN + '@' + IntToStr(Abs(n[i])) + ';';
      IF GNN[LENGTH(GNN)] = ';' THEN
        DELETE (GNN, LENGTH(GNN), 1);
      END;
    GetNewName := GNN + ')';
    END;

  VAR GeoObj : TGeoObj;
      n, i   : Integer;
      buf    : WideString;
  BEGIN
  CASE tb.token OF
     0 : If Abs(tb.value - pi   ) < 1e-12 then tbs := 'pi' else
         If Abs(tb.value - euler) < 1e-12 then tbs := 'e'
         else tbs := FloatToStrF(tb.value, ffGeneral, 10, 0);
     1 : tbs := 'x';
     2 : tbs := tbs (tb.left_ch) + ' + ' + tbs (tb.right_ch);
     3 : tbs := tbs (tb.left_ch) + ' - ' + tbs (tb.right_ch);
     4 : tbs := tbs (tb.left_ch) + '*' + tbs (tb.right_ch);
     5 : tbs := tbs (tb.left_ch) + '/' + tbs (tb.right_ch);
     6 : tbs := tbs (tb.left_ch) + '^' + tbs (tb.right_ch);
     7 : BEGIN
         i   := Round(tb.value);
         buf := '';
         tbs := buf + brackets[i] + #$0020 + tbs (tb.right_ch) + #$0020 + brackets[Succ(i)];
         END;
     8 : tbs := 'sin(' + tbs (tb.right_ch) + ')';
     9 : tbs := 'cos(' + tbs (tb.right_ch) + ')';
    10 : tbs := 'tan(' + tbs (tb.right_ch) + ')';
    11 : tbs := 'sqrt(' + tbs (tb.right_ch) + ')';
    12 : tbs := 'ln('  + tbs (tb.right_ch) + ')';
    13 : tbs := 'exp(' + tbs (tb.right_ch) + ')';
    14 : tbs := 'log(' + tbs (tb.right_ch) + ')';
    15 : tbs := 'arctan(' + tbs (tb.right_ch) + ')';
    16 : tbs := '-' + tbs (tb.right_ch);
    17 : tbs := 'abs(' + tbs (tb.right_ch) + ')';
    18 : tbs := 'sqr(' + tbs (tb.right_ch) + ')';
    19 : tbs := 'int(' + tbs (tb.right_ch) + ')';
    20 : tbs := 'frac(' + tbs (tb.right_ch) + ')';
    21 : tbs := 'normal(' + tbs(tb.right_ch) + ')';

    { Die folgenden beiden Token sind nur für EUKLID eingebaut : }
    22 : BEGIN  { Abstand }
         GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
         IF (GeoObj <> NIL) then
           IF GeoObj.ClassType = TGDistLine THEN
             tbs := TGDistLine(GeoObj).Name
           ELSE
             error_str := TBMsg[14]  {'Abstand nicht gefunden !'}
         ELSE
           tbs := GetNewName('d', tb.right_ch.right_ch);
         END;
    23 : BEGIN  { Winkelweite }
         GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
         IF (GeoObj <> NIL) then
           IF GeoObj.ClassType = TGAngleWidth THEN
             tbs := TGDistLine(GeoObj).Name
           ELSE
             error_str := TBMsg[15]  {'Winkelweite nicht gefunden !'}
         ELSE
           tbs := GetNewName('w', tb.right_ch.right_ch);
         END;

    { Hier nochmals was Allgemeingültiges : }
    24 : tbs := 'arcsin(' + tbs(tb.right_ch) + ')';
    25 : tbs := 'arccos(' + tbs(tb.right_ch) + ')';

    { Und weitere Spezial-EUKLID-Token : }
    26 : BEGIN  { x-Wert }
         n := ROUND(tb.right_ch.value);
         If n > 0 then begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(n);
           IF GeoObj <> NIL THEN
             tbs := 'x(' + GeoObj.Name + ')'
           ELSE
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
           end
         ELSE IF n < 0 THEN
           tbs := 'x(@' + IntToStr(Abs(n)) + ')'
         ELSE
           error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
         END;
    27 : BEGIN  { y-Wert }
         n := ROUND(tb.right_ch.value);
         If n > 0 then begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(n);
           IF GeoObj <> NIL THEN
             tbs := 'y(' + GeoObj.Name + ')'
           ELSE
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
           end
         ELSE IF n < 0 THEN
           tbs := 'y(@' + IntToStr(Abs(n)) + ')'
         ELSE
           error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
         END;
    28 : BEGIN  { Länge }
         n := ROUND(tb.right_ch.value);
         If n > 0 then begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(n);
           IF (GeoObj <> NIL) and
              ((GeoObj is TGShortLine) or
               (GeoObj is TGCircle) or       // für Umfang !
               (GeoObj is TGPolygon)) THEN
             tbs := 'len(' + GeoObj.Name + ')'
           ELSE
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
           end
         ELSE IF n < 0 THEN
           tbs := 'len(@' + IntToStr(Abs(n)) + ')'
         ELSE
           error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
         END;
    29 : BEGIN  { Radius }
         n := ROUND(tb.right_ch.value);
         If n > 0 then begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(n);
           IF (GeoObj <> NIL) and
              (GeoObj is TGCircle) THEN
             tbs := 'radius(' + GeoObj.Name + ')'
           ELSE
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
           end
         ELSE IF n < 0 THEN
           tbs := 'radius(@' + IntToStr(Abs(n)) + ')'
         ELSE
           error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
         END;
    30 : BEGIN  { Flächeninhalt }
         n := ROUND(tb.right_ch.value);
         If n > 0 then begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(n);
           IF (GeoObj <> NIL) and
              ((GeoObj is TGCircle) or
               (GeoObj is TGConic) or
               (GeoObj is TGPolygon) or
               (GeoObj is TGArea)) THEN
             tbs := 'area(' + GeoObj.Name + ')'
           ELSE
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
           end
         ELSE IF n < 0 THEN
           tbs := 'area(@' + IntToStr(Abs(n)) + ')'
         ELSE
           error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
         END;
    31 : BEGIN  { allg. Wert }
         n := ROUND(tb.right_ch.value);
         If n > 0 then begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(n);
           IF (GeoObj <> NIL) and
              ((GeoObj is TGNumber) or (GeoObj is TGShortLine)) THEN
             If (Round(tb.value) = 0) and (Not GeometriaExport) then
               tbs := GeoObj.Name
             else
               tbs := 'val(' + GeoObj.Name + ')'
           ELSE
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
           end
         ELSE IF n < 0 THEN
           tbs := 'val(@' + IntToStr(Abs(n)) + ')'
         ELSE
           error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
         END;
    32 : tbs := GetNewName('tv', tb.right_ch);

    { Zur Abwechslung mal wieder ein paar allgemeingültige Deklarationen : }
    33 : tbs := 'floor(' + tbs (tb.right_ch) + ')';
    34 : tbs := 'ceil(' + tbs (tb.right_ch) + ')';
    35 : tbs := 'sgn(' + tbs(tb.right_ch) + ')';
    36 : tbs := 'grad(' + tbs(tb.right_ch) + ')';
    37 : tbs := 'bogen(' + tbs(tb.right_ch) + ')';
    38 : tbs := 'rnd(' + tbs(tb.right_ch) + ')';
    39 : begin
         TTBaum(tb.right_ch.left_ch).BuildString;
         TTBaum(tb.right_ch.right_ch).BuildString;
         TBoolBaum(tb.left_ch).RebuildSourceStr;
         tbs := 'if(' + TBoolBaum(tb.left_ch).SourceStr + '; ' +
                        TTBaum(tb.right_ch.left_ch).source_str + '; ' +
                        TTBaum(tb.right_ch.right_ch).source_str + ')';
         end;
    40 : tbs := 'random(' + tbs(tb.right_ch) + ')';
    41 : begin
         GeoObj := TGeoObjListe(Drawing).GetValidObj(Round(tb.right_ch.value));
         tbs := 'slope(' + GeoObj.Name + ')';
         end;
    49 : begin  { User-defined function }
         GeoObj := TGeoObjListe(Drawing).GetValidObj(tb.right_ch.GetVInt(0));
         If GeoObj <> Nil then begin
           n := tb.GetVInt(0);
           buf := GeoObj.Name;
           For i := 1 to n do
             buf := buf + '''';
           tbs := buf + '(' + tbs(tb.right_ch.right_ch) + ')';
           end
         else
           error_str := TBMsg[18];    {'Kein passendes Objekt gefunden !'}
         end;
    50 : tbs := tbs(tb.left_ch) + '°';
  ELSE
    error_str := TBMsg[16];  {'Unbekannter Operator !'}
  END; { of case }
  END;


function TTBaum.Convert2OnlyRAD(st: WideString; isAngleTerm: Boolean): WideString;
  begin
  Result := st;
  if FAngleMode = Deg then begin
    try
      FreeAndNil(baum);
      baum := term(st);
      if baum <> Nil then begin
        transformTrig(baum);
        if isAngleTerm then
          transformDegTerm2Rad(baum);
        deleteTrigLoops(baum);
        Result := tbs(baum);
        end;
      FreeAndNil(baum);
    except
      Exit;
    end; { of try }
    FAngleMode := Rad;
    end;
  end;

procedure TTBaum.UpdateDegSourceAndBuildTree(st: WideString;
                                    isAngleTerm: Boolean  );
  { 25.09.2010 : Rekonstruktion des Term-Strings aus einem eventuell
                 vorhandenen Termbaum ergänzt, weil alte Dateien
    (2.4 / 2.5) gelegentlich falsche Termstrings enthalten. In diesem
    Fällen kann der korrekte Termstring aus dem binär gespeicherten
    Baum rekonstruiert werden.                                          }
  var rss: WideString; // "r"econstructed "s"ource "s"tring
  begin
  BuildString;
  rss := source_str;
  if TGeoObjListe(Drawing).IsOldDegRadProblemVersion then
    st := Convert2OnlyRAD(st, isAngleTerm);
  BuildTree(st);
  if (status <= tbCompError) and (Length(rss) > 0) then begin
    if TGeoObjListe(Drawing).IsOldDegRadProblemVersion then
      rss := Convert2OnlyRad(rss, isAngleTerm);
    BuildTree(rss);
    end;
  end;

PROCEDURE TTBaum.BuildTree (st : WideString);
  { Interpretiert den String st; dabei werden die interpretierten Zeichen
    aus st entfernt, ohne dass dies aber in der aufrufenden Prozedur
    zu sehen wäre: st ist Werte-Parameter! }
  BEGIN
  Reset;
  source_str := st;
  KillLeadingBlanks(st);
  IF st <> '' THEN BEGIN
    baum := term (st);
    IF (st        > '') OR
       (error_str > '') THEN BEGIN
      IF error_str = '' THEN
        error_str := TBMsg[3];  {'Syntaxfehler !'}
      error_spot := SUCC (LENGTH (source_str) - LENGTH (st));
      If (error_str = TBMsg[6]) and
         OldCoordFuncUsed(Copy(source_str, error_spot, Length(st))) then
        error_str := TBMsg[21];
      status     := tbCompError;
      END
    ELSE BEGIN
      error_spot := 0;
      status     := tbOkay;
      source_str := tbs(baum);
      END;
    END;
  END;  { of BuildTree }


PROCEDURE TTBaum.BuildTreeAndReturn(var st : WideString);
  { Interpretiert den String st und gibt im Variablen-Parameter
    st die noch nicht interpretierten Zeichen zurück }
  var n : Integer;
  begin
  Reset;
  KillLeadingBlanks(st);
  source_str := st;
  If st <> '' then begin
    baum := term (st);
    If (baum = Nil) and (error_str = '') then
      error_str := TBMsg[3];  {'Syntaxfehler !'}
    If error_str <> '' then begin
      error_spot := SUCC (LENGTH (source_str) - LENGTH (st));
      If (error_str = TBMsg[6]) and
         OldCoordFuncUsed(Copy(source_str, error_spot, Length(st))) then
        error_str := TBMsg[21];
      status     := tbCompError;
      end
    else begin
      error_spot := 0;
      status     := tbOkay;
      n := Length(st);
      If n > 0 then
        Delete(source_str, Succ(Length(source_str) - n), n);
      end;
    end;
  end;  { of BuildTree }


function TTBaum.TVCalculated(knot: TKnoten; var tv: Double): Boolean;
  var n   : Array [1..4] of Integer;
      obj : Array [1..3] of TGeoObj;
      xp, yp : Double;
      i   : Integer;
  begin
  Result := False;
  knot.Read4Int(n[1], n[2], n[3], n[4]);
  For i := 1 to 3 do
    obj[i] := TGeoObjListe(Drawing).GetValidObj(n[i]);
  If (obj[1] <> Nil) and (obj[1] is TGPoint) and
     (obj[2] <> Nil) and (obj[2] is TGPoint) and
     (obj[3] <> Nil) and (obj[3] is TGPoint) then
    Result := GetPedalPoint(obj[2].X, obj[2].Y, obj[3].X, obj[3].Y,
                            obj[1].X, obj[1].Y, xp, yp)
              and GetTV    (obj[2].X, obj[2].Y, obj[3].X, obj[3].Y,
                            xp, yp, tv);

  end;

PROCEDURE TTBaum.Calculate (x : DOUBLE; VAR y : DOUBLE);
  { Jeder Aufruf dieser Prozedur verursacht einen Versuch, den Wert des
    Termbaums zu berechnen, unabhängig davon, ob frühere Berechnungen
    erfolgreich waren oder nicht. Damit machen die Variablen Status und
    error_str nur eine Aussage über den jeweils letzten Berechnungs-
    versuch, nicht aber über die Berechenbarkeit des Terms insgesamt.
    Dies ist sinnvoll, weil sich seit dem vorigen Berechnungsversuch
    die Berechenbarkeit geändert haben könnte.
    Letzte Änderung : 01.06.01

    Die Prozedur wurde im Zusammenhang mit den Umbauarbeiten für das XML-
    Datenformat erweitert, so dass sie nun einen automatischen Kompilier-
    versuch unternimmt, wenn bei ihrem Aufruf die Bedingung
       (baum = Nil) and (source_str <> '')
    erfüllt ist. Ist dieser erfolgreich, dann wird der Baum sofort
    ausgewertet und der Termwert wie üblich zurückgeliefert.
    Letzte Änderung: 02.09.03                                           }

  FUNCTION tbw (tb : TKnoten) : DOUBLE;

    VAR arg, denom, res : DOUBLE;
        int_arg         : Integer;
        tv              : TBoolBaum;
        tw              : TTBaum;
        GeoObj          : TGeoObj;

    BEGIN
    Result := 0.0;
    CASE tb.token OF
       0 : Result := tb.value;          { Konstante }
       1 : Result := x;                 { Funktions-Argument }
       2 : Result := tbw (tb.left_ch) + tbw (tb.right_ch);
       3 : Result := tbw (tb.left_ch) - tbw (tb.right_ch);
       4 : Result := tbw (tb.left_ch) * tbw (tb.right_ch);
       5 : BEGIN
           denom := tbw (tb.right_ch);
           If ABS (denom) >= Epsilon THEN
             Result := tbw (tb.left_ch) / denom
           ELSE
             error_str := TBMsg[9];   {'Division durch Null !'}
           END;
       6 : If power(tbw (tb.left_ch), tbw (tb.right_ch), res) then
             Result := res
           else
             error_str := TBMsg[13];  {'Negatives LOG-Argument !'}
       7 : Result := tbw (tb.right_ch);
       8 : IF FAngleMode = Rad THEN
             Result := SIN (tbw (tb.right_ch))
           ELSE
             Result := SIN (bogen(tbw(tb.right_ch)));
       9 : IF FAngleMode = Rad THEN
             Result := COS (tbw (tb.right_ch))
           ELSE
             Result := COS (bogen(tbw(tb.right_ch)));
      10 : BEGIN
           IF FAngleMode = Rad THEN
             arg := tbw(tb.right_ch)
           ELSE
             arg := bogen(tbw(tb.right_ch));
           denom := COS (arg);
           IF ABS (denom) >= Epsilon THEN
             Result := SIN (arg) / denom
           ELSE
             error_str := TBMsg[10];  {'Unzulässiges Argument !'}
           END;
      11 : BEGIN
           arg := tbw(tb.right_ch);
           IF arg >= 0.0 THEN
             Result := SQRT (Abs(arg))
           ELSE
             error_str := TBMsg[11];  {'Negativer Radikand !'}
           END;
      12 : BEGIN
           arg := tbw(tb.right_ch);
           IF arg > 0.0 THEN
             Result := LN  (arg)
           ELSE
             error_str := TBMsg[12];  {'Negatives LN-Argument !'}
           END;
      13 : Result := EXP (tbw (tb.right_ch));
      14 : BEGIN
           arg := tbw(tb.right_ch);
           IF arg > 0.0 THEN
             Result := LN  (tbw (tb.right_ch)) / LN (10.0)
           ELSE
             error_str := TBMsg[13];  {'Negatives LOG-Argument !'}
           END;
      15 : BEGIN
           Result := ARCTAN (tbw (tb.right_ch));
           IF FAngleMode = Deg THEN
             Result := grad(Result);
           END;
      16 : Result := -1.0 * tbw (tb.right_ch);
      17 : Result := ABS (tbw (tb.right_ch));
      18 : Result := SQR (tbw (tb.right_ch));
      19 : Result := INT (tbw (tb.right_ch));
      20 : Result := FRAC (tbw (tb.right_ch));
      21 : Result := 1 / SQRT (2*PI) * exp (- 0.5 * SQR (tbw(tb.right_ch)));
      22 : BEGIN                                                    { Abstand     }
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) and
              (GeoObj.ClassType = TGDistLine) and
               GeoObj.DataValid THEN
             Result := TGDistLine(GeoObj).GetValue(gv_val)
           ELSE
             error_str := TBMsg[14];  {'Abstand nicht gefunden !'}
           END;
      23 : BEGIN                                                    { Winkelweite }
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) and
              (GeoObj.ClassType = TGAngleWidth) and
              (GeoObj.DataValid) THEN BEGIN
             Result := TGAngleWidth(GeoObj).GetValue(gv_val);
             IF FAngleMode = Deg THEN
               Result := grad(Result);
             END
           ELSE
             error_str := TBMsg[15];  {'Winkelweite nicht gefunden !'}
           END;
      24 : begin
           arg := tbw(tb.right_ch);
           If Abs(arg) <= 1.0 then begin
             Result := ArcSin(arg);
             IF FAngleMode = Deg THEN
               Result := grad(Result);
             end
           else
             error_str := TBMsg[10];  {'Unzulässiges Argument !'}
           end;
      25 : begin
           arg := tbw(tb.right_ch);
           If Abs(arg) <= 1.0 then begin
             Result := ArcCos(arg);
             IF FAngleMode = Deg THEN
               Result := grad(Result);
             end
           else
             error_str := TBMsg[10];  {'Unzulässiges Argument !'}
           end;
      26 : begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) and
              (GeoObj.DataValid) THEN
             Result := GeoObj.GetValue(gv_x)
           ELSE
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
           end;
      27 : begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) and
              (GeoObj.DataValid) THEN
             Result := GeoObj.GetValue(gv_y)
           ELSE
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
           end;
      28 : begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) THEN   // Prüfung auf DataValid entfernt !
             Result := GeoObj.GetValue(gv_len)
           ELSE
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
           end;
      29 : begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) and
              (GeoObj is TGCircle) and
              (GeoObj.DataValid) THEN
             Result := GeoObj.GetValue(gv_radius)
           ELSE
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
           end;
      30 : begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) and (GeoObj.DataValid) and
              ((GeoObj is TGArea) or (GeoObj is TGPolygon) or
               (GeoObj is TGCircle) or (GeoObj is TGConic)) THEN
             Result := GeoObj.GetValue(gv_area)
           ELSE
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
           end;
      31 : begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) and
              ((GeoObj is TGNumber) or (GeoObj is TGShortLine)) and
              (GeoObj.DataValid) THEN
             Result := GeoObj.GetValue(gv_val)
           ELSE
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
           end;
      32 : If TVCalculated(tb.right_ch, res) then
             Result := res
           else
             error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
      33 : begin
           arg := tbw(tb.right_ch);
           IF Abs(arg) < MaxInt THEN
             Result := floor(arg)
           ELSE
             error_str := TBMsg[10];  {'Unzulässiges Argument !'}
           end;
      34 : begin
           arg := tbw(tb.right_ch);
           IF Abs(arg) < MaxInt THEN
             Result := ceil(arg)
           ELSE
             error_str := TBMsg[10];  {'Unzulässiges Argument !'}
           end;
      35 : begin  { Signum - Funktion }
           arg := tbw(tb.right_ch);
           IF Abs(arg) > epsilon THEN
             If arg > 0 then
               Result := 1
             else
               Result := -1
           ELSE
             Result := 0;
           end;
      36 : Result := grad(tbw(tb.right_ch));
      37 : Result := bogen(tbw(tb.right_ch));
      38 : begin  { Rundungs - Funktion }
           arg := tbw(tb.right_ch);
           If Abs(arg) < MaxInt then
             Result := SafeRound(arg)
           else
             error_str := TBMsg[10];
           end;
      39 : begin { If - Funktion }
           tv := TBoolBaum(tb.left_ch);
           If tv.Calculate(x) then
             tw := TTBaum(tb.right_ch.left_ch)
           else
             tw := TTBaum(tb.right_ch.right_ch);
           tw.Calculate(x, res);
           If tw.is_okay then
             Result := res
           else
             error_str := tw.error_str;
           end;
      40 : begin  { Zufalls - Funktion }
           int_arg := SafeRound(tbw(tb.right_ch));
           If int_arg > 1 then
             Result := Random(int_arg)
           else
             Result := Random;
           end;
      41 : try  { Slope - Funktion }
             GeoObj := TGeoObjListe(Drawing).GetValidObj(Round(tb.right_ch.value));
             if GeoObj.IsCompatibleWith(ccFunktion) then
               if TGFunktion(GeoObj).GetDerivationValue(x, 1, res) then
                 Result := res
               else
                 error_str := TBMsg[23]   {'Wert nicht verfügbar!'}
             else
               begin
               Result := GeoObj.GetValue(gv_slope);
               if IsNan(Result) then
                 error_str := TBMsg[23]   {'Wert nicht verfügbar!'}
               end;
           except
             error_str := TBMsg[23];   {'Wert nicht verfügbar!'}
           end;
      49 : try  { User-defined function }
             GeoObj := TGeoObjListe(Drawing).GetValidObj(tb.right_ch.GetVInt(0));
             arg := tbw(tb.right_ch.right_ch);
             int_arg := tb.GetVInt(0);
             If (int_arg >= 0) and (int_arg < 2) then
               If TGFunktion(GeoObj).GetDerivationValue(arg, int_arg, res) then
                 Result := res
               else
                 error_str := TBMsg[22]
             else
               error_str := TBMsg[22];
           except
             error_str := TBMsg[22];
           end;
      50 : Result := bogen(tbw(tb.left_ch));
    ELSE
      error_str := TBMsg[16];  {'Unbekannter Operator !'}
    END; { of case }
    END;

  VAR sbuf : WideString;

  BEGIN
  status    := tbOkay;   { Siehe Kommentar im Kopf der Prozedur }
  error_str := '';
  IF (baum = NIL) AND    { Kompilierungs-Automatik, siehe ebenfalls oben }
     (Length(source_str) > 0) THEN BEGIN
    sbuf := source_str;
    BuildTree(sbuf);
    END;
  IF (baum <> NIL) AND (status = tbOkay) THEN BEGIN
    try
      y := tbw (baum);
    except
      error_spot := 1;
      error_str  := tbmsg[20];    { 'Bereichsüberschreitung' }
      status     := tbCalcError;
    end;
    If Length(error_str) > 0 THEN
      status := tbCalcError;
    END;
  END;


FUNCTION TTBaum.Derive(knot: TKnoten): TKnoten;
  var t1, t2 : TTBaum;
      tv     : TBoolBaum;
      k1, k2 : TKnoten;
      n      : Integer;
  BEGIN
  CASE knot.Token OF
     0 : Result := TKnoten.Create(0, 0, Nil, Nil);   { Konstante }
     1 : If ROUND(knot.Value) = 0 then
           Result := TKnoten.Create(0, 1, Nil, Nil)  { x }
         else
           Result := TKnoten.Create(0, 0, Nil, Nil); { Parameter }
     2,
     3 : Result := TKnoten.Create(knot.token, 0,     { Summe, Differenz }
                     Derive(knot.left_ch),
                     Derive(knot.right_ch));
     4 : begin                                       { Produkte : }
         If knot.right_ch.token = 0 then               { Konstanten vor ! }
           knot.SwitchChildren;
         If knot.left_ch.token = 0 then                { Konst * f(x) }
           Result := TKnoten.Create(4, 0,
                       CopyKnot(knot.left_ch),
                       Derive(knot.right_ch))
         else
           Result := TKnoten.Create(2, 0,              { f(x) * g(x) }
                       TKnoten.Create(4, 0,
                         Derive(knot.left_ch),
                         CopyKnot(knot.right_ch)),
                       TKnoten.Create(4, 0,
                         Derive(knot.right_ch),
                         CopyKnot(knot.left_ch)));
         end;
     5 : If knot.right_ch.token = 0 then begin       { Quotienten : }
           k1 := Derive(knot.left_ch);                      { f(x) / Konst }
           If k1.token in [2, 3] then                    // falls nötig:
             k2 := TKnoten.Create(7, 1, Nil, k1)         // Klammer um den Zähler
           else
             k2 := k1;
           Result := TKnoten.Create(5, 0,
                       k2,
                       CopyKnot(knot.right_ch))
           end
         else
           Result := TKnoten.Create(5, 0,                   { f(x) / g(x) }
                       TKnoten.Create(7, 1,              // Klammer um den Zähler
                         Nil,
                         TKnoten.Create(3, 0,
                           TKnoten.Create(4, 0,
                             Derive(knot.left_ch),
                             CopyKnot(knot.right_ch)),
                           TKnoten.Create(4, 0,
                             Derive(knot.right_ch),
                             CopyKnot(knot.left_ch)))),
                       TKnoten.Create(18, 0,
                         Nil,
                         CopyKnot(knot.right_ch)));
     6 : Case knot.left_ch.token of                  { Potenzen : }
           0 : Result := TKnoten.Create(4, 0,          { Konstante ^ g(x) }
                           CopyKnot(knot),
                           TKnoten.Create(4, 0,
                             Derive(knot.right_ch),
                             TKnoten.Create(12, 0,
                               Nil,
                               CopyKnot(knot.left_ch))));
           1 : If knot.right_ch.token = 0 then         { x ^ Konstante }
                 If Abs(knot.right_ch.value - 1.0) < epsilon then { x^1 }
                   Result := TKnoten.Create(0, 1, Nil, Nil)
                 else if Abs(knot.right_ch.value - 2.0) < epsilon then
                   Result := TKnoten.Create(4, 0,                 { x^2 }
                               CopyKnot(knot.right_ch),
                               TKnoten.Create(1, 0, Nil, Nil))
                 else                                             { x^k }
                   Result := TKnoten.Create(4, 0,
                               CopyKnot(knot.right_ch),
                               TKnoten.Create(6, 0,
                                 TKnoten.Create(1, 0, Nil, Nil),
                                 TKnoten.Create(0, knot.right_ch.value - 1.0,
                                   Nil,
                                   Nil)))
               else                                    { x ^ g(x) }
                 Result := TKnoten.Create(4, 0,
                             CopyKnot(knot),
                             TKnoten.Create(7, 1,        // Klammer um die Summe
                               Nil,
                               TKnoten.Create(2, 0,
                                 TKnoten.Create(4, 0,
                                   Derive(knot.right_ch),
                                   TKnoten.Create(12, 0,
                                     Nil,
                                     TKnoten.Create(1, 0, Nil, Nil))),
                                 TKnoten.Create(5, 0,
                                   CopyKnot(knot.right_ch),
                                   TKnoten.Create(1, 0, Nil, Nil)))));
         else { of case }
           If knot.right_ch.token = 0 then             { f(x) ^ Konstante }
             If ABS(knot.right_ch.value - 1.0) < epsilon then   { f(x)^1 }
               Result := Derive(knot.left_ch)
             else if Abs(knot.right_ch.value - 2.0) < epsilon then
               Result := TKnoten.Create(4, 0,                   { f(x)^2 }
                           CopyKnot(knot.right_ch),
                           TKnoten.Create(4, 0,
                             CopyKnot(knot.left_ch),
                             Derive(knot.left_ch)))
             else                                               { f(x)^k }
               Result := TKnoten.Create(4, 0,
                           CopyKnot(knot.right_ch),
                           TKnoten.Create(4, 0,
                             TKnoten.Create(6, 0,
                               CopyKnot(knot.left_ch),
                               TKnoten.Create(0, knot.right_ch.value - 1.0,
                                              NIL, NIL)),
                             Derive(knot.left_ch)))
           else
             Result := TKnoten.Create(4, 0,            { f(x) ^ g(x) }
                         CopyKnot(knot),
                         TKnoten.Create(7, 1,            // Klammer um die Summe
                           Nil,
                           TKnoten.Create(2, 0,
                             TKnoten.Create(4, 0,
                               Derive(knot.right_ch),
                               TKnoten.Create(12, 0,
                                 Nil,
                                 CopyKnot(knot.left_ch))),
                             TKnoten.Create(4, 0,
                               CopyKnot(knot.right_ch),
                               TKnoten.Create(5, 0,
                                 Derive(knot.left_ch),
                                 CopyKnot(knot.left_ch))))));
         end;
     7 : Result := TKnoten.Create(7, 1,              { Klammer }
                     Nil,
                     Derive(knot.right_ch));
     8 : Result := TKnoten.Create(4, 0,              { sin }
                     Derive(knot.right_ch),
                     TKnoten.Create(9, 0,
                       Nil,
                       CopyKnot(knot.right_ch)));
     9 : Result := TKnoten.Create(4, 0,              { cos }
                     Derive(knot.right_ch),
                     TKnoten.Create(16, 0,
                       Nil,
                       TKnoten.Create(8, 0,
                         Nil,
                         CopyKnot(knot.right_ch))));
    10 : Result := TKnoten.Create(5, 0,              { tan }
                    Derive (knot.right_ch),
                    TKnoten.Create(18, 0,
                      Nil,
                      TKnoten.Create(9, 0,
                        Nil,
                        CopyKnot(knot.right_ch))));
    11 : Result := TKnoten.Create(5, 0,              { sqrt }
                    Derive (knot.right_ch),
                    TKnoten.Create(4, 0,
                      TKnoten.Create(0, 2, Nil, Nil),
                      CopyKnot(knot)));
    12 : Result := TKnoten.Create(5, 0,              { ln }
                    Derive(knot.right_ch),
                    CopyKnot(knot.right_ch));
    13 : Result := TKnoten.Create(4, 0,              { exp }
                    Derive(knot.right_ch),
                    CopyKnot(knot));
    14 : Result := TKnoten.Create(4, 0,              { log }
                    TKnoten.Create(0, 1/ln(10), Nil, Nil),
                    TKnoten.Create(5, 0,
                      Derive(knot.right_ch),
                      CopyKnot(knot.right_ch)));
    15 : Result := TKnoten.Create(5, 0,              { arctan }
                    Derive(knot.right_ch),
                    TKnoten.Create(2, 0,
                      TKnoten.Create(0, 1, Nil, Nil),
                      TKnoten.Create(18, 0,
                        Nil,
                        CopyKnot(knot.right_ch))));
    16 : Result := TKnoten.Create(16, 0,             { Change Sign }
                     Nil,
                     Derive(knot.right_ch));
    17 : Result := TKnoten.Create(4, 0,              { Abs }
                    Derive(knot.right_ch),
                    TKnoten.Create(22, 0,
                      Nil,
                      CopyKnot(knot.right_ch)));
    18 : Result := TKnoten.Create(4, 0,              { Sqr }
                    TKnoten.Create(0, 2, Nil, Nil),
                    TKnoten.Create(4, 0,
                      Derive(knot.right_ch),
                      CopyKnot(knot.right_ch)));
    19 : Result := TKnoten.Create(0, 0, Nil, Nil);   { Int }
    20 : Result := Derive(knot.right_ch);            { Frac }
    21 : Result := TKnoten.Create(4, 0,              { Gauss }
                    CopyKnot(knot),
                    TKnoten.Create(4, 0,
                      TKnoten.Create(0, -2, Nil, Nil),
                      TKnoten.Create(4, 0,
                        Derive(knot.right_ch),
                        CopyKnot(knot.right_ch))));
    22,                                              { Abstand }
    23 : Result := TKnoten.Create(0, 0, Nil, Nil);   { Winkelweite }
    24 : Result := TKnoten.Create(5, 0,              { ArcSin }
                    Derive(knot.right_ch),
                    TKnoten.Create(11, 0,
                      Nil,
                      TKnoten.Create(3, 0,
                        TKnoten.Create(0, 1, Nil, Nil),
                        TKnoten.Create(18, 0,
                          Nil,
                          CopyKnot(knot.right_ch)))));
    25 : Result := TKnoten.Create(16, 0,             { ArcCos }
                    Nil,
                    TKnoten.Create(5, 0,
                      Derive(knot.right_ch),
                      TKnoten.Create(11, 0,
                        Nil,
                        TKnoten.Create(3, 0,
                          TKnoten.Create(0, 1, Nil, Nil),
                          TKnoten.Create(18, 0,
                            Nil,
                            CopyKnot(knot.right_ch))))));

    26, 27, 28, 29, 30, 31, 32,                      { Euklid-Konstanten  }
    33, 34,                                          { Floor [x], Ceil[x] }
    35 : Result := TKnoten.Create(0, 0, Nil, Nil);   { Signum             }
    36 : Result := TKnoten.Create(36, 0,             { Grad               }
                    Nil,
                    Derive(knot.right_ch));
    37 : Result := TKnoten.Create(37, 0,             { Bogen              }
                    Nil,
                    Derive(knot.right_ch));
    38 : Result := TKnoten.Create(0, 0, Nil, Nil);   { Rnd                }
    39 : begin
        tv := TBoolBaum.Create(Drawing, FAngleMode, TBoolBaum(knot.left_ch).SourceStr);
        t1 := TTBaum.CreateDerivationOf(TTBaum(knot.right_ch.left_ch));
        t2 := TTBaum.CreateDerivationOf(TTBaum(knot.right_ch.right_ch));
        Result := TKnoten.Create(39, 1,             { If                  }
                    Pointer(tv),
                    TKnoten.Create(200, 0,
                                   Pointer(t1), Pointer(t2)));
        end;
    41 : Result := Nil;                             { Slope               }
                          { (wird generell als nicht ableitbar angesehen) }
    49 : try
          n  := knot.right_ch.GetVInt(0);
          k1 := CopyKnot(knot.right_ch.right_ch);
          k2 := Derive(k1);
          Result := TKnoten.Create(4, 0, k2,
                        TKnoten.Init4Int(41, 1, 0, 0, 0, Nil,
                           TKnoten.Init4Int(0, n, 0, 0, 0, Nil, k1)));
        except
          Result := Nil;  { notfalls !}
        end;
  ELSE
    Result := Nil;
  END; { of case }
  END;


procedure TTBaum.Integrate(aa, bb: Double; var ss: Double);
  { Berechnet mit einem adaptiven Quadratur-Verfahren einen numerischen
    Näherungswert für das Integral von a bis b über die Funktion f.
    Funktioniert nur dann sicher, wenn f auf [a;b] stetig ist - und am
    besten zur Sicherheit gleich noch stetig differenzierbar.
    Details siehe Faires, Burden "Numerische Methoden",  S.140 ff

    21.11.2008 : Bei periodischen Integranden kann es zum vorzeitigen
                 Abbruch der Berechnung kommen, weil schon die Ergebnisse
    der ersten beiden Iterationsstufen zufälligerweise hinreichend dicht
    beieinander liegen. Um dies zu vermeiden, wurde die zusätzliche Ab-
    bruchbedingung "LEV > 3" (siehe [*]) ergänzt. Nun werden immer
    mindestens 8 Teilintervalle berechnet.                              }

  var  TOL, A, H, S, FA, FB, FC: array [1..50] of Double;
       V : array [1.. 7] of Double;
       L : array [1..50] of Integer;
       APP, S1, S2, FD, FE : Double;
       N, I, LEV : integer;
       OK : boolean;
  label j_exit;

  begin
  N   :=   40;      //  maximale Schachtelungstiefe
  OK  := True;
  APP :=  0.0;      //  Ergebnis-Puffer
  I   :=    1;
  TOL[I] := 1e-5;   //  => maximaler Fehler des Ergebnisses < 1e-6 !
  A[I] := aa;
  H[I] := 0.5 * (bb - aa);
  If is_Okay then Calculate(aa,        FA[I]) else goto j_exit;
  If is_Okay then Calculate(aa + H[I], FC[I]) else goto j_exit;
  If is_Okay then Calculate(bb,        FB[I]) else goto j_exit;
  S[I] := H[I] * (FA[I] + 4.0 * FC[I] + FB[I]) / 3.0;
  L[I] := 1;
  while (I > 0) and OK do begin
    If is_Okay then Calculate(A[I] + 0.5 * H[I], FD) else goto j_exit;
    If is_Okay then Calculate(A[I] + 1.5 * H[I], FE) else goto j_exit;
    S1 := H[I] * ( FA[I] + 4.0 * FD + FC[I] ) / 6.0;
    S2 := H[I] * ( FC[I] + 4.0 * FE + FB[I] ) / 6.0;
    V[1] := A[I];
    V[2] := FA[I];
    V[3] := FC[I];
    V[4] := FB[I];
    V[5] := H[I];
    V[6] := TOL[I];
    V[7] := S[I];
    LEV := L[I];
    I := I - 1;
    if (abs( S1 + S2 - V[7] ) < V[6]) and (LEV > 3) then  // [*]
      APP := APP + ( S1 + S2 )
    else
      if ( LEV >= N ) then
        OK := false  { Procedure fails }
      else begin
        I := I + 1;          { Data for right half subinterval }
        A[I] := V[1] + V[5];
        FA[I] := V[3];
        FC[I] := FE;
        FB[I] := V[4];
        H[I] := 0.5 * V[5];
        TOL[I] := 0.5 * V[6];
        S[I] := S2;
        L[I] := LEV + 1;
        I := I + 1;          { Data for left half subinterval }
        A[I] := V[1];
        FA[I] := V[2];
        FC[I] := FD;
        FB[I] := V[3];
        H[I] := H[I-1];
        TOL[I] := TOL[I-1];
        S[I] := S1;
        L[I] := L[I-1]
        end;
    end;

  j_exit:
  if not OK then
    status := tbCalcError
  else
    ss     := APP;
  end;


PROCEDURE TTBaum.BuildString;
  { 25.05.2008 : Wegen "BaumImFluss"-Bug von Dietmar Viertel wurden in der
                 Funktion tbs alle Überprüfungen in den EUKLID-Funktionen
    auf GeoObj.IsValid entfernt. Auch wenn ein Objekt (derzeit!) ungültig
    ist, muss der Termstring komplett generiert werden, sofern er sich
    aus der Struktur des Termbaumes eindeutig ableiten lässt.
    Bisher wurde in einem solchen Fall ein leerer String zurückgegeben,
    mit fatalen Folgen z.B. im Zusammenhang mit der if-Funktion.          }

  VAR st : WideString;

  BEGIN
  IF (baum <> Nil) and
     (status > tbCompError) THEN BEGIN    { Berechnungsfehler tolerieren ! }
    error_str := '';
    st := tbs (baum);
    IF error_str = '' THEN
      source_str := st
    ELSE
      source_str := '';
    END;
  END;


PROCEDURE TTBaum.ChangeSign;
  begin
  If (Status = tbOkay) and (baum <> Nil) then
    If Baum.token = 0 then begin    { Falls der Baum nur eine }
      Baum.Value := - Baum.Value;   {   Konstanten enthält    }
      BuildString;
      end
    else begin                      { Komplexerer Term        }
      source_str := '-(' + source_str + ')';
      BuildTree(source_str);
      end;
  end;


PROCEDURE TTBaum.SetNewNames(MakroNum: Integer);
  var ActMakro: TMakro;

  procedure ExchangeNames(knot: TKnoten);
    var n     : Array [0..3] of Integer;
        j, np : Integer;
    begin
    If knot <> Nil then
      If knot.token In EuklidToken then
        Case Knot.token of
          22, 23: If knot.right_ch.right_ch <> Nil then begin
                    knot.right_ch.value := 0.0;
                    knot.right_ch.right_ch.Read4Int(n[0], n[1], n[2], n[3]);
                    For j := 0 to 3 do
                      If n[j] <> 0 then begin
                        np := ActMakro.GetNewObj(n[j]).GeoNum;
                        If np > 0 then
                          n[j] := np;
                        end;
                    knot.right_ch.right_ch.Write4Int(n[0], n[1], n[2], n[3]);
                    end
                  else
                    ActMakro.MakroStatus := -4;
          26..31: begin
                  np := Round(knot.right_ch.value);
                  knot.right_ch.value := ActMakro.GetNewObj(np).GeoNum;
                  end;
        else
          ActMakro.MakroStatus := -4;
        end  { of case }
      else begin
        ExchangeNames(knot.left_ch);
        ExchangeNames(knot.right_ch);
        end;
    end;

  begin
  ActMakro := TGeoObjListe(Drawing).MakroList.Items[MakroNum];
  ExchangeNames(baum);
  end;


procedure TTBaum.KillDirectMOLinks;
  { löscht alle GeoNummern von Maßobjekten aus dem Termbaum }
  procedure KDML(knot: TKnoten);
    begin
    If knot <> Nil then with knot do
      If token In EuklidToken then
        If right_ch.right_ch <> Nil then
          right_ch.value := 0.0
        else
      else begin
        KDML(left_ch);
        KDML(right_ch);
        end;
    end;

  begin
  KDML(baum);
  end;


PROCEDURE TTBaum.GetInfo(var info : STRING; NameList: TList);

  FUNCTION GetNewName (NewNameStart : String; knot : TKnoten) : STRING;
    VAR n    : ARRAY [0..3] OF Integer;
        i    : Integer;
        GNN  : STRING;
        TGO  : TGeoObj;

    BEGIN
    GNN := NewNameStart + '(';
    IF knot <> NIL THEN BEGIN
      knot.Read4Int(n[0], n[1], n[2], n[3]);
      FOR i := 0 TO 3 DO
        IF n[i] > 0 THEN BEGIN
          TGO := TGeoObjListe(Drawing).GetValidObj(n[i]);
          IF TGO <> Nil THEN BEGIN
            GNN := GNN + '?;';
            NameList.Add(TGO);
            END
          END;
      IF GNN[LENGTH(GNN)] = ';' THEN
        DELETE (GNN, LENGTH(GNN), 1);
      END;
    GetNewName := GNN + ')';
    END;

  FUNCTION tbs (tb : TKnoten) : STRING;

    VAR GeoObj : TGeoObj;
        pu     : WideString;
        i      : Integer;
    BEGIN
    CASE tb.token OF
       0 : tbs := Float2Str(tb.value, 3);
       1 : tbs := 'x';
       2 : tbs := tbs (tb.left_ch) + ' + ' + tbs (tb.right_ch);
       3 : tbs := tbs (tb.left_ch) + ' - ' + tbs (tb.right_ch);
       4 : tbs := tbs (tb.left_ch) + ' * ' + tbs (tb.right_ch);
       5 : tbs := tbs (tb.left_ch) + ' / ' + tbs (tb.right_ch);
       6 : tbs := tbs (tb.left_ch) + ' ^ ' + tbs (tb.right_ch);
       7 : BEGIN
           i   := Round(tb.value);
           pu  := '';
           tbs := pu + brackets[i] + ' ' + tbs (tb.right_ch) + ' ' + brackets[Succ(i)];
           END;
       8 : tbs := 'SIN ( ' + tbs (tb.right_ch) + ' )';
       9 : tbs := 'COS ( ' + tbs (tb.right_ch) + ' )';
      10 : tbs := 'TAN ( ' + tbs (tb.right_ch) + ' )';
      11 : tbs := 'SQRT ( ' + tbs (tb.right_ch) + ' )';
      12 : tbs := 'LN ( '  + tbs (tb.right_ch) + ' )';
      13 : tbs := 'EXP ( ' + tbs (tb.right_ch) + ' )';
      14 : tbs := 'LOG ( ' + tbs (tb.right_ch) + ' )';
      15 : tbs := 'ARCTAN ( ' + tbs (tb.right_ch) + ' )';
      16 : tbs := '- ' + tbs (tb.right_ch);
      17 : tbs := 'ABS ( ' + tbs (tb.right_ch) + ' )';
      18 : tbs := 'SQR ( ' + tbs (tb.right_ch) + ' )';
      19 : tbs := 'INT ( ' + tbs (tb.right_ch) + ' )';
      20 : tbs := 'FRAC ( ' + tbs (tb.right_ch) + ' )';
      21 : tbs := 'NORMAL ( ' + tbs(tb.right_ch) + ' )';

      { Die folgenden beiden Token sind nur für EUKLID eingebaut : }
      22 : BEGIN  { Abstand }
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) then
             IF (GeoObj.ClassType = TGDistLine) AND
                 GeoObj.DataValid THEN BEGIN
               pu := 'd( ? ; ? )';
               GeoObj.InsertNameOf(TGeoObj(GeoObj.Parent[0]), pu);
               GeoObj.InsertNameOf(TGeoObj(GeoObj.Parent[1]), pu);
               tbs := pu;
               END
             ELSE
               error_str := TBMsg[14]  {'Abstand nicht gefunden !'}
           ELSE
             tbs := GetNewName('d', tb.right_ch.right_ch);
           END;
      23 : BEGIN  { Winkelweite }
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) then
             IF (GeoObj.ClassType = TGAngleWidth) AND
                 GeoObj.DataValid THEN BEGIN
               pu := 'w( ? ; ? ; ? )';
               GeoObj := GeoObj.Parent[0];
               For i := 1 to 3 do
                 GeoObj.InsertNameOf(TGeoObj(GeoObj.Parent[i]), pu);
               tbs := pu;
               END
             ELSE
               error_str := TBMsg[15]  {'Winkelweite nicht gefunden !'}
           ELSE
             tbs := GetNewName('w', tb.right_ch.right_ch);
           END;

      24 : tbs := 'ARCSIN ( ' + tbs(tb.right_ch) + ' )';
      25 : tbs := 'ARCCOS ( ' + tbs(tb.right_ch) + ' )';

      26 : BEGIN
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) AND
              GeoObj.DataValid THEN BEGIN
             pu := 'x( ? )';
             GeoObj.InsertNameOf(GeoObj, pu);
             tbs := pu;
             END
           ELSE
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           END;
      27 : BEGIN
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) AND
              GeoObj.DataValid THEN BEGIN
             pu := 'y( ? )';
             GeoObj.InsertNameOf(GeoObj, pu);
             tbs := pu;
             END
           ELSE
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           END;
      28 : BEGIN
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) AND
              GeoObj.DataValid THEN BEGIN
             pu := 'len( ? )';
             GeoObj.InsertNameOf(GeoObj, pu);
             tbs := pu;
             END
           ELSE
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           END;
      29 : BEGIN
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) AND
              (GeoObj is TGCircle) AND
              GeoObj.DataValid THEN BEGIN
             pu := 'radius( ? )';
             GeoObj.InsertNameOf(GeoObj, pu);
             tbs := pu;
             END
           ELSE
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           END;
      30 : BEGIN
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) AND
              GeoObj.DataValid THEN BEGIN
             pu := 'area( ? )';
             GeoObj.InsertNameOf(GeoObj, pu);
             tbs := pu;
             END
           ELSE
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           END;
      31 : BEGIN
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) AND
              ((GeoObj is TGNumberObj) or (GeoObj is TGShortLine)) AND
              GeoObj.DataValid THEN BEGIN
             pu := ' ? ';     // statt 'val( ? )';
             GeoObj.InsertNameOf(GeoObj, pu);
             tbs := pu;
             END
           ELSE
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           END;
      32 : BEGIN                                                 { Teilverhältnis }
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) then
             IF (GeoObj.ClassType = TGPoint) AND
                 GeoObj.DataValid THEN BEGIN
               pu := 'tv( ? ; ? ; ? )';
               GeoObj := GeoObj.Parent[0];
               For i := 0 to 2 do
                 GeoObj.InsertNameOf(TGeoObj(GeoObj.Parent[i]), pu);
               tbs := pu;
               END
             ELSE
               error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           ELSE
             tbs := GetNewName('tv', tb.right_ch);
           END;

      33 : tbs := 'FLOOR(' + tbs (tb.right_ch) + ')';
      34 : tbs := 'CEIL(' + tbs (tb.right_ch) + ')';
      35 : tbs := 'SGN(' + tbs(tb.right_ch) + ')';
      36 : tbs := 'GRAD(' + tbs (tb.right_ch) + ')';
      37 : tbs := 'BOGEN(' + tbs(tb.right_ch) + ')';
      38 : tbs := 'RND(' + tbs(tb.right_ch) + ')';
      39 : tbs := 'IF(' + TBoolBaum(tb.left_ch).SourceStr + '; ' +
                          TTBaum(tb.right_ch.left_ch).source_str + '; ' +
                          TTBaum(tb.right_ch.right_ch).source_str + ')';
      40 : tbs := 'RANDOM(' + tbs(tb.right_ch) + ')';
      41 : begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           If (GeoObj <> NIL) and
              GeoObj.DataValid then begin
             pu := 'SLOPE( ? )';
             GeoObj.InsertNameOf(GeoObj, pu);
             tbs := pu;
             end
           else
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           end;
      49 : begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(tb.right_ch.GetVInt(0));
           If GeoObj <> Nil then begin
             pu := ' ? (';
             GeoObj.InsertNameOf(GeoObj, pu);
             tbs := pu + tbs(tb.right_ch.right_ch) + ')';
             end
           else
             error_str := TBMsg[18];    {'Kein passendes Objekt gefunden !'}
           end;
    ELSE
      error_str := TBMsg[16];  {'Unbekannter Operator !'}
    END; { of case }
    END;

  BEGIN
  IF (baum <> Nil) AND
     (status = tbOkay) THEN
    info := tbs(baum)
  ELSE
    info := '{{ungültiger Term}}';
  END;


function TTBaum.GetHTMLString(calculateValues: Boolean = false): String;
  { liefert eine HTML-formatierte Version des Term-Strings }

  FUNCTION GetNewName (NewNameStart : String; knot : TKnoten) : String;
    VAR n    : ARRAY [0..3] OF Integer;
        i    : Integer;
        GNN  : String;
        TGO  : TGeoObj;

    BEGIN
    GNN := NewNameStart + '(';
    IF knot <> NIL THEN BEGIN
      knot.Read4Int(n[0], n[1], n[2], n[3]);
      FOR i := 0 TO 3 DO
        IF n[i] > 0 THEN BEGIN
          TGO := TGeoObjListe(Drawing).GetValidObj(n[i]);
          IF TGO <> Nil THEN
            GNN := GNN + TGO.GetFormattedName + ';';
          END
        ELSE If n[i] < 0 THEN
          GNN := GNN + '@' + IntToStr(Abs(n[i])) + ';';
      IF GNN[LENGTH(GNN)] = ';' THEN
        DELETE (GNN, LENGTH(GNN), 1);
      END;
    GetNewName := GNN + ')';
    END;

  FUNCTION tbs (tb : TKnoten) : String;

    VAR GeoObj : TGeoObj;
        n, i   : Integer;
        v      : Double;
        buf    : String;
    BEGIN
    CASE tb.token OF
       0 : If Abs(tb.value - pi   ) < 1e-12 then tbs := 'pi' else
           If Abs(tb.value - euler) < 1e-12 then tbs := 'e'
           else tbs := FloatToStrF(tb.value, ffGeneral, 10, 0);
       1 : tbs := 'x';
       2 : tbs := tbs (tb.left_ch) + ' + ' + tbs (tb.right_ch);
       3 : tbs := tbs (tb.left_ch) + ' - ' + tbs (tb.right_ch);
       4 : tbs := tbs (tb.left_ch) + '*' + tbs (tb.right_ch);
       5 : tbs := tbs (tb.left_ch) + '/' + tbs (tb.right_ch);
       6 : tbs := tbs (tb.left_ch) + '^' + tbs (tb.right_ch);
       7 : BEGIN
           i   := Round(tb.value);
           tbs := Char(brackets[i]) + ' ' + tbs (tb.right_ch) + ' ' + Char(brackets[Succ(i)]);
           END;
       8 : tbs := 'sin(' + tbs (tb.right_ch) + ')';
       9 : tbs := 'cos(' + tbs (tb.right_ch) + ')';
      10 : tbs := 'tan(' + tbs (tb.right_ch) + ')';
      11 : tbs := 'sqrt(' + tbs (tb.right_ch) + ')';
      12 : tbs := 'ln('  + tbs (tb.right_ch) + ')';
      13 : tbs := 'exp(' + tbs (tb.right_ch) + ')';
      14 : tbs := 'log(' + tbs (tb.right_ch) + ')';
      15 : tbs := 'arctan(' + tbs (tb.right_ch) + ')';
      16 : tbs := '-' + tbs (tb.right_ch);
      17 : tbs := 'abs(' + tbs (tb.right_ch) + ')';
      18 : tbs := 'sqr(' + tbs (tb.right_ch) + ')';
      19 : tbs := 'int(' + tbs (tb.right_ch) + ')';
      20 : tbs := 'frac(' + tbs (tb.right_ch) + ')';
      21 : tbs := 'normal(' + tbs(tb.right_ch) + ')';

      { Die folgenden beiden Token sind nur für EUKLID eingebaut : }
      22 : BEGIN  { Abstand }
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) and
              (GeoObj.ClassType = TGDistLine) THEN
             tbs := TGDistLine(GeoObj).GetFormattedName
           ELSE
             error_str := TBMsg[14]; {'Abstand nicht gefunden !'}
           END;
      23 : BEGIN  { Winkelweite }
           GeoObj := TGeoObjListe(Drawing).GetValidObj(ROUND(tb.right_ch.value));
           IF (GeoObj <> NIL) and
              (GeoObj.ClassType = TGAngleWidth) THEN
             tbs := TGDistLine(GeoObj).GetFormattedName
           ELSE
             error_str := TBMsg[15]; {'Winkelweite nicht gefunden !'}
           END;

      { Hier nochmals was Allgemeingültiges : }
      24 : tbs := 'arcsin(' + tbs(tb.right_ch) + ')';
      25 : tbs := 'arccos(' + tbs(tb.right_ch) + ')';

      { Und weitere Spezial-EUKLID-Token : }
      26 : BEGIN  { x-Wert }
           n := ROUND(tb.right_ch.value);
           If n > 0 then begin
             GeoObj := TGeoObjListe(Drawing).GetValidObj(n);
             IF GeoObj <> NIL THEN
               tbs := 'x(' + GeoObj.GetFormattedName + ')'
             ELSE
               error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
             end
           ELSE IF n < 0 THEN
             tbs := 'x(@' + IntToStr(Abs(n)) + ')'
           ELSE
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           END;
      27 : BEGIN  { y-Wert }
           n := ROUND(tb.right_ch.value);
           If n > 0 then begin
             GeoObj := TGeoObjListe(Drawing).GetValidObj(n);
             IF GeoObj <> NIL THEN
               tbs := 'y(' + GeoObj.GetFormattedName + ')'
             ELSE
               error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
             end
           ELSE IF n < 0 THEN
             tbs := 'y(@' + IntToStr(Abs(n)) + ')'
           ELSE
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           END;
      28 : BEGIN  { Länge }
           n := ROUND(tb.right_ch.value);
           If n > 0 then begin
             GeoObj := TGeoObjListe(Drawing).GetValidObj(n);
             IF (GeoObj <> NIL) and
                ((GeoObj is TGShortLine) or
                 (GeoObj is TGCircle) or       // für Umfang !
                 (GeoObj is TGPolygon)) THEN
               tbs := 'len(' + GeoObj.GetFormattedName + ')'
             ELSE
               error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
             end
           ELSE IF n < 0 THEN
             tbs := 'len(@' + IntToStr(Abs(n)) + ')'
           ELSE
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           END;
      29 : BEGIN  { Radius }
           n := ROUND(tb.right_ch.value);
           If n > 0 then begin
             GeoObj := TGeoObjListe(Drawing).GetValidObj(n);
             IF (GeoObj <> NIL) and
                (GeoObj is TGCircle) THEN
               tbs := 'radius(' + GeoObj.GetFormattedName + ')'
             ELSE
               error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
             end
           ELSE IF n < 0 THEN
             tbs := 'radius(@' + IntToStr(Abs(n)) + ')'
           ELSE
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           END;
      30 : BEGIN  { Flächeninhalt }
           n := ROUND(tb.right_ch.value);
           If n > 0 then begin
             GeoObj := TGeoObjListe(Drawing).GetValidObj(n);
             IF (GeoObj <> NIL) and
                ((GeoObj is TGCircle) or
                 (GeoObj is TGConic) or
                 (GeoObj is TGPolygon) or
                 (GeoObj is TGArea)) THEN
               tbs := 'area(' + GeoObj.GetFormattedName + ')'
             ELSE
               error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
             end
           ELSE IF n < 0 THEN
             tbs := 'area(@' + IntToStr(Abs(n)) + ')'
           ELSE
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           END;
      31 : BEGIN  { allg. Wert }
           n := ROUND(tb.right_ch.value);
           If n > 0 then begin
             GeoObj := TGeoObjListe(Drawing).GetValidObj(n);
             IF (GeoObj <> NIL) and
                ((GeoObj is TGNumber) or (GeoObj is TGShortLine)) THEN
               if calculateValues then begin
                 v  := GeoObj.GetValue(0);
                 tbs := '[' + Float2Str(v, LengthDecimals) + ']';
                 end
               else
                 tbs := GeoObj.GetFormattedName
             ELSE
               error_str := TBMsg[18];  {'Kein passendes Objekt gefunden !'}
             end
           ELSE IF n < 0 THEN
             tbs := 'val(@' + IntToStr(Abs(n)) + ')'
           ELSE
             error_str := TBMsg[18]  {'Kein passendes Objekt gefunden !'}
           END;
      32 : tbs := GetNewName('tv', tb.right_ch);

      { Zur Abwechslung mal wieder ein paar allgemeingültige Deklarationen : }
      33 : tbs := 'floor(' + tbs (tb.right_ch) + ')';
      34 : tbs := 'ceil(' + tbs (tb.right_ch) + ')';
      35 : tbs := 'sgn(' + tbs(tb.right_ch) + ')';
      36 : tbs := 'grad(' + tbs(tb.right_ch) + ')';
      37 : tbs := 'bogen(' + tbs(tb.right_ch) + ')';
      38 : tbs := 'rnd(' + tbs(tb.right_ch) + ')';
      39 : tbs := 'if(' + TBoolBaum(tb.left_ch).GetHTMLString + '; ' +
                          TTBaum(tb.right_ch.left_ch).GetHTMLString + '; ' +
                          TTBaum(tb.right_ch.right_ch).GetHTMLString + ')';
      40 : tbs := 'random(' + tbs(tb.right_ch) + ')';

      { Wieder was "Euklidisches..." }
      41 : begin
           GeoObj := TGeoObjListe(Drawing).GetValidObj(Round(tb.right_ch.value));
           tbs := 'slope(' + GeoObj.Name + ')';
           end;
      49 : begin  { User-defined function }
           GeoObj := TGeoObjListe(Drawing).GetValidObj(tb.right_ch.GetVInt(0));
           If GeoObj <> Nil then begin
             n := tb.GetVInt(0);
             buf := GeoObj.GetFormattedName;
             For i := 1 to n do
               buf := buf + '''';
             tbs := buf + '(' + tbs(tb.right_ch.right_ch) + ')';
             end
           else
             error_str := TBMsg[18];    {'Kein passendes Objekt gefunden !'}
           end;

      { Und schließlich noch mal was allgemeingültiges : }
      50 : tbs := tbs(tb.left_ch) + '°';

    ELSE
      error_str := TBMsg[16];  {'Unbekannter Operator !'}
    END; { of case }
    END;

  begin
  If (baum <> Nil) and
     (status > tbCompError) then
    Result := tbs(baum)
  else
    Result := source_str
  end;


FUNCTION TTBaum.GeoNumString: STRING;

  FUNCTION GetNewName (NewNameStart : String; knot : TKnoten) : STRING;
    VAR n    : ARRAY [0..3] OF Integer;
        i    : Integer;
        GNN  : STRING;

    BEGIN
    GNN := NewNameStart + '(';
    IF knot <> NIL THEN BEGIN
      knot.Read4Int(n[0], n[1], n[2], n[3]);
      FOR i := 0 TO 3 DO
        IF n[i] > 0 THEN
          GNN := GNN + '%' + IntToStr(n[i]) + ';'
        ELSE IF n[i] < 0 THEN
          GNN := GNN + '@' + IntToStr(Abs(n[i])) + ';';
      IF GNN[LENGTH(GNN)] = ';' THEN
        DELETE (GNN, LENGTH(GNN), 1);
      END;
    GetNewName := GNN + ')';
    END;

  FUNCTION tbs (tb : TKnoten) : STRING;

    VAR i : Integer;
    BEGIN
    CASE tb.token OF
       0 : tbs := Float2Str(tb.value, 3);
       1 : tbs := 'x';
       2 : tbs := tbs (tb.left_ch) + ' + ' + tbs (tb.right_ch);
       3 : tbs := tbs (tb.left_ch) + ' - ' + tbs (tb.right_ch);
       4 : tbs := tbs (tb.left_ch) + ' * ' + tbs (tb.right_ch);
       5 : tbs := tbs (tb.left_ch) + ' / ' + tbs (tb.right_ch);
       6 : tbs := tbs (tb.left_ch) + ' ^ ' + tbs (tb.right_ch);
       7 : BEGIN
           i   := Round(tb.value);
           tbs := Char(brackets[i]) + ' ' + tbs (tb.right_ch) + ' ' + Char(brackets[Succ(i)]);
           END;
       8 : tbs := 'SIN ( ' + tbs (tb.right_ch) + ' )';
       9 : tbs := 'COS ( ' + tbs (tb.right_ch) + ' )';
      10 : tbs := 'TAN ( ' + tbs (tb.right_ch) + ' )';
      11 : tbs := 'SQRT ( ' + tbs (tb.right_ch) + ' )';
      12 : tbs := 'LN ( '  + tbs (tb.right_ch) + ' )';
      13 : tbs := 'EXP ( ' + tbs (tb.right_ch) + ' )';
      14 : tbs := 'LOG ( ' + tbs (tb.right_ch) + ' )';
      15 : tbs := 'ARCTAN ( ' + tbs (tb.right_ch) + ' )';
      16 : tbs := '- ' + tbs (tb.right_ch);
      17 : tbs := 'ABS ( ' + tbs (tb.right_ch) + ' )';
      18 : tbs := 'SQR ( ' + tbs (tb.right_ch) + ' )';
      19 : tbs := 'INT ( ' + tbs (tb.right_ch) + ' )';
      20 : tbs := 'FRAC ( ' + tbs (tb.right_ch) + ' )';
      21 : tbs := 'NORMAL ( ' + tbs(tb.right_ch) + ' )';

      { Die folgenden beiden Token sind nur für EUKLID eingebaut : }
      22 : tbs := GetNewName('d', tb.right_ch.right_ch);  { Abstand }
      23 : tbs := GetNewName('w', tb.right_ch.right_ch);  { Winkelweite }

      { Allgemeingültiges : }
      24 : tbs := 'ARCSIN ( ' + tbs(tb.right_ch) + ' )';
      25 : tbs := 'ARCCOS ( ' + tbs(tb.right_ch) + ' )';

      { Weitere EUKLID-spezifische Token : }
      26 : tbs := 'X(%' + IntToStr(ROUND(tb.right_ch.value)) + ')';
      27 : tbs := 'Y(%' + IntToStr(ROUND(tb.right_ch.value)) + ')';
      28 : tbs := 'LEN(%' + IntToStr(ROUND(tb.right_ch.value)) + ')';
      29 : tbs := 'RADIUS(%' + IntToStr(ROUND(tb.right_ch.value)) + ')';
      30 : tbs := 'AREA(%' + IntToStr(ROUND(tb.right_ch.value)) + ')';
      31 : tbs := 'VAL(%' + IntToStr(ROUND(tb.right_ch.value)) + ')';
      32 : tbs := GetNewName('TV', tb.right_ch);          { Teilverhältnis }

      { Allgemeingültiges : }
      33 : tbs := 'FLOOR(' + tbs (tb.right_ch) + ')';
      34 : tbs := 'CEIL(' + tbs (tb.right_ch) + ')';
      35 : tbs := 'SGN(' + tbs(tb.right_ch) + ')';
      36 : tbs := 'GRAD(' + tbs (tb.right_ch) + ')';
      37 : tbs := 'BOGEN(' + tbs(tb.right_ch) + ')';
      38 : tbs := 'RND(' + tbs(tb.right_ch) + ')';
      39 : tbs := 'IF(' + TBoolBaum(tb.left_ch).GeoNumStr + '; ' +
                          TTBaum(tb.right_ch.left_ch).GeoNumString + '; ' +
                          TTBaum(tb.right_ch.right_ch).GeoNumString + ')';
      40 : tbs := 'RANDOM(' + tbs(tb.right_ch) + ')';

      { Weitere EUKLID-spezifische Token : }
      41 : error_str := TBMsg[16];  { User-defined function object }
      42 : tbs := 'SLOPE(%' + IntToStr(Round(tb.right_ch.value)) + ')';
      50 : tbs := tbs(tb.left_ch) + '°';

    ELSE
      error_str := TBMsg[16];  {'Unbekannter Operator !'}
    END; { of case }
    END;

  BEGIN { of GeoNumString }
  If Length(fgeonum_str) > 0 then
    Result := fgeonum_str
  else
    IF (baum <> Nil) AND
       (status >= tbCalcError) THEN BEGIN
      fgeonum_str := tbs(baum);
      Result := fgeonum_str;
      END
    ELSE
      Result := '';
  END;  { of GeoNumString }


procedure TTBaum.ConvertSource2GeoNumString;
  begin
  If (baum <> NIL) and
     (Status >= tbCalcError) then begin
    fgeonum_str := '';
    fgeonum_str := GeoNumString;
    end;
  end;


PROCEDURE TTBaum.Reset;
  BEGIN
  IF baum <> NIL THEN begin
    baum.Free;
    baum := Nil;
    end;
  error_spot :=  0;
  error_str  := '';
  source_str := '';
  status     := tbEmpty;
  END;


destructor TTBaum.Destroy;
  BEGIN
  Reset;
  Drawing := Nil;
  fgeonum_str := '';
  Inherited Destroy;
  END;



{-----------------------------------------------}
{ TBoolBaum's Methods Implementation            }
{-----------------------------------------------}


constructor TBoolBaum.Create(iDrawing: TObject; iAngleMode: AngleModeTyp; s: WideString);
  begin
  Inherited Create;
  FAngleMode := iAngleMode;
  Drawing := iDrawing;
  KillLeadingBlanks(s);
  If Length(s) > 0 then begin
    FSourceStr := s;
    BuildTreeAndReturn(s);
    end;
  end;


destructor TBoolBaum.Destroy;
  begin
  FBaum.Free;
  FBaum := Nil;
  Inherited Destroy;
  end;


function TBoolBaum.Calculate(x : Double): Boolean;
  var s : WideString;

  function bbval(k : TKnoten): Boolean;
    var ls, rs  : Double;
        GO1, GO2,
        GO3, GO4: TGeoObj;
        n       : Integer;
    begin
    Case k.token of
      101 : Result := bbval(k.left_ch) = bbval(k.right_ch);
      106 : Result := bbval(k.left_ch) <> bbval(k.right_ch);
      107 : Result := bbval(k.left_ch) OR bbval(k.right_ch);
      108 : Result := bbval(k.left_ch) XOR bbval(k.right_ch);
      109 : Result := bbval(k.left_ch) AND bbval(k.right_ch);
      110 : Result := Not bbval(k.left_ch);
      111 : Result := True;
      112 : Result := False;
      113 : Result := bbval(k.left_ch);

      141 : if GetDynaGeoObjsFrom(k, TGeoObjListe(Drawing), GO1, GO2, GO3, GO4) then
              if GO1 is TGStraightLine then
                if GO2 is TGStraightLine then
                  Result := TGStraightLine(GO1).LiesParallel(TGStraightLine(GO2))
                else
                  Result := TGStraightLine(GO1).LiesParallel(TGPoint(GO2), TGPoint(GO3))
              else
                if GO3 is TGStraightLine then
                  Result := TGStraightLine(GO3).LiesParallel(TGPoint(GO1), TGPoint(GO2))
                else
                  Result := IsParallelPointPairs(TGPoint(GO1), TGPoint(GO2),
                                                 TGPoint(GO3), TGPoint(GO4))
            else begin
              Result := False;
              FOkay  := False;
              end;
      142 : if GetDynaGeoObjsFrom(k, TGeoObjListe(Drawing), GO1, GO2, GO3, GO4) then
              if GO1 is TGStraightLine then
                if GO2 is TGStraightLine then
                  Result := TGStraightLine(GO1).LiesOrthogonal(TGStraightLine(GO2))
                else
                  Result := TGStraightLine(GO1).LiesOrthogonal(TGPoint(GO2), TGPoint(GO3))
              else
                if GO3 is TGStraightLine then
                  Result := TGStraightLine(GO3).LiesOrthogonal(TGPoint(GO1), TGPoint(GO2))
                else
                  Result := IsOrthogonalPointPairs(TGPoint(GO1), TGPoint(GO2),
                                                   TGPoint(GO3), TGPoint(GO4))
            else begin
              Result := False;
              FOkay  := False;
              end;
      143 : if GetDynaGeoObjsFrom(k, TGeoObjListe(Drawing), GO1, GO2, GO3, GO4) and
               (GO1 is TGPoint) and (GO2 is TGLine) then
              Result := TGLine(GO2).Includes(TGPoint(GO1).X, TGPoint(GO1).Y)
            else begin
              Result := False;
              FOkay  := False;
              end;
      144 : if GetDynaGeoObjsFrom(k, TGeoObjListe(Drawing), GO1, GO2, GO3, GO4) and
               (GO1 <> Nil) then
              Result := GO1.DataValid
            else begin
              Result := False;
              FOkay  := False;
              end;
      200 : begin
            TTBaum(k.left_ch).Calculate(x, ls);
            TTBaum(k.right_ch).Calculate(x, rs);
            If TTBaum(k.left_ch).is_okay and
               TTBaum(k.right_ch).is_okay then begin
              n := Round(k.value);
              Case n of
                101 : Result := SameValue(ls, rs);
                102 : Result :=  ls < rs;
                103 : Result := (ls < rs) or SameValue(ls, rs);
                104 : Result :=  ls > rs;
                105 : Result := (ls > rs) or SameValue(ls, rs);
                106 : Result := Not SameValue(ls, rs);
              else
                Result := False;
                FOkay  := False;
              end; { of case }
              end
            else begin
              Result := False;
              FOkay  := False;
              end;
            end;
    else
      Result := False;
      FOkay  := False;
    end; { of case }
    end;

  begin
  If Not Assigned(FBaum) then begin
    s := FSourceStr;
    FBaum := BoolTerm(s);
    end;
  If Assigned(FBaum) then begin
    FOkay := True;
    Result := bbval(FBaum);
    end
  else
    Result := False;
  end;


procedure TBoolBaum.RebuildSourceStr;

  function ns(k : TKnoten): String;
    var ls, rs   : TTBaum;
        n        : Integer;
    begin
    Result := '';
    Case k.token of
      101 : Result := ns(k.left_ch) + ' = '  + ns(k.right_ch);
      106 : Result := ns(k.left_ch) + ' <> ' + ns(k.right_ch);
      107 : Result := ns(k.left_ch) + ' OR ' + ns(k.right_ch);
      108 : Result := ns(k.left_ch) + ' XOR ' + ns(k.right_ch);
      109 : Result := ns(k.left_ch) + ' AND ' + ns(k.right_ch);
      110 : Result := 'NOT ' + ns(k.left_ch);
      111 : Result := 'True';
      112 : Result := 'False';
      113 : Result := brackets[Round(k.value)] + ns(k.left_ch) + brackets[Round(k.value)+1];

      141 : Result := 'parall (' + GetBFParamListFrom(TGeoObjListe(Drawing), k) + ')';
      142 : Result := 'ortho (' + GetBFParamListFrom(TGeoObjListe(Drawing), k) + ')';
      143 : Result := 'incid (' + GetBFParamListFrom(TGeoObjListe(Drawing), k) + ')';
      144 : Result := 'valid (' + GetBFParamListFrom(TGeoObjListe(Drawing), k) + ')';
      200 : begin
            ls := TTBaum(k.left_ch);
            ls.BuildString;
            rs := TTBaum(k.right_ch);
            rs.BuildString;
            If (ls.status > tbCompError) and
               (rs.status > tbCompError) then begin
              n := Round(k.value);
              Case n of
                101 : Result := ls.source_str + ' = '  + rs.source_str;
                102 : Result := ls.source_str + ' < '  + rs.source_str;
                103 : Result := ls.source_str + ' <= ' + rs.source_str;
                104 : Result := ls.source_str + ' > '  + rs.source_str;
                105 : Result := ls.source_str + ' >= ' + rs.source_str;
                106 : Result := ls.source_str + ' <> ' + rs.source_str;
              else  { of inner case }
                FOkay  := False;
              end; { of case }
              end
            else { of if }
              FOkay  := False;
            end;
    else { of outer case }
      FOkay  := False;
    end; { of case }
    end;

  begin
  FSourceStr := ns(FBaum);
  end;


function TBoolBaum.GetHTMLString: String;

  function ns(k : TKnoten): String;
    var ls, rs   : TTBaum;
        n        : Integer;
    begin
    Result := '';
    Case k.token of
      101 : Result := ns(k.left_ch) + ' = '  + ns(k.right_ch);
      106 : Result := ns(k.left_ch) + ' &lt;&gt; ' + ns(k.right_ch);
      107 : Result := ns(k.left_ch) + ' OR ' + ns(k.right_ch);
      108 : Result := ns(k.left_ch) + ' XOR ' + ns(k.right_ch);
      109 : Result := ns(k.left_ch) + ' AND ' + ns(k.right_ch);
      110 : Result := 'NOT ' + ns(k.left_ch);
      111 : Result := 'True';
      112 : Result := 'False';
      113 : Result := brackets[Round(k.value)] + ns(k.left_ch) + brackets[Round(k.value)+1];

      141 : Result := 'parall (' + GetBFGeoNumParamList(TGeoObjListe(Drawing), k) + ')';
      142 : Result := 'ortho (' + GetBFGeoNumParamList(TGeoObjListe(Drawing), k) + ')';
      143 : Result := 'incid (' + GetBFGeoNumParamList(TGeoObjListe(Drawing), k) + ')';
      144 : Result := 'valid (' + GetBFGeoNumParamList(TGeoObjListe(Drawing), k) + ')';
      200 : begin
            ls := TTBaum(k.left_ch);
            rs := TTBaum(k.right_ch);
            If (ls.status > tbCompError) and
               (rs.status > tbCompError) then begin
              n := Round(k.value);
              Case n of
                101 : Result := ls.GetHTMLString + ' = '  + rs.GetHTMLString;
                102 : Result := ls.GetHTMLString + ' &lt; '  + rs.GetHTMLString;
                103 : Result := ls.GetHTMLString + ' &lt;= ' + rs.GetHTMLString;
                104 : Result := ls.GetHTMLString + ' &gt; '  + rs.GetHTMLString;
                105 : Result := ls.GetHTMLString + ' &gt;= ' + rs.GetHTMLString;
                106 : Result := ls.GetHTMLString + ' &lt;&gt; ' + rs.GetHTMLString;
              else  { of inner case }
                FOkay  := False;
              end; { of case }
              end
            else { of if }
              FOkay  := False;
            end;
    else { of outer case }
      FOkay  := False;
    end; { of case }
    end;

  begin
  Result := ns(FBaum);
  end;


function TBoolBaum.GeoNumStr : String;

  function ns(k : TKnoten): String;
    var ls, rs   : TTBaum;
        n        : Integer;
    begin
    Result := '';
    Case k.token of
      101 : Result := ns(k.left_ch) + ' = '  + ns(k.right_ch);
      106 : Result := ns(k.left_ch) + ' <> ' + ns(k.right_ch);
      107 : Result := ns(k.left_ch) + ' OR ' + ns(k.right_ch);
      108 : Result := ns(k.left_ch) + ' XOR ' + ns(k.right_ch);
      109 : Result := ns(k.left_ch) + ' AND ' + ns(k.right_ch);
      110 : Result := 'NOT ' + ns(k.left_ch);
      111 : Result := 'True';
      112 : Result := 'False';
      113 : Result := brackets[Round(k.value)] + ns(k.left_ch) + brackets[Round(k.value)+1];

      141 : Result := 'parall (' + GetBFGeoNumParamList(TGeoObjListe(Drawing), k) + ')';
      142 : Result := 'ortho (' + GetBFGeoNumParamList(TGeoObjListe(Drawing), k) + ')';
      143 : Result := 'incid (' + GetBFGeoNumParamList(TGeoObjListe(Drawing), k) + ')';
      144 : Result := 'valid (' + GetBFGeoNumParamList(TGeoObjListe(Drawing), k) + ')';
      200 : begin
            ls := TTBaum(k.left_ch);
            rs := TTBaum(k.right_ch);
            If (ls.status > tbCompError) and
               (rs.status > tbCompError) then begin
              n := Round(k.value);
              Case n of
                101 : Result := ls.GeoNumString + ' = '  + rs.GeoNumString;
                102 : Result := ls.GeoNumString + ' < '  + rs.GeoNumString;
                103 : Result := ls.GeoNumString + ' <= ' + rs.GeoNumString;
                104 : Result := ls.GeoNumString + ' > '  + rs.GeoNumString;
                105 : Result := ls.GeoNumString + ' >= ' + rs.GeoNumString;
                106 : Result := ls.GeoNumString + ' <> ' + rs.GeoNumString;
              else  { of inner case }
                FOkay  := False;
              end; { of case }
              end
            else { of if }
              FOkay  := False;
            end;
    else { of outer case }
      FOkay  := False;
    end; { of case }
    end;

  begin
  Result := ns(FBaum);
  end;


function TBoolBaum.CompRTerm(var s: WideString): TKnoten;
  var ls, rs   : TTBaum;
      ws1, ws2, ws3 : WideString;

  function GetWorkStrings : Boolean;
    var i : Integer;
    begin
    Result := False;
    ws1 := s;         // Kompletten Vergleichs-Quellcode kopieren
    i := 1;
    While (i <= Length(ws1)) and (Not CharInSet(ws1[i], ['=', '<', '>'])) do
      i := i + 1;
    If i <= Length(ws1) then begin
      ws2 := Copy(ws1, i, Length(ws1));
      Delete(ws1, i, Length(ws1));
      i := 1;
      While (i <= Length(ws2)) and CharInSet(ws2[i], ['=', '<', '>']) do
        i := i + 1;
      If i <= Length(ws2) then begin
        ws3 := Copy(ws2, i, Length(ws2));
        Delete(ws2, i, Length(ws2));
        Result := (Length(ws1) > 0) and
                  (Length(ws2) > 0) and
                  (Length(ws3) > 0);
        end;
      end;
    end;

  function GetToken(s: String): Integer;
    begin
    Result := 100;
    If Pos('=', s) > 0 then Result := Result + 1;
    If Pos('<', s) > 0 then Result := Result + 2;
    If Pos('>', s) > 0 then Result := Result + 4;
    end;

  begin
  If GetWorkStrings then begin
    ls := TTBaum.Create(Drawing, FAngleMode);
    ls.BuildTree(ws1);
    If ls.is_okay then begin
      rs := TTBaum.Create(Drawing, FAngleMode);
      rs.BuildTreeAndReturn(ws3);
      If rs.is_okay then begin
        Result := TKnoten.Create(200, GetToken(ws2),
                                 TKnoten(ls), TKnoten(rs));
        s := ws3;
        end
      else begin
        ls.Free;
        rs.Free;
        FErrMsg := tbmsg03;
        Result  := Nil;
        end;
      end
    else begin
      ls.Free;
      FErrMsg := tbmsg03;
      Result  := Nil;
      end;
    end
  else begin
    FErrMsg := tbmsg03;
    Result  := Nil;
    end;
  end;


function TBoolBaum.BoolConst(var s: WideString): TKnoten;
  var ws : String;
  begin
  ws := UpperCase(s);
  If POS('TRUE', ws) = 1 then begin
    CutFirst_wB(s, 4);
    Result := TKnoten.Create(111, 0, Nil, Nil);
    end
  else
  If POS('FALSE', ws) = 1 then begin
    CutFirst_wB(s, 5);
    Result := TKnoten.Create(112, 0, Nil, Nil);
    end
  else
    Result := Nil;
  end;

function TBoolBaum.GetBoolFuncIndex(s: WideString): Integer;
  var ws, bs : WideString;
      n, k   : Integer;
  begin
  Result := 0;
  ws := AnsiUpperCase(s);
  While (Length(ws) > 0) and (ws[1] = ' ') do Delete(ws, 1, 1);
  For n := 1 to anz_bf do begin
    bs := bf_name[n];
    If Pos(bs, ws) = 1 then begin
      CutFirst_wB(ws, Length(bs));
      If (Length(ws) > 0) then begin
        k := Pos(ws[1], brackets);
        If (k > 0) and Odd(k) then
          Result := n;
        end;
      Exit;
      end;
    end;
  end;

function TBoolBaum.GetGeoNumFrom(var s: WideString): Integer;
  var gn : WideString;
      GO : TGeoObj;
  begin
  Result := 0;
  GO := Nil;
  gn := '';
  While (Length(s) > 0) and IsNameChar(s[1]) do begin
    gn := gn + s[1];
    Delete(s, 1, 1);
    end;
  If Length(gn) > 0 then
    GO := TGeoObjListe(Drawing).GetGeoObjByName(gn);
  If GO <> Nil then begin
    Result := GO.GeoNum;
    end
  else begin
    If (Length(s) > 0) and (s[1] = '@') then begin
      Delete(s, 1, 1);
      gn := '';
      While (Length(s) > 0) and IsDigit(s[1]) do begin
        gn := gn + s[1];
        Delete(s, 1, 1);
        end;
      If Length(gn) > 0 then
        Result := - StrToInt(gn);
      end;
    end;
  If Result <> 0 then
    While (Length(s) > 0) and CharInSet(s[1], [',', ';', ' ']) do
      Delete(s, 1, 1);
  end;


function TBoolBaum.BFArgsValid(fn: Integer; nr: Array of Integer): Boolean;

  function eq(w, v: String): Boolean;
    var i : Integer;
    begin
    Result := Length(v) = Length(w);
    If Result then
      For i := 1 to Length(w) do
        If (v[i] <> '_') and (w[i] <> '_') and (v[i] <> w[i]) then
          Result := False;
    end;

  var GO : TGeoObj;
      s  : String;
      i  : Integer;
  begin
  s := '';
  For i := 0 to High(nr) do begin
    If nr[i] > 0 then begin
      GO := TGeoObjListe(Drawing).GetObj(nr[i]);
      If GO <> Nil then begin
        If      GO is TGPoint        then s := s + 'P'       // Punkt
        else if GO is TGStraightLine then s := s + 'g'       // Gerade
        else if GO is TGCircle       then s := s + 'k'       // Kreis
        else if GO is TGCurve        then s := s + 'c'       // Curve
        else                              s := s + 'u';      // Unbekannt
        end;
      end
    else
      If nr[i] < 0 then s := s + '_';
    end;
  Case fn of
    141,
    142 : Result := eq(s, 'gg') or eq(s, 'PPg') or eq(s, 'gPP') or eq(s, 'PPPP');
    143 : Result := eq(s, 'Pg') or eq(s, 'Pk')  or eq(s, 'Pc');
    144 : Result := Length(s) = 1;
  else
    Result := False;
  end; { of case }
  end;


function TBoolBaum.BoolFunc(var s: WideString): TKnoten;
  var gn       : Array[0..3] of Integer;  //  "g"eo "n"um - Array
      os       : WideString;   //  "o"riginal "s"tring
      kn       : TKnoten;
      obi,                 //  opening bracket index
      bfi,                 //  "b"oolean "f"unction "i"ndex
      n, i     : Integer;
  begin
  Result := Nil;
  os  := s;           // Original merken
  bfi := GetBoolFuncIndex(s);
  If bfi > 0 then begin     //  Bool'sche DynaGeo-Funktion erkannt
    CutFirst_wB(s, Length(bf_name[bfi]));
    obi := Pos(s[1], brackets);
    CutFirst_wB(s, 1);
    For i := 0 to 3 do           // Array der GeoNummern initialisieren
      gn[i] := 0;
    i := 0;
    n := GetGeoNumFrom(s);
    If n <> 0 then begin
      Repeat
        gn[i] := n;
        Inc(i);
        n := GetGeoNumFrom(s);
      until (n = 0) or (i > 3);
      If (s[1] = brackets[obi + 1]) and BFArgsValid(bfBase + bfi, gn) then begin
        CutFirst_wB(s, 1);       // Schließende Klammer entfernen
        Result := TKnoten.Init4Int(bfBase + bfi, gn[0], gn[1], gn[2], gn[3], Nil, Nil);
        end
      else
        FErrMsg := Format(bbmsg03, [brackets[obi + 1]]);  // ")" erwartet !
      end
    else
      FErrMsg := tbmsg18;      // Kein passendes Objekt gefunden !
    end
  else begin                // Klammerterm erkannt
    obi := Pos(s[1], brackets);                      // Öffnende Klammer
    If (obi > 0) and Odd(obi) then begin
      CutFirst_wB(s, 1);
      kn := BoolExpr(s);
      If kn <> Nil then
        If Pos(s[1], brackets) = obi + 1 then begin  // Schließende Klammer
          CutFirst_wB(s, 1);
          Result := TKnoten.Create(113, obi, kn, Nil);
          end
        else begin
          kn.Free;
          FErrMsg := Format(bbmsg03, [brackets[obi + 1]]);  // ")" erwartet !
          end
      else begin
        s := os;        // Original wiederherstellen !
        FErrMsg := bbmsg02;
        end
      end
    else begin
      kn := CompRTerm(s);
      If kn <> Nil then
        Result := kn
      else begin
        s := os;
        FErrMsg := tbmsg03;
        end;
      end;
    end;
  end;


function TBoolBaum.AndTerm(var s: WideString): TKnoten;
  var kn1   : TKnoten;
      f_not : Boolean;
  begin
  If (Length(s) >= 3) and
     (AnsiUpperCase(s[1]) = 'N') and
     (AnsiUpperCase(s[2]) = 'O') and
     (AnsiUpperCase(s[3]) = 'T') then begin
    f_not := True;
    CutFirst_wB(s, 3);
    end
  else
    f_not := False;

  kn1 := BoolConst(s);
  If kn1 = Nil then
    kn1 := BoolFunc(s);

  If kn1 <> Nil then
    If f_not then
      Result := TKnoten.Create(110, 0, kn1, Nil)
    else
      Result := kn1
  else begin
    Result := Nil;
    FErrMsg := bbmsg02;
    end;
  end;


function TBoolBaum.OrTerm(var s: WideString): TKnoten;
  var kn1, kn2 : TKnoten;
  begin
  kn1 := AndTerm(s);
  If kn1 <> Nil then
    If (Length(s) >= 3) and
       (AnsiUpperCase(s[1]) = 'A') and
       (AnsiUpperCase(s[2]) = 'N') and
       (AnsiUpperCase(s[3]) = 'D') then begin
      CutFirst_wB(s, 3);
      kn2 := OrTerm(s); // Rekursiver Aufruf für mehrteilige Terme
      If kn2 <> Nil then
        Result := TKnoten.Create(109, 0, kn1, kn2)
      else begin
        kn1.Free;
        Result := Nil
        end;
      end
    else
      Result := kn1
  else
    Result := Nil;
  end;


function TBoolBaum.BoolTerm(var s: WideString): TKnoten;
  var kn1, kn2 : TKnoten;
  begin
  kn1 := OrTerm(s);
  If kn1 <> Nil then
    If Length(s) >= 1 then
      Case UpCase(Char(s[1])) of
        'O' : If (Length(s) >= 2) and
                 (AnsiUpperCase(s[2]) = 'R') then begin
                CutFirst_wB(s, 2);
                kn2 := BoolTerm(s);  // Rekursiver Aufruf für mehrteilige Terme
                If kn2 <> Nil then
                  Result := TKnoten.Create(107, 0, kn1, kn2)
                else begin
                  kn1.Free;
                  Result := Nil;
                  end;
                end
              else begin
                kn1.Free;
                Result := Nil;
                end;
        'X' : If (Length(s) >= 3) and
                 (AnsiUpperCase(s[2]) = 'O') and
                 (AnsiUpperCase(s[3]) = 'R') then begin
                CutFirst_wB(s, 3);
                kn2 := BoolTerm(s);  // Rekursiver Aufruf für mehrteilige Terme
                If kn2 <> Nil then
                  Result := TKnoten.Create(108, 0, kn1, kn2)
                else begin
                  kn1.Free;
                  Result := Nil;
                  end;
                end
              else begin
                kn1.Free;
                Result := Nil;
                end;
      else { of case }
        Result := kn1;
      end { of case }
    else
      Result := kn1
  else
    Result := Nil;
  end;


function TBoolBaum.BoolExpr(var s: WideString): TKnoten;
  var kn1, kn2 : TKnoten;
  begin
  kn1 := BoolTerm(s);
  If kn1 <> Nil then
    If Length(s) > 0 then
      Case s[1] of
        '=' : begin
              CutFirst_wB(s, 1);
              kn2 := BoolTerm(s);
              If kn2 <> Nil then
                Result := TKnoten.Create(101, 0, kn1, kn2)
              else begin
                kn1.Free;
                Result := Nil;
                end;
              end;
        '<' : If s[2] = '>' then begin
                CutFirst_wB(s, 2);
                kn2 := BoolTerm(s);
                If kn2 <> Nil then
                  Result := TKnoten.Create(106, 0, kn1, kn2)
                else begin
                  kn1.Free;
                  Result := Nil;
                  end;
                end
              else begin
                FErrMsg := bbmsg01;
                kn1.Free;
                Result := Nil;
                end;
      else { of case }
        Result := kn1;
      end { of case }
    else
      Result := kn1
  else
    Result := Nil;
  end;


function TBoolBaum.BuildTreeAndReturn(var s: WideString): Boolean;
  var n : Integer;
  begin
  If Assigned(FBaum) then begin
    FBaum.Free;
    FBaum := Nil;
    end;
  If Length(s) > 0 then begin
    KillLeadingBlanks(s);
    FSourceStr := s;
    end;
  FOkay := True;
  FBaum := BoolExpr(s);
  If FBaum <> Nil then begin
    n := Length(s);
    If n > 0 then
      Delete(FSourceStr, Succ(Length(FSourceStr) - n), n);
    FOkay := True;
    end
  else begin
    FOkay := False;
    FErrSpot := Length(FSourceStr) - Length(s);
    end;
  Result := FOkay;
  end;

procedure TBoolBaum.RegisterTermParentsIn(GO: TObject);
  var GO1, GO2, GO3, GO4 : TGeoObj;
  procedure RTP(k: TKnoten);
    begin
    If k <> Nil then
      Case k.token of
      141,
      142,
      143,
      144 : if GetDynaGeoObjsFrom(k, TGeoObjListe(Drawing),
                                  GO1, GO2, GO3, GO4) then begin
              (GO as TGeoObj).BecomesChildOf(GO1);
              (GO as TGeoObj).BecomesChildOf(GO2);
              (GO as TGeoObj).BecomesChildOf(GO3);
              (GO as TGeoObj).BecomesChildOf(GO4);
              end;
      200 : begin
            TTBaum(k.left_ch).RegisterTermParentsIn(GO);
            TTBaum(k.right_ch).RegisterTermParentsIn(GO);
            end
      else
        RTP(k.left_ch);
        RTP(k.right_ch);
      end; { of case }
    end;
  begin
  RTP(FBaum);
  end;

procedure TBoolBaum.UnregisterTermParentsIn(GO: TObject);
  var GO1, GO2, GO3, GO4 : TGeoObj;
  procedure UTP(k: TKnoten);
    begin
    If k <> Nil then
      Case k.token of
      141,
      142,
      143,
      144 : if GetDynaGeoObjsFrom(k, TGeoObjListe(Drawing),
                                  GO1, GO2, GO3, GO4) then begin
              (GO as TGeoObj).Stops2BeChildOf(GO1);
              (GO as TGeoObj).Stops2BeChildOf(GO2);
              (GO as TGeoObj).Stops2BeChildOf(GO3);
              (GO as TGeoObj).Stops2BeChildOf(GO4);
              end;
      200 : begin
            TTBaum(k.left_ch).UnregisterTermParentsIn(GO);
            TTBaum(k.right_ch).UnregisterTermParentsIn(GO);
            end
      else
        UTP(k.left_ch);
        UTP(k.right_ch);
      end; { of case }
    end;
  begin
  UTP(FBaum);
  end;

procedure TBoolBaum.transformTrig(k: TKnoten);
  var tb1, tb2 : TTBaum;
  begin
  if k <> Nil then
    if k.token = 200 then begin
      tb1 := TTBaum(k.left_ch);
      tb2 := TTBaum(k.right_ch);
      tb1.transformTrig(tb1.baum);
      tb2.transformTrig(tb2.baum);
      end
    else begin
      transformTrig(k.left_ch);
      transformTrig(k.right_ch);
      end;
  end;

procedure TBoolBaum.transformAngleRefs(k: TKnoten);
  var tb1, tb2 : TTBaum;
  begin
  if k <> Nil then
    if k.token = 200 then begin
      tb1 := TTBaum(k.left_ch);
      tb2 := TTBaum(k.right_ch);
      tb1.transformTrig(tb1.baum);
      tb2.transformTrig(tb2.baum);
      end
    else begin
      transformAngleRefs(k.left_ch);
      transformAngleRefs(k.right_ch);
      end;
  end;

function TBoolBaum.ContainsADescendentOf(GO: TObject; var si: Integer): Boolean;
  procedure Check(k: TKnoten);
    begin
    If (Not Result) and (k <> Nil) then
      If k.token = 200 then
        Result := TTBaum(k.left_ch).ContainsADescendentOf(GO, si) or
                  TTBaum(k.right_ch).ContainsADescendentOf(GO, si)
      else begin
        Check(k.left_ch);
        Check(k.right_ch);
        end;
    end;
  begin
  Result := False;
  Check(FBaum);
  end;



{----- Registrierung der Typen --------------------}

BEGIN
RegisterClass(TKnoten);
RegisterClass(TTBaum);
RegisterClass(TBoolBaum);
END.

