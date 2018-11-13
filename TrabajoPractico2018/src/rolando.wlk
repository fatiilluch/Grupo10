import espectroMalefico.*
import hechizoBasico.*
import fuerzaOscura.*
import CollarDivino.*
import espadaDelDestino.*
import mascaraOscura.*
import refuerzos.*
import armadura.*
import espejo.*

object rolando 
{
	var valorBaseHechiceria = 3
	var valorBaseDeLucha = 1
	var hechizoPreferido = espectroMalefico
	const property artefactos = []
	
	// Modificar a gusto el valor base de lucha de Rolando.	
	method valorBaseHechiceria(nuevoValorBase)
	{
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
	method habilidadDeLucha() = self.artefactos().sum( {poder => poder.poderDeLucha(self)} ) + self.valorBaseDeLucha()

	// Agregar y remover artefactos de Rolando. 2
	method agregaArtefacto(unArtefacto) 
	{
		artefactos.add(unArtefacto)
	}

	method removeArtefacto(artefacto) 
	{
		artefactos.remove(artefacto)
	}
	
	method removeTodosLosArtefactos() 
	{
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
	
	method mejorPoder() = self.artefactoSinEspejo().map({artefacto => artefacto.poderDeLucha(self)}).max()
}