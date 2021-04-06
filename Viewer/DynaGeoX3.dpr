library DynaGeoX3;

uses
  ComServ,
  DynaGeoX3_TLB in 'DynaGeoX3_TLB.pas',
  DynaGeoImpl in 'DynaGeoImpl.pas' {DynaGeoX: TActiveForm} {DynaGeoX: CoClass},
  About1 in 'About1.pas' {DynaGeoXAbout},
  Declar in '..\Declar.pas',
  GeoTypes in '..\GeoTypes.pas',
  Mathlib in '..\Mathlib.pas',
  tbaum in '..\tbaum.pas',
  utility in '..\utility.pas',
  GeoEvents in '..\GeoEvents.pas',
  CmdProc in 'CmdProc.pas',
  TermForm in 'TermForm.pas',
  CommentWin in 'CommentWin.pas' {TextWin},
  SmallSelectWin in 'SmallSelectWin.pas' {SelectWin},
  PropPage in 'PropPage.pas' {DGXPropPage1: TPropertyPage},
  TermEdit in 'TermEdit.pas' {TermEditDlg},
  WertEing in 'WertEing.pas' {WertEingabeDlg},
  RangeEdit in 'RangeEdit.pas' {RangeEditWin},
  RTF2HTMLConv in '..\RTF2HTMLConv.pas',
  NameDlg in 'NameDlg.pas' {ObjNameDlg},
  ToolBarProc in 'ToolBarProc.pas',
  FileIO in '..\FileIO.pas',
  GeoMakro in '..\GeoMakro.pas',
  KoordEing in 'KoordEing.pas' {KoordEingabeDlg},
  GeoLocLines in '..\GeoLocLines.pas',
  ValidateResultWin in '..\ValidateResultWin.pas' {ValidationResultWin},
  GeoConic in '..\GeoConic.pas',
  GeoTransf in '..\GeoTransf.pas',
  GeoImage in '..\GeoImage.pas',
  GeoHelper in '..\GeoHelper.pas',
  GlobVars in '..\GlobVars.pas',
  GeoVerging in '..\GeoVerging.pas',
  Unit_LGS in '..\Unit_LGS.pas',
  GeoGroup in '..\GeoGroup.pas';

{$E ocx}

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}
{$R MYEUKLID.RES}

begin
end.
