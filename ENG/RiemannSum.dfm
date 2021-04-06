object RiemannForm: TRiemannForm
  Left = 511
  Top = 121
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Create a Riemann sum'
  ClientHeight = 193
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 80
    Width = 185
    Height = 25
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Kind of Riemann sum: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 185
    Height = 25
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Number of intervals: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 128
    Width = 385
    Height = 9
    Shape = bsTopLine
  end
  object Button1: TButton
    Left = 64
    Top = 144
    Width = 121
    Height = 33
    Caption = 'Okay'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 208
    Top = 144
    Width = 113
    Height = 33
    Caption = 'Abort'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object RadioGroup1: TRadioGroup
    Left = 208
    Top = 56
    Width = 137
    Height = 57
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 1
    Items.Strings = (
      'upper sum'
      'lower sum')
    ParentFont = False
    TabOrder = 2
  end
  object EditTerm: TFormatEdit
    Left = 208
    Top = 24
    Width = 137
    Height = 22
    Cursor = crDefault
    ParentColor = False
    TabOrder = 3
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
  end
end
