unit Auxo.IDE.FakeProperty;

// Unit not used?
interface

uses
  DesignIntf, DesignEditors, System.Classes, System.TypInfo, System.Generics.Collections;

type
  TFakeProperty = class(TBasePropertyEditor, IProperty, IPropertyKind)
  private
    FDesigner: IDesigner;
    FComponent: TComponent;
  protected
    { IProperty }
    procedure Initialize; override;
    procedure SetPropEntry(Index: Integer; AInstance: TPersistent; APropInfo: PPropInfo); override;
    procedure Activate;
    function AllEqual: Boolean;
    function AutoFill: Boolean;
    procedure Edit; virtual;
    function HasInstance(Instance: TPersistent): Boolean;
    function GetAttributes: TPropertyAttributes; virtual;
    function GetEditLimit: Integer;
    function GetEditValue(out Value: string): Boolean;
    function GetName: string; virtual;
    function GetValue: string; virtual;
    procedure SetValue(const Value: string); virtual;
    procedure GetProperties(Proc: TGetPropProc); virtual;
    function GetPropInfo: PPropInfo; virtual;
    function GetPropType: PTypeInfo; virtual;
    procedure GetValues(Proc: TGetStrProc); virtual;
    procedure Revert;
    function ValueAvailable: Boolean; virtual;
    { IPropertyKind }
    function GetKind: TTypeKind; virtual;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    property Component: TComponent read FComponent write FComponent;
    property Designer: IDesigner read FDesigner;
  end;

  TPropertyList = TList<IProperty>;

implementation

{ TFakeProperty }

constructor TFakeProperty.Create(const ADesigner: IDesigner; APropCount: Integer);
begin
  inherited;
  FDesigner := ADesigner;
end;

procedure TFakeProperty.Activate;
begin
end;

function TFakeProperty.AllEqual: Boolean;
begin
  Result := True;
end;

function TFakeProperty.AutoFill: Boolean;
begin
  Result := True;
end;

procedure TFakeProperty.Edit;
begin
  inherited;
end;

function TFakeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paNotNestable, paReadOnly];
end;

function TFakeProperty.GetEditLimit: Integer;
begin
  Result := -1;
end;

function TFakeProperty.GetEditValue(out Value: string): Boolean;
begin
  Result := True;
  Value := GetValue;
end;

function TFakeProperty.GetKind: TTypeKind;
begin
  Result := tkInteger;
end;

function TFakeProperty.GetName: string;
begin
  Result := '';
end;

procedure TFakeProperty.GetProperties(Proc: TGetPropProc);
begin
end;

function TFakeProperty.GetPropInfo: PPropInfo;
begin
  Result := nil;
end;

function TFakeProperty.GetPropType: PTypeInfo;
begin
  Result := nil;
end;

function TFakeProperty.GetValue: string;
begin
  Result := ''
end;

procedure TFakeProperty.GetValues(Proc: TGetStrProc);
begin
end;

function TFakeProperty.HasInstance(Instance: TPersistent): Boolean;
begin
  Result := False;
end;

procedure TFakeProperty.Initialize;
begin
  inherited;
end;

procedure TFakeProperty.Revert;
begin

end;

procedure TFakeProperty.SetPropEntry(Index: Integer; AInstance: TPersistent; APropInfo: PPropInfo);
begin
  inherited;
end;

procedure TFakeProperty.SetValue(const Value: string);
begin
end;

function TFakeProperty.ValueAvailable: Boolean;
begin
  Result := True;
end;

end.
