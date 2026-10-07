import wollok.game.*

object musica {
  method iniciar() {
    const musica = game.sound("sonidos\\Casino-game-ambiente1.mp3")
    musica.shouldLoop(true)
    game.schedule(500, { musica.play()} )
    keyboard.up().onPressDo({ musica.volume(1) })
    keyboard.down().onPressDo({ musica.volume(0) })
  }
}