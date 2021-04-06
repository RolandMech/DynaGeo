object SelectXCmdForm: TSelectXCmdForm
  Left = 684
  Top = 126
  HelpContext = 1218
  BorderStyle = bsDialog
  Caption = 'Choose commands...'
  ClientHeight = 385
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 13
    Width = 195
    Height = 20
    AutoSize = False
    Caption = 'Available commands :'
  end
  object Bevel1: TBevel
    Left = 394
    Top = 7
    Width = 7
    Height = 370
    Shape = bsRightLine
  end
  object CmdListBox: TCheckListBox
    Left = 20
    Top = 39
    Width = 365
    Height = 282
    OnClickCheck = CmdListBoxClickCheck
    Columns = 2
    ItemHeight = 13
    Items.Strings = (
      'Point'
      'Point on a line'
      'Intersection of 2 lines'
      'Midpoint between 2 points'
      'Segement between 2 points'
      'Vector'
      'Line through 2 points'
      'Line in determined angle'
      'Perpendicular line'
      'Parallel line'
      'Perpendicular bisector'
      'Bisector'
      'Ray'
      'Circle from centre and peripheral point'
      'Circle with determined radius'
      'Polygon'
      'Snap point to line'
      'Unsnap point'
      'Reflect object in an axis'
      'Reflect object in a point'
      'Translate object'
      'Rotate object'
      'Dilate object'
      'Reflect object in a circle'
      'Record a locus line'
      'Delete obejct'
      'Measure distance'
      'Measure angle'
      'Measure area'
      'Save as...'
      'Start / stop animation'
      'Create textbox'
      'Create number object'
      'Create term object'
      'Macro'
      'Check correctness'
      'Ellipse'
      'Parabolal'
      'Hyperbola'
      'Function graph')
    TabOrder = 0
  end
  object BtnOkay: TButton
    Left = 416
    Top = 40
    Width = 89
    Height = 33
    Caption = 'Okay'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
  object BtnCancel: TButton
    Left = 416
    Top = 86
    Width = 89
    Height = 35
    Cancel = True
    Caption = 'Abort'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
  end
  object BtnDelSel: TButton
    Left = 148
    Top = 342
    Width = 117
    Height = 26
    Caption = 'Delete selection'
    TabOrder = 3
    OnClick = BtnDelSelClick
  end
end
