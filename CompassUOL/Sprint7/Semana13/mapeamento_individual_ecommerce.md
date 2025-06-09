# Mapeamentos Individuais de Elementos Web - Desafio Semana 13

## Site de E-commerce Utilizado: DemoBlaze (https://www.demoblaze.com/)

---

### Estratégia 1: Mapeamento por Ordem e Tags (Estrutura Estável)

**Elemento Mapeado:** O link da categoria "Phones" na barra lateral esquerda.

**Descrição:** Este elemento representa o link para a seção de telefones no menu lateral de categorias do site. É o primeiro item da lista de categorias visíveis.

**Por que utilizei esta estratégia:** O link "Phones" não possui um ID único. No entanto, ele é consistentemente o primeiro link dentro da lista de categorias (`<a class="list-group-item">`). Ao mapeá-lo por sua posição (primeiro elemento `<a>` dentro de uma classe específica), garantimos que o mapeamento será robusto, desde que a ordem dos links nessa seção permaneça estável.

**Exemplo de Mapeamento (Robot Framework):**
```robotframework
Click Element    xpath=(//a[@class='list-group-item'])[1]

---

### Estratégia 2: Uso da Estrutura da Tabela

**Elemento Mapeado:** O link "Delete" de um item na tabela de produtos do carrinho.

**Descrição:** Este elemento é um link de ação que permite remover um produto específico da lista do carrinho de compras. Ele está localizado na última coluna de cada linha de produto dentro da tabela principal do carrinho.

**Por que utilizei esta estratégia:** A página do carrinho organiza os itens em uma tabela HTML (`<table>`). Utilizar o XPath com a estrutura de `tbody` (corpo da tabela), `tr` (linha) e `td` (coluna) permite mapear e interagir com elementos com base na sua posição relativa dentro dessa estrutura. Isso é ideal para ações como "excluir" um item específico de uma lista, garantindo que o comando atue na linha correta. Por exemplo, `tr[1]` para o primeiro item, `tr[2]` para o segundo, e assim por diante.

**Exemplo de Mapeamento (Robot Framework):**
```robotframework
Click Element    xpath=//tbody[@id='tbodyid']/tr[1]/td[7]/a

---

### Estratégia 3: Uso de Palavras-chave Customizadas

**Elemento Mapeado:** O botão "Place Order" (Fazer Pedido) na página do carrinho.

**Descrição:** Este botão inicia o processo de checkout final na página do carrinho, abrindo um modal para o formulário de finalização da compra.

**Por que utilizei esta estratégia:** O botão "Place Order" representa uma ação crucial no fluxo de compra e é um ponto de interação importante. Ao encapsular seu clique em uma palavra-chave customizada (`Fazer Pedido`), o código de teste se torna mais legível (ex: "Fazer Pedido" em vez de um seletor complexo). Além disso, se o seletor deste botão for alterado no futuro (ex: muda de classe ou ganha um ID), a correção precisa ser feita apenas na definição da palavra-chave, evitando quebrar múltiplos testes que utilizam essa ação e otimizando a manutenção.

**Exemplo de Mapeamento (Robot Framework - no arquivo `.robot` onde a palavra-chave seria definida):**
```robotframework
*** Keywords ***
Fazer Pedido
    Click Element    xpath=//button[contains(.,'Place Order')]

