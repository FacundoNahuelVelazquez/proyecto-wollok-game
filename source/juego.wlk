
import wollok.game.*
import personaje.*
import pantallaDeInicio.*
import escenarios.*
import teclado.*
import musica.*



// object juego {
//     method iniciar() {
//         game.width(16)
//         game.height(12)
//         game.cellSize(50)
//         game.title("casino")
//         musica.iniciar()

//         game.addVisual(personaje)
//         teclado.moverPersonaje.mover()
//         self.irA(escenarioCasino)
//         game.start()
//     }

//     method irA(escenario) {
//         escenario.cargar()
//     }
// }

object juego {

    method iniciar() {
        game.width(16)
        game.height(12)
        game.cellSize(50)
        game.title("casino")

        musica.iniciar()

        game.addVisual(personaje)

        teclado.moverPersonaje.mover()

        self.irA(escenarioCasino)

        game.addVisual(casino)

        keyboard.enter().onPressDo {
            game.removeVisual(casino)
        }

        game.start()
    }

    method irA(escenario) {
        escenario.cargar()
    }
}