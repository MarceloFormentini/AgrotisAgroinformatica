unit model.pedido.uIPedido;

interface

type
  IPedido = interface
  ['{824013C1-04B1-4E12-A271-217C563509CC}']
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

end.
