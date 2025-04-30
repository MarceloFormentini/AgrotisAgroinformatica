unit model.pedidoItens.uItensPedido;

interface

uses
  model.pedidoItens.uIItensPedido,
  utils.uAtributos;

type
  [Tabela('ITENS_PEDIDO')]
  TPedidoItens = class(TInterfacedObject, IItensPedido)
  private
    [Campo('CODIGO'), PK]
    FCodigo: Integer;

    [Campo('CODIGO_PEDIDO'), FK]
    FCodigoPedido: Integer;

    [Campo('CODIGO_PRODUTO'), FK]
    FCodigoProduto: Integer;

    [Campo('QUANTIDADE')]
    FQuantidade: Currency;

    [Campo('VALOR_UNITARIO')]
    FValorUnitario: Currency;

    [Campo('VALOR_TOTAL')]
    FValorTotal: Currency;

  public

    class function New: IItensPedido;

    function GetCodigo: Integer;
    function GetCodigoPedido: Integer;
    function GetCodigoProduto: Integer;
    function GetQuantidade: Currency;
    function GetValorUnitario: Currency;
    function GetValorTotal: Currency;

    function SetCodigo(const AValue: Integer): IItensPedido;
    function SetCodigoPedido(const AValue: Integer): IItensPedido;
    function SetCodigoProduto(const AValue: Integer): IItensPedido;
    function SetQuantidade(const AValue: Currency): IItensPedido;
    function SetValorUnitario(const AValue: Currency): IItensPedido;
    function SetValorTotal(const AValue: Currency): IItensPedido;

  end;

implementation

class function TPedidoItens.New: IItensPedido;
begin
  Result := Self.Create;
end;

function TPedidoItens.GetCodigo: Integer;
begin
  Result := FCodigo;
end;

function TPedidoItens.GetCodigoProduto: Integer;
begin
  Result := FCodigoProduto;
end;

function TPedidoItens.GetCodigoPedido: Integer;
begin
  Result := FCodigoPedido;
end;

function TPedidoItens.GetQuantidade: Currency;
begin
  Result := FQuantidade;
end;

function TPedidoItens.GetValorTotal: Currency;
begin
  Result := FValorTotal;
end;

function TPedidoItens.GetValorUnitario: Currency;
begin
  Result := FValorUnitario;
end;

function TPedidoItens.SetCodigo(const AValue: Integer): IItensPedido;
begin
  Result := Self;
  FCodigo := AValue;
end;

function TPedidoItens.SetCodigoProduto(const AValue: Integer): IItensPedido;
begin
  Result := Self;
  FCodigoProduto := AValue;
end;

function TPedidoItens.SetCodigoPedido(const AValue: Integer): IItensPedido;
begin
  Result := Self;
  FCodigoPedido := AValue;
end;

function TPedidoItens.SetQuantidade(const AValue: Currency): IItensPedido;
begin
  Result := Self;
  FQuantidade := AValue;
end;

function TPedidoItens.SetValorTotal(const AValue: Currency): IItensPedido;
begin
  Result := Self;
  FValorTotal := AValue;
end;

function TPedidoItens.SetValorUnitario(const AValue: Currency): IItensPedido;
begin
  Result := Self;
  FValorUnitario := AValue;
end;

end.
