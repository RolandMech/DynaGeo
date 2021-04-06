inherited AffAbb_2c_Dlg: TAffAbb_2c_Dlg
  Caption = 'Defining an affine rotation'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label2: TLabel
    Caption = 
      'An affine rotation is defined by a fixed point (the centre of ro' +
      'tation) and 2 pairs of point and image point.'
  end
  inherited Label3: TLabel
    Top = 104
    Width = 337
    Height = 49
    Caption = 
      'First specify the point that should be used as centre of the aff' +
      'ine rotation.'
  end
  inherited Label4: TLabel
    Top = 160
    Width = 337
    Caption = 'Then specify a first point, not too close to the centre.'
  end
  inherited Label5: TLabel
    Top = 216
    Width = 337
    Height = 41
    Caption = 'Now specify the impage point of this first point. '
  end
  object Label6: TLabel [5]
    Left = 56
    Top = 264
    Width = 337
    Height = 57
    AutoSize = False
    Caption = 'Then specify a second point, not too close to the centre too.'
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
    Caption = 'Finally specify the image point of the second point.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
end
