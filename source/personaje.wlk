import wollok.game.*
import obstaculos.*
import juego.*

object personaje {

    var property position = game.origin()
    var imagenActual = "robert/jugador-robert-sur-chiquito.png"
    var puedeMoverse = true
    var movimientos = 0

    method image() = imagenActual
    method cantidadMovimientos() = movimientos

    method bloquear() {
        puedeMoverse = false
    }

    method liberar() {
        puedeMoverse = true
    }

    method estaDentroDelTablero(pos) =
        pos.x() >= 0 && pos.x() <= game.width() - 1 &&
        pos.y() >= 0 && pos.y() <= game.height() - 1

    method puedeIrA(pos) = puedeMoverse && self.estaDentroDelTablero(pos) && !obstaculos.estaBloqueada(pos)

    method moverA(nuevaPosicion) {
        const posicionAnterior = position
        [nuevaPosicion].filter({ pos => self.puedeIrA(pos) }).forEach({ pos => self.position(pos) })
        if (position != posicionAnterior) {
            movimientos += 1
        }
        juego.salidasEn(position).forEach({ salida => salida.usar() })
    }

    method arriba() {
        imagenActual = "robert/jugador-robert-norte-chiquito.png"
        self.moverA(position.up(1))
    }

    method abajo() {
        imagenActual = "robert/jugador-robert-sur-chiquito.png"
        self.moverA(position.down(1))
    }

    method derecha() {
        imagenActual = "robert/jugador-robert-este-chiquito.png"
        self.moverA(position.right(1))
    }

    method izquierda() {
        imagenActual = "robert/jugador-robert-oeste-chiquito.png"
        self.moverA(position.left(1))
    }

    method estaLibre() = puedeMoverse
}