object HTMLGeometriaDataForm: THTMLGeometriaDataForm
  Left = 638
  Top = 126
  HelpContext = 40
  BorderStyle = bsDialog
  Caption = 'Zeichnung in Geometria-HTML-Seite speichern'
  ClientHeight = 310
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 7
    Width = 280
    Height = 20
    AutoSize = False
    Caption = 'Zielpfad f'#252'r die HTML-Datei :'
  end
  object Label3: TLabel
    Left = 13
    Top = 85
    Width = 241
    Height = 20
    AutoSize = False
    Caption = 'Text oberhalb des Geometria-Objekts :'
  end
  object Bevel1: TBevel
    Left = 6
    Top = 242
    Width = 514
    Height = 7
    Shape = bsBottomLine
  end
  object Label6: TLabel
    Left = 13
    Top = 189
    Width = 248
    Height = 20
    AutoSize = False
    Caption = 'Name des Autors:'
  end
  object EditTargetPath: TEdit
    Left = 26
    Top = 26
    Width = 352
    Height = 21
    TabOrder = 0
    Text = 'EditTargetPath'
  end
  object BtnBrowseHTML: TButton
    Left = 396
    Top = 26
    Width = 111
    Height = 23
    Caption = 'Durchsuchen...'
    TabOrder = 1
    OnClick = BtnBrowseHTMLClick
  end
  object PreText: TMemo
    Left = 26
    Top = 104
    Width = 352
    Height = 72
    TabOrder = 2
  end
  object BtnSave: TButton
    Left = 145
    Top = 264
    Width = 116
    Height = 33
    Caption = 'Speichern'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 3
  end
  object BtnCancel: TButton
    Left = 272
    Top = 264
    Width = 106
    Height = 33
    Caption = 'Abbrechen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 4
  end
  object GB_ViewerDimensions: TGroupBox
    Left = 396
    Top = 93
    Width = 111
    Height = 76
    Caption = ' Viewer-Fenster '
    TabOrder = 5
    object Label4: TLabel
      Left = 7
      Top = 20
      Width = 39
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Breite :'
    end
    object Label5: TLabel
      Left = 7
      Top = 46
      Width = 39
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'H'#246'he :'
    end
    object IEditWinWidth: TIntEdit
      Left = 52
      Top = 20
      Width = 46
      Height = 21
      TabOrder = 0
      Text = '350'
    end
    object IEditWinHeight: TIntEdit
      Left = 52
      Top = 46
      Width = 46
      Height = 21
      TabOrder = 1
      Text = '250'
    end
  end
  object EditAuthorName: TEdit
    Left = 26
    Top = 208
    Width = 352
    Height = 21
    TabOrder = 6
  end
  object RG_Style: TRadioGroup
    Left = 397
    Top = 177
    Width = 111
    Height = 59
    Caption = ' Darstellung im... '
    ItemIndex = 0
    Items.Strings = (
      'DynaGeo-Stil'
      'Geometria-Stil')
    TabOrder = 7
  end
  object CB_CopyApplet: TCheckBox
    Left = 26
    Top = 52
    Width = 319
    Height = 20
    Caption = '"geometria.jar" ins Zielverzeichnis kopieren (falls n'#246'tig)'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 8
  end
  object SaveHTMLFile: TSaveDialog
    Filter = 'HTML-Dateien (*.html)|*.html'
    Title = 'Als HTML-Seite speichern'
    Left = 24
    Top = 320
  end
end
