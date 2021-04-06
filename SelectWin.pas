unit SelectWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSelectDlg = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    SelectedItem : Integer;
    procedure LoadObjList(mx, my: Integer);
    procedure LoadMakList;
  end;


implementation

{$R *.DFM}

Uses GlobVars, MainWin, GeoTypes, GeoMakro;

procedure TSelectDlg.Button1Click(Sender: TObject);
  begin
  SelectedItem := ListBox1.ItemIndex;
  ModalResult := mrOk;
  end;

procedure TSelectDlg.LoadObjList(mx, my: Integer);
  var i : Integer;
  begin
  Caption := MyMess[55];
  If mx + Width > Screen.DesktopWidth then
    Left := Screen.DesktopWidth - Width
  else
    Left := mx;
  If my + Height > Screen.DesktopHeight then
    Top := Screen.DesktopHeight - Height
  else
    Top := my;
  ListBox1.Items.Clear;
  With Hauptfenster do
    For i := 0 to Pred(Selected.Count) do
      ListBox1.Items.Add(TGeoObj(Selected.Items[i]).Name);
  end;

procedure TSelectDlg.LoadMakList;
  var i : Integer;
  begin
  Caption := MyMess[57];
  ListBox1.Items.Clear;
  With Hauptfenster.Drawing.MakroList do
    For i := 0 to Pred(Count) do
      ListBox1.Items.Add(TMakro(Items[i]).Name);
  end;

procedure TSelectDlg.FormActivate(Sender: TObject);
  begin
  SelectedItem := -1;
  If ListBox1.Items.Count > 0 then
    ListBox1.ItemIndex := 0;
  end;

procedure TSelectDlg.Button2Click(Sender: TObject);
  begin
  Close;
  end;

end.
