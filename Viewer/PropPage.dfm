object DGXPropPage1: TDGXPropPage1
  Left = 494
  Top = 150
  Width = 381
  Height = 152
  Caption = 'DynaGeoX-Eigenschaften'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 26
    Width = 189
    Height = 40
    AutoSize = False
    Caption = 
      'Tragen Sie hier die GEOX-Datei ein, in der Ihre Zeichnung gespei' +
      'chert ist :  '
    WordWrap = True
  end
  object Ed_DataFile: TEdit
    Left = 13
    Top = 78
    Width = 345
    Height = 21
    TabOrder = 0
    Text = 'Ed_DataFile'
  end
  object Btn_Browse: TButton
    Left = 254
    Top = 26
    Width = 104
    Height = 27
    Caption = 'Durchsuchen...'
    TabOrder = 1
    OnClick = Btn_BrowseClick
  end
  object OpenDialog1: TOpenDialog
    Filter = 'DynaGeo-Dateien|*.geox;*.geo'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 216
    Top = 40
  end
end
