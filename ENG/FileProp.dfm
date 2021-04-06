object FileProps: TFileProps
  Left = 647
  Top = 124
  BorderStyle = bsDialog
  Caption = 'Edit Copyright notice'
  ClientHeight = 287
  ClientWidth = 501
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 384
    Top = 13
    Width = 7
    Height = 260
    Shape = bsLeftLine
  end
  object GroupBox2: TGroupBox
    Left = 13
    Top = 14
    Width = 352
    Height = 124
    Caption = ' Copyright text '
    TabOrder = 1
    object ShowEditCaps: TLabel
      Left = 235
      Top = 13
      Width = 104
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = '(not editable)'
    end
    object Memo1: TMemo
      Left = 13
      Top = 33
      Width = 326
      Height = 78
      TabOrder = 0
      OnChange = Memo1Change
    end
  end
  object BtnOkay: TButton
    Left = 403
    Top = 20
    Width = 85
    Height = 33
    Caption = 'Okay'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = BtnOkayClick
  end
  object GroupBox1: TGroupBox
    Left = 13
    Top = 149
    Width = 352
    Height = 124
    Caption = ' Actual file attributes '
    TabOrder = 2
    object Label1: TLabel
      Left = 65
      Top = 20
      Width = 53
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Name : '
    end
    object DName: TLabel
      Left = 124
      Top = 20
      Width = 221
      Height = 20
      AutoSize = False
      Caption = 'DName'
      ShowAccelChar = False
    end
    object Label2: TLabel
      Left = 8
      Top = 79
      Width = 110
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'with the program : '
    end
    object DProgVersion: TLabel
      Left = 124
      Top = 79
      Width = 221
      Height = 19
      AutoSize = False
      Caption = 'DProgVersion'
    end
    object Label3: TLabel
      Left = 7
      Top = 40
      Width = 111
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Creation date : '
    end
    object DCreateDat: TLabel
      Left = 124
      Top = 40
      Width = 130
      Height = 19
      AutoSize = False
      Caption = 'DCreateDat'
    end
    object Label5: TLabel
      Left = 7
      Top = 59
      Width = 111
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Last change date : '
    end
    object DChangeDat: TLabel
      Left = 124
      Top = 59
      Width = 124
      Height = 20
      AutoSize = False
      Caption = 'DChangeDat'
    end
    object Label4: TLabel
      Left = 59
      Top = 98
      Width = 59
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Size : '
    end
    object DSize: TLabel
      Left = 124
      Top = 98
      Width = 91
      Height = 20
      Hint = '(bytes)'
      AutoSize = False
      Caption = 'DSize'
    end
  end
  object BtnCancel: TButton
    Left = 403
    Top = 65
    Width = 85
    Height = 33
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 3
  end
end
