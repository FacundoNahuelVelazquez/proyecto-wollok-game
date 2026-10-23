import wollok.game.*
import obstaculos.*
import juego.*
import miniJefe.*
import personaje.*



object fondo {
    var property image = "casino\\casino-tablero.png"

    method position() = game.origin()
}

object escenarioCasino {
    method salidas() = [salidaCasinoAVasos, encuentroMiniJefe, salidaCasinoADados]

    method cargar() {
        fondo.image("casino\\casino-tablero.png")
        obstaculos.limpiar()
        self.cargarParedes()
        self.cargarMesas()
        self.cargarMaquinitas()
        if (!game.hasVisual(miniJefe)) {
            game.addVisual(miniJefe)
        }
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


object salidaCasinoAVasos {
    const celdas = [game.at(15, 2)]

    method activaEn(pos) = celdas.contains(pos)

    method usar() {
        juego.irA(escenarioVasos, game.at(1, 5))
    }
}

object salidaVasosACasino {
    const celdas = [game.at(0, 4), game.at(0, 5), game.at(0, 6)]

    method activaEn(pos) = celdas.contains(pos)

    method usar() {
        juego.irA(escenarioCasino, game.at(14, 2))
    }
}

object escenarioVasos {
    method salidas() = [salidaVasosACasino]

    method cargar() {
        fondo.image("casino\\escenario-vasos.png")
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
        obstaculos.bloquearZona(5, 10, 6, 9)      // escenario con la mesa de vasos y las banquetas del frente
        obstaculos.bloquearZona(11, 11, 7, 9)     // borde derecho del escenario y banquetas de ese lado
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

// para los demás: la idea es que al momento de tocar ("interactuar") al crupier nos mande al otro tablero, de ese tablero no podemas salir. 
// la unica manera seria "derrotarlo", que seria esquivando todas sus cartas hasta que no tenga más, ahi terminaría este mini juego. 
// en donde podemos salir con mas o menos plata que al inicio. 


object escenarioPelea {
    method salidas() = []

    method cargar() {
        fondo.image("casino\\salon-casino-batalla.png")
        obstaculos.limpiar()
        self.cargarParedes()
        self.cargarMesas()
        self.cargarPlantas()

        miniJefe.position(game.at(6, 8))

        if (not game.hasVisual(miniJefe)) {
            game.addVisual(miniJefe)
        }

        miniJefe.iniciarAtaque()

        game.onCollideDo(personaje, {elemento => elemento.chocarConPersonaje()})
    }

    method cargarParedes() {
        obstaculos.bloquearZona(0, 15, 10, 11)    // pared de arriba y escenario del fondo
        obstaculos.bloquearZona(0, 0, 0, 9)       // pared izquierda
        obstaculos.bloquearZona(15, 15, 0, 9)     // pared derecha
        obstaculos.bloquearZona(1, 6, 0, 1)       // pared de abajo, a la izquierda de la alfombra
        obstaculos.bloquearZona(9, 14, 0, 1)      // pared de abajo, a la derecha de la alfombra
    }

    method cargarMesas() {
        obstaculos.bloquearZona(1, 3, 7, 8)       // mesa de arriba, izquierda (con banquetas)
        obstaculos.bloquearZona(12, 14, 7, 8)     // mesa de arriba, derecha (con banquetas)
        obstaculos.bloquearZona(1, 4, 4, 5)       // ruleta de la izquierda
        obstaculos.bloquearZona(2, 4, 3, 3)       // banquetas de la ruleta izquierda
        obstaculos.bloquearZona(11, 14, 4, 5)     // ruleta de la derecha
        obstaculos.bloquearZona(11, 13, 3, 3)     // banquetas de la ruleta derecha
    }

    method cargarPlantas() {
        obstaculos.bloquearZona(4, 4, 9, 9)       // planta de arriba, izquierda
        obstaculos.bloquearZona(11, 11, 9, 9)     // planta de arriba, derecha
        obstaculos.bloquearZona(1, 1, 2, 2)       // planta de abajo, izquierda
        obstaculos.bloquearZona(14, 14, 2, 2)     // planta de abajo, derecha
    }
}

object escenarioDados {
    method salidas() = [salidaDadosACasino]

    method cargar() {
        fondo.image("casino\\tablero-dados.png")
        obstaculos.limpiar()
        self.cargarParedes()
        self.cargarMesa()
        self.cargarPlantas()
    }

    method cargarParedes() {
        obstaculos.bloquearZona(0, 15, 9, 11)     // pared de arriba con plantas y escenario
        obstaculos.bloquearZona(0, 15, 0, 1)      // barandas y cordones de abajo
    }

    method cargarMesa() {
        obstaculos.bloquearZona(5, 10, 4, 6)      // mesa de dados y banquetas
    }

    method cargarPlantas() {
        obstaculos.bloquearZona(0, 0, 6, 7)       // plantas de la izquierda
        obstaculos.bloquearZona(0, 1, 2, 2)       // plantas de abajo, izquierda
        obstaculos.bloquearZona(14, 15, 2, 2)     // plantas de abajo, derecha
    }
}

object salidaCasinoADados {
    const celdas = [game.at(0, 2)]

    method activaEn(pos) = celdas.contains(pos)

    method usar() {
        juego.irA(escenarioDados, game.at(14, 5))
    }
}

object salidaDadosACasino {
    const celdas = [game.at(15, 5), game.at(15, 6)]

    method activaEn(pos) = celdas.contains(pos)

    method usar() {
        juego.irA(escenarioCasino, game.at(1, 2))
    }
}

object encuentroMiniJefe {
    const celdas = [
        game.at(6, 7), game.at(7, 7), 
        game.at(6, 8), game.at(7, 8)
    ]

    method activaEn(pos) = celdas.contains(pos)

    method usar() {
        juego.irA(escenarioPelea, game.at(7, 1))
    }
}