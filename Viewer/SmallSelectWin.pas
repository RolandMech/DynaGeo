unit SmallSelectWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TSelectWin = class(TForm)
    ListBox: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure ListBoxDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

procedure TSelectWin.ListBoxDblClick(Sender: TObject);
  begin
  ModalResult := mrOk;
  end;

procedure TSelectWin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
  Case Key of
    vk_Return : ModalResult := mrOk;
    vk_Escape : ModalResult := mrCancel;
  end;  
  end;

end.
