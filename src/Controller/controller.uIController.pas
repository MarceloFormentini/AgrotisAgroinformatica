unit controller.uIController;

interface

uses
  model.entity.uIEntity,
  model.dao.uIDao;

type
  IController = interface
    function Entity: IEntity;
    function Dao(AValue: IInterface): IDao;
  end;

implementation

end.
