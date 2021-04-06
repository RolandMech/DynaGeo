unit HTMLDynaGeoJSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IntEdit;

type
  THTMLDynaGeoJDataForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label6: TLabel;
    BtnBrowseViewer: TButton;
    EditTargetPath: TEdit;
    BtnBrowseHTML: TButton;
    EditViewerPath: TEdit;
    RG_ViewerPathMode: TRadioGroup;
    BtnResetViewerPath: TButton;
    PreText: TMemo;
    BtnSave: TButton;
    BtnCancel: TButton;
    GB_ViewerDimensions: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    IEditWinWidth: TIntEdit;
    IEditWinHeight: TIntEdit;
    EditAuthorName: TEdit;
    BtnViewerCmds: TButton;
    SaveHTMLFile: TSaveDialog;
    ViewerPathDlg: TOpenDialog;
    procedure EditTargetPathChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnResetViewerPathClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnBrowseHTMLClick(Sender: TObject);
    procedure BtnBrowseViewerClick(Sender: TObject);
    procedure BtnViewerCmdsClick(Sender: TObject);
    procedure IEditWinHeightChange(Sender: TObject);
    procedure IEditWinHeightExit(Sender: TObject);
  private
    { Private-Deklarationen }
    ActCmdCount,
    MaxCmdCount  : Integer;
    CmdStr       : String;
    procedure ReadDataFromHTMLFile;
  public
    { Public-Deklarationen }
    OutRect      : TRect;
    IsNewTag     : Boolean;
    TagStartLine,
    TextFirstLine,
    TextLastLine : Integer;
    HTMLFilePath,
    GEOFilePath  : String;
    function Execute : Boolean;
  end;

implementation

{$R *.dfm}

Uses Math, Declar, GlobVars, Utility, MainWin, SelectXCmd, TagSelDlg;

Const ViewerBtnHeight = 38;

function THTMLDynaGeoJDataForm.Execute: Boolean;
  begin
  Result := ShowModal = mrOk;
  end;

procedure THTMLDynaGeoJDataForm.FormShow(Sender: TObject);

  function LocalViewerAvailable: Boolean;
    var s : String;
    begin
    s := ExtractFileDir(Application.ExeName) + '\Viewer\dynageoj.jar';
    Result := FileExists(s);
    end;

  begin
  If LocalViewerAvailable then
    RG_ViewerPathMode.Enabled := True
  else begin
    RG_ViewerPathMode.ItemIndex := 0;
    RG_ViewerPathMode.Enabled := False;
    end;
  TextFirstLine :=  0;
  TextLastLine  := -1;
  CmdStr := Hauptfenster.Drawing.CmdString;
  BtnResetViewerPathClick(Sender);
  If Hauptfenster.SelStatus > 0 then
    OutRect := Hauptfenster.SelRect
  else if Hauptfenster.WindowState = wsNormal then
    OutRect := HauptFenster.PaintBox1.ClientRect
  else
    OutRect := Rect(0, 0, 499, 349);
  IEditWinWidth.Value  := Succ(OutRect.Right - OutRect.Left);
  IEditWinHeight.Value := Succ(OutRect.Bottom - OutRect.Top);
  SaveHTMLFile.InitialDir := ExtractFilePath(Hauptfenster.ActGeoFileName);
  IsNewTag             := False;
  GEOFilePath          := ChangeFileExt(Hauptfenster.ActGeoFileName, '.geo');
  HTMLFilePath         := '';     // Löschen, damit HTML-Datei gecheckt wird !
  EditTargetPath.Text  := ChangeFileExt(Hauptfenster.ActGeoFileName, '.html');
  EditTargetPathChange(Sender);   // Setzt HTMLFilePath !
  end;


procedure THTMLDynaGeoJDataForm.FormCloseQuery(Sender: TObject;
                                               var CanClose: Boolean);
  begin
  If BtnSave.Focused then begin
    If (IEditWinWidth.Value * IEditWinHeight.Value > Screen.Width * Screen.Height / 4) and
       (MessageDlg(MyMess[119], mtWarning, [mbYes, mbNo], 0) = mrNo) then begin
      CanClose := False;
      IEditWinWidth.SetFocus;
      end
    else begin
      With OutRect do begin
        right := left + IEditWinWidth.Value;
        bottom := top + IEditWinHeight.Value;
        end;
      ActCmdCount := Length(CmdStr) Div 2;
      MaxCmdCount := (OutRect.Bottom - OutRect.Top - 12) Div ViewerBtnHeight;
      If ActCmdCount > MaxCmdCount then begin
        MessageDlg(Format(MyMess[51], [ActCmdCount, MaxCmdCount]), mtError, [mbOk], 0);
        CanClose := False;
        end
      else begin
        CanClose := ModalResult = mrOk;
        If CanClose then
          Hauptfenster.Drawing.CmdString := CmdStr;
        end
      end
    end
  else
    CanClose := True;
  end;

procedure THTMLDynaGeoJDataForm.BtnBrowseHTMLClick(Sender: TObject);
  begin
  If SaveHTMLFile.Execute then begin
    EditTargetPath.Text := ChangeFileExt(SaveHTMLFile.FileName, '.html');
    EditTargetPathChange(Sender);
    end;
  end;


procedure THTMLDynaGeoJDataForm.BtnBrowseViewerClick(Sender: TObject);
  var s : String;
  begin
  If ViewerPathDlg.Execute then begin
    s := ExtractRelativePath(EditTargetPath.Text, ViewerPathDlg.FileName);
    if Length(s) > 0 then begin
      if s[1] <> '.' then  // absoluter Pfad!
        s := FilePathAsURL(ViewerPathDlg.FileName);
      EditViewerPath.Text := s;
      end;
    end;
  end;


procedure THTMLDynaGeoJDataForm.BtnResetViewerPathClick(Sender: TObject);
  begin
  If RG_ViewerPathMode.ItemIndex = 0 then
    EditViewerPath.Text := JViewerInternetPath
  else
    EditViewerPath.Text :=
      FilePathAsURL(ExtractFilePath(Application.ExeName) +
                    'viewer\dynageoj.jar');
  end;

procedure THTMLDynaGeoJDataForm.BtnViewerCmdsClick(Sender: TObject);
  var SelectXCmdForm: TSelectXCmdForm;
  begin
  SelectXCmdForm := TSelectXCmdForm.CreateWithCmdStr(Self, CmdStr);
  If SelectXCmdForm.ShowModal = mrOk then begin
    CmdStr := SelectXCmdForm.GetCommands;
    ActCmdCount := Length(CmdStr) Div 2;
    If ActCmdCount > MaxCmdCount then
      MessageDlg(Format(MyMess[51], [ActCmdCount, MaxCmdCount]), mtWarning, [mbOk], 0);
    end;
  SelectXCmdForm.Release;
  end;

procedure THTMLDynaGeoJDataForm.IEditWinHeightChange(Sender: TObject);
  begin
  MaxCmdCount := (IEditWinHeight.Value - 76) Div ViewerBtnHeight;
  end;

procedure THTMLDynaGeoJDataForm.IEditWinHeightExit(Sender: TObject);
  begin
  If ActCmdCount > MaxCmdCount then
    MessageDlg(Format(MyMess[51], [ActCmdCount, MaxCmdCount]), mtWarning, [mbOk], 0);
  BtnViewerCmds.SetFocus;
  end;

type TTagData = class(TObject)
                public
                  line     : Integer;
                  archive  : String;
                  width    : Integer;
                  height   : Integer;
                  filename : String;
                end;

procedure THTMLDynaGeoJDataForm.ReadDataFromHTMLFile;
  var SL : TStringList; { String-Liste für HTML-Code der existierenden Ziel-Datei }
      TL : TList;       { Tag-Liste }
      SelTagIndex,
      startLine,
      idLine,
      endLine,
      i         : Integer;
      s         : String;
      TagData   : TTagData;
      TagSelect : TTagSelectDlg;

  function NewTagStart(L: TStrings): Integer;
    var fLine : Integer;
    begin
    If SearchForw('</body>', L, 0, fLine) or
       SearchForw('</html>', L, 0, fLine) then begin
      NewTagStart := fLine;
      IsNewTag    := True;
      end
    else
      NewTagStart := -1;    // Ziel-Datei verletzt HTML-Syntax-Regeln !
    end;

  function GetTextLastLineFromTagStartLine: Integer;
    var i : Integer;
    begin
    i := TagStartLine - 1;
    s := SL.Strings[i];
    DeleteChars(' ', s);
    If s = '<center>' then begin
      i := i - 1;
      s := SL.Strings[i];
      DeleteChars(' ', s);
      If s = '<br>' then
        i := i - 1;
      end;
    Result := i;
    end;

  begin
  SL := TStringList.Create;
  try
    SL.LoadFromFile(HTMLFilePath);
    TL := TList.Create;
    try
      startLine := 0;
      While SearchForw('<applet', SL, startLine, startLine) do
        If SearchForw('</applet', SL, startLine, endLine) and
           SearchForw('de.dynageo.dynageoj.applet.DynaGeoJApplet', SL, startLine, idLine) and
           (startLine <= idLine) and
           (idLine <= endLine) then begin
          TagData := TTagData.Create;
          With TagData do begin
            line     := startLine;
            archive  := ExtractData('archive', SL, startLine);
            width    := StrToInt(ExtractData('width', SL, startLine)) - 50;
            height   := StrToInt(ExtractData('height', SL, startLine));
            filename := ExtractData('value', SL, startLine);
            end;
          TL.Add(TagData);
          startLine := endLine + 1;
          end
        else
          startLine := startLine + 1;

      SelTagIndex := -1;
      If TL.Count = 0 then  // kein Tag gefunden
        If SL.Count = 0 then   // leere Zieldatei  ==> komplett neu schreiben !
          TagStartLine := -1
        else                   // nicht-leere Zieldatei ohne Tag
          TagStartLine := NewTagStart(SL)
      else                 // mindestens 1 Tag gefunden
        If (TL.Count = 1) and  // genau 1 Tag gefunden und Namen sind synchron
           (UpperCase(TTagData(TL.Items[0]).filename) =
            UpperCase(ExtractFileName(GEOFilePath))) then begin
          SelTagIndex := 0;
          TagStartLine := TTagData(TL.Items[0]).line;
          If Hauptfenster.SelStatus <= 0 then begin
            IEditWinWidth.Value  := TTagData(TL.Items[0]).width;
            IEditWinHeight.Value := TTagData(TL.Items[0]).height;
            end;
          EditViewerPath.Text := TTagData(TL.Items[0]).archive;
          end
        else begin             // mehr als 1 Tag oder Namen sind nicht synchron
          TagSelect := TTagSelectDlg.Create(Self);  // => Auswahl-Dialog zeigen
          try
            For i := 0 to Pred(TL.Count) do begin
              TagSelect.ListBox1.Items.Add(TTagData(TL.Items[i]).filename);
              If UpperCase(TTagData(TL.Items[i]).filename) =
                 UpperCase(ExtractFileName(GEOFilePath)) then
                TagSelect.ListBox1.ItemIndex := i;
              end;
            If TagSelect.ListBox1.ItemIndex >= 0 then
              TagSelect.RadioButton1.Checked := True
            else
              TagSelect.RadioButton2.Checked := True;
            TagSelect.ShowModal;
            If (TagSelect.RadioButton1.Checked) and
               (TagSelect.ListBox1.ItemIndex >= 0) then begin
              SelTagIndex := TagSelect.ListBox1.ItemIndex;
              TagStartLine := TTagData(TL.Items[SelTagIndex]).line;
              IEditWinWidth.Value  := TTagData(TL.Items[SelTagIndex]).width;
              IEditWinHeight.Value := TTagData(TL.Items[SelTagIndex]).height;
              EditViewerPath.Text  := TTagData(TL.Items[SelTagIndex]).archive;
              end
            else begin
              SelTagIndex := TL.Count;
              TagStartLine := NewTagStart(SL);
              If Hauptfenster.SelStatus > 0 then begin
                IEditWinWidth.Value  := OutRect.Right - OutRect.Left;
                IEditWinHeight.Value := OutRect.Bottom - OutRect.Top;
                end
              else begin
                IEditWinWidth.Value  := Min(660, OutRect.Right - OutRect.Left);
                IEditWinHeight.Value := Min(408, OutRect.Bottom - OutRect.Top);
                end;
              end;
          finally
            TagSelect.Free;
          end;
          end; { of else }

      PreText.Lines.Clear;
      TextFirstLine :=  0;
      TextLastLine  := -1;
      If (TagStartLine >= 0) and (TagStartLine < SL.Count) then
        If SelTagIndex > 0 then begin
          i := Succ(TTagData(TL.Items[Pred(SelTagIndex)]).line);
          If SearchForw('</applet', SL, i, i) then begin
            i := i + 1;
            s := SL.Strings[i];
            DeleteChars(' ', s);
            If s = '</center>' then begin
              i := i + 1;
              s := SL.Strings[i];
              DeleteChars(' ', s);
              If s = '<br>' then
                i := i + 1;
              end
            else
              if s = '</center><br>' then
                i := i + 1;
            TextFirstLine := i;
            end
          else
            TextFirstLine := TTagData(TL.Items[SelTagIndex]).line - 1;
          TextLastLine  := GetTextLastLineFromTagStartLine;
          end
        else     // Normalfall: es gibt nur 1 <applet>-Tag in der Datei !
          If SearchForw('<body', SL, 0, i) then begin  // Normalerweise beginnt der
            TextFirstLine := i + 1;                    // "Text oberhalb" direkt oben.
            TextLastLine := GetTextLastLineFromTagStartLine;
            end
          else begin  // Diese Datei erfüllt die HTML-Spezifikationen nicht!
            i := GetTextLastLineFromTagStartLine;
            TextFirstLine := i;
            TextLastLine  := i - 1;
            end;

      If TextFirstLine > 0 then
        For i := TextFirstLine to TextLastLine do
          PreText.Lines.Add(SL.Strings[i]);

      EditAuthorName.Text := '';
      If SearchForw('<META NAME="Author"', SL, 0, i) then
        EditAuthorName.Text := HTMLExtractAttrValue('CONTENT', SL.Strings[i]);
      With EditAuthorName do
        ReadOnly := Length(Text) > 0;

      For i := Pred(TL.Count) downTo 0 do begin
        TTagData(TL.Items[i]).Free;
        TL.Items [i] := Nil;
        end;
    finally
      TL.Free;
    end; { of inner try }
  finally
    SL.Free;
  end; { of outer try }
  end;

procedure THTMLDynaGeoJDataForm.EditTargetPathChange(Sender: TObject);
  begin
  If (Length(EditTargetPath.Text) > 0) and
     (HTMLFilePath <> EditTargetPath.Text) then begin
    HTMLFilePath := EditTargetPath.Text;
    GEOFilePath  := ExtractFilePath(HTMLFilePath) + ExtractFileName(GEOFilePath);
    If FileExists(HTMLFilePath) then
      ReadDataFromHTMLFile;
    end;
  end;

end.
