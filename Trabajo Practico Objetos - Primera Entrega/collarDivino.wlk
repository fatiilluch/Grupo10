import rolando.*

object collarDivino {
	
	var perlas = 5
	
	method perlas(nuevasPerlas){
		perlas = nuevasPerlas
	} 
	
	method perlas() = perlas
	
	method poderDeLucha(cantidadDePerlas) {
		perlas = cantidadDePerlas
	} 
	
	method poderDeLucha() = perlas
	
}