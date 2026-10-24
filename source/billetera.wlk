import wollok.game.*


object billetera {
    const saldoInicial = 100
    const meta = 2000
    const recompensaEsquivaCarta = 5
    const recompensaMoneda = 20
    var saldo = saldoInicial

    method saldo() = saldo

    method sumar(monto) {
        saldo = saldo + monto
    }

    method restar(monto) {
        saldo = (saldo - monto).max(0)
    }

    method cobrarDanioCarta(monto) {
        self.restar(monto)
    }

    method recogerMoneda() {
        self.sumar(recompensaMoneda)
    }

    method premiarEsquivaCarta(columnaCarta, columnaJugadorAlAparecer, movimientosAlAparecer, columnaJugadorActual, movimientosActuales) {
        if (
            columnaCarta == columnaJugadorAlAparecer &&
            columnaJugadorActual != columnaCarta &&
            movimientosActuales > movimientosAlAparecer
        ) {
            self.sumar(recompensaEsquivaCarta)
        }
    }

    method puedeApostar(monto) = saldo >= monto

    method alcanzoLaMeta() = saldo >= meta

    method estaEnQuiebra() = saldo == 0

    method reiniciar() {
        saldo = saldoInicial
    }
}

object marcadorFondo {
    method position() = game.at(0, 11)

    method image() = "casino/marcador-fondo.png"
}

object marcador {
    method position() = game.at(1, 11)

    method text() = billetera.saldo().toString()

    method textColor() = "FFD700"
}