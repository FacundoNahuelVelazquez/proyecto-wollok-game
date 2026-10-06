import wollok.game.*

object musica {
  method iniciar() {
    const musica = game.sound("sonidos\\Casino-Game-Ambiente.mp3")
    musica.shouldLoop(true)
    game.schedule(500, { musica.play()} )
    keyboard.up().onPressDo({ musica.volume(1) })
    keyboard.down().onPressDo({ musica.volume(0) })
  }
}