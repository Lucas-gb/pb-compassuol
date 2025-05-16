import pytest
from calculadora import Calculadora

# +++++++++ TESTES DE SOMA +++++++++++

def test_soma_positivos():
    calc = Calculadora()
    assert calc.somar(5, 5, 1) == 11

def test_soma_zero():
    calc = Calculadora()
    assert calc.somar(5, 0) == 5

def test_soma_negativos():
    calc = Calculadora()
    assert calc.somar(-5, -5) == -10

def test_soma_negativo_float():
    calc = Calculadora()
    assert calc.somar(-1, 3.1) == 2.1

# --------- TESTES DE SUBTRAÇÃO ----------

def test_subtracao_positivos():
    calc = Calculadora()
    assert calc.subtrair(5, 3) == 2

def test_subtracao_negativo():
    calc = Calculadora()
    assert calc.subtrair(3, 5) == -2

def test_subtracao_zero():
    calc = Calculadora()
    assert calc.subtrair(5, 0) == 5

# ******** TESTES DE MULTIPLICAÇÃO **********

def test_multiplicacao():
    calc = Calculadora()
    assert calc.multiplicar(4, 3) == 12

def test_multiplicacao_zero():
    calc = Calculadora()
    assert calc.multiplicar(5, 0) == 0

def test_multiplicacao_negativo():
    calc = Calculadora()
    assert calc.multiplicar(-2, 4) == -8

# //---------- TESTES DE DIVISÃO ----------//

def test_divisao():
    calc = Calculadora()
    assert calc.dividir(10, 2) == 5

def test_divisao_float():
    calc = Calculadora()
    assert calc.dividir(10.6, 2) == 5.3

def test_divisao_decimal():
    calc = Calculadora()
    assert calc.dividir(7, 2) == 3.5

def test_divisao_zero():
    calc = Calculadora()
    with pytest.raises(ValueError):
        calc.dividir(10, 0)

# ^^^^^^^^^ TESTE DE POTENCIA ^^^^^^^^^

def test_potencia():
    calc = Calculadora()
    assert calc.potencia(2, 3) == 8

def test_potencia_zero():
    calc = Calculadora()
    assert calc.potencia(5, 0) == 1

# %%%%%%%%% TESTE DE PORCENTAGEM %%%%%%%%

def test_porcentagem():
    calc = Calculadora()
    assert calc.porcentagem(200, 10) == 20

def test_porcentagem_zero():
    calc = Calculadora()
    assert calc.porcentagem(200, 0) == 0
