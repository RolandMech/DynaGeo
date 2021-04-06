inherited AffAbb_2d_Dlg: TAffAbb_2d_Dlg
  Caption = 'Defining a general affinity'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label2: TLabel
    Width = 313
    Height = 129
    Caption = 
      'A general affinity is defined by 3 pairs of point and image poin' +
      't. You must make sure that any 2 of the 3 source points do not c' +
      'oincide. The same must be true for the 3 image points.'
  end
  inherited Label3: TLabel
    Top = 168
    Height = 25
    Caption = 'Specify the first point.'
  end
  inherited Label4: TLabel
    Height = 25
    Caption = 'Specify the appropriate image point.'
  end
  inherited Label5: TLabel
    Top = 240
    Height = 25
    Caption = 'Specify the second point.'
  end
  object Label6: TLabel [5]
    Left = 56
    Top = 264
    Width = 321
    Height = 25
    AutoSize = False
    Caption = 'Specify the appropriate image point.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
    WordWrap = True
  end
  object Label7: TLabel [6]
    Left = 56
    Top = 312
    Width = 321
    Height = 25
    AutoSize = False
    Caption = 'Specify the third point.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
    WordWrap = True
  end
  object Label8: TLabel [7]
    Left = 56
    Top = 336
    Width = 321
    Height = 25
    AutoSize = False
    Caption = 'Specify the appropriate image point.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
    WordWrap = True
  end
end
