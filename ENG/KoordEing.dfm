object KoordEingabeDlg: TKoordEingabeDlg
  Left = 644
  Top = 225
  HelpContext = 42
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Enter the co-ordinates :'
  ClientHeight = 139
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = True
  Position = poMainFormCenter
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 465
    Height = 71
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 20
    Top = 20
    Width = 26
    Height = 20
    Alignment = taCenter
    AutoSize = False
    Caption = 'x : '
  end
  object Label2: TLabel
    Left = 20
    Top = 46
    Width = 26
    Height = 20
    Alignment = taCenter
    AutoSize = False
    Caption = 'y :'
  end
  object OKBtn: TButton
    Left = 128
    Top = 96
    Width = 108
    Height = 25
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
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 248
    Top = 96
    Width = 106
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 3
    OnClick = CancelBtnClick
  end
  object Edit1: TFormatEdit
    Left = 48
    Top = 20
    Width = 409
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 0
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -15
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    ScrollBars = ssNone
    WantReturns = False
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
  object Edit2: TFormatEdit
    Left = 48
    Top = 46
    Width = 409
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 1
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -15
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    ScrollBars = ssNone
    WantReturns = False
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
end
