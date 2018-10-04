import rolando.*
import hechizo.*
import cotaDeMalla.*
import bendicion.*

object armadura
{
	var property refuerzo = ninguno 
	
	method poderDeLucha() = 2 + self.refuerzo().unidadesDeLucha()
	
	method cambiaRefuerzo(unRefuerzo) {
		refuerzo = unRefuerzo
	}
}

object ninguno 
{ 
	method unidadesDeLucha() = 0 
}




