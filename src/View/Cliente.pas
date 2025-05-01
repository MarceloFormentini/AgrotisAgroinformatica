unit Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  controller.uIController,
  Pesquisa, Vcl.Mask, Vcl.DBCtrls, Datasnap.DBClient, Data.DB,
  controller.cep.uIViaCepController, controller.cep.uViaCepController,
  model.validacao.uIValidadorCampos;

type
  TFCliente = class(TForm)
    PanelCliente: TPanel;
    PanelBottom: TPanel;
    btnExcluir: TButton;
    btnSalvar: TButton;
    btnFechar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditCodigo: TEdit;
    EditNome: TEdit;
    Label5: TLabel;
    btnPesquisa: TButton;
    ImageList: TImageList;
    EditUF: TEdit;
    EditCidade: TEdit;
    Label6: TLabel;
    EditCEP: TEdit;
    btnConsultarCEP: TButton;
    Label7: TLabel;
    EditLogradouro: TEdit;
    Label8: TLabel;
    EditComplemento: TEdit;
    Label9: TLabel;
    EditBairro: TEdit;
    Label10: TLabel;
    EditCodigoIBGE: TEdit;
    btnNovo: TButton;
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure EditCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnConsultarCEPClick(Sender: TObject);
  private
    FController: IController;
    FViaCEPController: IViaCepController;
    FValidadorCampos: IValidadorCampos;

    procedure LimparCampos;
    procedure CarregarCampos(ADataSet: TDataSet);

  end;

var
  FCliente: TFCliente;

implementation

uses
  controller.uController, model.cep.uViaCEP, model.cep.uIViaCEP,
  model.validacao.uValidadorCampos, utils.uEnum;

{$R *.dfm}

procedure TFCliente.btnConsultarCEPClick(Sender: TObject);
var
  ConsultaCEP: IViaCep;
begin
  if EditCEP.Text = '' then
    Exit;

  FViaCEPController := TViaCepController.New;
  ConsultaCEP := FViaCEPController.ConsultarPorCEP(EditCEP.Text);

  EditLogradouro.Text := ConsultaCEP.GetLogradouro;
  EditComplemento.Text := ConsultaCEP.GetComplemento;
  EditBairro.Text := ConsultaCEP.GetBairro;
  EditCidade.Text := ConsultaCEP.GetCidade;
  EditUF.Text := ConsultaCEP.GetUF;
  EditCodigoIBGE.Text := ConsultaCEP.GetCodigoIBGE;
end;

procedure TFCliente.btnExcluirClick(Sender: TObject);
var
  lDataSource: TDataSource;
begin
  if EditCodigo.Text = '' then
    Exit;

  if MessageDlg('Confirma a exclusão do cliente?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  lDataSource := TDataSource.Create(nil);
  try
    FController.Dao(
      FController.Entity.Pedido.SetCodigoCliente(
        StrToInt(EditCodigo.Text)
      )
    ).ListarPor('CODIGO_CLIENTE').DataSource(lDataSource);

    if not lDataSource.DataSet.IsEmpty then
    begin
      ShowMessage('Cliente vínculado a um pedido não pode ser excluído.');
      Exit;
    end;

  finally
    lDataSource.Free;
  end;

  try
    var lCliente := FController.Entity
      .Cliente
      .SetCodigo(StrToInt(EditCodigo.Text));

    FController.Dao(lCliente).Excluir;

    ShowMessage('Cliente excluído com sucesso.');
    Close;
  except
    ShowMessage('Erro ao excluir o cliente.');
  end;
end;

procedure TFCliente.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFCliente.btnNovoClick(Sender: TObject);
begin
  LimparCampos;
  EditNome.SetFocus;
end;

procedure TFCliente.btnPesquisaClick(Sender: TObject);
var
  FPesquisa: TFPesquisa;
begin
  FPesquisa := TFPesquisa.Create(Self);
  FPesquisa.TipoPesquisa := tpCliente;
  try
    if FPesquisa.ShowModal = mrOk then
      CarregarCampos(FPesquisa.GetDataSet);
  finally
    FPesquisa.Free;
  end;
end;

procedure TFCliente.btnSalvarClick(Sender: TObject);
begin
  try
    if not FValidadorCampos.ValidarCampos then
      Exit;

    var lCliente := FController.Entity
      .Cliente
      .SetNome(EditNome.Text)
      .SetCEP(EditCEP.Text)
      .SetLogradouro(EditLogradouro.Text)
      .SetComplemento(EditComplemento.Text)
      .SetBairro(EditBairro.Text)
      .SetCidade(EditCidade.Text)
      .SetUF(EditUF.Text)
      .SetCodigoIBGE(EditCodigoIBGE.Text);

    if EditCodigo.Text = '' then
    begin
      FController.Dao(lCliente).Inserir;
      ShowMessage('Cliente cadastrado com sucesso.');
    end
    else
    begin
      FController.Dao(lCliente).Atualizar;
      ShowMessage('Cliente atualizado com sucesso.');
    end;
  except
    ShowMessage('Erro ao salvar o cliente.');
  end;
end;

procedure TFCliente.CarregarCampos(ADataSet: TDataSet);
begin
  EditCodigo.Text       := ADataSet.FieldByName('CODIGO').AsString;
  EditNome.Text         := ADataSet.FieldByName('NOME').AsString;
  EditCEP.Text          := ADataSet.FieldByName('CEP').AsString;
  EditLogradouro.Text   := ADataSet.FieldByName('LOGRADOURO').AsString;
  EditComplemento.Text  := ADataSet.FieldByName('COMPLEMENTO').AsString;
  EditBairro.Text       := ADataSet.FieldByName('BAIRRO').AsString;
  EditCidade.Text       := ADataSet.FieldByName('CIDADE').AsString;
  EditUF.Text           := ADataSet.FieldByName('UF').AsString;
  EditCodigoIBGE.Text   := ADataSet.FieldByName('CODIGO_IBGE').AsString;
end;

procedure TFCliente.EditCodigoKeyPress(Sender: TObject; var Key: Char);
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
      FController.Entity.Cliente.SetCodigo(
        StrToInt(EditCodigo.Text)
      )
    ).ListarPorId.DataSource(lDataSource);

    CarregarCampos(lDataSource.DataSet);

  finally
    lDataSource.Free;
  end;
end;

procedure TFCliente.FormCreate(Sender: TObject);
begin
  FController := TController.New;
  FValidadorCampos := TValidadorCampos.New(Self);
end;

procedure TFCliente.LimparCampos;
begin
  EditCodigo.Clear;
  EditNome.Clear;
  EditCEP.Clear;
  EditLogradouro.Clear;
  EditComplemento.Clear;
  EditBairro.Clear;
  EditCidade.Clear;
  EditUF.Clear;
  EditCodigoIBGE.Clear;
end;

end.
