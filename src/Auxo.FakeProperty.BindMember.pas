unit Auxo.FakeProperty.BindMember;

interface

uses
  Auxo.FakeProperty.Binding, DesignIntf, System.Classes;

type
  TBindMemberProperty = class(TBindingSubProperty, IProperty)
  protected
    procedure SetValue(const Value: string); override;
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

implementation

uses
  Auxo.Binding.Component, Vcl.Dialogs;

{ TBindMemberProperty }

function TBindMemberProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paNotNestable, paValueEditable];
end;

function TBindMemberProperty.GetName: string;
begin
  Result := 'Member';
end;

function TBindMemberProperty.GetValue: string;
var
  link: Integer;
  Binding: TAuxoBinding;
begin
  inherited;
  Result := '';
  Binding := Group.GetBinding(link);
  if Assigned(Binding) and Assigned(Binding[link]) then
    Result := Binding[link].Member;
end;

procedure TBindMemberProperty.GetValues(Proc: TGetStrProc);
var
  link: Integer;
  Binding: TAuxoBinding;
  I: Integer;
begin
  inherited;
  Binding := Group.GetBinding(link);
  ShowMessage(Binding.ClassName);
  ShowMessage(Binding.Source.ClassType.ClassName);
  ShowMessage(Binding.Source.Members.ClassName);
  for I := 0 to Binding.Source.Members.Count-1 do
    Proc(Binding.Source.Members[I].Name);
end;

procedure TBindMemberProperty.SetValue(const Value: string);
var
  link: Integer;
  Binding: TAuxoBinding;
begin
  inherited;
  Binding := Group.GetBinding(link);
  if Assigned(Binding) and Assigned(Binding[link]) then
    Binding[link].Member := Value;
end;

end.
