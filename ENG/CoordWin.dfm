object CoordDlg: TCoordDlg
  Left = 563
  Top = 120
  HelpContext = 241
  BorderStyle = bsDialog
  Caption = 'Edit co-ordinate system'
  ClientHeight = 325
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 312
    Top = 232
    Width = 272
    Height = 9
    Shape = bsBottomLine
    Style = bsRaised
  end
  object GroupBox1: TGroupBox
    Left = 13
    Top = 8
    Width = 276
    Height = 209
    Caption = ' Shape '
    TabOrder = 0
    object CB_CoordSysVisible: TCheckBox
      Left = 13
      Top = 36
      Width = 183
      Height = 20
      Caption = 'axes visible'
      TabOrder = 0
      OnClick = CB_CoordSysVisibleClick
    end
    object CB_MarkGridPoints: TCheckBox
      Left = 13
      Top = 75
      Width = 170
      Height = 20
      Caption = 'draw grid'
      TabOrder = 1
      OnClick = CB_MarkGridPointsClick
    end
    object CB_ScaleAxis: TCheckBox
      Left = 13
      Top = 55
      Width = 176
      Height = 20
      Caption = 'show numbers at the axes'
      TabOrder = 2
    end
    object GridSpacing: TRadioGroup
      Left = 32
      Top = 104
      Width = 233
      Height = 41
      Caption = ' Distance of marks '
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        ' narrow'
        ' medium'
        ' wide')
      TabOrder = 3
    end
    object GridMarks: TRadioGroup
      Left = 32
      Top = 152
      Width = 233
      Height = 41
      Caption = ' Type of marks '
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'cross'
        'solid line'
        'dotted line')
      TabOrder = 4
    end
    object CB_OriginVisible: TCheckBox
      Left = 13
      Top = 17
      Width = 188
      Height = 17
      Caption = 'origin visible'
      TabOrder = 5
      OnClick = CB_OriginVisibleClick
    end
  end
  object Okay: TButton
    Left = 350
    Top = 264
    Width = 91
    Height = 33
    Caption = 'Okay'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = OkayClick
  end
  object Abbrechen: TButton
    Left = 462
    Top = 264
    Width = 91
    Height = 33
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
  end
  object GroupBox3: TGroupBox
    Left = 13
    Top = 232
    Width = 276
    Height = 81
    Caption = ' Names of the axes '
    TabOrder = 3
    object Label1: TLabel
      Left = 7
      Top = 23
      Width = 65
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'x-axis : '
    end
    object Label2: TLabel
      Left = 8
      Top = 47
      Width = 64
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'y-axis : '
    end
    object Ed_xName: TEdit
      Left = 78
      Top = 20
      Width = 111
      Height = 21
      TabOrder = 0
      Text = 'Ed_xName'
    end
    object Ed_yName: TEdit
      Left = 78
      Top = 46
      Width = 111
      Height = 21
      TabOrder = 1
      Text = 'Ed_yName'
    end
  end
  object GroupBox2: TGroupBox
    Left = 312
    Top = 8
    Width = 273
    Height = 209
    Caption = ' Scaling of the axes '
    TabOrder = 4
    object Label3: TLabel
      Left = 32
      Top = 48
      Width = 121
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'pixel per unit :'
    end
    object Label4: TLabel
      Left = 32
      Top = 107
      Width = 121
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'pixel per x-unit :'
    end
    object Label5: TLabel
      Left = 33
      Top = 134
      Width = 121
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'pixel per y-unit :'
    end
    object RB_Isotrop: TRadioButton
      Left = 16
      Top = 24
      Width = 241
      Height = 25
      Caption = 'same scale on both axes'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RB_IsotropClick
    end
    object RB_Anisotrop: TRadioButton
      Left = 16
      Top = 80
      Width = 241
      Height = 25
      Caption = 'different scales on the axes '
      TabOrder = 1
      OnClick = RB_AnisotropClick
    end
    object Ed_Unit: TEdit
      Left = 160
      Top = 48
      Width = 97
      Height = 21
      TabOrder = 2
      Text = 'Ed_Unit'
    end
    object Ed_UnitX: TEdit
      Left = 160
      Top = 104
      Width = 97
      Height = 21
      TabOrder = 3
      Text = 'Ed_UnitX'
    end
    object Ed_UnitY: TEdit
      Left = 160
      Top = 132
      Width = 97
      Height = 21
      TabOrder = 4
      Text = 'Ed_UnitY'
    end
    object Btn_Reset: TButton
      Left = 16
      Top = 168
      Width = 241
      Height = 25
      Caption = 'Reset scaling to standard values'
      TabOrder = 5
      OnClick = Btn_ResetClick
    end
  end
end
