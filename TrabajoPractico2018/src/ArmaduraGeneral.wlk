import Personaje.*

class ArmaduraGeneral {
	
	var property refuerzo
	var property valorBase = 2
	
	method poderDeLucha() = self.refuerzo().unidadesDeLucha()
	
	method cambiaRefuerzo(unRefuerzo) {
		refuerzo = unRefuerzo
	}
}
 
 