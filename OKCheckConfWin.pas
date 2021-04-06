unit OKCheckConfWin;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, Grids, ValEdit, Dialogs,
     GeoTypes, GeoConic, GeoHelper, FormatEdit;

type
  TConfigOKCheckDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    VLEditor: TValueListEditor;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Ed_LinkSuccess: TEdit;
    Ed_LinkFail: TEdit;
    Label6: TLabel;
    Ed_Hint: TEdit;
    Ed_Term: TFormatEdit;
    procedure FormShow(Sender: TObject);
    procedure Ed_TermExit(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FDrawing : TGeoObjListe;
    FActFile : String;
    Vars,
    TypList  : TStringList;
    function LoadVarsFrom(src: String): Boolean;
  public
    { Public-Deklarationen }
    constructor CreateWD(AOwner: TComponent; ADrawing: TGeoObjListe; AFileName: String);
    destructor Destroy; override;
  end;


implementation

{$R *.dfm}

Uses StrUtils, MathLib, GlobVars, Utility, TBaum;

{ Als Variablen stehen die Ausdrücke "@0", "@1", "@2",...."@9" zur Verfügung. }


{========= Lebenslauf ===========================}

constructor TConfigOKCheckDlg.CreateWD(AOwner: TComponent;
                                       ADrawing: TGeoObjListe;
                                       AFileName: String);
  var i : Integer;
  begin
  Inherited Create(AOwner);
  FDrawing := ADrawing;
  FActFile := AFileName;
  TypList := TStringList.Create;
  For i := 0 to High(varTypeStrs) do
    TypList.Add(varTypeStrs[i]);
  Vars := TStringList.Create;
  end;

destructor TConfigOKCheckDlg.Destroy;
  begin
  Vars.Free;
  TypList.Free;
  Inherited Destroy;
  end;

{========== Hilfs-Prozeduren =========================}

function TConfigOKCheckDlg.LoadVarsFrom(src: String): Boolean;
  var bsl  : TStringList;  // "b"uffer "s"tring "l"ist
      s, t : String;
      n, i : Integer;
  begin
  Result := True;
  bsl := TStringList.Create;
  try
    i := Pos('@', src);
    While Result and (i > 0) do begin
      If (i + 1 > Length(src)) or
         Not CharInSet(src[i+1], ['1', '2', '3', '4', '5', '6', '7', '8', '9']) then
        Result := False;
      i := PosEx('@', src, i+1);
      end;
    i := 1;
    n := Pos('@', src);
    While Result and            // Solange kein Fehler auftaucht
          (n > 0) do begin      // und noch ein '@' in src vorkommt:
      s := '@' + IntToStr(i);   // Nächsten @-Variablennamen basteln ...
      n := Pos(s, src);         // ... und danach in src suchen
      If n > 0 then begin
        If s ='@0' then
          Result := False            // Ungültige Variable gefunden !
        else begin
          t := Vars.Values[s];       // Möglichst alte Typen übernehmen
          If Length(t) = 0 then
            t := varTypeStrs[0];       // Notfalls auf "Punkt" setzen
          bsl.Add(s + '=' + t);
          Repeat
            Delete(src, n, 2);         // Alle Vorkommen der aktuellen
            n := Pos(s, src);          //    @-Variablen löschen
          until n = 0;
          end;
        end;
      i := i + 1;               // Auf nächsten möglichen Index schalten
      n := Pos('@', src);       // Ein '@' in src suchen
      end;
    Vars.Clear;                 // Variablenliste löschen
    If Result then
      Vars.Text := bsl.Text;    // Gegebenenfalls neue Daten übernehmen
  finally
    bsl.Free;
  end; { of try }
  With VLEditor do begin
    Strings.Text := Vars.Text;  // Aktuelle Daten an die Oberfläche durchreichen !
    For i := 0 to Pred(Strings.Count) do begin
      ItemProps[i].EditStyle := esPickList;
      ItemProps[i].PickList  := TypList;
      ItemProps[i].ReadOnly  := True;
      end;
    end;
  end;

{=========== Methoden =================================}

procedure TConfigOKCheckDlg.FormShow(Sender: TObject);
  var i : Integer;
      CCO : TGCheckControl;
  begin
  CCO := FDrawing.CheckControl as TGCheckControl;
  If Assigned(CCO) then begin
    Ed_Term.HTMLTextAsString := CCO.VTermStr;
    Ed_Hint.Text := CCO.VHint;
    If Length(CCO.VVars) > 0 then begin
      Vars.Text := CCO.VVars;
      With VLEditor do begin
        Strings.Text := Vars.Text;
        For i := 0 to Pred(Vars.Count) do begin
          ItemProps[i].EditStyle := esPickList;
          ItemProps[i].PickList  := TypList;
          ItemProps[i].ReadOnly  := True;
          end;
        end;
      end;
    end
  else
    LoadVarsFrom(Ed_Term.HTMLTextAsString);
  Ed_LinkSuccess.Text := FDrawing.LinkForward;
  Ed_LinkFail.Text := FDrawing.LinkBack;
  end;

procedure TConfigOKCheckDlg.Ed_TermExit(Sender: TObject);
  begin
  If Not LoadVarsFrom(Ed_Term.HTMLTextAsString) then begin
    MessageDlg(MyMess[132], mtWarning, [mbOk], 0);
    Ed_Term.SetFocus;
    end;
  end;


procedure TConfigOKCheckDlg.OKBtnClick(Sender: TObject);
  { Zunächst wird die Korrektheits-Bedingung nur darauf überprüft,
    ob sie genau so viele schließende wie öffnende Klammern enthält.
    Falls ja, wird eine Probe-Kompilation des Terms durchgeführt.   }

  var ts     : WideString;
      ErrStr : String;
      ErrNum : Integer;

  function LinksOkay(var ErrNum: Integer): Boolean;
    var ExePath,
        s        : String;
        ok1, ok2 : Boolean;
    begin
    ErrNum := 0;
    ExePath := ExtractFilePath(FActFile);
    ok1 := True;
    ok2 := True;
    If Length(Ed_LinkSuccess.Text) > 0 then begin
      s := Ed_LinkSuccess.Text;
      While s[1] = '\' do Delete(s, 1, 1);
      s := ExePath + s;
      ok1 := FileExists(s) or
             (MessageDlg(Format(MyMess[120], [s, Ed_LinkSuccess.Text]), mtInformation, [mbYes, mbNo], 0) = mrYes);
      end;
    If ok1 and (Length(Ed_LinkFail.Text) > 0) then begin
      s := Ed_LinkFail.Text;
      While s[1] = '\' do Delete(s, 1, 1);
      s := ExePath + s;
      ok2 := FileExists(s) or
             (MessageDlg(Format(MyMess[120], [s, Ed_LinkFail.Text]), mtInformation, [mbYes, mbNo], 0) = mrYes);
      end;
    If not ok1 then ErrNum := 11;
    If not ok2 then ErrNum := 12;
    Result :=  ok1 and ok2;
    end;

  begin  { of OKBtnClick }
  ts := HTMLString2WideString(Ed_Term.GetHTMLTextLine(0));
  If Length(ts) > 0 then begin
    If ValidationTermOk(FDrawing, ts, VLEditor.Strings.Text, ErrStr, ErrNum) and
       LinksOkay(ErrNum) then
      ModalResult := mrOk
    else begin
      MessageDlg(ErrStr, mtWarning, [mbOk], 0);
      Case ErrNum of
        11 : Ed_LinkSuccess.SetFocus;
        12 : Ed_LinkFail.SetFocus;
      else
        Ed_Term.SetFocus;
        If ErrNum < 0 then begin
          Ed_Term.ActCursorPos := Point(0, -ErrNum);
          Ed_Term.RevokeActSelection;
          end
        else begin
          Ed_Term.ActCursorPos := Point(0, 0);
          Ed_Term.SelectActualLine;
          end;
      end; { of case }
      end;
    end
  else
    if MessageDlg(MyMess[121], mtInformation, [mbYes, mbNo], 0) = mrYes then
      ModalResult := mrOK;
  end;   { of OKBtnClick }

end.
