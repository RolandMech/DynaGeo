object QuantPtWin: TQuantPtWin
  Left = 609
  Top = 210
  HelpContext = 239
  BorderIcons = [biHelp]
  BorderStyle = bsDialog
  Caption = 'Step width when dragged'
  ClientHeight = 191
  ClientWidth = 383
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
  object BtnAbort: TButton
    Left = 264
    Top = 150
    Width = 105
    Height = 27
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 3
    ParentFont = False
    TabOrder = 0
  end
  object BtnHelp: TButton
    Left = 144
    Top = 150
    Width = 105
    Height = 27
    Caption = 'Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BtnHelpClick
  end
  object BtnOkay: TButton
    Left = 16
    Top = 150
    Width = 113
    Height = 27
    Caption = 'Okay'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 2
    OnClick = BtnOkayClick
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 16
    Width = 353
    Height = 121
    Caption = ' When this point is dragged, it should...  '
    TabOrder = 3
    object Label1: TLabel
      Left = 39
      Top = 85
      Width = 85
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Step width : '
      Enabled = False
      Visible = False
    end
    object RB_Smooth: TRadioButton
      Left = 13
      Top = 26
      Width = 326
      Height = 20
      Caption = ' ....move most smoothly across the screen'
      TabOrder = 0
      OnClick = RB_SmoothClick
    end
    object RB_Stepped: TRadioButton
      Left = 13
      Top = 59
      Width = 326
      Height = 20
      Caption = ' ....jump in steps of the following width:'
      TabOrder = 1
      OnClick = RB_SteppedClick
    end
    object FE_Quant: TFloatEdit
      Left = 130
      Top = 83
      Width = 85
      Height = 21
      Hint = 'Step width in logical units'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = '0'
    end
  end
end
