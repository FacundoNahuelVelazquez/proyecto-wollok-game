
import wollok.game.*
import personaje.*
import pantallaDeInicio.*
import teclado.*
import musica.*



object juego {
    method iniciar() {
        game.width(16)
        game.height(12)
        game.cellSize(50)
        game.title("casino")
        musica.iniciar()

        game.boardGround("casino\\casino-tablero.png")
        game.addVisual(personaje)
        teclado.moverPersonaje.mover()
        game.start()
    }

}