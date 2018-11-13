import rolando.*
import hechizoBasico.*
import espectroMalefico.*
import Artefacto.*

object libroDeHechizos inherits Artefacto
{	
	var property hechizos = []
	
	override method peso() = 0
	
	override method fechaCompra() = new Date()
	
	method poder() = self.filtraLibroDeHechizos().filter({poderoso => poderoso.esPoderoso()}).sum({poder => poder.poder()})
	
	method filtraLibroDeHechizos() = self.hechizos().filter({artefacto => artefacto.equals(self).negate()})
	
	method agregaHechizo(nuevoHechizo)
	{
		hechizos.add(nuevoHechizo)
	}
	
	method precioDeLista() = (10 * self.decimeCuantosPoderososHay()) + self.hechizos().sum({poder => poder.poder()})
		
	method decimeCuantosPoderososHay() = self.hechizos().filter({hechizo => hechizo.esPoderoso()}).size() 
}