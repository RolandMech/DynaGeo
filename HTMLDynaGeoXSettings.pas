unit HTMLDynaGeoXSettings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, IntEdit;
  
type
  THTMLDynaGeoXDataForm = class(TForm)
    BtnBrowseViewer: TButton;
    EditTargetPath: TEdit;
    Label1: TLabel;
    BtnBrowseHTML: TButton;
    Label2: TLabel;
    EditViewerPath: TEdit;
    RG_ViewerPathMode: TRadioGroup;
    BtnResetViewerPath: TButton;
    Label3: TLabel;
    PreText: TMemo;
    BtnSave: TButton;
    BtnCancel: TButton;
    SaveHTMLFile: TSaveDialog;
    ViewerPathDlg: TOpenDialog;
    GB_ViewerDimensions: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    IEditWinWidth: TIntEdit;
    IEditWinHeight: TIntEdit;
    Label6: TLabel;
    EditAuthorName: TEdit;
    BtnViewerCmds: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnBrowseHTMLClick(Sender: TObject);
    procedure BtnBrowseViewerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnResetViewerPathClick(Sender: TObject);
    procedure BtnViewerCmdsClick(Sender: TObject);
    procedure IEditWinHeightChange(Sender: TObject);
    procedure IEditWinHeightExit(Sender: TObject);
    procedure EditTargetPathChange(Sender: TObject);
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

{$R *.DFM}

Uses Math, Declar, GlobVars, Utility, MainWin, SelectXCmd, TagSelDlg;

Const ViewerBtnHeight = 38;

function THTMLDynaGeoXDataForm.Execute: Boolean;
  begin
  Result := ShowModal = mrOk;
  end;

procedure THTMLDynaGeoXDataForm.FormShow(Sender: TObject);

  function LocalViewerAvailable: Boolean;
    var s : String;
    begin
    s := ExtractFileDir(Application.ExeName) + '\Viewer\DynaGeoX3.ocx';
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
  else if (OutRect.Right - OutRect.Left < 10) or
          (OutRect.Bottom - OutRect.Top < 10) then
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


procedure THTMLDynaGeoXDataForm.FormCloseQuery(Sender: TObject;
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

procedure THTMLDynaGeoXDataForm.BtnBrowseHTMLClick(Sender: TObject);
  begin
  If SaveHTMLFile.Execute then begin
    EditTargetPath.Text := ChangeFileExt(SaveHTMLFile.FileName, '.html');
    EditTargetPathChange(Sender);
    end;
  end;


procedure THTMLDynaGeoXDataForm.BtnBrowseViewerClick(Sender: TObject);
  begin
  If ViewerPathDlg.Execute then
    EditViewerPath.Text := FilePathAsURL(ViewerPathDlg.FileName);
  end;


procedure THTMLDynaGeoXDataForm.BtnResetViewerPathClick(Sender: TObject);
  begin
  If RG_ViewerPathMode.ItemIndex = 0 then
    EditViewerPath.Text := XViewerInternetPath
  else
    EditViewerPath.Text :=
      FilePathAsURL(ExtractFilePath(Application.ExeName) +
                    'Viewer\DynaGeoX3.ocx');
  end;

procedure THTMLDynaGeoXDataForm.BtnViewerCmdsClick(Sender: TObject);
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

procedure THTMLDynaGeoXDataForm.IEditWinHeightChange(Sender: TObject);
  begin
  MaxCmdCount := (IEditWinHeight.Value - 76) Div ViewerBtnHeight;
  end;

procedure THTMLDynaGeoXDataForm.IEditWinHeightExit(Sender: TObject);
  begin
  If ActCmdCount > MaxCmdCount then
    MessageDlg(Format(MyMess[51], [ActCmdCount, MaxCmdCount]), mtWarning, [mbOk], 0);
  BtnViewerCmds.SetFocus;
  end;

type TTagData = class(TObject)
                public
                  line     : Integer;
                  width    : Integer;
                  height   : Integer;
                  filename : String;
                end;

procedure THTMLDynaGeoXDataForm.ReadDataFromHTMLFile;
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
      While SearchForw('<object', SL, startLine, startLine) do
        If SearchForw('</object', SL, startLine, endLine) and
           SearchForw('2EF98DE5-183F-11D4-83EC-EC6A1DB6E213', SL, startLine, idLine) and
           (startLine <= idLine) and
           (idLine <= endLine) then begin
          TagData := TTagData.Create;
          With TagData do begin
            line     := startLine;
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
          If Hauptfenster.SelStatus > 0 then begin
            IEditWinWidth.Value  := OutRect.Right - OutRect.Left;
            IEditWinHeight.Value := OutRect.Bottom - OutRect.Top;
            end
          else begin
            IEditWinWidth.Value  := TTagData(TL.Items[0]).width;
            IEditWinHeight.Value := TTagData(TL.Items[0]).height;
            end;
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
          If SearchForw('</object', SL, i, i) then begin
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
        else     // Normalfall: es gibt nur 1 <object>-Tag in der Datei !
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

procedure THTMLDynaGeoXDataForm.EditTargetPathChange(Sender: TObject);
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
