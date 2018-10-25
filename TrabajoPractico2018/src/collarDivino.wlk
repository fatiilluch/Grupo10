import rolando.*

object collarDivino 
{
	var property perlas = 5
	
	var property peso = 0 
	var property fechaCompra = new Date()
	var property fechaHoy = new Date()
	
	method fechaCompra (dia,mes,anio) = new Date(dia,mes,anio)

	method pesoTotal(duenio) = (self.peso() - self.factorDeCorreccion()) + (self.perlas()*0.5)

	method factorDeCorreccion() = (self.diasDesdeQueSeComproElArtefacto() / 1000).min(1)
	
	method diasDesdeQueSeComproElArtefacto() = self.fechaHoy() - self.fechaCompra()
	
	method poderDeLucha(duenio) = self.perlas()
	
	method precioDeLista (duenio) = 2 * self.perlas()
	
	
	
	
}