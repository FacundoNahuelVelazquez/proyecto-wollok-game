import wollok.game.*
import juego.*       // <-- IMPORTANTE PARA SABER DÓNDE ESTAMOS
import escenarios.*  // <-- IMPORTANTE PARA SABER CUÁL ES EL TABLERO DE PELEA

object miniJefe {
    var property position = game.at(6, 7)
    var direccion = 1
    var estaAtacando = false

    method image() = "mini-jefe-crupier/crupier-mini-jefe-chiquito.png"

    method iniciarAtaque() {
        if (!estaAtacando) {
            estaAtacando = true
            game.onTick(300, "movimiento_jefe", { self.mover() })
        }
    }

    method detenerAtaque() {
        if (estaAtacando) {
            game.removeTickEvent("movimiento_jefe")
            estaAtacando = false
        }
    }

    method mover() {
        if (juego.estaEn(escenarioPelea)) {
            const proximoX = position.x() + direccion
            if (proximoX > 11 || proximoX < 4) {
                direccion = direccion * -1
            }
            position = game.at(position.x() + direccion, position.y())
        }
    }

    method chocarConPersonaje() {}
}