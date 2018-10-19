import rolando.*

object collarDivino 
{
	
	var property perlas = 5
	//var property peso = 0 
	//var property fechaCompra = 0

	//method pesoTotal() = (self.peso() - self.factorDeCorreccion()) + (self.perlas()*0.5)

	//method factorDeCorreccion() = (self.fechaCompra() / 1000).max(1)
	
	method poderDeLucha(duenio) = self.perlas()
	
	method precioDeLista (duenio) = 2 * self.perlas()
}