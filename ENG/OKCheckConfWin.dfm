object ConfigOKCheckDlg: TConfigOKCheckDlg
  Left = 624
  Top = 155
  BorderStyle = bsDialog
  Caption = 'Configure the correctness check :'
  ClientHeight = 379
  ClientWidth = 527
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 16
    Top = 12
    Width = 497
    Height = 313
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 24
    Top = 28
    Width = 241
    Height = 17
    AutoSize = False
    Caption = 'Condition of correctness : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 40
    Top = 84
    Width = 97
    Height = 57
    AutoSize = False
    Caption = 'Types of the variables used : '
    WordWrap = True
  end
  object Label3: TLabel
    Left = 24
    Top = 228
    Width = 225
    Height = 17
    AutoSize = False
    Caption = 'Links to the next drawing : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 40
    Top = 252
    Width = 89
    Height = 17
    AutoSize = False
    Caption = 'After success :'
  end
  object Label5: TLabel
    Left = 40
    Top = 284
    Width = 89
    Height = 17
    AutoSize = False
    Caption = 'After failure :'
  end
  object Label6: TLabel
    Left = 40
    Top = 164
    Width = 137
    Height = 17
    AutoSize = False
    Caption = 'Hint text :'
  end
  object OKBtn: TButton
    Left = 144
    Top = 340
    Width = 105
    Height = 25
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 262
    Top = 340
    Width = 107
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 5
  end
  object VLEditor: TValueListEditor
    Left = 144
    Top = 84
    Width = 225
    Height = 81
    KeyOptions = [keyUnique]
    Strings.Strings = (
      '@1=point'
      '@2=segment'
      '@3=line'
      '@4=circle'
      '@5=conic')
    TabOrder = 0
    TitleCaptions.Strings = (
      'variable'
      'type')
    ColWidths = (
      55
      147)
  end
  object Ed_LinkSuccess: TEdit
    Left = 144
    Top = 252
    Width = 345
    Height = 21
    TabOrder = 2
  end
  object Ed_LinkFail: TEdit
    Left = 144
    Top = 284
    Width = 345
    Height = 21
    TabOrder = 3
  end
  object Ed_Hint: TEdit
    Left = 40
    Top = 180
    Width = 449
    Height = 21
    TabOrder = 1
  end
  object Ed_Term: TFormatEdit
    Left = 40
    Top = 52
    Width = 449
    Height = 21
    Cursor = crDefault
    ParentColor = False
    TabOrder = 6
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -11
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    OnExit = Ed_TermExit
  end
end
