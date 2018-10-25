import rolando.*
import hechizoBasico.*
import espectroMalefico.*

object libroDeHechizos 
{	
	var property hechizos = []
	var property peso = 0
	
	var property fechaCompra
	var property fecha = new Date()

	method diasDesdeQueSeComproElArtefacto() = self.fechaCompra() - self.fecha() // ver una manera de convertir esta fehca en un nro

	method pesoTotal(duenio) = self.peso() - self.factorDeCorreccion()

	method factorDeCorreccion() = (self.diasDesdeQueSeComproElArtefacto() / 1000).min(1)
	
	method poder() = self.filtraLibroDeHechizos().filter({poderoso => poderoso.esPoderoso()}).sum({poder => poder.poder()})
	
	method filtraLibroDeHechizos() = self.hechizos().filter({artefacto => artefacto.equals(self).negate()})
	
	method agregaHechizo(nuevoHechizo)
	{
		hechizos.add(nuevoHechizo)
	}
	
	method precioDeLista(duenio) = (10 * self.decimeCuantosPoderososHay()) + self.hechizos().sum({poder => poder.poder()})
		
	method decimeCuantosPoderososHay() = self.hechizos().filter({hechizo => hechizo.esPoderoso()}).size() 
	
}