unit Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  model.validacao.uIValidadorCampos, Datasnap.DBClient;

type
  TFPedido = class(TForm)
    PanelDados: TPanel;
    PanelGrid: TPanel;
    PanelTotal: TPanel;
    PanelBottom: TPanel;
    GridProdutos: TDBGrid;
    btnGravar: TButton;
    btnFechar: TButton;
    Label1: TLabel;
    EditTotalPedido: TEdit;
    Label5: TLabel;
    lblPedido: TLabel;
    EditPedido: TEdit;
    EditClienteCodigo: TEdit;
    Label3: TLabel;
    EditProdutoCodigo: TEdit;
    Label4: TLabel;
    EditQuantidade: TEdit;
    Label6: TLabel;
    EditValorInitario: TEdit;
    Label7: TLabel;
    EditClienteDescricao: TEdit;
    EditProdutoDescricao: TEdit;
    btnPesquisa: TButton;
    ImageList: TImageList;
    btnInserir: TButton;
    Button1: TButton;
    Button2: TButton;
    DataSource: TDataSource;
    ClientDataSet1: TClientDataSet;
    procedure btnFecharClick(Sender: TObject);
    procedure EditClienteCodigoChange(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FValidadorCampos: IValidadorCampos;

  end;

var
  FPedido: TFPedido;

implementation

uses
  Pesquisa, model.validacao.uValidadorCampos;

{$R *.dfm}

procedure TFPedido.btnInserirClick(Sender: TObject);
begin
  if not FValidadorCampos.ValidarCampos then
    Exit;
end;

procedure TFPedido.btnPesquisaClick(Sender: TObject);
var
  FPesquisa : TFPesquisa;
begin
//  FPesquisa := TFPesquisa.Create(Self, 'Cliente');
//  try
//    FPesquisa.ShowModal;
//  finally
//    FPesquisa.Free;
//  end;
end;

procedure TFPedido.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFPedido.EditClienteCodigoChange(Sender: TObject);
begin
  lblPedido.Enabled := EditClienteCodigo.Text = '';
  EditPedido.Enabled := EditClienteCodigo.Text = '';
  btnPesquisa.Enabled := EditClienteCodigo.Text = '';
end;

procedure TFPedido.FormCreate(Sender: TObject);
begin
  FValidadorCampos := TValidadorCampos.New(Self);
end;

end.
