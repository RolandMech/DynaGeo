object ExpertOptWin: TExpertOptWin
  Left = 683
  Top = 119
  HelpContext = 1224
  BorderStyle = bsDialog
  Caption = '  Gef'#228'hrliche Optionen f'#252'r mutige Benutzer...'
  ClientHeight = 344
  ClientWidth = 457
  Color = clTeal
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 25
    Top = 16
    Width = 408
    Height = 305
    Caption = ' Achtung !!! '
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 13
      Top = 38
      Width = 332
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = 'Hier sollten nur Experten '#196'nderungen vornehmen!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RG_DragStrategy: TRadioGroup
      Left = 20
      Top = 83
      Width = 365
      Height = 66
      Caption = '  Aktualisierungsstrategie im Zugmodus  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        'Determinismus ist wichtiger, trotz "springender Punkte"'
        'Stetigkeit ist wichtiger, soweit eben m'#246'glich')
      ParentFont = False
      TabOrder = 0
      OnClick = RG_DragStrategyClick
    end
    object BtnSetExpertOpts: TButton
      Left = 44
      Top = 251
      Width = 189
      Height = 33
      Caption = #196'nderung '#252'bernehmen'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 1
      OnClick = BtnSetExpertOptsClick
    end
    object BtnCancel: TButton
      Left = 256
      Top = 251
      Width = 105
      Height = 33
      Cancel = True
      Caption = 'Abbrechen'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 2
    end
    object GroupBox2: TGroupBox
      Left = 20
      Top = 160
      Width = 365
      Height = 57
      Caption = '  Rekursion  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object CB_Recursion: TCheckBox
        Left = 16
        Top = 24
        Width = 281
        Height = 17
        Caption = 'Rekursive Funktionen erlauben'
        TabOrder = 0
        OnClick = RG_DragStrategyClick
      end
    end
  end
end
