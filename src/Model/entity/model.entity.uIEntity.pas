unit model.entity.uIEntity;

interface

uses
  model.cliente.uICliente,
  model.produto.uIProduto,
  model.pedido.uIPedido,
  model.pedidoItens.uIItensPedido;

type
  IEntity = interface
  ['{3869B1BB-FA46-4DAF-99DF-F8ED4F9F1F2A}']
    function Cliente: ICliente;
    function Produto: IProduto;
    function Pedido: IPedido;
    function PedidoItens: IItensPedido;
  end;

implementation

end.
