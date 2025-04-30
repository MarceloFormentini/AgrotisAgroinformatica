unit model.produto.uProduto;

interface

uses
  model.produto.uIProduto,
  utils.uAtributos;

type
  [Tabela('PRODUTO')]
  TProduto = class(TInterfacedObject, IProduto)
  private
    [Campo('CODIGO'), PK]
    FCodigo: Integer;

    [Campo('DESCRICAO')]
    FDescricao: String;

    [Campo('PRECO_VENDA')]
    FPrecoVenda: Currency;

  public
    class function New: IProduto;

    function GetCodigo: Integer;
    function GetDescricao: String;
    function GetPrecoVenda: Currency;
    function SetCodigo(const AValue: Integer): IProduto;
    function SetDescricao(const AValue: String): IProduto;
    function SetPrecoVenda(const AValue: Currency): IProduto;
  end;

implementation

class function TProduto.New: IProduto;
begin
  Result := Self.Create;
end;

function TProduto.GetCodigo: Integer;
begin
  Result := FCodigo;
end;

function TProduto.GetDescricao: String;
begin
  Result := FDescricao;
end;

function TProduto.GetPrecoVenda: Currency;
begin
  Result := FPrecoVenda;
end;

function TProduto.SetCodigo(const AValue: Integer): IProduto;
begin
  Result := Self;
  FCodigo := AValue;
end;

function TProduto.SetDescricao(const AValue: String): IProduto;
begin
  Result := Self;
  FDescricao := AValue;
end;

function TProduto.SetPrecoVenda(const AValue: Currency): IProduto;
begin
  Result := Self;
  FPrecoVenda := AValue;
end;

end.