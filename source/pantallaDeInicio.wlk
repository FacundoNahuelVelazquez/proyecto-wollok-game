import wollok.game.*

class Pantalla {
    method image()
    method position()
    method mostrarExtras() {}
    method ocultarExtras() {}
    method siguiente() = self
    method alPresionarC() {}
    method alPresionarV() {
        if (game.hasVisual(self)) {
            pantallaCreditos.volverA(self)
            menuInicio.cambiarA(pantallaCreditos)
        }
    }

    method representaFinal() = false
    method estaVisible() = game.hasVisual(self)

    method irA(pantalla) {
        if (self.estaVisible()) {
            menuInicio.cambiarA(pantalla)
        }
    }
}

object casino inherits Pantalla {
    override method image() = "casino/casino-poster-inicio.png"
    override method position() = game.origin()
    override method siguiente() = pantallaControles
    override method alPresionarC() {
        self.irA(self.siguiente())
    }
}

object pantallaGameOver inherits Pantalla {
    override method image() = "casino/game-over.png"
    override method position() = game.origin()
    override method representaFinal() = true
}

object pantallaVictoria inherits Pantalla {
    override method position() = game.origin()
    override method image() = "casino/game-win.png"
    override method representaFinal() = true
}

object pantallaControles inherits Pantalla {
    override method image() = "casino/Controles.png"
    override method position() = game.origin()
    override method mostrarExtras() {
        game.addVisual(indicacionCreditos)
    }

    override method ocultarExtras() {
        game.removeVisual(indicacionCreditos)
    }
    
    override method siguiente() = casino
    override method alPresionarC() {
        self.irA(self.siguiente())
    }
}

object pantallaCreditos inherits Pantalla {
    var pantallaAnterior = casino

    override method image() = "casino/CreditosCodeTeam.png" 
    
    override method position() = game.origin()

    override method alPresionarC() {
        self.irA(pantallaAnterior)
    }

    override method alPresionarV() {
        self.irA(pantallaAnterior)
    }

    override method representaFinal() = pantallaAnterior.representaFinal()

    method volverA(pantalla) {
        pantallaAnterior = pantalla
    }
}

// object creditosEquipo {
//     method mostrar() {
//         [tituloCreditos, creditoNehuen, creditoFacundo, creditoUriel, creditoLucas, creditoJeanPaul, volverCreditos]
//             .forEach({ credito => game.addVisual(credito) })
//     }

//     method ocultar() {
//         [tituloCreditos, creditoNehuen, creditoFacundo, creditoUriel, creditoLucas, creditoJeanPaul, volverCreditos]
//             .filter({ credito => game.hasVisual(credito) })
//             .forEach({ credito => game.removeVisual(credito) })
//     }
// }

// object tituloCreditos {
//     method text() = "CRÉDITOS"
//     method textColor() = "FFD700"
//     method position() = game.at(4, 9)
// }

object indicacionCreditos {
    method text() = "V: ver creditos"
    method textColor() = "FFD700"
    method position() = game.at(5, 1)
}

// object volverCreditos {
//     method text() = "V: volver"
//     method textColor() = "FFD700"
//     method position() = game.at(4, 3)
// }

// object creditoNehuen {
//     method text() = "Nehuen Rodriguez"
//     method textColor() = "FFFFFF"
//     method position() = game.at(4, 8)
// }

// object creditoFacundo {
//     method text() = "Facundo Velazquez"
//     method textColor() = "FFFFFF"
//     method position() = game.at(4, 7)
// }

// object creditoUriel {
//     method text() = "Uriel Garay"
//     method textColor() = "FFFFFF"
//     method position() = game.at(4, 6)
// }

// object creditoLucas {
//     method text() = "Lucas Mogro"
//     method textColor() = "FFFFFF"
//     method position() = game.at(4, 5)
// }

// object creditoJeanPaul {
//     method text() = "Jean-Paul Bittencourt"
//     method textColor() = "FFFFFF"
//     method position() = game.at(4, 4)
// }

object menuInicio {
    var pantallaActual = casino

    method configurar() {
        game.addVisual(pantallaActual)
        keyboard.c().onPressDo { self.alternarPantalla() } 
        keyboard.v().onPressDo { pantallaActual.alPresionarV() }
    }

    method cambiarA(pantalla) {
        pantallaActual.ocultarExtras()
        if (game.hasVisual(pantallaActual)) {
            game.removeVisual(pantallaActual)
        }
        pantallaActual = pantalla
        game.addVisual(pantallaActual)
        pantallaActual.mostrarExtras()
    }

    method quitarPantallaActual() {
        pantallaActual.ocultarExtras()
        if (game.hasVisual(pantallaActual)) {
            game.removeVisual(pantallaActual)
        }
        pantallaActual = casino
    }

    method alternarPantalla() {
        [pantallaActual].filter({ p => game.hasVisual(p) }).forEach({ p =>
            self.quitarPantallaActual()
            pantallaActual = p.siguiente() 
            game.addVisual(pantallaActual)
            pantallaActual.mostrarExtras()
        })
    }

    method pantallaFinalActiva() = pantallaActual.representaFinal()
}