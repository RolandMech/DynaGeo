unit Symbols;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, FormatEdit;

type
  TSymbolWin = class(TForm)
    SymbolGrid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure SymbolGridDblClick(Sender: TObject);
    procedure SymbolGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
    target     : TFormatEdit;
    rowCt,
    LCCx, LCCy : Integer;
  public
    { Public-Deklarationen }
    constructor CreateWD(iOwner: TComponent; iTarget: TFormatEdit;
                         iTopLeft: TPoint; iRows: Integer);
  end;

  
implementation

{$R *.dfm}

uses GlobVars, CommentWin;

{============ TSymbolWin ========================}

constructor TSymbolWin.CreateWD(iOwner: TComponent; iTarget: TFormatEdit;
                                iTopLeft: TPoint; iRows: Integer);
  begin
  Inherited Create(iOwner);
  target := iTarget;
  Left := iTopLeft.X;
  Top := iTopLeft.Y;
  rowCt := iRows;
  end;

procedure TSymbolWin.FormCreate(Sender: TObject);
  var i, k : Integer;
  begin
  With SymbolGrid do begin
    RowCount := rowCt;
    For k := 0 to Pred(RowCount) do // vertikal
      For i := 0 to 15 do   // horizontal
        Cells[i, k] := symTab[k+1, i+1];
    Cells[1, 2] := '||';
    ClientHeight := GridHeight;
    ClientWidth  := GridWidth;
    end;
  ClientWidth  := SymbolGrid.Width - 2;
  ClientHeight := SymbolGrid.Height - 2;
  end;

procedure TSymbolWin.SymbolGridDblClick(Sender: TObject);
  var s : String;
  begin
  s := SymbolGrid.Cells[LCCx, LCCy];
  target.Paste('<font face="Symbol">' + s + '</font>');
  (Owner as TForm).SetFocus;
  end;

procedure TSymbolWin.SymbolGridMouseDown(Sender: TObject; Button: TMouseButton;
                                         Shift: TShiftState; X, Y: Integer);
  begin
  SymbolGrid.MouseToCell(X, Y, LCCx, LCCy);
  end;

end.
