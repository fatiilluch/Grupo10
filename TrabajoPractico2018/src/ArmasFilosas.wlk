import fuerzaOscura.*

class ArmaFilosa 
{	
	method poderDeLucha() = 3	
}

class Espada inherits ArmaFilosa {}

class Hacha inherits ArmaFilosa {}
 
class Lanza inherits ArmaFilosa {} 

class MascaraOscura {
	
	var property indiceDeOscuridad = 0
	
	var property minimoDePoder = 4 
	
	method poderDeLucha() = self.minimoDePoder().max((fuerzaOscura.poder()/2) * self.indiceDeOscuridad())
}

	
	