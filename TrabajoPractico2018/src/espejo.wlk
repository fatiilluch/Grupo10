import rolando.*

object espejo 
{
	var property peso = 0 
		
	var property fechaCompra = new Date()
	var property fecha = new Date()

	method diasDesdeQueSeComproElArtefacto() = self.fechaCompra() - self.fecha() 

	method pesoTotal(duenio) = self.peso() - self.factorDeCorreccion()

	method factorDeCorreccion() = (self.diasDesdeQueSeComproElArtefacto() / 1000).min(1)

	method poderDeLucha(duenio) = duenio.mejorPoderDeLucha() 
	
	method precioDeLista() = 90
}
