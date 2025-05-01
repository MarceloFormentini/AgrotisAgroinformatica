unit Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Mask, Vcl.DBCtrls,
  controller.uIController, Data.DB, model.validacao.uIValidadorCampos,
  Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  model.totalizador.uITotalizadorValor, utils.uEnum;

type
  TFPedido = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PanelPedido: TPanel;
    Panel2: TPanel;
    btnFechar: TButton;
    btnAvancar: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    btnVoltar: TButton;
    btnSalvar: TButton;
    Label1: TLabel;
    btnPesquisa: TButton;
    Shape: TShape;
    Label5: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DataEmissao: TDateTimePicker;
    RadioGroup1: TRadioGroup;
    CheckEntrada: TCheckBox;
    CheckSaida: TCheckBox;
    EditNumeroPedido: TEdit;
    ImageList: TImageList;
    EditReferencia: TEdit;
    EditCodigoCliente: TEdit;
    EditNomeCliente: TEdit;
    btnPesquisaCliente: TButton;
    btnNovo: TButton;
    Panel5: TPanel;
    Label7: TLabel;
    EditTotalPedido: TEdit;
    Label8: TLabel;
    btnPesquisaProduto: TButton;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    btnInserirItem: TButton;
    btnRemoverItem: TButton;
    DataSource: TDataSource;
    ClientDataSet: TClientDataSet;
    GridItensPedido: TDBGrid;
    ClientDataSetCODIGO: TIntegerField;
    ClientDataSetDESCRICAO: TStringField;
    ClientDataSetQUANTIDADE: TFloatField;
    ClientDataSetVALOR_UNITARIO: TFloatField;
    ClientDataSetTOTAL_ITEM: TFloatField;
    VALOR_UNITARIO: TDBEdit;
    ClientDataSetCODIGO_PEDIDO: TIntegerField;
    ClientDataSetCODIGO_PRODUTO: TIntegerField;
    TOTAL_ITEM: TDBEdit;
    QUANTIDADE: TDBEdit;
    CODIGO_PRODUTO: TDBEdit;
    DESCRICAO: TDBEdit;
    btnNovoItem: TButton;
    btnCancelarItem: TButton;
    btnExcluir: TButton;
    procedure btnFecharClick(Sender: TObject);
    procedure btnAvancarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckEntradaClick(Sender: TObject);
    procedure CheckSaidaClick(Sender: TObject);
    procedure EditNumeroPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisaClienteClick(Sender: TObject);
    procedure btnNovoItemClick(Sender: TObject);
    procedure btnInserirItemClick(Sender: TObject);
    procedure EditCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarItemClick(Sender: TObject);
    procedure btnPesquisaProdutoClick(Sender: TObject);
    procedure ClientDataSetAfterEdit(DataSet: TDataSet);
    procedure ClientDataSetVALOR_UNITARIOChange(Sender: TField);
    procedure ClientDataSetQUANTIDADEChange(Sender: TField);
    procedure CODIGO_PRODUTOKeyPress(Sender: TObject; var Key: Char);
    procedure btnRemoverItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    FController: IController;
    FValidadorCampos: IValidadorCampos;
    FCodigoPedido: Integer;
    FTotalPedido: Double;
    FTotalizadorValor: ITotalizadorValor;

    procedure LimparCampos;

    procedure CarregarDados(ADataSet: TDataSet);
    procedure CarregarDadosCliente(ADataSet: TDataSet);
    procedure PesquisarCliente(ACliente: Integer);

    procedure CarregarDadosProduto(ADataSet: TDataSet);
    procedure PesquisarProduto(AProduto: Integer);

    procedure AbrirPesquisa(ATipoPesquisa: tTipoPesquisa);
    procedure PesquisaItensPedido;
    procedure CarregaItensPedido(ADataSet: TDataSet);

    function ValidarCamposItens: Boolean;

    procedure CalcularTotalItem;
  end;

var
  FPedido: TFPedido;

implementation

uses
  controller.uController, Pesquisa, model.validacao.uValidadorCampos,
  model.totalizador.uTotalizadorValor;

{$R *.dfm}

procedure TFPedido.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFPedido.btnInserirItemClick(Sender: TObject);
begin
  if not ValidarCamposItens then
    Exit;
  ClientDataSet.Post;
  btnInserirItem.Enabled := False;
  btnCancelarItem.Enabled := False;
  btnNovoItem.Enabled := True;
  btnRemoverItem.Enabled := True;
  EditTotalPedido.Text := FTotalizadorValor.CalcularTotal;
end;

procedure TFPedido.btnNovoClick(Sender: TObject);
begin
  LimparCampos;
  btnExcluir.Enabled := False;
  EditNumeroPedido.SetFocus;
end;

procedure TFPedido.btnNovoItemClick(Sender: TObject);
begin
  ClientDataSet.Append;
  CODIGO_PRODUTO.SetFocus;
  btnNovoItem.Enabled := False;
  btnRemoverItem.Enabled := False;
  btnCancelarItem.Enabled := True;
  btnInserirItem.Enabled := True;
end;

procedure TFPedido.btnPesquisaClick(Sender: TObject);
begin
  AbrirPesquisa(tpPedido);
end;

procedure TFPedido.btnPesquisaClienteClick(Sender: TObject);
begin
  AbrirPesquisa(tpCliente);
end;

procedure TFPedido.btnPesquisaProdutoClick(Sender: TObject);
var
  FPesquisa : TFPesquisa;
begin
  FPesquisa := TFPesquisa.Create(Self);
  FPesquisa.TipoPesquisa := tpPedido;
  try
    if FPesquisa.ShowModal = mrOk then
      CarregarDadosProduto(FPesquisa.GetDataSet);
  finally
    FPesquisa.Free;
  end;
end;

procedure TFPedido.btnRemoverItemClick(Sender: TObject);
begin
  if ClientDataSet.IsEmpty then
    Exit;

  ClientDataSet.Delete;
  EditTotalPedido.Text := FTotalizadorValor.CalcularTotal;
end;

procedure TFPedido.btnSalvarClick(Sender: TObject);
var
  tipoPedido: String;
  lDataSource: TDataSource;
begin
  if ClientDataSet.IsEmpty then
  begin
    ShowMessage('Informe os itens do pedido para poder salvar.');
    Exit;
  end;
  if MessageDlg('Confirma o pedido?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  tipoPedido := 'S';
  if CheckEntrada.Checked then
    tipoPedido := 'E';

  try
    var lPedido := FController.Entity.Pedido
      .SetCodigo(FCodigoPedido)
      .SetReferencia(EditReferencia.Text)
      .SetNumeroPedido(StrToInt(EditNumeroPedido.Text))
      .SetDataEmissao(DataEmissao.DateTime)
      .SetCodigoCliente(StrToInt(EditCodigoCliente.Text))
      .SetTipoPedido(tipoPedido)
      .SetValorTotal(StrToFloat(EditTotalPedido.Text));

    if FCodigoPedido > 0 then
      FController.Dao(lPedido).Atualizar
    else
    begin
      FController.Dao(lPedido).Inserir;

      lDataSource := TDataSource.Create(nil);
      try
        FController.Dao(
          FController.Entity.Pedido.SetNumeroPedido(
            StrToInt(EditNumeroPedido.Text)
          )
        ).ListarPor('NUMERO_PEDIDO').DataSource(lDataSource);

        FCodigoPedido := lDataSource.DataSet.FieldByName('CODIGO').AsInteger;
      finally
        lDataSource.Free;
      end;
    end;

    try
      ClientDataSet.DisableControls;
      ClientDataSet.First;
      while not ClientDataSet.Eof do
      begin
        var lItensPedido := FController.Entity.PedidoItens
          .SetCodigo(ClientDataSetCODIGO.AsInteger)
          .SetCodigoPedido(FCodigoPedido)
          .SetCodigoProduto(ClientDataSetCODIGO_PRODUTO.AsInteger)
          .SetQuantidade(ClientDataSetQUANTIDADE.AsFloat)
          .SetValorUnitario(ClientDataSetVALOR_UNITARIO.AsFloat)
          .SetValorTotal(ClientDataSetTOTAL_ITEM.AsFloat);

        if ClientDataSetCODIGO.AsInteger > 0 then
          FController.Dao(lItensPedido).Atualizar
        else
          FController.Dao(lItensPedido).Inserir;

        ClientDataSet.Next;
      end;

    finally
      ClientDataSet.EnableControls;
    end;

    ShowMessage('Pedido gravado com sucesso.');
    btnVoltar.Click;
    btnNovo.Click;
  except
    on E:Exception do
      ShowMessage('Erro ao salvar pedido. ' + E.Message);
  end;

end;

procedure TFPedido.btnVoltarClick(Sender: TObject);
begin
  PageControl.SelectNextPage(False, False);
end;

procedure TFPedido.PesquisaItensPedido;
var
  lDataSource: TDataSource;
begin
  if FCodigoPedido <= 0 then
    Exit;

  lDataSource := TDataSource.Create(nil);
  try
    FController.Dao(
      FController.Entity.PedidoItens.SetCodigoPedido(
        FCodigoPedido
      )
    ).ListarPor('CODIGO_PEDIDO').DataSource(lDataSource);

    CarregaItensPedido(lDataSource.DataSet);

  finally
    lDataSource.Free;
  end;
end;

procedure TFPedido.PesquisarCliente(ACliente: Integer);
var
  lDataSource: TDataSource;
begin

  lDataSource := TDataSource.Create(nil);
  try
    FController.Dao(
      FController.Entity.Cliente.SetCodigo(
        ACliente
      )
    ).ListarPorId.DataSource(lDataSource);

    CarregarDadosCliente(lDataSource.DataSet);

  finally
    lDataSource.Free;
  end;
end;

procedure TFPedido.PesquisarProduto(AProduto: Integer);
var
  lDataSource: TDataSource;
begin
  lDataSource := TDataSource.Create(nil);
  try
    FController.Dao(
      FController.Entity.Produto.SetCodigo(
        AProduto
      )
    ).ListarPorId.DataSource(lDataSource);

    CarregarDadosProduto(lDataSource.DataSet);

  finally
    lDataSource.Free;
  end;
end;

function TFPedido.ValidarCamposItens: Boolean;
var
  i: Integer;
  Field: TField;
begin
  Result := True;
  for i := 0 to ClientDataSet.FieldCount - 1 do
    begin
      Field := ClientDataSet.Fields[i];
      if Field.Required and Field.IsNull then
      begin
        ShowMessage('O campo ' + Field.DisplayLabel + ' deve ser informado.');
        Field.FocusControl;
        Result := False;
        Break;
      end;
    end;

end;

procedure TFPedido.CalcularTotalItem;
begin
  ClientDataSetTOTAL_ITEM.AsFloat := ClientDataSetQUANTIDADE.AsFloat * ClientDataSetVALOR_UNITARIO.AsFloat;
end;

procedure TFPedido.CarregaItensPedido(ADataSet: TDataSet);
var
  i: Integer;
  Field: TField;
begin
  if ADataSet.IsEmpty then
  begin
    ClientDataSet.Append;
    Exit;
  end;

  ADataSet.First;
  while not ADataSet.Eof do
  begin
    ClientDataSet.Append;
    for i := 0 to ADataSet.FieldCount - 1 do
    begin
      Field := ADataSet.Fields[i];
      ClientDataSet.FieldByName(Field.FieldName).Value := Field.Value;
    end;
    PesquisarProduto(ClientDataSetCODIGO_PRODUTO.AsInteger);
    ClientDataSet.Post;

    ADataSet.Next;
  end;
  ClientDataSet.First;

end;

procedure TFPedido.CarregarDados(ADataSet: TDataSet);
var
  tipoOperacao: String;
begin
  FCodigoPedido := 0;
  if ADataSet.IsEmpty then
    Exit;

  FCodigoPedido := ADataSet.FieldByName('CODIGO').AsInteger;
  EditNumeroPedido.Text := ADataSet.FieldByName('NUMERO_PEDIDO').AsString;
  EditReferencia.Text := ADataSet.FieldByName('REFERENCIA').AsString;
  DataEmissao.DateTime := ADataSet.FieldByName('DATA_EMISSAO').AsDateTime;
  tipoOperacao := ADataSet.FieldByName('TIPO_OPERACAO').AsString;

  CheckEntrada.Checked := tipoOperacao = 'E';
  CheckSaida.Checked := tipoOperacao = 'S';

  PesquisarCliente(ADataSet.FieldByName('CODIGO_CLIENTE').AsInteger);
  btnExcluir.Enabled := True;
end;

procedure TFPedido.CarregarDadosCliente(ADataSet: TDataSet);
begin
  EditCodigoCliente.Clear;
  EditNomeCliente.Clear;

  if ADataSet.IsEmpty then
    Exit;

  EditCodigoCliente.Text := ADataSet.FieldByName('CODIGO').AsString;
  EditNomeCliente.Text := ADataSet.FieldByName('NOME').AsString;
end;

procedure TFPedido.CarregarDadosProduto(ADataSet: TDataSet);
begin
  ClientDataSetDESCRICAO.Clear;
  ClientDataSetCODIGO_PRODUTO.Clear;

  if ADataSet.IsEmpty then
    Exit;

  ClientDataSetDESCRICAO.AsString       := ADataSet.FieldByName('DESCRICAO').AsString;
  ClientDataSetCODIGO_PRODUTO.AsInteger := ADataSet.FieldByName('CODIGO').AsInteger;
end;

procedure TFPedido.CheckEntradaClick(Sender: TObject);
begin
  CheckSaida.Checked := not CheckEntrada.Checked;
end;

procedure TFPedido.CheckSaidaClick(Sender: TObject);
begin
  CheckEntrada.Checked := not CheckSaida.Checked;
end;

procedure TFPedido.ClientDataSetAfterEdit(DataSet: TDataSet);
begin
  btnNovoItem.Enabled := False;
  btnInserirItem.Enabled := True;
  btnCancelarItem.Enabled := True;
  btnRemoverItem.Enabled := False;
end;

procedure TFPedido.ClientDataSetQUANTIDADEChange(Sender: TField);
begin
  CalcularTotalItem;
end;

procedure TFPedido.ClientDataSetVALOR_UNITARIOChange(Sender: TField);
begin
  CalcularTotalItem;
end;

procedure TFPedido.CODIGO_PRODUTOKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> #13 then
    Exit;

  PesquisarProduto(StrToInt(CODIGO_PRODUTO.Text));
  Perform(Wm_NextDlgCtl,0,0);
end;

procedure TFPedido.EditCodigoClienteKeyPress(Sender: TObject; var Key: Char);
var
  lDataSource: TDataSource;
begin
  if Key <> #13 then
    Exit;

  if EditCodigoCliente.Text = '' then
    Exit;

  lDataSource := TDataSource.Create(nil);
  try
    FController.Dao(
      FController.Entity.Cliente.SetCodigo(
        StrToInt(EditCodigoCliente.Text)
      )
    ).ListarPorId.DataSource(lDataSource);

    CarregarDadosCliente(lDataSource.DataSet);
  finally
    lDataSource.Free;
  end;
end;

procedure TFPedido.EditNumeroPedidoKeyPress(Sender: TObject; var Key: Char);
var
  lDataSource: TDataSource;
begin
  if Key <> #13 then
    Exit;

  lDataSource := TDataSource.Create(nil);
  try
    FController.Dao(
      FController.Entity.Pedido.SetNumeroPedido(
        StrToInt(EditNumeroPedido.Text)
      )
    ).ListarPor('NUMERO_PEDIDO').DataSource(lDataSource);

    CarregarDados(lDataSource.DataSet);
  finally
    lDataSource.Free;
  end;
end;

procedure TFPedido.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  // oculta as abas do PageControl e seta a pagina inicial
  for i := 0 to PageControl.PageCount -1 do
    PageControl.Pages[i].TabVisible := False;

  PageControl.ActivePage := PageControl.Pages[0];

  FController := TController.New;

  FValidadorCampos := TValidadorCampos.New(Self);

  FTotalizadorValor := TTotalizadorValor.New(ClientDataSet);
  LimparCampos;
  Shape.Width := PanelPedido.Width - 2;
end;

procedure TFPedido.FormShow(Sender: TObject);
begin
  EditNumeroPedido.SetFocus;
  btnExcluir.Enabled := False;
end;

procedure TFPedido.LimparCampos;
begin
  EditNumeroPedido.Clear;
  EditReferencia.Clear;
  DataEmissao.DateTime := Now();
  EditCodigoCliente.Clear;
  EditNomeCliente.Clear;
  CheckEntrada.Checked := False;
  CheckSaida.Checked := True;
  FCodigoPedido := 0;
  ClientDataSet.Close;
  ClientDataSet.CreateDataSet;
  ClientDataSet.Open;
end;

procedure TFPedido.AbrirPesquisa(ATipoPesquisa: tTipoPesquisa);
var
  FPesquisa: TFPesquisa;
begin
  FPesquisa := TFPesquisa.Create(Self);
  FPesquisa.TipoPesquisa := ATipoPesquisa;
  try
    if FPesquisa.ShowModal = mrOk then
    begin
      case ATipoPesquisa of
        tpCliente:
          CarregarDadosCliente(FPesquisa.GetDataSet);
        tpPedido:
          CarregarDados(FPesquisa.GetDataSet);
      end;
    end;
  finally
    FPesquisa.Free;
  end;
end;

procedure TFPedido.btnAvancarClick(Sender: TObject);
begin
  if EditNumeroPedido.Text = '' then
    if not FValidadorCampos.ValidarCampos then
      Exit;

  PesquisaItensPedido;
  PageControl.SelectNextPage(True, False);
  if ClientDataSet.IsEmpty then
    btnNovoItem.Click
  else
  begin
    btnInserirItem.Enabled := False;
    btnCancelarItem.Enabled := False;
  end;
  EditTotalPedido.Text := FTotalizadorValor.CalcularTotal;

  CODIGO_PRODUTO.SetFocus;
end;

procedure TFPedido.btnCancelarItemClick(Sender: TObject);
begin
  ClientDataSet.Cancel;
  btnCancelarItem.Enabled := False;
  btnInserirItem.Enabled := False;
  btnNovoItem.Enabled := True;
  btnRemoverItem.Enabled := True;
end;

procedure TFPedido.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Confirma a exclusão do pedido?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  try
    ClientDataSet.DisableControls;
    try
      ClientDataSet.First;
      while not ClientDataSet.Eof do
      begin
        var lItensPedidos := FController.Entity
            .PedidoItens
            .SetCodigo(ClientDataSetCODIGO.AsInteger);

        FController.Dao(lItensPedidos).Excluir;

        ClientDataSet.Next;
      end;

      var lPedido := FController.Entity
        .Pedido
        .SetCodigo(FCodigoPedido);
//        .SetNumeroPedido(StrToInt(EditNumeroPedido.Text));

      FController.Dao(lPedido).Excluir;
    except
      on E:Exception do
        ShowMessage('Erro ao excluir pedido. ' + E.Message);
    end;
    btnVoltar.Click;
    btnNovo.Click;
  finally
    ClientDataSet.EnableControls;
  end;
end;

end.
