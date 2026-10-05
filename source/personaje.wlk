import wollok.game.*

object personaje {
    var property position = game.origin()
    var imagenActual = "robert\\jugador-robert-sur-chiquito.png"

    method image() = imagenActual

    method arriba() {
        imagenActual = "robert\\jugador-robert-norte-chiquito.png"
        position = position.up(1)
    }

    method abajo() {
        imagenActual = "robert\\jugador-robert-sur-chiquito.png"
        position = position.down(1)
    }

    method derecha() {
        imagenActual = "robert\\jugador-robert-oeste-chiquito.png"
        position = position.right(1)
    }

    method izquierda() {
        imagenActual = "robert\\jugador-robert-este-chiquito.png"
        position = position.left(1)
    }
}