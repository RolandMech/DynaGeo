unit FormatText;

interface
uses Graphics, Classes, Windows, SysUtils, Dialogs;


type

TFontChange = (fcBold, fcItalic, fcUnderline, fcPosition,
               fcSize, fcName, fcTag, fcColor);
TFontChanges = Set of TFontChange;

TSelection = record Start, Ende : TPoint; end;
TFontPosition = (fpNormal, fpSup, fpSub);

TRowInfo = class(TObject)
  public
    first,last           : integer;
    height,width, bottom : integer;
    constructor Create;
end;

TFormatFontStack = class;

TFormatFont = class(TObject)
  public
    Position    : TFontPosition;
    Style       : TFontStyles;
    Size        : Integer;
    Name        : TFontName;
    Color       : TColor;
    Tag,                         // zur Speicherung eines Integer-Wertes
    Translation : Integer;       // nur für die Anzeige
  private
    procedure   SetFont    (Canvas : TCanvas; DisplayFactor : extended; Inverse : boolean = false);
    procedure   SetStellung(Canvas : TCanvas);
    function    ExtractAttrValue(attName, orgStr : String) : String;
  public
    constructor Create;                    overload;
    constructor Create ( f : TFormatFont); overload;
    constructor Create ( f : TFont);       overload;
    procedure   Assign ( f : TFormatFont); overload;
    procedure   Assign ( f : TFont);       overload;
    function    AdjustFontData (ss : String;
                                fs : TFormatFontStack;
                                SizingAllowed : Boolean = False) : Boolean;
end;

TFormatFontStack = class(TObject)
  private
    List : TList;
  public
    constructor Create;
    procedure Free;
    function IsEmpty : Boolean;
    procedure push (f : TFormatFont);
    procedure pop (f : TFormatFont);
  end;

TCharacter = class(TObject)
  private
    FCanvas        : TCanvas;
    FUnicode       : string;
    FDisplayFactor : extended;
    FFont          : TFormatFont;
    FSize          : TSize;
    FBottom        : Integer;
    FABCSize       : TABC;

    function GetWidth: integer;
    function GetHeight: integer;
    function GetChar: char;

    procedure Paint(Pos : TPoint; r: TRect; Inverse : Boolean = false);
    procedure PaintTransparent(Pos : TPoint; r :TRect; col : TColor);
    procedure PaintOverhang(Pos : TPoint; r: TRect; Inverse : Boolean = false);
    procedure PaintOverhangTransparent(Pos : TPoint; r :TRect; col : TColor);

    procedure ChangeFont(NewFont : TFormatFont; Change : TFontChanges);
    procedure SetDisplayFactor(f : extended);
    procedure SetCanvas  (c : TCanvas);
    procedure AdjustSize;

    property  DisplayFactor : extended read FDisplayFactor write SetDisplayFactor;
    property  Canvas        : TCanvas  read FCanvas write SetCanvas;

  public
    constructor Create(c : char; f: TFormatFont; Canvas: TCanvas); overload;
    constructor Create(c : char; f: TFormatFont); overload;
    destructor  Destroy; override;

    property  Size          : TSize    read  FSize;
    property  Width         : integer  read  GetWidth;
    property  Height        : integer  read  GetHeight;
    property  Bottom        : integer  read  FBottom;
    property  Font          : TFormatFont  read  FFont;
    property  Character     : char     read  GetChar;
    property  ABC           : TABC     read  FABCSize;
  end;

TLine = class(TObject)
  private
    FMaxWidth    : Integer;
    FCanvas      : TCanvas;
    FCharacters  : TList;
    FRowInfos    : TList;

    function GetSize  : TSize;
    function GetWidth : Integer;
    function GetHeight: Integer;
    function GetText  : String;

    function ExtraBefore(nr : Integer; First : Integer): integer;
    function ExtraAfter (nr : Integer; Last  : Integer): integer;

    procedure SetCanvas  (c : TCanvas);
    procedure SetMaxWidth(w : integer);
    procedure SetHTMLText(s: string; FontList: TList; linkList: TStringList);
    procedure GetHTMLText(HTMLText : TStrings; FontList: TList; TagList, LinkList: TStrings);

    procedure Insert (i: integer; b: TCharacter);
    procedure ChangeFont(Selection: TSelection; NewFont: TFormatFont; Change: TFontChanges);

    procedure SetDisplayFactor(f : extended);
    procedure Paint(Pos : TPoint; ClipRect : TRect); overload;
    procedure Paint(Pos : TPoint; ClipRect : TRect; Selection : TSelection); overload;
    procedure PaintTransparent(Pos : TPoint; ClipRect : TRect; col : TColor);

  public
    constructor Create(s: string; FontList: TList; linkList: TStringList); overload;
    constructor Create(s: string; FontList: TList; linkList: TStringList;
                       MaxWidth: integer; Canvas: TCanvas ); overload;
    destructor  Destroy; override;
    procedure AdjustRowInfos;

    function  Characters                    : Integer;
    function  GetCharacter   (nr : integer) : TCharacter;
    function  GetCharBottom  (nr : integer) : Integer;
    function  GetCharPosition(nr : integer) : TRect;
    function  GetCharFont    (nr : integer) : TFormatFont;
    function  GetCharInPos   (Pos : TPoint) : Integer;

    property  Size  : TSize      read GetSize;
    property  Width : integer    read GetWidth;
    property  Height: integer    read GetHeight;
    property  Text  : string     read GetText;
  end;

TFormatText = class (TObject)
  private
    FClientRect : TRect;
    FCanvas     : TCanvas;
    FLinkList,
    FPlainText,
    FHTMLText   : TStringList;
    Zeilen      : TList;
    procedure SetCanvas(c : TCanvas);
  public
    constructor Create(Lines: TStrings; f : TFont); overload;
    constructor Create(Lines: TStrings; cl_rect: TRect; Canvas: TCanvas ); overload;
    destructor  Destroy; override;

    procedure SetClientRect(cl_rect: TRect);
    procedure SetClientTop(i : integer);
    procedure SetClientRight(i : integer);
    procedure SetClientLeft(i : integer);

    function GetSize : TSize;
    function GetWidth: integer;
    function GetHeight: integer;
    function GetCharacter(Pos : TPoint) : TCharacter;
    function GetCharPosition(Pos : TPoint) : TRect;
    function GetCharInPos(Pos : TPoint) : TPoint;
    function GetCharFont(Pos : TPoint) : TFormatFont;
    function GetLine(i : integer) : TLine;
    function GetText : TStrings;
    function GetHTMLText(DefaultFont : TFont) : TStrings;
    function GetLinkAddress(linkTag : integer) : String;
    function NewDisplayFactor: Double;
    function Lines : integer;
    function CharactersInLine(i : integer) : integer;
    function IsEmpty: Boolean;
    procedure SetHTMLText (Lines : TStrings); overLoad;
    procedure SetHTMLText (Lines : TStrings; DefaultFont : TFont); overload;
    procedure SetDisplayFactor (f : extended);
    procedure ChangeFont(Selection: TSelection; NewFont : TFormatFont; Change : TFontChanges);

    procedure Insert(Pos : TPoint; b : TCharacter); overload;
    procedure Insert(Pos : TPoint; c : char; f : TFormatFont); overload;
    function  InsertPlainText(IPos : TPoint; ustr : String) : TPoint;
    function  InsertHTMLText(IPos : TPoint; fstr : String) : TPoint;
    procedure Delete(Pos : TPoint);
    procedure Merge(i: integer);
    procedure Separate(Pos : TPoint);

    procedure Paint(FitToClientRect : Boolean = FALSE); overload;
    procedure Paint(ClipRect : TRect; FitToClientRect : Boolean = FALSE); overload;
    procedure Paint(Selection : TSelection; ClipRect: TRect; FitToClientRect : Boolean = FALSE); overload;
    procedure PaintTransparent(ClipRect : TRect; col : TColor; FitToClientRect : Boolean = FALSE);

    property LinkList: TStringList read FLinkList;
    property Canvas: TCanvas read FCanvas write SetCanvas;
  end;


function  ResizeHTMLText (    org      : String;
                              NewHeight: Integer): String;
procedure DeleteChars    (    delchars : string;
                          var s        : String);


implementation

// Minimale Höhe einer Zeile, d.h. für Leerzeilen
const MIN_HEIGHT : Integer = 12;

// Ein Rechteck mit einem ClippingRect beschneiden
function Clip(r: TRect; ClipRect: TRect): TRect;
var show : boolean;
begin
  show := True;
  if r.left   <  Cliprect.left   then r.left := ClipRect.left;
  if r.left   >= Cliprect.right  then show := False;
  if r.right  <= Cliprect.left   then show := False;
  if r.right  >= Cliprect.right  then r.right := ClipRect.right;
  if r.top    <  Cliprect.top    then r.top := ClipRect.top;
  if r.top    >= Cliprect.bottom then show := False;
  if r.bottom <= Cliprect.top    then show := False;
  if r.bottom >  Cliprect.bottom then r.bottom := ClipRect.bottom;
  if show then result := r else result := Rect(0,0,0,0);
end;

// Unerwünschte Zeichen aus einem String löschen
procedure DeleteChars(delchars : string; var s : String);
  var i, n : Integer;
  begin
  For i := 1 to Length(delchars) do begin
    n := POS(delchars[i], s);
    While n > 0 do begin
      Delete(s, n, 1);
      n := POS(delchars[i], s);
      end;
    end;
  end;

// Quelltext einer HTML-Zeile auf neue Zeilenhöhe ändern
function ResizeHTMLText(org: String; NewHeight: Integer): String;
  var FT: TFormatText;
      Lines: TStringList;
      DefFont: TFont;
      NewFont: TFormatFont;
      Sel : TSelection;
  begin
  DefFont := TFont.Create;
  try
    DefFont.Name := 'Arial';
    DefFont.Size := 12;
    Lines := TStringList.Create;
    try
      Lines.Add(org);
      FT := TFormatText.Create(Lines, DefFont);
      try
        Sel.Start := Point(0, 0);
        Sel.Ende  := Point(FT.CharactersInLine(Pred(FT.Lines)), Pred(FT.Lines));
        NewFont := TFormatFont.Create(DefFont);
        try
          NewFont.Size := NewHeight;
          FT.ChangeFont(Sel, NewFont, [fcSize]);
          Lines.Assign(FT.GetHTMLText(DefFont));
          Result := Lines.Strings[0];
        finally
          NewFont.Free;
        end;
      finally
        FT.Free;
      end;
    finally
      Lines.Free;
    end;
  finally
    DefFont.Free;
  end; { of try }
  end;

function HTMLSpecialChar(code: String): Char;
  begin
  If code = 'auml'  then Result := 'ä' else
  If code = 'ouml'  then Result := 'ö' else
  If code = 'uuml'  then Result := 'ü' else
  If code = 'Auml'  then Result := 'Ä' else
  If code = 'Ouml'  then Result := 'Ö' else
  If code = 'Uuml'  then Result := 'Ü' else
  If code = 'szlig' then Result := 'ß' else
  If code = 'amp'   then Result := '&' else
  Result := ' ';     // Default-Buchstabe !
  end;


// --------------------------------------------------- //
// TFormatFont                                         //
// --------------------------------------------------- //
// Erweiterung von TFont                               //
// Ermöglicht es, Hoch- und Tiefstellung sowie         //
//                  einen Integer-Index zu speichern   //
// --------------------------------------------------- //

constructor TFormatFont.Create();
begin
  Position := fpNormal;
  Style    := [];
  Size     := 12;
  Name     := 'Arial';
  Color    := clBlack;
end;

constructor TFormatFont.Create(f : TFormatFont);
begin
  If Assigned(f) then begin
    Position := f.Position;
    Style    := f.Style;
    Size     := f.Size;
    Name     := f.Name;
    Color    := ColorToRGB(f.Color);
    Tag      := f.Tag;
    end
  else
    Create;
end;

constructor TFormatFont.Create(f : TFont);
begin
  If Assigned(f) then begin
    Name     := f.Name;
    Size     := f.Size;
    Style    := f.Style;
    Position := fpNormal;
    Color    := ColorToRGB(f.Color);
    Tag      := 0;
    end
  else
    Create;
end;

procedure TFormatFont.Assign(f: TFormatFont);
  begin
  If Assigned(f) then begin
    Name     := f.Name;
    Size     := f.Size;
    Style    := f.Style;
    Position := f.Position;
    Color    := f.Color;
    Tag      := f.Tag;
    end
  else begin
    Name     := 'Arial';
    Size     := 12;
    Style    := [];
    Position := fpNormal;
    Color    := clBlack;
    Tag      := 0;
    end;
  end;

procedure TFormatFont.Assign(f: TFont);
  begin
  If Assigned(f) then begin
    Name     := f.Name;
    Size     := f.Size;
    Style    := f.Style;
    Color    := f.Color;
    end
  else begin
    Name     := 'Arial';
    Size     := 12;
    Style    := [];
    Color    := clBlack;
    end;
  Position := fpNormal;
  Tag      := 0;
  end;

// Font in Canvas einstellen (ohne Hoch/Tiefstellung)
procedure TFormatFont.SetFont(Canvas : TCanvas; DisplayFactor: extended; inverse : boolean);
begin
  If not Assigned(Canvas.Font) then
    Canvas.Font := TFont.Create;

  Canvas.Font.Name := Name;

  // Unterstreichen wird vom Programm selbst übernommen
  // damit eine einheitliche Linie zustande kommt.
  Canvas.Font.Style := Style - [fsUnderline];

  // Selektierte Buchstaben invers darstellen
  if Inverse then
    Canvas.Font.Color := ColorToRGB(Color xor clWhite)
  else
    Canvas.Font.Color := Color;

  // Bei Fontgröße den Vergrößerungsfaktor beachten
  Canvas.Font.Size := round(Size*DisplayFactor);

  // Minimale Fontgröße festlegen, damit überhaupt eine
  // Anzeige stattfindet
  if Canvas.Font.Size < 2 then Canvas.Font.Size := 2;
end;

// Berechnet Verschiebung aufgrund Hoch/Tiefstellung und
//   verändert Font.Size entsprechend
procedure TFormatFont.SetStellung(Canvas : TCanvas);
  { 06.04.04: Größe von tief- und hochgestelltem Text
              von 1/2 auf 2/3 der Normalgröße geändert }
  begin
  case Position of
  fpNormal : Translation := 0;   // normal
  fpSub    : begin               // tiefgestellt
             Translation := -Canvas.Font.Height;
             Canvas.Font.Size := 2 * Canvas.Font.Size Div 3;
             Inc(Translation, Canvas.Font.Height);
             end;
  fpSup    : begin               // hochgestellt
             Translation := 0;
             Canvas.Font.Size := 2 * Canvas.Font.Size Div 3;
             end;
  end;
  end;

{ // Tom Schaller's Original :
begin
  case Position of
  // normal
  fpNormal : Translation := 0;
  // tiefgestellt
  fpSub : begin
         Translation := -Canvas.Font.Height;
         Canvas.Font.Size := round(Canvas.Font.Size/2);
         Inc(Translation,Canvas.Font.Height);
       end;
  // hochgestellt
  fpSup : begin
         Translation := 0;
         Canvas.Font.Size := round(Canvas.Font.Size/2);
         end;
  end;
end;
}

function TFormatFont.ExtractAttrValue( attName, orgStr: String) : String;
  var valStr : String;
      n      : Integer;
  begin
  n := Pos(UpperCase(attName), UpperCase(orgStr));
  If n > 0 then begin
    n := n + Length(attName);
    While CharInSet(orgStr[n], [' ', '=']) do Inc(n);
    valStr := '';
    If orgStr[n] = '"' then begin
      Inc(n);
      Repeat
        valStr := valStr + orgStr[n];
        Inc(n);
      until (n > Length(orgStr)) or (orgStr[n] = '"');
      end
    else
      Repeat
        valStr := valStr + orgStr[n];
        Inc(n);
      until (n > Length(orgStr)) or CharInSet(orgStr[n], [' ', '>']);
    Result := valStr;
    end
  else
    Result := '';
  end;


function TFormatFont.AdjustFontData(ss : String; fs : TFormatFontStack;
                                    SizingAllowed : Boolean = False): Boolean;
  var newName,
      newSize : String;
      n, i    : Integer;
  begin
  Result := True;
  While CharInSet(ss[1], [' ', '<']) do
    Delete(ss, 1, 1);
  If ss[1] = '/' then  { Ende-Tag }
    fs.pop(Self)
  else begin           { Anfangs-Tag }
    n := Pos('FONT', UpperCase(ss));
    If n > 0 then begin   { Font-Tag; es sollte n = 1 sein! }
      Assert(n = 1, 'Falsches FONT-Tag!');
      newName := ExtractAttrValue('Face', ss);
      newSize := ExtractAttrValue('Size', ss);
      If (Length(newSize) > 0) and SizingAllowed then begin
        Val(newSize, n, i);
        If i <> 0 then n := 0;
        end
      else
        n := 0;
      fs.push(Self);
      If Length(newName) > 0 then Name := newName;
      If n               > 0 then Size := n;
      end
    else begin            { Attribut-Tags }
      n := Pos(' ', ss);
      While n > 0 do begin
        Delete(ss, n, 1);
        n := Pos(' ', ss);
        end;
      ss := UpperCase(ss);
      If ss = 'B' then begin
        fs.push(Self);
        Style := Style + [fsBold];
        end
      else If ss = 'U' then begin
        fs.push(Self);
        Style := Style + [fsUnderLine];
        end
      else If ss = 'I' then begin
        fs.push(Self);
        Style := Style + [fsItalic];
        end
      else If ss = 'SUP' then begin
        fs.push(Self);
        Position := fpSup;
        end
      else If ss = 'SUB' then begin
        fs.push(Self);
        Position := fpSub;
        end
      else
        Result := False;
      end;
    end;
  end;


// ---------------------------------------------------------
// TFormatFontStack
// ---------------------------------------------------------

constructor TFormatFontStack.Create;
  begin
  Inherited Create;
  List := TList.Create;
  end;

procedure TFormatFontStack.Free;
  begin
  While Not IsEmpty do
    pop(Nil);
  List.Free;  
  Inherited Free;
  end;

function TFormatFontStack.IsEmpty : Boolean;
  begin
  Result := List.Count = 0;
  end;

procedure TFormatFontStack.Push(f : TFormatFont);
  var nf : TFormatFont;
  begin
  nf := TFormatFont.Create(f);   // Neuen Eintrag mit den übergebenen Daten
  List.Insert(0, nf);            //   erstellen und in Liste einsortieren
  end;

procedure TFormatFontStack.Pop(f : TFormatFont);
  begin
  If List.Count > 0 then begin   // Falls der Stack nicht leer ist:
    If Assigned(f) then          // Daten des obersten Elements
      f.Assign(TFormatFont(List.Items[0]));  // ausgeben, dann
    TFormatFont(List[0]).Free;   // oberstes Element
    List.Delete(0);              //   entfernen
    end;
  end;


// ---------------------------------------------------------
// TRowInfo
// ---------------------------------------------------------

constructor TRowInfo.Create;
begin
  first  := 0;
  last   := 0;
  height := 0;
  width  := 0;
  bottom := 0;
end;




// ---------------------------------------------------------
//
//                          TCharacter
//
// ---------------------------------------------------------

constructor TCharacter.Create(c : char; f: TFormatFont);
begin
  inherited Create;
  FUnicode       := c;
  FFont          := TFormatFont.Create(f);
  FCanvas        := nil;
  FDisplayFactor := 1.0;
  AdjustSize;
end;

constructor TCharacter.Create(c : char; f: TFormatFont; Canvas: TCanvas);
begin
  Create(c,f);
  FCanvas := Canvas;
  AdjustSize;
end;

destructor TCharacter.Destroy;
begin
  FreeAndNil(FFont);
  inherited Destroy;
end;



// Größenfunktionen
// ----------------

procedure TCharacter.SetDisplayFactor(f : extended);
  begin
  FDisplayFactor := f;
  AdjustSize;
  end;

procedure TCharacter.SetCanvas(c : TCanvas);
  begin
  FCanvas := c;
  AdjustSize;
  end;

procedure TCharacter.AdjustSize;
  var Metrics : TTextMetric;
  begin
  if assigned(FCanvas) and (Length(FUnicode) > 0) then begin
    FFont.SetFont(FCanvas, FDisplayFactor);
    if FUnicode[1] = ' ' then begin
      FSize.cy :=0;
      FBottom  :=0;
      end
    else begin
      // Height = Höhe des Buchstaben
      FSize.cy :=FCanvas.TextHeight(FUnicode);
      // Bottom = Höhe bis zur Grundlinie des Buchstaben
      //          ohne Berücksichtigung der Hoch/Tiefstellung
      GetTextMetrics(FCanvas.Handle, Metrics);
      FBottom := Metrics.tmAscent;
      end;
    FFont.SetStellung(FCanvas);
    // Width = Breite des Buchstaben
    FSize.cx := FCanvas.TextWidth(FUnicode);
    GetCharABCWidths(FCanvas.Handle,ord(FUnicode[1]),ord(FUnicode[1]),FABCSize);
    end
  else begin
    FSize.cx := 0;
    FSize.cy := 0;
    FBottom  := 0;
    FABCSize.abcA := 0;
    FABCSize.abcB := 0;
    FABCSize.abcC := 0;
    end;
  end;

function TCharacter.GetWidth: integer;
  begin
  result := FSize.cx;
  end;

function TCharacter.GetHeight: integer;
  begin
  result := FSize.cy;
  end;

// Liefert das dargestellte Zeichen
function TCharacter.GetChar: char;
  begin
  result := FUnicode[1];
  end;

// Zeichnen des Buchstaben
// r       = Clipping Rect
// inverse = Müssen die Farben umgedreht werden
procedure TCharacter.Paint(Pos : TPoint; r :TRect; inverse : boolean);
  var i : Integer;
  begin
  // Ist das ClipRect überhaupt sichtbar?
  if assigned(FCanvas) and (r.right-r.left>0) then
    with FCanvas do begin
      FFont.SetFont(FCanvas, FDisplayFactor, inverse);
      FFont.SetStellung(FCanvas);

      // Eigentliche Zeichenausgabe
      TextRect(r, Pos.x,Pos.y-FBottom+FFont.Translation,FUnicode);

      // Untersteichen des Buchstabens (außer er ist tiefgestellt)
      // wird nicht über das normale Style erledigt, damit eine einheitliche
      // Linie bei verschiedenen Schriftarten entsteht
      if (fsUnderline in FFont.Style) and
         not (FFont.Position = fpSub) then begin
        Pen.Color := Font.Color;
        i := 0;
        repeat
          MoveTo(r.left, Pos.y+2+i);
          LineTo(r.right, Pos.y+2+i);
          inc(i);
        until i > FDisplayFactor-0.5;
      end;
    end;
  end;

procedure TCharacter.PaintOverhang(Pos : TPoint; r :TRect; inverse : boolean);
  var c : TColor;
  begin
  // Ist das ClipRect überhaupt sichtbar?
  if assigned(FCanvas) and (r.right-r.left>0) then
    with FCanvas do begin
      FFont.SetFont(FCanvas, FDisplayFactor, inverse);
      FFont.SetStellung(FCanvas);
      c := Brush.Color;
      Brush.Style := bsClear;
      TextRect(r, Pos.x, Pos.y - FBottom + FFont.Translation, FUnicode);
      Brush.Style := bsSolid;
      Brush.Color := c;
    end;
  end;

procedure TCharacter.PaintTransparent(Pos: TPoint; r: TRect; col: TColor);
  var i : Integer;
  begin
  // Ist das ClipRect überhaupt sichtbar?
  if assigned(FCanvas) and (r.right-r.left>0) then
    with FCanvas do begin
      FFont.SetFont(FCanvas, FDisplayFactor);
      FFont.SetStellung(FCanvas);

      // Umschalten auf transparente Ausgabe !
      Brush.Style := bsClear;
      If FFont.Tag = 0 then    // Normalfall
        Font.Color := col
      else                     // Speziell für HTML-Tags
        Font.Color := FFont.Color;

      // Eigentliche Zeichenausgabe
      TextRect(r, Pos.x, Pos.y - FBottom + FFont.Translation, FUnicode);

      // Untersteichen des Buchstabens (außer er ist tiefgestellt)
      // wird nicht über das normale Style erledigt, damit eine einheitliche
      // Linie bei verschiedenen Schriftarten entsteht
      if (fsUnderline in FFont.Style) and
         not (FFont.Position = fpSub) then begin
        Pen.Color := Font.Color;
        i := 0;
        repeat
          MoveTo(r.left, Pos.y+2+i);
          LineTo(r.right, Pos.y+2+i);
          inc(i);
        until i > FDisplayFactor-0.5;
      end;
    end;
  end;

procedure TCharacter.PaintOverhangTransparent(Pos : TPoint; r :TRect; col : TColor);
  begin
  // Ist das ClipRect überhaupt sichtbar?
  if assigned(FCanvas) and (r.right-r.left>0) then
    with FCanvas do begin
      FFont.SetFont(FCanvas, FDisplayFactor);
      FFont.SetStellung(FCanvas);
      Brush.Style := bsClear;
      If FFont.Tag = 0 then    // Normalfall
        Font.Color := col
      else                     // Speziell für HTML-Tags
        Font.Color := FFont.Color;
      TextRect(r, Pos.x, Pos.y-FBottom+FFont.Translation, FUnicode);
    end;
  end;


// Font des Buchstabens ändern
// Es sollen nur die in Change angegeben Werte des neuen Font
// übernommen werden.
procedure TCharacter.ChangeFont( NewFont : TFormatFont; Change: TFontChanges);
begin
  if (fcBold in Change) then
  begin
    if fsBold in NewFont.Style then FFont.Style := FFont.Style + [fsBold]
                               else FFont.Style := FFont.Style - [fsBold];
  end;
  if (fcItalic in Change) then
  begin
    if fsItalic in NewFont.Style then FFont.Style := FFont.Style + [fsItalic]
                                 else FFont.Style := FFont.Style - [fsItalic];
  end;
  if (fcUnderline in Change) then
  begin
    if fsUnderline in NewFont.Style then FFont.Style := FFont.Style + [fsUnderline]
                                    else FFont.Style := FFont.Style - [fsUnderline];
  end;
  if (fcPosition in Change) then FFont.Position := NewFont.Position;
  if (fcSize in Change) then FFont.Size := NewFont.Size;
  if (fcName in Change) then FFont.Name := NewFont.Name;
  if (fcTag in Change) then FFont.Tag := NewFont.Tag;
  if (fcColor in Change) then FFont.Color := NewFont.Color;
  AdjustSize;
end;




// -------------------------------------------
//
//                   TLine
//
// -------------------------------------------

constructor TLine.Create(s : string; fontlist: TList; linkList: TStringList);
  begin
  inherited Create;
  FCharacters  := TList.Create;
  FRowInfos    := TList.Create;
  FCanvas      := nil;
  FMaxWidth := 32000;  // Dummywert
  SetHTMLText(s, FontList, linkList);
  end;

constructor TLine.Create(s : string; fontlist: TList; linkList: TStringList;
                         MaxWidth: integer; Canvas: TCanvas);
  begin
  Create(s, fontlist, linkList);
  FMaxWidth := MaxWidth;
  SetCanvas(Canvas);
  AdjustRowInfos;
  end;

destructor TLine.Destroy;
var i : integer;
begin
  for i:= FCharacters.Count-1 downto 0 do
    TCharacter(FCharacters.items[i]).Free;
  FCharacters.Free;
  for i:= FRowInfos.Count-1 downto 0 do
    TRowInfo(FRowInfos.items[i]).Free;
  FRowInfos.Free;
  inherited;
end;

procedure TLine.SetHTMLText(s : string; fontList : TList; linkList: TStringList);
  var f       : TFormatFont;
      Tag     : String;
      code, i : Integer;

  procedure AnalyseContentOf(OTag: String);
    var UpTag,
        subtag, wert : String;
        j            : Integer;
    begin
    // Zulässige Tags
    if Upcase(OTag[1]) = 'A' then begin  // Link-Anfangs-Tag
      wert := f.ExtractAttrValue('href', OTag);
      If Length(wert) > 0 then begin
      {ToDo: Die folgende Zeile überschreibt einen schon vorhandenen Font!}
        f := TFormatFont.Create(f);
        f.Tag := linkList.Count + 1;     // Referenz-Nummer im Font vermerken
        f.Style := f.Style + [fsUnderline];  // Darstellung unterstrichen...
        f.Color := clBlue;                   //              ...und blau
        FontList.Add(f);                 // Font an die Fontliste anfügen
        linkList.Add(wert);              // Link an die Linkliste anfügen
        end
      else
        MessageDlg('Der HTML-Text ist nicht korrekt!',mtError,[mbOk],0);
      end
    else if (       OTag[1]  = '/') and  // Link-Ende-Tag
            (Upcase(OTag[2]) = 'A') then begin
      if FontList.Count >= 2 then begin  // Noch genug Fonts in der Liste?
        f := TFormatFont(FontList.items[FontList.Count-2]);
        TFormatFont(FontList.items[FontList.count-1]).free;
        FontList.delete(FontList.Count-1);
        end
      else
        MessageDlg('Der HTML-Text ist nicht korrekt!',mtError,[mbOk],0);
      end
    else if compareStr(UpperCase(OTag), 'HR') = 0 then  // Absatz-Umbruch
      FCharacters.add(TCharacter.Create('¯', f))
    else begin                           // Zeichen-Formatierung
      UpTag:=upperCase(OTag);
      if      compareStr(UpTag,'B')=0 then f.Style := f.Style + [fsBold]
      else if compareStr(UpTag,'/B')=0 then f.Style := f.Style - [fsBold]
      else if compareStr(UpTag,'I')=0 then f.Style := f.Style + [fsItalic]
      else if compareStr(UpTag,'/I')=0 then f.Style := f.Style - [fsItalic]
      else if compareStr(UpTag,'U')=0 then f.Style := f.Style + [fsUnderline]
      else if compareStr(UpTag,'/U')=0 then f.Style := f.Style - [fsUnderline]
      else if compareStr(UpTag,'SUB')=0 then f.Position := fpSub
      else if compareStr(UpTag,'/SUB')=0 then f.Position := fpNormal
      else if compareStr(UpTag,'SUP')=0 then f.Position := fpSup
      else if compareStr(UpTag,'/SUP')=0 then f.Position := fpNormal

      // Beim Fonttag muss der Font gespeichert, bzw.
      // der alte Font wieder aus der Liste gelesen werden
      else if compareStr(copy(UpTag,1,5),'/FONT')=0 then begin
        // Enthält Fontliste noch genug Fonts?
        if FontList.Count >= 2 then begin
          f := TFormatFont(FontList.items[FontList.Count-2]);
          TFormatFont(FontList.items[FontList.count-1]).free;
          FontList.delete(FontList.Count-1);
          end
        else
          MessageDlg('Der HTML-Text ist nicht korrekt!',mtError,[mbOk],0);
        end
      else if compareStr(copy(UpTag,1,4),'FONT')=0 then begin
        // Neuen Font erzeugen und in Liste hinzufügen
        // zunächst auf Basis des aktuellen Fonts
        f := TFormatFont.Create(f);
        FontList.add(f);

        // SubTags untersuchen:
        subtag := Trim(copy(UpTag,6,length(OTag)));
        wert := f.ExtractAttrValue('SIZE', subtag);
        If Length(wert) > 0 then begin
          val(Wert,j,code);
          If code = 0 then f.Size := j;
          end;
        wert := f.ExtractAttrValue('FACE', subtag);
        If Length(wert) > 0 then f.Name := wert;
        end;
      end;
    end;

  begin { of SetHTMLText }
  // alte Einträge für Buchstaben und RowInfos löschen
  for i:= FCharacters.Count-1 downto 0 do begin
    TCharacter(FCharacters.items[i]).Free;
    FCharacters.delete(i);
    end;
  for i:= FRowInfos.Count-1 downto 0 do begin
    TRowInfo(FRowInfos.items[i]).Free;
    FRowInfos.Delete(i);
    end;

  // Zuletzt benutzten Font wählen
  if FontList <> nil then
    f := TFormatFont(FontList.items[FontList.Count-1])
  else
    f := TFormatFont.Create;

  // Alle Buchstaben auswerten
  i := 1;
  while i <= length(s) do begin
    // kommt als nächstes ein codiertes Zeichen? (&..;)
    if s[i]='&' then begin
      Tag := copy(s,i+1,length(s));
      code := pos(';',Tag);
      Tag := copy(Tag,1,code-1);

      // es gibt nur 2 bis 4 Zeichen Länge
      if (code >= 3) and (code<=5) then begin
        i:=i+length(Tag)+2;
        Tag := lowerCase(Tag);
        if comparestr(tag,'lt')=0 then FCharacters.add(TCharacter.Create('<',f));
        if comparestr(tag,'gt')=0 then FCharacters.add(TCharacter.Create('>',f));
        if comparestr(tag,'amp')=0 then FCharacters.add(TCharacter.Create('&',f));
        if comparestr(tag,'apos')=0 then FCharacters.add(TCharacter.Create('''',f));
        if comparestr(tag,'quot')=0 then FCharacters.add(TCharacter.Create('"',f));
        end
      else begin
        inc(i);
        MessageDlg('Der HTML-Text ist nicht korrekt!',mtError,[mbOk],0);
        end;
      end
    else begin
      // Kommt als nächstes ein Tag ? (<..>)
      if s[i]='<' then begin
        Tag := copy(s,i+1,length(s));
        code := pos('>',Tag);
        if code = 0 then begin
          inc(i);
          MessageDlg('Der HTML-Text ist nicht korrekt!',mtError,[mbOk],0);
          end
        else begin
          Tag := copy(Tag,1,code-1);
          i:=i+length(Tag)+2;   // i zeigt jetzt direkt hinter das Ende des Tags!
          AnalyseContentOf(Tag);
          end
        end
      else begin
        // Offenbar kommt als nächstes ein ganz normales druckbares Zeichen!
        FCharacters.add(TCharacter.Create(s[i],f));
        i:= i +1;
        end;
      end;
    end;
  AdjustRowInfos;
  end;  { of SetHTMLText }

procedure TLine.Paint(Pos : TPoint; ClipRect : TRect);
  var s : TSelection;
  begin
  s.start.x := -1;
  s.Start.y := -1;
  s.Ende.x  := -1;
  s.Ende.y  := -1;
  Paint(Pos,ClipRect,s);
  end;

procedure TLine.Paint(Pos : TPoint; ClipRect : TRect; Selection : TSelection);
  var aktPos,
      oldPos    : TPoint;
      highLight : Boolean;
      r         : TRect;
      Size      : TABC;
      row,
      Overhang,
      Ex        : Integer;
      c         : Char;
      m,
      i         : Integer;

  begin
  if assigned(FCanvas) then begin
    aktPos := Pos;

    r.Top     := aktPos.y;
    r.Bottom  := r.Top + TRowInfo(FRowInfos.Items[0]).Height;
    r.Right   := aktPos.x;
    r.Left    := aktPos.x;

    // Beim ersten Buchstaben Platz für Underhang lassen
    Overhang := 0;

    // Die Baseline ist für das Zeichnen entscheidend
    aktPos.y := aktPos.y + GetCharBottom(-1);

    row := 0;

    // Schon vor Beginn der Zeile Selektionsanfang?
    if (Selection.Start.y < 0) and (Selection.Ende.y>=0) then begin
      HighLight := True;
      FCanvas.Brush.Color := FCanvas.Brush.Color xor ColorToRGB(clWhite);
      end
    else HighLight := False;

    for i := 0 to FCharacters.Count-1 do begin
      // Selektionsbeginn
      if (Selection.Start.y = 0) and (Selection.Start.x = i) then begin
        HighLight := True;
        FCanvas.Brush.Color := FCanvas.Brush.Color xor ColorToRGB(clWhite);
        end;
      // Selektionsende
      if (Selection.Ende.y = 0) and (Selection.Ende.x = i) then begin
        HighLight := False;
        FCanvas.Brush.Color := FCanvas.Brush.Color xor ColorToRGB(clWhite);
        end;

      // Neue Anzeigezeile
      if i > TRowInfo(FRowInfos.Items[row]).last then begin
        // Startwerte der neuen Zeile
        aktPos.x := Pos.x;
        aktPos.y := aktPos.y - TRowInfo(FRowInfos.Items[row]).bottom
                             + TRowInfo(FRowInfos.Items[row]).height
                             + TRowInfo(FRowInfos.Items[row+1]).bottom;
        // Zeilen löschen
        r.Left := r.right;
        r.Right := FMaxWidth+Pos.x;
        FCanvas.FillRect(Clip(r,ClipRect));

        r.Top    := r.Bottom;
        r.Left   := aktPos.x;
        r.Bottom := r.Top + TRowInfo(FRowInfos.Items[row+1]).height;

        inc(row);
        end;

      Size := TCharacter(FCharacters.Items[i]).ABC;
      // Underhang wird durch Verschieben der Position ausgeglichen
      // z.B. erster kursiver Buchstabe
      Ex   := ExtraBefore(i, TRowInfo(FRowInfos.Items[row]).First);
      if (Size.abcA < 0) and (Ex>0) then begin
        Inc(aktPos.x,Ex);
        Size.abcA := 0;
        end;

      r.Right := aktPos.x + TCharacter(FCharacters.Items[i]).Width;
      // Underhang wird durch Verschieben des rechten Rands ausgeglichen
      // z.B. letzter kursiver Buchstabe
      Ex   := ExtraAfter(i, TRowInfo(FRowInfos.Items[row]).Last);
      if (Size.abcC < 0) and (Ex>0) then begin
        Inc(r.right,Ex);
        Size.abcC := 0;
        end;

      // Ausgabe des aktuellen Buchstabens
      c := TCharacter(FCharacters.Items[i]).getChar;
      If c = '¯' then begin               //  "<hr>"
        m := (r.Top + r.Bottom) Div 2;
        r.Right := ClipRect.Right;
        With FCanvas do begin
          FillRect(Clip(r, ClipRect));
          Pen.Color := clLtGray;
          Pen.Width := 3;
          MoveTo(r.Left  +  2, m);
          LineTo(r.Right - 20, m);
          Pen.Width := 1;
          end;
        r.Right := ClipRect.Right;
        end
      else
        TCharacter(FCharacters.Items[i]).Paint(aktPos,Clip(r,ClipRect),HighLight);

      // Overhang des vorherigen Buchstabens ausgeben
      if Overhang > 0 then
        TCharacter(FCharacters.Items[i-1]).PaintOverhang(oldPos,Clip(r,ClipRect),HighLight);

      Overhang  := -Size.abcC;
      oldPos    := aktPos;
      aktPos.x  := r.Right;

      // Underhang des nächsten Buchstabens ausgeben,
      // wenn er nicht durch Verschieben ausgeglichen wird
      if (i < TRowInfo(FRowInfos.Items[row]).last) then begin
        Ex := ExtraBefore(i+1, TRowInfo(FRowInfos.Items[row]).First);
        if (TCharacter(FCharacters.Items[i+1]).ABC.abcA < 0) and (Ex=0) then
          TCharacter(FCharacters.Items[i+1]).PaintOverhang(aktPos,Clip(r,ClipRect),HighLight);
        end;
      r.Left := r.Right;
      end;

    if (HighLight) then
      FCanvas.Brush.Color := FCanvas.Brush.Color xor ColorToRGB(clWhite);

    // Ende des letzten Buchstabens ergänzen
    if Overhang > 0 then begin
      r.Left := oldPos.x;
      r.Right := r.Left + TCharacter(FCharacters.Last).Width * 2;
      TCharacter(FCharacters.Last).PaintOverhang(oldPos,Clip(r,ClipRect),HighLight);
      end;

    // Zeile auffüllen
    r.Left := r.right;
    r.Right := FMaxWidth+Pos.x;
    FCanvas.FillRect(Clip(r,ClipRect));
    end;
  end;


procedure TLine.PaintTransparent(Pos : TPoint; ClipRect : TRect; col : TColor);
  var aktPos,
      oldPos    : TPoint;
      r         : TRect;
      Size      : TABC;
      row,
      Overhang,
      Ex        : Integer;
      c         : Char;
      m,
      i         : Integer;


  begin
  if assigned(FCanvas) then begin
    aktPos := Pos;

    r.Top     := aktPos.y;
    r.Bottom  := r.Top + TRowInfo(FRowInfos.Items[0]).Height;
    r.Right   := aktPos.x;
    r.Left    := aktPos.x;

    // Beim ersten Buchstaben Platz für Underhang lassen
    Overhang := 0;

    // Die Baseline ist für das Zeichnen entscheidend
    aktPos.y := aktPos.y + GetCharBottom(-1);

    row := 0;
    for i := 0 to FCharacters.Count-1 do begin
      // Neue Anzeigezeile
      if i > TRowInfo(FRowInfos.Items[row]).last then begin
        // Startwerte der neuen Zeile
        aktPos.x := Pos.x;
        aktPos.y := aktPos.y - TRowInfo(FRowInfos.Items[row]).bottom
                             + TRowInfo(FRowInfos.Items[row]).height
                             + TRowInfo(FRowInfos.Items[row+1]).bottom;
        // Zeilen löschen
        r.Left := r.right;
        r.Right := FMaxWidth+Pos.x;
        FCanvas.FillRect(Clip(r,ClipRect));

        r.Top    := r.Bottom;
        r.Left   := aktPos.x;
        r.Bottom := r.Top + TRowInfo(FRowInfos.Items[row+1]).height;

        inc(row);
        end;

      Size := TCharacter(FCharacters.Items[i]).ABC;
      // Underhang wird durch Verschieben der Position ausgeglichen
      // z.B. erster kursiver Buchstabe
      Ex   := ExtraBefore(i, TRowInfo(FRowInfos.Items[row]).First);
      if (Size.abcA < 0) and (Ex>0) then begin
        Inc(aktPos.x,Ex);
        Size.abcA := 0;
        end;

      r.Right := aktPos.x + TCharacter(FCharacters.Items[i]).Width;
      // Underhang wird durch Verschieben des rechten Rands ausgeglichen
      // z.B. letzter kursiver Buchstabe
      Ex   := ExtraAfter(i, TRowInfo(FRowInfos.Items[row]).Last);
      if (Size.abcC < 0) and (Ex>0) then begin
        Inc(r.right,Ex);
        Size.abcC := 0;
        end;

      // Ausgabe des aktuellen Buchstabens
      c := TCharacter(FCharacters.Items[i]).getChar;
      If c = '¯' then begin
        m := (r.Top + r.Bottom) Div 2;
        r.Right := ClipRect.Right;
        With FCanvas do begin     // Hintergrund *nicht* löschen !
          Pen.Color := clLtGray;
          Pen.Width := 3;
          MoveTo(r.Left  +  2, m);
          LineTo(r.Right - 20, m);
          Pen.Width := 1;
          end;
        r.Right := ClipRect.Right;
        end
      else
        TCharacter(FCharacters.Items[i]).PaintTransparent(aktPos,Clip(r,ClipRect),col);

      // Overhang des vorherigen Buchstabens ausgeben
      if Overhang > 0 then
        TCharacter(FCharacters.Items[i-1]).PaintOverhangTransparent(oldPos,Clip(r,ClipRect),col);

      Overhang  := -Size.abcC;
      oldPos    := aktPos;
      aktPos.x  := r.Right;

      // Underhang des nächsten Buchstabens ausgeben,
      // wenn er nicht durch Verschieben ausgeglichen wird
      if (i < TRowInfo(FRowInfos.Items[row]).last) then begin
        Ex := ExtraBefore(i+1, TRowInfo(FRowInfos.Items[row]).First);
        if (TCharacter(FCharacters.Items[i+1]).ABC.abcA < 0) and (Ex=0) then
          TCharacter(FCharacters.Items[i+1]).PaintOverhangTransparent(aktPos,Clip(r,ClipRect),col);
        end;
      r.Left := r.Right;
      end;

    // Ende des letzten Buchstabens ergänzen
    if Overhang > 0 then begin
      r.Left := oldPos.x;
      r.Right := r.Left + TCharacter(FCharacters.Last).Width * 2;
      TCharacter(FCharacters.Last).PaintOverhangTransparent(oldPos,Clip(r,ClipRect),col);
      end;
      
    // Hier Zeile *nicht* auffüllen !
    // Dies würde zu häßlichen Auslöschungen führen, weshalb Tom's Originalcode
    //  (siehe oben, am Ende der "Paint"-Prozedur) entfernt wurde !  29.11.05
    end;
  end;


// Umbrüche der Anzeigenzeilen und die Größe
// der Anzeigezeilen bestimmen
procedure TLine.AdjustRowInfos;
  var char_width, char_height, char_nr, i : Integer;
      RowInfo, WordInfo : TRowInfo;
      c : char;

  begin

  // alte RowInfos löschen
  for i:= FRowInfos.Count-1 downto 0 do begin
    TRowInfo(FRowInfos.items[i]).Free;
    FRowInfos.delete(i);
    end;

  char_nr  := 0;

  WordInfo := TRowInfo.Create;
  RowInfo  := TRowInfo.Create;
  RowInfo.First := 0;

  if assigned(FCanvas) then begin
    while char_nr < FCharacters.Count do begin

      // Größe des nächsten Buchstaben bestimmen
      char_width := TCharacter(FCharacters.Items[char_nr]).Width;
      char_height:= TCharacter(FCharacters.Items[char_nr]).Height;
      c          := TCharacter(FCharacters.Items[char_nr]).Character;

      // Wort passt nicht mehr in die Zeile
      if ((c <> ' ') and (RowInfo.Width + WordInfo.Width > FMaxWidth)) or
        (RowInfo.Width + WordInfo.Width + char_Width +
         ExtraBefore(char_nr,RowInfo.First)+ ExtraAfter(char_nr,char_nr)
         > FMaxWidth) then begin
        // Nur ein einziges Wort in Zeile, d.h. kann nicht
        // umgebrochen werden, Trennung innerhalb des Wortes
        if (RowInfo.Width = 0) then begin
          RowInfo.last   := char_nr-1;
          RowInfo.Width  := WordInfo.Width;
          RowInfo.Height := WordInfo.Height;
          RowInfo.Bottom := WordInfo.Bottom;
          WordInfo.Width := 0;
          WordInfo.Height := 0;
          WordInfo.Bottom := 0;
          end;

        // RowInfo.Width = 0 kommt vor, wenn 1. Buchstabe zu breit für Zeile
        if RowInfo.Width > 0 then begin
          // Minimale Höhe für Leerzeilen oder winzige Buchstaben festlegen
          if RowInfo.Height = 0 then RowInfo.Height := MIN_HEIGHT;
          // Kursiver Buchstabe am Zeilenende
          RowInfo.Width := RowInfo.Width - ExtraAfter(RowInfo.Last, FCharacters.Count-1) + ExtraAfter(RowInfo.Last, RowInfo.Last);
          FRowInfos.Add(RowInfo);

          RowInfo := TRowInfo.Create;
          RowInfo.First := TRowInfo(FRowInfos.Items[FRowInfos.Count-1]).Last+1;

          // Aktueller Buchstabe ist nicht Beginn des aktuellen Worts
          // dann den Platzbedarf des Wortanfangs anpassen
          if char_nr <> RowInfo.First then
            WordInfo.Width := WordInfo.Width
               - ExtraBefore(RowInfo.First,TRowInfo(FRowInfos.Items[FRowInfos.Count-1]).First)
               + ExtraBefore(RowInfo.First,RowInfo.First);
          end;
        end;

      // größter Buchstabe bestimmt die Höhe des Wortes/Zeile
      if char_height > WordInfo.Height then begin
        WordInfo.Height := char_height;
        WordInfo.Bottom := TCharacter(FCharacters.Items[char_nr]).Bottom;
        end;

      WordInfo.Width := WordInfo.Width + char_width +
                       ExtraBefore(char_nr,RowInfo.First)+
                       ExtraAfter(char_nr,FCharacters.Count-1);

      // Wortende
      if (c = ' ') or (char_nr = FCharacters.Count-1) then begin
        // Wort in der gleichen Zeile anzeigen
        RowInfo.last  := char_nr;
        RowInfo.Width := RowInfo.Width + WordInfo.Width;
        if RowInfo.Height < WordInfo.Height then begin
          RowInfo.Height := WordInfo.Height;
          RowInfo.Bottom := WordInfo.Bottom;
          end;

        WordInfo.Width := 0;
        WordInfo.Bottom := 0;
        WordInfo.Height := 0;
        end;
      inc(char_nr);
      end;
    RowInfo.last := char_nr-1;
    end
  else
    RowInfo.last := FCharacters.Count-1;

  if RowInfo.Height = 0 then
    RowInfo.Height := MIN_HEIGHT;
  FRowInfos.Add(RowInfo);
  WordInfo.Free;
  end;


Procedure TLine.Insert(i : integer; b : TCharacter);
  begin
  FCharacters.Insert(i,b);
  AdjustRowInfos;
  end;


// Größe der Zeile
function TLine.GetSize : TSize;
  var t:TSize;
  begin
  t.cx := GetWidth;
  t.cy := GetHeight;
  result := t;
  end;

// reale Breite
function TLine.GetWidth: integer;
  var i,cx: integer;
  begin
  cx := 0;
  // Breite entspricht der längsten Anzeigezeile
  for i := 0 to FRowInfos.Count-1 do
    if cx < TRowInfo(FRowInfos.Items[i]).Width then
       cx := TRowInfo(FRowInfos.Items[i]).Width;
  result := cx;
  end;

function TLine.GetHeight: integer;
  var i,cy : integer;
  begin
  cy := 0;
  for i := 0 to FRowInfos.Count-1 do
    cy := cy + TRowInfo(FRowInfos.Items[i]).Height;
  result := cy;
  end;

// Position der Baseline eines Buchstaben, relativ zur
// Oberkante der Zeile (Hardbreak)
function TLine.GetCharBottom(nr : integer) : integer;
  var i,cy : integer;
  begin
  cy := 0;
  i := 0;
  // Höhe der vorangehenden Anzeigenzeilen
  while TRowInfo(FRowInfos.Items[i]).last < nr do begin
    cy := cy + TRowInfo(FRowInfos.Items[i]).Height;
    i := i +1;
    end;
  // Base der richtigen Anzeigezeile
  cy := cy + TRowInfo(FRowInfos.Items[i]).Bottom;
  result := cy;
  end;

// Ist vor dem Buchstaben Platz nötig um die schrägen kursiven
// Buchstaben darzustellen
function TLine.ExtraBefore(nr : integer; First : Integer) : integer;
  var pt : Integer;
      f1, f2 : TFormatFont;
      b  : Boolean;
  begin
  b  := False;
  f1 := GetCharacter(nr).Font;
  if (fsItalic in f1.Style) then begin
    if (nr = First) then b := True // erster Buchstabe
    else begin
      f2 := GetCharacter(nr-1).Font;
      if not(fsItalic in f2.Style) then b := True;    //erster kursiver Buchstabe
      if ((f1.Position = fpNormal) and (f2.Position = fpSub)) then b:= True;     //letzter Buchstabe tiefgestellt
      end;
    end;
  if b then begin
    pt := -GetCharacter(nr).ABC.abcA;
    if pt < 0 then pt := 0;
    result := pt;
    end
  else result := 0;
  end;

// Ist nach dem Buchstaben Platz nötig um die schrägen kursiven
// Buchstaben darzustellen
function TLine.ExtraAfter(nr : integer; Last : Integer) : integer;
  var pt : Integer;
      f1, f2 : TFormatFont;
      b  : Boolean;
  begin
  b  := False;
  f1 := GetCharacter(nr).Font;
  if (fsItalic in f1.Style) then begin
    if (nr = Last) then b := True // letzter Buchstabe
    else begin
      f2 := GetCharacter(nr+1).Font;
      if not(fsItalic in f2.Style) then b := True;    //letzter kursiver Buchstabe
      if ((f1.Position = fpNormal) and (f2.Position = fpSup)) then b:= True;     //nächster Buchstabe hochgestellt
      end;
    end;
  if b then begin
    pt := -GetCharacter(nr).ABC.abcC;
    if pt < 0 then pt := 0;
    result := pt;
    end
  else result := 0;
  end;

// Die Position eines Buchstaben relativ zur linken, oberen
// Ecke der Zeile (Hardbreak)
function TLine.GetCharPosition(nr : integer) : TRect;
var i,j: integer;
    rect : TRect;
begin
  Rect.Top := 0; Rect.Left := 0;
  i := 0;
  // Oberkante := Höhe der Anzeigezeilen vor dem Buchstaben
  while (i<FRowInfos.Count-1) and (TRowInfo(FRowInfos.Items[i]).last < nr) do
  begin
    Rect.Top := Rect.Top + TRowInfo(FRowInfos.Items[i]).Height;
    inc(i);
  end;
  // Unterkante
  Rect.Bottom := Rect.Top + TRowInfo(FRowInfos.Items[i]).Height;

  // Linke Kante
  j := TRowInfo(FRowInfos.Items[i]).First;
  while j <= nr-1 do
  begin
    Rect.Left := Rect.Left + GetCharacter(j).Width
                 + ExtraBefore(j,TRowInfo(FRowInfos.Items[i]).First)
                 + ExtraAfter(j,TRowInfo(FRowInfos.Items[i]).Last);
    inc(j);
  end;

  // Rechte Kante
  if (j<FCharacters.Count) then
  begin
    Rect.Right := Rect.Left  + GetCharacter(j).Width
                  + ExtraAfter(j,TRowInfo(FRowInfos.Items[i]).Last);
  end
  else
    // Cursor steht hinter letztem Buchstaben
    Rect.Right := Rect.Left;

  result := Rect;
end;

function TLine.GetCharFont(nr : integer):TFormatFont;
  begin
  if (nr>=0) and (nr<FCharacters.Count) then
    result := GetCharacter(nr).Font
  else
    If (nr>0) and (nr = FCharacters.Count) then
      result := GetCharacter(nr-1).Font
    else
      result := nil;
  end;

// maximale Breite setzen
procedure TLine.SetMaxWidth(w:integer);
begin
  if FMaxWidth <> w then
  begin
    FMaxWidth := w;
    AdjustRowInfos;
  end;
end;

// Faktor für die Anzeige setzen
procedure TLine.SetDisplayFactor( f : extended );
  var c : TCharacter;
      i : integer;
  begin
  // Bei jedem Buchstaben setzen
  for i := 0 to FCharacters.Count-1 do
    try
      c := GetCharacter(i);
      c.DisplayFactor := f;
    except
      // do nothing !
    end;
  AdjustRowInfos;
  end;

// Canvas an Buchstaben weitergeben
procedure TLine.SetCanvas( c : TCanvas );
var i : integer;
begin
  FCanvas := c;
  for i := 0 to FCharacters.Count-1 do
  begin
    GetCharacter(i).Canvas:=c;
  end;
  AdjustRowInfos;
end;

// Reinen Text der Zeile zurückliefern
function TLine.GetText : String;
  var i : integer;
      s : String;
  begin
  s := '';
  for i := 0 to FCharacters.Count-1 do
    s := s + GetCharacter(i).Character;
  result := s;
  end;

// Formatierten Text der Zeile zurückliefern
procedure TLine.GetHTMLText(HTMLText : TStrings; FontList: TList; TagList, LinkList: TStrings);
  var i,j,n : integer;
      s,t : String;
      OldFont,NewFont : TFormatFont;
      br : boolean;
      c : char;

  // Hilfsfunktion zum Erzeugen und Merken eines neuen Tags
  // Öffnen ist immer erlaubt (keine Reihenfolge wird beachtet)
  function AddTag(tag : string): string;
    begin
    TagList.add('</'+Tag+'>');
    result := '<'+Tag+'>';
    end;

  // Hilfsfunktion zum Schließen eines Tags
  // Alle Tags die nach dem angegeben Tag geöffnet wurden,
  // müssen erst geschlossen werden und danach wieder geöffnet werden
  // um korrekten HTML-Code zu erhalten
  function CloseTag(tag : string): string;
    var u : integer;
        s : string;
    begin
    tag := '</'+tag+'>';
    u := TagList.Count;
    s := '';
    // Alle nachfolgenden Tags und Tag selbst schließen
    if u > 0 then begin
      repeat
        u := u -1;
        s := s + TagList.Strings[u];
      until (u=0) or (comparestr(TagList.Strings[u],tag)=0);
      TagList.Delete(u);
      end;
    // Alle nachfolgenden Tags wieder öffnen
    while u < TagList.Count do begin
      // Tag ohne "/"
      s := s + '<' + copy(TagList.STrings[u],3,10);
      inc (u);
      end;
    result := s;
    end;

  begin
  j := 0;
  // Auch im HTML-Code Softbreaks entsprechend der Anzeigezeilen erzeugen
  for i := 0 to FRowInfos.Count-1 do begin
    s := '';
    // Bis zum letzten Buchstaben dieser Anzeigezeile
    while j <= TRowInfo(FRowInfos.Items[i]).last do begin
      // Tags anpassen
      OldFont := TFormatFont(FontList.items[Fontlist.Count-1]);
      NewFont := GetCharacter(j).Font;

      // Bei neuem Font-Tag und Link-Tag erst alle Tags schließen (sieht besser aus)
      if (OldFont.Name <> NewFont.Name) or
         (OldFont.Size <> NewFont.Size) or
         (OldFont.Tag  <> NewFont.Tag ) then begin
        for n := TagList.count - 1 downto 0 do begin
          s := s + TagList.Strings[n];
          TagList.Delete(n);
          end;

        // Ist noch ein Font-Tag geöffnet?
        if FontList.Count = 2 then begin
          s := s + '</font>';
          FontList.Delete(1);
          OldFont.Free;
          OldFont := TFormatFont(FontList.items[0]);
          end;
        OldFont.Style := [];
        OldFont.Position := fpNormal;

        // Neuer Font-Tag erforderlich?
        if (OldFont.Name <> NewFont.Name) or
           (OldFont.Size <> NewFont.Size) then begin
          s := s + '<font';
          if (OldFont.Name <> NewFont.Name) then s := s + ' face="'+ NewFont.Name + '"';
          if (OldFont.Size <> NewFont.Size) then s := s + ' size=' + inttostr(NewFont.Size);
          s := s + '>';
          FontList.Add(TFormatFont.Create(NewFont));
          end;

        // Link-Tag ?
        if (OldFont.Tag <> NewFont.Tag) then
          if OldFont.Tag = 0 then begin       // öffnendes Link-Tag
            s := s + '<a href="' + LinkList[NewFont.Tag - 1] + '">';
            OldFont.Tag := NewFont.Tag;
            end
          else
            if NewFont.Tag = 0 then begin  // schließendes Link-Tag
              s := s + '</a>';
              OldFont.Tag := 0;
              end
            else
              MessageDlg('Zwei Links dürfen nicht direkt hintereinander stehen!',
                          mtError, [mbOk], 0);
        end;

      // Welche Tags müssen geschlossen werden ?
      if (OldFont.Position <> NewFont.Position) then begin
        if OldFont.Position = fpSup then s := s + CloseTag('sup');
        if OldFont.Position = fpSub then s := s + CloseTag('sub');
        end;
      if (fsBold      in OldFont.Style) and not(fsBold      in NewFont.Style) then s := s + CloseTag('b');
      if (fsUnderline in OldFont.Style) and not(fsUnderline in NewFont.Style) then s := s + CloseTag('u');
      if (fsItalic    in OldFont.Style) and not(fsItalic    in NewFont.Style) then s := s + CloseTag('i');
      // Welche Tags müssen geöffnet werden?
      if (fsItalic    in NewFont.Style) and not(fsItalic    in OldFont.Style) then s := s + AddTag('i');
      if (fsUnderline in NewFont.Style) and not(fsUnderline in OldFont.Style) then s := s + AddTag('u');
      if (fsBold      in NewFont.Style) and not(fsBold      in OldFont.Style) then s := s + AddTag('b');
      if (OldFont.Position <> NewFont.Position) then begin
        if NewFont.Position = fpSup then s := s + AddTag('sup');
        if NewFont.Position = fpSub then s := s + AddTag('sub');
        end;
      OldFont.Style    := NewFont.Style;
      OldFont.Position := NewFont.Position;

      // Text hinzufügen
      c := GetCharacter(j).getChar;
      case c of
        '<' : s := s + '&lt;';
        '>' : s := s + '&gt;';
        '&' : s := s + '&amp;';
        '"' : s := s + '&quot;';
        '¯' : s := s + '<hr>';
      else
        s := s + c;
      end;
      inc(j);
      end;
    // Close-Tags ans Ende der vorherigen Zeile verschieben
    if HTMLText.Count>0 then begin
      br := comparestr(copy(HTMLText.Strings[HTMLText.Count-1],
                       length(HTMLText.Strings[HTMLText.Count-1])-3,4),'<br>')=0;

      // <br> entfernen
      if br then
        HTMLText.Strings[HTMLText.Count-1] :=
          copy(HTMLText.Strings[HTMLText.Count-1], 1,
               length(HTMLText.Strings[HTMLText.Count-1])-4);

      // Tags verschieben
      while (length(s)>0) and (s[1]='<') and (s[2]='/') do
      begin
        t := copy(s,1,pos('>',s));
        s := copy(s,length(t)+1,Length(s));
        HTMLText.Strings[HTMLText.Count-1] :=
          HTMLText.Strings[HTMLText.Count-1] + t;
      end;

      // <br> wieder anhängen
      if br then
        HTMLText.Strings[HTMLText.Count-1] :=
          HTMLText.Strings[HTMLText.Count-1]+'<br>';
      end;
    HTMLText.Add(s);
    end;
  HTMLText.strings[HTMLText.Count-1] :=
    HTMLText.strings[HTMLText.Count-1] + '<br>';
  end;

// Bestimmenten Buchstaben zurückgeben
function TLine.GetCharacter(nr : integer) : TCharacter;
begin
  result := nil;
  if (nr>=0) and (nr<Characters) then
    result := TCharacter(FCharacters.Items[nr]);
end;

// Anzahl der Buchstaben in der Zeile
function TLine.Characters : integer;
begin
  result := FCharacters.Count;
end;

// Nummer des Buchstaben in bestimmter Position
// (relativ zur linken oberen Ecke der Zeile) ermitteln
function TLine.GetCharInPos(Pos : TPoint) : integer;
var x,y, i,j, Width : Integer;
begin
  if assigned(FCanvas) then
  begin
    i := 0;
    y := 0;
    // Richtige Anzeigezeile suchen
    while (i<FRowInfos.Count-1) and (y+TRowInfo(FRowInfos.items[i]).Height < Pos.y) do
    begin
      y := y + TRowInfo(FRowInfos.items[i]).Height;
      Inc(i);
    end;

    j := TRowInfo(FRowInfos.items[i]).first;
    // Passenden Buchstaben in der Anzeigezeile suchen
    x := 0;
    while (j< FCharacters.Count) and (j < TRowInfo(FRowInfos.items[i]).last) do
    begin
      Width := GetCharacter(j).GetWidth
               + ExtraBefore(j,TRowInfo(FRowInfos.items[i]).First)
               + ExtraAfter(j,TRowInfo(FRowInfos.items[i]).Last);
      if (x+Width< Pos.x) then x := x+Width
                          else break;
      Inc(j);
    end;
    // Cursor vor oder hinter dem Buchstaben positionieren?
    if (j<= TRowInfo(FRowInfos.items[i]).last) then
    begin
      Width := GetCharacter(j).GetWidth
               + ExtraBefore(j,TRowInfo(FRowInfos.items[i]).First)
               + ExtraAfter(j,TRowInfo(FRowInfos.items[i]).Last);
      if abs(x+Width-Pos.x) < abs(x-Pos.x) then Inc(j);
    end;
    result := j;
  end
  else result := 0;
end;

// Font von selektierte Buchstaben anpassen
procedure TLine.ChangeFont(Selection: TSelection; NewFont : TFormatFont; Change: TFontChanges);
var i,s,e : integer;
begin
  // Selektion in dieser Zeile?
  if (Selection.Start.y <= 0) and (Selection.Ende.y>=0) then
  begin
    // Startposition
    if (Selection.Start.y < 0) then s:=0 else s:= Selection.Start.x;
    // Endposition
    if (Selection.Ende.y > 0) then e:=Characters-1
    else
    begin
      e:=Selection.Ende.x-1;
      if e>Characters-1 then e:= Characters-1;
    end;

    for i := s to e do
    begin
      GetCharacter(i).ChangeFont(NewFont,Change);
    end;
    AdjustRowInfos;
  end;
end;

//---------------------------------------------------------
//
//                        FormatText
//
//---------------------------------------------------------


constructor TFormatText.Create(Lines : TStrings; f : TFont);
  begin
  inherited Create;
  FLinkList   := TStringList.Create;
  FHTMLText   := TStringList.Create;
  FPlainText  := TStringList.Create;
  Zeilen      := TList.Create;
  FCanvas     := nil;
  FClientRect := Rect(0,0,100,100);
  SetHTMLText(Lines, f);
  end;

constructor TFormatText.Create(Lines : TStrings; cl_rect : TRect; Canvas: TCanvas );
  begin
  inherited Create;
  FLinkList   := TStringList.Create;
  FHTMLText   := TStringList.Create;
  FPlainText  := TStringList.Create;
  Zeilen      := TList.Create;
  self.FCanvas:= Canvas;
  FClientRect := cl_rect;
  SetHTMLText(Lines);
  end;

destructor TFormatText.Destroy;
  var i : integer;
  begin
  if assigned(Zeilen) then begin
    for i:= Zeilen.Count-1 downto 0 do
      TLine(Zeilen.items[i]).Free;
    Zeilen.Free;
    end;
  FPlainText.free;
  FHTMLText.free;
  FLinkList.free;
  inherited;
  end;


function TFormatText.NewDisplayFactor: Double;
  var i, ch : Integer;
      f     : array[0..8] of extended;
  begin
  // DisplayFaktor mit Intervallschachtelung bestimmen
  ch := FClientRect.Bottom-FClientRect.Top;
  f[0]:=0.1;  // Minimaler Displayfaktor
  f[1]:=100;  // Maximaler Displayfaktor
  SetDisplayFactor(f[0]);
  f[3] := GetHeight;
  f[4] := GetWidth;
  SetDisplayFactor(f[1]);
  f[5] := GetHeight;
  f[6] := GetWidth;
  for i := 1 to 20 do begin  // 20 Intervalle
    if f[5] = f[3] then break;
    if ch<f[3] then break;
    f[2] := (f[0]+f[1]) / 2;
    SetDisplayFactor(f[2]);
    f[7] := GetHeight;
    f[8] := GetWidth;
    if (f[7] > FClientRect.Bottom-FClientRect.Top) or
       (f[8] > FClientRect.Right-FClientRect.Left) then begin
      f[1]:=f[2]; f[5]:=f[7]; f[6]:=f[8];
      end
    else begin
      f[0]:=f[2]; f[3]:=f[7]; f[4]:=f[8];
      end
    end;
  // Den kleineren Displayfaktor benutzen, damit es auf jeden Fall passt
  Result := f[0];
  end;

procedure TFormatText.Paint(FitToClientRect : Boolean = FALSE);
  var s : TSelection;
  begin
  s.start.x := -1;
  s.Start.y := -1;
  s.Ende.x  := -1;
  s.Ende.y  := -1;
  Paint(s, FClientRect, FitToClientRect);
  end;

procedure TFormatText.Paint(ClipRect : TRect; FitToClientRect : Boolean = FALSE);
  var s : TSelection;
  begin
  s.start.x := -1;
  s.Start.y := -1;
  s.Ende.x  := -1;
  s.Ende.y  := -1;
  Paint(s, ClipRect, FitToClientRect);
  end;


procedure TFormatText.Paint(Selection : TSelection; ClipRect : TRect; FitToClientRect : Boolean = FALSE);
  var i      : integer;
      aktPos : TPoint;
      r      : TRect;
  begin
  if assigned(FCanvas) then begin
    // An ClientRect anpassen
    if FitToClientRect then
      SetDisplayFactor(NewDisplayFactor);

    FCanvas.Brush.Color := Colortorgb(FCanvas.Brush.Color);
    aktPos := FClientRect.TopLeft;
    // alle Zeilen zeichnen
    for i := 0 to Zeilen.Count-1 do begin
      TLine(Zeilen.Items[i]).Paint(aktPos,ClipRect,Selection);
      aktPos.y := aktPos.y + TLine(Zeilen.Items[i]).GetHeight;
      Dec(Selection.Start.y); Dec(Selection.Ende.y);
      end;
    r.TopLeft := aktPos;
    r.BottomRight := FClientRect.BottomRight;
    FCanvas.FillRect(Clip(r,ClipRect));

    // DisplayFaktor wieder zurückstellen
    if FitToClientRect then
      SetDisplayFactor(1.0);
    end;
  end;

procedure TFormatText.PaintTransparent(ClipRect : TRect; col : TColor; FitToClientRect : Boolean = FALSE);
  var i      : integer;
      aktPos : TPoint;
      r      : TRect;
  begin
  if assigned(FCanvas) then begin
    // An ClientRect anpassen
    If FitToClientRect then
      SetDisplayFactor(NewDisplayFactor);

    With FCanvas do begin
      If TextFlags and ETO_OPAQUE > 0 then
        TextFlags := TextFlags - ETO_OPAQUE;
      Brush.Style := bsClear;
      end;
    aktPos := FClientRect.TopLeft;
    // alle Zeilen zeichnen
    for i := 0 to Zeilen.Count-1 do begin
      TLine(Zeilen.Items[i]).PaintTransparent(aktPos,ClipRect,col);
      aktPos.y := aktPos.y + TLine(Zeilen.Items[i]).GetHeight;
      end;
    r.TopLeft := aktPos;
    r.BottomRight := FClientRect.BottomRight;

    // DisplayFaktor wieder zurückstellen
    SetDisplayFactor(1.0);
    end;
  end;


// DisplayFaktor in allen Zeilen setzen
procedure TFormatText.SetDisplayFactor(f : extended);
  var i : integer;
  begin
  for i := 0 to Zeilen.Count-1 do
    GetLine(i).SetDisplayFactor(f);
  end;

// Neuen Canvas in allen Zeilen setzen
procedure TFormatText.SetCanvas(c : TCanvas);
  var i : integer;
  begin
  FCanvas := c;
  for i := 0 to Zeilen.Count-1 do
    GetLine(i).SetCanvas(c);
  end;

procedure TFormatText.SetClientRect(cl_rect : TRect);
  var i : integer;
  begin
  // Hat sich die Breite geändert? Dann alle Zeilen davon benachrichtigen
  if (FClientRect.right-FClientRect.left <> cl_rect.right-cl_rect.left) then
    for i := 0 to Zeilen.Count-1 do
      TLine(Zeilen.items[i]).SetMaxWidth(cl_rect.right-cl_rect.left);
  FClientRect := cl_rect;
  end;

procedure TFormatText.SetClientTop(i: integer);
  var r : TRect;
  begin
  r := FClientRect;
  r.Top := i;
  SetClientRect(r);
  end;

procedure TFormatText.SetClientLeft(i: integer);
  var r : TRect;
  begin
  r := FClientRect;
  r.Left := i;
  SetClientRect(r);
  end;

procedure TFormatText.SetClientRight(i: integer);
  var r : TRect;
  begin
  r := FClientRect;
  r.Right := i;
  SetClientRect(r);
  end;

// Größe des Textes
function TFormatText.GetSize : TSize;
  var t:TSize;
  begin
  t.cx := GetWidth;
  t.cy := GetHeight;
  result := t;
  end;

function TFormatText.GetWidth: integer;
  var i,cx: integer;
  begin
  cx := 0;
  for i := 0 to Zeilen.Count-1 do
    if cx < TLine(Zeilen.Items[i]).getWidth then
      cx := TLine(Zeilen.Items[i]).getWidth;
  result := cx;
  end;

function TFormatText.GetHeight: integer;
  var i,cy : integer;
  begin
  cy := 0;
  for i := 0 to Zeilen.Count-1 do
    cy := cy + TLine(Zeilen.Items[i]).getHeight;
  result := cy;
  end;


// Buchstaben an einer bestimmten Position ermitteln
function TFormatText.GetCharacter(Pos : TPoint) : TCharacter;
  var z : TLine;
  begin
  z := GetLine(Pos.y);
  if z <> nil then
    result := z.GetCharacter(Pos.x)
  else
    result := Nil;
  end;


// Position eines Buchstabens ermitteln
function TFormatText.GetCharPosition(Pos: TPoint):TRect;
  var i, y : Integer;
      r    : TRect;
  begin
  if assigned(FCanvas) then begin
    // Höhe der Zeilen vor diesem Buchstaben
    y := FClientRect.top;
    i := 0;
    while i < Pos.y do begin
      inc(y,TLine(Zeilen.Items[i]).GetHeight);
      inc(i);
      end;
    // Position des Buchstabens in der Zeile
    r := TLine(Zeilen.Items[i]).GetCharPosition(Pos.x);
    Inc(r.Top,y);
    Inc(r.Bottom,y);
    Inc(r.Left,FClientRect.Left);
    Inc(r.Right,FClientRect.Left);
    end
  else
    r := Rect(0,0,10,20);
  result := r;
  end;

// Ermitteln des Buchstabens an einer bestimmten Fenster-Koordinate
function TFormatText.GetCharInPos(Pos : TPoint) : TPoint;
  var y, i : Integer;
  begin
  if assigned(FCanvas) then begin
    i := 0;
    y := 0;
    // In welcher Zeile liegt die Koordinate?
    while (i <= Zeilen.Count-1) and
          (y + GetLine(i).GetHeight < Pos.y) do begin
      y := y + GetLine(i).GetHeight;
      Inc(i);
      end;
    // Buchstabe liegt in keiner Zeile
    if Pos.y <= 0 then
      result := Point(0,0)
    else
      if (i = Zeilen.Count) then
        result := Point(GetLine(i-1).Characters,i-1)
      else
        // Welcher Buchstabe dieser Zeile ist es?
        result := Point(GetLine(i).GetCharInPos(Point(Pos.x,Pos.y-y)),i);
    end
  else
    result := Point(0,0);
  end;

// Font eines Buchstaben bestimmen
function TFormatText.GetCharFont(Pos : TPoint) : TFormatFont;
  begin
  if (Pos.y >=0 ) and (Pos.y < Zeilen.Count) then  // gültige Zeilennummer
    result := GetLine(Pos.y).GetCharFont(Pos.x)
  else
    result := nil;
  end;


// Bestimmte Zeile ermitteln
function TFormatText.GetLine(i : Integer) : TLine;
  begin
  result := nil;
  if (i>=0) and (i<=Zeilen.Count-1) then
    result := TLine(Zeilen.items[i]);
  end;

// Anzahl der Zeilen
function TFormatText.Lines : integer;
  begin
  Result := Zeilen.Count;
  end;

// Anzahl der Buchstaben in einer bestimmten Zeile
function TFormatText.CharactersInLine(i : integer) : integer;
  var z : TLine;
  begin
  z := GetLine(i);
  if z = nil then
    Result := 0
  else
    Result := z.Characters;
  end;

function TFormatText.GetLinkAddress(linkTag : Integer) : String;
  begin
  If (linkTag > 0) and (linkTag <= FLinkList.Count) then
    Result := FLinkList[Pred(linkTag)]
  else
    Result := '';
  end;

function TFormatText.IsEmpty: Boolean;
  var n, i : Integer;
  begin
  n := 0;
  i := 0;
  While (n = 0) and (i < Lines) do begin
    n := CharactersInLine(i);
    i := i + 1;
    end;
  Result := n = 0;
  end;

// Einfügen eines neuen Buchstaben an einer bestimmten Position
procedure TFormatText.Insert(Pos : TPoint; b : TCharacter);
  var z : TLine;
  begin
  Z := GetLine(Pos.y);
  if z<>nil then
    z.insert(Pos.x, b);
  end;

// Einfügen eines neuen Bustabens mit einem bestimmten Font an einer Position
procedure TFormatText.Insert(Pos : TPoint; c : char; f : TFormatFont);
  var b : TCharacter;
  begin
  b := TCharacter.Create(c, f, FCanvas);
  Insert(Pos, b);
  end;

// Einfügen eines unformatierten Textes an einer Position
function TFormatText.InsertPlainText(IPos : TPoint; ustr : String) : TPoint;
  var af : TFormatFont;
      i  : Integer;
  begin
  af := TFormatFont.Create(GetCharFont(IPos));
  For i := 1 to Length(ustr) do begin
    Insert(IPos, ustr[i], af);
    IPos.X := IPos.X + 1;
    end;
  af.Free;
  Result := IPos;
  end;

// Einfügen eines formatierten HTML-Textes an einer Position
function TFormatText.InsertHTMLText(IPos : TPoint; fstr : String): TPoint;
  var af : TFormatFont;
      fl : TFormatFontStack;
      ic : Char;
      e  : Integer;
  begin
  af := TFormatFont.Create(GetCharFont(IPos));
  fl := TFormatFontStack.Create;
  While Length(fstr) > 0 do
    Case fstr[1] of
      '<' :  If Pos('<BR>', upperCase(fstr)) = 1 then begin  { Zeilenumbruch }
               Separate(IPos);
               System.Delete(fstr, 1, 4);
               IPos.Y := IPos.Y + 1;
               IPos.X := 0;
               end
             else if Pos('<HR>', upperCase(fstr)) = 1 then begin    { Absatz }
               if IPos.X > 0 then begin  { nur falls nötig: neue Zeile }
                 Separate(IPos);
                 IPos.Y := IPos.Y + 1;
                 IPos.X := 0;
                 end;
               ic := '¯';                { Steuerzeichen für "<HR>": Macron  }
               Insert(IPos, ic, af);
               IPos.X := IPos.X + 1;
               Separate(IPos);           { danach immer neue Zeile ! }
               System.Delete(fstr, 1, 4);
               IPos.Y := IPos.Y + 1;
               IPos.X := 0;
               end
             else begin                                      { Anderes Tag ? }
               e := Pos('>', fstr);
               If (e > 1) and
                  af.AdjustFontData(Copy(fstr, 2, e-2), fl) then      { Ja ! }
                 System.Delete(fstr, 1, e)
               else begin                                           { Nein ! }
                 Insert(IPos, fstr[1], af);
                 System.Delete(fstr, 1, 1);
                 IPos.X := IPos.X + 1;
                 end;
               end;
      '&' :  begin                                           { Sonderzeichen }
             e := Pos(';', fstr);
             If e > 1 then begin
               ic := HTMLSpecialChar(Copy(fstr, 2, e-2));
               If ic <> ' ' then begin
                 Insert(IPos, ic, af);
                 System.Delete(fstr, 1, e);
                 IPos.X := IPos.X + 1;
                 end
               else begin
                 ic := '&';
                 Insert(IPos, ic, af);
                 System.Delete(fstr, 1, 1);
                 IPos.X := IPos.X + 1;
                 end
               end
             else begin
               ic := '&';
               Insert(IPos, ic, af);
               System.Delete(fstr, 1, 1);
               IPos.X := IPos.X + 1;
               end;
             end;
    else
      Insert(IPos, fstr[1], af);
      System.Delete(fstr, 1, 1);
      IPos.X := IPos.X + 1;
    end;
  fl.Free;
  af.Free;
  Result := IPos;
  end;

// Löschen eines Buchstaben
procedure TFormatText.Delete(Pos : TPoint);
  var b : TCharacter;
      l : TLine;
  begin
  b := GetCharacter(Pos);
  l := GetLine(Pos.y);
  if b <> nil then begin
    l.FCharacters.delete(Pos.x);
    b.free;
    l.AdjustRowInfos;
    end
  else
    if (l <> Nil) then begin
      if (Pos.X >= 0) and
         (Pos.X < l.FCharacters.Count) then
        l.FCharacters.delete(Pos.x);
      l.AdjustRowInfos;
      end;
  end;

// Eine Zeile in zwei Zeilen aufspalten
procedure TFormatText.Separate(Pos : TPoint);
  var l1,l2 : TLine;
      i : integer;
  begin
  // Alte Zeile
  l1 := GetLine(Pos.y);

  // Neue Zeile vorbereiten
  if assigned(FCanvas) then
    l2 := TLine.Create('', nil, nil, FClientRect.right-FClientRect.left,FCanvas)
  else
    l2 := TLine.Create('', nil, nil);
  Zeilen.Insert(Pos.y+1,l2);

  // Alle Buchstaben ab der angegeben Position in die neue Zeile verschieben
  for i := CharactersInLine(Pos.y)-1 downto Pos.x do begin
    l2.FCharacters.insert(0, l1.GetCharacter(i));
    l1.FCharacters.delete(i);
    end;
  l1.AdjustRowInfos;
  l2.AdjustRowInfos;
  end;

// Zwei aufeinanderfolgende Zeilen zu einer vereinigen
procedure TFormatText.Merge(i : integer);
  var l1,l2 : TLine;
      j : integer;
  begin
  l1 := GetLine(i);
  l2 := GetLine(i+1);

  If l2 <> Nil then begin
    // Buchstaben der 2. Zeile an 1. anhängen
    for j := 0 to CharactersInLine(i+1)-1 do
      l1.FCharacters.add(l2.GetCharacter(j));
    l1.AdjustRowInfos;

    // 2. Zeile löschen
    for j := l2.FCharacters.count-1 downto 0 do
      l2.FCharacters.delete(j);
    Zeilen.delete(i+1);
    l2.Free;
    end;
  end;

// Ändern des Fonts der selektierten Zeichen
procedure TFormatText.ChangeFont(Selection: TSelection;  NewFont : TFormatFont; Change: TFontChanges);
  var i : integer;
  begin
  for i := 0 to Zeilen.Count-1 do begin
    GetLine(i).ChangeFont(Selection, NewFont, Change);
    // Da die Zeilen nicht wissen, die wievielte sie sind
    // wird die y-Position verändert. Ist dann y = 0 handelt es
    // sich um die richtige Zeile
    Dec(Selection.Start.y);
    Dec(Selection.Ende.y);
    end;
  end;


function TFormatText.GetText : TStrings;
  var i : integer;
  begin
  for i:= FPlainText.Count-1 downto 0 do
    FPlainText.delete(i);
  for i := 0 to Zeilen.Count-1 do
    FPlainText.add(GetLine(i).GetText);
  Result := FPlainText;
  end;

function TFormatText.GetHTMLText(DefaultFont: TFont) : TStrings;
  var i : integer;
      FontList : TList;
      TagList : TStrings;
  begin
  // Alten HTML-Text löschen
  for i:= FHTMLText.Count-1 downto 0 do
    FHTMLText.delete(i);

  // Standardfont vorgeben
  FontList := TList.Create;
  TagList  := TStringList.Create;
  FontList.Add(TFormatFont.Create(DefaultFont));
  // Styletags sollen auf jeden Fall eingefügt werden
  TFormatFont(FontList.items[0]).Style := [];
  // Jede Zeile abfragen
  for i := 0 to Zeilen.Count-1 do
    GetLine(i).GetHTMLText(FHTMLText, FontList, TagList, FLinkList);

  // <br> in der letzten Zeile entfernen
  FHTMLText.strings[FHTMLText.Count-1]:=
    copy(FHTMLText.strings[FHTMLText.Count-1], 1,
         length(FHTMLText.strings[FHTMLText.Count-1])-4);

  // noch offene Tags schließen
  for i := TagList.Count-1 downto 0 do
    FHTMLText.Strings[FHTMLText.Count-1] :=
      FHTMLText.Strings[FHTMLText.Count-1] + TagList.Strings[i];
  TagList.Free;

  // ggf. offnen Font-Tag schließen
  if FontList.Count=2 then begin
    FHTMLText.Strings[FHTMLText.Count-1] := FHTMLText.Strings[FHTMLText.Count-1] + '</font>';
    TFormatFont(FontList.items[1]).Free;
    end;
  TFormatFont(FontList.items[0]).Free;
  FontList.Free;
  Result := FHTMLText;
  end;

procedure TFormatText.SetHTMLText(Lines : TStrings);
  begin
  If Assigned(FCanvas) then
    SetHTMLText(Lines, FCanvas.Font)
  else
    SetHTMLText(Lines, Nil);
  end;

procedure TFormatText.SetHTMLText(Lines : TStrings; DefaultFont : TFont);
  var i        : Integer;
      f        : TFormatFont;
      FontList : TList;
      Zeile, s : String;

  begin
  for i:= Zeilen.Count-1 downto 0 do begin  // Alte Zeilen löschen
    TLine(Zeilen.items[i]).Free;
    Zeilen.delete(i);
    end;

  // Einen großen String erzeugen, da die Softbreaks keine Rolle spielen
  s:= '';
  if Lines <> nil then
    for i := 0 to Lines.Count-1 do
      s := s + Lines.Strings[i];

  // Standardfont auswählen
  If Assigned(DefaultFont) then
    f := TFormatFont.Create(DefaultFont)
  else
    f := TFormatFont.Create;
  FontList := TList.Create;
  FontList.add(f);

  // Wenn kein Text vorhanden: eine Leerzeile erzeugen,
  // damit man etwas eingeben kann
  if length(s)=0 then begin
    if assigned(FCanvas) then
      Zeilen.add(TLine.Create('', FontList, nil,
                              FClientRect.right-FClientRect.left, FCanvas))
    else
      Zeilen.add(TLine.Create('', FontList, nil));
    end
  else
    while length(s) > 0 do begin // Hardbreak suchen
      i := pos('<BR>',uppercase(s));
      if i>0 then begin          // Zeile erzeugen
        Zeile := copy(s,1,i-1);
        if assigned(FCanvas) then
          Zeilen.add(TLine.Create(Zeile, FontList, FLinkList,
                                  FClientRect.right-FClientRect.left, FCanvas))
        else
          Zeilen.add(TLine.Create(Zeile,FontList, FLinkList));
        s := copy(s,i+4,length(s));
        end
      else begin                 // Letzte Zeile ohne <br>
        try
          Zeilen.add(TLine.Create(s, FontList, FLinkList,
                                  FClientRect.right-FClientRect.left, FCanvas))
        except
          Zeilen.add(TLine.Create(s, FontList, FLinkList));
        end;
        s := '';
        end;
      end;
  for i:= FontList.count-1 to 0 do
    TFormatFont(FontList.items[i]).Free;
  FontList.Free;
  end;



end.
