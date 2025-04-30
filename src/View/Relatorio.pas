unit Relatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls;

type
  TFRelatorio = class(TForm)
    PanelPrincipal: TPanel;
    PanelBottom: TPanel;
    btnImprimir: TButton;
    btnFechar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditClienteCodigo: TEdit;
    EditClienteNome: TEdit;
    btnPesquisa: TButton;
    ImageList: TImageList;
    Label5: TLabel;
    EditProdutoCodigo: TEdit;
    EditProdutoDescricao: TEdit;
    Button3: TButton;
    DateInicial: TDateTimePicker;
    DateFinal: TDateTimePicker;
    cbxLayout: TComboBox;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRelatorio: TFRelatorio;

implementation

uses
  System.DateUtils;

{$R *.dfm}

procedure TFRelatorio.FormCreate(Sender: TObject);
begin
  DateInicial.Date := StartOfTheMonth(Date());
  DateFinal.Date := EndOfTheMonth(Date());
end;

procedure TFRelatorio.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
