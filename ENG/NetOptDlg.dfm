object NetOptionsDlg: TNetOptionsDlg
  Left = 488
  Top = 155
  BorderStyle = bsDialog
  Caption = 'Network options'
  ClientHeight = 431
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 7
    Top = 209
    Width = 481
    Height = 215
    Caption = '  Management of menue configurations  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 13
      Top = 26
      Width = 202
      Height = 20
      AutoSize = False
      Caption = 'Private menue configurations : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 267
      Top = 26
      Width = 202
      Height = 20
      AutoSize = False
      Caption = 'Global menue configurations :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 267
      Top = 150
      Width = 202
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = 'Global configuration ...'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Bevel1: TBevel
      Left = 241
      Top = 130
      Width = 7
      Height = 79
      Shape = bsLeftLine
    end
    object Label6: TLabel
      Left = 13
      Top = 150
      Width = 202
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = 'Private configuration ...'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object btnShiftConfig2Global: TSpeedButton
      Left = 228
      Top = 65
      Width = 26
      Height = 27
      Hint = 'Change the selected private configuration to global'
      Caption = '=>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnShiftConfig2GlobalClick
    end
    object btnShiftConfig2Privat: TSpeedButton
      Left = 228
      Top = 98
      Width = 26
      Height = 26
      Hint = 'Change the selected global configuration to private'
      Caption = '<='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnShiftConfig2PrivatClick
    end
    object Bevel2: TBevel
      Left = 241
      Top = 13
      Width = 7
      Height = 46
      Shape = bsLeftLine
    end
    object BtnSetAsDefaultMenuConfig: TButton
      Left = 267
      Top = 169
      Width = 202
      Height = 33
      Hint = 
        'Register the selected global menu configuration as standard for ' +
        'all users'
      Caption = 'Set as default'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnSetAsDefaultMenuConfigClick
    end
    object LB_PrivCfgs: TListBox
      Left = 13
      Top = 46
      Width = 202
      Height = 98
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 1
      OnClick = LB_CfgsClick
    end
    object LB_GlobCfgs: TListBox
      Left = 267
      Top = 46
      Width = 202
      Height = 98
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 2
      OnClick = LB_CfgsClick
    end
    object btnNewCfg: TButton
      Left = 13
      Top = 169
      Width = 53
      Height = 33
      Hint = 'Creates a new private menue configuration'
      Caption = 'New...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnNewCfgClick
    end
    object btnEditCfg: TButton
      Left = 78
      Top = 169
      Width = 66
      Height = 33
      Hint = 'Edits the selected private menue configuration'
      Caption = 'Edit...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnEditCfgClick
    end
    object btnDelCfg: TButton
      Left = 156
      Top = 169
      Width = 59
      Height = 33
      Hint = 'Deletes the selected private menue configuration'
      Caption = 'Delete'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnDelCfgClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 7
    Top = 7
    Width = 481
    Height = 194
    Caption = '  Permission of configuration '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 1
    object Label5: TLabel
      Left = 33
      Top = 23
      Width = 163
      Height = 16
      AutoSize = False
      Caption = 'The user are allowed to ...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 345
      Top = 71
      Width = 124
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = 'These settings ...'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Bevel3: TBevel
      Left = 325
      Top = 13
      Width = 7
      Height = 172
      Shape = bsLeftLine
    end
    object CB_AllowChooseMenu: TCheckBox
      Left = 13
      Top = 78
      Width = 306
      Height = 20
      Caption = '... choose from existing menue configurations'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
      OnClick = CB_AllowSvOptChMenuClick
    end
    object CB_AllowEditMenues: TCheckBox
      Left = 13
      Top = 98
      Width = 287
      Height = 20
      Caption = '... create their own menue configurations'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 1
    end
    object BtnSaveNetOptions: TButton
      Left = 345
      Top = 91
      Width = 124
      Height = 38
      Hint = 
        'Saves the permissions concerning the user'#39's private configuratio' +
        'n'
      Caption = 'Save these rights'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BtnSaveNetOptionsClick
    end
    object CB_AllowEditOptions: TCheckBox
      Left = 13
      Top = 39
      Width = 306
      Height = 20
      Caption = '... change their actual program settings'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 3
      OnClick = CB_AllowEditOptionsClick
    end
    object CB_AllowSaveOptions: TCheckBox
      Left = 13
      Top = 59
      Width = 306
      Height = 20
      Caption = '... save their actual program settings'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
      OnClick = CB_AllowSvOptChMenuClick
    end
    object RG_UserOptFile: TRadioGroup
      Left = 24
      Top = 128
      Width = 289
      Height = 57
      Caption = ' Location of the configuration file : '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'in the user'#39's profil if possible  ( recommended ! )'
        'in the DynaGeo folder  ( for experts only ! )')
      ParentFont = False
      TabOrder = 5
    end
  end
end
