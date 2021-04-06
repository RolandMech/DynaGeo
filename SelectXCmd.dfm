object SelectXCmdForm: TSelectXCmdForm
  Left = 684
  Top = 126
  HelpContext = 1218
  BorderStyle = bsDialog
  Caption = 'Befehle ausw'#228'hlen...'
  ClientHeight = 385
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 13
    Width = 195
    Height = 20
    AutoSize = False
    Caption = 'Verf'#252'gbare Befehle :'
  end
  object Bevel1: TBevel
    Left = 394
    Top = 7
    Width = 7
    Height = 370
    Shape = bsRightLine
  end
  object CmdListBox: TCheckListBox
    Left = 20
    Top = 39
    Width = 365
    Height = 282
    OnClickCheck = CmdListBoxClickCheck
    Columns = 2
    ItemHeight = 13
    Items.Strings = (
      'Punkt'
      'Punkt auf einer Linie'
      'Schnittpunkt(e) zweier Linien'
      'Mittelpunkt zwischen 2 Punkten'
      'Strecke zwischen 2 Punkten'
      'Vektor'
      'Gerade durch 2 Punkte'
      'Gerade in bestimmtem Winkel'
      'Orthogonale'
      'Parallele'
      'Mittelsenkrechte'
      'Winkelhalbierende'
      'Halbgerade'
      'Kreis um Mittelpunkt durch Kreispunkt'
      'Kreis mit bestimmtem Radius'
      'N-Eck'
      'Punkt an Linie binden'
      'Punktbindung l'#246'sen'
      'Objekt an Achse spiegeln'
      'Objekt an Punkt spiegeln'
      'Objekt verschieben'
      'Objekt drehen'
      'Objekt zentrisch strecken'
      'Objekt an Kreis spiegeln'
      'Ortslinie aufzeichnen'
      'Objekt l'#246'schen'
      'Abstand messen'
      'Winkelweite messen'
      'Fl'#228'cheninhalt messen'
      'Speichern unter...'
      'Animation starten/stoppen'
      'Textbox erzeugen'
      'Zahlobjekt erzeugen'
      'Termobjekt erzeugen'
      'Makro'
      'Korrektheit pr'#252'fen'
      'Ellipse'
      'Parabel'
      'Hyperbel'
      'Funktions-Schaubild'
      'Einh'#252'llende aufzeichnen')
    TabOrder = 0
  end
  object BtnOkay: TButton
    Left = 416
    Top = 40
    Width = 89
    Height = 33
    Caption = 'Okay'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
  object BtnCancel: TButton
    Left = 416
    Top = 86
    Width = 89
    Height = 35
    Cancel = True
    Caption = 'Abbrechen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
  end
  object BtnDelSel: TButton
    Left = 148
    Top = 342
    Width = 117
    Height = 26
    Caption = 'Auswahl l'#246'schen'
    TabOrder = 3
    OnClick = BtnDelSelClick
  end
end
