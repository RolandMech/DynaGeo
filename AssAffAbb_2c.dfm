inherited AffAbb_2c_Dlg: TAffAbb_2c_Dlg
  Caption = 'Festlegen einer Affin-Drehung'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label2: TLabel
    Caption = 
      'Um eine Affin-Drehung zu definieren, m'#252'ssen Sie den Drehpunkt so' +
      'wie zwei Punkt-Bildpunkt-Paare angeben.'
  end
  inherited Label3: TLabel
    Top = 104
    Width = 337
    Height = 49
    Caption = 
      'Geben Sie zun'#228'chst den Drehpunkt (Fixpunkt) Ihrer Affin-Drehung ' +
      'an.'
  end
  inherited Label4: TLabel
    Top = 160
    Width = 337
    Caption = 
      'Geben Sie nun einen ersten Punkt an, der nicht zu dicht beim Dre' +
      'hpunkt liegt.'
  end
  inherited Label5: TLabel
    Top = 216
    Width = 337
    Height = 41
    Caption = 'Geben Sie dann den Bildpunkt des ersten Punktes an. '
  end
  object Label6: TLabel [5]
    Left = 56
    Top = 264
    Width = 337
    Height = 57
    AutoSize = False
    Caption = 
      'Geben Sie nun einen zweiten Punkt ein, der ebenfalls nicht zu di' +
      'cht beim Drehpunkt liegt.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label7: TLabel [6]
    Left = 56
    Top = 328
    Width = 313
    Height = 49
    AutoSize = False
    Caption = 'Geben Sie schlie'#223'lich den Bildpunkt des zweiten Punktes ein.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
end
