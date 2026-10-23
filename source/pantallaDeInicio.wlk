import wollok.game.*

// object casino {
//     method cargar() {
//         game.boardGround("casino\\casino-poster-game.png")
//         obstaculos.limpiar()
//     }
// }


object casino {

    method image() = "casino\\casino-poster-game-inicio.png"

    method position() = game.origin()
}

object pantallaGameOver {
    method image() = "casino\\game-over.png"

    method position() = game.origin()
}