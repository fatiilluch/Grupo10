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
import Comerciante.*

class Personaje 
{
	var valorBaseHechiceria = 3
	var valorBaseDeLucha = 1
	var hechizoPreferido = new HechizoDeLogo()
	const property artefactos = []
	
	var property monedas = 100
	
	const property capacidadMaximaDeCarga   
	
	var property espacioLibre = 0
	
	var property pesoTotal = 0
	var property pesoCargado = 0
	
	//const property objetivos = [] // Cada vez que cumple un objetivo gana 10 monedas

	//var comerciante = new Comerciante() 
	
	method canjeaPor(nuevoProducto) 
	{
		var mitadMonedas = self.hechizoPreferido().precioDeLista(self) / 2 	
		
		if (self.podesComprarlo(nuevoProducto).negate()) 
		{
			throw new ExcepcionPorFaltaDeArticulo("No puede adquirir este producto")
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
	
	method podesCargarlo(objeto) =
			objeto.pesoTotal(self) <= self.capacidadMaximaDeCarga() &&
		self.espacioLibre(capacidadMaximaDeCarga) <= self.capacidadMaximaDeCarga()
		
	method compra(artefacto, comerciante)
	{
		if (self.podesComprarlo(artefacto).negate() || comerciante.tieneElArtefacto(artefacto).negate())
		{
			throw new ExcepcionPorFaltaDeArticulo ("No se puede adquirir este articulo")
		}
		self.agregaArtefacto(artefacto)
		self.pagar(artefacto.precioDeLista(self),comerciante)
	}
	
	method pagar(precio, comerciante) 
	{
		self.monedas(self.monedas() - precio - comerciante.cobrarImpuesto(precio))
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
		/*if (self.podesCargarlo(unArtefacto).negate())
		{
			throw new ExcepcionPorExcesoDePeso("Es mucha carga, no puede cargarlo")
		}*/
		artefactos.add(unArtefacto) 
		self.pesoCargado(self.pesoCargado() + unArtefacto.peso())
	}

	method removeArtefacto(artefacto) 
	{
		artefactos.remove(artefacto)
		self.pesoCargado(self.pesoCargado() - artefacto.pesoTotal(self))
	}
	
	method removeTodosLosArtefactos() 
	{
		self.artefactos().forEach({artefacto => self.removeArtefacto(artefacto)})
	}
	
	method pesoTotal() = self.artefactos().sum({artefacto => artefacto.peso()})
	
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

class ExcepcionPorFaltaDeArticulo inherits Exception {}

class ExcepcionPorExcesoDePeso inherits Exception {}