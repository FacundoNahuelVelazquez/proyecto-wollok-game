import wollok.game.*
import obstaculos.*
import juego.*

object personaje {

    var property position = game.origin()
    var imagenActual = "robert\\jugador-robert-sur-chiquito.png"

    method image() = imagenActual

    method estaDentroDelTablero(pos) =
        pos.x() >= 0 and pos.x() <= game.width() - 1 and
        pos.y() >= 0 and pos.y() <= game.height() - 1

    method puedeIrA(pos) = self.estaDentroDelTablero(pos) and not obstaculos.estaBloqueada(pos)

    method moverA(nuevaPosicion) {
        [nuevaPosicion].filter({ pos => self.puedeIrA(pos) }).forEach({ pos => self.position(pos) })
        juego.salidasEn(position).forEach({ salida => salida.usar() })
    }

    method arriba() {
        imagenActual = "robert\\jugador-robert-norte-chiquito.png"
        self.moverA(position.up(1))
    }

    method abajo() {
        imagenActual = "robert\\jugador-robert-sur-chiquito.png"
        self.moverA(position.down(1))
    }

    method derecha() {
        imagenActual = "robert\\jugador-robert-este-chiquito.png"
        self.moverA(position.right(1))
    }

    method izquierda() {
        imagenActual = "robert\\jugador-robert-oeste-chiquito.png"
        self.moverA(position.left(1))
    }
}