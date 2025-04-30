unit DM_Pedido;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls,
  Data.DB, Datasnap.DBClient, controller.uIController;

type
  TDMD_Pedido = class(TDataModule)
    ImageList: TImageList;
    TPedido: TClientDataSet;
    SPedido: TDataSource;
    TPedidoCODIGO: TIntegerField;
    TPedidoREFERENCIA: TStringField;
    TPedidoNUMERO_PEDIDO: TIntegerField;
    TPedidoDATA_EMISSAO: TDateField;
    TPedidoCLIENTE: TIntegerField;
    TPedidoTIPO_OPERACAO: TBooleanField;
    TPedidoTOTAL_PEDIDO: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TPedidoNUMERO_PEDIDOChange(Sender: TField);
  private
    FController: IController;
  public
    { Public declarations }
  end;

var
  DMD_Pedido: TDMD_Pedido;

implementation

uses
  Vcl.Dialogs, controller.uController;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMD_Pedido.DataModuleCreate(Sender: TObject);
begin
  TPedido.Close;
  TPedido.CreateDataSet;
  TPedido.Open;

  FController := TController.New;
end;

procedure TDMD_Pedido.DataModuleDestroy(Sender: TObject);
begin
  TPedido.Close;
end;

procedure TDMD_Pedido.TPedidoNUMERO_PEDIDOChange(Sender: TField);
begin
  if TPedidoNUMERO_PEDIDO.AsString = '' then
    Exit;


end;

end.
