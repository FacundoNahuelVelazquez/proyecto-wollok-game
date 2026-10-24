import wollok.game.*
import cartas.*
import juego.*
import personaje.*
import obstaculos.*
import miniJefe.*

class PatronDeLluvia {
    method columnas() = []
}

class PatronColumnasPares inherits PatronDeLluvia {
    override method columnas() = [2, 4, 6, 8, 10, 12]
}

class PatronColumnasImpares inherits PatronDeLluvia {
    override method columnas() = [3, 5, 7, 9, 11, 13]
}

object lluviaDeCartas {
    const duracion = 100
    const primeraColumna = 2
    const cantidadColumnas = 12
    const filaDeCaida = 9
    var objetos = []
    const columnasDisponibles = []
    var jugando = false
    var cantidadLanzamientos = 0
    var cantidadPatrones = 0
    var actualizacionesDePatron = 0
    var movimientosObservados = 0
    var segundosQuieto = 0

    method estaJugando() = jugando

    method iniciar() {
        self.finalizar()
        objetos = []
        self.reponerColumnas()
        jugando = true
        cantidadLanzamientos = 0
        cantidadPatrones = 0
        actualizacionesDePatron = 0
        movimientosObservados = personaje.cantidadMovimientos()
        segundosQuieto = 0
        game.addVisual(contadorRonda)
        contadorRonda.iniciar(duracion)
        game.onTick(1000, "relojLluvia", { self.actualizarRonda() })
        game.onTick(500, "lanzamientoCartas", { self.lanzarCartas() })
        game.onTick(500, "patronesLluvia", { self.actualizarPatrones() })
        game.onTick(1000, "quietudLluvia", { self.controlarQuietud() })
        game.onTick(3000, "aparicionMonedas", { self.lanzarMoneda() })
        game.onTick(200, "movimientoLluvia", { self.actualizarObjetos() })
    }

    method actualizarRonda() {
        if (jugando) {
            contadorRonda.pasarSegundo()
            if (contadorRonda.seAcabo()) {
                self.finalizar()
                juego.detenerMiniJefe()
            }
        }
    }

    method etapaDificultad() =
        ((duracion - contadorRonda.segundosRestantes()) / 25).truncate(0)

    method controlarQuietud() {
        if (jugando) {
            if (movimientosObservados == personaje.cantidadMovimientos()) {
                segundosQuieto += 1
                if (segundosQuieto >= 4) {
                    self.lanzarCartaEn(
                        new CartaRapida(),
                        personaje.position().x(),
                        filaDeCaida
                    )
                    segundosQuieto = 0
                }
            } else {
                movimientosObservados = personaje.cantidadMovimientos()
                segundosQuieto = 0
            }
        }
    }

    method lanzarCartas() {
        if (jugando) {
            cantidadLanzamientos += 1
            self.lanzarCartaAleatoria(new CartaNormal())
            if (cantidadLanzamientos % 2 == 0) {
                self.lanzarCartaAleatoria(new CartaEspecial())
            }
            if (
                contadorRonda.segundosRestantes() <= 30 &&
                cantidadLanzamientos % 4 == 0
            ) {
                self.lanzarCartaAleatoria(new CartaEspecial())
            }
        }
    }

    method actualizarPatrones() {
        if (jugando) {
            actualizacionesDePatron += 1
            if (actualizacionesDePatron >= self.ticsEntrePatrones()) {
                actualizacionesDePatron = 0
                self.lanzarPatron()
            }
        }
    }

    method ticsEntrePatrones() = (20 - self.etapaDificultad() * 3).max(10)

    method lanzarPatron() {
        if (jugando) {
            self.siguientePatron().columnas().forEach({ columna =>
                self.lanzarCartaEn(new CartaNormal(), columna, filaDeCaida)
            })
            cantidadPatrones += 1
        }
    }

    method siguientePatron() =
        if (cantidadPatrones % 2 == 0) {
            new PatronColumnasPares()
        } else {
            new PatronColumnasImpares()
        }

    method lanzarCartaAleatoria(carta) {
        self.reponerColumnasSiHaceFalta()
        const columna = columnasDisponibles.anyOne()
        columnasDisponibles.remove(columna)
        self.lanzarCartaEn(carta, columna, filaDeCaida)
    }

    method lanzarCartaEn(carta, columna, fila) {
        self.agregarObjeto(carta, columna, fila)
    }

    method lanzarMoneda() {
        if (jugando) {
            const posicionesDisponibles = []
            (1..14).forEach({ columna =>
                (1..9).forEach({ fila =>
                    const posicion = game.at(columna, fila)
                    if (self.posicionValidaParaMoneda(posicion)) {
                        posicionesDisponibles.add(posicion)
                    }
                })
            })
            if (!posicionesDisponibles.isEmpty()) {
                const posicion = posicionesDisponibles.anyOne()
                if (self.posicionValidaParaMoneda(posicion)) {
                    self.agregarObjeto(new Moneda(), posicion.x(), posicion.y())
                }
            }
        }
    }

    method posicionValidaParaMoneda(posicion) =
        posicion.y() < miniJefe.position().y() &&
        !obstaculos.estaBloqueada(posicion) &&
        posicion != personaje.position() &&
        objetos.filter({ elemento =>
            elemento.estaActivo() && elemento.position() == posicion
        }).isEmpty()

    method agregarObjeto(objeto, columna, fila) {
        if (jugando) {
            objetos.add(objeto)
            objeto.aparecerEn(columna, fila)
        }
    }

    method reponerColumnasSiHaceFalta() {
        if (columnasDisponibles.isEmpty()) {
            self.reponerColumnas()
        }
    }

    method reponerColumnas() {
        columnasDisponibles.clear()
        (primeraColumna..(primeraColumna + cantidadColumnas - 1)).forEach({ columna =>
            columnasDisponibles.add(columna)
        })
    }

    method actualizarObjetos() {
        if (jugando) {
            const objetosActivos = objetos.filter({ objeto => objeto.estaActivo() })
            objetosActivos.forEach({ objeto => objeto.avanzar() })
            objetos = objetosActivos.filter({ objeto => objeto.estaActivo() })
        }
    }

    method finalizar() {
        jugando = false
        self.detenerTicks()
        objetos.forEach({ objeto => objeto.retirar() })
        objetos = []
        if (game.hasVisual(contadorRonda)) {
            game.removeVisual(contadorRonda)
        }
    }

    method detenerTicks() {
        game.removeTickEvent("relojLluvia")
        game.removeTickEvent("lanzamientoCartas")
        game.removeTickEvent("patronesLluvia")
        game.removeTickEvent("quietudLluvia")
        game.removeTickEvent("aparicionMonedas")
        game.removeTickEvent("movimientoLluvia")
    }
}

object contadorRonda {
    var property segundosRestantes = 0

    method text() = "Tiempo: " + segundosRestantes.toString()
    method textColor() = "FFFFFF"
    method position() = game.at(13, 11)

    method iniciar(segundos) {
        segundosRestantes = segundos
    }

    method pasarSegundo() {
        segundosRestantes -= 1
    }

    method seAcabo() = segundosRestantes == 0
}
