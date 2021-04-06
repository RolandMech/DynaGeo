object OkayButton: TOkayButton
  Left = 566
  Top = 167
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Ready ?'
  ClientHeight = 48
  ClientWidth = 219
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object OkayBtn: TButton
    Left = 7
    Top = 8
    Width = 202
    Height = 33
    Caption = 'Okay, I'#39'm ready !'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = OkayBtnClick
    OnKeyDown = OkayBtnKeyDown
  end
end
