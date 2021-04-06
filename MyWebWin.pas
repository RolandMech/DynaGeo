unit MyWebWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, OleCtrls, SHDocVw, StdCtrls, ExtCtrls;

type
  TBrowserWin = class(TForm)
    MyBrowser: TWebBrowser;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    constructor CreateWD(AOwner: TComponent; WebAddress: WideString);
  end;

implementation

{$R *.DFM}

constructor TBrowserWin.CreateWD(AOwner: TComponent; WebAddress: WideString);
  begin
  Inherited Create(AOwner);
  MyBrowser.Navigate(WebAddress);
  end;

end.
