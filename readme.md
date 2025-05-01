# Agrotis Agroinformática
Agrotis Agroinformática é um projeto desenvolvido para gerenciar pedidos de clientes, produtos e itens de pedidos. Utilizando a linguagem Delphi e o padrão de arquitetura MVC, o sistema é estruturado para promover uma separação clara entre as camadas de apresentação, negócio e dados, facilitando a manutenção e escalabilidade da aplicação.​

## Arquitetura
O projeto adota o padrão MVC (Model-View-Controller), com ênfase na orientação a interfaces. Cada entidade (Cliente, Produto, Pedido, Item do Pedido) é representada por uma interface específica, promovendo baixo acoplamento e alta coesão.​

## Principais Componentes
- **Interfaces de Entidade:** Definem contratos para as entidades, permitindo implementações flexíveis e desacopladas.

- **Classes Construtoras:** Implementam as interfaces, retornando a própria instância (`result := Self;`), facilitando o encadeamento de métodos e a fluidez na criação de objetos.

- **IEntity:** Interface genérica que expõe a implementação das classes sem acoplar diretamente a instância em outras camadas, seguindo o padrão Factory Method.

- **IConnection:** Interface para abstração da conexão com o banco de dados, permitindo a utilização de diferentes drivers de conexão.

- **TConexaoFiredac:** Implementação da interface `IConnection` utilizando o componente FireDAC, que herda de `TCustomConnection`, garantindo compatibilidade com diversos bancos de dados.​

## Tecnologias Utilizadas
- Linguagem: Delphi
- IDE: Delphi 10.3
- Padrão de Arquitetura: MVC (Model-View-Controller)
- Abordagem: Orientação a Interfaces
- Acesso a Dados: FireDAC
- Banco de Dados: Compatível com diversos bancos de dados suportados pelo FireDAC​

## Como Executar o Projeto
1. Pré-requisitos:
- Delphi instalado (versão compatível com o projeto).
- Banco de dados configurado e acessível.
- Componentes necessários (como FireDAC) devidamente instalados.​

2. Passos:
- Clone o repositório:​
```
git clone https://github.com/MarceloFormentini/AgrotisAgroinformatica.git
```
- Abra o arquivo CadastroPedido.dpr no Delphi.
- Configure a conexão com o banco de dados conforme necessário no arquivo `config.ini`.

> [!NOTE]
> O arquivo `config.ini` deve estar na mesma pasta do executável, com isso o sistema lê o arquivo para a conexão.
- Compile e execute o projeto.​

## Funcionalidades
1. **Cadastro de Clientes:** Permite adicionar, editar e remover informações de clientes.

2. **Cadastro de Produtos:** Gerencia os produtos disponíveis para pedidos.

3. **Gestão de Pedidos:** Criação, edição e exclusão de pedidos, associando clientes e produtos.

4. **Itens do Pedido:** Adição de múltiplos produtos a um pedido, com quantidades e valores específicos.