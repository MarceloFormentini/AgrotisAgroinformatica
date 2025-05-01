unit Principal;

interface

uses
  Cliente,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.CategoryButtons, System.ImageList,
  Vcl.ImgList, Vcl.ExtCtrls, Vcl.WinXCtrls, Vcl.Buttons, Vcl.StdCtrls;

type
  TFPrincipal = class(TForm)
    PanelPrincipal: TPanel;
    PanelMenu: TPanel;
    btnSair: TSpeedButton;
    btnMenu: TSpeedButton;
    btnCliente: TSpeedButton;
    btnPedido: TSpeedButton;
    btnProduto: TSpeedButton;
    ImageList: TImageList;
    procedure btnMenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnClienteClick(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
    procedure btnPedidoClick(Sender: TObject);

  private
    FExpandido: Boolean;
    procedure ShowHint(AValue: Boolean);

  end;

var
  FPrincipal: TFPrincipal;

implementation

uses
  Produto, Pedido;

{$R *.dfm}

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  FExpandido := False;
  PanelMenu.Width := 38;
  ShowHint(True);
end;

procedure TFPrincipal.btnMenuClick(Sender: TObject);
begin
  if FExpandido then
  begin
    PanelMenu.Width := 38;
    ShowHint(True)
  end
  else
  begin
    PanelMenu.Width := 110;
    ShowHint(False)
  end;

  FExpandido := not FExpandido;
end;

procedure TFPrincipal.btnClienteClick(Sender: TObject);
var
  FCliente : TFCliente;
begin
  FCliente := TFCliente.Create(Self);
  try
    FCliente.ShowModal;
  finally
    FreeAndNil(FCliente)
  end;
end;

procedure TFPrincipal.btnProdutoClick(Sender: TObject);
var
  FProduto: TFProduto;
begin
  FProduto := TFProduto.Create(Self);
  try
    FProduto.ShowModal;
  finally
    FProduto.Free;
  end;
end;

procedure TFPrincipal.btnPedidoClick(Sender: TObject);
var
  FPedido: TFPedido;
begin
  FPedido := TFPedido.Create(Self);
  try
    FPedido.ShowModal;
  finally
    FPedido.Free;
  end;
end;

procedure TFPrincipal.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFPrincipal.ShowHint(AValue: Boolean);
begin
  btnCliente.ShowHint := AValue;
  btnProduto.ShowHint := AValue;
  btnPedido.ShowHint := AValue;
  btnSair.ShowHint := AValue;
end;

end.
