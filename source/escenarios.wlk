import wollok.game.*
import obstaculos.*
import juego.*

object fondo {
    var property image = "casino\\casino-tablero.png"

    method position() = game.origin()
}

object escenarioCasino {
    method salidas() = [salidaCasinoADados]

    method cargar() {
        fondo.image("casino\\casino-tablero.png")
        obstaculos.limpiar()
        self.cargarParedes()
        self.cargarMesas()
        self.cargarMaquinitas()
    }

    method cargarParedes() {
        obstaculos.bloquearZona(0, 15, 10, 11)    // pared y cortinas de arriba
        obstaculos.bloquearZona(0, 5, 0, 1)       // abajo a la izquierda (máquinas y cordón)
        obstaculos.bloquearZona(10, 15, 0, 1)     // abajo a la derecha (cordón y máquinas)
    }

    method cargarMesas() {
        obstaculos.bloquearZona(0, 3, 8, 9)       // mesa de arriba, izquierda
        obstaculos.bloquearZona(5, 7, 8, 9)       // semicírculo izquierdo
        obstaculos.bloquearZona(8, 10, 8, 9)      // semicírculo derecho
        obstaculos.bloquearZona(12, 15, 8, 9)     // ruleta de arriba
        obstaculos.bloquearZona(0, 3, 5, 6)       // mesa del medio, izquierda
        obstaculos.bloquearZona(12, 15, 5, 6)     // ruleta del medio
    }

    method cargarMaquinitas() {
        obstaculos.bloquearZona(0, 4, 3, 4)       // maquinitas de arriba, izquierda
        obstaculos.bloquearZona(11, 15, 3, 4)     // maquinitas de arriba, derecha
    }
}


object salidaCasinoADados {
    const celdas = [game.at(15, 2)]

    method activaEn(pos) = celdas.contains(pos)

    method usar() {
        juego.irA(escenarioDados, game.at(1, 5))
    }
}

object salidaDadosACasino {
    const celdas = [game.at(0, 4), game.at(0, 5), game.at(0, 6)]

    method activaEn(pos) = celdas.contains(pos)

    method usar() {
        juego.irA(escenarioCasino, game.at(14, 2))
    }
}

object escenarioDados {
    method salidas() = [salidaDadosACasino]

    method cargar() {
        fondo.image("casino\\escenario-dados.png")
        obstaculos.limpiar()
        self.cargarParedes()
        self.cargarEscenario()
        self.cargarMesas()
        self.cargarBarra()
    }

    method cargarParedes() {
        obstaculos.bloquearZona(0, 15, 10, 11)  // pared de arriba
        obstaculos.bloquearZona(0, 0, 9, 9)      // plantas de arriba
        obstaculos.bloquearZona(3, 3, 9, 9)
        obstaculos.bloquearZona(12, 12, 9, 9)
        obstaculos.bloquearZona(15, 15, 9, 9)
        obstaculos.bloquearZona(0, 0, 7, 7)       // planta de la izquierda
        obstaculos.bloquearZona(15, 15, 6, 7)    // planta de la derecha
        obstaculos.bloquearZona(1, 2, 6, 6)       // cordón de arriba de la puerta
        obstaculos.bloquearZona(1, 3, 3, 3)       // cordón de abajo de la puerta
    }

    method cargarEscenario() {
        obstaculos.bloquearZona(5, 11, 6, 9)      // escenario con la mesa de vasos y las banquetas del frente
        obstaculos.bloquearZona(4, 4, 8, 9)       // banquetas de la izquierda del escenario
    }

    method cargarMesas() {
        obstaculos.bloquearZona(12, 15, 4, 5)   // mesa redonda de la derecha
        obstaculos.bloquearZona(5, 7, 2, 3)      // mesa redonda del medio
        obstaculos.bloquearZona(0, 2, 0, 1)   // mesa de abajo, izquierda
        obstaculos.bloquearZona(4, 6, 0, 1)   // mesa de abajo, medio
    }

    method cargarBarra() {
        obstaculos.bloquearZona(11, 15, 0, 3)   // barra y estantes
        obstaculos.bloquearZona(10, 10, 1, 2)  // banquetas de la barra
    }
}