object SymbolWin: TSymbolWin
  Left = 496
  Top = 130
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = ' Special chars to insert...'
  ClientHeight = 144
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Symbol'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SymbolGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 353
    Height = 121
    ColCount = 16
    DefaultColWidth = 20
    FixedCols = 0
    RowCount = 4
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 0
    OnDblClick = SymbolGridDblClick
    OnMouseDown = SymbolGridMouseDown
  end
end