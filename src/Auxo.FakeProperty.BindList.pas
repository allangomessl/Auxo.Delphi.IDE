unit Auxo.FakeProperty.BindList;

interface

uses
  Auxo.FakeProperty.Binding, DesignIntf, System.Classes;

type
  TBindListProperty = class(TBindingSubProperty, IProperty)
  protected
    procedure SetValue(const Value: string); override;
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

implementation

uses
  Auxo.IDE.ComponentList, Auxo.Binding.Component, System.SysUtils;

{ TBindListProperty }

function TBindListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paNotNestable, paValueEditable, paVCL];
end;

function TBindListProperty.GetName: string;
begin
  Result := 'List';
end;

function TBindListProperty.GetValue: string;
var
  AllBindings: TArray<TAuxoBinding>;
  Bind: TAuxoBinding;
begin
  Result := '';
  AllBindings := TDesignComponents<TAuxoBinding>.List(Designer);
  for Bind in AllBindings do
  begin
    if Bind.Locate(Group.Component) >= 0 then
      Exit(Bind.Name)
  end;
end;

procedure TBindListProperty.GetValues(Proc: TGetStrProc);
var
  Item: TAuxoBinding;
  AllBindings: TArray<TAuxoBinding>;
begin
  AllBindings := TDesignComponents<TAuxoBinding>.List(Designer);
  for Item in AllBindings do
    Proc(Item.Name);
end;

procedure TBindListProperty.SetValue(const Value: string);
var
  CurrentName: string;
  BindingsNew: TAuxoBinding;
begin
  BindingsNew := nil;
  if Value <> '' then
  begin
    BindingsNew := Designer.GetComponent(Value) as TAuxoBinding;
    if not Assigned(BindingsNew) then
      raise Exception.Create('Component not found or invalid.');
  end;

  CurrentName := GetValue;

  if (CurrentName <> '') and (not Assigned(BindingsNew) or (BindingsNew.Name <> CurrentName)) then
    TAuxoBinding(Designer.GetComponent(CurrentName)).RemoveLink(Group.Component);

  if Assigned(BindingsNew) then
    BindingsNew.AddLink(Group.Component);
end;

end.
