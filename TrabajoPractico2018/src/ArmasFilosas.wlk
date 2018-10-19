import fuerzaOscura.*

class ArmaFilosa 
{	
	method poderDeLucha(duenio) = 3
	
	method precioDeLista(duenio) = 5 * self.poderDeLucha(duenio)
		
	//method pesoTotal() = 0
}

class Espada inherits ArmaFilosa {}

class Hacha inherits ArmaFilosa {}
 
class Lanza inherits ArmaFilosa {} 


	