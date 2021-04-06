object ConstrTextWin: TConstrTextWin
  Left = 629
  Top = 132
  Width = 413
  Height = 319
  HelpContext = 92
  VertScrollBar.Tracking = True
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Construction text'
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnHide = FormHide
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object FormatEdit1: TFormatEdit
    Left = 8
    Top = 8
    Width = 377
    Height = 249
    Cursor = crDefault
    ParentColor = False
    TabOrder = 0
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -15
    DefaultFont.Name = 'Times New Roman'
    DefaultFont.Style = []
    WordWrap = False
    EditEnabled = False
    OnKeyDown = FormatEdit1KeyDown
    OnMouseDown = FormatEdit1MouseDown
  end
end
