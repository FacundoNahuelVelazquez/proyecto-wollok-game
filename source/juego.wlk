import wollok.game.*
import personaje.*
import pantallaDeInicio.*
import escenarios.*
import teclado.*
import musica.*
import billetera.*
import miniJefe.*
import lluviadecartas.*
import dificultad.*


object juego {
    var escenarioActual = escenarioCasino

    method iniciar() {
        game.width(16)
        game.height(12)
        game.cellSize(50)
        game.title("casino")

        musica.iniciar()

        game.addVisual(fondo)
        game.addVisual(personaje)
        game.addVisual(marcadorFondo)
        game.addVisual(marcador)

        teclado.moverPersonaje.mover()

        self.irA(escenarioCasino, game.at(7, 1))

        game.addVisual(casino)
        game.addVisual(textoDificultad)
        personaje.bloquear()

        keyboard.enter().onPressDo { self.empezarPartida() }
        keyboard.h().onPressDo { self.cambiarDificultad() }

        game.start()
    }

    method empezarPartida() {
        [casino].filter({ p => game.hasVisual(p) }).forEach({ p => self.comenzar() })
    }

    method comenzar() {
        game.removeVisual(casino)
        game.removeVisual(textoDificultad)
        billetera.reiniciar()
        personaje.liberar()
    }

    method cambiarDificultad() {
        [casino].filter({ p => game.hasVisual(p) }).forEach({ p => dificultad.alternar() })
    }

    method irA(escenario, posicionInicial) {
        [miniJefe].filter({ m => game.hasVisual(m) }).forEach({ m => game.removeVisual(m) })
        escenarioActual = escenario
        escenario.cargar()
        personaje.position(posicionInicial)
    }

    method verificarQuiebra() {
        [billetera].filter({ b => b.estaEnQuiebra() }).forEach({ b => self.mostrarGameOver() })
    }

    method mostrarGameOver() {
        personaje.bloquear()
        [pantallaGameOver].filter({ p => not game.hasVisual(p) }).forEach({ p => self.ponerGameOver() })
    }

    method ponerGameOver() {
        game.addVisual(pantallaGameOver)
        game.schedule(50, { lluviaDeCartas.finalizar() })
    }

    method detenerMiniJefe() {
        miniJefe.detenerMovimiento()
        miniJefe.position(game.at(6, 7))
        billetera.sumar(200)
        self.irA(escenarioCasino, game.at(7, 1))
    }

    method reiniciar() {
        [pantallaGameOver].filter({ p => game.hasVisual(p) }).forEach({ p => self.volverAEmpezar() })
    }

    method volverAEmpezar() {
        game.removeVisual(pantallaGameOver)
        billetera.reiniciar()
        lluviaDeCartas.finalizar()

        miniJefe.detenerMovimiento()
        miniJefe.position(game.at(6, 7))

        self.irA(escenarioCasino, game.at(7, 1))
        personaje.liberar()
    }

    method estaEn(escenario) = escenarioActual == escenario

    method salidasEn(pos) = escenarioActual.salidas().filter({ salida => salida.activaEn(pos) })
}