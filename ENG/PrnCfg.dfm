object PrinterCfgDlg: TPrinterCfgDlg
  Left = 571
  Top = 120
  HelpContext = 105
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Printer options'
  ClientHeight = 296
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 295
    Top = 8
    Width = 7
    Height = 281
    Shape = bsLeftLine
  end
  object BtnClose: TButton
    Left = 312
    Top = 200
    Width = 105
    Height = 33
    Caption = 'Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 0
  end
  object BtnPrint: TButton
    Left = 312
    Top = 152
    Width = 105
    Height = 33
    Caption = 'Print'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 6
    ParentFont = False
    TabOrder = 1
  end
  object BtnCancel: TButton
    Left = 312
    Top = 248
    Width = 105
    Height = 33
    Caption = 'Abort'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
  end
  object BtnPreview: TButton
    Left = 312
    Top = 22
    Width = 105
    Height = 33
    Caption = 'Preview...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BtnPreviewClick
  end
  object PaperOutFormat: TRadioGroup
    Left = 16
    Top = 16
    Width = 265
    Height = 89
    Caption = ' Output format : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Portrait, upper half of page'
      'Portrait, full page'
      'Landscape, full page')
    ParentFont = False
    TabOrder = 4
    OnClick = PaperOutFormatClick
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 112
    Width = 265
    Height = 73
    Caption = ' Output window : '
    TabOrder = 5
    object Label2: TLabel
      Left = 29
      Top = 21
      Width = 105
      Height = 20
      AutoSize = False
      Caption = 'Scaling factor : '
    end
    object Label3: TLabel
      Left = 29
      Top = 45
      Width = 105
      Height = 20
      AutoSize = False
      Caption = 'rel. border width (%) : '
    end
    object SkalFaktor: TEdit
      Left = 146
      Top = 21
      Width = 103
      Height = 21
      TabOrder = 0
      Text = 'SkalFaktor'
      OnExit = SkalFaktorExit
    end
    object RandBreite: TEdit
      Left = 146
      Top = 44
      Width = 103
      Height = 21
      TabOrder = 1
      Text = 'RandBreite'
      OnExit = RandBreiteExit
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 192
    Width = 265
    Height = 89
    Caption = ' Active printer : '
    TabOrder = 6
    object BtnEditPrinter: TButton
      Left = 13
      Top = 48
      Width = 236
      Height = 25
      Caption = 'Configure / change printer ...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnEditPrinterClick
    end
    object ActPrinter: TEdit
      Left = 13
      Top = 18
      Width = 236
      Height = 21
      ReadOnly = True
      TabOrder = 1
      Text = 'ActPrinter'
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 232
    Top = 56
  end
end
