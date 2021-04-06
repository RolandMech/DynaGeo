object Angles1Dlg: TAngles1Dlg
  Left = 960
  Top = 197
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'Spiel "Winkel sch'#228'tzen"'
  ClientHeight = 306
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 212
    Width = 67
    Height = 13
    Caption = 'Winkelweite : '
  end
  object Label2: TLabel
    Left = 184
    Top = 8
    Width = 138
    Height = 13
    Caption = 'Ergebnisse und Bewertung : '
  end
  object BtnEnde: TButton
    Left = 328
    Top = 265
    Width = 105
    Height = 33
    Caption = 'Spiel abbrechen'
    TabOrder = 0
    OnClick = BtnEndeClick
  end
  object BtnHelp: TButton
    Left = 184
    Top = 265
    Width = 105
    Height = 33
    Caption = 'Hilfe zum Spiel'
    TabOrder = 1
    OnClick = BtnHelpClick
  end
  object RGAngleGroup: TRadioGroup
    Left = 8
    Top = 8
    Width = 137
    Height = 177
    Caption = 'Art des Winkels:'
    Items.Strings = (
      'Nullwinkel'
      'Spitzer Winkel'
      'Rechter Winkel'
      'Stumpfer Winkel'
      'Gestreckter Winkel'
      #220'berstumpfer Winkel'
      'Vollwinkel')
    TabOrder = 2
    OnClick = RGAngleGroupClick
  end
  object StringGrid1: TStringGrid
    Left = 184
    Top = 34
    Width = 249
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
    TabOrder = 3
  end
  object BtnNextAngle: TButton
    Left = 8
    Top = 265
    Width = 129
    Height = 33
    Caption = 'N'#228'chster Winkel'
    TabOrder = 4
    OnClick = BtnNextAngleClick
  end
  object Ed_Angle: TEdit
    Left = 97
    Top = 209
    Width = 40
    Height = 21
    Hint = 'Einheit nicht vergessen!'
    Alignment = taCenter
    TabOrder = 5
    Text = '75'#176
  end
end
