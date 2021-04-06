unit CoordWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TCoordDlg = class(TForm)
    GroupBox1: TGroupBox;
    CB_CoordSysVisible: TCheckBox;
    CB_MarkGridPoints: TCheckBox;
    Okay: TButton;
    Abbrechen: TButton;
    CB_ScaleAxis: TCheckBox;
    Bevel1: TBevel;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Ed_xName: TEdit;
    Label2: TLabel;
    Ed_yName: TEdit;
    GroupBox2: TGroupBox;
    RB_Isotrop: TRadioButton;
    RB_Anisotrop: TRadioButton;
    Label3: TLabel;
    Ed_Unit: TEdit;
    Label4: TLabel;
    Ed_UnitX: TEdit;
    Label5: TLabel;
    Ed_UnitY: TEdit;
    Btn_Reset: TButton;
    GridSpacing: TRadioGroup;
    GridMarks: TRadioGroup;
    CB_OriginVisible: TCheckBox;
    procedure CB_CoordSysVisibleClick(Sender: TObject);
    procedure CB_MarkGridPointsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OkayClick(Sender: TObject);
    procedure RB_IsotropClick(Sender: TObject);
    procedure RB_AnisotropClick(Sender: TObject);
    procedure Btn_ResetClick(Sender: TObject);
    procedure CB_OriginVisibleClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


implementation

Uses Math,  GlobVars, Utility, GeoTypes, MainWin;

{$R *.DFM}

{ Verwaltung der gegenseitigen logischen Abhängigkeiten }

procedure TCoordDlg.CB_OriginVisibleClick(Sender: TObject);
  begin
  CB_CoordSysVisible.Enabled := CB_OriginVisible.Checked;
  CB_CoordSysVisible.Checked := CB_OriginVisible.Checked;
  end;

procedure TCoordDlg.CB_CoordSysVisibleClick(Sender: TObject);
  begin
  If CB_CoordSysVisible.Checked then CB_OriginVisible.Checked := True;
  CB_MarkGridPoints.Enabled := CB_CoordSysVisible.Checked;
  CB_ScaleAxis.Enabled      := CB_CoordSysVisible.Checked;
  GridSpacing.Enabled       := CB_CoordSysVisible.Checked and
                               CB_MarkGridPoints.Checked;
  GridMarks.Enabled         := GridSpacing.Enabled;
  end;

procedure TCoordDlg.CB_MarkGridPointsClick(Sender: TObject);
  begin
  GridSpacing.Enabled       := CB_MarkGridPoints.Checked;
  GridMarks.Enabled         := GridSpacing.Enabled;
  end;

procedure TCoordDlg.RB_IsotropClick(Sender: TObject);
  begin
  Ed_Unit.Enabled := True;
  RB_Anisotrop.Checked := False;
  Ed_UnitX.Enabled := False;
  Ed_UnitY.Enabled := False;
  end;

procedure TCoordDlg.RB_AnisotropClick(Sender: TObject);
  begin
  Ed_UnitX.Enabled := True;
  Ed_UnitY.Enabled := True;
  RB_Isotrop.Checked := False;
  Ed_Unit.Enabled := False;
  end;

procedure TCoordDlg.Btn_ResetClick(Sender: TObject);
  begin
  RB_Anisotrop.Checked := False;
  Ed_Unit.Text := Float2Str(ScreenPPCMx, 4);
  Ed_UnitX.Text := Ed_Unit.Text;
  Ed_UnitY.Text := Ed_Unit.Text;
  RB_Isotrop.Checked := True;
  end;


{ Initialisierung und Auswertung }

procedure TCoordDlg.FormShow(Sender: TObject);
  begin
  With TGOrigin(Hauptfenster.Drawing.Items[0]) do begin
    CB_OriginVisible.Checked   := isVisible;
    CB_CoordSysVisible.Checked := ShowAxis;
    CB_CoordSysVisible.Enabled := Not Hauptfenster.Drawing.CoSysInVisGroup;
    CB_MarkGridPoints.Checked  := CSType <> 0;
    CB_MarkGridPoints.Enabled  := CB_CoordSysVisible.Checked;
    CB_ScaleAxis.Checked       := Not AxisNoNumbers;
    CB_ScaleAxis.Enabled       := CB_CoordSysVisible.Checked;

    Case Abs(CSType) of
      1 : GridSpacing.ItemIndex := 0;   { 1cm-Gitter }
      2 : GridSpacing.ItemIndex := 1;   { 2cm-Gitter }
      5 : GridSpacing.ItemIndex := 2;   { 5cm-Gitter }
    end; { of case }
    GridMarks.ItemIndex := GridType;
    GridSpacing.Enabled := CB_CoordSysVisible.Checked and
                           CB_MarkGridPoints.Checked;
    GridMarks.Enabled   := GridSpacing.Enabled;
    Ed_XName.Text := TGAxis(Hauptfenster.Drawing.Items[1]).caption;
    Ed_YName.Text := TGAxis(Hauptfenster.Drawing.Items[2]).caption;
    Ed_Unit.Text  := Float2Str(act_PixelPerXcm, 4);
    Ed_UnitX.Text := Float2Str(act_PixelPerXcm, 4);
    Ed_UnitY.Text := Float2Str(act_PixelPerYcm, 4);
    RB_Isotrop.Checked   := Math.IsZero(act_PixelPerXcm - act_PixelPerYcm, 1e-6);
    RB_Anisotrop.Checked := Not RB_Isotrop.Checked;
    end;
  end;

procedure TCoordDlg.OkayClick(Sender: TObject);
  begin
  try
    With TGOrigin(Hauptfenster.Drawing.Items[0]) do begin
      ShowsAlways := CB_OriginVisible.Checked;
      If Not CB_MarkGridPoints.Checked then
        CSType := 0
      else begin
        Case GridSpacing.ItemIndex of
          0 : CSType := 1;
          1 : CSType := 2;
          2 : CSType := 5;
        else
          CSType := 0;
        end; { of case }
        GridType := GridMarks.ItemIndex;
        end;
      AxisNoNumbers := Not CB_ScaleAxis.Checked;
      end;
    With Hauptfenster.Drawing do begin
      TGAxis(Items[1]).caption := Ed_XName.Text;
      TGAxis(Items[2]).caption := Ed_YName.Text;
      TGAxis(Items[1]).ShowsAlways := CB_CoordSysVisible.Checked;
      TGAxis(Items[2]).ShowsAlways := CB_CoordSysVisible.Checked;
      end;
    If RB_Isotrop.Checked then begin
      act_pixelPerXcm := StrToFloat(Ed_Unit.Text);
      act_pixelPerYcm := act_pixelPerXcm;
      end
    else begin
      act_pixelPerXcm := StrToFloat(Ed_UnitX.Text);
      act_pixelPerYcm := StrToFloat(Ed_UnitY.Text);
      end;
    Hauptfenster.Drawing.RescaleCoordSys(act_pixelPerXcm, act_pixelPerYcm);
    HauptFenster.RefreshSpecialImageButtons;
    ModalResult := mrOk;
  except
    MessageDlg(MyOptMsg[0], mtWarning, [mbOk], 0);
  end; { of try }
  end;

end.
