object AddMemberWin: TAddMemberWin
  Left = 519
  Top = 127
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Edit a visibility group'
  ClientHeight = 166
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefault
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 104
    Width = 481
    Height = 9
    Shape = bsTopLine
  end
  object BtnOkay: TButton
    Left = 113
    Top = 120
    Width = 137
    Height = 33
    Caption = 'Okay'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 0
    OnClick = BtnOkayClick
  end
  object BtnCancel: TButton
    Left = 265
    Top = 120
    Width = 121
    Height = 33
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
    OnClick = BtnCancelClick
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 16
    Width = 273
    Height = 81
    AutoSize = False
    Caption = 
      'Clicking any object will toggle its blinking mode. When you fina' +
      'lly click "Okay", then all blinking objects will be added to the' +
      ' visibility group. '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object BtnSelectAll: TButton
    Left = 312
    Top = 16
    Width = 169
    Height = 33
    Caption = 'Select all objects'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = BtnSelectAllClick
  end
  object BtnUnselectAll: TButton
    Left = 312
    Top = 56
    Width = 169
    Height = 33
    Caption = 'Unselect all objects'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = BtnUnselectAllClick
  end
end
