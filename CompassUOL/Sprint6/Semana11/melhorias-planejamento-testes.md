# Documentação de Melhorias e Análise de Testes Automatizados (Challenge 03)

## 1. Feedback do Challenge Anterior

O feedback principal recebido foi a necessidade de "destacar os candidatos à automação" no planejamento de testes, visando maior clareza e direcionamento estratégico.

## 2. Análise e Identificação de Candidatos à Automação

Para endereçar o feedback e refinar o planejamento de testes, foi realizada uma análise aprofundada dos casos de teste manuais existentes no QAlity. O objetivo foi identificar quais cenários são os mais adequados para automação com Robot Framework, considerando sua repetitividade e impacto no sistema.

### Critérios considerados para automação:
* **Repetitivos e de Execução Frequente:** Testes que precisam ser executados várias vezes, como os de regressão ou smoke tests.
* **Críticos e de Alto Impacto:** Funcionalidades essenciais do sistema, cuja falha teria consequências significativas.
* **Resultados Determinísticos e Previsíveis:** Cenários onde o resultado esperado é sempre o mesmo e claramente definido.
* **Baseados em API:** Testes que validam entradas e saídas de dados diretamente via API, sem a necessidade de uma interface visual (otimizando a velocidade de execução e estabilidade).
* **Rápidos de Executar:** Contribuem para um ciclo de feedback rápido no processo de desenvolvimento.

### Casos de Teste Identificados como Ótimos Candidatos para Automação:
* **QT-3 - Login com credenciais válidas**
    * **Justificativa:** É uma funcionalidade crítica e de entrada do sistema. Sua execução é frequente (testes de sanidade, regressão) e possui resultados determinísticos via API, tornando-o ideal para automação.
* **QT-4 - Cadastro de produto**
    * **Justificativa:** Funcionalidade essencial para o negócio, frequentemente utilizada para criar dados de teste para outros cenários. Apresenta resultados determinísticos via API e é rápido de executar.
* **QT-5 - Criar Carrinho com Produto Válido**
    * **Justificativa:** É uma funcionalidade crítica para o fluxo de compra e frequentemente usada em conjunto com outros testes. Possui resultados previsíveis via API e é eficiente para automação.
* **QT-6 - Validar restrição de cadastro com e-mail gmail ou hotmail**
    * **Justificativa:** Teste de validação de regra de negócio, fundamental para garantir a integridade dos dados e a conformidade do sistema. Testes de cenários negativos são excelentes para automação, pois garantem que o sistema se comporte conforme o esperado para entradas inválidas.

## 3. Próximos Passos

Com base na análise, o próximo passo imediato é iniciar a implementação dos testes automatizados utilizando Robot Framework para os casos identificados acima, priorizando a estabilidade e a cobertura dos cenários mais críticos.

## 4. Testes Automatizados Implementados e Estrutura

A implementação inicial dos testes automatizados para este desafio focou nos seguintes casos de teste:
* `login_tests.robot`
* `product_tests.robot`
* `user_registration_tests.robot`

**Observação sobre a Estrutura do Projeto:**
Foi identificada a oportunidade de aprimorar a organização da estrutura de testes. Para futuras implementações, especialmente para o cenário de "Criar Carrinho com Produto Válido", será considerada a criação de uma pasta dedicada (e.g., `tests/cart/`) para abrigar testes relacionados à funcionalidade de carrinho. Esta segregação por domínio visa melhorar a modularidade, navegabilidade e manutenção do projeto de automação, em vez de agrupar tudo junto com testes de produto.

## 5. Lições Aprendidas e Desafios Futuros

Durante o desenvolvimento deste desafio, algumas limitações de tempo e escopo foram observadas, que servem como importantes lições para futuras iterações e aprimoramentos:

* **Massa de Dados Dinâmica:** Devido às restrições de tempo, implementações e refatoração não foi possível implementar com exito uma estratégia robusta para massa de dados dinâmica. Os testes atuais utilizam dados estáticos. Futuras implementações buscarão integrar fontes de dados dinâmicas para aumentar a robustez e a reutilização dos testes.
* **Expansão de Cenários e Candidatos:** O tempo limitado também impediu a exploração e automação de um número maior de cenários de testes e a identificação de candidatos adicionais à automação. Em desafios futuros, com mais experiência, o objetivo é expandir significativamente a cobertura de testes automatizados, explorando mais funcionalidades e tipos de teste.

---