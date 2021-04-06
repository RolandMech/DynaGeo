object RegisterDlg: TRegisterDlg
  Left = 355
  Top = 268
  HelpContext = 168
  BorderStyle = bsDialog
  Caption = 'Search for a license file'
  ClientHeight = 143
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 7
    Top = 79
    Width = 462
    Height = 6
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 13
    Top = 13
    Width = 157
    Height = 20
    AutoSize = False
    Caption = 'Path of license file :'
  end
  object CancelBtn: TButton
    Left = 313
    Top = 96
    Width = 113
    Height = 33
    Caption = 'Cancel'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 0
  end
  object RegisterBtn: TButton
    Left = 49
    Top = 96
    Width = 121
    Height = 33
    Caption = 'Register'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = RegisterBtnClick
  end
  object HelpButton: TButton
    Left = 185
    Top = 96
    Width = 113
    Height = 33
    Caption = 'Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = HelpButtonClick
  end
  object Edit1: TEdit
    Left = 13
    Top = 39
    Width = 345
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 371
    Top = 39
    Width = 91
    Height = 26
    Caption = 'Browse...'
    TabOrder = 4
    OnClick = Button1Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'DynaGeo Licence files (*.dgl)|*.dgl'
    Left = 536
    Top = 8
  end
end
