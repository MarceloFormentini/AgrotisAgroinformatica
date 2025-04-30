unit model.dao.uIDao;

interface

uses
  Data.DB;

type
  IDao = interface
    function Listar: IDao;
    function ListarPorId: IDao;
    function ListarPor: IDao;
    function Excluir: IDao;
    function Atualizar: IDao;
    function Inserir: IDao;
    function DataSource(AValue: TDataSource): IDao;
  end;

implementation

end.
