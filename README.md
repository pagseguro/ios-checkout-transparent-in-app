![ps5.png](https://bitbucket.org/repo/4naLKz/images/1051242651-ps5.png)

# Guia de Integração #
* **
**Biblioteca iOS PagSeguro UOL - Checkout Transparente Manual de Uso**
 
* **
**Histórico de Versões**    

- 0.0.1 : **Atualização do SDK**  - 16/02/2017

* **

**Copyright**

Todos os direitos reservados. O UOL é uma marca comercial do UNIVERSO ONLINE S / A. O logotipo do UOL é uma marca comercial do UNIVERSO ONLINE S / A. Outras marcas, nomes, logotipos e marcas são de propriedade de seus respectivos proprietários.
As informações contidas neste documento pertencem ao UNIVERSO ONLINE S/A. Todos os direitos reservados. UNIVERSO ONLINE S/A. - Av. Faria Lima, 1384, 6º andar, São Paulo / SP, CEP 01452-002, Brasil.
O serviço PagSeguro não é, nem pretende ser comparável a serviços financeiros oferecidos por instituições financeiras ou administradoras de cartões de crédito, consistindo apenas de uma forma de facilitar e monitorar a execução das transações de comércio electrónico através da gestão de pagamentos. Qualquer transação efetuada através do PagSeguro está sujeita e deve estar em conformidade com as leis da República Federativa do Brasil.
Aconselhamos que você leia os termos e condições cuidadosamente.

* **

**Aviso Legal**

O UOL não oferece garantias de qualquer tipo (expressas, implícitas ou estatutárias) com relação às informações nele contidas. O UOL não assume nenhuma responsabilidade por perdas e danos (diretos ou indiretos), causados por erros ou omissões, ou resultantes da utilização deste documento ou a informação contida neste documento ou resultantes da aplicação ou uso do produto ou serviço aqui descrito. O UOL reserva o direito de fazer qualquer tipo de alterações a quaisquer informações aqui contidas sem aviso prévio.

* **

**Visão Geral**

A biblioteca Checkout Transparente tem como foco auxiliar desenvolvedores que desejam prover em seus aplicativos toda a praticidade e segurança fornecida pelo PagSeguro no segmento de pagamentos móveis através de smartphones e tablets. Para ajudar a entender como a biblioteca pode ser utilizada, apresentamos o seguinte cenário:

• Cenário Exemplo: Solução de pagamentos com Checkout Transparente. A empresa X desenvolve um aplicativo para seus clientes permitindo-os efetuar pagamento de serviços prestados ou itens (produtos) vendidos. Neste cenário o aplicativo da empresa X faz uso da biblioteca PagSeguro "Checkout Transparente" autorizando a Library com a sua conta PagSeguro (E-mail vendedor e Token referente da conta). O aplicativo coleta os dados do cartão de crédito do cliente informando-o para a biblioteca PagSeguro "Checkout Transparente" o valor, descrição do pagamento e os dados do cartão para realizar pagamentos solicitado pelos usuários do aplicativo. A empresa X receberá os pagamentos em sua conta PagSeguro configurada como vendedor na Lib Checkout Transparente.


* **

**Conceitos Básicos**

Antes de fazer uso da biblioteca é importante que o desenvolvedor realize alguns procedimentos básicos, além de assimilar alguns conceitos importantes para o correto funcionamento de sua aplicação. É necessário ter em mãos o token da conta PagSeguro que será configurado como vendedor (Seller), tal token pode ser obtido no ibanking do PagSeguro. (Vide tópico abaixo).

* **

**Para utilizar o Checkout Transparente**

O Checkout Transparente in App está operando em fase de piloto. Para fazer parte deste piloto você precisa seguir alguns passos:

- Enviar um e-mail para checkoutinapp@pagseguro.com.br informando um telefone de contato e o e-mail da sua conta PagSeguro.  
Se você for selecionado para o piloto, nossa equipe entrará em contato com você para obter mais informações e liberar a funcionalidade para a sua conta;
- Implementar o Checkout Transparente in App em sua aplicação;
- Encaminhar os feedbacks para a nossa equipe. Nesta fase do projeto a sua opinião será extremamente importante.

A equipe do PagSeguro dará todo o suporte para sua integração do Checkout in App com a sua aplicação.

* **

**Obtendo Token da conta PagSeguro**

Para realizar transações utilizando a biblioteca é necessária uma conta PagSeguro. Caso não tenha uma Acesse: www.pagseguro.com.br.
Com a conta PagSeguro criada é necessário ter o Token da conta que será utilizada na configuração como vendedor na Library Checkout Transparente.

OBTENDO TOKEN DA CONTA PAGSEGURO PARA INTEGRAÇÃO COM API's

Na pagina do ibanking do PagSeguro em sua conta:

1- Click na guia **"Minha Conta"**;

2- No Menu lateral clique em **"Preferências"**;

3- Pressione o botão **"Gerar Token"**;

4- Armazene esse **TOKEN** em algum lugar pois iremos utilizá-lo a seguir nesse guia de integração.

* **
## **1 - Instalação** ##

**Obs: Os trechos utilizados nesta documentação foram retirados da aplicação de exemplo disponível nesse repositório.**


A biblioteca possui um arquivo:

* `ios-checkout-transparent-in-app.framework`: é o binário da biblioteca, a partir de onde serão realizada as chamadas.

Para instalar, copie o arquivo para o seu projeto no Xcode.

* **
## **2 - Configuração do info.plist** ##

Adicionar a liberação para segurança de tráfego de dados

```html

    <key>NSAppTransportSecurity</key>
        <dict>
            <key>NSAllowsArbitraryLoads</key>
            <true/>
        </dict>
```


* **
## **3 - Configurações do projeto** ##

Targets -> Build Settingns -> Header Search Paths

Adicionar :

* $(PROJECT_DIR)/ios-checkout-transparent-in-app.framework/Headers

* **
## **4 - Configurações de Autorização** ##

Antes de utilizar os demais métodos da biblioteca é de extrema importância passar as configuração para inicialização da Lib Checkout Transparente.

Configuração de inicialização da Lib:

* (NSString) Email (E-mail da conta que será utilizado como vendedor);

* (NSString) withToken (Token da conta que será utilizado como vendedor, foi explicado anteriormente nessa documentação como obter esse token);

* (NSString) appName (Nome do aplicativo);

* Importar a classe AuthorizationLib

```objective-c

    #import "AuthorizationLib.h"

    [[AuthorizationLib sharedManager] setEmail:@"exemplo@bol.com.br" 
    withToken:@"10291902189212891289"];


```

* **
## **4 - Configurações ViewController** ##

Apartir da classe CheckoutTransparent criar a instância para efetuar o pagamento;

Importar a classe CheckoutTransparent
```objective-c
#import "CheckoutTransparent.h"

```

Criar uma propriedade CheckoutTransparent
```objective-c
@property CheckoutTransparent *checkoutTransparent;

```

Instância com os parâmetros para efetuar o pagamento;


* (NSString) CreditCard (Número cartão de crédito);

* (NSString) expMonth (Mês data de validade do cartão de crédito); 

* (NSString) expYear (Ano data de validade do cartão de crédito);

* (NSString) amountPayment (Valor do pagamento);

* (NSString) descriptionPayment (Descrição do pagamento);

* (BOOL, NSDictionary) success (callback retorno sucesso da requisição do pagamento, parâmetros de retorno BOOL e  NSDictionary);

* (NSError) failure (callback retorno falha da requisição do pagamento, parâmetros de retorno NSError);

```objective-c
self.checkoutTransparent = [[CheckoutTransparent alloc] initWithCreditCard:@"4716940755077413"
                                    expMonth:@"10"
                                    expYear:@"22"
                                    cvv:@"123"
                                    amountPayment:@"10.00"
                                    descriptionPayment:@"pagamento de roupa"
                                    success:^(BOOL approved, NSDictionary *success){
                                        NSLog(@"ApprovalResult");

                                    } failure:^(NSError *error) {
                                        NSLog(@"RefusedResult");
                                    }];
```

* **
**Código de Erros**

Abaixo seguem os códigos de erro que podem ser retornados pela biblioteca:

1001 - INVALID CARD NUMBER (Número do cartão inválido);

1002 - YEAR OF VALIDATION OF THE INVALID CARD (Ano de validade do cartão inválido);

1003 - VALID MONTH OF INVALID CARD (Mês de validade do cartão inválido);

1004 - VALUE OF INVALID PAYMENT (Valor do pagamento inválido);

1005 - INVALID CVV NUMBER (Número do cvv inválido);

9000 - NETWORK_ERROR (Falha de conexão);

9001 - REFUSED_TRANSACTION_ERROR (Transação cancelada ou recusada);

9002 - CREATE_TRANSACTION_ERROR (Falha ao criar transação);

9003 - TIME_OUT_CHECK_TRANSACTION (Timeout verificação status da transação);

9004 - CHECK_TRANSACTION_ERROR (Falha na verificação da transação);

9005 - TIME_OUT_CHECK_TRANSACTION_VALIDATOR (Timeout verificação status da transação validadora);

* **

**UOL - O melhor conteúdo**

© 1996-2017 O melhor conteúdo. Todos os direitos reservados.
UNIVERSO ONLINE S/A - CNPJ/MF 01.109.184/0001-95 - Av. Brigadeiro Faria Lima, 1.384, São Paulo - SP - CEP 01452-002 
<hr>
