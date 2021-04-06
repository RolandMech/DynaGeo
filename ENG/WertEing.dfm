object WertEingabeDlg: TWertEingabeDlg
  Left = 653
  Top = 123
  Width = 343
  Height = 144
  HelpContext = 79
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = []
  Caption = 'Enter a value :'
  Color = clBtnFace
  Constraints.MinHeight = 136
  Constraints.MinWidth = 343
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 16
    Top = 16
    Width = 303
    Height = 45
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 64
    Top = 73
    Width = 102
    Height = 27
    Caption = 'Okay'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 176
    Top = 73
    Width = 95
    Height = 27
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
    OnClick = CancelBtnClick
  end
  object Edit1: TFormatEdit
    Left = 28
    Top = 28
    Width = 277
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 2
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -15
    DefaultFont.Name = 'Times New Roman'
    DefaultFont.Style = []
    WantReturns = False
    OnExit = EditExit
  end
end
