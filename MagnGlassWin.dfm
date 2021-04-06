object MyMagnGlassWin: TMyMagnGlassWin
  Left = 1320
  Top = 197
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Funktionen-Lupe'
  ClientHeight = 333
  ClientWidth = 300
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 33
    Width = 300
    Height = 300
    Align = alClient
    Constraints.MinHeight = 300
    Constraints.MinWidth = 300
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 300
    Height = 33
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 9
      Width = 145
      Height = 18
      AutoSize = False
      Caption = 'Vergr'#246#223'erung : '
    end
    object Label2: TLabel
      Left = 167
      Top = 9
      Width = 122
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = '1024'
    end
  end
end
