object TermEditDlg: TTermEditDlg
  Left = 694
  Top = 123
  Width = 459
  Height = 318
  HelpContext = 157
  BorderIcons = []
  Caption = 'Edit expression'
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 420
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 20
    Top = 20
    Width = 52
    Height = 20
    AutoSize = False
    Caption = 'Expression : '
  end
  object Okay: TButton
    Left = 115
    Top = 237
    Width = 105
    Height = 33
    Caption = 'Okay'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
    OnClick = OkayClick
  end
  object Cancel: TButton
    Left = 239
    Top = 237
    Width = 97
    Height = 33
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
    OnClick = CancelClick
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 53
    Width = 417
    Height = 172
    Caption = ' Display options : '
    TabOrder = 0
    object Label3: TGroupBox
      Visible = False
    end
    object Label1: TLabel
      Left = 52
      Top = 21
      Width = 293
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Number of digits :'
    end
    object EditComment: TEdit
      Left = 168
      Top = 80
      Width = 233
      Height = 21
      TabOrder = 2
      Text = 'EditComment'
    end
    object CB_ShowName: TCheckBox
      Left = 20
      Top = 40
      Width = 141
      Height = 20
      Caption = 'Name anzeigen'
      TabOrder = 0
    end
    object CB_ShowComment: TCheckBox
      Left = 20
      Top = 80
      Width = 141
      Height = 20
      Caption = 'Kommentar anzeigen :'
      TabOrder = 1
      OnClick = CB_ShowCommentClick
    end
    object SE_Decimals: TSpinEdit
      Left = 351
      Top = 18
      Width = 50
      Height = 22
      Hint = 'Range: 2...8'
      MaxValue = 8
      MinValue = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Value = 3
      OnKeyDown = SE_DecimalsKeyDown
    end
    object CB_ShowTerm: TCheckBox
      Left = 20
      Top = 60
      Width = 141
      Height = 20
      Caption = 'Show expression'
      TabOrder = 4
    end
    object RG_Format: TRadioGroup
      Left = 16
      Top = 115
      Width = 385
      Height = 42
      Caption = ' Output format : '
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'normal'
        'degrees'
        'multiples of pi')
      TabOrder = 5
    end
  end
  object EditTerm: TFormatEdit
    Left = 72
    Top = 16
    Width = 361
    Height = 25
    Cursor = crDefault
    ParentColor = False
    TabOrder = 3
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -15
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    WantReturns = False
  end
end
