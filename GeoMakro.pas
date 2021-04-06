unit GeoMakro;

interface

uses Classes, Windows, Dialogs, XMLIntf,
     SysUtils, GlobVars, Utility, GeoTypes, TBaum;

type
  TMakroCmd = class(TObject)
    private
      FOldNum,
      FCmdType  : Integer; { = -1: implizites Startobjekt: wird (wenn
                                      nötig) automatisch erzeugt;
                             =  0: Startobjekt; muß schon (in Drawing)
                                      vorhanden sein;
                             =  1: Zwischenobjekt; wird (wenn nötig) erzeugt,
                                      bleibt aber unsichtbar;
                             =  2: Zielobjekt; wird (wenn nötig) erzeugt und
                                      sichtbar gemacht;                      }
      FNewObj,
      FProtoTyp : TGeoObj;
      function GetExpType: Integer;
    public
      constructor Create(GO: TGeoObj; iCmdType: Integer; iNewGeoNum: Integer = -1);
      constructor Load(iDrawing: TGeoObjListe; S: TFileStream);
      constructor Load32(iDrawing: TGeoObjListe; R: TReader);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
      function  CreateCmdNode(DOMDoc : IXMLDocument): IXMLNode;
      destructor Destroy; override;
      function ExecuteMC(targetList: TGeoObjListe; MakroNum, MaCmdNum: Integer): Integer;
      function ObjType : TClass;
      property CmdType : Integer read FCmdType write FCmdType;
      property OldNum  : Integer read FOldNum;
      property pNewObj : TGeoObj read FNewObj write FNewObj;
      property ProtoTyp: TGeoObj read FProtoTyp;
      property ExpType : Integer read GetExpType;
    end;

  TMakro = class(TList)
    private
      ObjList       : TGeoObjListe;
      FirstStartObj : TGeoObj;
      WarnLevel     : Integer;
      function GetNewId: Integer;
      function LastTargetValid: Boolean;
    public
      Name,
      HelpText,
      FilePath      : String;
      NotYetSaved   : Boolean;
      MakroStatus   : Integer;   { =  0: Makro gültig                                       }
                                 { = -1: Zielobjekt nicht aus den StartObjekten ableitbar!  }
                                 { = -2: Zielobjekt = Startobjekt!                          }
                                 { = -3: Fehler bei der Makro-Ausführung!                   }
                                 { = -4: Term-Fehler!                                       }
                                 { = -5: Polygon-Fehler: Eckenzahl stimmt nicht!            }
                                 { = -6: Keine Startobjekte vorhanden                       }
                                 { = -7: Keine Zielobjekte vorhanden                        }
                                 { = -8: Ungeeignetes Startobjekt                           }
      constructor Create(iObjList: TGeoObjListe; iName, iHelpText: String);
      constructor Load(iObjList: TGeoObjListe; S: TFileStream; FileName: String);
      constructor Load32(iObjList: TGeoObjListe; R: TReader);
      constructor CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
      destructor Destroy; override;
      procedure ConvertOldObjects;
      function  CreateCmdsNode(DOMDoc : IXMLDocument): IXMLNode;
      procedure AddCmd(NewCmd: TMakroCmd);
      procedure RegisterStartObj (GO: TGeoObj);
      procedure RegisterTargetObj(GO: TGeoObj);
      procedure GetCmdList(SL: TStrings);
      procedure Reset(iObjList: TGeoObjListe);
      function  GetMakroCmd4Input: TMakroCmd;
      function  GetNewObj(iOldNum: Integer): TGeoObj;
      function  ObjAlreadyRegistered(ARO: TGeoObj): Boolean;
      function  NewMakroIsOkay: Boolean;
      function  GetMakroCmdWithProtoTypeId(n: Integer): TMakroCmd;
      procedure RunIt(MakroNum: Integer);
      procedure ShowErrorMsg(MaCmdNum: Integer);
    end;

  TMakroList = class(TList)
    public
      procedure DeleteMakro(nr : Integer);
      procedure Clear; override;
    end;


const
  MakroMode : Integer = 0;    { = 0: es wird im Augenblick kein Makro erzeugt    }
                              { = 1: es wird ein (weiteres) Startobjekt erwartet }
                              { = 2: es wird ein (weiteres) Zielobjekt erwartet  }
                              { = 3: das Makro soll erzeugt werden               }

implementation

uses GeoHelper;

{-------------------------------------------}
{  TMakroCmd's Methods Implementation       }
{-------------------------------------------}

constructor TMakroCmd.Create(GO: TGeoObj; iCmdType: Integer; iNewGeoNum: Integer = -1);
  var typRef : TGeoObjClass;
  begin
  Inherited Create;
  If iNewGeoNum > 0 then
    FOldNum := iNewGeoNum
  else
    FOldNum := GO.GeoNum;
  FNewObj   := Nil;
  FCmdType  := iCmdType;
  typRef    := TGeoObjClass(GO.ClassType);
  If typRef = TGDoublePt then begin
    FProtoTyp := TGDoubleIntersection.CreateBlueprintOf(Nil, iNewGeoNum);
    FProtoTyp.Parent.Add(Pointer(GO.Parent.SafeGetGeoNum(0)));
    FProtoTyp.Parent.Add(Pointer(GO.Parent.SafeGetGeoNum(1)));
    end
  else
    FProtoTyp := typRef.CreateBlueprintOf(GO);
  end;


constructor TMakroCmd.Load(iDrawing: TGeoObjListe; S: TFileStream);
  var i, ObjTypeNum, id : Integer;
      ObjParent         : Array[1..3] of Integer;
      NewObjType        : TGeoObjClass;
      Data              : Double;
      Term              : TTBaum;

  function GetGeoClassByNum(Num : Integer) : TClass;
    begin
    Case Num of
      29 : Result := TGPoint;
      37 : Result := TGShortLine;
      39 : Result := TGLongLine;
      49 : Result := TGCircle;
    else
      Result := TGeoObj;
    end; { of case }
    end;

  begin
  id := ReadOldIntFromStream(S);
  If id = 146 then begin
    FOldNum := ReadOldIntFromStream(S);
    ReadOldIntFromStream(S);   { alte FNewNum lesen }
    FCmdType := ReadOldIntFromStream(S);
    ObjTypeNum := ReadOldIntFromStream(S);
    If FCmdType <= 0 then  { alle StartObjekte }
      NewObjType := TGeoObjClass(GetGeoClassByNum(ObjTypeNum))
    else                  { zu erzeugende Objekte }
      NewObjType := TGeoObjClass(GetGeoTypeByNum(ObjTypeNum));
    FProtoTyp := NewObjType.CreateBlueprintOf(Nil);
    For i := 1 to 3 do begin
      ObjParent[i] := ReadOldIntFromStream(S);
      If ObjParent[i] <> 0 then
        ProtoTyp.Parent.Add(Pointer(ObjParent[i]));
      end;

    If ObjTypeNum IN [37, 38, 42] then begin
      S.Read(Data, SizeOf(Data));
      Case ObjTypeNum of
        37 : TGFixLine(ProtoTyp).MyLength := Data;
        38 : TGDirLine(ProtoTyp).dAngle   := Data;
        42 : TGFixCircle(ProtoTyp).Radius := Data;
      end; { of case }
      end;

    If ObjTypeNum IN [43, 48] then begin
      Term := TTBaum.Load(iDrawing, S);
{      Term.KillDirectMOLinks; }
      Case ObjTypeNum of
        43 : TGXCircle(ProtoTyp).rTerm := Term;
        48 : TGXLine(ProtoTyp).wTerm := Term;
      end; { of case }
      end;
    end
  else
    Raise EStreamError.Create('Makro-Kommando erwartet !');
  end;


constructor TMakroCmd.Load32(iDrawing: TGeoObjListe; R: TReader);
  var typName : String;
      typRef  : TGeoObjClass;
  begin
  FOldNum   := R.ReadInteger;
  FCmdType  := R.ReadInteger;
  typName   := R.ReadString;
  typRef    := TGeoObjClass(FindClass(typName));
  FProtoTyp := typRef.Load32(R, iDrawing);
  FProtoTyp.UpdateOldPrototype;
  end;


constructor TMakroCmd.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var TypName, s : String;
      TypRef     : TGeoObjClass;
      XObj       : IXMLNode;
      IsDepr     : Boolean;
  begin
  s := DE.getAttribute('cmd_type');
  FCmdType  := StrToInt(s);
  XObj      := DE.childNodes.First;
  TypName   := iObjList.Get_ClassName(XObj.nodeName, IsDepr);
  TypRef    := TGeoObjClass(FindClass(typName));
  FProtoTyp := typRef.CreateProtoTypFromDomData(iObjList, XObj);
  FOldNum   := FProtoTyp.GeoNum;
  end;

  
function TMakroCmd.CreateCmdNode(DOMDoc : IXMLDocument): IXMLNode;
  var XProtoTyp : IXMLNode;
  begin
  Result := DomDoc.createNode('cmd');
  Result.setAttribute('cmd_type', IntToStr(CmdType));

  XProtoTyp := Prototyp.CreatePrototypNode(DOMDoc);
  Result.childNodes.add(XProtoTyp);
  end;


function TMakroCmd.ObjType: TClass;
  begin
  Result := ProtoTyp.ClassType;
  end;


destructor TMakroCmd.Destroy;
  begin
  While ProtoTyp.Parent.Count > 0 do
    ProtoTyp.Parent.Delete(Pred(ProtoTyp.Parent.Count));
  ProtoTyp.FreeBluePrint;
  Inherited Destroy;
  end;

function TMakroCmd.GetExpType: Integer;
  begin
  If ObjType.InheritsFrom(TGNumberObj) then
    Result := ccNumberObj
  else if ObjType.InheritsFrom(TGPolygon) then
    Result := ccAnyPoly
  else If ObjType.InheritsFrom(TGCircle) then
    Result := ccCircle
  else If ObjType.InheritsFrom(TGLongLine) then
    Result := ccStraightLine
  else If ObjType.InheritsFrom(TGShortLine) then
    Result := ccShortLine
  else If ObjType.InheritsFrom(TGPoint) then
    Result := ccAnyPoint
  else
    Result := -1;
  end;

function TMakroCmd.ExecuteMC(targetList: TGeoObjListe; MakroNum, MaCmdNum: Integer): Integer;
  var typRef   : TGeoObjClass;
      PO       : TGPolygon;
      VP1, VP2 : TGPoint;
      edge     : TGShortLine;
      err, i   : Integer;

  function GetEdgeWithPts(P1, P2: TGeoObj): TGShortLine;
    var j : Integer;
    begin
    Result := Nil;
    j := 0;
    While (Result = Nil) and (j < targetList.LastValidObjIndex) do
      If (TGeoObj(TargetList[j]) is TGShortLine) and
         (TGeoObj(TargetList[j]).Parent.IndexOf(P1) >= 0) and
         (TGeoObj(TargetList[j]).Parent.IndexOf(P2) >= 0) then
        Result := TargetList[j]
      else
        j := j + 1;
    end;

  begin
  ExecuteMC := 0;
  typRef  := TGeoObjClass(ProtoTyp.ClassType);
  pNewObj := targetList.InsertObject
                   (typRef.CreateFromBlueprint(targetList, MakroNum, MaCmdNum),
                    err);

  { Klassenspezifische Nacharbeiten }
  If typRef = TGFixLine then              { Links setzen !  }
    TGFixLine(pNewObj).AdjustFriendlyLinks;

  If typRef = TGPolygon then
    with TGPolygon(pNewObj) do begin      { Polygon-Seiten einfügen     }
      ShowsAlways := CmdType = 2;         { Obwohl das Polygon ein
        unsichtbares Hilfsobjekt ist, muss es hier eventuell sichtbar
        geschaltet werden, damit die Maus es auch als Polygon aufspüren
        kann. Andernfalls sieht sie ebenfalls nur einzelne Seiten und
        das erzeugte Bild-Polygon kann nicht weiterverwendet werden !   }
      For i := 0 to Pred(Parent.Count) do
        targetList.InsertObject
          (TGShortLine.Create(targetList, Parent[i],
                              Parent[(i+1) Mod Parent.Count],
                              CmdType = 2),
           err);
      end;

  If (typRef = TGRegPoly) or (typRef = TGMappedRegPoly) then
    with TGRegPoly(pNewObj) do begin
      ShowsAlways := CmdType = 2;
      VP1 := Parent[1];
      For i := 2 to Pred(VCount) do begin
        VP2 := TGVertexPt.Create(targetList, pNewObj, i, CmdType = 2);
        VP2 := targetList.InsertObject(VP2, err) as TGPoint;
        targetList.InsertObject(TGShortLine.Create(targetList, VP1, VP2, CmdType = 2),
                                err);
        VP1 := VP2;
        end;
      targetList.InsertObject(TGShortLine.Create(targetList, VP1, Parent[0], CmdType = 2),
                              err);
      end;

  If (typRef = TGArea) and                { Rand-Polygon sichtbar machen }
     (TGeoObj(pNewObj.Parent[0]) is TGPolygon) and
     pNewObj.IsVisible then begin
    PO := TGPolygon(pNewObj.Parent[0]);
    For i := 0 to Pred(PO.Parent.Count) do begin
      edge := GetEdgeWithPts(PO.Parent[i], PO.Parent[(i+1) Mod PO.Parent.Count]);
      If Assigned(edge) then
        edge.ShowsAlways := True;
      end;
    end;
  end;


{-------------------------------------------}
{  TMakro's Methods Implementation          }
{-------------------------------------------}

constructor TMakro.Create(iObjList: TGeoObjListe; iName, iHelpText: String);
  begin
  Inherited Create;
  Name     := iName;
  HelpText := iHelpText;
  FilePath := '';
  NotYetSaved   := True;
  MakroStatus   := 0;
  ObjList       := iObjList;
  FirstStartObj := ObjList[ObjList.LastValidObjIndex];
  end;


constructor TMakro.Load(iObjList: TGeoObjListe; S: TFileStream; FileName : String);
  var n, i : Integer;
  begin
  ObjList     := iObjList;
  Name        := ReadOldStrFromStream(S);
  HelpText    := ReadOldStrFromStream(S);
  FilePath    := FileName;
  NotYetSaved := False;
  ReadOldIntFromStream(S);    { Nur wegen der Kompatibilität ! }
  MakroStatus := ReadOldIntFromStream(S);
  { Jetzt wird die Liste der Makrokommandos eingelesen : }
  n := ReadOldIntFromStream(S);
  ReadOldIntFromStream(S);
  ReadOldIntFromStream(S);
  For i := 0 to Pred(n) do
    Add(TMakroCmd.Load(ObjList, S));
  end;


constructor TMakro.Load32(iObjList: TGeoObjListe; R: TReader);
  begin
  ObjList  := iObjList;
  Name     := R.ReadString;
  HelpText := R.ReadString;
  NotYetSaved := False;
  MakroStatus := R.ReadInteger;
  R.ReadListBegin;
  While not R.EndOfList do
    Add(TMakroCmd.Load32(ObjList, R));
  R.ReadListEnd;
  end;


constructor TMakro.CreateFromDomData(iObjList: TGeoObjListe; DE: IXMLNode);
  var XData, XCmd : IXMLNode;
  begin
  ObjList     := iObjList;
  MakroStatus := 0;
  NotYetSaved := False;
  XData    := DE.childNodes.findNode('name', '');
  Name     := XData.NodeValue;
  XData    := DE.childNodes.findNode('helptext', '');
  try
    HelpText := FormatAllBreaks(XData.NodeValue) // 27.12.2009: Formatierung ergänzt
  except
    HelpText := '';               // 26.02.2011: Fall des leeren Hilfetextes ergänzt
  end;  { of try }
  XData    := DE.childNodes.findNode('cmd_list', '');
  XCmd     := XData.childNodes.findNode('cmd', '');
  While XCmd <> Nil do begin
    Add(TMakroCmd.CreateFromDomData(ObjList, XCmd));
    XCmd := XData.childNodes.findSibling(XCmd, 1);
    end;
  end;


destructor TMakro.Destroy;
  var n : Integer;
  begin
  while Count > 0 do begin
    n := Pred(Count);
    TMakroCmd(Items[n]).Free;
    Delete(n);
    end;
  inherited Destroy;
  end;

procedure TMakro.ConvertOldObjects;
  var old_PT,                 // "old P"roto"T"ype
      new_PT  : TGeoObj;      // "new P"roto"T"ype
      mam_cmd,                // "ma"tching "m"akro "cmd"
      new_cmd : TMakroCmd;
      i       : Integer;
  begin
  WarnLevel := 0;
  i := 0;
  While i < Pred(Count) do begin
    If TMakroCmd(Items[i]).ProtoTyp.ClassType = TGDoublePt then begin
      old_PT  := TMakroCmd(Items[i]).ProtoTyp;
      new_cmd := TMakroCmd.Create(old_PT, TMakroCmd(Items[i]).CmdType, GetNewId);
      new_PT  := TGIntersectPt.CreateBlueprintOf(Nil, old_PT.GeoNum);
      new_PT.Parent.Add(Pointer(new_cmd.FOldNum));
      TMakroCmd(Items[i]).FProtoTyp := new_PT;
      old_PT.FreeBluePrint;
      Insert(i, new_cmd);
      i := i + 1;
      WarnLevel := WarnLevel or 1;
      end;
    If TMakroCmd(Items[i]).ProtoTyp.ClassType = TGSecondPt then begin
      old_PT := TMakroCmd(Items[i]).ProtoTyp;
      new_PT := TGIntersectPt.CreateBlueprintOf(old_PT);
      mam_cmd := GetMakroCmdWithProtoTypeId(Integer(new_PT.Parent[0]));
      If Assigned(mam_cmd) and Assigned(mam_cmd.ProtoTyp) then
        new_PT.Parent[0] := mam_cmd.ProtoTyp.Parent[0];
      TMakroCmd(Items[i]).FProtoTyp := new_PT;
      old_PT.FreeBluePrint;
      WarnLevel := WarnLevel or 2;
      end;
    i := i + 1;
    end;
  If WarnLevel > 0 then
    FilePath := '';
  end;


function TMakro.CreateCmdsNode(DOMDoc : IXMLDocument): IXMLNode;
  var XCmd : IXMLNode;
      i    : Integer;
  begin
  Result := DOMDoc.createNode('cmd_list');
  For i := 0 to Pred(Count) do begin
    XCmd := TMakroCmd(Items[i]).CreateCmdNode(DOMDoc);
    If XCmd <> Nil then
      Result.childNodes.add(XCmd);
    end;
  WarnLevel := 0;
  end;


procedure TMakro.AddCmd(NewCmd: TMakroCmd);
  { fügt dem Makro das übergebene neue Kommando hinzu;
    setzt FirstStartObj auf das erste der bisher registrierten
    ("wirklichen") Startobjekte (also: CmdType = 0);
    implizite Startobjekte werden dabei übergangen. }

  var GO   : TGeoObj;
      eoi  : Integer;           { "existing object index" }

  function search(num : Integer; var n : Integer) : Boolean;
    var i : Integer;
    begin
    n := -1;
    i := 0;
    While (n < 0) and (i < Count) do begin
      with TMakroCmd(Items[i]) do
        If OldNum = num then n := i;
      Inc(i);
      end;
    search := n >= 0;
    end;

  begin
  If search(NewCmd.OldNum, eoi) then begin
    If NewCmd.CmdType > TMakroCmd(Items[eoi]).CmdType then
      TMakroCmd(Items[eoi]).CmdType := NewCmd.CmdType;
    NewCmd.Free;
    end
  else begin
    Add(NewCmd);
    If (ObjList <> Nil) and
       (NewCmd.CmdType <= 0) and      // Explizite und implizite Startobjekte,
       (NewCmd.OldNum > 5) then begin //   aber keine KoordSys-Bestandteile!
      GO := ObjList.GetObj(NewCmd.OldNum);
      If (FirstStartObj = Nil) or
         ((GO <> Nil) and
          (ObjList.IndexOf(GO) < ObjList.IndexOf(FirstStartObj))) then
        FirstStartObj := GO;
      end;
    end;
  end;


function TMakro.GetNewObj(iOldNum: Integer): TGeoObj;
  var i : Integer;
  begin
  Result := Nil;
  i      := 0;
  While (Result = Nil) and (i < Count) do begin
    With TMakroCmd(Items[i]) do
      If OldNum = iOldNum then
        Result := pNewObj;
    Inc(i);
    end;
  end;


procedure TMakro.GetCmdList(SL: TStrings);
  var i, k    : Integer;
      pu, ta  : String;
  begin
  For i := 0 to Pred(Count) do
    with TMakroCmd(Items[i]) do begin
      pu := Format('%3d', [OldNum]);
      ta := 'OldNum=' + pu;
      If pNewObj = Nil then
        ta := ta + ';  NewObjNum= (keine)'
      else begin
        pu := Format('%3d', [pNewObj.GeoNum]);
        ta := ta + ';  NewObjNum= ' + pu;
        end;
      pu := Format('%3d', [CmdType]);
      ta := ta + ';  CmdType= ' + pu;
      ta := ta + ';  ObjektTyp= ' + ProtoTyp.ClassName;
      If CmdType > 0 then begin
        ta := ta + ';  Eltern: ';
        for k := 0 to Pred(ProtoTyp.Parent.Count) do begin
          pu := Format('%2d', [Integer(ProtoTyp.Parent[k])]);
          ta := ta + pu + ' ';
          end;
        end;
      sl.Add(ta);
      end;
  end;


function TMakro.ObjAlreadyRegistered(ARO: TGeoObj): Boolean;
  var i: Integer;
  begin
  Result := False;
  For i := Pred(Count) DownTo 0 do
    With TMakroCmd(Items[i]) do
      If OldNum = ARO.GeoNum then
        Result := True;
  end;


procedure TMakro.RegisterStartObj(GO: TGeoObj);
  begin
  { Das Objekt GO entscheidet selbst, welche seiner Eltern eventuell
    gleich mitregistriert werden sollen; daher der GO-Methodenaufruf ! }
  GO.RegisterAsMacroStartObject;
  end;


procedure TMakro.RegisterTargetObj(GO: TGeoObj);

  function IsStartObj(Num: Integer): Boolean;
    var i   : Integer;
    begin
    Result := False;
    i      := 0;
    While (Not Result) and (i < Count) and
          (TMakroCmd(Items[i]).CmdType <= 0) do begin
      If TMakroCmd(Items[i]).OldNum = Num then
        Result := True;
      Inc(i);
      end;
    end;

  procedure RegisterObj (O2R: TGeoObj; iCmdType : Integer);
    var j  : Integer;

    procedure RegisterSiblingsOf(IP: TGeoObj);
      var MIP : TGDoubleIntersection;
          i   : Integer;
      begin
      If (IP is TGDoubleIntersection) and
         (IP.Parent.Count > 0) then begin
        MIP := TGDoubleIntersection(IP.Parent[0]);
        For i := 0 to Pred(MIP.Children.Count) do
          AddCmd(TMakroCmd.Create(MIP.Children[i], 1));
        end;
      end;

    begin { of RegisterObj }
    If ((O2R is TGAxis) or (O2R is TGOrigin)) and   { Koordinatensystem-Teile }
       (Not ObjAlreadyRegistered(O2R)) then         {   als implizite Start-  }
      Insert(0, TMakroCmd.Create(O2R, -1));         {   objekte verbuchen !   }

    if IsStartObj(O2R.GeoNum) then          { Falls das Objekt schon Startobjekt ist, dann   }
      if iCmdType = 2 then                  { kann es nicht gleichzeitig Zielobjekt sein     }
        MakroStatus := -2                   { ==> also Fehlermeldung rausgeben !             }
      else                           { Normalfall für schon vorhandene Objekte: nix zu tun ! }
    else begin                              { Falls das Objekt noch nicht registriert ist,   }
                                            { wird seine Gültigkeit überprüft:               }
      if ((O2R.ClassType = TGPoint) and (O2R.Parent.Count = 0)) or   { falls es ein          }
         (O2R.ClassType = TGBaseLine) or    {    (ungebundenes) Basisobjekt ist oder in der  }
         (O2R.ClassType = TGBaseCircle) or  {    DrawingListe vor dem 1. Startobjekt steht,  }
         (ObjList.IndexOf(O2R) < ObjList.IndexOf(FirstStartObj)) then
        MakroStatus := -1                   {    dann ist das Makro ungültig !               }
      else begin
        j := 0;                             {    Erst alle direkten Vorfahren registrieren.  }
        While (MakroStatus = 0) and
              (j < O2R.Parent.Count) do begin
          RegisterObj (TGeoObj(O2R.Parent.List[j]), 1);
          Inc(j);
          end;

        If MakroStatus = 0 then begin
          AddCmd(TMakroCmd.Create(O2R, iCmdType)); { Dann: aktuelles Objekt ....       }
          If (O2R.ClassType = TGIntersectPt) then  {       bzw. Objekte registrieren.  }
            RegisterSiblingsOf(O2R);
          end;
        end;
      end;
    end;  { of RegisterObj }

  begin { of RegisterTargetObj }
  RegisterObj (GO, 2);               { !!! Rekursion !!! }
  end;  { of RegisterTargetObj }


procedure TMakro.Reset(iObjList: TGeoObjListe);
  var i : Integer;
  begin
  For i := 0 to Pred(Count) do
    TMakroCmd(Items[i]).pNewObj := Nil;
  MakroStatus := 0;
  ObjList := iObjList;
  end;


function TMakro.LastTargetValid : Boolean;
  var i: Integer;
  begin
  If TMakroCmd(Last).pNewObj = Nil then
    Result := False
  else begin
    i := Pred(Count);
    While TMakroCmd(Items[i]).CmdType <> 2 do
      Dec(i);
    If TMakroCmd(Items[i]).pNewObj.DataValid then
      Result := True
    else
      If (TMakroCmd(Items[i]).ObjType = TGSecondPt) and
         (TMakroCmd(Items[i-1]).ObjType = TGDoublePt) and
         (TMakroCmd(Items[i-1]).CmdType = 1) and
         TMakroCmd(Items[i-1]).pNewObj.DataValid then begin
        TMakroCmd(Items[i-1]).pNewObj.ShowsAlways := True;
        Result := True;
        end
      else if (TMakroCmd(Items[i]).ObjType = TGDoublePt) and
         (TMakroCmd(Items[i+1]).ObjType = TGSecondPt) and
         (TMakroCmd(Items[i+1]).CmdType = 1) and
         TMakroCmd(Items[i+1]).pNewObj.DataValid then begin
        TMakroCmd(Items[i+1]).pNewObj.ShowsAlways := True;
        Result := True;
        end
      else if (TMakroCmd(Items[i]).ObjType = TGShortLine) and
         TGeoObj(TMakroCmd(Items[i]).pNewObj.Parent[0]).DataValid and
         TGeoObj(TMakroCmd(Items[i]).pNewObj.Parent[1]).DataValid then
        Result := True
      else
        Result := False;
    end;
  end;


function TMakro.GetNewId: Integer;
  var n, i : Integer;
  begin
  n := 1;
  For i := 0 to Pred(Count) do
    If TMakroCmd(Items[i]).OldNum >= n then
      n := TMakroCmd(Items[i]).OldNum + 1;
  Result := n;
  end;


function TMakro.GetMakroCmdWithProtoTypeId(n: Integer): TMakroCmd;
  var i : Integer;
  begin
  Result := Nil;
  i := 0;
  While (Result = Nil) and (i < Count) do
    If TMakroCmd(Items[i]).ProtoTyp.GeoNum = n then
      Result := TMakroCmd(Items[i])
    else
      i := i + 1;
  end;

function TMakro.GetMakroCmd4Input: TMakroCmd;
  var ActCmd : TMakroCmd;
      i : Integer;
  begin
  Result := Nil;
  i := 0;
  Repeat
    ActCmd := Items[i];
    If (ActCmd.CmdType = -1) and (ActCmd.OldNum < 5) then
      actCmd.pNewObj := ObjList.GetValidObj(ActCmd.OldNum)
    else If (ActCmd.CmdType = 0) and (ActCmd.pNewObj = Nil) then
      Result := ActCmd;
    i := i + 1;
  until (Result <> Nil) or (i >= Count);
  end;

function TMakro.NewMakroIsOkay: Boolean;
  var i,
      soc,             { Start Object Count }
      toc : Integer;   { Target Object Count }
  begin
  soc := 0;
  toc := 0;
  For i := 0 to Pred(Count) do
    Case TMakroCmd(Items[i]).CmdType of
      0 : Inc(soc);
      2 : Inc(toc);
    end;
  If soc = 0 then
    MakroStatus := -6
  else If toc = 0 then
    MakroStatus := -7;
  Result := MakroStatus = 0;
  end;


procedure TMakro.RunIt(MakroNum: Integer);
  var MaCmdNum,
      LastLVO : Integer; { "Last LastValidObjIndex" }
  begin { of RunIt }
  MaCmdNum := 0;
  While TMakroCmd(Items[MaCmdNum]).CmdType < 0 do begin
    with TMakroCmd(Items[MaCmdNum]) do
      If (ProtoTyp is TGAxis) or (ProtoTyp is TGOrigin) then
        pNewObj := Self.ObjList.GetObj(OldNum);
    Inc(MaCmdNum);
    end;
  While TMakroCmd(Items[MaCmdNum]).CmdType <= 0 do
    Inc(MaCmdNum);                            { Alle StartObjekte überspringen }
  MakroStatus := 0;
  LastLVO := ObjList.LastValidObjIndex;
  try
    While (MaCmdNum < Count) and
          (MakroStatus = 0) do begin          { Kommandos ausführen ! }
      MakroStatus := TMakroCmd(Items[MaCmdNum]).ExecuteMC(ObjList, MakroNum, MaCmdNum);
      Inc(MaCmdNum);
      end;
    If MakroStatus = 0 then
      If Not LastTargetValid then
        MakroStatus := -3;
  except
    If MakroStatus = 0 then
      MakroStatus := -3;                      { Makro-Runtime-Error }
    With ObjList do
      While LastValidObjIndex > LastLVO do    { Alle im Makro erzeugten  }
        FreeObject(Items[LastValidObjIndex]); { Objekte wieder löschen   }
  end;
  end;  { of RunIt }


procedure TMakro.ShowErrorMsg(MaCmdNum: Integer);
  var msg     : String;
      act_cmd : TMakroCmd;
  begin
  If MakroStatus < 0 then begin
    Case MakroStatus of
      -1 : msg := MyMakMsg[26];
      -2 : msg := MyMakMsg[27];
      -3 : msg := MyMakMsg[28];
      -4 : msg := MyMakMsg[36];
      -5 : begin
           act_cmd := TMakroCmd(Items[MaCmdNum]);
           msg := Format(MyMakMsg[37],
                        [act_cmd.pNewObj.Parent.Count,
                         act_cmd.ProtoTyp.Parent.Count]);
           end;
      -6 : msg := MyMakMsg[39];
      -7 : msg := MyMakMsg[40];
      -8 : msg := MyMakMsg[42];
    else
      msg := MyMakMsg[18];   { ??? Ob das wohl sinnvoll ist ??? }
    end; { of case }
    MessageDlg(msg, mtError, [mbOk], 0);
    end;
  end;


{-------------------------------------------}
{  Makro-Liste's Methods Implementation     }
{-------------------------------------------}

procedure TMakroList.DeleteMakro(nr: Integer);
  var temp : TMakro;
  begin
  If (nr >= 0) and (nr < Count) then begin
    temp := Items[nr];
    Delete(nr);
    temp.Free;
    end;
  end;

procedure TMakroList.Clear;
  begin
  While Count > 0 do DeleteMakro(0);
  Inherited Clear;
  end;


{-------------------------------------------}
{  Start- und Schlußprozedur der Unit       }
{-------------------------------------------}

initialization

// MakroList := TMakroList.Create;

finalization

// MakroList.Free;

end.
