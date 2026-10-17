import wollok.game.*

object billetera {
    // var saldo = self.saldoInicial()
    // method saldoInicial() = 100
    
    var saldo = 100
    const meta = 2000

    method saldo() = saldo

    method sumar(monto) {
        saldo = saldo + monto
    }

    method restar(monto) {
        saldo = (saldo - monto).max(0)
    }

    method puedeApostar(monto) = saldo >= monto

    method alcanzoLaMeta() = saldo >= meta
}

object marcadorFondo {
    method position() = game.at(0, 11)

    method image() = "casino\\marcador-fondo.png"
}

object marcador {
    method position() = game.at(1, 11)

    method text() = billetera.saldo().toString()

    method textColor() = "FFD700"
}