unit Auxo.Editor.BindList;

interface

uses
  DesignEditors, DesignIntf, System.Classes;
type
  TBindMemberEditor = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

implementation

uses
  Auxo.Binding.Component;

{ TBindMemberEditor }

function TBindMemberEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList];
end;

procedure TBindMemberEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Binding: TAuxoBinding;
  Link: TAuxoBindLink;
begin
  inherited;
  Link := GetComponent(0) as TAuxoBindLink;
  if Assigned(Link) then
  begin
    if Assigned(Link.Collection) then
    begin
      Binding := Link.Collection.Owner as TAuxoBinding;
      if Assigned(Binding) and Assigned(Binding.Source) then
      begin
        for I := 0 to Binding.Source.Members.Count-1 do
          Proc(Binding.Source.Members[I].Name);
      end;
    end;
  end;
end;

end.
