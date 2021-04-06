object TagSelectDlg: TTagSelectDlg
  Left = 598
  Top = 137
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Select DynaGeoX object'
  ClientHeight = 273
  ClientWidth = 423
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 166
    Top = 239
    Width = 91
    Height = 26
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
  end
  object GroupBox1: TGroupBox
    Left = 7
    Top = 13
    Width = 410
    Height = 215
    Caption = ' Please decide if the actual construction ... '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 52
      Top = 46
      Width = 339
      Height = 39
      AutoSize = False
      Caption = 
        'the following list shows the GEO(X) files referred in the HTML f' +
        'ile; choose the one you want to be replaced!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label2: TLabel
      Left = 52
      Top = 169
      Width = 326
      Height = 40
      AutoSize = False
      Caption = 
        'then a new DynaGeoX object tag will be added to the end of the H' +
        'TML file.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object RadioButton1: TRadioButton
      Left = 13
      Top = 20
      Width = 371
      Height = 20
      Caption = '...should replace a drawing referred in the HTML file already;'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object ListBox1: TListBox
      Left = 52
      Top = 85
      Width = 306
      Height = 46
      ItemHeight = 13
      TabOrder = 1
      OnClick = ListBox1Click
    end
    object RadioButton2: TRadioButton
      Left = 13
      Top = 150
      Width = 358
      Height = 20
      Caption = '...should be added to the HTML file;'
      TabOrder = 2
    end
  end
end
