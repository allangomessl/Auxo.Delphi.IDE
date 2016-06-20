unit Auxo.IDE.ComponentList;

interface

uses
  System.Classes, DesignIntf, System.Generics.Collections;

type
  TDesignComponents<T: class> = class
  strict private
    class var FDesigner: IDesigner;
    class var FList: TList<T>;
    class procedure GetItem(const ComponentName: string);
  public
    class function List(const Designer: IDesigner): TArray<T>;
  end;

implementation

uses
  System.TypInfo, System.SysUtils;

{ TDesignComponentList }

class procedure TDesignComponents<T>.GetItem(const ComponentName: string);
begin
  FList.Add(T(FDesigner.GetComponent(ComponentName)));
end;

class function TDesignComponents<T>.List(const Designer: IDesigner): TArray<T>;
begin
  FList := TList<T>.Create;
  try
    FDesigner := Designer;
    Designer.GetComponentNames(GetTypeData(TypeInfo(T)), GetItem);
    Result := FList.ToArray;
  finally
    FreeAndNil(FList);
  end;
end;

end.
