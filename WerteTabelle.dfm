object FunkTableWin: TFunkTableWin
  Left = 744
  Top = 122
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Werte-Tabelle'
  ClientHeight = 372
  ClientWidth = 306
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 314
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 306
    Height = 110
    Align = alTop
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 136
      Top = 4
      Width = 161
      Height = 97
      Caption = '  x-Bereich  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 44
        Width = 30
        Height = 13
        Caption = 'xmax :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 16
        Top = 68
        Width = 17
        Height = 13
        Caption = 'dx :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 16
        Top = 20
        Width = 27
        Height = 13
        Caption = 'xmin :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 72
        Top = 16
        Width = 73
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'Edit1'
        OnExit = RefreshTable
      end
      object Edit2: TEdit
        Left = 72
        Top = 40
        Width = 73
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = 'Edit2'
        OnExit = RefreshTable
      end
      object Edit3: TEdit
        Left = 72
        Top = 64
        Width = 73
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = 'Edit3'
        OnExit = RefreshTable
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 4
      Width = 121
      Height = 97
      Caption = '  Funktionen  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object FunkLB: TCheckListBox
        Left = 8
        Top = 16
        Width = 105
        Height = 73
        OnClickCheck = RefreshTable
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
  object FTab: TStringGrid
    Left = 0
    Top = 110
    Width = 306
    Height = 262
    Align = alClient
    DefaultRowHeight = 18
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goThumbTracking]
    PopupMenu = PopupMenu1
    ScrollBars = ssVertical
    TabOrder = 1
    OnClick = RefreshTable
  end
  object PopupMenu1: TPopupMenu
    Left = 32
    Top = 272
    object Menu_Update: TMenuItem
      Caption = 'Anzeige aktualisieren'
      OnClick = RefreshTable
    end
    object Menu_Kopieren: TMenuItem
      Caption = 'In die Zwischenablage kopieren'
      OnClick = Menu_KopierenClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Menu_Schliessen: TMenuItem
      Caption = 'Fenster schlie'#223'en'
      OnClick = Menu_SchliessenClick
    end
  end
end
