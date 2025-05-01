unit model.dao.uDao;

interface

uses
  model.dao.uIDao,
  model.conexao.uIQuery,
  model.conexao.uIConnection,
  Data.DB,
  System.Generics.Collections;

type
  TDao = class(TInterfacedObject, IDao)
  private
    FParent: IInterface;
    FConnection: IConnection;
    FQuery: IQuery;
    FDataSet: TDataSet;
    FLista: TDictionary<String, Variant>;
    FDataSource: TDataSource;

    constructor Create(Parent: IInterface);
    destructor Destroy; override;

  public
    class function New(Parent: IInterface): IDao;

    function Listar: IDao;
    function ListarPorId: IDao;
    function ListarPor(AParam: String): IDao;
    function Excluir: IDao;
    function Atualizar: IDao;
    function Inserir: IDao;
    function DataSource(AValue: TDataSource): IDao;
  end;

implementation

uses
  model.conexao.uQuery,
  model.conexao.uConnectionFiredac,
  utils.uUtils;

function TDao.Atualizar: IDao;
begin
  Result := Self;
  var lQuery := TUtils.New(FParent).Query.Update;
  FQuery.Query(lQuery, FLista);
end;

constructor TDao.Create(Parent: IInterface);
begin
  FParent := Parent;
  FConnection := TConnectionFiredac.New;
  FQuery := TQuery.New(FConnection);
  FDataSet := TDataset.Create(nil);
  FLista := TDictionary<String, Variant>.Create;

  TUtils.New(FParent).Query.FieldParameter(FLista);
end;

function TDao.DataSource(AValue: TDataSource): IDao;
begin
  Result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := FDataSet;
end;

destructor TDao.Destroy;
begin
  inherited;
end;

function TDao.Excluir: IDao;
begin
  Result := Self;
  var lQuery := TUtils.New(FParent).Query.Delete;
  FQuery.Query(lQuery, FLista);
end;

function TDao.Inserir: IDao;
begin
  Result := Self;
  var lQuery := TUtils.New(FParent).Query.Insert;
  FQuery.Query(lQuery, FLista);
end;

function TDao.Listar: IDao;
begin
  Result := Self;
  var lQuery := TUtils.New(FParent).Query.SelectWithWhere(False);
  FDataSet := FQuery.OneAll(lQuery, []);
end;

function TDao.ListarPor(AParam: String): IDao;
begin
  Result := Self;
  var lQuery := TUtils.New(FParent).Query.SelectWithFixedWhere(AParam);
  FDataSet := FQuery.OneAll(lQuery, FLista);
end;

function TDao.ListarPorId: IDao;
begin
  Result := Self;
  var lQuery := TUtils.New(FParent).Query.SelectWithWhere(True);
  FDataSet := FQuery.OneAll(lQuery, FLista);
end;

class function TDao.New(Parent: IInterface): IDao;
begin
  Result := Self.Create(Parent);
end;

end.
