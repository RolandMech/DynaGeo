inherited AffAbb_2a_Dlg: TAffAbb_2a_Dlg
  Left = 617
  Top = 212
  Caption = 'Festlegen einer Euler'#39'schen Affinit'#228't'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label2: TLabel
    Caption = 
      'Eine Euler'#39'sche Affinit'#228't hat zwei Fixgeraden, die sich in dem e' +
      'inzigen Fixpunkt der Abbildung schneiden. '
  end
  inherited Label3: TLabel
    Top = 112
    Caption = 
      'Geben Sie zun'#228'chst eine Geraden an, die eine Fixgerade Ihrer Eul' +
      'er'#39'schen Affinit'#228't werden soll.'
  end
  inherited Label4: TLabel
    Top = 184
    Height = 57
    Caption = 
      'Geben Sie nun eine zweite Gerade ein, die die erste Gerade in ge' +
      'nau einem Punkt schneidet. '
  end
  inherited Label5: TLabel
    Top = 256
    Height = 49
    Caption = 
      'Geben Sie nun einen Punkt an, der auf keiner der beiden Fixgerad' +
      'en liegt.'
  end
  object Label6: TLabel [5]
    Left = 56
    Top = 320
    Width = 321
    Height = 65
    AutoSize = False
    Caption = 
      'Geben Sie als letztes den Bildpunkt des zuvor angegebenen Punkte' +
      's an. Er darf ebenfalls nicht auf einer der Fixgeraden liegen. '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
end
