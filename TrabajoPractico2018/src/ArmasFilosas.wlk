import fuerzaOscura.*

class ArmaFilosa 
{	
	var property peso
	var property fechaCompra 
	var property fechaHoy = new Date()
	
	method fechaCompra(dia,mes,anio) = new Date(dia,mes,anio)

	method poderDeLucha(duenio) = 3
	
	method precioDeLista(duenio) = 5 * self.pesoTotal(duenio)
		
	method pesoTotal(duenio) = self.peso() - self.factorDeCorreccion()
	
	method factorDeCorreccion() = (self.diasDesdeQueSeComproElArtefacto()/1000).min(1)
	
	method diasDesdeQueSeComproElArtefacto() = self.fechaHoy() - self.fechaCompra()
}

class Espada inherits ArmaFilosa {}

class Hacha inherits ArmaFilosa {}
 
class Lanza inherits ArmaFilosa {} 


/*Por ejemplo, un artefacto que tiene 700 días de comprado 
restará 0,7 kg. del peso, un artefacto nuevo no resta nada 
y un artefacto que tiene 2.500 días de comprado restará 1 kg.*/
	