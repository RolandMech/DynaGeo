inherited AffAbb_2e_Dlg: TAffAbb_2e_Dlg
  Caption = 'Festlegen einer affinen Abbildung durch eine Matrix'
  ClientWidth = 430
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label2: TLabel
    Caption = 
      'Zur Festlegung einer Affinit'#228't durch eine Abbildungs-Matrix gebe' +
      'n Sie bitte die folgenden 6 Koeffizienten ein:'
  end
  inherited Label3: TLabel
    Left = 24
    Top = 136
    Width = 9
    Height = 32
    AutoSize = True
    Caption = '('
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = []
    ExplicitLeft = 24
    ExplicitTop = 136
    ExplicitWidth = 9
    ExplicitHeight = 32
  end
  object Label1: TLabel [3]
    Left = 56
    Top = 136
    Width = 34
    Height = 32
    Caption = ')=('
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel [4]
    Left = 232
    Top = 136
    Width = 26
    Height = 32
    Caption = ' )('
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel [5]
    Left = 280
    Top = 136
    Width = 34
    Height = 32
    Caption = ')+('
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel [6]
    Left = 392
    Top = 136
    Width = 9
    Height = 32
    Caption = ')'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel [7]
    Left = 80
    Top = 216
    Width = 289
    Height = 81
    AutoSize = False
    Caption = 
      'Die 6 Koeffizienten k'#246'nnen Konstanten sein, aber auch Terme, die' +
      ' Referenzen auf andere Objekte der Zeichnung enthalten.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label12: TLabel [8]
    Left = 80
    Top = 304
    Width = 289
    Height = 65
    AutoSize = False
    Caption = 
      'Der "Weiter"-Knopf ist nur aktiviert, wenn alle 6 Koeffizienten ' +
      'g'#252'ltige Konstanten oder Terme enthalten.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label8: TLabel [9]
    Left = 264
    Top = 152
    Width = 9
    Height = 16
    Caption = 'y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label6: TLabel [10]
    Left = 264
    Top = 136
    Width = 8
    Height = 16
    Caption = 'x'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  inherited Label4: TLabel
    Left = 40
    Top = 136
    Width = 12
    Height = 16
    AutoSize = True
    Caption = 'x'#39
    Visible = True
    ExplicitLeft = 40
    ExplicitTop = 136
    ExplicitWidth = 12
    ExplicitHeight = 16
  end
  inherited Label5: TLabel
    Left = 40
    Top = 152
    Width = 13
    Height = 16
    AutoSize = True
    Caption = 'y'#39
    Visible = True
    ExplicitLeft = 40
    ExplicitTop = 152
    ExplicitWidth = 13
    ExplicitHeight = 16
  end
  inherited OKBtn: TButton
    Enabled = True
    ModalResult = 0
    TabOrder = 6
    OnClick = OKBtnClick
  end
  inherited CancelBtn: TButton
    TabOrder = 8
  end
  inherited HelpBtn: TButton
    TabOrder = 7
  end
  object FormatEdit2: TFormatEdit
    Left = 96
    Top = 157
    Width = 68
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 1
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
  object FormatEdit3: TFormatEdit
    Left = 168
    Top = 132
    Width = 68
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 2
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
  object FormatEdit4: TFormatEdit
    Left = 168
    Top = 157
    Width = 68
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 3
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
  object FormatEdit1: TFormatEdit
    Left = 96
    Top = 132
    Width = 68
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 0
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
  object FormatEdit5: TFormatEdit
    Left = 320
    Top = 132
    Width = 68
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 4
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
  object FormatEdit6: TFormatEdit
    Left = 320
    Top = 156
    Width = 68
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 5
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
end
