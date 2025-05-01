unit model.pedido.uPedido;

interface

uses
  model.pedido.uIPedido,
  utils.uAtributos;

type
  [Tabela('PEDIDO')]
  TPedido = class(TInterfacedObject, IPedido)
  private
    [Campo('CODIGO'), PK]
    FCodigo: Integer;

    [Campo('REFERENCIA')]
    FReferencia: String;

    [Campo('NUMERO_PEDIDO'), PK]
    FNumeroPedido: Integer;

    [Campo('DATA_EMISSAO')]
    FDataEmissao: TDateTime;

    [Campo('CODIGO_CLIENTE'), FK]
    FCodigoCliente: Integer;

    [Campo('TIPO_OPERACAO'), PK]
    FTipoPedido: String;

    [Campo('TOTAL_PEDIDO')]
    FValorTotal: Currency;

  public
    class function New: IPedido;

    function GetCodigo: Integer;
    function GetReferencia: String;
    function GetNumeroPedido: Integer;
    function GetDataEmissao: TDateTime;
    function GetCodigoCliente: Integer;
    function GetTipoPedido: String;
    function GetValorTotal: Currency;

    function SetCodigo(const AValue: Integer): IPedido;
    function SetReferencia(const AValue: String): IPedido;
    function SetNumeroPedido(const AValue: Integer): IPedido;
    function SetDataEmissao(AValue: TDateTime): IPedido;
    function SetCodigoCliente(const AValue: Integer): IPedido;
    function SetTipoPedido(const AValue: String): IPedido;
    function SetValorTotal(const AValue: Currency): IPedido;
  end;

implementation

class function TPedido.New: IPedido;
begin
  Result := Self.Create;
end;

function TPedido.GetCodigo: Integer;
begin
  Result := FCodigo;
end;

function TPedido.GetCodigoCliente: Integer;
begin
  Result := FCodigoCliente;
end;

function TPedido.GetDataEmissao: TDateTime;
begin
  Result := FDataEmissao;
end;

function TPedido.GetNumeroPedido: Integer;
begin
  Result := FNumeroPedido;
end;

function TPedido.GetReferencia: String;
begin
  Result := FReferencia;
end;

function TPedido.GetTipoPedido: String;
begin
  Result := FTipoPedido;
end;

function TPedido.GetValorTotal: Currency;
begin
  Result := FValorTotal;
end;

function TPedido.SetCodigo(const AValue: Integer): IPedido;
begin
  Result := Self;
  FCodigo := AValue;
end;

function TPedido.SetCodigoCliente(const AValue: Integer): IPedido;
begin
  Result := Self;
  FCodigoCliente := AValue;
end;

function TPedido.SetDataEmissao(AValue: TDateTime): IPedido;
begin
  Result := Self;
  FDataEmissao := AValue;
end;

function TPedido.SetNumeroPedido(const AValue: Integer): IPedido;
begin
  Result := Self;
  FNumeroPedido := AValue;
end;

function TPedido.SetReferencia(const AValue: String): IPedido;
begin
  Result := Self;
  FReferencia := AValue;
end;

function TPedido.SetTipoPedido(const AValue: String): IPedido;
begin
  Result := Self;
  FTipoPedido := AValue;
end;

function TPedido.SetValorTotal(const AValue: Currency): IPedido;
begin
  Result := Self;
  FValorTotal := AValue;
end;

end.
