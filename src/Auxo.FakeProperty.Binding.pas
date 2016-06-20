unit Auxo.FakeProperty.Binding;

interface

uses
  Auxo.IDE.FakeProperty, DesignEditors, DesignIntf, System.Classes, Auxo.Binding.Component;

type
  TBindingProperty = class;
  TBindingSubProperty = class(TFakeProperty)
  private var
    FGroup: TBindingProperty;
  public
    property Group: TBindingProperty read FGroup write FGroup;
  end;

  TBindingProperty = class(TFakeProperty)
  private
    FRoot: TComponent;
  protected
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetProperties(Proc: TGetPropProc); override;
    procedure SetValue(const Value: string); override;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    function GetBinding(out ALink: Integer): TAuxoBinding;
  end;

implementation

uses
  System.SysUtils, System.Generics.Collections, Auxo.IDE.ComponentList, Vcl.Dialogs, System.TypInfo, Auxo.FakeProperty.BindList, Auxo.FakeProperty.BindMember;

{ TAuxoProperty }

constructor TBindingProperty.Create(const ADesigner: IDesigner; APropCount: Integer);
begin
  inherited Create(ADesigner, APropCount);
  if ADesigner = nil then
    FRoot := nil
  else
    FRoot := ADesigner.Root;
end;

function TBindingProperty.GetAttributes: TPropertyAttributes;
begin
  // Not nestible so that it won't appear inside expanded component references
  Result := [paSubProperties, paVolatileSubProperties, paReadOnly];
end;

function TBindingProperty.GetBinding(out ALink: Integer): TAuxoBinding;
var
  List: TArray<TAuxoBinding>;
  Item: TAuxoBinding;
begin
  List := TDesignComponents<TAuxoBinding>.List(Designer);
  Result := nil;
  ALink := -1;

  for Item in List do
  begin
    ALink := Item.Locate(Component);
    if ALink >= 0 then
      Exit(Item);
  end;
end;

function TBindingProperty.GetName: string;
begin
  Result := 'Auxo Binding';
end;

procedure TBindingProperty.GetProperties(Proc: TGetPropProc);
var
  Prop: TBindingSubProperty;
begin
  Prop := TBindListProperty.Create(Designer, 1);
  Prop.Group := Self;
  Proc(Prop);
  Prop := TBindMemberProperty.Create(Designer, 1);
  Prop.Group := Self;
  Proc(Prop);
end;

function TBindingProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', ['Auxo']);
end;

procedure TBindingProperty.SetValue(const Value: string);
begin
  inherited;
  ShowMessage(Value);
end;

end.
