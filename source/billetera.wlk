import wollok.game.*
import dificultad.*

object billetera {
    const recompensaMoneda = 50
    var saldo = 100

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
        //self.sumar(20) 
    }

    method puedeApostar(monto) = saldo >= monto

    method meta() = 2000

    method alcanzoLaMeta() = saldo >= self.meta()

    method estaEnQuiebra() = saldo == 0

    method reiniciar() {
        saldo = dificultad.actual().saldoInicial()
    }
}

object marcadorFondo {
    method position() = game.at(0, 11)

    method image() = "casino//marcador-fondo.png"
}

object marcador {
    method position() = game.at(1, 11)

    method text() = billetera.saldo().toString()

    method textColor() = "FFD700"
}