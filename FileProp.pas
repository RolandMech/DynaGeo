unit FileProp;

interface

{$IFDEF NO_PLATFORMWARNINGS}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, OKCheckConfWin;

type
  TFileProps = class(TForm)
    BtnOkay: TButton;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    ShowEditCaps: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DName: TLabel;
    Label2: TLabel;
    DProgVersion: TLabel;
    Label3: TLabel;
    DCreateDat: TLabel;
    Label5: TLabel;
    DChangeDat: TLabel;
    Label4: TLabel;
    DSize: TLabel;
    Bevel1: TBevel;
    BtnCancel: TButton;
    procedure BtnOkayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
    { Private-Deklarationen }
    CR_changed : Boolean;
  public
    { Public-Deklarationen }
  end;


implementation

{$R *.DFM}

Uses GlobVars, Utility, GeoTypes, MainWin, SelectXCmd;

procedure TFileProps.FormShow(Sender: TObject);
  var GOL           : TGeoObjListe;
      FileData      : TSearchRec;
      dt0, dt1, dt2 : TDateTime;
  begin
  GOL := Hauptfenster.Drawing;
  If Length(GOL.LastEditDate) > 0 then begin
    DName.Caption        := ExtractFileName(Hauptfenster.ActGeoFileName);
    DCreateDat.Caption   := GOL.CreationDate;
    DChangeDat.Caption   := GOL.LastEditDate;
    DProgVersion.Caption := GOL.LastEditProg + ' ' + GOL.LastEditVers;
    If FindFirst(HauptFenster.ActGeoFileName, faAnyFile, FileData) = 0 then
      DSize.Caption := IntToStr(FileData.Size)
    else
      DSize.Caption := MyFileMsg[19];
    end { of outer if }
  else
    try
      If FindFirst(HauptFenster.ActGeoFileName, faAnyFile, FileData) = 0 then
        With FileData do begin
          DName.Caption        := Name;
          DProgVersion.Caption := 'EUKLID DynaGeo ' + GeoFileVersion;
          dt0 := GetDateTimeFromFATTime (Time);
          dt1 := GetDateTimeFromFileTime(FindData.ftLastWriteTime);
          dt2 := GetDateTimeFromFileTime(FindData.ftCreationTime);
          If (Abs(dt0 - dt1) < 1.16e-4) and { 10 s Unterschied wird toleriert }
             (dt1 >= dt2) then begin
            DChangeDat.Caption := FormatDateTime(MyFileMsg[4], dt1);
            DCreateDat.Caption := FormatDateTime(MyFileMsg[4], dt2)
            end
          else begin
            DChangeDat.Caption := FormatDateTime(MyFileMsg[4], dt0);
            DCreateDat.Caption := MyFileMsg[19];
            end;
          DSize.Caption    := IntToStr(Size) + ' Bytes';
          end
      else begin // neue, noch nicht gespeicherte Datei
        DName.Caption        := MyFileMsg[20];
        DProgVersion.Caption := GeoFileVersion;
        DCreateDat.Caption   := '';
        DChangeDat.Caption   := '';
        DSize.Caption        := '';
        end;
    finally
      FindClose(FileData);
    end; { of try }

  Memo1.Lines.Assign(HauptFenster.Drawing.CRText);
  Memo1.ReadOnly  := IsShareware or
                     ((HauptFenster.Drawing.CRNr <> 0) and
                      (HauptFenster.Drawing.CRNr <> LizenzNr));
  If Memo1.ReadOnly then
    ShowEditCaps.Caption := MyMess[68]
  else
    ShowEditCaps.Caption := MyMess[69];
  CR_changed := False;
  BtnOkay.SetFocus;
  end;

procedure TFileProps.Memo1Change(Sender: TObject);
  begin
  CR_changed := True;
  end;

procedure TFileProps.BtnOkayClick(Sender: TObject);
  begin
  If CR_changed then begin
    HauptFenster.Drawing.CRText.Assign(Memo1.Lines);
    HauptFenster.Drawing.CRNr := LizenzNr;
    HauptFenster.Drawing.IsDirty := True;
    end;
  Close;
  end;

end.
