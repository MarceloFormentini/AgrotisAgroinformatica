MVC
Interface - orientado a interface (cliente, produto, pedido e pedido item)
classe construtora para cada interface
	set com const para não haver alteração
		result := Self; retorna a interface que esta classe esta implementando

IEntyti - uma interface que vai expor a implementação das classe sem ter a necessidade de acoplar a instancia em outra camada, no caso no Controller ou algo a parte. Como se fosse uma fabrica de métodos (Factory Method)
	classe construtora - faz o acomplamento apenas em um local. Pega a usabilidade de Ports and Adapters, quem trabalha com a porta é a interface.

regra de negócio é no model.

## Conexão
Interface IConnection -> TCustomConnection: qualquer driver de conexão a banco de dados herda do mais ancestrar possível, sendo assim todos herdam de TCustomConnection

TConexaoFiredac -> essa classe trabalha apenas com conexão Firedac, qualquer tipo de conexão., por que a camada mais externa vai ter acesso somente a interface não a conexão concreta.

Inversão de dependencia: pq a instancia vai estar em outro momento, na hora que for chamado ele vai estar sendo instanciado em outro lugar, qunado vem para a Query já vem com o objeto já instanciado, então só acessa os métodos, não preciso criar. Reduz o acoplamento.

ISettings -> pode ser configurado outro servidor
