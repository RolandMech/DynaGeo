object AskUser1Dlg: TAskUser1Dlg
  Left = 590
  Top = 127
  Width = 434
  Height = 446
  Caption = 'DynaGeo braucht Ihre Hilfe!'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 393
    Height = 97
    AutoSize = False
    Caption = 
      'DynaGeo kann nicht entscheiden, ob der Punkt %s wirklich immer a' +
      'uf der Geraden %s liegen wird. Dies ist jedoch f'#252'r eine korrekte' +
      ' Definition der gew'#252'nschten Achsenaffinit'#228't unbedingt notwendig.' +
      ' Bitte w'#228'hlen Sie eine der folgenden 3 M'#246'glichkeiten aus:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Panel1: TPanel
    Left = 24
    Top = 120
    Width = 377
    Height = 217
    TabOrder = 0
    object RadioButton1: TRadioButton
      Left = 16
      Top = 16
      Width = 337
      Height = 57
      Caption = 
        'Ja, ich bin sicher, dass der Punkt immer auf der Geraden liegen ' +
        'wird, wie auch immer man die Zeichnung verzieht.'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      WordWrap = True
    end
    object RadioButton2: TRadioButton
      Left = 16
      Top = 80
      Width = 345
      Height = 65
      Caption = 
        'Nein, ich bin nicht sicher. Daher soll DynaGeo einen neuen Punkt' +
        ' erzeugen, der an die Gerade gebunden ist und daher immer auf ih' +
        'r liegen wird.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      WordWrap = True
    end
    object RadioButton3: TRadioButton
      Left = 16
      Top = 152
      Width = 345
      Height = 49
      Caption = 'Ich m'#246'chte die Definition der Achsenaffinit'#228't abbrechen.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      WordWrap = True
    end
  end
  object Button1: TButton
    Left = 152
    Top = 360
    Width = 121
    Height = 33
    Caption = 'Okay'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
end
