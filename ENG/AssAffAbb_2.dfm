object AffAbb_2_Dlg: TAffAbb_2_Dlg
  Left = 595
  Top = 202
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Defining an #'
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
      'To define an axis affinity you must specify the axis and one poi' +
      'nt together with its image point.'
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
    Caption = 'First specify the line that should become the axis of the # .'
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
    Caption = 'Then specify a point that does not lie too closed to the axis.'
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
      'Finally specify the appropriate image point. For a # this point ' +
      'must lie on the line blinking red. Even if you do not click prec' +
      'isely on this line, the image point will be bound to it automati' +
      'cally. '
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
    Caption = 'Next >>'
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
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = CancelBtnClick
  end
  object HelpBtn: TButton
    Left = 86
    Top = 400
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 1
    OnClick = HelpBtnClick
  end
end
