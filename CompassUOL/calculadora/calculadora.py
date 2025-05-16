class Calculadora:
    def somar(self, *args):
        return sum(args)

    def subtrair(self, a, b):
        return a - b

    def multiplicar(self, a, b):
        return a * b

    def dividir(self, a, b):
        if b == 0:
            raise ValueError("Não é possível dividir por zero.")
        return a / b

    def potencia(self, base, expoente):
        return base ** expoente

    def porcentagem(self, base, percentual):
        return (base * percentual) / 100