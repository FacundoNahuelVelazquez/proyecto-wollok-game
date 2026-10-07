import wollok.game.*
import obstaculos.*

object casino {
    method cargar() {
        game.boardGround("casino\\casino-poster-game.png")
        obstaculos.limpiar()
    }
}