unit Auxo.Filter.Binding;

interface

uses
  DesignIntf, DesignEditors, System.Classes;

type
  TAuxoBindingFilter = class(TSelectionEditor, ISelectionPropertyFilter)
  protected
    { ISelectionPropertyFilter }
    procedure FilterProperties(const ASelection: IDesignerSelections; const ASelectionProperties: IInterfaceList);
  end;

procedure register;

implementation

uses
  System.Generics.Collections, Auxo.FakeProperty.Binding, Auxo.Access.Component, Auxo.IDE.FakeProperty, Auxo.Binding.Component, Auxo.Editor.BindList;

{ TAuxoPropertyFilter }

procedure TAuxoBindingFilter.FilterProperties(const ASelection: IDesignerSelections; const ASelectionProperties: IInterfaceList);
var
  I: Integer;
  NewProperty: TFakeProperty;
begin
  for I := 0 to ASelection.Count - 1 do
  begin
    if (ASelection.Items[I] is TComponent) then
    begin
      if TAccess.Registered(TComponentClass(ASelection.Items[I].ClassType)) then
      begin
        NewProperty := TBindingProperty.Create(Designer, 1);
        NewProperty.Component := ASelection.Items[I] as TComponent;
        ASelectionProperties.Insert(0, NewProperty as IProperty);
      end;
    end;
  end;
end;

procedure register;
begin
  RegisterSelectionEditor(TComponent, TAuxoBindingFilter);
  RegisterPropertyEditor(TypeInfo(string), TAuxoBindLink, 'Member', TBindMemberEditor);
end;

end.
