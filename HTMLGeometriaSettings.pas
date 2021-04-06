unit HTMLGeometriaSettings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  mIntEdit, StdCtrls, ExtCtrls, GeoTypes;

type
  THTMLGeometriaDataForm = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label6: TLabel;
    EditTargetPath: TEdit;
    BtnBrowseHTML: TButton;
    PreText: TMemo;
    BtnSave: TButton;
    BtnCancel: TButton;
    GB_ViewerDimensions: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    IEditWinWidth: TIntEdit;
    IEditWinHeight: TIntEdit;
    EditAuthorName: TEdit;
    SaveHTMLFile: TSaveDialog;
    RG_Style: TRadioGroup;
    CB_CopyApplet: TCheckBox;
    procedure BtnBrowseHTMLClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    AppletPath      : String;
    OutRect         : TRect;
    x_min, x_max,
    y_min, y_max    : Double;
    function Execute: Boolean;
    procedure CalculateCoordRange(Drawing: TGeoObjListe);
  end;


implementation

uses GlobVars, Utility, MainWin;

{$R *.DFM}

function THTMLGeometriaDataForm.Execute: Boolean;
  begin
  Result := ShowModal = mrOk;
  end;

procedure THTMLGeometriaDataForm.BtnBrowseHTMLClick(Sender: TObject);
  begin
  If SaveHTMLFile.Execute then
    EditTargetPath.Text := ChangeFileExt(SaveHTMLFile.FileName, '.html');
  end;

procedure THTMLGeometriaDataForm.FormShow(Sender: TObject);
  begin
  EditTargetPath.Text := ChangeFileExt(Hauptfenster.ActGeoFileName, '.html');
  SaveHTMLFile.InitialDir := ExtractFilePath(Hauptfenster.ActGeoFileName);
  AppletPath := ExtractFilePath(Application.ExeName) + 'viewer\geometria.jar';
  If FileExists(AppletPath) then
    CB_CopyApplet.Enabled := True
  else begin
    CB_CopyApplet.Enabled := False;
    AppletPath := '';
    end;
  If Hauptfenster.SelStatus = 3 then
    OutRect := HauptFenster.SelRect
  else
    OutRect := Hauptfenster.PaintBox1.ClientRect;
  IEditWinWidth.Value := OutRect.Right - OutRect.Left;
  IEditWinHeight.Value := OutRect.Bottom - OutRect.Top;
  end;

procedure THTMLGeometriaDataForm.FormCloseQuery(Sender: TObject;
                                                var CanClose: Boolean);
  begin
  With OutRect do begin
    right := left + IEditWinWidth.Value;
    bottom := top + IEditWinHeight.Value;
    end;
  If (ModalResult = mrOk) and
     FileExists(EditTargetPath.Text) then
    CanClose := MessageDlg(MyFileMsg[11],
                           mtWarning, [mbYes, mbNo], 0) = mrYes
  else
    CanClose := True;
  end;

procedure THTMLGeometriaDataForm.CalculateCoordRange(Drawing: TGeoObjListe);
  begin
  With Drawing do begin
    GetLogCoords(OutRect.left, OutRect.bottom, x_min, y_min);
    GetLogCoords(OutRect.right, OutRect.top, x_max, y_max)
    end;
  end;

end.
