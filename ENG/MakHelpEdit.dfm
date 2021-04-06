object MakHelpDlg: TMakHelpDlg
  Left = 304
  Top = 227
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Macro description'
  ClientHeight = 210
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 13
    Width = 53
    Height = 20
    AutoSize = False
    Caption = 'Name :'
  end
  object Label2: TLabel
    Left = 13
    Top = 39
    Width = 72
    Height = 20
    AutoSize = False
    Caption = 'Help text :'
  end
  object Bevel1: TBevel
    Left = 273
    Top = 7
    Width = 7
    Height = 195
    Shape = bsLeftLine
  end
  object Edit1: TEdit
    Left = 72
    Top = 13
    Width = 182
    Height = 24
    TabOrder = 0
    Text = ''
  end
  object Memo1: TMemo
    Left = 13
    Top = 59
    Width = 241
    Height = 137
    TabOrder = 1
  end
  object Okay: TButton
    Left = 288
    Top = 13
    Width = 83
    Height = 28
    Caption = 'Okay'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = OkayClick
  end
  object Abbrechen: TButton
    Left = 288
    Top = 59
    Width = 83
    Height = 30
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = AbbrechenClick
  end
end
