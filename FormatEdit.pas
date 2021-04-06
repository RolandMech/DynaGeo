unit FormatEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Clipbrd, FormatText, extctrls;

type
  TFontChangeEvent = procedure (Sender : TObject; Font : TFormatFont) of object;


  TFormatEdit = class(TCustomControl)
  private
    { Private-Deklarationen }
    FWordWrap       : Boolean;
    FWantReturns    : Boolean;
    FEditEnabled    : Boolean;
    FHTMLText       : TStrings;
    FAktFont        : TFormatFont;
    FAktCursorPos   : TPoint;
    FActLinkIndex   : Integer;  { enthält die Nummer (> 0) des aktuellen Links }
    FVScrollBar,                {         oder 0, falls kein Link aktiv ist.   }
    FHScrollBar     : boolean;
    FOnFontChange   : TFontChangeEvent;
    FOnChange       : TNotifyEvent;
    procedure React(Key: Word; Shift: TShiftState; x : integer = 0; y : integer =0);
    procedure DeleteSelectedChars;
    function  CharsSelected : boolean;
    procedure AdjustScrollBar;

    procedure SetScrollBars(Style : TScrollStyle);
    function  GetScrollBars : TScrollStyle;
    procedure SetWordWrap(b : Boolean);

    function  GetHTMLText: TStrings;
    function  GetHTMLTextAsString: String;
    function  GetPlainText: TStrings;
    function  GetSelPlainText: TStrings;
    procedure SetHTMLText(Lines: TStrings);
    procedure SetHTMLTextFromString(newText: String);

    function  GetDefaultFont: TFont;
    procedure SetDefaultFont(f : TFont);
    procedure SetActFont(newFont: TFont); overload;
    procedure SetActFont(newFont: TFormatFont); overload;
    procedure SetAktCursorPos(ncp: TPoint);
    procedure SetEditEnabled(newVal: Boolean);


  protected
    { Protected-Deklarationen }
    OldSelectedPos,
    SelectedPos   : TSelection;
    StartSelection: TPoint;
    CursorTimer   : TTimer;
    CursorCount   : Integer;
    CursorVisible : Boolean;
    CursorLastPos : TPoint;
    TopLeft       : TPoint;
    MaxTopLeft    : TPoint;
    ShowText      : TFormatText;
    procedure Paint; override;
    procedure ShowCursor(b: Boolean);
    procedure CreateWnd; override;
    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMHScroll(var Message: TWMVScroll); message WM_HSCROLL;
    procedure Resize; override;
    procedure Loaded; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure HideSelection;
    procedure ShowSelection;
    procedure SetSelection(Sel: TSelection);
    procedure SelectionChangeFont(Change : TFontChanges);
    procedure CreateParams(var Params: TCreateParams); override;

  public
    { Public-Deklarationen }
    property Canvas;
    property PlainText: TStrings read GetPlainText;
    property SelPlainText: TStrings read GetSelPlainText;
    property HTMLTextAsString: String read GetHTMLTextAsString write SetHTMLTextFromString;
    property ActFont: TFormatFont read FAktFont;
    property ActCursorPos: TPoint read FAktCursorPos write SetAktCursorPos;
    property ActSelection: TSelection read SelectedPos write SetSelection;

    constructor Create(Owner : TComponent); override;
    destructor  Destroy; override;

    function  GetCharFont(Pos: TPoint): TFormatFont;
    procedure SetTag (i : integer);
    procedure SetBold (b: boolean);
    procedure SetItalic (b: boolean);
    procedure SetUnderline (b: boolean);
    procedure SetSup (b: boolean);
    procedure SetSub (b: boolean);
    procedure SetSize(i: integer);
    procedure SetFontName (n : TFontName);
    procedure SetFont(f: TFont);  overload;
    procedure SetFont(f: TFormatFont); overload;
    procedure SelectActualLine;
    procedure RevokeActSelection;
    procedure Clear;
    procedure Cut;

    function  CopyToClipboard : Boolean;
    function  InsertFromClipboard : Boolean;
    procedure Paste(fs: String);
    procedure LoadBMPDataInto(BMP: TBitMap);
    function  LineLength(nr: Integer): Integer;
    function  GetTextExtent: TPoint;
    function  LineCount: Integer;
    function  Dist2Bottom: Integer;
    function  IsEmpty: Boolean;
    function  GetHTMLTextLine(nr: Integer): String;
    function  GetPlainASCIITextLine(nr: Integer): String;
    function  GetHTMLLinkAt(acp: TPoint): String;
    function  InsertHTMLLinkAt(acp: TPoint; linktext, adress: String): Boolean;
    function  InsertHTMLTextAt(acp: TPoint; newText: String): Boolean;

  published
    { Published-Deklarationen }
    // geerbte Eigenschaften
    property Color default clWindow;
    property Cursor default crIBeam;
    property ParentColor;
    property TabStop default true;
    property TabOrder;
    // Neue Eigenschaften
    property DefaultFont: TFont read GetDefaultFont write SetDefaultFont;
    property ScrollBars: TScrollStyle read GetScrollBars write SetScrollBars default ssVertical;
    property Text: TStrings read GetHTMLText write SetHTMLText stored True;
    property WantReturns: Boolean read FWantReturns write FWantReturns default true;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default true;
    property EditEnabled: Boolean read FEditEnabled write SetEditEnabled default true;

    // Geerbte Ereignisse
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    // Neue Ereignisse
    property OnFontChange:TFontChangeEvent read FOnFontChange write FOnFontChange;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  end;

procedure Register;

implementation

//-------------------------------------------------------
//
//             Hilfsprozeduren
//
//-------------------------------------------------------

procedure Register;
  begin
  RegisterComponents('DynaGeoCustomComponents', [TFormatEdit]);
  end;


//-----------------------------------------------------
//
//            Allgemeines Fensterhandling
//
//-----------------------------------------------------

constructor TFormatEdit.Create(Owner: TComponent);
  begin
  inherited Create(Owner);

  // Fenster mit 3D-Rahmen erzeugen
  ControlStyle := ControlStyle + [csFramed, csOpaque];

  // Standardwerte
  ParentColor   := False;
  TabStop       := True;
  Color         := clWindow;
  Font          := DefaultFont;

  FWantReturns  := True;
  FWordWrap     := True;
  FEditEnabled  := True;
  FHScrollBar   := False;
  FVScrollBar   := True;

  FOnFontChange := nil;
  FOnChange     := nil;

  FAktCursorPos := Point(0,0); // Cursor auf die Nullposition
  CursorVisible := False;      // Cursor wird gerade nicht gezeigt

  SelectedPos.Start.y := -1;   // Keine Selektierung
  SelectedPos.Start.x := -1;
  SelectedPos.Ende.y  := -1;
  SelectedPos.Ende.x  := -1;

  TopLeft    := Point(0,0); // ScrollPosition
  MaxTopLeft := Point(0,0); // Maximale ScrollPosition

  FHTMLText := TStringList.Create;
  ShowText  := TFormatText.Create(nil, Font); // zunächst leeren Text erzeugen
  end;

destructor TFormatEdit.Destroy;
  begin
  ShowText.Free;
  FHTMLText.Free;
  FAktFont.Free;
  inherited Destroy;
  end;

procedure TFormatEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
  begin
  // Cursortasten und Buchstaben werden von FormatEdit verarbeitet
  Message.Result := DLGC_WANTARROWS + DLGC_WANTCHARS;
  end;

procedure TFormatEdit.CreateParams(var Params: TCreateParams);
  begin
  inherited CreateParams(Params);
  // Fenster gegebenfalls mit Scrollbars ausstatten
  with Params do begin
    if FVScrollBar then
      Style := Style or WS_VSCROLL;
    if FHScrollBar then
      Style := Style or WS_HSCROLL;
    end;
  end;

procedure TFormatEdit.CreateWnd;
  begin
  inherited;
  SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE)
    or WS_CLIPSIBLINGS);
  // Jetzt ist Canvas verfügbar
  ShowText.Canvas := Canvas;
  end;

procedure TFormatEdit.Loaded;
  begin
  inherited;
  // Startwerte aus Laufzeitdefintion sind nun geladen,
  // Text und Font können gesetzt werden
  FAktFont := TFormatFont.Create(Canvas.Font);
  if assigned(FOnFontChange) then
    FOnFontChange(self,FAktFont);
  SetHTMLText(FHTMLText);
  end;


procedure TFormatEdit.Resize;
  var cl_rect : TRect;
  begin
  inherited;
  // Größe muss angepasst werden
  cl_rect := ClientRect;
  // Platz für 3D-Rahmen lassen
  InflateRect(cl_rect,-1,-1);
  if not FWordWrap then
    cl_rect.right := 32000;
  ShowText.SetClientRect(cl_rect);
  AdjustScrollBar;
  end;

// Anpassen der Scrollbars
procedure TFormatEdit.AdjustScrollBar;
  var cl_rect : TRect;
      h       : integer;
  begin
  // Maximale x-Koordinate (für Scrollbar)
  // Bei automatischem Umbruch kein horizontales Scrollen
  if not FWordWrap then begin
    MaxTopLeft.x := ShowText.GetWidth-ClientWidth+5;
    if MaxTopLeft.x < 0 then
      MaxTopLeft.x := 0;
    end
  else
    MaxTopLeft.x := 0;
  if FHScrollBar then
    SetScrollRange(Handle, SB_HORZ, 0, MaxTopLeft.x, True);

  h := ShowText.GetHeight-ClientHeight+2;
  if h < 0 then
    h := 0;
  // Nur dann eine Änderung der Scrollrange durchführen,
  // wenn sie sich wirklich geändert hat, da jede Änderung
  // zum Ein/Ausblenden des Scrollbars führen kann und damit
  // weitergehende Änderungen nach sich zieht
  if MaxTopLeft.y <> h then begin
    // Wegen neuer Breite (Scrollbar sichtbar/unsichtbar) ClientRect neu setzen
    if (h=0) or (MaxTopLeft.y = 0) then begin
      if FVScrollBar then
        SetScrollRange(Handle, SB_VERT, 0, h, True);
      cl_rect := ClientRect;
      InflateRect(cl_rect,-1,-1);
      cl_rect.Top := cl_rect.Top-TopLeft.y;
      cl_rect.Left := cl_rect.Left-TopLeft.x;
      if not FWordWrap then
        cl_rect.Right := 32000;
      ShowText.SetClientRect(cl_rect);
      // Veränderte Breite hat eine veränderte Höhe zur Folge
      h := ShowText.GetHeight-ClientHeight+2;
      if h < 0 then
        h := 0;
      end;
    MaxTopLeft.y:=h;
    if FVScrollBar then
      SetScrollRange(Handle, SB_VERT, 0, MaxTopLeft.y, True);
    end;
  end;


// --------------------------------------------------
//
//      Interne Hilfsmethoden
//
// --------------------------------------------------


function TFormatEdit.Dist2Bottom : Integer;
  begin
  Result := ClientHeight - ShowText.GetHeight;
  end;

// SetActFont
procedure TFormatEdit.SetActFont(newFont: TFont);
  begin
  If Assigned(newFont) then
    FAktFont.Assign(newFont)
  else
    FAktFont.Assign(DefaultFont);
  end;

procedure TFormatEdit.SetActFont(newFont: TFormatFont);
  begin
  If Assigned(newFont) then
    FAktFont.Assign(newFont)
  else
    FAktFont.Assign(DefaultFont);
  end;


// --------------------------------------------------
//
//        Reaktion auf Fensternachrichten
//
//        SetFocus, KillFocus, HScroll, VScroll
//
// --------------------------------------------------


procedure TFormatEdit.WMSetFocus(var Message: TWMSetFocus);
  begin
  // Blinkenden Cursor aktivieren
  SetTimer(Handle, 101, 350, nil);
  CursorCount := 1;
  ShowCursor(true);
  inherited;
  end;

procedure TFormatEdit.WMKillFocus(var Message: TWMKillFocus);
  begin
  // Blinkenden Cursor deaktivieren
  KillTimer(Handle, 101);
  CursorCount := 0;
  ShowCursor(false);
  inherited;
  end;

procedure TFormatEdit.WMTimer(var Message: TWMTimer);
  begin
  // Blinkenden Cursor (kurz (350ms) an, lang (700 ms) aus)
  CursorCount := CursorCount + 1;
  if CursorCount = 3 then
    CursorCount := 0;
  ShowCursor(CursorCount=0);
  end;

procedure TFormatEdit.WMVScroll(var Message: TWMVScroll);
  var NewTopLine: Integer;
  begin
  inherited;
  ShowCursor(false);
  // Neue ScrollPosition berechnen
  NewTopLine := TopLeft.y;
  case Message.ScrollCode of
    SB_LINEDOWN: Inc(NewTopLine,10);
    SB_LINEUP: Dec(NewTopLine,10);
    SB_PAGEDOWN: Inc(NewTopLine,ClientRect.Bottom div 3);
    SB_PAGEUP: Dec(NewTopLine,ClientRect.Bottom div 3);
    SB_THUMBPOSITION, SB_THUMBTRACK: NewTopLine := Message.Pos;
  end;
  // Grenzen einhalten
  if NewTopLine < 0 then
    NewTopLine := 0;
  if NewTopLine > MaxTopLeft.y then
    NewTopLine := MaxTopLeft.y;
  // Vertikalen ScrollBar anpassen
  TopLeft.y := NewTopLine;
  if FVScrollBar then
    SetScrollPos(Handle,SB_VERT,NewTopLine,True);
  // Verschiebung durch Verändern des ClientRect realisieren
  ShowText.SetClientTop(1-NewTopLine);
  Invalidate;
  end;

procedure TFormatEdit.WMHScroll(var Message: TWMVScroll);
  var NewTopLine: Integer;
  begin
  inherited;
  ShowCursor(false);
  // Neue ScrollPosition berechnen
  NewTopLine := TopLeft.x;
  case Message.ScrollCode of
    SB_LINEDOWN: Inc(NewTopLine,10);
    SB_LINEUP: Dec(NewTopLine,10);
    SB_PAGEDOWN: Inc(NewTopLine,ClientRect.Right div 3);
    SB_PAGEUP: Dec(NewTopLine,ClientRect.Right div 3);
    SB_THUMBPOSITION, SB_THUMBTRACK: NewTopLine := Message.Pos;
  end;
  // Grenzen einhalten
  if NewTopLine < 0 then
    NewTopLine := 0;
  if NewTopLine > MaxTopLeft.x then
    NewTopLine := MaxTopLeft.x;
  // Horizontalen ScrollBar anpassen
  TopLeft.x := NewTopLine;
  if FHScrollBar then
    SetScrollPos(Handle,SB_HORZ,NewTopLine,True);
  // Verschiebung durch Verändern des ClientRect realisieren
  ShowText.SetClientLeft(1-NewTopLine);
  Invalidate;
  end;

// ---------------------------------------------------------
//
//             Zeichenfunktionen
//
// ---------------------------------------------------------

procedure TFormatEdit.Paint;
  var Border : TRect;
  begin
  inherited;
  ShowCursor(false);
  // 3D-Rahmen zeichnen
  Border := ClientRect;
  Canvas.Brush.Color := Color;
  if csFramed in ControlStyle then
    Frame3D(Canvas,Border,cl3DDkShadow,cl3DLight,1)
  else
    Frame3D(Canvas,Border,clBlack,clBlack,1);
  // Text ausgeben
  if assigned(ShowText) then
    ShowText.Paint(SelectedPos,Border);
  if Focused then
    ShowCursor(CursorCount = 0);
  end;


procedure TFormatEdit.ShowCursor(b : Boolean);
  var char_pos : TRect;
      newSize  : Integer;
  begin
  if (b <> CursorVisible) and assigned(ShowText) then begin
    char_pos := ShowText.GetCharPosition(ActCursorPos);
    If char_pos.Right = char_pos.Left then begin
      newSize := Round(ActFont.Size * DefaultFont.PixelsPerInch / 72);
      If char_pos.Bottom - char_pos.Top < newSize then
        char_pos.Bottom := char_pos.Top + newSize;
      end;
    // Cursor immer invers darstellen
    Canvas.Pen.Mode := pmXOR;
    Canvas.Pen.Color := clWhite;
    // Grenzen des Fensters einhalten
    if (char_pos.top < 1) and (char_pos.bottom>=1) then
      char_pos.top := 1;
    if (char_pos.bottom > ClientHeight-1) and
       (char_pos.top < ClientHeight-1) then
      char_pos.bottom := ClientHeight-1;
    // Dicke Linie zeichnen
    Canvas.MoveTo(char_pos.left, char_pos.top);
    Canvas.LineTo(char_pos.left, char_pos.bottom);
    Canvas.MoveTo(char_pos.left+1, char_pos.top);
    Canvas.LineTo(char_pos.left+1, char_pos.bottom);
    // Standardmodus
    Canvas.Pen.Mode := pmCopy;
    CursorVisible := b;
    end;
  end;

procedure TFormatEdit.HideSelection;
  begin
  If (SelectedPos.Start.X <> -1) or
     (SelectedPos.Ende.X  <> -1) then begin
    OldSelectedPos := SelectedPos;
    SelectedPos.Start := Point(-1, -1);
    SelectedPos.Ende  := Point(-1, -1);
    ShowCursor(False);
    Repaint;
    end;
  end;

procedure TFormatEdit.ShowSelection;
  begin
  If (OldSelectedPos.Start.X <> -1) or
     (OldSelectedPos.Ende.X  <> -1) then begin
    SelectedPos := OldSelectedPos;
    ShowCursor(True);
    Repaint;
    end;
  end;

// -------------------------------------------------------
//
//                  Eingaberoutinen
//
// -------------------------------------------------------

// Sind Buchstaben selektiert ?
function TFormatEdit.CharsSelected : boolean;
  var b : boolean;
  begin
  b := (SelectedPos.Start.y <> -1) and (SelectedPos.Ende.y <> -1);
  if b then
    b := (SelectedPos.Start.y <> SelectedPos.Ende.y) or
         (SelectedPos.Start.x <> SelectedPos.Ende.x);
  result := b;
  end;

// Selektierte Buchstaben löschen
procedure TFormatEdit.DeleteSelectedChars;
  var Pos : TPoint;
  begin
  if (CharsSelected) then begin
    // Von hinten nach vorne, da die Startposition dabei fest bleibt
    Pos := SelectedPos.Ende;
    while (Pos.y> SelectedPos.Start.y) or
          ((Pos.y=SelectedPos.Start.y) and
           (Pos.x > SelectedPos.Start.x)) do begin
      Pos.x := Pos.x-1;
      // Kein weitere Buchstabe in dieser Zeile => mit vorheriger Zeile vereinen
      if (Pos.x < 0) {and (Pos.Y > 0)} then begin
        Dec(Pos.y);
        Pos.x := ShowText.CharactersInLine(Pos.y)-1;
        ShowText.Merge(Pos.y);
        end;
      ShowText.Delete(Pos);
      end;
    ActCursorPos := SelectedPos.Start;
    // Selektierung löschen
    SelectedPos.Start.y := -1;
    SelectedPos.Start.x := -1;
    SelectedPos.Ende := SelectedPos.Start;
    end;
  end;


procedure TFormatEdit.KeyPress(var Key: char);
  begin
  inherited;
  if ord(key)>=32 then
    If FEditEnabled then begin
      if CharsSelected then DeleteSelectedChars;
      // Buchstabe einfügen
      ShowText.Insert(ActCursorPos, Key, FAktFont);
      // Cursorposition anpassen
      React(VK_RIGHT,[]);
      if Assigned(FOnChange) then
        FOnChange(self);
      Invalidate;
      end
    else
      MessageBeep(MB_OK);
  end;


procedure TFormatEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
  inherited;
  // Gegebenfalls fokusieren
  if not Focused then SetFocus;

  if ssLeft in Shift then begin
    // Cursorposition setzen (Scrollpos. berücksichtigen)
    Inc(y,TopLeft.y);
    Inc(x,TopLeft.x);
    React(0,Shift,x,y);
    // Startpunkt einer Selektion festlegen (wie Shift-Taste)
    React(VK_SHIFT,Shift);
    end;
  end;

procedure TFormatEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
  begin
  inherited;
  if (ssLeft in Shift) then
    begin
    // Selektion anpassen (Scrollpos. berücksichtigen)
    Inc(y,TopLeft.y);
    Inc(x,TopLeft.x);
    React(0,Shift+[ssShift],x,y);
    end;
  end;


procedure TFormatEdit.KeyDown(var Key: Word; Shift: TShiftState);
  begin
  inherited;
  React(Key,Shift);
  end;

// Diese Funktion behandelt die Tastaturereignisse
procedure TFormatEdit.React(Key: Word; Shift: TShiftState; x : integer = 0 ; y : integer = 0);
  var OldCursorPos,
      ACPos   : TPoint;
      Handled : Boolean;
      ScrollMsg: TWMScroll;
      CharPos : TRect;

  // Hilfsfunktion, um die richtige Cursorposition zu finden,
  // wenn Pfeil hoch/runter (Direction: +1/-1)
  // oder Page hoch/runter (Direction: +/- halbe Clienthöhe)
  // gedrückt wurde
  function SearchPos(Direction : integer; Cur_Pos : TPoint):TPoint;
    var OldPos: TRect;
        Pos : TPoint;
    begin
    OldPos := ShowText.GetCharPosition(Cur_Pos);

    // Bei Bewegung nach unten unteren Rand, sonst oberer Rand
    if Direction>0 then Pos.y := OldPos.bottom
                   else Pos.y := OldPos.top;

    // In y-Richtung Verschiebung berücksichtigen, x-Pos beibehalten
    Pos.y := Pos.y + Direction;
    Pos.x := OldPos.left;

    // Scrollposition berücksichtigen
    Inc(Pos.y,TopLeft.y);
    Inc(Pos.x,TopLeft.x);
    result := ShowText.GetCharInPos(Pos);
    end;

  begin { of React }
  if Not assigned(ShowText) then Exit;

  // Shifttaste bewirkt eigentlich keine Änderung, außer dass
  // Start der Markierung gesetzt wird.
  if Key <> VK_SHIFT then begin
    OldCursorPos := ActCursorPos;
    ShowCursor(false);
    end;

  Handled := True;
  case Key of
    // Dummycode(0) für die Behandlung von Mausklicks.
    // Der Cursor wird auf den angeklicken Buchstaben gesetzt
    0       : ActCursorPos := ShowText.GetCharInPos(Point(x,y));

    // Shifttaste: Selektion beginnt
    VK_SHIFT: If CharsSelected then
                Handled := False
              else begin
                SelectedPos.Start := ActCursorPos;
                SelectedPos.Ende := ActCursorPos;
                StartSelection := ActCursorPos;
                end;

    // Pos1-Taste:
    VK_HOME: If ssCtrl in Shift then begin  // Zum Textanfang springen
               ActCursorPos := Point(0, 0);
               end
             else begin                     // Zum Zeilenanfang springen
               CharPos := ShowText.GetCharPosition(ActCursorPos);
               If CharPos.Left = 1 then begin
                 ACPos := ActCursorPos;
                 ACPos.X := 0;
                 ActCursorPos := ACPos;
                 end
               else begin
                 CharPos.left := 1;
                 // Scrollposition berücksichtigen
                 Inc(CharPos.top,TopLeft.y);
                 ActCursorPos := ShowText.GetCharInPos(CharPos.TopLeft);
                 end;
               end;

    // Ende-Taste:
    VK_END:  If ssCtrl in Shift then begin  // zum Textende springen
               ACPos := ActCursorPos;
               ACPos.X := LineLength(ACPos.Y);
               ActCursorPos := ACPos;
               end
             else begin                     // zum Zeilenende springen
               CharPos := ShowText.GetCharPosition(ActCursorPos);
               CharPos.left := 32000;
               // Scrollposition berücksichtigen
               Inc(CharPos.top,TopLeft.y);
               ActCursorPos := ShowText.GetCharInPos(CharPos.TopLeft);
            // if ActCursorPos.x <> ShowText.CharactersInLine(ActCursorPos.y) then
            //   Dec(ActCursorPos.x);
             end;

    // Pfeil hoch: Eine Zeile nach oben
    VK_UP:   ActCursorPos := SearchPos(-1, ActCursorPos);
    // Pfeil runter: Eine Zeile nach unten
    VK_DOWN: ActCursorPos := SearchPos( 1, ActCursorPos);

    // Pfeil links: Einen Buchstaben/Wort nach links, ggf. ans Ende der vorherigen Zeile
    VK_LEFT: begin
             ACPos := ActCursorPos;
             Dec(ACPos.x);
             // Zeilenanfang?
             if ACPos.x < 0 then
               if ACPos.y > 0 then begin
                 Dec(ACPos.y);
                 ACPos.x := ShowText.CharactersInLine(ACPos.y);
                 end
               else
                 ACPos.x := 0;
             // Bis zum nächsten Wortanfang springen
             if ssCtrl in Shift then begin
               Dec(ACPos.x);
               while (ACPos.x >= 0) and
                     (ShowText.GetCharacter(ACPos).Character <> ' ') do
                 Dec(ACPos.x);
               Inc(ACPos.x);
               end;
             ActCursorPos := ACPos;
             end;

    // Pfeil rechts: Einen Buchstaben/Wort nach rechts, ggf. an den Anfang der nächsten Zeile
    VK_RIGHT: begin
              ACPos := ActCursorPos;
              Inc(ACPos.x);
              if ACPos.x > ShowText.CharactersInLine(ACPos.y) then
                if ACPos.y < ShowText.Lines-1 then begin
                  Inc(ACPos.y);
                  ACPos.x := 0;
                  end
                else
                  ACPos.x := ShowText.CharactersInLine(ACPos.y);
              // Bis zum nächsten Wortende springen
              if (ssCtrl in Shift) and
                 not(ACPos.x = ShowText.CharactersInLine(ACPos.y)) then begin
                Inc(ACPos.x);
                while (ACPos.x < ShowText.CharactersInLine(ACPos.y))
                  and (ShowText.GetCharacter(ACPos).Character <> ' ') do
                  Inc(ACPos.x);
                end;
              ActCursorPos := ACPos;
              end;

    // Bild runter: Um die Hälfte des Clientbereiches nach unten springen
    VK_NEXT: ActCursorPos := SearchPos ( Height div 2, ActCursorPos);
    // Bild hoch: Um die Hälfte des Clientbereiches nach oben springen
    VK_PRIOR: ActCursorPos := SearchPos(-Height div 2, ActCursorPos);

    // Backspace: Vorheriges Zeichen löschen
    VK_BACK:
        If FEditEnabled then begin
          // ggf. alle selektierten Zeichen löschen
          if CharsSelected then
            DeleteSelectedChars
          else
            if ActCursorPos.x > 0 then begin
              ActCursorPos := Point(ActCursorPos.x - 1, ActCursorPos.Y);
              ShowText.Delete(ActCursorPos);
              Invalidate;
              end
            else
              // Mit vorheriger Zeile zusammenfügen, da kein
              // weiteres Zeichen in dieser Zeile vorhanden
              if ActCursorPos.y > 0 then begin
                ActCursorPos :=
                  Point(ShowText.CharactersInLine(ActCursorPos.y - 1),
                        ActCursorPos.y - 1);
                ShowText.Merge(ActCursorPos.y);
                end;
          // Änderung des Textes mitteilen
          if Assigned(FOnChange) then
            FOnChange(self);
          Invalidate;
          end
        else begin
          Handled := False;
          MessageBeep(MB_OK);
          end;

    // Nächstes Zeichen löschen
    VK_DELETE:
        If FEditEnabled then begin
          // ggf. alle selektierten Zeichen löschen
          if CharsSelected then
            DeleteSelectedChars
          else
            if ActCursorPos.x < ShowText.CharactersInLine(ActCursorPos.y) then
              ShowText.Delete(ActCursorPos)
            else
              // Mit nächster Zeile zusammenfügen, da kein weiteres Zeichen vorhanden
              if ActCursorPos.y < ShowText.Lines-1 then
                ShowText.Merge(ActCursorPos.y);
          // Änderung des Textes mitteilen
          if Assigned(FOnChange) then
            FOnChange(self);
          Invalidate;
          end
        else begin
          Handled := False;
          MessageBeep(MB_OK);
          end;

    // Return-Taste: Falls zulässig einen Hard-Break einfügen und Zeile teilen
    VK_RETURN:
        if FEditEnabled and FWantReturns then begin
          // ggf. alle selektierten Zeichen löschen
          if CharsSelected then DeleteSelectedChars;
          // Zeile teilen
          ShowText.Separate(ActCursorPos);
          ActCursorPos := Point(0, ActCursorPos.y + 1);
          // Änderung des Textes mitteilen
          if Assigned(FOnChange) then FOnChange(self);
          Invalidate;
          end
        else begin
          MessageBeep(MB_OK);
          Handled := False;
          end;

    Ord('A'):    // Strg-A zum Markieren des gesamten Textes;
        If ssCtrl in Shift then begin
          StartSelection := Point(0, 0);
          ACPos.Y := Pred(LineCount);
          ACPos.X := LineLength(ACPos.Y);
          ActCursorPos := ACPos;
          SelectedPos.Start := StartSelection;
          SelectedPos.Ende  := ActCursorPos;
          end
        else begin
          Handled := False;
          inherited KeyDown(Key, Shift);
          end;

    VK_INSERT,   // Strg_Einf oder
    Ord('C'):    // Strg-C zum Kopieren in die Zwischenablage
        If ssCtrl in Shift then begin
          If Not CopyToClipboard then
            MessageBeep(MB_OK);
          end
        else begin
          Handled := False;
          inherited KeyDown(Key, Shift);
          end;

    Ord('V'):   // Strg-V zum Einfügen aus der Zwischenablage
        If ssCtrl in Shift then begin
          If Not InsertFromClipboard then
            MessageBeep(MB_OK);
          end
        else begin
          Handled := False;
          inherited KeyDown(Key, Shift);
          end;

    Ord('X') :  // Strg-X zum Ausschneiden in die Zwischenablage
        If ssCtrl in Shift then begin
          CopyToClipboard;
          DeleteSelectedChars;
          end
        else begin
          Handled := False;
          inherited KeyDown(Key, Shift);
          end;

    134 : OldCursorPos.x := -1;  //Dummy
  else
    Handled := False;
    inherited KeyDown(Key, Shift);
  end; { of case }

  // Wurde etwas geändert?
  if Handled then begin
    // ggf. Selektierung anpassen
    if ssCtrl in Shift then
      Invalidate
    else
      if ssShift in Shift then begin
        if (ActCursorPos.y < StartSelection.y) or
           ((ActCursorPos.y = StartSelection.y) and
            (ActCursorPos.x <= StartSelection.x)) then begin
          SelectedPos.Start := ActCursorPos;
          SelectedPos.Ende := StartSelection;
          end;
        if (ActCursorPos.y > StartSelection.y) or
           ((ActCursorPos.y = StartSelection.y) and
            (ActCursorPos.x >= StartSelection.x)) then begin
          SelectedPos.Ende := ActCursorPos;
          SelectedPos.Start := StartSelection;
          end;
        Invalidate;
        end
      else begin
        // Selektierung löschen, wenn Shifttaste nicht mehr gedrückt
        if SelectedPos.Start.x <> -1 then begin
          SelectedPos.Start.x := -1;
          SelectedPos.Start.y := -1;
          SelectedPos.Ende := SelectedPos.Start;
          Invalidate;
          end;
        end;
    end; { of "if Handled" }

  if Key <> VK_SHIFT then begin
    AdjustScrollBar;
    if (OldCursorPos.x <> ActCursorPos.x) or
       (OldCursorPos.y <> ActCursorPos.y) then begin
      // Fenster notfalls scrollen
      CharPos := ShowText.GetCharPosition(ActCursorPos);
      ScrollMsg.Msg := WM_VSCROLL;
      ScrollMsg.ScrollBar := 0;
      while CharPos.top < 1 do begin
        ScrollMsg.ScrollCode := SB_PAGEUP;
        WMVScroll(ScrollMsg);
        CharPos := ShowText.GetCharPosition(ActCursorPos);
        end;
      while CharPos.bottom > ClientRect.Bottom-1 do begin
        ScrollMsg.ScrollCode := SB_PAGEDOWN;
        WMVScroll(ScrollMsg);
        CharPos := ShowText.GetCharPosition(ActCursorPos);
        end;
      //horinzontal scrollen
      ScrollMsg.Msg := WM_HSCROLL;
      while CharPos.left < 1 do begin
        ScrollMsg.ScrollCode := SB_PAGEUP;
        WMHScroll(ScrollMsg);
        CharPos := ShowText.GetCharPosition(ActCursorPos);
        end;
      while CharPos.right > ClientRect.right-1 do begin
        ScrollMsg.ScrollCode := SB_PAGEDOWN;
        WMHScroll(ScrollMsg);
        CharPos := ShowText.GetCharPosition(ActCursorPos);
        end;

      OldCursorPos := ActCursorPos;
      // Schriftart des letzten Buchstaben verwenden (außer wenn Selektion an AktCursorPos beginnt)
      if (ActCursorPos.x <> SelectedPos.Start.x) or
         (ActCursorPos.y <> SelectedPos.Start.y) then begin
        if OldCursorPos.x > 0 then
          Dec(OldCursorPos.x)
        // Am Anfang der Zeile die Schriftart des 1. Buchstabens (wenn es einen gibt)
        else begin
          while (OldCursorPos.y>=0) and
                (OldCursorPos.x >= ShowText.CharactersInLine(OldCursorPos.y)) do begin
            Dec(OldCursorPos.y);
            if (OldCursorPos.y >= 0) then begin
              OldCursorPos.x := ShowText.CharactersInLine(OldCursorPos.y)-1;
              if OldCursorPos.x < 0 then OldCursorPos.x := 0;
              end;
            end;
          end;
        end;
      if OldCursorPos.y = -1 then
        SetActFont(DefaultFont)
      else
        SetActFont(ShowText.GetCharFont(OldCursorPos));
      if assigned(FOnFontChange) then
        FOnFontChange(self, FAktFont);
      end;

    // Neue Cursorposition sofort anzeigen
    if Focused then begin
      CursorCount := -1;
      ShowCursor(true);
      end;
    end;  { of "key <> VK_SHIFT" }
  end; { of React }

// ----------------------------------------------------------
// Reaktion auf die Änderung der Schriftart von außen
// ----------------------------------------------------------

// Ändert den selektierten Text:
// Change gibt an, welche Ausprägung des aktuellen Fonts
// geändert werden muss

procedure TFormatEdit.SelectionChangeFont(Change : TFontChanges);
  begin
  if CharsSelected then begin
    ShowText.ChangeFont(SelectedPos, FAktFont, Change);
    // Änderung des Textes mitteilen
    if Assigned(FOnChange) then
      FOnChange(self);
    React(134,[ssShift]);
    Invalidate;
    AdjustScrollBar;
    end;
  // Änderung der aktuellen Schriftart mitteilen
  if assigned(OnFontChange) then
    OnFontChange(self, FAktFont);
  end;

function TFormatEdit.GetCharFont(Pos: TPoint): TFormatFont;
  begin
  Result := ShowText.GetCharFont(Pos);
  end;

procedure TFormatEdit.SetEditEnabled(newVal: Boolean);
  begin
  FEditEnabled := newVal;
  end;

procedure TFormatEdit.SetTag (i : integer);
  begin
  If i >= 0 then with FAktFont do begin
    Tag := i;
    Style := Style + [fsUnderline];
    Color := clBlue;
    end;
  SelectionChangeFont([fcUnderline, fcColor, fcTag]);
  end;


procedure TFormatEdit.SetBold (b : boolean);
  begin
  if b then
    FAktFont.Style := FAktFont.Style + [fsBold]
  else
    FAktFont.Style := FAktFont.Style - [fsBold];
  SelectionChangeFont([fcBold]);
  end;

procedure TFormatEdit.SetItalic (b : boolean);
  begin
  if b then
    FAktFont.Style := FAktFont.Style + [fsitalic]
  else
    FAktFont.Style := FAktFont.Style - [fsItalic];
  SelectionChangeFont([fcItalic]);
  end;

procedure TFormatEdit.SetUnderline (b : boolean);
  begin
  if b then
    FAktFont.Style := FAktFont.Style + [fsUnderline]
  else
    FAktFont.Style := FAktFont.Style - [fsUnderline];
  SelectionChangeFont([fcUnderline]);
  end;

procedure TFormatEdit.SetSup (b : Boolean);
  begin
  if b then
    FAktFont.Position := fpSup
  else
    FAktFont.Position := fpNormal;
  SelectionChangeFont([fcPosition]);
  end;

procedure TFormatEdit.SetSub (b : Boolean);
  begin
  if b then
    FAktFont.Position := fpSub
  else
    FAktFont.Position := fpNormal;
  SelectionChangeFont([fcPosition]);
  end;

procedure TFormatEdit.SetSize (i : integer);
  begin
  if i>0 then FAktFont.Size := i;
  SelectionChangeFont([fcSize]);
  end;

procedure TFormatEdit.SetFontName (n : TFontName);
  begin
  if length(n)>0 then FAktFont.Name := n;
  SelectionChangeFont([fcName]);
  end;

procedure TFormatEdit.SetFont (f : TFont);
  begin
  SetActFont(f);
  SelectionChangeFont([fcBold,fcItalic,fcUnderline,fcPosition,fcSize,fcName,fcTag]);
  end;

procedure TFormatEdit.SetFont (f : TFormatFont);
  begin
  SetActFont(f);
  SelectionChangeFont([fcBold,fcItalic,fcUnderline,fcPosition,fcSize,fcName]);
  end;

// ----------------------------------------------------------
//   Umgang mit selektiertem Text, Cursorpositionierung
// ----------------------------------------------------------

procedure TFormatEdit.SetSelection(Sel: TSelection);
  { 06.08.09 geändert: Jetzt wird der zu verwendende Font für die
                       einzufügenden Zeichen vom aktuellen *ersten*
    Zeichen geholt, statt wie zuvor vom letzten! Dies vermeidet z.B.
    störende Tiefstellungen bei durchnummerierten Bezeichnern.      }
  begin
  If Sel.Ende.X < 0 then
    Sel.Ende.X := LineLength(Sel.Ende.Y);
  SelectedPos.Start := Sel.Start;
  SelectedPos.Ende  := Sel.Ende;
  StartSelection    := Sel.Start;   // Doppelte Buchführung ;-)
  ActCursorPos      := Sel.Ende;    // Kursor ans Ende
  SetActFont(ShowText.GetCharFont(StartSelection)); 
  Update;
  If (Sel.Ende.X <> Sel.Start.X) or
     (Sel.Ende.Y <> Sel.Start.Y) then
    SetFocus;
  end;

procedure TFormatEdit.SelectActualLine;
  var pos     : TPoint;
      sel     : TSelection;
      lastFont: TFormatFont;
  begin
  pos.x := 0;
  pos.y := ActCursorPos.Y;
  sel.Start := pos;
  pos.x := LineLength(pos.y);
  sel.Ende  := pos;
  SetSelection(sel);
  lastFont := ShowText.GetCharFont(pos);
  If Assigned(OnFontChange) then
    OnFontChange(Self, lastFont);
  Invalidate;
  end;

procedure TFormatEdit.RevokeActSelection;
  var sel : TSelection;
  begin
  If CharsSelected then begin
    sel.Start := ActCursorPos;
    sel.Ende  := ActCursorPos;
    SetSelection(sel);
    Invalidate;
    end;
  end;

procedure TFormatEdit.SetAktCursorPos(ncp: TPoint);
  { ActCursorPos = (x, y) heißt:
    Der Cursor steht in der (y+1)-ten Zeile vor dem (x+1)-ten Zeichen.
    Sowohl die Zeichen- als auch die Zeilen-Nummerierung beginnen also
    mit Null! ActCursorPos = (0,0) heißt also: der Cursor steht links vom
    1. Zeichen in der 1. Zeile !
    Wertebereiche:   x = 0 .. CharactersInLine;    y = 0 .. Lines   }
  var max_x, max_y : Integer;
  begin
  If ncp.X < 0 then ncp.X := 0;
  If ncp.Y < 0 then ncp.Y := 0;
  max_y := Pred(ShowText.Lines);
  If ncp.Y > max_y then ncp.Y := max_y;
  max_x := ShowText.CharactersInLine(ncp.Y);
  If ncp.X > max_x then ncp.X := max_x;
  FAktCursorPos := ncp;
  end;

// ----------------------------------------------------------
//
// Import-/Export/Auskunfts-Funktionen
//      (Clipboard-Unterstützung, ....)
//
// ----------------------------------------------------------

function TFormatEdit.CopyToClipboard : Boolean;
  var sl : TStrings;
  begin
  Result := False;
  If (SelectedPos.Start.Y < SelectedPos.Ende.Y) or
     ((SelectedPos.Start.Y = SelectedPos.Ende.Y) and
      (SelectedPos.Start.X < SelectedPos.Ende.X)) then begin
    sl := SelPlainText;
    try
      Clipboard.AsText := sl.Text;
      Result := True;
    finally
      sl.Free;
    end;
    end;
  end;

function TFormatEdit.InsertFromClipboard : Boolean;
  var fs : String;
      i  : Integer;
  begin
  Cut;
  If Clipboard.HasFormat(cf_Text) then begin
    fs := Clipboard.AsText;
    i := POS(#$D#$A, fs);
    while i > 0 do begin
      Delete(fs, i, 2);
      Insert('<br>', fs, i);
      i := POS(#$D#$A, fs);
      end;
    end
  else
    fs := '';
  Paste(fs);
  Result := True;
  end;

procedure TFormatEdit.Cut;
  begin
  If (SelectedPos.Start.Y < SelectedPos.Ende.Y) or
     ((SelectedPos.Start.Y = SelectedPos.Ende.Y) and
      (SelectedPos.Start.X < SelectedPos.Ende.X)) then
    DeleteSelectedChars;
  end;

procedure TFormatEdit.Paste(fs: String);
  begin
  If FEditEnabled then begin
    If (Length(fs) = 0) and
       ClipBoard.HasFormat(cf_Text) then
      fs := Clipboard.AsText;
    DeleteSelectedChars;
    ActCursorPos := ShowText.InsertHTMLText(ActCursorPos, fs);
    Resize;
    Invalidate;
    ActCursorPos := Point(0, 0);
    Invalidate;
    end;
  end;

procedure TFormatEdit.Clear;
  begin
  If FEditEnabled then begin
    SetHTMLText(Nil);
    Invalidate;
    end;
  end;

function TFormatEdit.IsEmpty: Boolean;
  begin
  Result := ShowText.IsEmpty;
  end;

function TFormatEdit.GetTextExtent: TPoint;
  begin
  Result := Point(ShowText.GetWidth, ShowText.GetHeight);
  end;

procedure TFormatEdit.LoadBMPDataInto(BMP: TBitMap);
  begin
  Assert(BMP <> Nil, 'BitMap-Parameter ist NIL !');
  HideSelection;
  BMP.Width  := ShowText.GetWidth;
  BMP.Height := ShowText.GetHeight;
  BitBlt(BMP.Canvas.Handle, 0, 0, BMP.Width, BMP.Height,
         Canvas.Handle, 1, 1, SrcCopy);
  ShowSelection;
  end;

function TFormatEdit.LineLength(nr : Integer): Integer;
  begin
  If nr < ShowText.Lines then
    Result := ShowText.CharactersInLine(nr)
  else
    Result := 0;
  end;

function TFormatEdit.LineCount: Integer;
  { 12.01.2013  Geändert in sicherere Abfrage:
                statt nur "ShowText.Lines" abzufragen, wird nun durch
    einen Aufruf von GetHTMLText sichergestellt, dass der gewünschte
    HTMLText auch wirklich schon vorliegt.                           }
  var SL : TStrings;
  begin
  SL := GetHTMLText;
  Result := SL.Count;  // vorher: ShowText.Lines;
  SL.Free;
  end;

function TFormatEdit.GetHTMLTextLine(nr: Integer): String;
  var SL : TStrings;
  begin
  SL := GetHTMLText;
  If nr < SL.Count then
    Result := SL.Strings[nr]   // FHTMLText[nr]
  else
    Result := '';
  SL.Free;
  end;

function TFormatEdit.GetPlainASCIITextLine(nr: Integer): String;

  function KillAllTags(s: String): String;
    var na, ne, cc : Integer;
    begin
    na := POS('<', s);
    While na > 0 do begin
      ne := POS('>', s);
      While (ne > 0) and (ne < na) do begin  // Schließendes Tag *vor*
        Delete(s, ne, 1);                    //    öffnendem Tag
        na := na - 1;                        // ==> Zeichen löschen !
        ne := POS('>', s);
        end;
      If ne > 0 then begin                   // dann ist auch  ne > na !!!
        cc := ne - na + 1;                   // ==> Tag komplett löschen !
        Delete(s, na, cc);
        end;
      na := POS('<', s);
      end;
    Result := s;
    end;

  var s : String;
  begin
  s := GetHTMLTextLine(nr);
  If Length(s) > 0 then
    Result := KillAllTags(s)
  else
    Result := '';
  end;


function TFormatEdit.GetHTMLLinkAt(acp: TPoint): String;
  { Prüft, ob an der übergebenen Stelle acp ein Link steht; falls ja, wird
    der HTML-Text dieses Links, andernfalls ein leerer String zurückgegeben.
    Außerdem wird FActLinkIndex gesetzt: bei einem bestehenden Link auf dessen
    Index (der stets echt positiv sein muss! Der Wert "0" steht für "ist kein
    Link" !), bei einem neuen Link auf ShowText.LinkList.Count, was der
    kleinste noch nicht verwendete Index ist!                              }

  procedure Decr(var p: TPoint);
    begin
    If p.X > 0 then
      p.X := p.X - 1
    else
      If p.Y > 0 then begin
        p.Y := p.Y - 1;
        p.X := LineLength(p.Y - 1);
        end
      else
        if p.Y = 0 then p.Y := -1;
    end;

  procedure Incr(var p: TPoint);
    begin
    If p.Y < LineCount then
      If p.X < LineLength(p.Y) - 1 then
        p.X := p.X + 1
      else begin   // letzter Buchstabe in der Zeile
        p.Y := p.Y + 1;
        p.X := 0;
        end;
    end;

  var ffont : TFormatFont;   // "f"ormat "font"
      s     : String;
      sel   : TSelection;
      rp    : TPoint;        // "r"unning "p"osition
  begin  { of GetHTMLLinkAt() }
  if (acp.X < 0) or (acp.Y < 0) then
    acp := ActCursorPos;
  ffont := ShowText.GetCharFont(acp);
  If Assigned(ffont) and (ffont.Tag > 0) then begin
    FActLinkIndex := ffont.Tag;
    rp := acp;
    s  := '';
    Repeat
      s := ShowText.GetLine(rp.Y).GetCharacter(rp.X).Character + s;
      Decr(rp);
    until (rp.Y < 0) or (ShowText.GetCharFont(rp).Tag <> FActLinkIndex);
    Incr(rp);
    sel.Start := rp;
    rp := acp;
    Incr(rp);
    While (rp.Y < LineCount) and
          (rp.X < ShowText.CharactersInLine(rp.Y)) and
          (ShowText.GetCharFont(rp).Tag = FActLinkIndex) do begin
      s := s + ShowText.GetLine(rp.Y).GetCharacter(rp.X).Character;
      Incr(rp);
      end;
    sel.Ende := rp;
    SetSelection(sel);
    Result := '<a href="' + ShowText.GetLinkAddress(FActLinkIndex) + '">' + s + '</a>';
    end
  else begin
    FActLinkIndex := ShowText.LinkList.Count + 1;
    sel.Start := ActCursorPos;
    sel.Ende  := ActCursorPos;
    SetSelection(sel);
    Result := '';  // kein Link!
    end;
  end;   { of GetHTMLLinkAt() }

function TFormatEdit.InsertHTMLLinkAt(acp: TPoint; linktext, adress: String): Boolean;
  { Falls beim Aufruf dieser Methode ein existierender Link editiert werden
    soll, muss er markiert sein. Nur dann werden die Daten korrekt ersetzt.
    Neue Links werden grundsätzlich an die ShowText.LinkList hinten angefügt. }
  var sel      : TSelection;
      lastLine,
      lastChar : Integer;
  begin
  lastLine := Pred(LineCount);
  lastChar := ShowText.CharactersInLine(acp.Y);
  If (acp.Y <= lastLine) and
     (acp.X <= LastChar) then begin
    Assert(FActLinkIndex > 0, 'Link-Index > 0 erwartet, aber : ' +
                              IntToStr(FActLinkIndex) + ' gefunden!');
    sel := ActSelection;
    If (sel.Start.Y < sel.Ende.Y) or
       ((sel.Start.Y = sel.Ende.Y) and
        (sel.Start.X < sel.Ende.X)) then begin
      DeleteSelectedChars;
      ShowText.InsertHTMLText(ActCursorPos, linkText);
      ShowText.LinkList[FActLinkIndex - 1] := adress
      end
    else begin
      ShowText.InsertHTMLText(ActCursorPos, linktext);
      ShowText.LinkList.Add(adress);
      FActLinkIndex := ShowText.LinkList.Count;
      end;
    sel.Start := ActCursorPos;
    sel.Ende  := Point(ActCursorPos.X + Length(linktext), ActCursorPos.Y);
    ActSelection  := sel;
    SetTag(FActLinkIndex);
    ActCursorPos  := sel.Ende;
    Result := True;
    end
  else
    Result := False;
  end;

function TFormatEdit.InsertHTMLTextAt(acp: TPoint; newText: String): Boolean;
  begin
  ActCursorPos := ShowText.InsertHTMLText(acp, newText);
  ShowText.Paint;
  Result := True;
  end;


// ---------------------------------------------------------
// Standartbehandlungsroutinen für published - Variablen
// ---------------------------------------------------------

// Scrollbars ja / nein
procedure TFormatEdit.SetScrollBars(Style : TScrollStyle);
  begin
  FVScrollBar := (Style = ssVertical)   or (Style = ssBoth);
  FHScrollBar := (Style = ssHorizontal) or (Style = ssBoth);
  end;

function TFormatEdit.GetScrollBars : TScrollStyle;
  begin
  if FVScrollBar then
    if FHScrollBar then result := ssBoth
    else                result := ssVertical
  else
    if FHScrollBar then result := ssHorizontal
    else                result := ssNone;
  end;


// Textfunktionen :
// ------------------------------------------
// GetPlainText        [property PlainText]     (Text ohne Formatierung)
// GetSelPlainText     [property SelPlainText]  (Text ohne Formatierung)
// GetHTMLText         [property Text]          (Text mit HTML-Formatierung)
// SetHTMLText         [property Text]          (Text mit HTML-Formatierung)
// GetHTMLTextAsString [property TextAsString]  (Text mit HTML-Formatierung)
// SetHTMLTextAsString [property TextAsString]  (Text mit HTML-Formatierung)

function  TFormatEdit.GetPlainText: TStrings;
  { Zugriffsfunktion für die Eigenschaft "PlainText".
    Diese Funktion ist effektiv ein Konstruktor:
    sie liefert eine String-Liste, die extern entsorgt werden muss. }
  begin
  Result := TStringList.Create;
  Result.AddStrings(ShowText.GetText);
  end;

function  TFormatEdit.GetSelPlainText: TStrings;
  { Zugriffsfunktion für die Eigenschaft "SelPlainText";
    Diese Funktion ist effektiv ein Konstruktor:
    sie liefert eine String-Liste, die extern entsorgt werden muss. }
  var Pos : TPoint;
      pu  : String;
      n   : Integer;
  begin
  Result := TStringList.Create;
  If CharsSelected then begin
    Pos := SelectedPos.Start;
    While Pos.Y <= SelectedPos.Ende.Y do begin
      pu := '';
      If Pos.Y < SelectedPos.Ende.Y then   // Letztes Zeichen adressieren
        n := ShowText.CharactersInLine(Pos.Y)
      else
        n := SelectedPos.Ende.X;
      While Pos.X < n do begin  // Zeile auslesen
        pu := pu + ShowText.GetCharacter(Pos).Character;
        Pos.X := Pos.X + 1;
        end;
      Result.Add(pu);      // Zeile abspeichern
      Pos.X := 0;          // CR
      Pos.Y := Pos.Y + 1;  // LF
      end;
    end;
  end;

function  TFormatEdit.GetHTMLText: TStrings;
  { Zugriffsfunktion für die Eigenschaft "Text".
    Diese Funktion ist effektiv ein Konstruktor:
    sie liefert stets eine *Kopie* der internen String-Liste !  }
  var t : TSTrings;
  begin
  // Nur dann aus dem dazugehörigen ShowText laden, wenn dieser schon
  // existiert (nicht csLoading) und nicht zur Designzeit (nicht csDesigning),
  // damit der HTML-Text wie vom Benutzer eingegeben gespeichert wird.
  if not ((csLoading in ComponentState) or
          (csDesigning in ComponentState)) then begin
    t := ShowText.GetHTMLText(DefaultFont);   // Vorsicht! Dies liefert stets
    FHTMLText.Clear;                          // die *interne* ShowText-String-
    FHTMLText.AddStrings(t);                  // Liste, also *nie* freigeben !
    end;
  Result := TStringList.Create;    // Hier wird eine Kopie hergestellt
  Result.AddStrings(FHTMLText);    //   und nach außen geliefert !
  end;

procedure TFormatEdit.SetHTMLText(Lines : TStrings);
  var cl_rect : TRect;
  begin
  // Aktueller Font muss der eingestellte Defaultfont sein
  if assigned(FAktFont) then
    SetActFont(Font)
  else
    FAktFont := TFormatFont.Create(Font);
  Canvas.Font := Font;

  // Scrollposition auf 0,0 setzen und Cursor an Anfang positionieren
  TopLeft := Point(0,0);
  SelectedPos.Start.y := -1;
  SelectedPos.Ende.y := -1;
  ActCursorPos := Point(0, 0);

  // Größe des Anzeigebereichs festlegen
  // Fiktive Größe 32000, wenn kein automatischer Zeilenumbruch
  cl_rect := ClientRect;
  InflateRect(cl_rect,-1,-1);
  if not FWordWrap then cl_rect.right := 32000;
  ShowText.SetClientRect(cl_rect);

  ShowText.SetHTMLText(Lines);

  // FHTMLText anpassen
  if Lines <> FHTMLText then begin
    FHTMLText.Clear;
    If Assigned(Lines) then
      FHTMLText.AddStrings(Lines);
    end;

  MaxTopLeft := Point(-1,-1);
  AdjustScrollBar;
  Invalidate;
  if assigned(FOnFontChange) then
    FOnFontChange(self,FAktFont);
  end;

function TFormatEdit.GetHTMLTextAsString: String;
  var SL : TStrings;
  begin
  SL := GetHTMLText;
  Result := SL.Text;
  SL.Free;
  DeleteChars(#10#13, Result);
  end;

procedure TFormatEdit.SetHTMLTextFromString(newText: String);
  var SL : TStrings;
      n  : Integer;
  begin
  SL := TStringList.Create;
  While Length(newText) > 0 do begin
    n := Pos('<br>', newText);
    If n > 0 then begin
      SL.Add(Copy(newText, 1, n+3));
      Delete(newText, 1, n+3);
      end
    else begin
      SL.Add(newText);
      newText := '';
      end;
    end;
  SetHTMLText(SL);
  SL.Free;
  end;


// DefaultFont
procedure TFormatEdit.SetDefaultFont(f : TFont);
  begin
  If (f.Name  <> Font.Name ) or (f.Size    <> Font.Size   ) or
     (f.Style <> Font.Style) or (f.Charset <> Font.Charset) or
     (f.Color <> Font.Color) then begin
    Font.Assign(f);
    SetHTMLText(FHTMLText);  // Text neu setzen, damit der Defaultfont
    end;                     //   auch wirklich benutzt wird.
  end;

function TFormatEdit.GetDefaultFont : TFont;
  begin
  result := Font;
  end;


// Automatische Zeilenumbrüche ja/nein
procedure TFormatEdit.SetWordWrap(b : boolean);
  begin
  If FWordWrap <> b then begin
    FWordWrap := b;
    Resize;
    end;
  end;

end.
