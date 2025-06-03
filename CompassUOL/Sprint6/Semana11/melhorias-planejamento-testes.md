# Documentação de Melhorias e Análise de Testes Automatizados (Challenge 03)

## 1. Feedback do Challenge Anterior

O feedback principal recebido foi a necessidade de **"destacar os candidatos à automação."** no planejamento de testes.

## 2. Análise e Identificação de Candidatos à Automação

Para endereçar o feedback e refinar o planejamento de testes, foi realizada uma análise dos casos de teste manuais existentes no QAlity para identificar quais são os mais adequados para automação com Robot Framework.

**Critérios considerados para automação:**
* **Repetitivos e de Execução Frequente:** Testes que precisam ser executados várias vezes (ex: regressão).
* **Críticos e de Alto Impacto:** Funcionalidades essenciais do sistema.
* **Resultados Determinísticos e Previsíveis:** Onde o resultado esperado é sempre o mesmo e claro.
* **Baseados em API:** Testes que validam entradas e saídas de dados via API, sem necessidade de interface visual.
* **Rápidos de Executar:** Contribuem para um feedback rápido.

**Casos de Teste Identificados como Ótimos Candidatos para Automação:**

* **QT-3 - Login com credenciais válidas**
    * **Justificativa:** É uma funcionalidade crítica e de entrada do sistema. É executada frequentemente e possui resultados determinísticos via API. Ideal para validação de sanidade e regressão.

* **QT-4 - Cadastro de produto**
    * **Justificativa:** Funcionalidade essencial para o negócio e muito utilizada para criar dados de teste para outros cenários. Possui resultados determinísticos via API e é rápido de executar.

* **QT-5 - Criar Carrinho com Produto Válido**
    * **Justificativa:** Também é uma funcionalidade crítica para o fluxo de compra e frequentemente usada em conjunto com outros testes. Possui resultados previsíveis via API e é eficiente para automação.

* **QT-6 - Validar restrição de cadastro com e-mail gmail ou hotmail**
    * **Justificativa:** É um teste de validação de regra de negócio, fundamental para garantir a integridade dos dados e a conformidade do sistema. Testes de cenários negativos são excelentes para automação pois garantem que o sistema se comporte conforme o esperado para entradas inválidas.

## 3. Próximos Passos
Iniciar a implementação dos testes automatizados utilizando Robot Framework para os casos identificados acima.