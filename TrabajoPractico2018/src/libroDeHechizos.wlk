import rolando.*
import hechizoBasico.*
import espectroMalefico.*

object libroDeHechizos 
{	
	var property hechizos = []
	//var property peso = 10 
	//var property fechaCompra = 200

	//method pesoTotal() = self.peso() - self.factorDeCorreccion()

	//method factorDeCorreccion() = (self.fechaCompra() / 1000).max(1)
	
	method poder() = self.filtraLibroDeHechizos().filter({poderoso => poderoso.esPoderoso()}).sum({poder => poder.poder()})
	
	method filtraLibroDeHechizos() = self.hechizos().filter({artefacto => artefacto.equals(self).negate()})
	
	method agregaHechizo(nuevoHechizo){
		hechizos.add(nuevoHechizo)
	}
	
	method precioDeLista(duenio) = (10 * self.decimeCuantosPoderososHay()) + self.hechizos().sum({poder => poder.poder()})
		
	method decimeCuantosPoderososHay() = self.hechizos().filter({hechizo => hechizo.esPoderoso()}).size() 
	
}