unit ConstrWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls,
  Utility, GeoTypes, Declar, GlobVars, FormatEdit;

type
  TConstrTextWin = class(TForm)
    FormatEdit1: TFormatEdit;
    procedure FormatEdit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormHide(Sender: TObject);
    procedure FormatEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormResize(Sender: TObject);
  private
    { Private-Deklarationen }
    Ready     : Boolean;
    GO        : TGeoObj;
    bufList   : TStringList;
    procedure Look4Object(var Msg: TMessage); message cmd_ConstrWinDown;
  public
    { Public-Deklarationen }
    constructor CreateP(AOwner: TComponent);
    destructor Destroy; override;
    procedure GetTextFromDrawing(Drawing: TGeoObjListe);
  end;



implementation

{$R *.DFM}

Uses MainWin, FormatText;


constructor TConstrTextWin.CreateP(AOwner: TComponent);
  begin
  Create(AOwner);
  Ready := False;
  With FormatEdit1 do begin
    DefaultFont := GlobalDefaultFont;
    EditEnabled := False;
    BoundsRect  := Self.ClientRect;
    end;
  bufList := TStringList.Create;
  end;

destructor TConstrTextWin.Destroy;
  begin
  bufList.Free;
  Inherited Destroy;
  end;

procedure TConstrTextWin.GetTextFromDrawing(Drawing: TGeoObjListe);
  var i      : Integer;
      s, buf : String;
      ShowIt : Boolean;
  begin
  FormatEdit1.HTMLTextAsString := '';
  bufList.Clear;
  For i := 5 to Drawing.LastValidObjIndex do begin
    If NoNamesInConstrText then
      ShowIt := Not (TGeoObj(Drawing.Items[i]) is TGTextObj)
    else
      ShowIt := Not (TGeoObj(Drawing.Items[i]) is TGComment);
    If ShowIt then
      With TGeoObj(Drawing.Items[i]) do begin
        s := GetInfo;
        If Length(s) > 0 then begin   // Leere Zeilen übergehen !
          buf := ResizeHTMLText(s, 12);
          If DataValid then
            If IsVisible then
              bufList.AddObject('   ' + buf + ' <br>', Drawing.Items[i])
            else
              bufList.AddObject('    ( ' + buf + ' ) <br>', Drawing.Items[i])
          else
            bufList.AddObject('    {{ ' + buf + ' }} <br>', Drawing.Items[i]);
          end;
        end;
    end;
    FormatEdit1.Text := bufList;
  Ready := True;
  GO := Nil;
  Drawing.MakeHiddenObjectsTempVisible;
  end;

procedure TConstrTextWin.FormResize(Sender: TObject);
  begin
  FormatEdit1.BoundsRect := Self.ClientRect;
  FormatEdit1.Invalidate;
  end;

procedure TConstrTextWin.FormHide(Sender: TObject);
  begin
  Ready := False;   { Vormerken für das nächste Öffnen des Fensters ! }
  With Hauptfenster.Drawing do begin
    HideHiddenObjects;
    DrawFirstObjects(LastValidObjIndex, True);
    end;
  end;

{================= Markierungs-Manipulata =====================}

procedure TConstrTextWin.Look4Object(var Msg: TMessage);
  var lineNum  : Integer;
      Sel      : TSelection;
  begin
  lineNum := FormatEdit1.ActCursorPos.Y;
  GO := TGeoObj(bufList.Objects[lineNum]);
  If GO <> Nil then begin
    Sel.Start := Point(1, LineNum);
    If GO.IsVisible then
      Sel.Ende := Point(FormatEdit1.LineLength(lineNum), LineNum)
    else
      Sel.Ende := Sel.Start;
    FormatEdit1.ActSelection := Sel;
    FormatEdit1.Invalidate;
    FormatEdit1.SetFocus;
    GO.IsBlinking := True;
    end;
  end;

procedure TConstrTextWin.FormatEdit1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
  If GO <> Nil then
    GO.IsBlinking := False;
  Hauptfenster.Drawing.EndBlinkingMode;
  If Button = mbRight then
    FormatEdit1.RevokeActSelection;
  If (Button = mbLeft) and (ssDouble in Shift) then
    PostMessage(Handle, cmd_ConstrWinDown, 0, 0);
  end;

procedure TConstrTextWin.FormatEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
  If key = vk_Escape then begin
    FormatEdit1.RevokeActSelection;
    If GO <> Nil then
      GO.IsBlinking := False;
    end;
  if key = vk_Insert then
    key := 0;
  end;

procedure TConstrTextWin.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
  var cp  : TPoint;
      Sel : TSelection;
  begin
  If GO <> Nil then
    GO.IsBlinking := False;
  cp := FormatEdit1.ActCursorPos;
  If cp.Y > 0 then begin
    If Not Handled then begin
      Sel.Start := Point(1, cp.Y - 1);
      Sel.Ende := Sel.Start;
      FormatEdit1.ActSelection := Sel;
      FormatEdit1.Invalidate;
      Handled := True;
      end;
    PostMessage(Handle, cmd_ConstrWinDown, 0, 0);
    end
  else
    If Not Handled then begin
      Sel.Start := Point(0, 0);
      Sel.Ende  := Point(0, 0);
      FormatEdit1.ActSelection := Sel;
      FormatEdit1.Invalidate;
      Handled := True;
      end;
  end;

procedure TConstrTextWin.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
  var cp  : TPoint;
      Sel : TSelection;
  begin
  If GO <> Nil then
    GO.IsBlinking := False;
  cp := FormatEdit1.ActCursorPos;
  If cp.Y < Pred(FormatEdit1.LineCount) then begin
    If Not Handled then begin
      Sel.Start := Point(1, cp.Y + 1);
      Sel.Ende := Sel.Start;
      FormatEdit1.ActSelection := Sel;
      FormatEdit1.Invalidate;
      Handled := True;
      end;
    PostMessage(Handle, cmd_ConstrWinDown, 0, 0);
    end
  else
    If Not Handled then begin
      Sel.Start := Point(cp.X, cp.Y);
      Sel.Ende  := Point(cp.X, cp.Y);
      FormatEdit1.ActSelection := Sel;
      FormatEdit1.Invalidate;
      Handled := True;
      end;
  end;

end.
