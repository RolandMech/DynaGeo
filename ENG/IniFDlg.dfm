object OptionsDlg: TOptionsDlg
  Left = 694
  Top = 146
  HelpContext = 20
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Options'
  ClientHeight = 355
  ClientWidth = 514
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = OptionsMenu
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 299
    Width = 514
    Height = 56
    Align = alBottom
    TabOrder = 0
    object BtnCancel: TButton
      Left = 322
      Top = 13
      Width = 159
      Height = 33
      Cancel = True
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
    end
    object BtnOkay: TButton
      Left = 32
      Top = 13
      Width = 272
      Height = 33
      Caption = 'Apply these settings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = ''
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = OkayClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 514
    Height = 299
    HelpContext = 20
    ActivePage = TabSheet5
    Align = alClient
    HotTrack = True
    MultiLine = True
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      HelpContext = 1221
      Caption = '  Start options  '
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object RGStartWindow: TRadioGroup
        Left = 39
        Top = 15
        Width = 290
        Height = 84
        Caption = ' Starting the program : '
        Items.Strings = (
          '  set default window size'
          '  maximize window'
          '  restore the last used window ')
        TabOrder = 0
      end
      object RGNewCoordSys: TRadioGroup
        Left = 39
        Top = 133
        Width = 290
        Height = 84
        Caption = ' Starting a new drawing : '
        Items.Strings = (
          '  don'#39't show a co-ordinate system'
          '  show axes only'
          '  show axes and co-ordinate grid')
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      HelpContext = 1222
      Caption = ' Presentation  '
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label7: TLabel
        Left = 280
        Top = 23
        Width = 73
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Point size : '
      end
      object Label27: TLabel
        Left = 224
        Top = 60
        Width = 129
        Height = 33
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Standard colour of the co-ordinate system :'
        WordWrap = True
      end
      object CB_AutoNameCol: TCheckBox
        Left = 267
        Top = 110
        Width = 206
        Height = 20
        Caption = 'Name colour follows object colour'
        TabOrder = 4
      end
      object CB_PolygonAutoFill: TCheckBox
        Left = 267
        Top = 210
        Width = 209
        Height = 20
        Caption = 'Fill new polygons on creation'
        Checked = True
        State = cbChecked
        TabOrder = 8
      end
      object GB_PointDefaults: TGroupBox
        Left = 16
        Top = 14
        Width = 201
        Height = 105
        Caption = ' Standard point styles : '
        TabOrder = 0
        object Label15: TLabel
          Left = 13
          Top = 23
          Width = 118
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Free basis points : '
        end
        object Label16: TLabel
          Left = 7
          Top = 75
          Width = 124
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Constructed points : '
        end
        object Label19: TLabel
          Left = 13
          Top = 49
          Width = 118
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Fixed points : '
        end
        object BB_BasePointDefStyle: TBitBtn
          Left = 137
          Top = 20
          Width = 20
          Height = 20
          DoubleBuffered = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
            FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000
            FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          ParentDoubleBuffered = False
          TabOrder = 0
          OnClick = BB_BasePointDefStyleClick
        end
        object BB_ConstrPointDefStyle: TBitBtn
          Left = 137
          Top = 72
          Width = 20
          Height = 20
          DoubleBuffered = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF
            FFFFFFFFF000000FFFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000
            FFFFFFFF00000000FFFFFFFFF000000FFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          ParentDoubleBuffered = False
          TabOrder = 2
          OnClick = BB_ConstrPointDefStyleClick
        end
        object BB_CoordPointDefStyle: TBitBtn
          Left = 137
          Top = 46
          Width = 20
          Height = 20
          DoubleBuffered = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000FFFFFF000000000
            0FFFFFF0000000000FFFFFF000FFFF000FFFFFF000FFFF000FFFFFF000FFFF00
            0FFFFFF000FFFF000FFFFFF0000000000FFFFFF0000000000FFFFFF000000000
            0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          ParentDoubleBuffered = False
          TabOrder = 1
          OnClick = BB_CoordPointDefStyleClick
        end
      end
      object SE_PointSize: TSpinEdit
        Left = 360
        Top = 21
        Width = 41
        Height = 22
        EditorEnabled = False
        MaxValue = 10
        MinValue = 1
        TabOrder = 2
        Value = 4
      end
      object GB_LineDefaults: TGroupBox
        Left = 16
        Top = 134
        Width = 201
        Height = 105
        Caption = ' Standard line styles : '
        TabOrder = 1
        object Label17: TLabel
          Left = 7
          Top = 36
          Width = 98
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Simple lines : '
        end
        object Label18: TLabel
          Left = 7
          Top = 68
          Width = 98
          Height = 21
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'locus lines : '
        end
        object BB_NormalLineDefStyle: TBitBtn
          Left = 111
          Top = 33
          Width = 65
          Height = 20
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 0
          OnClick = BB_NormalLineDefStyleClick
        end
        object BB_LocLineDefStyle: TBitBtn
          Left = 111
          Top = 65
          Width = 65
          Height = 20
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 1
          OnClick = BB_LocLineDefStyleClick
        end
      end
      object CB_RightAnglePt: TCheckBox
        Left = 267
        Top = 135
        Width = 206
        Height = 20
        Caption = 'Mark right angles with a point'
        TabOrder = 5
      end
      object CB_FrameMeasures: TCheckBox
        Left = 267
        Top = 185
        Width = 206
        Height = 20
        Caption = 'Enclose measures with a frame'
        TabOrder = 7
      end
      object CB_FillAngleSector: TCheckBox
        Left = 267
        Top = 160
        Width = 206
        Height = 20
        Caption = 'Show angle marks filled'
        TabOrder = 6
      end
      object CosysColBox: TColorBox
        Left = 360
        Top = 64
        Width = 105
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbPrettyNames]
        TabOrder = 3
      end
    end
    object TabSheet3: TTabSheet
      HelpContext = 1223
      Caption = '  Measure  '
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label26: TLabel
        Left = 32
        Top = 210
        Width = 297
        Height = 25
        AutoSize = False
        Caption = 'Maximal number of intervals in a Riemann sum : '
      end
      object CB_AngleOrient: TCheckBox
        Left = 32
        Top = 141
        Width = 209
        Height = 20
        Caption = 'Care for angle orientation'
        TabOrder = 2
      end
      object CB_AllAreasSigned: TCheckBox
        Left = 32
        Top = 165
        Width = 257
        Height = 20
        Caption = 'Measure polygon and circle areas with orientation'
        TabOrder = 3
      end
      object GB_Accuracy: TGroupBox
        Left = 24
        Top = 16
        Width = 201
        Height = 105
        Caption = ' Length of the measure'#39's decimal part :'
        TabOrder = 0
        object Label3: TLabel
          Left = 17
          Top = 24
          Width = 104
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'for distances : '
        end
        object Label14: TLabel
          Left = 17
          Top = 50
          Width = 104
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'for angle widths : '
        end
        object Label21: TLabel
          Left = 17
          Top = 75
          Width = 104
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'for area sizes : '
        end
        object SpELengthDecimals: TSpinEdit
          Left = 137
          Top = 21
          Width = 40
          Height = 22
          MaxValue = 6
          MinValue = 0
          TabOrder = 0
          Value = 3
        end
        object SpEAngleDecimals: TSpinEdit
          Left = 137
          Top = 47
          Width = 40
          Height = 22
          MaxValue = 4
          MinValue = 0
          TabOrder = 1
          Value = 0
        end
        object SpEAreaDecimals: TSpinEdit
          Left = 137
          Top = 72
          Width = 40
          Height = 22
          MaxValue = 5
          MinValue = 0
          TabOrder = 2
          Value = 2
        end
      end
      object GB_Units: TGroupBox
        Left = 264
        Top = 16
        Width = 217
        Height = 105
        Caption = ' Units of measures : '
        TabOrder = 1
        object Label20: TLabel
          Left = 8
          Top = 75
          Width = 89
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'for areas : '
        end
        object Label2: TLabel
          Left = 8
          Top = 50
          Width = 89
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'for angles : '
        end
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 89
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'for distances : '
        end
        object ELengthUnit: TEdit
          Left = 104
          Top = 21
          Width = 72
          Height = 21
          Hint = 'Standard:  cm  '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Text = 'ELengthUnit'
        end
        object EAngleUnit: TEdit
          Left = 104
          Top = 47
          Width = 72
          Height = 21
          Hint = 'Standard:  '#176'  '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Text = 'EAngleUnit'
        end
        object EAreaUnit: TEdit
          Left = 104
          Top = 72
          Width = 73
          Height = 21
          TabOrder = 2
          Text = 'EAreaUnit'
        end
      end
      object SpEMaxRieCnt: TSpinEdit
        Left = 336
        Top = 208
        Width = 57
        Height = 22
        MaxValue = 64000
        MinValue = 256
        TabOrder = 4
        Value = 256
      end
    end
    object TabSheet5: TTabSheet
      HelpContext = 1224
      Caption = '  Internals  '
      ImageIndex = 4
      object Label5: TLabel
        Left = 60
        Top = 14
        Width = 124
        Height = 19
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Mouse capture area : '
      end
      object Label6: TLabel
        Left = 40
        Top = 40
        Width = 144
        Height = 19
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Standard zoom factor : '
      end
      object Label4: TLabel
        Left = 0
        Top = 66
        Width = 184
        Height = 19
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Tolerance for angle comparison : '
      end
      object Label9: TLabel
        Left = 268
        Top = 66
        Width = 52
        Height = 19
        AutoSize = False
        Caption = 'degree'
      end
      object Label10: TLabel
        Left = 0
        Top = 92
        Width = 184
        Height = 19
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Tolerance for distance comparison : '
      end
      object Label11: TLabel
        Left = 268
        Top = 92
        Width = 52
        Height = 19
        AutoSize = False
        Caption = 'pixels'
      end
      object Label12: TLabel
        Left = 268
        Top = 14
        Width = 52
        Height = 19
        AutoSize = False
        Caption = 'pixels'
      end
      object EMouseC: TEdit
        Left = 192
        Top = 14
        Width = 70
        Height = 21
        Hint = 'Range: 1...10'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = 'EMouseC'
      end
      object EZoomF: TEdit
        Left = 192
        Top = 40
        Width = 70
        Height = 21
        Hint = 'Range: 1...10'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Text = 'EZoomF'
      end
      object EAngleAcc: TEdit
        Left = 192
        Top = 66
        Width = 70
        Height = 21
        Hint = 'Range: 1e-5'#176'...10'#176
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Text = 'EAngleAcc'
      end
      object EDistAcc: TEdit
        Left = 192
        Top = 92
        Width = 70
        Height = 21
        Hint = 'Range: 1e-12...1'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = 'EDistAcc'
      end
      object BtnExpertOpts: TButton
        Left = 336
        Top = 140
        Width = 137
        Height = 25
        Caption = 'Expert options...'
        TabOrder = 7
        OnClick = BtnExpertOptsClick
      end
      object CB_FatCursors: TCheckBox
        Left = 28
        Top = 188
        Width = 201
        Height = 18
        Caption = 'Use fat mouse pointers'
        TabOrder = 6
      end
      object CB_ShowSim: TCheckBox
        Left = 28
        Top = 164
        Width = 257
        Height = 18
        Caption = 'Animate the correctness check'
        TabOrder = 5
      end
      object CB_ExtPointCmd: TCheckBox
        Left = 28
        Top = 140
        Width = 241
        Height = 18
        Caption = '"Point" command with extended capabilities'
        TabOrder = 4
      end
      object RG_XMLFormat: TRadioGroup
        Left = 336
        Top = 16
        Width = 153
        Height = 97
        Caption = ' XML output format '
        Items.Strings = (
          'ZIP compressed'
          'unformatted'
          'short rows (recommended)'
          '"pretty print"')
        TabOrder = 8
      end
    end
    object TabSheet4: TTabSheet
      HelpContext = 1225
      Caption = 'Menu configuration'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 4
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label13: TLabel
        Left = 65
        Top = 20
        Width = 247
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Length of list of the last recently used files : '
      end
      object ELRUCount: TEdit
        Left = 318
        Top = 20
        Width = 72
        Height = 21
        Hint = 'Range: 0..9'
        TabOrder = 0
        Text = 'ELRUCount'
      end
      object Panel2: TPanel
        Left = 26
        Top = 59
        Width = 447
        Height = 111
        BevelOuter = bvLowered
        BevelWidth = 2
        TabOrder = 1
        object CfgList: TComboBox
          Left = 24
          Top = 20
          Width = 401
          Height = 21
          TabOrder = 0
          Text = 'CfgList'
          OnChange = CfgListChange
        end
        object BtnNewMenuCfg: TButton
          Left = 24
          Top = 65
          Width = 113
          Height = 27
          Hint = 'Creates a new menu configuration'
          HelpContext = 31
          Caption = 'New...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = NewMenuCfgClick
        end
        object BtnEditMenuCfg: TButton
          Left = 168
          Top = 65
          Width = 113
          Height = 27
          Hint = 'Edits the selected menu configuration'
          HelpContext = 25
          Caption = 'Edit...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = EditMenuCfgClick
        end
        object BtnDelMenuCfg: TButton
          Left = 312
          Top = 65
          Width = 113
          Height = 27
          Hint = 'Deletes the selected menu configuration'
          HelpContext = 25
          Caption = 'Delete'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = DelMenuCfgClick
        end
      end
    end
    object TabSheet6: TTabSheet
      HelpContext = 1226
      Caption = 'Text settings'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object CB_NoNamesInConstrText: TCheckBox
        Left = 48
        Top = 132
        Width = 377
        Height = 23
        Caption = 'No names and measures in the construction text'
        TabOrder = 0
      end
      object RG_LineEquationStyle: TRadioGroup
        Left = 48
        Top = 161
        Width = 409
        Height = 73
        Caption = ' Form of the line equations : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -10
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          '"y = mx + c"   ( or  "x = a" )'
          ' always  "ax + by = c"')
        ParentFont = False
        TabOrder = 1
      end
      object GroupBox6: TGroupBox
        Left = 48
        Top = 3
        Width = 409
        Height = 123
        Caption = ' Standard font for labels : '
        DoubleBuffered = False
        Padding.Left = 20
        Padding.Top = 10
        Padding.Right = 20
        Padding.Bottom = 10
        ParentDoubleBuffered = False
        TabOrder = 2
        object Label28: TLabel
          Left = 23
          Top = 28
          Width = 37
          Height = 13
          Caption = 'Name : '
        end
        object Label29: TLabel
          Left = 285
          Top = 28
          Width = 38
          Height = 13
          Caption = 'Size : '
        end
        object Label30: TLabel
          Left = 6
          Top = 56
          Width = 54
          Height = 13
          Caption = 'Preview : '
        end
        object CB_DefaultFontFace: TComboBox
          Left = 65
          Top = 25
          Width = 149
          Height = 21
          Style = csDropDownList
          DropDownCount = 15
          TabOrder = 0
          OnChange = DefaultFontChange
        end
        object SE_DefaultFontSize: TSpinEdit
          Left = 329
          Top = 25
          Width = 48
          Height = 22
          MaxValue = 60
          MinValue = 6
          TabOrder = 1
          Value = 12
          OnChange = DefaultFontChange
        end
        object PreviewPanel: TPanel
          Left = 66
          Top = 56
          Width = 311
          Height = 59
          BevelInner = bvLowered
          BevelKind = bkSoft
          BevelOuter = bvNone
          Caption = 'AaBbYyZz 1234'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
    end
    object TabSheet7: TTabSheet
      HelpContext = 1227
      Caption = 'Export'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox3: TGroupBox
        Left = 24
        Top = 8
        Width = 457
        Height = 73
        Caption = ' Printing : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object CB_InternalLS_Prn: TCheckBox
          Left = 23
          Top = 21
          Width = 178
          Height = 20
          Caption = 'Generate line style internally'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -10
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object CB_InternalCS_Prn: TCheckBox
          Left = 23
          Top = 45
          Width = 178
          Height = 20
          Caption = 'Generate circle style internally'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -10
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object CB_HatchedFill_Prn: TCheckBox
          Left = 215
          Top = 21
          Width = 178
          Height = 20
          Caption = 'Allow dashed fillings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -10
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object CB_UserDefBrush_Prn: TCheckBox
          Left = 215
          Top = 45
          Width = 178
          Height = 20
          Caption = 'Allow rasterized fillings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -10
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
      end
      object GroupBox4: TGroupBox
        Left = 24
        Top = 96
        Width = 457
        Height = 73
        Caption = ' Exporting to the clipboard : '
        TabOrder = 1
        object Label22: TLabel
          Left = 192
          Top = 23
          Width = 185
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Dilation factor in  x-direction ( SFx ) :'
        end
        object Label23: TLabel
          Left = 192
          Top = 47
          Width = 185
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Y/X  aspect ( = SFy / SFx ) :'
        end
        object CB_InternalLS_Clipboard: TCheckBox
          Left = 23
          Top = 21
          Width = 154
          Height = 20
          Caption = 'Generate line style internally'
          TabOrder = 0
        end
        object CB_InternalCS_Clipboard: TCheckBox
          Left = 23
          Top = 45
          Width = 154
          Height = 20
          Caption = 'Generate cirle style internally'
          TabOrder = 1
        end
        object Ed_ScaleX_Clpbrd: TEdit
          Left = 384
          Top = 21
          Width = 57
          Height = 21
          TabOrder = 2
          Text = '1.0'
        end
        object Ed_Aspect_Clpbrd: TEdit
          Left = 384
          Top = 45
          Width = 57
          Height = 21
          TabOrder = 3
          Text = '1.0'
        end
      end
      object GroupBox5: TGroupBox
        Left = 24
        Top = 184
        Width = 457
        Height = 49
        Caption = ' Exporting bitmaps : '
        TabOrder = 2
        object Label24: TLabel
          Left = 48
          Top = 21
          Width = 161
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Resolution of the image file : '
        end
        object Label25: TLabel
          Left = 336
          Top = 21
          Width = 33
          Height = 20
          AutoSize = False
          Caption = 'dpi'
        end
        object CB_BMP_Res: TComboBox
          Left = 216
          Top = 17
          Width = 113
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = '[Screen-Res]'
          Items.Strings = (
            '[Screen-Res]'
            '200'
            '300'
            '400'
            '600'
            '800'
            '1000'
            '1200')
        end
      end
    end
    object TabSheet8: TTabSheet
      HelpContext = 1228
      Caption = 'Mappings'
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 45
        Top = 39
        Width = 420
        Height = 106
        Caption = ' Add traces automatically for... '
        TabOrder = 0
        object CB_AutoTraceMirrorAxis: TCheckBox
          Left = 29
          Top = 28
          Width = 176
          Height = 20
          Caption = 'reflection in a line'
          TabOrder = 0
        end
        object CB_AutoTraceMirrorCentre: TCheckBox
          Left = 29
          Top = 47
          Width = 170
          Height = 20
          Caption = 'reflection in a point'
          TabOrder = 1
        end
        object CB_AutoTraceMove: TCheckBox
          Left = 29
          Top = 67
          Width = 176
          Height = 20
          Caption = 'translation'
          TabOrder = 2
        end
        object CB_AutoTraceRotate: TCheckBox
          Left = 227
          Top = 28
          Width = 150
          Height = 20
          Caption = 'rotation'
          TabOrder = 3
        end
        object CB_AutoTraceStretch: TCheckBox
          Left = 227
          Top = 47
          Width = 176
          Height = 20
          Caption = 'dilation'
          TabOrder = 4
        end
      end
    end
    object TabSheet9: TTabSheet
      HelpContext = 1229
      Caption = 'Locus lines'
      ImageIndex = 8
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label8: TLabel
        Left = 87
        Top = 178
        Width = 196
        Height = 18
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Minimal trace point distance : '
      end
      object GroupBox2: TGroupBox
        Left = 55
        Top = 34
        Width = 378
        Height = 95
        Caption = ' New locus lines '
        TabOrder = 0
        object CB_BezierOLines: TCheckBox
          Left = 36
          Top = 21
          Width = 228
          Height = 20
          Caption = 'show as curves'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = CB_BezierOLinesClick
        end
        object CB_DynaOLines: TCheckBox
          Left = 36
          Top = 41
          Width = 254
          Height = 20
          Caption = 'create as dynamic'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object CB_StandardOLines: TCheckBox
          Left = 36
          Top = 61
          Width = 280
          Height = 20
          Caption = 'convert to standard locus line (if possible)'
          TabOrder = 2
        end
      end
      object EOLDist: TEdit
        Left = 289
        Top = 175
        Width = 48
        Height = 21
        Hint = 'range: 1...50'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Text = 'EOLDist'
      end
    end
  end
  object OptionsMenu: TMainMenu
    Left = 480
    Top = 192
    object CfgDatei: TMenuItem
      Caption = 'Configuration file'
      HelpContext = 1225
      object StandardEinstellungenwiederladen1: TMenuItem
        Caption = 'Reload standard settings'
        OnClick = LoadStandardClick
      end
      object LetzteUserEinstellungenwiederladen1: TMenuItem
        Caption = 'Reload last user settings'
        OnClick = LoadUserClick
      end
      object AktuelleUserEinstellungenspeichern1: TMenuItem
        Caption = 'Save actual user settings'
        OnClick = SaveUserClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object AlsStandardspeichern1: TMenuItem
        Caption = 'Save actual user settings as standard'
        OnClick = AlsStandardspeichern1Click
      end
      object LizenzDatenAktualisieren1: TMenuItem
        Caption = 'Update licence data'
        OnClick = LizenzDatenAktualisieren1Click
      end
      object NetzwerkOptionen1: TMenuItem
        Caption = 'Network options...'
        OnClick = NetzwerkOptionen1Click
      end
    end
  end
  object PointStyleMenu: TPopupMenu
    Left = 480
    Top = 144
    object GefllterKreis1: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF
        FFFFFFFFF000000FFFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000
        FFFFFFFF00000000FFFFFFFFF000000FFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Caption = 'Filled circle'
      OnClick = PointStyleClick
    end
    object GeflltesQuadrat1: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
        FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000
        FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Caption = 'Filled square'
      OnClick = PointStyleClick
    end
    object HohlerKreis1: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFF000000F
        FFFFFFFF00000000FFFFFFF0000FF0000FFFFFF000FFFF000FFFFFF000FFFF00
        0FFFFFF0000FF0000FFFFFFF00000000FFFFFFFFF000000FFFFFFFFFFF0000FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Caption = 'Hollow circle'
      OnClick = PointStyleClick
    end
    object HohlesQuadrat1: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000FFFFFF000000000
        0FFFFFF0000000000FFFFFF000FFFF000FFFFFF000FFFF000FFFFFF000FFFF00
        0FFFFFF000FFFF000FFFFFF0000000000FFFFFF0000000000FFFFFF000000000
        0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Caption = 'Hollow square'
      OnClick = PointStyleClick
    end
    object Kreuzaufrecht1: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFF
        FFFFFFFFFF000FFFFFFFFFFFFF000FFFFFFFFFF000000000FFFFFFF000000000
        FFFFFFF000000000FFFFFFFFFF000FFFFFFFFFFFFF000FFFFFFFFFFFFF000FFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Caption = 'cross, upright'
      OnClick = PointStyleClick
    end
    object Kreuzdiagonal1: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF0FFFFFFFFF000FF000
        FFFFFFF0000000000FFFFFFF00000000FFFFFFFFF000000FFFFFFFFFF000000F
        FFFFFFFF00000000FFFFFFF0000000000FFFFFFF000FF000FFFFFFFFF0FFFF0F
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Caption = 'cross, diagonal'
      OnClick = PointStyleClick
    end
    object HohlerKreisdnn1: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF
        FFFFFFFFF0FFFF0FFFFFFFFF0FFFFFF0FFFFFFFF0FFFFFF0FFFFFFFF0FFFFFF0
        FFFFFFFF0FFFFFF0FFFFFFFFF0FFFF0FFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Caption = 'Hollow circle, thin'
      OnClick = PointStyleClick
    end
    object HilesQuadratdnn1: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
        FFFFFFFF0FFFFFF0FFFFFFFF0FFFFFF0FFFFFFFF0FFFFFF0FFFFFFFF0FFFFFF0
        FFFFFFFF0FFFFFF0FFFFFFFF0FFFFFF0FFFFFFFF00000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Caption = 'Hollow square, thin'
      OnClick = PointStyleClick
    end
    object Kreuzaufrechtdnn1: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
        FFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFF000000000
        FFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Caption = 'cross, upright, thin'
      OnClick = PointStyleClick
    end
    object Kreuzdiagonaldnn1: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFF0
        FFFFFFFFF0FFFF0FFFFFFFFFFF0FF0FFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFF
        FFFFFFFFFF0FF0FFFFFFFFFFF0FFFF0FFFFFFFFF0FFFFFF0FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Caption = 'cross, diagonal, thin'
      OnClick = PointStyleClick
    end
  end
  object LineStyleMenu: TPopupMenu
    OwnerDraw = True
    Left = 480
    Top = 96
    object dnn1: TMenuItem
      Caption = 'thin'
      OnClick = LineStyleMenuClick
      OnDrawItem = LineStyleMenu_DrawItem
      OnMeasureItem = LineStyleMenu_MeasureItem
    end
    object dick1: TMenuItem
      Caption = 'thick'
      OnClick = LineStyleMenuClick
      OnDrawItem = LineStyleMenu_DrawItem
      OnMeasureItem = LineStyleMenu_MeasureItem
    end
    object fett1: TMenuItem
      Caption = 'fat'
      OnClick = LineStyleMenuClick
      OnDrawItem = LineStyleMenu_DrawItem
      OnMeasureItem = LineStyleMenu_MeasureItem
    end
    object gestrichelt1: TMenuItem
      Caption = 'dashed'
      OnClick = LineStyleMenuClick
      OnDrawItem = LineStyleMenu_DrawItem
      OnMeasureItem = LineStyleMenu_MeasureItem
    end
    object punktiert1: TMenuItem
      Caption = 'dotted'
      OnClick = LineStyleMenuClick
      OnDrawItem = LineStyleMenu_DrawItem
      OnMeasureItem = LineStyleMenu_MeasureItem
    end
    object strichpunktiert1: TMenuItem
      Caption = 'dash-dotted'
      OnClick = LineStyleMenuClick
      OnDrawItem = LineStyleMenu_DrawItem
      OnMeasureItem = LineStyleMenu_MeasureItem
    end
  end
  object LocLineStyleMenu: TPopupMenu
    OwnerDraw = True
    Left = 480
    Top = 48
    object dnneLinie1: TMenuItem
      Caption = 'thin line'
      OnClick = LocLineStyleMenuClick
      OnDrawItem = LocLineStyleMenu_DrawItem
      OnMeasureItem = LineStyleMenu_MeasureItem
    end
    object dickeLinie1: TMenuItem
      Caption = 'thick line'
      OnClick = LocLineStyleMenuClick
      OnDrawItem = LocLineStyleMenu_DrawItem
      OnMeasureItem = LineStyleMenu_MeasureItem
    end
    object PunkteSerie1: TMenuItem
      Caption = 'series of points, thin'
      OnClick = LocLineStyleMenuClick
      OnDrawItem = LocLineStyleMenu_DrawItem
      OnMeasureItem = LineStyleMenu_MeasureItem
    end
    object PunktSeriedick1: TMenuItem
      Caption = 'series of points, thick'
      OnClick = LocLineStyleMenuClick
      OnDrawItem = LocLineStyleMenu_DrawItem
      OnMeasureItem = LineStyleMenu_MeasureItem
    end
  end
end
