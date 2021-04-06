object AskUser1Dlg: TAskUser1Dlg
  Left = 590
  Top = 127
  Width = 434
  Height = 446
  Caption = 'DynaGeo needs your help!'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 393
    Height = 97
    AutoSize = False
    Caption = 
      'DynaGeo cannot decide if the point %s will always lie on the lin' +
      'e %s. But thiis is absolutely necessary to get a correct definit' +
      'ion of the affine transformation. Please select one of the follo' +
      'wing 3 possibilities:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Panel1: TPanel
    Left = 24
    Top = 120
    Width = 377
    Height = 217
    TabOrder = 0
    object RadioButton1: TRadioButton
      Left = 16
      Top = 16
      Width = 337
      Height = 57
      Caption = 
        'Yes, I am sure the point will always lie on this line, no matter' +
        ' how the construction is dragged.'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      WordWrap = True
    end
    object RadioButton2: TRadioButton
      Left = 16
      Top = 80
      Width = 345
      Height = 65
      Caption = 
        'No, I am not sure. So DynaGeo should create a new point that is ' +
        'bound to the line and thus will lie on it always.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      WordWrap = True
    end
    object RadioButton3: TRadioButton
      Left = 16
      Top = 152
      Width = 345
      Height = 49
      Caption = 'I want to abort the definition of the affine transformation.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      WordWrap = True
    end
  end
  object Button1: TButton
    Left = 152
    Top = 360
    Width = 121
    Height = 33
    Caption = 'Okay'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
end
