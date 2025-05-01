program CadastroPedido;

uses
  Vcl.Forms,
  model.entity.uEntity in 'src\model\entity\model.entity.uEntity.pas',
  model.entity.uIEntity in 'src\model\entity\model.entity.uIEntity.pas',
  model.cliente.uCliente in 'src\model\cliente\model.cliente.uCliente.pas',
  model.cliente.uICliente in 'src\model\cliente\model.cliente.uICliente.pas',
  model.produto.uIProduto in 'src\model\produto\model.produto.uIProduto.pas',
  model.produto.uProduto in 'src\model\produto\model.produto.uProduto.pas',
  model.pedido.uIPedido in 'src\model\pedido\model.pedido.uIPedido.pas',
  model.pedido.uPedido in 'src\model\pedido\model.pedido.uPedido.pas',
  model.pedidoItens.uIItensPedido in 'src\model\pedidoItens\model.pedidoItens.uIItensPedido.pas',
  model.pedidoItens.uItensPedido in 'src\model\pedidoItens\model.pedidoItens.uItensPedido.pas',
  Cliente in 'src\View\Cliente.pas' {FCliente},
  Pesquisa in 'src\View\Pesquisa.pas' {FPesquisa},
  Principal in 'src\View\Principal.pas' {FPrincipal},
  Produto in 'src\View\Produto.pas' {FProduto},
  utils.uAtributos in 'src\utils\utils.uAtributos.pas',
  utils.uIQuery in 'src\utils\utils.uIQuery.pas',
  utils.uIUtils in 'src\utils\utils.uIUtils.pas',
  utils.uQuery in 'src\utils\utils.uQuery.pas',
  utils.uRttiHelper in 'src\utils\utils.uRttiHelper.pas',
  utils.uUtils in 'src\utils\utils.uUtils.pas',
  controller.uController in 'src\Controller\controller.uController.pas',
  controller.uIController in 'src\Controller\controller.uIController.pas',
  model.dao.uDao in 'src\Model\DAO\model.dao.uDao.pas',
  model.dao.uIDao in 'src\Model\DAO\model.dao.uIDao.pas',
  model.conexao.uConnectionFiredac in 'src\Model\conexao\model.conexao.uConnectionFiredac.pas',
  model.conexao.uSettings in 'src\Model\conexao\model.conexao.uSettings.pas',
  model.conexao.uIConnection in 'src\Model\conexao\model.conexao.uIConnection.pas',
  model.conexao.uISettings in 'src\Model\conexao\model.conexao.uISettings.pas',
  model.conexao.uIQuery in 'src\Model\conexao\model.conexao.uIQuery.pas',
  model.conexao.uQuery in 'src\Model\conexao\model.conexao.uQuery.pas',
  model.cep.uViaCEP in 'src\Model\CEP\model.cep.uViaCEP.pas',
  controller.cep.uIViaCepController in 'src\Controller\CEP\controller.cep.uIViaCepController.pas',
  controller.cep.uViaCepController in 'src\Controller\CEP\controller.cep.uViaCepController.pas',
  model.cep.uIViaCEP in 'src\Model\CEP\model.cep.uIViaCEP.pas',
  model.validacao.uValidadorCampos in 'src\Model\validacao\model.validacao.uValidadorCampos.pas',
  model.validacao.uIValidadorCampos in 'src\Model\validacao\model.validacao.uIValidadorCampos.pas',
  Pedido in 'src\View\Pedido.pas' {FPedido},
  model.totalizador.uTotalizadorValor in 'src\Model\totalizador\model.totalizador.uTotalizadorValor.pas',
  model.totalizador.uITotalizadorValor in 'src\Model\totalizador\model.totalizador.uITotalizadorValor.pas';

{$R *.res}

begin
//  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
