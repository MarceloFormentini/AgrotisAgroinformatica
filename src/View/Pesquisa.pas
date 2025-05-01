unit Pesquisa;

interface

uses
  controller.uIController,
  model.cliente.uICliente,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, System.Generics.Collections, Datasnap.DBClient,
  utils.uEnum;

type
  TFPesquisa = class(TForm)
    PanelTop: TPanel;
    PanelGrid: TPanel;
    PanelBottom: TPanel;
    btnPesquisar: TButton;
    EditPesquisa: TEdit;
    lblPesquisaPor: TLabel;
    btnSelecionar: TButton;
    btnFechar: TButton;
    GridPesquisa: TDBGrid;
    lblPesquisa: TLabel;
    DataSourcePesquisa: TDataSource;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridPesquisaDblClick(Sender: TObject);

  private
    FController: IController;
    FDataSet: TClientDataSet;

    procedure PesquisaCliente;
    procedure PesquisaProduto;
    procedure PesquisaPedido;
    procedure PesquisaClientePor;
    procedure PesquisaProdutoPor;
    procedure PesquisaPedidoPor;
    procedure ConfigurarGridCliente;
    procedure ConfigurarGridProduto;
    procedure ConfigurarGridPedido;
    procedure CopiarDados(ADataSet: TDataSet);
  public
    TipoPesquisa: tTipoPesquisa;
    function GetDataSet: TDataSet;
  end;

var
  FPesquisa: TFPesquisa;

implementation

{$R *.dfm}

uses
  controller.uController;

procedure TFPesquisa.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFPesquisa.FormCreate(Sender: TObject);
begin
  FController := TController.New;
  FDataSet := TClientDataSet.Create(nil);
end;

procedure TFPesquisa.FormDestroy(Sender: TObject);
begin
  FDataSet.Free;
end;

procedure TFPesquisa.FormShow(Sender: TObject);
begin
  case TipoPesquisa of
    tpCliente:
      begin
        lblPesquisa.Caption := 'Pesquisa de Cliente';
        lblPesquisaPor.Caption := 'Pesquisar por Nome';
        PesquisaCliente;
      end;
    tpPedido:
      begin
        lblPesquisa.Caption := 'Pesquisa de Pedido';
        lblPesquisaPor.Caption := 'Pesquisar por Numero Pedido';
        PesquisaPedido;
      end;
    tpProduto:
      begin
        lblPesquisa.Caption := 'Pesquisa de Produto';
        lblPesquisaPor.Caption := 'Pesquisar por Descrição';
        PesquisaProduto;
      end;
  end;
  GridPesquisa.SetFocus;
end;

function TFPesquisa.GetDataSet: TDataSet;
begin
  Result := FDataSet;
end;

procedure TFPesquisa.GridPesquisaDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFPesquisa.PesquisaCliente;
begin
  var lCliente := FController.Dao(
    FController.Entity.Cliente
  ).Listar.DataSource(DataSourcePesquisa);

  CopiarDados(DataSourcePesquisa.DataSet);

  ConfigurarGridCliente;
end;

procedure TFPesquisa.PesquisaClientePor;
begin
  var lCliente := FController.Dao(
    FController.Entity.Cliente.SetNome(
      EditPesquisa.Text
    )
  ).ListarPor('NOME').DataSource(DataSourcePesquisa);

  CopiarDados(DataSourcePesquisa.DataSet);
  ConfigurarGridCliente;
end;

procedure TFPesquisa.PesquisaPedido;
begin
  var lPedido := FController.Dao(
    FController.Entity.Pedido
  ).Listar.DataSource(DataSourcePesquisa);

  CopiarDados(DataSourcePesquisa.DataSet);

  ConfigurarGridPedido;
end;

procedure TFPesquisa.PesquisaPedidoPor;
var
  pedido: Integer;
begin
  if not TryStrToInt(EditPesquisa.Text, pedido) then
  begin
    ShowMessage('Informe o numero do pedido. Digite um número inteiro');
    EditPesquisa.SetFocus;
    Exit;
  end;

  var lCliente := FController.Dao(
    FController.Entity.Pedido.SetNumeroPedido(
      pedido
    )
  ).ListarPor('NUMERO_PEDIDO').DataSource(DataSourcePesquisa);

  CopiarDados(DataSourcePesquisa.DataSet);
  ConfigurarGridPedido;
end;

procedure TFPesquisa.PesquisaProduto;
begin
  FController.Dao(
    FController.Entity.Produto
  ).Listar.DataSource(DataSourcePesquisa);

  CopiarDados(DataSourcePesquisa.DataSet);

  ConfigurarGridProduto;
end;

procedure TFPesquisa.PesquisaProdutoPor;
begin
  FController.Dao(
    FController.Entity.Produto.SetDescricao(
      EditPesquisa.Text
    )
  ).ListarPor('DESCRICAO').DataSource(DataSourcePesquisa);

  CopiarDados(DataSourcePesquisa.DataSet);
  ConfigurarGridProduto;
end;

procedure TFPesquisa.btnPesquisarClick(Sender: TObject);
begin
  if EditPesquisa.Text = '' then
    Exit;

  case TipoPesquisa of
    tpCliente:
      PesquisaClientePor;
    tpPedido:
      PesquisaPedidoPor;
    tpProduto:
      PesquisaProdutoPor;
  end;
end;

procedure TFPesquisa.btnSelecionarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFPesquisa.ConfigurarGridCliente;
var
  Coluna: TColumn;
begin
  GridPesquisa.Columns.Clear; // Remove colunas existentes

  // Criando a coluna para o Código
  Coluna := GridPesquisa.Columns.Add;
  Coluna.Title.Caption := 'Código';
  Coluna.FieldName := 'CODIGO';
  Coluna.Width := 50;

  // Criando a coluna para o Nome
  Coluna := GridPesquisa.Columns.Add;
  Coluna.Title.Caption := 'Nome';
  Coluna.FieldName := 'NOME';
  // tamanho do grid menos o tamanho das outras colunas + mais bordas
  Coluna.Width := GridPesquisa.Width - 354;

  // Criando a coluna para o UF
  Coluna := GridPesquisa.Columns.Add;
  Coluna.Title.Caption := 'UF';
  Coluna.FieldName := 'UF';
  Coluna.Width := 50;

  // Criando a coluna para o Cidade
  Coluna := GridPesquisa.Columns.Add;
  Coluna.Title.Caption := 'Cidade';
  Coluna.FieldName := 'CIDADE';
  Coluna.Width := 230;

  DataSourcePesquisa.DataSet := FDataSet;
  DataSourcePesquisa.DataSet.Active := True;
  DataSourcePesquisa.DataSet.First;
  GridPesquisa.Refresh;
end;

procedure TFPesquisa.ConfigurarGridPedido;
var
  Coluna: TColumn;
begin
  GridPesquisa.Columns.Clear; // Remove colunas existentes

  // Criando a coluna para o Numero do Pedido
  Coluna := GridPesquisa.Columns.Add;
  Coluna.Title.Caption := 'Numero';
  Coluna.FieldName := 'NUMERO_PEDIDO';
  Coluna.Width := 70;

  // Criando a coluna para o Data Emissão
  Coluna := GridPesquisa.Columns.Add;
  Coluna.Title.Caption := 'Data Emissão';
  Coluna.FieldName := 'DATA_EMISSAO';
  Coluna.Width := 70;

  // Criando a coluna para o Referencia
  Coluna := GridPesquisa.Columns.Add;
  Coluna.Title.Caption := 'Referência';
  Coluna.FieldName := 'REFERENCIA';
  Coluna.Width := GridPesquisa.Width - 148;

  DataSourcePesquisa.DataSet := FDataSet;
  DataSourcePesquisa.DataSet.Active := True;
  DataSourcePesquisa.DataSet.First;
  GridPesquisa.Refresh;
end;

procedure TFPesquisa.ConfigurarGridProduto;
var
  Coluna: TColumn;
begin
  GridPesquisa.Columns.Clear; // Remove colunas existentes

  // Criando a coluna para o Código
  Coluna := GridPesquisa.Columns.Add;
  Coluna.Title.Caption := 'Código';
  Coluna.FieldName := 'CODIGO';
  Coluna.Width := 100;

  // Criando a coluna para o Nome
  Coluna := GridPesquisa.Columns.Add;
  Coluna.Title.Caption := 'Decrição';
  Coluna.FieldName := 'DESCRICAO';
  Coluna.Width := GridPesquisa.Width - 105;

  DataSourcePesquisa.DataSet := FDataSet;
  DataSourcePesquisa.DataSet.Active := True;
  DataSourcePesquisa.DataSet.First;
  GridPesquisa.Refresh;
end;

procedure TFPesquisa.CopiarDados(ADataSet: TDataSet);
var
  i: Integer;
  Field: TField;
begin
  if ADataSet.IsEmpty then
    Exit;

  FDataSet.FieldDefs.Clear;

  for i := 0 to ADataSet.FieldCount - 1 do
      FDataSet.FieldDefs.Add(
        ADataSet.Fields[i].FieldName,
        ADataSet.Fields[i].DataType,
        ADataSet.Fields[i].Size,
        ADataSet.Fields[i].Required
      );

  FDataSet.Close;
  FDataSet.CreateDataSet;
  FDataSet.Open;

  ADataSet.First;
  while not ADataSet.Eof do
  begin
    FDataSet.Append;
    for i := 0 to ADataSet.FieldCount - 1 do
    begin
      Field := ADataSet.Fields[i];
      FDataSet.FieldByName(Field.FieldName).Value := Field.Value;
    end;
    FDataSet.Post;

    ADataSet.Next;
  end;
end;

end.
