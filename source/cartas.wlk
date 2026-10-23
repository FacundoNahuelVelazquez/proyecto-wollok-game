import wollok.game.*
import billetera.*
import juego.*

class Carta {
    var property position

    method image() 
    method penalizacion()

    method iniciarCaida() {
        game.onTick(200, "caer_" + self.identity().toString(), { self.caer() })
    }

    method caer() {
        if (position.y() > 0) {
            position = position.down(1)
        } else {
            self.esquivada()
        }
    }

    method esquivada() {
        billetera.sumar(10)
        self.destruir()
    }

    method chocarConPersonaje() {
        billetera.restar(self.penalizacion())
        juego.verificarQuiebra()
        self.destruir()
    }

    method destruir() {
        game.removeTickEvent("caer_" + self.identity().toString())
        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }
    }
}

class CartaNormal inherits Carta {
    override method image() = "mini-jefe-crupier\\carta-crupier-mini.png" 
    override method penalizacion() = 30
}

class CartaEspecial inherits Carta {
    override method image() = "mini-jefe-crupier\\carta-super-crupier-mini.png" 
    override method penalizacion() = 50
}