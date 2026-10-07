import wollok.game.*
import obstaculos.*
import personaje.*


//obstaculos planteados desde el primer escenario (casino-tablero)
//a medida que se vayan creando mas escenarios se pueden ir agregando en este archivo
object escenarioCasino {
    method cargar() {
        game.boardGround("casino\\casino-tablero.png")
        obstaculos.limpiar()
        personaje.position(game.at(7, 1))
        self.cargarParedes()
        self.cargarMesas()
        self.cargarMaquinitas()
    }

    method cargarParedes() {
        obstaculos.bloquearZona(0, 15, 10, 11)
        obstaculos.bloquearZona(0, 5, 0, 0)
        obstaculos.bloquearZona(10, 15, 0, 0)
    }

    method cargarMesas() {
        obstaculos.bloquearZona(1, 3, 8, 9)
        obstaculos.bloquearZona(5, 7, 8, 9)
        obstaculos.bloquearZona(8, 10, 8, 9)
        obstaculos.bloquearZona(12, 14, 8, 9)
        obstaculos.bloquearZona(1, 3, 5, 6)
        obstaculos.bloquearZona(12, 14, 5, 6)
    }

    method cargarMaquinitas() {
        obstaculos.bloquearZona(0, 4, 2, 3)
        obstaculos.bloquearZona(11, 15, 2, 3)
    }
}