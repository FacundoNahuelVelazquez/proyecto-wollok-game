import wollok.game.*
import juego.*

class Pantalla {
    method image()
    method position()
    method mostrarExtras() {}
    method ocultarExtras() {}
    method siguiente() = self
    method alPresionarC() {}
    method alPresionarEnter() {}
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

    override method alPresionarEnter() {
        juego.empezarPartida()
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

    override method alPresionarEnter() {
        pantallaCreditos.volverA(self)
        self.irA(pantallaCreditos)
    }
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

    override method alPresionarEnter() {
        [self].filter({ p => p.estaVisible() and p.representaFinal() }).forEach({ p => juego.volverAEmpezar() })
    }

    override method representaFinal() = pantallaAnterior.representaFinal()

    method volverA(pantalla) {
        pantallaAnterior = pantalla
    }
}



object indicacionCreditos {
    method text() = "V: ver creditos"
    method textColor() = "FFD700"
    method position() = game.at(5, 1)
}



object menuInicio {
    var pantallaActual = casino

    method configurar() {
        game.addVisual(pantallaActual)
        keyboard.c().onPressDo { self.alternarPantalla() }
        keyboard.v().onPressDo { pantallaActual.alPresionarV() }
    }

    method alPresionarEnter() {
        pantallaActual.alPresionarEnter()
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