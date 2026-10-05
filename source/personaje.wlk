import wollok.game.*

object personaje {
    var property position = game.origin()
    var imagenActual = "robert\\jugador-robert-sur-chiquito.png"

    method image() = imagenActual

    method arriba() {
        imagenActual = "robert\\jugador-robert-norte-chiquito.png"
        if (position.y() < game.height() - 1) {
            position = position.up(1)
        }
    }

    method abajo() {
        imagenActual = "robert\\jugador-robert-sur-chiquito.png"
        if (position.y() > 0) {
            position = position.down(1)
        }
    }

    method derecha() {
        imagenActual = "robert\\jugador-robert-oeste-chiquito.png"
        if (position.x() < game.width() - 1) {
            position = position.right(1)
        }
    }

    method izquierda() {
        imagenActual = "robert\\jugador-robert-este-chiquito.png"
        if (position.x() > 0) {
            position = position.left(1)
        }
    }
}