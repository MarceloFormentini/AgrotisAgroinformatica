unit controller.uController;

interface

uses
  controller.uIController,
  model.entity.uIEntity,
  model.dao.uIDao;

type
  TController = class(TInterfacedObject, IController)
    private
      FEntity: IEntity;
      FDao: IDao;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IController;

      function Entity: IEntity;
      function Dao(AValue: IInterface): IDao;
  end;

implementation

uses
  model.dao.uDao,
  model.entity.uEntity;

constructor TController.Create;
begin

end;

function TController.Dao(AValue: IInterface): IDao;
begin
  Result := TDao.New(AValue);
end;

destructor TController.Destroy;
begin

  inherited;
end;

function TController.Entity: IEntity;
begin
  if not Assigned(FEntity) then
    FEntity := TEntity.New;

  Result := FEntity;
end;

class function TController.New: IController;
begin
  Result := Self.Create;
end;

end.
