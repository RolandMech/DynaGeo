object ObjNameDlg: TObjNameDlg
  Left = 725
  Top = 124
  HelpContext = 113
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Edit object name'
  ClientHeight = 254
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object NewName: TLabel
    Left = 7
    Top = 117
    Width = 46
    Height = 20
    Alignment = taCenter
    AutoSize = False
    Caption = 'Name :'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 296
    Height = 81
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 293
    object SB_Fett: TSpeedButton
      Left = 143
      Top = 40
      Width = 25
      Height = 25
      Hint = 'Bold'
      AllowAllUp = True
      GroupIndex = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        7E010000424D7E01000000000000760000002800000016000000160000000100
        0400000000000801000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF
        F7007FFFFFFFFFFFFF00FFFFF0000FFFFFFFFFFFFF00FFFFF0000FFFFFFFFFFF
        FF00FFFFF0000FFFFFFFFFFFFF00FFFFF0000FFFFFFFFFFFFF00FFFFF0000000
        07FFFFFFFF00FFFFF000000000FFFFFFFF00FFFFF000000000FFFFFFFF00FFFF
        F000000007FFFFFFFF00FFFFF0000FFFFFFFFFFFFF00FFFFF0000FFFFFFFFFFF
        FF00FFFFF0000FFFFFFFFFFFFF00FFFFF0000000000007FFFF00FFFFF0000000
        000000FFFF00FFFFF0000000000000FFFF00FFFFF7000000000007FFFF00FFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FF00}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = SB_FettClick
    end
    object SB_Kursiv: TSpeedButton
      Left = 169
      Top = 40
      Width = 25
      Height = 25
      Hint = 'Italic'
      AllowAllUp = True
      GroupIndex = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        7E010000424D7E01000000000000760000002800000016000000160000000100
        0400000000000801000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFF00FFFF00FFFF00FFFFFFFFFF00FFFF00FFFF00FFFFFFFF
        FF00FFFF00FFF00FFFFFFFFFFF00FFFFF00FF00FFFFFFFFFFF00FFFFF00F00FF
        FFFFFFFFFF00FFFFF00000FFFFFFFFFFFF00FFFFF0000FFFFFFFFFFFFF00FFFF
        FF0000FFFFFFFFFFFF00FFFFFF00F00FFFFFFFFFFF00FFFFFF00FF00FFFFFFFF
        FF00FFFFFF00FFF00FFFFFFFFF00FFFFFFF00FFF00FFFFFFFF00FFFFFFF00FFF
        F00FFFFFFF00FFFFFFF00FFFF00FFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FF00}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = SB_KursivClick
    end
    object SB_Unterstrichen: TSpeedButton
      Left = 195
      Top = 40
      Width = 25
      Height = 25
      Hint = 'Underlined'
      AllowAllUp = True
      GroupIndex = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        7E010000424D7E01000000000000760000002800000016000000160000000100
        0400000000000801000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF00000000000000FFFF00FFFF
        00000000000000FFFF00FFFF00000000000000FFFF00FFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFF7777FFFFFFFFF00FFFFFFF77777
        777FFFFFFF00FFFFFF777FFFF777FFFFFF00FFFFFF77FFFFFF77FFFFFF00FFFF
        FF77FFFFFF77FFFFFF00FFFFFF77FFFFFF77FFFFFF00FFFFFF77FFFFFF77FFFF
        FF00FFFFFF77FFFFFF77FFFFFF00FFFFFF77FFFFFF77FFFFFF00FFFFFF77FFFF
        FF77FFFFFF00FFFFFF77FFFFFF77FFFFFF00FFFFFF77FFFFFF77FFFFFF00FFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FF00}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = SB_UnterstrichenClick
    end
    object SB_Hochgestellt: TSpeedButton
      Left = 247
      Top = 40
      Width = 25
      Height = 25
      Hint = 'Superscript'
      AllowAllUp = True
      GroupIndex = 4
      Glyph.Data = {
        7E010000424D7E01000000000000760000002800000016000000160000000100
        0400000000000801000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFF77FFFFFF77FFFFFFF
        FF00FFF777FFFF777FFFFFFFFF00FFFF777FF777FFFFFFFFFF00FFFFF777777F
        FFFFFFFFFF00FFFFFF7777FFFFFFFFFFFF00FFFFFF7777FFFFFFFFFFFF00FFFF
        F777777FFF000000FF00FFFF777FF777FF000000FF00FFF777FFFF777FF00FFF
        FF00FFF77FFFFFF77FFF00FFFF00FFFFFFFFFFFFFFFFF00FFF00FFFFFFFFFFFF
        FFFFFF00FF00FFFFFFFFFFFFFF00FF00FF00FFFFFFFFFFFFFF000000FF00FFFF
        FFFFFFFFFFF0000FFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = SB_HochgestelltClick
    end
    object SB_Tiefgestellt: TSpeedButton
      Left = 221
      Top = 40
      Width = 25
      Height = 25
      Hint = 'Subscript'
      AllowAllUp = True
      GroupIndex = 4
      Glyph.Data = {
        7E010000424D7E01000000000000760000002800000016000000160000000100
        0400000000000801000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFF00FFF00FFFF
        FFFFFFFFFFFFF00FFF00FFFFFFFFFFFFFFFFF00FFF00FFF77FFFFFF77FFFF00F
        FF00FFF777FFFF777F0FF00FFF00FFFF777FF777FF00F00FFF00FFFFF777777F
        FFF0000FFF00FFFFFF7777FFFFFF000FFF00FFFFFF7777FFFFFFF00FFF00FFFF
        F777777FFFFFFFFFFF00FFFF777FF777FFFFFFFFFF00FFF777FFFF777FFFFFFF
        FF00FFF77FFFFFF77FFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = SB_TiefgestelltClick
    end
    object ComboBox1: TComboBox
      Left = 13
      Top = 10
      Width = 196
      Height = 21
      Hint = 'Font face'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = ComboBox1Change
    end
    object SpinEdit1: TSpinEdit
      Left = 226
      Top = 8
      Width = 47
      Height = 22
      Hint = 'Font size'
      EditorEnabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 2
      MaxValue = 99
      MinValue = 6
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 10
      OnChange = SpinEdit1Change
    end
    object Btn_SpecialChars: TButton
      Left = 15
      Top = 40
      Width = 105
      Height = 25
      Caption = 'Special chars'
      TabOrder = 2
      OnClick = Btn_SpecialCharsClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 200
    Width = 296
    Height = 54
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 293
    object CancelBtn: TButton
      Left = 152
      Top = 13
      Width = 81
      Height = 27
      Cancel = True
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = CancelBtnClick
    end
    object OkBtn: TButton
      Left = 56
      Top = 13
      Width = 81
      Height = 27
      Caption = 'Okay'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = OkBtnClick
    end
  end
  object FormatEdit1: TFormatEdit
    Left = 56
    Top = 87
    Width = 225
    Height = 106
    Cursor = crDefault
    ParentColor = False
    TabOrder = 2
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -11
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
  end
end
