inherited AffAbb_1_Dlg: TAffAbb_1_Dlg
  Left = 592
  Top = 205
  BorderIcons = []
  Caption = 'Assistent f'#252'r das Erstellen affiner Abbildungen'
  ClientHeight = 432
  ClientWidth = 426
  FormStyle = fsStayOnTop
  Position = poDefault
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Left = 10
    Width = 409
    Height = 385
    ExplicitLeft = 10
    ExplicitWidth = 409
    ExplicitHeight = 385
  end
  object Label2: TLabel [1]
    Left = 56
    Top = 24
    Width = 289
    Height = 49
    AutoSize = False
    Caption = 
      'W'#228'hlen Sie bitte zun'#228'chst die Art der gew'#252'nschten affinen Abbild' +
      'ung aus:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label1: TLabel [2]
    Left = 32
    Top = 88
    Width = 323
    Height = 16
    Caption = 'Affinit'#228'ten mit einer Fixpunkt-Geraden (Achse) :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel [3]
    Left = 32
    Top = 216
    Width = 255
    Height = 16
    Caption = 'Affinit'#228'ten mit genau einem Fixpunkt :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel [4]
    Left = 32
    Top = 296
    Width = 142
    Height = 16
    Caption = 'Allgemeine Affinit'#228't :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited OKBtn: TButton
    Left = 328
    Top = 400
    Width = 89
    Caption = 'Weiter >>'
    TabOrder = 8
    ExplicitLeft = 328
    ExplicitTop = 400
    ExplicitWidth = 89
  end
  inherited CancelBtn: TButton
    Left = 8
    Top = 400
    Width = 73
    TabOrder = 10
    ExplicitLeft = 8
    ExplicitTop = 400
    ExplicitWidth = 73
  end
  object HelpBtn: TButton
    Left = 86
    Top = 400
    Width = 75
    Height = 25
    Caption = '&Hilfe'
    TabOrder = 9
    OnClick = HelpBtnClick
  end
  object RB_Scherung: TRadioButton
    Tag = 1
    Left = 64
    Top = 112
    Width = 257
    Height = 17
    Caption = 'Scherung'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
  object RB_OrthAxStreckung: TRadioButton
    Tag = 2
    Left = 64
    Top = 136
    Width = 257
    Height = 17
    Caption = 'Orthogonale axiale Streckung'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object RB_SchraegSpiegelung: TRadioButton
    Tag = 3
    Left = 64
    Top = 160
    Width = 257
    Height = 17
    Caption = 'Schr'#228'gspiegelung'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object RB_AllgAxAff: TRadioButton
    Tag = 4
    Left = 64
    Top = 184
    Width = 257
    Height = 17
    Caption = 'Allgemeine axiale Affinit'#228't'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object RB_EulerAff: TRadioButton
    Tag = 5
    Left = 64
    Top = 240
    Width = 209
    Height = 17
    Caption = 'Euler'#39'sche Affinit'#228't'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object RB_AffDrehung: TRadioButton
    Tag = 6
    Left = 64
    Top = 264
    Width = 209
    Height = 17
    Caption = 'Affin-Drehung'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object RB_AllgAff6Pt: TRadioButton
    Tag = 7
    Left = 64
    Top = 320
    Width = 305
    Height = 17
    Caption = 'festgelegt durch 3 Punkt-Bildpunkt-Paare'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object RB_AllgAffMat: TRadioButton
    Tag = 8
    Left = 64
    Top = 344
    Width = 305
    Height = 17
    Caption = 'festgelegt durch 6 Koeffizienten (Matrix)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
end
