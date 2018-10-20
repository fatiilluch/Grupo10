import fuerzaOscura.*
import collarDivino.*
import espadaDelDestino.*
import ArmaduraGeneral.*
import espejo.*
import HechizoDeLogo.*
import Comerciante.*
import Mascara.*
import hechizoBasico.*
import bendicion.*
import ArmasFilosas.*
import CotaMalla.*
import armadura.*
import libroDeHechizos.*

class Personaje 
{
	var valorBaseHechiceria = 3
	var valorBaseDeLucha = 1
	var hechizoPreferido = new HechizoDeLogo()
	const property artefactos = []
	
	var property monedas = 100
	
	//const property objetivos = [] // Cada vez que cumple un objetivo gana 10 monedas

	//var property cantidadMaximaDeCarga = 0

	//var comerciante = new Comerciante() 
	
	method canjeaPor(nuevoProducto) 
	{
		var mitadMonedas = self.hechizoPreferido().precioDeLista(self) / 2 	
		
		if (self.podesComprarlo(nuevoProducto).negate()) 
		{
			throw new ExcepcionPorFaltaDeMonedas("No puede adquirir este producto")
		}
		
		var costo = nuevoProducto.precioDeLista(self) - mitadMonedas
		
		self.restaMonedas(costo.max(0))
		
		self.hechizoPreferido(nuevoProducto)
	}
	
	method restaMonedas(cantidad) 
	{
		self.monedas((self.monedas() - cantidad).max(0))
		return self.monedas()
	}
	
	//method puedeCargarlo(objeto)
	//{
	//	return !(objeto.pesoTotal() >= self.cantidadMaximaDeCarga())
	//}

	method compra(artefacto)
	{
		if (self.podesComprarlo(artefacto).negate())
		{
			throw new ExcepcionPorFaltaDeMonedas("No puede Comprar este Artefacto")
		}
		self.agregaArtefacto(artefacto)
		self.monedas((self.monedas() - artefacto.precioDeLista(self)))
	}

	method podesComprarlo(artefacto) = artefacto.precioDeLista(self) <= self.monedas()
	
	// Modificar a gusto el valor base de lucha de Rolando.	
	method valorBaseHechiceria(nuevoValorBase)
	{
		valorBaseHechiceria = nuevoValorBase
	}
	
	method valorBaseHechiceria() = valorBaseHechiceria
	
	method valorBaseDeLucha(nuevoValorDeLucha)
	{
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
	method agregaArtefacto(unArtefacto) 
	{
		//if (self.puedeCargarlo(unArtefacto))
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


class ExcepcionPorFaltaDeMonedas inherits Exception {}