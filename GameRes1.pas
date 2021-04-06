unit GameRes1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage;

type
  TGameRes1Dlg = class(TForm)
    Lbl_Msg1: TLabel;
    Lbl_Msg3: TLabel;
    Btn_Yes: TButton;
    Btn_No: TButton;
    Lbl_Msg2: TLabel;
    Label4: TLabel;
    Lbl_Note: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    constructor CreateWD(AOwner: TComponent; iNoteStr, iMsgStr: String);
  end;


implementation

{$R *.dfm}

constructor TGameRes1Dlg.CreateWD(AOwner: TComponent; iNoteStr, iMsgStr: String);
  var n : Integer;
  begin
  Inherited Create(AOwner);
  Lbl_Note.Caption := iNoteStr;
  n := Pos('!', iMsgStr);
  if n > 0 then begin
    while iMsgStr[n + 1] = '!' do
      n := n + 1;
    Lbl_Msg1.Caption := Copy(iMsgStr, 1, n);
    Delete(iMsgStr, 1, n+2);
    Lbl_Msg2.Caption := iMsgStr;
    end;
  end;

end.
