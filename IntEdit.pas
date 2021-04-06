unit IntEdit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Dialogs, Windows;

type
  TIntEdit = class(TEdit)
  private
    FValue : LongInt;
    function  GetValue : LongInt;
    procedure SetValue (NewValue : LongInt);
  protected
    procedure KeyPress(var Key: Char); override;
    procedure Change; override;
  public
    constructor Create (AOwner : TComponent); override;
  published
    property Value: LongInt read GetValue write SetValue stored False;
  end;

procedure Register;

implementation

{================ TIntEdit ===================}

constructor TIntEdit.Create (AOwner : TComponent);
  var code : Integer;
  begin
  Inherited Create(AOwner);
  Val(text, FValue, code);
  If code <> 0 then begin
    FValue := 0;
    Text   := '0';
    end;
  end;

function TIntEdit.GetValue: LongInt;
  var code : Integer;
  begin
  Val(text, Result, code);       { kann schief gehen }
  If code = 0 then
    FValue := Result
  else begin
    Result := FValue;
    If Not(csDesigning in ComponentState) then begin
      MessageDlg('"' + Text + '" stellt keine gültige Integerzahl dar.',
                  mtError, [mbOk], 0);
      SetFocus;
      end;
    end;
  end;

procedure TIntEdit.SetValue (NewValue: LongInt);
  begin
  Text := IntToStr (NewValue);  { geht immer }
  end;

procedure TIntEdit.KeyPress(var Key: Char);
  var buf : String;
  begin
  Case Key of
    #8,
    '0'..'9' : ;
    '+', '-' : If SelStart > 0 then
                 Key := #0
               else
                 if CharInSet(Text[1], ['+', '-']) then begin
                   buf := Text;
                   Delete(buf, 1, 1);
                   Text := buf;
                   SelStart := 0;
                   end;
  else
    Key := #0;
  end;
  If Key = #0 then
    MessageBeep(0);
  Inherited KeyPress(Key);
  end;

procedure TIntEdit.Change;
  { merkt sich die letzte gültige Integerzahl aus "Text"
    in "FValue"                                          }
  var nv   : LongInt;
      code : Integer;
  begin
  Inherited Change;
  Val(Text, nv, code);
  If code = 0 then
    FValue := nv;
  end;


procedure Register;
begin
  RegisterComponents('DynaGeoCustomComponents', [TIntEdit]);
end;

end.
