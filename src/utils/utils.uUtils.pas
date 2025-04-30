unit utils.uUtils;

interface

uses
  utils.uIUtils,
  utils.uIQuery;

type
  TUtils = class(TInterfacedObject, IUtils)
  private
    FParent: IInterface;
    FQuery: IQuery;

  public
    constructor Create(Parent: IInterface);
    destructor Destroy; override;
    class function New(Parent: IInterface): IUtils;
    function Query: IQuery;

  end;

implementation

uses
  utils.uQuery;

constructor TUtils.Create(Parent: IInterface);
begin
  FParent := Parent;
end;

destructor TUtils.Destroy;
begin

  inherited;
end;

class function TUtils.New(Parent: IInterface): IUtils;
begin
  Result := Self.Create(Parent);
end;

function TUtils.Query: IQuery;
begin
  if not Assigned(FQuery) then
    FQuery := TQuery.New(FParent);

  Result := FQuery;
end;

end.
