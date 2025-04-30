unit model.entity.uEntity;

interface

uses
  model.entity.uIEntity,
  model.cliente.uICliente,
  model.produto.uIProduto,
  model.pedido.uIPedido,
  model.pedidoItens.uIItensPedido;

type
  TEntity = class(TInterfacedObject, IEntity)
  private
    FCliente: ICliente;
    FProduto: IProduto;
    FPedido: IPedido;
    FItensPedido: IItensPedido;

  public
    class function New: TEntity;

    function Cliente: ICliente;
    function Produto: IProduto;
    function Pedido: IPedido;
    function PedidoItens: IItensPedido;

  end;

implementation

uses
  model.cliente.uCliente, model.pedido.uPedido,
  model.pedidoItens.uItensPedido, model.produto.uProduto;

class function TEntity.New: TEntity;
begin
  Result := Self.Create;
end;

function TEntity.Cliente: ICliente;
begin
  if not Assigned(FCliente) then
    FCliente := TCliente.New;

  Result := FCliente;
end;

function TEntity.Pedido: IPedido;
begin
  if not Assigned(FPedido) then
    FPedido := TPedido.New;

  Result := FPedido;
end;

function TEntity.PedidoItens: IItensPedido;
begin
  if not Assigned(FItensPedido) then
    FItensPedido := TPedidoItens.New;

  Result := FItensPedido;
end;

function TEntity.Produto: IProduto;
begin
  if not Assigned(FProduto) then
    FProduto := TProduto.New;

  Result := FProduto;
end;

end.
