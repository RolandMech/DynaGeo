inherited AffAbb_2a_Dlg: TAffAbb_2a_Dlg
  Left = 617
  Top = 212
  Caption = 'Defining a scaling'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label2: TLabel
    Caption = 
      'A scaling has 2 fixed lines that intersect in the only fixed poi' +
      'nt of this transformation. '
  end
  inherited Label3: TLabel
    Top = 112
    Caption = 
      'First specify the line that should be used as first fixed line o' +
      'f the scaling.'
  end
  inherited Label4: TLabel
    Top = 184
    Height = 57
    Caption = 
      'Then specify another line (not parallel to the first one!) that ' +
      'should be the second fixed line. '
  end
  inherited Label5: TLabel
    Top = 256
    Height = 49
    Caption = 
      'Now specify a point which does not lie on any of the fixed lines' +
      '.'
  end
  object Label6: TLabel [5]
    Left = 56
    Top = 320
    Width = 321
    Height = 65
    AutoSize = False
    Caption = 
      'Finally specify the appropriate image point that must not lie on' +
      ' one of the fixed lines too. '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
end
