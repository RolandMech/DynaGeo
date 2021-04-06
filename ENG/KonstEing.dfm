object KonstEingabeDlg: TKonstEingabeDlg
  Left = 360
  Top = 256
  HelpContext = 128
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Segment length :'
  ClientHeight = 97
  ClientWidth = 188
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 13
    Top = 8
    Width = 163
    Height = 45
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 143
    Top = 23
    Width = 27
    Height = 19
    AutoSize = False
    Caption = 'cm'
  end
  object OKBtn: TButton
    Left = 13
    Top = 62
    Width = 75
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
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 100
    Top = 62
    Width = 75
    Height = 27
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
    OnClick = CancelBtnClick
  end
  object Edit1: TEdit
    Left = 33
    Top = 20
    Width = 104
    Height = 21
    TabOrder = 2
    Text = '5'
  end
end
