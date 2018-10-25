import rolando.*

object espejo 
{
	var property peso = 0 
		
	var property fechaCompra
	var property fecha = new Date()

	method diasDesdeQueSeComproElArtefacto() = self.fechaCompra() - self.fecha() // ver una manera de convertir esta fehca en un nro

	method pesoTotal(duenio) = self.peso() - self.factorDeCorreccion()

	method factorDeCorreccion() = (self.diasDesdeQueSeComproElArtefacto() / 1000).min(1)

	method poderDeLucha(duenio) = duenio.mejorPoderDeLucha() 
	
	method precioDeLista(duenio) = 90
}
