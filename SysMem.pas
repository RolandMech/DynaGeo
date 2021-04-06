unit SysMem;

interface

{$IFDEF NO_PLATFORMWARNINGS}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSysMemWin = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    LblMemoryLoad: TLabel;
    LblTotalPhys: TLabel;
    LblAvailPhys: TLabel;
    LblTotalPageFile: TLabel;
    LblAvailPageFile: TLabel;
    LblUsedVirtual: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


implementation

{$R *.DFM}

Uses GlobVars;

procedure TSysMemWin.FormShow(Sender: TObject);
  var MemStat         : TMemoryStatusEx;
      // MemManagerState : TMemoryManagerState;  { gegebenenfalls aktivieren }
  begin
  GroupBox2.Caption := ' ' + Copy(MyStartMsg[8], 1, Pos('-', MyStartMsg[8])) +
                       ' ' + FullVersionString(Application.ExeName) + ' ';
  MemStat.dwLength := SizeOf(TMemoryStatusEx);
  GlobalMemoryStatusEx(MemStat);
  With MemStat do begin
    LblMemoryLoad.Caption :=
      Format('%d %%', [dwMemoryLoad]);
    LblTotalPhys.Caption  :=
      Format('%d kB', [ullTotalPhys Div 1024]);
    LblAvailPhys.Caption  :=
      Format('%d kB', [ullAvailPhys Div 1024]);
    LblTotalPageFile.Caption :=
      Format('%d kB', [ullTotalPageFile Div 1024]);
    LblAvailPageFile.Caption :=
      Format('%d kB', [ullAvailPageFile Div 1024]);
    LblUsedVirtual.Caption :=
      Format('%d kB', [(ullTotalVirtual - ullAvailVirtual) Div 1024]);
    end;
  { Bei Bedarf kann die folgende Funktion detaillierte Informationen über
    den Heap-Speicher liefern (dann Ergebnis-Puffer oben aktivieren!) :   }
  // GetMemoryManagerState(MemManagerState);
  end;

end.
