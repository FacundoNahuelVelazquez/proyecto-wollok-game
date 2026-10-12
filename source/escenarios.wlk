import wollok.game.*
import obstaculos.*
import juego.*

object fondo {
    var property image = "casino\\casino-tablero.png"

    method position() = game.origin()
}

object escenarioCasino {
    method salidas() = [salidaCasinoADados1]

    method cargar() {
        fondo.image("casino\\casino-tablero.png")
        obstaculos.limpiar()
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

object escenarioDados1 {
    method salidas() = [salidaDados1ACasino]

    method cargar() {
        fondo.image("casino\\escenario-dados1.png")
        obstaculos.limpiar()
        // acá van los obstaculos.bloquearZona(...) de este mapa
    }
}

object salidaCasinoADados1 {
    const celdas = [game.at(15, 1)]

    method activaEn(pos) = celdas.contains(pos)

    method usar() {
        juego.irA(escenarioDados1, game.at(1, 1))
    }
}

object salidaDados1ACasino {
    const celdas = [game.at(0, 1)]

    method activaEn(pos) = celdas.contains(pos)

    method usar() {
        juego.irA(escenarioCasino, game.at(14, 1))
    }
}