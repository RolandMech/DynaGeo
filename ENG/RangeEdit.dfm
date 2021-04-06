object RangeEditWin: TRangeEditWin
  Left = 681
  Top = 122
  BorderStyle = bsDialog
  Caption = 'Edit number object'
  ClientHeight = 181
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 13
    Width = 85
    Height = 20
    AutoSize = False
    Caption = 'Lower bound :'
  end
  object Label2: TLabel
    Left = 111
    Top = 13
    Width = 91
    Height = 20
    AutoSize = False
    Caption = 'Actual value :'
  end
  object Label3: TLabel
    Left = 215
    Top = 13
    Width = 78
    Height = 20
    AutoSize = False
    Caption = 'Upper bound :'
  end
  object FloatEdit1: TFloatEdit
    Left = 13
    Top = 39
    Width = 85
    Height = 21
    TabOrder = 0
    Text = '-2'
    OnExit = FloatEdit1Exit
  end
  object FloatEdit2: TFloatEdit
    Left = 111
    Top = 39
    Width = 91
    Height = 21
    TabOrder = 1
    Text = '1,5'
    OnExit = FloatEdit2Exit
  end
  object FloatEdit3: TFloatEdit
    Left = 215
    Top = 39
    Width = 78
    Height = 21
    TabOrder = 2
    Text = '5'
    OnExit = FloatEdit3Exit
  end
  object Button1: TButton
    Left = 160
    Top = 136
    Width = 113
    Height = 34
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 4
  end
  object OkayBtn: TButton
    Left = 32
    Top = 136
    Width = 113
    Height = 34
    Caption = 'Okay'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = OkayBtnClick
  end
  object GroupBox1: TGroupBox
    Left = 13
    Top = 78
    Width = 280
    Height = 46
    Caption = ' Step width: '
    TabOrder = 5
    object CheckBox1: TCheckBox
      Left = 13
      Top = 20
      Width = 157
      Height = 13
      Caption = 'set quantisation value :'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object FloatEdit4: TFloatEdit
      Left = 182
      Top = 16
      Width = 79
      Height = 21
      TabOrder = 1
      Text = '0'
      OnExit = FloatEdit4Exit
    end
  end
end
