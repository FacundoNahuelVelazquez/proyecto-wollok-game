import wollok.game.*
import cartas.*
import juego.*       // <-- IMPORTANTE PARA SABER DÓNDE ESTAMOS
import escenarios.*  // <-- IMPORTANTE PARA SABER CUÁL ES EL TABLERO DE PELEA

object miniJefe {
    var property position = game.at(6, 7)
    var direccion = 1
    var estaAtacando = false

    method image() = "mini-jefe-crupier\\crupier-mini-jefe-chiquito.png"

    method iniciarAtaque() {
        if (not estaAtacando) {
            estaAtacando = true
            game.onTick(500, "movimiento_jefe", { self.mover() })
            game.onTick(1500, "lanzar_carta", { self.lanzarCarta() })
        }
    }

    method detenerAtaque() {
        if (estaAtacando) {
            // Intentamos frenarlo
            game.removeTickEvent("movimiento_jefe")
            game.removeTickEvent("lanzar_carta")
            estaAtacando = false
        }
    }

    method mover() {
        // CANDADO: Solo hace esto si realmente estamos en la pelea
        if (juego.estaEn(escenarioPelea)) {
            var proximoX = position.x() + direccion
            if (proximoX >= game.width() - 1 or proximoX <= 0) {
                direccion = direccion * -1
            }
            position = game.at(position.x() + direccion, position.y())
        }
    }

    method lanzarCarta() {
        // CANDADO: Solo instancia y tira cartas si estamos en la pelea
        if (juego.estaEn(escenarioPelea)) {
            const esEspecial = (1..10).anyOne() > 8 
            const nuevaCarta = if (esEspecial) new CartaEspecial(position = position) else new CartaNormal(position = position)
            
            game.addVisual(nuevaCarta)
            nuevaCarta.iniciarCaida()
        }
    }
    
    method chocarConPersonaje() {} 
}