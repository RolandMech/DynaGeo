object PrintPreview: TPrintPreview
  Left = 598
  Top = 159
  HelpContext = 205
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Print preview'
  ClientHeight = 362
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 340
    Height = 362
    Align = alClient
    Color = clWhite
    ParentColor = False
    OnPaint = PaintBox1Paint
  end
end
