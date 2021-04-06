object EditGroupWin: TEditGroupWin
  Left = 649
  Top = 120
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Neue Gruppe anlegen'
  ClientHeight = 287
  ClientWidth = 588
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 561
    Height = 65
    Caption = ' Gruppen-Name : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 0
    object Edit1: TEdit
      Left = 40
      Top = 24
      Width = 497
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Edit1'
    end
  end
  object GroupBox3: TGroupBox
    Left = 16
    Top = 80
    Width = 561
    Height = 145
    Caption = ' Sichtbarkeit : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 1
    object RB_static: TRadioButton
      Left = 24
      Top = 32
      Width = 249
      Height = 25
      Caption = 'statisch, mit folgendem Startwert :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = VisTypeClick
    end
    object RG_visible: TRadioGroup
      Left = 288
      Top = 20
      Width = 249
      Height = 41
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'sichtbar'
        'unsichtbar')
      ParentFont = False
      TabOrder = 1
    end
    object RB_dynamic: TRadioButton
      Left = 24
      Top = 72
      Width = 225
      Height = 25
      Caption = 'dynamisch, '#252'ber die Bedingung :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = VisTypeClick
    end
    object FormatEdit1: TFormatEdit
      Left = 48
      Top = 104
      Width = 489
      Height = 22
      Cursor = crDefault
      ParentColor = False
      TabOrder = 3
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -16
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      WantReturns = False
      WordWrap = False
      OnEnter = FormatEdit1Enter
      OnExit = FormatEdit1Exit
    end
  end
  object BtnAddObjs: TButton
    Left = 14
    Top = 240
    Width = 267
    Height = 33
    Caption = 'Objekte hinzuf'#252'gen / entfernen'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BtnAddObjsClick
  end
  object BtnCancel: TButton
    Left = 438
    Top = 240
    Width = 137
    Height = 33
    Caption = 'Abbrechen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BtnCancelClick
  end
  object BtnClose: TButton
    Left = 296
    Top = 240
    Width = 129
    Height = 33
    Caption = 'Schlie'#223'en'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BtnCloseClick
  end
end
