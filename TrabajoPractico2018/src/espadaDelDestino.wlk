import rolando.*

object espadaDelDestino 
{
	var property peso = 0
	var property fechaCompra 
	
	method pesoTotal() = self.peso() - self.factorDeCorreccion()
	method factorDeCorreccion() = (self.fechaCompra() / 1000).min(1)
	
	method poderDeLucha(duenio) = 3
	
}
