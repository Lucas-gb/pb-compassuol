# Calculadora Python com TDD

Este projeto consiste em uma calculadora desenvolvida em Python, utilizando a abordagem de  
TDD (Test Driven Development). A calculadora possui operações matemáticas básicas,  
e os testes foram criados com o framework pytest.

---

## Funcionalidades

A calculadora implementa as seguintes operações:

- Adição (somar)
- Subtração (subtrair)
- Multiplicação (multiplicar)
- Divisão (dividir)
- Potência (potencia)
- Porcentagem (porcentagem)

Cada operação foi testada com múltiplos cenários, incluindo números negativos, zero,  
números quebrados (float) e erros esperados (como divisão por zero).

---

## Estrutura do projeto
calculadora/
├── calculadora.py
├── test_calculadora.py
├── README.md


---

## Testes

Os testes foram desenvolvidos com pytest e estão no arquivo `test_calculadora.py`.  
Para executá-los, use o comando:

```bash
  pytest test_calculadora.py
```