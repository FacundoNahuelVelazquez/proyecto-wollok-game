import wollok.game.*
import personaje.*
import pantallaDeInicio.*

object moverPersonaje {
    method mover() {
        keyboard.w().onPressDo {
        personaje.arriba()
    }

    keyboard.s().onPressDo {
        personaje.abajo()
    }

    keyboard.d().onPressDo {
        personaje.derecha()
    }

    keyboard.a().onPressDo {
        personaje.izquierda()
    }
    }
}