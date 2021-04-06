unit GeoGroup;

interface

uses Classes, Windows, Graphics, Menus, SysUtils,
     Declar, Utility, TBaum, XMLDoc, XMLIntf;

type TGeoGroup = class(TObject)
        private
          FGeoListe    : TList;
          FId,
          FMask        : Integer;
          FIsStatic,
          FIsVisible,
          FShowingName : Boolean;
          FCondition   : WideString;
          FComment     : WideString;
          FCondTree    : TBoolBaum;
          FMenuItem    : TMenuItem;
          FOutRect,
          FNameRect    : TRect;
          procedure SetComment(s: WideString);
          function  GetIsVisible: Boolean;
          procedure SetIsVisible(newVal: Boolean);
          procedure SetCondition(s: WideString);
        public
          constructor Create(iGeoListe: TList; iId : Integer; iOnClick: TNotifyEvent);
          destructor Destroy; override;
          function  CreateGroupListNode(DOMDoc: IXMLDocument): IXMLNode;
          function ShowMembers: Integer;
          function IsMoused(mx, my: Integer): Boolean;
          procedure MarkAllObjects;
          procedure RevokeAllMarks;
          procedure RebuildTermStrings;
          function MemberCount: Integer;
          function RegisterAllGroupMembers: Integer;
          procedure DrawIt(Canvas: TCanvas; R: TRect; Num: Integer);
          procedure PaintName(Canvas: TCanvas; R: TRect);
          procedure HideName(Canvas: TCanvas);
          property comment: WideString  read FComment write SetComment;
          property condition: WideString read FCondition write SetCondition;
          property IsStatic: Boolean read FIsStatic write FIsStatic;
          property IsVisible: Boolean read GetIsVisible write SetIsVisible;
          property MenuItem: TMenuItem read FMenuItem;
          property Id: Integer read FId;
          property Mask: Integer read FMask;
          property NameRect: TRect read FNameRect;
          property IsShowingName: Boolean read FShowingName;
        end;

     TGeoGroupList = class(TList)
        private
          FItemSpace   : Integer;
          FHandle      : HWnd;
          FOnClick     : TNotifyEvent;
          FVisMask     : Integer;
          IsLoading,
          IsDestroying : Boolean;
          procedure RefreshUI(job: Integer);
          procedure UpdateVisMask;
        public
          constructor Create;
          destructor  Destroy; override;
          procedure Initialize(iHandle: HWnd; iOnClick: TNotifyEvent; iItemSpace: Integer);
          function  CreateGroupListNode(DOMDoc: IXMLDocument): IXMLNode;
          procedure LoadGroupsFromXML(GeoListe: TList; DOMGroups: IXMLNode);
          procedure Add(Item: Pointer);
          procedure Delete(n: Integer);
          procedure ToggleGroupVis(nr: Integer);
          procedure RebuildTermStrings;
          procedure UpdateConditions;
          function  HideName(nr: Integer; Canvas: TCanvas): TRect;
          function  IsGroupVis(ObjMask: Integer): Boolean;
          function  GetCommentFrom(Mask: Integer): String;
          function  GetIconsWidth : Integer;
          function  GetFreeGroupId : Integer;
          function  VisMaskChanged(ovm: Integer = 0) : Integer;
          property  VisMask: Integer read FVisMask;
          property  ItemSpace: Integer read FItemSpace;
          property  WinHandle: HWnd read FHandle;
          property  OnClick: TNotifyEvent read FOnClick;
        end;


implementation

uses GlobVars, GeoTypes;

{====== TGeoGroup =============================}

constructor TGeoGroup.Create(iGeoListe: TList; iId: Integer; iOnClick: TNotifyEvent);
  begin
  Inherited Create;
  FGeoListe := iGeoListe;
  FId := iId;    { Muss eine natürliche Zahl aus [0..31] sein! }
  FMask := 1 SHL FId;
  FIsStatic := True;
  FIsVisible := False;
  FShowingName := False;
  FMenuItem := NewItem('', 0, False, True, iOnClick, cmd_Group, 'GMI' + IntToStr(Fid));
  end;

function TGeoGroup.CreateGroupListNode(DOMDoc: IXMLDocument): IXMLNode;
  var cs : WideString;
  begin
  Result := DOMDoc.createNode('group');
  Result.setAttribute('id', IntToStr(Id));
  cs := MaskDelimiters(comment);
  Result.setAttribute('comment', cs);
  If IsStatic then                             { statische Gruppe }
    If IsVisible then
      Result.setAttribute('visible', 'true')
    else
      Result.setAttribute('visible', 'false')
  else begin                                   { dynamische Gruppe }
    cs := maskDelimiters(condition);
    Result.setAttribute('condition', cs);
    end;
  end;

destructor TGeoGroup.Destroy;
  var i : Integer;
  begin
  For i := 0 to Pred(FGeoListe.Count) do
    TGeoObj(FGeoListe.Items[i]).RevokeFromGroup(FMask);
  FGeoListe := Nil;
  FCondTree.Free;
  FMenuItem.Free;
  Inherited Destroy;
  end;

function TGeoGroup.GetIsVisible: Boolean;
  var cv : Boolean;   // "C"ondition "V"alue
  begin
  If Not IsStatic then begin
    If Not Assigned(FCondTree) then
      FCondTree := TBoolBaum.Create(FGeoListe, Deg, condition);
    cv := FCondTree.Calculate(0);
    FIsVisible := FCondTree.IsOkay and cv;
    end;
  Result := FIsVisible;
  end;

procedure TGeoGroup.SetIsVisible(newVal: Boolean);
  begin
  If IsStatic then
    If FIsVisible <> NewVal then
      FIsVisible := NewVal;
  end;

function TGeoGroup.IsMoused(mx, my: Integer): Boolean;
  begin
  Result := PtInRect(FOutRect, Point(mx, my));
  end;

function TGeoGroup.MemberCount: Integer;
  var n, i : Integer;
  begin
  n := 0;
  For i := 0 to (FGeoListe as TGeoObjListe).LastValidObjIndex do
    If TGeoObj(FGeoListe.Items[i]).Groups and Mask > 0 then
      n := n + 1;
  Result := n;
  end;

function TGeoGroup.ShowMembers: Integer;
  var n, i : Integer;
  begin
  (FGeoListe as TGeoObjListe).MakeHiddenObjectsTempVisible;
  n := 0;
  For i := 0 to (FGeoListe as TGeoObjListe).LastValidObjIndex do
    If TGeoObj(FGeoListe.Items[i]).Groups and FMask > 0 then begin
      TGeoObj(FGeoListe.Items[i]).IsGrouped := True;
      n := n + 1;
      end
    else
      TGeoObj(FGeoListe.Items[i]).IsGrouped := False;
  Result := n;
  end;

procedure TGeoGroup.RebuildTermStrings;
  begin
  If Not IsStatic then begin // FCondTree gibt's nur für *dynamische* Gruppen !
    If FCondTree.IsOkay then
      FCondTree.RebuildSourceStr;
    If Length(FCondTree.SourceStr) > 0 then
      FCondition := FCondTree.SourceStr;
    end;
  end;

procedure TGeoGroup.MarkAllObjects;
  var i : Integer;
  begin
  For i := 0 to (FGeoListe as TGeoObjListe).LastValidObjIndex do
    TGeoObj(FGeoListe.Items[i]).IsGrouped := True;
  end;

procedure TGeoGroup.RevokeAllMarks;
  begin
  (FGeoListe as TGeoObjListe).EraseGroupMarks;
  end;

function TGeoGroup.RegisterAllGroupMembers: Integer;
  var n, i : Integer;
  begin
  n := 0;
  For i := 0 to (FGeoListe as TGeoObjListe).LastValidObjIndex do
    With TGeoObj(FGeoListe.Items[i]) do
      If IsGrouped then begin
        AddToGroup(Mask);
        n := n + 1;
        end
      else
        RevokeFromGroup(Mask);
  RevokeAllMarks;
  Result := n;
  end;

procedure TGeoGroup.DrawIt(Canvas: TCanvas; R: TRect; Num: Integer);
  var Size : Integer;
      Pos  : TPoint;
  begin
  Size := R.Bottom - R.Top - 5;
  Pos := Point(R.Left + 3 + Num * (Size + 3), R.Top + 3);
  FOutRect := Rect(Pos.X, Pos.Y, Pos.X + Size, Pos.Y + Size);

  With Canvas do begin
    Pen.Color := clBlack;
    Pen.Style := psSolid;
    Pen.Width := 2;
    Brush.Style := bsSolid;
    If IsStatic then
      If IsVisible then
        Brush.Color := clBlack
      else
        Brush.Color := clWhite
    else
      Brush.Color := clLtGray;
    Rectangle(FOutRect);
    end;
  end;

procedure TGeoGroup.PaintName(Canvas: TCanvas; R: TRect);
  var s        : String;
      TextSize : TSize;
      ShadRect : TRect;
  begin
  With Canvas do begin
    Font.Name  := 'Arial';
    Font.Size  := 8;
    Font.Style := [];
    Font.Color := clBlack;
    Pen.Color  := clMedGray;
    Pen.Width  := 1;
    Brush.Color := clLtGray;
    Brush.Style := bsSolid;
    s := Format(MyMess[91], [comment]);
    TextSize := TextExtent(s);
    With FNameRect do begin
      If FOutRect.Left + TextSize.cx + 8 < R.Right then begin
        left   := FOutRect.Left;
        right  := left + TextSize.cx;
        end
      else begin
        right  := R.Right - 8;
        left   := right - TextSize.cx;
        end;
      bottom := R.Bottom - 6;
      top    := bottom - TextSize.cy;
      end;
    ShadRect := FNameRect;
    With ShadRect do begin
      left := left + 4;
      right := right + 4;
      top := top + 4;
      bottom := bottom + 4;
      end;
    Rectangle(ShadRect);
    Pen.Color := clDkGray;
    Brush.Color := clYellow;
    Rectangle(FNameRect);
    TextOut(FNameRect.left, FNameRect.top, s);
    FShowingName := True;
    end;
  end;

procedure TGeoGroup.HideName(Canvas: TCanvas);
  begin
  If IsShowingName then
    with Canvas do begin
      Pen.Color  := clWhite;
      Pen.Width  := 1;
      Brush.Color := clWhite;
      Brush.Style := bsSolid;
      With FNameRect do begin
        right := right + 6;
        bottom := bottom + 4;
        end;
      Rectangle(FNameRect);
      FNameRect := Rect(0, 0, 0, 0);
      FShowingName := False;
      end;
  end;

procedure TGeoGroup.SetComment(s: WideString);
  begin
  FComment := s;
  FMenuItem.Caption := s;
  end;

procedure TGeoGroup.SetCondition(s: WideString);
  begin
  If Not Assigned(FCondTree) then
    FCondTree := TBoolBaum.Create(FGeoListe as TGeoObjListe, Deg, s)
  else
    FCondTree.BuildTreeAndReturn(s);
  If FCondTree.IsOkay then begin
    FCondTree.RebuildSourceStr;
    FCondition := FCondTree.SourceStr;
    end
  else
    FCondition := '';
  end;


{ ============= TGeoGroupList ==================================== }

constructor TGeoGroupList.Create;
  begin
  Inherited Create;
  IsDestroying := False;
  end;

procedure TGeoGroupList.Initialize(iHandle: HWnd; iOnClick: TNotifyEvent;
                                   iItemSpace: Integer);
  begin
  FHandle    := iHandle;
  FOnClick   := iOnClick;
  FItemSpace := iItemSpace;
  IsLoading  := False;
  end;

destructor TGeoGroupList.Destroy;
  begin
  IsDestroying := True;
  While Count > 0 do
    Delete(Pred(Count));
  Inherited Destroy;
  end;

function TGeoGroupList.CreateGroupListNode(DOMDoc: IXMLDocument): IXMLNode;
  var i : Integer;
  begin
  If Count > 0 then begin
    Result := DOMDoc.createNode('grouplist');
    For i := 0 to Pred(Count) do
      Result.childNodes.add(TGeoGroup(Items[i]).CreateGroupListNode(DOMDoc));
    end
  else
    Result := Nil;
  end;

procedure TGeoGroupList.LoadGroupsFromXML(GeoListe: TList; DOMGroups: IXMLNode);
  var GroupDE  : IXMLNode;
      newGroup : TGeoGroup;
      newId    : Integer;
      s        : WideString;
  begin
  IsLoading := True;
  Clear;    { Vorsichtshalber mal alle Einträge löschen }
  GroupDE := DomGroups.childNodes.First;
  While GroupDE <> Nil do begin
    newId    := StrToInt(GroupDE.getAttribute('id'));
    newGroup := TGeoGroup.Create(GeoListe, newId, FOnClick);
    s := GroupDE.getAttribute('comment');
    newGroup.comment := RebuildDelimiters(s);
    newGroup.FIsStatic := Not GroupDE.hasAttribute('condition');
    If newGroup.IsStatic then
      If GroupDE.hasAttribute('visible') then
        newGroup.FIsVisible := StrToBool(GroupDE.getAttribute('visible'))
      else
        newGroup.FIsVisible := False
    else begin
      s := GroupDE.getAttribute('condition');
      newGroup.condition := RebuildDelimiters(s);   // baut auch den Baum auf !
      If newGroup.condition = '' then begin         // Ungültige Bedingung ?
        NewGroup.FIsStatic := True;                 //   Dann umschalten auf
        NewGroup.FIsVisible := True;                //   statische Gruppe !
        end;
      end;
    Add(newGroup);
    GroupDE := DomGroups.childNodes.findSibling(GroupDE, 1);
    end;
  UpdateVisMask;
  IsLoading := False;
  end;

procedure TGeoGroupList.RefreshUI(job: Integer);
  { job wird bitweise interpretiert:
      1 (Bit 0 gesetzt) : Menü aktualisieren
      2 (Bit 1 gesetzt) : Statuszeile neu dimensionieren
      4 (Bit 2 gesetzt) : Statuszeile nur neu zeichnen    }
  begin
  If Not IsLoading then
    SendMessage(WinHandle, cmd_ExternCommand, cmd_GroupsChanged, job);
  end;

procedure TGeoGroupList.UpdateVisMask;
  var i : Integer;
  begin
  FVisMask := 0;
  For i := 0 to Pred(Count) do
    With TGeoGroup(Items[i]) do
      If IsVisible then             // Abfrage löst Neuberechnung aus!
        FVisMask := FVisMask or Mask;
  end;

procedure TGeoGroupList.Add(Item: Pointer);
  begin
  Inherited Add(Item);
  RefreshUI(3);
  end;

procedure TGeoGroupList.Delete(n: Integer);
  var delGroup : TGeoGroup;
  begin
  delGroup := Items[n];
  Inherited Delete(n);
  delGroup.Free;
  If Not IsDestroying then
    RefreshUI(3);
  end;

procedure TGeoGroupList.RebuildTermStrings;
  var i : Integer;
  begin
  For i := 0 to Pred(Count) do
    TGeoGroup(Items[i]).RebuildTermStrings;
  end;

procedure TGeoGroupList.UpdateConditions;
  begin
  UpdateVisMask;
  end;

procedure TGeoGroupList.ToggleGroupVis(nr: Integer);
  begin
  If (nr < Count) and
     (TGeoGroup(Items[nr]).IsStatic) then begin
    With TGeoGroup(Items[nr]) do begin
      IsVisible := Not IsVisible;
      end;
    RefreshUI(4);
    UpdateVisMask;
    end;
  end;

function TGeoGroupList.HideName(nr: Integer; Canvas: TCanvas): TRect;
  var i : Integer;
  begin
  If (nr >= Count) or (nr < 0) then begin
    nr := -1;
    i  := 0;
    While (nr < 0) and (i < Count) do
      If TGeoGroup(Items[i]).IsShowingName then
        nr := i
      else
        i := i + 1;
    end;
  If nr >= 0 then
    with TGeoGroup(Items[nr]) do begin
      Result := NameRect;
      HideName(Canvas);
      end
  else
    Result := Rect(0, 0, 0, 0);
  end;

function TGeoGroupList.GetIconsWidth : Integer;
  begin
  If Count > 0 then
    Result := Count * (ItemSpace - 3)
  else
    Result := 0;
  end;

function TGeoGroupList.GetCommentFrom(Mask: Integer): String;
  var n : Integer;
  begin
  If Mask = 0 then
    Result := ''
  else begin
    n := 0;
    While Not Odd(Mask) do begin
      Mask := Mask Div 2;
      n := n + 1;
      end;
    Result := TGeoGroup(Items[n]).comment;  
    end;
  end;

function TGeoGroupList.GetFreeGroupId : Integer;
  var n, i : Integer;
  begin
  n := 0;
  i := 0;
  While i < Count do
    If n = TGeoGroup(Items[i]).Id then begin
      n := n + 1;
      i := 0;
      end
    else
      i := i + 1;
  Result := n;
  end;

function TGeoGroupList.VisMaskChanged(ovm: Integer = 0): Integer;
  begin
  UpdateVisMask;
  Result := FVisMask XOR ovm;
  end;

function TGeoGroupList.IsGroupVis(ObjMask: Integer): Boolean;
  { Liefert genau dann TRUE, wenn das Objekt *keiner* Gruppe angehört
    oder einer Gruppe angehört, die sichtbar geschaltet ist.           }
  begin
  Result := (ObjMask = 0) or (FVisMask and ObjMask > 0)
  end;

end.
