unit model.conexao.uQuery;

interface

uses
  model.conexao.uIQuery,
  model.conexao.uIConnection,
  FireDAC.Comp.Client,
  Data.DB,
  System.Generics.Collections;

type
  TQuery = class(TInterfacedObject, IQuery)
  private
    FQuery: TFDQuery;

    procedure PreencheQuery(ASQL: String);
    procedure PreencheParams(AParams: Array of Variant);

    constructor Create(AConnection: IConnection);
    destructor Destroy; override;

  public
    class function New(AConnection: IConnection): IQuery;

    procedure Query(const Statement: String; const Params: Array of Variant); overload;
    function OneAll(const Statement: Variant; const Params: Array of Variant): TDataSet; overload;
    procedure Query(const Statement: String; const Params: TDictionary<String, Variant>); overload;
    function OneAll(const Statement: String; const Params: TDictionary<String, Variant>): TDataSet; overload;
  end;

implementation

constructor TQuery.Create(AConnection: IConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := TFDConnection(AConnection.Connection);
end;

destructor TQuery.Destroy;
begin
  FQuery.Free;
  inherited;
end;

class function TQuery.New(AConnection: IConnection): IQuery;
begin
  Result := Self.Create(AConnection);
end;

function TQuery.OneAll(const Statement: String; const Params: TDictionary<String, Variant>): TDataSet;
begin
  FQuery.SQL.Add(Statement);

  for var I in Params.Keys do
    if not (FQuery.Params.FindParam(I) = nil) then
      FQuery.ParamByName(I).Value := Params.Items[I];

  FQuery.Open();
  Result := FQuery;
end;

function TQuery.OneAll(const Statement: Variant; const Params: array of Variant): TDataSet;
begin
  PreencheQuery(Statement);
  PreencheParams(Params);

  FQuery.Open;
  Result := FQuery;
end;

procedure TQuery.PreencheParams(AParams: array of Variant);
begin
//  Adiciona os parametros para a Query
  for var I := Low(AParams) to High(AParams) do
  begin
    FQuery.Params.Add;
    FQuery.Params[I].Value := AParams[I];
  end;
end;

procedure TQuery.PreencheQuery(ASQL: String);
begin
//  adiciona SQL na Query
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(ASQL);
end;

procedure TQuery.Query(const Statement: String; const Params: array of Variant);
begin
  PreencheQuery(Statement);
  PreencheParams(Params);

  FQuery.ExecSQL;
end;

procedure TQuery.Query(const Statement: String; const Params: TDictionary<String, Variant>);
begin
  FQuery.SQL.Add(Statement);

  for var I in Params.Keys do
    if not (FQuery.Params.FindParam(I) = nil) then
      FQuery.ParamByName(I).Value := Params.Items[I];

  FQuery.ExecSQL;
end;

end.
