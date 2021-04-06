unit FloatEdit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Dialogs, Windows;

type
  TFloatEdit = class(TEdit)
  private
    FValue : Double;
    function  GetValue : Double;
    procedure SetValue (NewValue : Double);
    procedure MyVal (var v : Double; var c : Integer);
    function  E_before (spot : Integer) : Boolean;
  protected
    procedure KeyPress(var Key : Char); override;
    procedure Change; override;
  public
    constructor Create (AOwner : TComponent); override;
  published
    property Value: Double read GetValue write SetValue stored False;
  end;


procedure Register;

implementation

{================ TFloatEdit =====================}

constructor TFloatEdit.Create (AOwner : TComponent);
  var code : Integer;
  begin
  Inherited Create(AOwner);
  MyVal(FValue, code);
  If code <> 0 then begin
    FValue := 0.0;
    Text   := '0';
    end;
  end;

procedure TFloatEdit.MyVal(var v : Double; var c : Integer);
  var buf : String;
      n   : Integer;
  begin
  buf := text;
  n := Pos (',', buf);
  While n > 0 do begin
    buf[n] := '.';
    n := Pos (',', buf);
    end;
  Val(buf, v, c);
  end;

function TFloatEdit.E_before (spot : Integer) : Boolean;
  var e : Integer;
  begin
  e := Pos('e', Text);
  If e = 0 then e := Pos('E', Text);
  If e = 0 then
    Result := False
  else
    Result := e < spot;
  end;

function TFloatEdit.GetValue: Double;
  var code : Integer;
  begin
  MyVal(Result, code);       { kann schief gehen }
  If code = 0 then
    FValue := Result
  else begin
    Result := FValue;
    If Not(csDesigning in ComponentState) then begin
      MessageDlg('"' + Text + '" stellt keine gültige Fließkommazahl dar.',
                 mtError, [mbOk], 0);
      SetFocus;
      end;
    end;
  end;

procedure TFloatEdit.SetValue (NewValue: Double);
  begin
  Text := FloatToStr(NewValue);
  end;

procedure TFloatEdit.KeyPress(var Key: Char);
  var buf : String;
      oss : Integer;
  begin
  Case Key of
    #8,
    '0'..'9' : ;
    '.', ',' : If (SelStart = 0) or
                  Not(CharInSet(Text[SelStart], ['0'..'9'])) or
                  (Pos('.', Text) > 0) or
                  (Pos(',', Text) > 0) or
                  E_before(SelStart) then
                 Key := #0;
    'e', 'E' : If (SelStart = 0) or
                  (Pos('e', Text) > 0) or
                  (Pos('E', Text) > 0) then
                 Key := #0;
    '+', '-' : If (SelStart > 0) and
                   Not(CharInSet(Text[SelStart], ['e', 'E'])) then
                 Key := #0
               else
                 If CharInSet(Text[SelStart + 1], ['+', '-']) then begin
                   oss := SelStart;
                   buf := Text;
                   Delete(buf, SelStart + 1, 1);
                   Text := buf;
                   SelStart := oss;
                   end;
  else
    Key := #0;
  end; { of case }
  If Key = #0 then
    MessageBeep(0);
  Inherited KeyPress(Key);
  end;

procedure TFloatEdit.Change;
  { merkt sich die letzte gültige Integerzahl aus "Text"
    in "FValue"                                          }
  var nv   : Double;
      code : Integer;
  begin
  Inherited Change;
  MyVal(nv, code);
  If code = 0 then
    FValue := nv;
  end;



procedure Register;
begin
  RegisterComponents('DynaGeoCustomComponents', [TFloatEdit]);
end;

end.
