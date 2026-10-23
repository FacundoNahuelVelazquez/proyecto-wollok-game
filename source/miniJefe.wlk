import wollok.game.*
import cartas.*


object miniJefe {
    var property position = game.at(6, 7)
    var direccion = 1 // 1 derecha, -1 izquierda
    var estaAtacando = false 
    
    method image() = "mini-jefe-crupier\\crupier-mini-jefe-chiquito.png"

    method iniciarAtaque() {
        game.onTick(500, "movimiento_jefe", { self.mover() }) // se mueve cada medio segundo

        game.onTick(1000, "lanzar_carta", { self.lanzarCarta() }) // tira una carta cada un segundo y medio
    }

    method detenerAtaque() {
        if (estaAtacando) {
            game.removeTickEvent("movimiento_jefe")
            game.removeTickEvent("lanzar_carta")
            estaAtacando = false
        }
    }

    method mover() {
        var proximoX = position.x() + direccion

        if (proximoX >= game.width() - 1 or proximoX <= 0) {
            direccion = direccion * -1
        }
        position = game.at(position.x() + direccion, position.y())
    }

    method lanzarCarta() {
        const esEspecial = (1..10).anyOne() > 8 // 20% de probabilidad de carta especial
        const nuevaCarta = if (esEspecial) new CartaEspecial(position = position) else new CartaNormal(position = position)
        
        game.addVisual(nuevaCarta)
        nuevaCarta.iniciarCaida()
    }
    

    // Método vacío por si el personaje choca el cuerpo del jefe (para que no rompa el juego)
    method chocarConPersonaje() {}
}
