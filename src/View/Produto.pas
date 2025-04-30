unit Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, controller.uIController, Vcl.Mask,
  model.validacao.uIValidadorCampos;

type
  TFProduto = class(TForm)
    PanelBottom: TPanel;
    btnExcluir: TButton;
    btnSalvar: TButton;
    btnFechar: TButton;
    PanelCliente: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    EditCodigo: TEdit;
    EditDescricao: TEdit;
    btnPesquisa: TButton;
    EditValorUnit: TEdit;
    ImageList: TImageList;
    btnNovo: TButton;
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure EditCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure EditValorUnitKeyPress(Sender: TObject; var Key: Char);
  private
    FController: IController;
    FValidadorCampos: IValidadorCampos;

    procedure LimparCampos;
    procedure CarregarCampos(ADataSet: TDataSet);

  end;

var
  FProduto: TFProduto;

implementation

uses
  Pesquisa, controller.uController, model.validacao.uValidadorCampos;

{$R *.dfm}

procedure TFProduto.btnNovoClick(Sender: TObject);
begin
  LimparCampos;
  EditDescricao.SetFocus;
end;

procedure TFProduto.btnPesquisaClick(Sender: TObject);
var
  FPesquisa : TFPesquisa;
begin
  FPesquisa := TFPesquisa.Create(Self);
  FPesquisa.TipoPesquisa := 'P';
  try
    if FPesquisa.ShowModal = mrOk then
      CarregarCampos(FPesquisa.GetDataSet);
  finally
    FPesquisa.Free;
  end;
end;

procedure TFProduto.btnSalvarClick(Sender: TObject);
begin
  try
    if not FValidadorCampos.ValidarCampos then
      Exit;

    var lProduto := FController.Entity
      .Produto
      .SetDescricao(EditDescricao.Text)
      .SetPrecoVenda(StrToFloat(EditValorUnit.Text));

    if EditCodigo.Text = '' then
    begin
      FController.Dao(lProduto).Inserir;
      ShowMessage('Produto cadastrado com sucesso.');
    end
    else
    begin
      FController.Dao(lProduto).Atualizar;
      ShowMessage('Produto atualizado com sucesso.');
    end;
    Close;
  except
    on E: Exception do
      ShowMessage('Erro ao salvar o produto. ' + E.Message);
  end;
end;

procedure TFProduto.CarregarCampos(ADataSet: TDataSet);
begin
  if ADataSet.IsEmpty then
  begin
    LimparCampos;
    Exit;
  end;

  EditCodigo.Text    := ADataSet.FieldByName('CODIGO').AsString;
  EditDescricao.Text := ADataSet.FieldByName('DESCRICAO').AsString;
  EditValorUnit.Text := Format('%.2f', [ADataSet.FieldByName('PRECO_VENDA').AsFloat])
end;

procedure TFProduto.EditCodigoKeyPress(Sender: TObject; var Key: Char);
var
  lDataSource: TDataSource;
begin
  if key <> #13 then
    Exit;

  if EditCodigo.Text = '' then
    Exit;

  lDataSource := TDataSource.Create(nil);
  try
    FController.Dao(
      FController.Entity.Produto.SetCodigo(
        StrToInt(EditCodigo.Text)
      )
    ).ListarPorId.DataSource(lDataSource);

    CarregarCampos(lDataSource.DataSet);

  finally
    lDataSource.Free;
  end;
end;

procedure TFProduto.EditValorUnitKeyPress(Sender: TObject; var Key: Char);
begin
  // validação para aceitar apenas numero e vírgula
  if not (key in ['0'..'9',',',#8]) then
    key :=#0;
end;

procedure TFProduto.FormCreate(Sender: TObject);
begin
  FController := TController.New;
  FValidadorCampos := TValidadorCampos.New(Self);
end;

procedure TFProduto.LimparCampos;
begin
  EditCodigo.Clear;
  EditDescricao.Clear;
  EditValorUnit.Clear;
end;

procedure TFProduto.btnExcluirClick(Sender: TObject);
var
  lDataSource: TDataSource;
begin
  if EditCodigo.Text = '' then
    Exit;

  lDataSource := TDataSource.Create(nil);
  try
    FController.Dao(
      FController.Entity.PedidoItens.SetCodigoProduto(
        StrToInt(EditCodigo.Text)
      )
    ).ListarPorId.DataSource(lDataSource);

    if not lDataSource.DataSet.IsEmpty then
    begin
      ShowMessage('Produto vínculado a um pedido não pode ser excluido');
      Exit;
    end;

  finally
    lDataSource.Free;
  end;

  try
    var lProduto := FController.Entity.Produto.SetCodigo(StrToInt(EditCodigo.Text));

    FController.Dao(lProduto).Excluir;

    ShowMessage('Produto excluido com sucesso.');
    Close;
  except
    ShowMessage('Erro ao excluir o produto.');
  end;
end;

procedure TFProduto.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
