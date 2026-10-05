import wollok.game.*

object personaje {
    var property position = game.origin()
    var imagenActual = "jugador-robert-sur-chiquito.png"

    method image() = imagenActual

    method arriba() {
        imagenActual = "jugador-robert-norte-chiquito.png"
        position = position.up(1)
    }

    method abajo() {
        imagenActual = "jugador-robert-sur-chiquito.png"
        position = position.down(1)
    }

    method derecha() {
        imagenActual = "jugador-robert-oeste-chiquito.png"
        position = position.right(1)
    }

    method izquierda() {
        imagenActual = "jugador-robert-este-chiquito.png"
        position = position.left(1)
    }
}