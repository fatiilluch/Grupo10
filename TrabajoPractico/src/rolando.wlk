import espectroMalefico.*
import hechizoBasico.*
import fuerzaOscura.*
import collarDivino.*
import espadaDelDestino.*
import mascaraOscura.*

object rolando {
	var valorBase = 3
	var hechizoPreferido = espectroMalefico
	const property artefactos = []
	
	// Modificar a gusto el valor base de lucha de Rolando.	
	method valorBase(nuevoValorBase){
		valorBase = nuevoValorBase
	}
	
	method valorBase() = valorBase 

	//Obtener el nivel de hechicería de Rolando. 1	
	method nivelDeHechiceria() = self.valorBase() * self.hechizoPreferido().poder() + fuerzaOscura.poder()

	//Cambiar el hechizo preferido de Rolando en cualquier momento. 1	
	method hechizoPreferido(nuevoHechizoPreferido) {
		hechizoPreferido = nuevoHechizoPreferido
	}
	
	method hechizoPreferido() = hechizoPreferido
	
	// Saber si Rolando se cree poderoso, lo cual es cierto si su hechizo preferido lo es. 1 	
	method seCreePoderoso() = hechizoPreferido.esPoderoso()
	
	// duplicarFuerzaOscura 1
	method eclipse() = fuerzaOscura.poder() * 2
	
	// Saber el valor de lucha de Rolando. 2
	method habilidadDeLucha() {
		self.valorBase(1)
		return (self.artefactos().sum({ poder => poder.poderDeLucha() }) + self.valorBase())
	}

	// Agregar y remover artefactos de Rolando. 2
	method agregaArtefacto(unArtefacto) {
		artefactos.add(unArtefacto)
	}

	method removerArtefacto(artefacto) {
		artefactos.remove(artefacto)
	}
	
	method removerTodosLosArtefactos() {
		self.artefactos().forEach({artefacto => self.removerArtefacto(artefacto)})
	}
	
	// Averiguar si Rolando tiene mayor habilidad de lucha que nivel de hechicería. 2
	method masLuchaQueHechiceria() = self.habilidadDeLucha() < self.nivelDeHechiceria()
}
	
	 