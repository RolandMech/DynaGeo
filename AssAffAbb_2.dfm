object AffAbb_2_Dlg: TAffAbb_2_Dlg
  Left = 595
  Top = 202
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Festlegen einer #'
  ClientHeight = 431
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 10
    Top = 8
    Width = 409
    Height = 385
    Shape = bsFrame
  end
  object Label2: TLabel
    Left = 56
    Top = 24
    Width = 321
    Height = 73
    AutoSize = False
    Caption = 
      'Zur Festlegung einer jeden Achsenaffinit'#228't m'#252'ssen Sie die Affini' +
      't'#228'tsachse sowie ein Punkt-Bildpunkt-Paar angeben.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 56
    Top = 120
    Width = 321
    Height = 57
    AutoSize = False
    Caption = 
      'Geben Sie zun'#228'chst eine Gerade an, die die Achse (Fixpunktgerade' +
      ') Ihrer # werden soll.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label4: TLabel
    Left = 56
    Top = 192
    Width = 321
    Height = 41
    AutoSize = False
    Caption = 
      'Geben Sie nun einen Punkt an, der nicht zu dicht bei der Achse l' +
      'iegt.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
    WordWrap = True
  end
  object Label5: TLabel
    Left = 56
    Top = 248
    Width = 321
    Height = 137
    AutoSize = False
    Caption = 
      'Geben Sie als letztes den Bildpunkt des zuvor angegebenen Punkte' +
      's an. Bei einer # muss er auf der rot blinkenden Geraden liegen.' +
      ' Auch wenn Sie nicht genau auf diese Gerade klicken, wird ein sc' +
      'hon existierender Bildpunkt automatisch an sie gebunden bzw. ein' +
      ' neuer auf ihr erzeugt. '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
    WordWrap = True
  end
  object OKBtn: TButton
    Left = 328
    Top = 400
    Width = 89
    Height = 25
    Caption = 'Weiter >>'
    Default = True
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 8
    Top = 400
    Width = 73
    Height = 25
    Cancel = True
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 2
    OnClick = CancelBtnClick
  end
  object HelpBtn: TButton
    Left = 86
    Top = 400
    Width = 75
    Height = 25
    Caption = '&Hilfe'
    TabOrder = 1
    OnClick = HelpBtnClick
  end
end
