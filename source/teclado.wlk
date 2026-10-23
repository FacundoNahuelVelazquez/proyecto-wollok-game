import wollok.game.*
import personaje.*
import pantallaDeInicio.*
import vasos.*
import juego.*

object moverPersonaje {
    method mover() {
        keyboard.w().onPressDo { personaje.arriba() }
        keyboard.s().onPressDo { personaje.abajo() }
        keyboard.d().onPressDo { personaje.derecha() }
        keyboard.a().onPressDo { personaje.izquierda() }

        keyboard.e().onPressDo { juegoVasos.interactuar() }
        keyboard.num1().onPressDo { juegoVasos.numero(1) }
        keyboard.num2().onPressDo { juegoVasos.numero(2) }
        keyboard.num3().onPressDo { juegoVasos.numero(3) }
        
        keyboard.r().onPressDo { juego.reiniciar() }
    }

   
}