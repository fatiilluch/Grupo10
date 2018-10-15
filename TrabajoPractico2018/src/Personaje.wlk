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
	
	var property monedas = 100
	const property objetivos = [] // Cada vez que cumple un objetivo gana 10 monedas
	
	method canjeaPor (nuevoProducto) 
	{	
		var mitadMonedas = self.monedas(hechizoPreferido.precioDeLista(self) / 2)
		if (self.puedeComprarlo(nuevoProducto)) 
		{
			self.monedas(mitadMonedas + self.monedas())
			if (mitadMonedas > nuevoProducto.precioDeLista(self))
			{
				self.hechizoPreferido(nuevoProducto)
				self.monedas(self.monedas() - mitadMonedas)
			}
			else
			{
				self.hechizoPreferido(nuevoProducto)
				self.monedas(self.monedas() - nuevoProducto.precioDeLista(self))
			}
		}
	}


	method compra (artefacto)
	{
		if (self.puedeComprarlo(artefacto))
		{
			self.agregaArtefacto(artefacto)
			self.monedas((self.monedas() - artefacto.precioDeLista(self))
		}		
	}

	method puedeComprarlo(artefacto)
	{
		return !(artefacto.precioDeLista(self) >= self.monedas())
	}
	
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
	method hechizoPreferido(nuevoHechizoPreferido) 
	{
		hechizoPreferido = nuevoHechizoPreferido
	}
	
	method hechizoPreferido() = hechizoPreferido
	
	// Saber si Rolando se cree poderoso, lo cual es cierto si su hechizo preferido lo es. 1 	
	method seCreePoderoso() = hechizoPreferido.esPoderoso()
	
	// Saber el valor de lucha de Rolando. 2
	method habilidadDeLucha() = self.artefactos().sum( {poder => poder.poderDeLucha(self)} ) + self.valorBaseDeLucha()

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
	
	method mejorPoder() = self.artefactoSinEspejo().map({artefacto => artefacto.poderDeLucha(self)}).max()
}