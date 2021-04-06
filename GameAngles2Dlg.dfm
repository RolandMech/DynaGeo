object Angles2Dlg: TAngles2Dlg
  Left = 940
  Top = 180
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Spiel "Winkel mit dem Geodreieck messen"'
  ClientHeight = 267
  ClientWidth = 531
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 256
    Top = 6
    Width = 138
    Height = 13
    Caption = 'Ergebnisse und Bewertung : '
  end
  object Label1: TLabel
    Left = 16
    Top = 108
    Width = 125
    Height = 13
    Caption = 'Gemessene Winkelweite : '
  end
  object Label3: TLabel
    Left = 16
    Top = 8
    Width = 125
    Height = 13
    Caption = 'Position des Geodreiecks :'
  end
  object StringGrid1: TStringGrid
    Left = 256
    Top = 32
    Width = 257
    Height = 209
    Margins.Left = 5
    Margins.Top = 1
    Margins.Right = 5
    Margins.Bottom = 1
    ColCount = 4
    DefaultColWidth = 60
    DefaultRowHeight = 16
    Enabled = False
    FixedCols = 0
    RowCount = 12
    TabOrder = 0
    ColWidths = (
      60
      58
      68
      60)
  end
  object Ed_Angle: TEdit
    Left = 147
    Top = 105
    Width = 54
    Height = 21
    Hint = 'Einheit nicht vergessen!'
    Alignment = taCenter
    TabOrder = 1
    Text = '75'#176
  end
  object BtnNextAngle: TButton
    Left = 136
    Top = 145
    Width = 105
    Height = 33
    Caption = 'N'#228'chster Winkel'
    TabOrder = 2
    OnClick = BtnNextAngleClick
  end
  object BtnHelp: TButton
    Left = 16
    Top = 208
    Width = 105
    Height = 33
    Caption = 'Hilfe zum Spiel'
    TabOrder = 3
    OnClick = BtnHelpClick
  end
  object BtnEnde: TButton
    Left = 136
    Top = 208
    Width = 105
    Height = 33
    Caption = 'Spiel abbrechen'
    TabOrder = 4
    OnClick = BtnEndeClick
  end
  object CB_MidPt: TCheckBox
    Left = 16
    Top = 32
    Width = 209
    Height = 17
    Caption = 'Mittelpunkt auf dem Winkelscheitel'
    Enabled = False
    TabOrder = 5
  end
  object CB_Ruler: TCheckBox
    Left = 16
    Top = 55
    Width = 209
    Height = 18
    Caption = 'Lange Kante liegt auf dem 1. Schenkel'
    Enabled = False
    TabOrder = 6
  end
end
