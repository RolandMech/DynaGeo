unit WerteTabelle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, ExtCtrls, StdCtrls, CheckLst, Clipbrd,
  GlobVars, GeoTypes, GeoLocLines, TBaum;

type
  TFunkTableWin = class(TForm)
    Panel1: TPanel;
    FTab: TStringGrid;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    FunkLB: TCheckListBox;
    PopupMenu1: TPopupMenu;
    Menu_Kopieren: TMenuItem;
    Menu_Schliessen: TMenuItem;
    N1: TMenuItem;
    Menu_Update: TMenuItem;
    procedure FormResize(Sender: TObject);
    procedure FAuswahlClick(Sender: TObject);
    procedure RefreshTable(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Menu_KopierenClick(Sender: TObject);
    procedure Menu_SchliessenClick(Sender: TObject);
  private
    xmin,
    xmax,
    dx      : Double;
    Drawing : TGeoObjListe;
    function  CheckedFunkCount: Integer;
    procedure FillTable;
  public
    { Public-Deklarationen }
    constructor CreateWD(iOwner: TComponent; iFunktion: TGFunktion);
    constructor CreateWXMLD(iOwner: TComponent; iDrawing: TGeoObjListe; VTD: TValTabData);
    procedure InitWD(iFunktion: TGFunktion);
    procedure UpdateData;
  end;


implementation

{$R *.dfm}

uses Utility, Declar, MainWin;

constructor TFunkTableWin.CreateWD(iOwner: TComponent; iFunktion: TGFunktion);
  begin
  Inherited Create(iOwner);
  InitWD(iFunktion);
  end;

constructor TFunkTableWin.CreateWXMLD(iOwner: TComponent;
                                      iDrawing: TGeoObjListe;
                                      VTD: TValTabData);
  var SR : TRect;
      i  : Integer;
  begin
  Inherited Create(iOwner);
  Drawing    := iDrawing;
  Edit1.Text := VTD.xmin;
  Edit2.Text := VTD.xmax;
  Edit3.Text := VTD.dx;
  BoundsRect := VTD.rect;
  SR := Screen.WorkAreaRect;
  If Top < SR.Top then Top := SR.Top + 5;
  If Top + Height > SR.Bottom then Top := SR.Bottom - Height - 5;
  If Left < SR.Left then Left := SR.Left + 5;
  If Left + Width > SR.Right then Left := SR.Right - Width - 5;
  FunkLB.Clear;
  For i := 5 to Pred(Drawing.Count) do
    if TGeoObj(Drawing[i]) is TGFunktion then begin
      FunkLB.AddItem(TGeoObj(Drawing[i]).Name, Drawing[i]);
      FunkLB.Checked[Pred(FunkLB.Count)] :=
        Pos(IntToStr(TGeoObj(Drawing[i]).GeoNum), VTD.marked) > 0;
      end;
  RefreshTable(Nil);
  end;

procedure TFunkTableWin.InitWD(iFunktion: TGFunktion);
  var i : Integer;
  begin
  If iFunktion.ObjList <> Drawing then
    Drawing := iFunktion.ObjList;
  xmin := Round(Drawing.xMin);
  xmax := Round(Drawing.xMax);
  dx   := 1;
  Edit1.Text := FloatToStr(xmin);
  Edit2.Text := FloatToStr(xmax);
  Edit3.Text := FloatToStr(dx);
  FunkLB.Clear;
  For i := 5 to Pred(Drawing.Count) do
    if TGeoObj(Drawing[i]) is TGFunktion then begin
      FunkLB.AddItem(TGeoObj(Drawing[i]).Name, Drawing[i]);
      FunkLB.Checked[Pred(FunkLB.Count)] := Drawing[i] = iFunktion;
      end;
  RefreshTable(Nil);
  end;

function TFunkTableWin.CheckedFunkCount : Integer;
  var i, k : Integer;
  begin
  k := 0;
  For i := 0 to Pred(FunkLB.Count) do
    If FunkLB.Checked[i] then
      k := k + 1;
  Result := k;
  end;

procedure TFunkTableWin.FillTable;
  var x, y    : Double;
      i, j, k : Integer;
  begin
  { Erst x-Spalte füllen }
  FTab.Cells[0,0] := ' x';
  x := xmin;
  For i := 1 to FTab.RowCount do begin
    FTab.Cells[0,i] := ' ' + Float2Str(x, LengthDecimals);
    x := x + dx;
    end;
  { Dann Wertespalten füllen }
  j := 1;   // zeigt auf die nächste zu beschreibende Spalte !
  For k := 0 to Pred(FunkLB.Count) do
    if FunkLB.Checked[k] then begin
      FTab.Cells[j,0] := ' ' + TGFunktion(FunkLB.Items.Objects[k]).Name + '(x)';
      x := xmin;
      For i := 1 to FTab.RowCount do begin
        If TGFunktion(FunkLB.Items.Objects[k]).GetFunctionValue(x, y) then
          FTab.Cells[j,i] := ' ' + Float2Str(y, LengthDecimals)
        else
          FTab.Cells[j,i] := '--!!!--';
        x := x + dx;
        end;
      j := j + 1;
      end;
  end;

procedure TFunkTableWin.FormResize(Sender: TObject);
  begin
  FTab.DefaultColWidth := (FTab.ClientWidth - 2) Div FTab.ColCount;
  end;

procedure TFunkTableWin.FAuswahlClick(Sender: TObject);
  begin
  If Sender is TMenuItem then
    TMenuItem(Sender).Checked := Not TMenuItem(Sender).Checked;
  end;


procedure TFunkTableWin.RefreshTable(Sender: TObject);
  var tb : TTBaum;

  function IsValidTermIn(EditField : TEdit; var val: Double): Boolean;
    var s : String;
    begin
    s := EditField.Text;
    tb.BuildTree(s);
    If tb.is_okay then begin
      tb.Calculate(0, val);
      Result := tb.is_okay;
      end
    else begin
      Result := False;
      MessageDlg(Format(MyMess[139], [s]), mtError, [mbOk], 0);
      EditField.Text := Float2Str(val, LengthDecimals);
      end;
    end;

  begin
  tb := TTBaum.Create(Drawing, Rad);
  try
    If IsValidTermIn(Edit1, xmin) and
       IsValidTermIn(Edit2, xmax) and
       IsValidTermIn(Edit3, dx) then begin
      FTab.ColCount := CheckedFunkCount + 1;
      FTab.RowCount := Round((xmax - xmin)/dx) + 2;
      FTab.DefaultColWidth := (FTab.ClientWidth - 2) Div FTab.ColCount;
      FillTable;
      end;
  finally
    tb.Free;
  end;
  end;

procedure TFunkTableWin.UpdateData;
  var i : Integer;
  begin
  If Drawing <> THauptfenster(Owner).Drawing then begin
    Drawing := THauptfenster(Owner).Drawing;
    FunkLB.Clear;
    end
  else begin
    i := 0;
    While i < FunkLB.Count do begin
      If Drawing.IndexOf(FunkLB.Items.Objects[i]) < 0 then
        FunkLB.Items.Delete(i)
      else
        i := i + 1;
      end;
    end;
  { Jetzt enthält die Funktionsliste nur noch gültige alte Einträge. }
  For i := 5 to Pred(Drawing.Count) do
    if (TGeoObj(Drawing[i]) is TGFunktion) and
       (FunkLB.Items.IndexOfObject(Drawing[i]) < 0) then
      FunkLB.AddItem(TGeoObj(Drawing[i]).Name, Drawing[i]);
  { Jetzt enthält die Funktionsliste alle derzeit vorhandenen Funktionen. }
  If CheckedFunkCount = 0 then
    PostMessage(THauptfenster(Owner).Handle, cmd_ExternCommand,
                cmd_CloseFunkTable, 0)
  else
    RefreshTable(Nil);
  end;

procedure TFunkTableWin.FormActivate(Sender: TObject);
  begin
  UpdateData;
  end;

procedure TFunkTableWin.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
  PostMessage(THauptfenster(Owner).Handle, cmd_ExternCommand,
              cmd_CloseFunkTable, 0);
  Action := caFree;
  end;

procedure TFunkTableWin.FormCreate(Sender: TObject);
  var right_edge : Integer;
  begin
  right_edge := GroupBox1.Left + GroupBox1.Width + 9;
  If Constraints.MinWidth < right_edge then begin
    ClientWidth := right_edge;
    Constraints.MinWidth := Width;
    end;
  end;

procedure TFunkTableWin.Menu_KopierenClick(Sender: TObject);
  var buf  : String;
      i, k : Integer;
  begin
  buf := '';
  For i := 0 to Pred(FTab.RowCount) do begin
    buf := buf + FTab.Cells[0, i];
    For k := 1 to Pred(FTab.ColCount) do
      buf := buf + #9 + FTab.Cells[k, i];
    buf := buf + #13#10;  // Immer Umbruch am Ende der Zeile !
    end;
  Clipboard.AsText := buf;
  end;

procedure TFunkTableWin.Menu_SchliessenClick(Sender: TObject);
  begin
  Close;
  end;

end.
