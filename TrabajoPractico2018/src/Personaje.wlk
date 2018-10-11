import fuerzaOscura.*
import collarDivino.*
import espadaDelDestino.*
import mascaraOscura.*
import armadura.*
import espejo.*
import HechizoDeLogo.*

class Personaje 
{
	var valorBaseHechiceria = 3
	var valorBaseDeLucha = 1
	var hechizoPreferido = new HechizoDeLogo()
	const property artefactos = []
	
	// Modificar a gusto el valor base de lucha de Rolando.	
	method valorBaseHechiceria(nuevoValorBase){
		valorBaseHechiceria = nuevoValorBase
	}
	
	method valorBaseHechiceria() = valorBaseHechiceria
	
	method valorBaseDeLucha(nuevoValorDeLucha){
		valorBaseDeLucha = nuevoValorDeLucha
	}
	method valorBaseDeLucha() = valorBaseDeLucha

	//Obtener el nivel de hechicería de Rolando. 1	
	method nivelDeHechiceria() = self.valorBaseHechiceria() * self.hechizoPreferido().poder() + fuerzaOscura.poder()

	//Cambiar el hechizo preferido de Rolando en cualquier momento. 1	
	method hechizoPreferido(nuevoHechizoPreferido) {
		hechizoPreferido = nuevoHechizoPreferido
	}
	
	method hechizoPreferido() = hechizoPreferido
	
	// Saber si Rolando se cree poderoso, lo cual es cierto si su hechizo preferido lo es. 1 	
	method seCreePoderoso() = hechizoPreferido.esPoderoso()
	
	// Saber el valor de lucha de Rolando. 2
	method habilidadDeLucha() = self.artefactos().sum( {poder => poder.poderDeLucha()} ) + self.valorBaseDeLucha()

	// Agregar y remover artefactos de Rolando. 2
	method agregaArtefacto(unArtefacto) {
		artefactos.add(unArtefacto)
	}

	method removeArtefacto(artefacto) {
		artefactos.remove(artefacto)
	}
	
	method removeTodosLosArtefactos() {
		self.artefactos().forEach({artefacto => self.removeArtefacto(artefacto)})
	}
	
	// Averiguar si Rolando tiene mayor habilidad de lucha que nivel de hechicería. 2
	method masLuchaQueHechiceria() = self.habilidadDeLucha() < self.nivelDeHechiceria()
	
	method estaCargado() = self.artefactos().size() >= 5
	
	method mejorPoderDeLucha() 
	{
		if(self.artefactoSinEspejo().isEmpty())
		{
			return 0
		}
		else
		{
			return self.mejorPoder()
		}
	}
	
	method artefactoSinEspejo() = self.artefactos().filter({elemento => elemento.equals(espejo).negate()})
	
	method mejorPoder() = self.artefactoSinEspejo().max({artefacto => artefacto.poderDeLucha()})
	
}
	
	
 
/*Además del maléfico hay muchos otros hechizos a los que llamamos de "logos", 
cada uno con su propio nombre. El poder de hechicería es un múltiplo 
de la cantidad de letras de su nombre, donde el valor por el cual 
se multiplica puede variar de hechizo en hechizo. La forma de saber 
si es poderoso sigue siendo si su poder es mayor a 15. 
Se confirma que la fuerza oscura es única para todo el juego y 
que si su valor cambia, afecta el poder de hechicería de todos los personajes existentes.*/



