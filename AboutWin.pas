unit AboutWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TAboutBox = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    LData1: TLabel;
    LData2: TLabel;
    LData3: TLabel;
    LData4: TLabel;
    Image2: TImage;
    Button1: TButton;
    Timer: TTimer;
    Bevel1: TBevel;
    Image3: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

uses IniFDlg, MainWin, Declar, GlobVars, SysMem;

{$R *.DFM}

procedure TAboutBox.FormCreate(Sender: TObject);
  begin
  Label2.Caption := MyStartMsg[16];
  end;

procedure TAboutBox.Button1Click(Sender: TObject);
  begin
  If (not IsShareWare) or
     (Button1.Caption[1] = 'O') then Close;
  end;

procedure TAboutBox.FormShow(Sender: TObject);
  var s1, s2, s3 : String;
  begin
  If IsShareWare then begin
    LData1.Caption := MyStartMsg[0];
    LData2.Caption := MyStartMsg[1];
    LData3.Caption := MyStartMsg[2];
    LData4.Caption := MyStartMsg[3];
    end
  else begin
    If Length(LizNumStr) = 0 then LizNumStr := '0';
    LData1.Caption := TypeOfLicenceString(RegLicType) + MyStartMsg[4];
    HauptFenster.IniFile.LoadLicenceStrings(s1, s2, s3);
    LData2.Caption := s1;
    LData3.Caption := s2;
    LData4.Caption := s3;
    end;
  If IsStartUp then
    with Timer do begin    // Shareware-Nags killed 04.01.2016
      (*
      If IsShareWare then begin
        MyZoomCursor  := #$39;
        Interval := 1000;
        MyMoveCursor  := #$6B;
        MyInputCursor := #$F8;
        end
      else begin
      *)
      Interval := 1000;
      Button1.Caption := MyStartMsg[7];
      //  end;
      Enabled := True;
      end;
  end;

procedure TAboutBox.TimerTimer(Sender: TObject);
  begin
  Timer.Enabled := False;
  Button1.Caption := about_okaybtn;
  // If (Not IsShareWare) or AppShouldClose then
  Close;
  end;

procedure TAboutBox.Image3Click(Sender: TObject);
  begin
  HauptFenster.SysMemWin.ShowModal;
  end;

procedure TAboutBox.FormHide(Sender: TObject);
  begin
  If IsStartUp and IsShareWare then begin
    MyHelpCursor := #$AD;
    MyDragCursor := #$A3;
    end;
  end;

end.
