import wollok.game.*


object billetera {
    const saldoInicial = 100
    const meta = 2000
    const recompensaMoneda = 20
    var saldo = saldoInicial

    method tieneAlMenos(monto) = saldo >= monto

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
        // Te da la plata siempre que una carta llegue sana y salva al fondo
        //self.sumar(20) 
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

    method image() = "casino\\marcador-fondo.png"
}

object marcador {
    method position() = game.at(1, 11)

    method text() = billetera.saldo().toString()

    method textColor() = "FFD700"
}