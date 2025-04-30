unit Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Mask, Vcl.DBCtrls,
  controller.uIController, Data.DB, model.validacao.uIValidadorCampos;

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
  private
    FController: IController;
    FValidadorCampos: IValidadorCampos;

    procedure LimparCampos;
    procedure CarregarDados(ADataSet: TDataSet);
    procedure CarregarDadosCliente(ADataSet: TDataSet);
    procedure PesquisarCliente(ACliente: Integer);
    procedure EnableDisablePanel(APanel: TWinControl; AEnable: Boolean);
    procedure AbrirPesquisa(AChamada: String);
  end;

var
  FPedido: TFPedido;

implementation

uses
  controller.uController, Pesquisa, model.validacao.uValidadorCampos;

{$R *.dfm}

procedure TFPedido.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFPedido.btnNovoClick(Sender: TObject);
begin
  LimparCampos;
  EnableDisablePanel(PanelPedido, True);
end;

procedure TFPedido.btnPesquisaClick(Sender: TObject);
begin
  AbrirPesquisa('PEDIDO');
end;

procedure TFPedido.btnPesquisaClienteClick(Sender: TObject);
begin
  AbrirPesquisa('C');
end;

procedure TFPedido.btnSalvarClick(Sender: TObject);
begin
//
end;

procedure TFPedido.btnVoltarClick(Sender: TObject);
begin
  PageControl.SelectNextPage(False, False);
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

procedure TFPedido.CarregarDados(ADataSet: TDataSet);
var
  tipoOperacao: String;
begin
  if ADataSet.IsEmpty then
    Exit;

  EditNumeroPedido.Text := ADataSet.FieldByName('NUMERO_PEDIDO').AsString;
  EditReferencia.Text := ADataSet.FieldByName('REFERENCIA').AsString;
  DataEmissao.DateTime := ADataSet.FieldByName('DATA_EMISSAO').AsDateTime;
  tipoOperacao := ADataSet.FieldByName('TIPO_OPERACAO').AsString;

  CheckEntrada.Checked := tipoOperacao = 'E';
  CheckSaida.Checked := tipoOperacao = 'S';

  PesquisarCliente(ADataSet.FieldByName('CODIGO_CLIENTE').AsInteger);
end;

procedure TFPedido.CarregarDadosCliente(ADataSet: TDataSet);
begin
  if ADataSet.IsEmpty then
    Exit;

  EditCodigoCliente.Text := ADataSet.FieldByName('CODIGO').AsString;
  EditNomeCliente.Text := ADataSet.FieldByName('NOME').AsString;
end;

procedure TFPedido.CheckEntradaClick(Sender: TObject);
begin
  CheckSaida.Checked := not CheckEntrada.Checked;
end;

procedure TFPedido.CheckSaidaClick(Sender: TObject);
begin
  CheckEntrada.Checked := not CheckSaida.Checked;
end;

procedure TFPedido.EditNumeroPedidoKeyPress(Sender: TObject; var Key: Char);
var
  lDataSource: TDataSource;
begin
  if Key <> #13 then
    Exit;

  FController.Dao(
      FController.Entity.Pedido.SetNumeroPedido(
        StrToInt(EditNumeroPedido.Text)
      )
    ).ListarPorId.DataSource(lDataSource);

    CarregarDados(lDataSource.DataSet);
end;

procedure TFPedido.EnableDisablePanel(APanel: TWinControl; AEnable: Boolean);
var
  I: Integer;
begin
  for I := 0 to APanel.ControlCount - 1 do
  begin
    if APanel.Controls[I] is TWinControl then
      TWinControl(APanel.Controls[I]).Enabled := AEnable;
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

  LimparCampos;
  Shape.Width := PanelPedido.Width - 2;
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
end;

procedure TFPedido.AbrirPesquisa(AChamada: String);
var
  FPesquisa: TFPesquisa;
begin
  FPesquisa := TFPesquisa.Create(Self);
  FPesquisa.TipoPesquisa := AChamada;
  try
    if FPesquisa.ShowModal = mrOk then
    begin
      if AChamada = 'PEDIDO'then
      begin
        CarregarDados(FPesquisa.GetDataSet);
        EnableDisablePanel(PanelPedido, False);
      end
      else
        CarregarDadosCliente(FPesquisa.GetDataSet);
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
  PageControl.SelectNextPage(True, False);
end;

end.
