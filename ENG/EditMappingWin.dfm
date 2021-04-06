object EditMappingDlg: TEditMappingDlg
  Left = 573
  Top = 123
  Caption = 'Edit affine mapping'
  ClientHeight = 228
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 104
    Width = 34
    Height = 32
    Caption = ')=('
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 40
    Top = 104
    Width = 12
    Height = 16
    Caption = 'x'#39
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label5: TLabel
    Left = 40
    Top = 120
    Width = 13
    Height = 16
    Caption = 'y'#39
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 24
    Top = 104
    Width = 9
    Height = 32
    Caption = '('
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label8: TLabel
    Left = 264
    Top = 120
    Width = 9
    Height = 16
    Caption = 'y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label6: TLabel
    Left = 264
    Top = 104
    Width = 8
    Height = 16
    Caption = 'x'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label9: TLabel
    Left = 280
    Top = 104
    Width = 34
    Height = 32
    Caption = ')+('
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 392
    Top = 104
    Width = 9
    Height = 32
    Caption = ')'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 232
    Top = 104
    Width = 26
    Height = 32
    Caption = ' )('
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object InfoLbl: TLabel
    Left = 32
    Top = 16
    Width = 361
    Height = 73
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Bevel1: TBevel
    Left = 16
    Top = 160
    Width = 393
    Height = 9
    Shape = bsBottomLine
  end
  object FormatEdit1: TFormatEdit
    Left = 96
    Top = 100
    Width = 68
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 0
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
  object FormatEdit3: TFormatEdit
    Left = 168
    Top = 100
    Width = 68
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 1
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
  object FormatEdit4: TFormatEdit
    Left = 168
    Top = 125
    Width = 68
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 2
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
  object FormatEdit2: TFormatEdit
    Left = 96
    Top = 125
    Width = 68
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 3
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
  object FormatEdit5: TFormatEdit
    Left = 320
    Top = 100
    Width = 68
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 4
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
  object FormatEdit6: TFormatEdit
    Left = 320
    Top = 124
    Width = 68
    Height = 20
    Cursor = crDefault
    ParentColor = False
    TabOrder = 5
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    WordWrap = False
    OnEnter = MyEditEnter
    OnExit = MyEditExit
  end
  object Okay_Btn: TButton
    Left = 96
    Top = 184
    Width = 113
    Height = 33
    Caption = 'Okay'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 6
    OnClick = Okay_BtnClick
  end
  object Cancel_Btn: TButton
    Left = 224
    Top = 184
    Width = 113
    Height = 33
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 7
    OnClick = Cancel_BtnClick
  end
end
