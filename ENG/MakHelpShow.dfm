object MakHelpWin: TMakHelpWin
  Left = 352
  Top = 233
  HelpContext = 140
  ActiveControl = Okay
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Macro help text'
  ClientHeight = 200
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 7
    Top = 7
    Width = 299
    Height = 156
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    TabOrder = 0
  end
  object Okay: TButton
    Left = 111
    Top = 168
    Width = 91
    Height = 28
    Caption = 'Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
end
