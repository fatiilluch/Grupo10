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
	var property valorBaseHechiceria = 3
	var property valorBaseDeLucha = 1
	var property hechizoPreferido = new HechizoDeLogo()
	const property artefactos = []
	var property monedas = 100
	const property capacidadMaximaDeCarga   
	var property pesoTotal = 0 //peso total de los artefactos
	var property pesoCargado = 0 //peso que esta cargando la persona
	var property espacioLibre = 0 
	const property objetivos = [] 
	
	method canjeaPor(nuevoProducto) 
	{
		var mitadMonedas = self.hechizoPreferido().precioDeLista() / 2 	
		if (self.podesComprarlo(nuevoProducto).negate())
		{
			throw new ExcepcionPorFaltaDeArticulo("No se puede adquirir este articulo")
		}
		var costo = nuevoProducto.precioDeLista() - mitadMonedas
		self.restaMonedas(costo.max(0))
		self.hechizoPreferido(nuevoProducto)
	}
	method restaMonedas(cantidad) 
	{
		self.monedas((self.monedas() - cantidad).max(0))
		return self.monedas()
	}
	method espacioLibre() = self.capacidadMaximaDeCarga() - self.pesoCargado() 
	
	method podesCargarlo(objeto) = self.pesoCargado() < self.capacidadMaximaDeCarga() && objeto.peso() <= self.espacioLibre()
		
	method compra(artefacto, comerciante)
	{
		if (self.podesComprarlo(artefacto).negate()) 
		{
			throw new ExcepcionPorFaltaDeArticulo ("No se puede adquirir este articulo")
		}
		self.agregaArtefacto(artefacto)
		self.monedas(self.monedas() - artefacto.precioDeLista() - comerciante.cobrarImpuesto(artefacto))
	}
		
	method lasMonedasSonNegativas() = self.monedas() < 0
	
	method podesComprarlo(artefacto) = artefacto.precioDeLista() <= self.monedas()
		
	method nivelDeHechiceria() = self.valorBaseHechiceria() * self.hechizoPreferido().poder() + fuerzaOscura.poder()
	 	
	method seCreePoderoso() = hechizoPreferido.esPoderoso()
	
	method habilidadDeLucha() = self.artefactos().sum( {poder => poder.poderDeLucha(self)} ) + self.valorBaseDeLucha()

	method agregaArtefacto(unArtefacto)
	{
		if (self.podesCargarlo(unArtefacto).negate())
		{
			throw new ExcepcionPorExcesoDePeso ("Este articulo supera el maximo Permitido")
		}
		self.artefactos().add(unArtefacto) 
		self.pesoCargado(self.pesoCargado() + unArtefacto.peso())
		self.espacioLibre(self.capacidadMaximaDeCarga() - self.pesoCargado())
	}

	method removeArtefacto(artefacto) {
		self.artefactos().remove(artefacto)
		self.pesoCargado(self.pesoCargado() - artefacto.peso())
		self.espacioLibre(self.espacioLibre() + artefacto.peso())
	}
	method removeTodosLosArtefactos() { self.artefactos().forEach({artefacto => self.removeArtefacto(artefacto)}) }
	
	method pesoTotal() = self.artefactos().sum({artefacto => artefacto.peso()})
	
	method masLuchaQueHechiceria() = self.habilidadDeLucha() < self.nivelDeHechiceria()
	
	method estaCargado() = self.artefactos().size() >= 5
	
	method mejorPoderDeLucha() {
		if(self.artefactoSinEspejo().isEmpty()){
			return 0
		}
		else {
			return self.mejorPoder()
		}
	}
	method artefactoSinEspejo() = self.artefactos().filter({elemento => elemento.equals(espejo).negate()})
	method mejorPoder() = self.artefactoSinEspejo().map({artefacto => artefacto.poderDeLucha(self)}).max()
}
class ExcepcionPorFaltaDeArticulo inherits Exception {}
class ExcepcionPorExcesoDePeso inherits Exception {}
class ExcepcionPorMonedasNegativas inherits Exception {}