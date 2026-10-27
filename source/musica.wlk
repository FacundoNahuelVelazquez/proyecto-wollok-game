import wollok.game.*


// object musica {
//   method iniciar() {
//     const musica = game.sound("sonidos\\Casino-game-ambiente1.mp3")
//     musica.shouldLoop(true)
//     game.schedule(500, { musica.play()} )
//     keyboard.up().onPressDo({ musica.volume(1) })
//     keyboard.down().onPressDo({ musica.volume(0) })
//   }
// }


// musica para cada mapa
// habria que agregar musica para vasos.wlk. jefe-final.wlk y dados.wlk 
// prototipo de cancion para probar su funcionalidad

object sinMusica {
    method stop() {}
    method volume(valor) {}
}

object musica {
    var pista = sinMusica
    var archivoActual = ""
    var volumen = 1

    method iniciar() {
        keyboard.up().onPressDo({ self.cambiarVolumen(1) })
        keyboard.down().onPressDo({ self.cambiarVolumen(0) })
    }

    method cambiarVolumen(nuevo) {
        volumen = nuevo
        pista.volume(volumen)
    }

    method cambiarA(archivo) {
        [archivo].filter({ a => not (a == archivoActual) }).forEach({ a => self.reproducir(a) })
    }

    method reproducir(archivo) {
        archivoActual = archivo
        pista.stop()
        pista = game.sound(archivo)
        pista.shouldLoop(true)
        pista.volume(volumen)
        game.schedule(500, { pista.play() })
    }
}