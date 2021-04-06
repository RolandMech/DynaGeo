object AniParamsWin: TAniParamsWin
  Left = 462
  Top = 122
  HelpContext = 212
  BorderStyle = bsDialog
  Caption = 'Animations-Parameter'
  ClientHeight = 194
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 13
    Top = 16
    Width = 92
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Steuer-Objekt : '
  end
  object CancelBtn: TButton
    Left = 171
    Top = 144
    Width = 113
    Height = 33
    Caption = 'Abbrechen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 3
  end
  object OkayBtn: TButton
    Left = 35
    Top = 144
    Width = 124
    Height = 33
    Caption = 'Okay'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = OkayBtnClick
  end
  object ComboBox1: TComboBox
    Left = 111
    Top = 13
    Width = 189
    Height = 21
    Hint = 'W'#228'hlen Sie das Zahlobjekt aus,\ndas die Animation steuern soll !'
    Style = csDropDownList
    TabOrder = 0
    OnSelect = ComboBox1Select
  end
  object Panel1: TPanel
    Left = 7
    Top = 52
    Width = 306
    Height = 72
    TabOrder = 1
    object Label1: TLabel
      Left = 13
      Top = 13
      Width = 85
      Height = 20
      AutoSize = False
      Caption = 'Untere Grenze :'
    end
    object Label3: TLabel
      Left = 208
      Top = 13
      Width = 79
      Height = 20
      AutoSize = False
      Caption = 'Obere Grenze :'
    end
    object Label4: TLabel
      Left = 111
      Top = 13
      Width = 78
      Height = 20
      AutoSize = False
      Caption = 'Schrittweite :'
    end
    object FloatEdit1: TFloatEdit
      Left = 13
      Top = 33
      Width = 85
      Height = 21
      TabOrder = 0
      Text = '-2'
      OnExit = FloatEdit1Exit
    end
    object FloatEdit3: TFloatEdit
      Left = 208
      Top = 33
      Width = 85
      Height = 21
      TabOrder = 2
      Text = '5'
      OnExit = FloatEdit3Exit
    end
    object FloatEdit2: TFloatEdit
      Left = 111
      Top = 33
      Width = 85
      Height = 21
      TabOrder = 1
      Text = '0,001'
      OnExit = FloatEdit2Exit
    end
  end
end
