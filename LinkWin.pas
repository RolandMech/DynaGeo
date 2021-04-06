unit LinkWin;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
     Buttons, ExtCtrls, FormatEdit;

type
  TEditLinkDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    GeoFilePath : String;
    FEdit       : TFormatEdit;
    function IsValidLink(s: String): Boolean;
  public
    { Public-Deklarationen }
    constructor CreateWithTargetEdit(Owner: TComponent;
                                     iFEdit: TFormatEdit;
                                     iGeoFilePath: String);
  end;


implementation

uses Dialogs, GlobVars, Utility;

{$R *.dfm}

function TEditLinkDlg.IsValidLink(s: String): Boolean;
  var ffp : String;    // "f"ull "f"ile "p"ath
  begin
  If Length(s) > 0 then begin
    ffp := MergeFilePathAndRelFileName(ExtractFilePath(GeoFilePath), s);
    Result := FileExists(ffp);
    end
  else
    Result := False;
  end;

constructor TEditLinkDlg.CreateWithTargetEdit(Owner: TComponent;
                                              iFEdit: TFormatEdit;
                                              iGeoFilePath: String);
  begin
  Inherited Create(Owner);
  FEdit       := iFEdit;
  GeoFilePath := iGeoFilePath;
  end;

procedure TEditLinkDlg.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
  begin
  If CancelBtn.Focused then
    CanClose := True
  else
    if (Length(Edit1.Text) > 0) and (Length(Edit2.Text) > 0) then
      if IsValidLink(Edit2.Text) then
        CanClose := True   // Normalfall
      else
        CanClose := MessageDlg(Format(MyMess[124], [Edit2.Text]),
                               mtInformation, [mbYes, mbNo], 0) = mrYes
    else begin
      CanClose := False;
      MessageDlg(MyMess[125], mtWarning, [mbOk], 0);
      end
  end;

end.
