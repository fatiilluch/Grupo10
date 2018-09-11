object rolando {

	var valorBase = 3
	var valorDeLaFuerza
	var hechizoPreferido
	var poderDelHechizoPreferido
	const artefactos = []
	var habilidadDeLucha = 1

//Obtener el nivel de hechicería de Rolando.
	method nivel() = valorBase * poderDelHechizoPreferido / valorDeLaFuerza

//Cambiar el hechizo preferido de Rolando en cualquier momento.	
	method setHechizoPreferido(nuevoHechizoPreferido) {
		hechizoPreferido = nuevoHechizoPreferido
	}

	method poderDelHechizoPreferido() {
		poderDelHechizoPreferido = hechizoPreferido.poder()
		return poderDelHechizoPreferido
	}

	method valorDeLafuerza() {
		valorDeLaFuerza = fuerzaOscura.poder()
		return valorDeLaFuerza
	}

// Modificar a gusto el valor base de lucha de Rolando. punto 2
	
	method setHabilidadDeLucha(nuevaHabilidadDeLucha) {
		habilidadDeLucha = nuevaHabilidadDeLucha
	}

	method getHabilidadDeLucha() {
		return habilidadDeLucha
	}
	
//3. Saber el valor de lucha de Rolando.
	method habilidadDeLucha() {
		return artefactos.sum({ poder => poder.poderDeLucha() }) + habilidadDeLucha
	}

	method valorDeLucha() = habilidadDeLucha

//Averiguar si Rolando tiene mayor habilidad de lucha que nivel de hechicería.
	
	method tieneMejorHabilidadDeLucha() = habilidadDeLucha > poderDelHechizoPreferido

//Agregar y remover artefactos de Rolando.
	
	method agregaArtefacto(unArtefacto) {
		artefactos.add(unArtefacto)
	}

	method removerArtefacto(artefacto) {
		artefactos.remove(artefacto)
	}

//Saber si Rolando se cree poderoso, lo cual es cierto si su hechizo preferido lo es.	
	method seCreePoderoso() {
		return hechizoPreferido.esPoderoso()
	}

}

object espadaDelDestino {
	method poderDeLucha() = 3
}

object collarDivino {
	var perlas
	
	method poderDeLucha(cantidadDePerlas) {
		perlas = cantidadDePerlas
	}
	method poderDeLucha() = perlas

}

object mascaraOscura {
	method poderDeLucha() = 4.max(fuerzaOscura.poder() / 2)
}


//4. Representar un eclipse, lo que provoca que la fuerza de la oscuridad se duplique.
object eclipse {
	method duplicarFuerzaOscura() = fuerzaOscura.poder() * 2
}

object espectroMalefico {

	const nombre = []

	method poder() = 17

	method esPoderoso() = true

	method nombre() = nombre

//Tener la posibilidad de que el espectro maléfico cambie de nombre.
	method agregaNombre(unNombre) {
		self.agregaNombres([ unNombre ])
	}

	method agregaNombres(unosNombres) {
		self.nombre().addAll(unosNombres)
	}

}

object hechizoBasico {

	method poder() = 10
	method esPoderoso() = false

}

object fuerzaOscura {
	var fuerza = 5

	method poder() = fuerza
	method fuerza(nuevaFuerza) {
		fuerza = nuevaFuerza
	}

}

object armadura {
	var refuerzo
	
	method poderDeLucha() = 2 + refuerzo.valor()
}

object cotaDeMalla{
	method valor() = 1 
} 
	
}
