object EditMenuConfigWin: TEditMenuConfigWin
  Left = 474
  Top = 123
  HelpContext = 31
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Edit menu configuration'
  ClientHeight = 447
  ClientWidth = 714
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 54
    Width = 209
    Height = 20
    AutoSize = False
    Caption = 'List of deactivated commands :'
    WordWrap = True
  end
  object Label4: TLabel
    Left = 13
    Top = 16
    Width = 156
    Height = 17
    AutoSize = False
    Caption = 'Name of the menu configuration:'
    WordWrap = True
  end
  object Bevel1: TBevel
    Left = 16
    Top = 384
    Width = 681
    Height = 9
    Shape = bsTopLine
  end
  object CheckListBox1: TCheckListBox
    Left = 16
    Top = 72
    Width = 681
    Height = 297
    Columns = 3
    ItemHeight = 13
    Items.Strings = (
      'Load drawing'
      'Save drawing'
      'Save drawing as'
      'Printer options'
      'Print'
      'Enlarge drawing'
      'Reduce drawing'
      'Move drawing'
      'Snap point to line'
      'Undo snap point to line'
      'Point on a line'
      'Point with fixed co-ordinates'
      'Basic straight line'
      'Basic circle'
      'Triangle'
      'Polygon'
      'Trace line'
      'Midpoint'
      'Line segment of fixed length'
      'Perpendicular bisector'
      'Bisector'
      'Parallel line'
      'Perpendicular'
      'Line of determined angle'
      'Circle with determined radius'
      'Vector'
      'Reflect object in an axis'
      'Reflect object in a point'
      'Translate an object'
      'Rotate an object'
      'Dilate an object'
      'Reflect an object in a circle'
      'Measure distance'
      'Measure angle'
      'Measure area'
      'Create term object'
      'Create number object'
      'Mark angle'
      'Fix point'
      'Fix point to a gridpoint'
      'Unfix point'
      'Edit the co-ordinate system'
      'Create new macro'
      'Edit macro description'
      'Delete macro'
      'Load macro'
      'Save macro'
      'Show construction text'
      'Function graph'
      'Tangent to a curve'
      'Area under a function graph'
      'Ellipse from 2 focal points and 1point'
      'Ellipse from centre point and 2 vertizes'
      'Ellipse from centre and 2 conjugate points'
      'Parabola from focal point and directrix'
      'Parabola from 2 curve points and their tangent directions'
      'Hyperbola from 2 focal points and 1 point'
      'Hyperbola from 2 asymptotes and 1 point'
      'Conic through 5 points'
      'Polar line'
      'Polar point')
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 181
    Top = 15
    Width = 324
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object btnSave: TButton
    Left = 206
    Top = 400
    Width = 98
    Height = 33
    Caption = 'Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 430
    Top = 400
    Width = 98
    Height = 33
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 3
  end
  object btnHelp: TButton
    Left = 318
    Top = 400
    Width = 98
    Height = 33
    Caption = 'Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnHelpClick
  end
end
