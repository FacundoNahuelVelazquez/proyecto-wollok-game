
import wollok.game.*
import personaje.*
import pantallaDeInicio.*
import escenarios.*
import teclado.*
import musica.*
import billetera.*

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

        keyboard.enter().onPressDo {
            game.removeVisual(casino)
        }

        game.start()
    }

    method irA(escenario, posicionInicial) {
        escenarioActual = escenario
        escenario.cargar()
        personaje.position(posicionInicial)
    }

    method salidasEn(pos) = escenarioActual.salidas().filter({ salida => salida.activaEn(pos) })
}