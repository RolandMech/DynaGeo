object SysMemWin: TSysMemWin
  Left = 334
  Top = 215
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Available memory :'
  ClientHeight = 263
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 7
    Top = 163
    Width = 358
    Height = 46
    Caption = ' Euklid DynaGeo '
    TabOrder = 1
    object Label6: TLabel
      Left = 7
      Top = 20
      Width = 202
      Height = 20
      AutoSize = False
      Caption = 'Reserved memory :'
    end
    object LblUsedVirtual: TLabel
      Left = 228
      Top = 20
      Width = 124
      Height = 20
      AutoSize = False
      Caption = 'LblUsedVirtual'
    end
  end
  object GroupBox1: TGroupBox
    Left = 7
    Top = 13
    Width = 358
    Height = 137
    Caption = ' System '
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 20
      Width = 169
      Height = 20
      AutoSize = False
      Caption = 'Windos memory load :'
    end
    object Label2: TLabel
      Left = 7
      Top = 39
      Width = 182
      Height = 20
      AutoSize = False
      Caption = 'Physically installed RAM :'
    end
    object Label3: TLabel
      Left = 7
      Top = 59
      Width = 182
      Height = 20
      AutoSize = False
      Caption = 'Available RAM :'
    end
    object Label4: TLabel
      Left = 7
      Top = 91
      Width = 221
      Height = 20
      AutoSize = False
      Caption = 'Maximum size of the Paging file :'
    end
    object Label5: TLabel
      Left = 7
      Top = 111
      Width = 215
      Height = 20
      AutoSize = False
      Caption = 'Free space in the Paging file :'
    end
    object LblMemoryLoad: TLabel
      Left = 228
      Top = 20
      Width = 124
      Height = 20
      AutoSize = False
      Caption = 'LblMemoryLoad'
    end
    object LblTotalPhys: TLabel
      Left = 228
      Top = 39
      Width = 124
      Height = 20
      AutoSize = False
      Caption = 'LblTotalPhys'
    end
    object LblAvailPhys: TLabel
      Left = 228
      Top = 59
      Width = 124
      Height = 20
      AutoSize = False
      Caption = 'LblAvailPhys'
    end
    object LblTotalPageFile: TLabel
      Left = 228
      Top = 91
      Width = 124
      Height = 20
      AutoSize = False
      Caption = 'LblTotalPageFile'
    end
    object LblAvailPageFile: TLabel
      Left = 228
      Top = 111
      Width = 124
      Height = 20
      AutoSize = False
      Caption = 'LblAvailPageFile'
    end
  end
  object Button1: TButton
    Left = 138
    Top = 224
    Width = 111
    Height = 27
    Caption = 'Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 2
  end
end
