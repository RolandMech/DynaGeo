object HTMLDynaGeoJDataForm: THTMLDynaGeoJDataForm
  Left = 629
  Top = 124
  HelpContext = 38
  BorderStyle = bsDialog
  Caption = 'Export drawing to a DynaGeoJ HTML page'
  ClientHeight = 384
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 13
    Width = 280
    Height = 20
    AutoSize = False
    Caption = 'Target path of the HTML file :'
  end
  object Label2: TLabel
    Left = 13
    Top = 65
    Width = 326
    Height = 20
    AutoSize = False
    Caption = 'Path of the DynaGeoJ viewer  ( not directly editable ! ) :'
  end
  object Label3: TLabel
    Left = 13
    Top = 176
    Width = 241
    Height = 20
    AutoSize = False
    Caption = 'Text above the DynaGeoJ object :'
  end
  object Bevel1: TBevel
    Left = 7
    Top = 319
    Width = 514
    Height = 7
    Shape = bsBottomLine
  end
  object Label6: TLabel
    Left = 13
    Top = 273
    Width = 248
    Height = 20
    AutoSize = False
    Caption = 'Author'#39's name:'
  end
  object BtnBrowseViewer: TButton
    Left = 397
    Top = 85
    Width = 111
    Height = 20
    Caption = 'Search...'
    TabOrder = 0
    OnClick = BtnBrowseViewerClick
  end
  object EditTargetPath: TEdit
    Left = 26
    Top = 33
    Width = 352
    Height = 21
    TabOrder = 1
    Text = 'EditTargetPath'
    OnChange = EditTargetPathChange
  end
  object BtnBrowseHTML: TButton
    Left = 397
    Top = 33
    Width = 111
    Height = 20
    Caption = 'Search...'
    TabOrder = 2
    OnClick = BtnBrowseHTMLClick
  end
  object EditViewerPath: TEdit
    Left = 26
    Top = 85
    Width = 352
    Height = 21
    ReadOnly = True
    TabOrder = 3
    Text = 'EditViewerPath'
  end
  object RG_ViewerPathMode: TRadioGroup
    Left = 26
    Top = 111
    Width = 482
    Height = 52
    Caption = ' Standard viewer path points to... '
    ItemIndex = 0
    Items.Strings = (
      '... the EUKLID DynaGeo Homepage'
      '... this computer or to the local net')
    TabOrder = 4
  end
  object BtnResetViewerPath: TButton
    Left = 299
    Top = 130
    Width = 196
    Height = 20
    Hint = 'Resets the viewer path to the Standard viewer path'
    Caption = 'Reset to the Standard path'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = BtnResetViewerPathClick
  end
  object PreText: TMemo
    Left = 26
    Top = 195
    Width = 352
    Height = 66
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object BtnSave: TButton
    Left = 152
    Top = 338
    Width = 113
    Height = 33
    Caption = 'Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 7
  end
  object BtnCancel: TButton
    Left = 280
    Top = 338
    Width = 97
    Height = 33
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 8
  end
  object GB_ViewerDimensions: TGroupBox
    Left = 397
    Top = 176
    Width = 111
    Height = 85
    Caption = ' Viewer window '
    TabOrder = 9
    object Label4: TLabel
      Left = 7
      Top = 27
      Width = 39
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Width :'
    end
    object Label5: TLabel
      Left = 7
      Top = 53
      Width = 39
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Height :'
    end
    object IEditWinWidth: TIntEdit
      Left = 52
      Top = 25
      Width = 46
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object IEditWinHeight: TIntEdit
      Left = 52
      Top = 52
      Width = 46
      Height = 21
      TabOrder = 1
      Text = '0'
      OnChange = IEditWinHeightChange
      OnExit = IEditWinHeightExit
    end
  end
  object EditAuthorName: TEdit
    Left = 26
    Top = 293
    Width = 352
    Height = 21
    TabOrder = 10
  end
  object BtnViewerCmds: TButton
    Left = 397
    Top = 280
    Width = 111
    Height = 33
    Hint = 
      'Lets you choose the construction commands\navailable in the View' +
      'er window'
    Caption = 'Viewer commands...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = BtnViewerCmdsClick
  end
  object SaveHTMLFile: TSaveDialog
    Filter = 'HTML files (*.html)|*.html'
    Title = 'Save as DynaGeoJ HTML page'
    Left = 408
    Top = 336
  end
  object ViewerPathDlg: TOpenDialog
    Filter = 'DynaGeoJ viewer|dynageoj.jar'
    Title = 'Search for DynaGeoJ viewer'
    Left = 480
    Top = 336
  end
end
