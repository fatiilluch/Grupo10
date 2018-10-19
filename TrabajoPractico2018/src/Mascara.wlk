import fuerzaOscura.*

class MascaraOscura 
{
	//var property peso = 0
	//var property fechaCompra = 300
	var property indiceDeOscuridad = 0
	var property minimoDePoder = 4 
	
	method poderDeLucha(duenio) = self.minimoDePoder().max((fuerzaOscura.poder()/2) * self.indiceDeOscuridad())

	//method pesoTotal() = self.peso() - self.factorDeCorreccion()

	//method factorDeCorreccion() = (self.fechaCompra() / 1000).max(1)
}

	