import wollok.game.*

object casino {
    method image() = "casino\\casino-poster-inicio.png"
    method position() = game.origin()
    
    method siguiente() = pantallaControles 
}

object pantallaGameOver {
    method image() = "casino\\game-over.png"

    method position() = game.origin()
}

object pantallaVictoria {
    method position() = game.origin()
    
    method image() = "casino\\game-win.png" 
}

object pantallaControles {
    method image() = "casino\\Controles.png" 
    method position() = game.origin()
    
    method siguiente() = casino 
}

object menuInicio {
    var pantallaActual = casino

    method configurar() {
        game.addVisual(pantallaActual)
        
        keyboard.c().onPressDo { self.alternarPantalla() }
    }

    method alternarPantalla() {
        [pantallaActual].filter({ p => game.hasVisual(p) }).forEach({ p => 
            game.removeVisual(pantallaActual)
            pantallaActual = pantallaActual.siguiente()
            game.addVisual(pantallaActual)
        })
    }
}