
import wollok.game.*
import personaje.*
import pantallaDeInicio.*
import escenarios.*
import teclado.*
import musica.*
import billetera.*
import miniJefe.*
import lluviadecartas.*


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
            game.addVisual(miniJefe)
        }

        game.start()
    }

    method irA(escenario, posicionInicial) {
        if (game.hasVisual(miniJefe)) {
        game.removeVisual(miniJefe)
        }
        escenarioActual = escenario
        escenario.cargar()
        personaje.position(posicionInicial)
    }

    method verificarQuiebra() {
    [billetera].filter({ b => b.estaEnQuiebra() }).forEach({ b => self.mostrarGameOver() })
    }

    method mostrarGameOver() {
        personaje.bloquear()
        if (not game.hasVisual(pantallaGameOver)) {
            game.addVisual(pantallaGameOver)
            game.schedule(50, { lluviaDeCartas.finalizar() }) 
        }
    }

    method detenerMiniJefe() {
        miniJefe.detenerMovimiento() 
        
        miniJefe.position(game.at(6, 7))
        
        billetera.sumar(200) 
        
        self.irA(escenarioCasino, game.at(7, 1))
        
        //console.println("¡Sobreviviste a la lluvia de cartas!")
    }

    method reiniciar() {
        [pantallaGameOver].filter({ p => game.hasVisual(p) }).forEach({ p => self.volverAEmpezar() })
    }

    method volverAEmpezar() {
        if (game.hasVisual(pantallaGameOver)) {
            game.removeVisual(pantallaGameOver)
        }
        
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