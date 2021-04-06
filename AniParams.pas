unit AniParams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FloatEdit, ExtCtrls,
  Declar, GlobVars, GeoTypes;

type
  TAniParamsWin = class(TForm)
    CancelBtn: TButton;
    OkayBtn: TButton;
    ComboBox1: TComboBox;
    Label5: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    FloatEdit1: TFloatEdit;
    FloatEdit3: TFloatEdit;
    Label4: TLabel;
    FloatEdit2: TFloatEdit;
    procedure FormShow(Sender: TObject);
    procedure OkayBtnClick(Sender: TObject);
    procedure FloatEdit3Exit(Sender: TObject);
    procedure FloatEdit1Exit(Sender: TObject);
    procedure FloatEdit2Exit(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
  private
    { Private-Deklarationen }
    ObjList : TGeoObjListe;
    SO      : TGParentObj;   { Steuer-Objekt }
  public
    { Public-Deklarationen }
  end;


implementation

{$R *.dfm}

uses MathLib, MainWin;

procedure TAniParamsWin.FormShow(Sender: TObject);
  var i : Integer;
  begin
  ObjList := HauptFenster.Drawing;
  If ObjList.AnimationPossible then begin
    ComboBox1.Items.Clear;
    For i := 0 to ObjList.LastValidObjIndex do
      If (TGeoObj(ObjList[i]) is TGParentObj) and
         (TGParentObj(ObjList[i]).CanControlAnimation) then
        ComboBox1.Items.AddObject
           (TGParentObj(ObjList[i]).AniCtrlObjName, ObjList[i]);
    ComboBox1.ItemIndex := -1;
    If ObjList.AnimationSource <> Nil then
      For i := 0 to Pred(ComboBox1.Items.Count) do
        If ComboBox1.Items.Objects[i] = ObjList.AnimationSource then
          ComboBox1.ItemIndex := i;
    ComboBox1Select(Self);   { aktiviert/deaktiviert die Edit-Felder }
    end
  else
    ModalResult := mrCancel;
  end;

procedure TAniParamsWin.OkayBtnClick(Sender: TObject);
  begin
  If SO <> Nil then begin
    ObjList.FillDragList(SO);
    SO.SetAniParams(FloatEdit1.Value, FloatEdit1.Value - 1,
                    FloatEdit3.Value, FloatEdit2.Value);
    ObjList.AnimationSource := SO;
    ModalResult := mrOk;
    end
  else
    { nix. }
  end;

procedure TAniParamsWin.FloatEdit3Exit(Sender: TObject);
  begin
  If FloatEdit3.Value < FloatEdit1.Value then
    FloatEdit1.Value := FloatEdit3.Value - Abs(FloatEdit2.Value);
  end;

procedure TAniParamsWin.FloatEdit1Exit(Sender: TObject);
  begin
  If FloatEdit1.Value > FloatEdit3.Value then
    FloatEdit3.Value := FloatEdit1.Value + Abs(FloatEdit2.Value);
  end;


procedure TAniParamsWin.FloatEdit2Exit(Sender: TObject);
  begin
  If FloatEdit2.Value < epsilon then
    FloatEdit2.Value := DefAniStep;
  end;

procedure TAniParamsWin.ComboBox1Select(Sender: TObject);
  begin
  If ComboBox1.ItemIndex >= 0 then begin
    SO := TGParentObj(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
    FloatEdit1.Value   := SO.AniMinValue;
    If SO.AniStep < epsilon then
      FloatEdit2.Value := DefAniStep
    else
      FloatEdit2.Value := SO.AniStep;
    FloatEdit3.Value   := SO.AniMaxValue;
    FloatEdit1.Enabled := SO is TGNumberObj;
    FloatEdit2.Enabled := True;
    FloatEdit3.Enabled := SO is TGNumberObj;
    OkayBtn.Enabled    := True;
    end
  else begin
    SO := Nil;
    FloatEdit1.Text := ' -- ';
    FloatEdit2.Text := ' -- ';
    FloatEdit3.Text := ' -- ';
    FloatEdit1.Enabled := False;
    FloatEdit2.Enabled := False;
    FloatEdit3.Enabled := False;
    OkayBtn.Enabled := False;
    end;
  end;

end.
