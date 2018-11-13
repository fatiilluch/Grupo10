import rolando.*
import cotaDeMalla.*
import hechizoBasico.*
import HechizoDeLogo.*
import refuerzos.*

object armadura
{
	var property refuerzo = ninguno
		
	method poderDeLucha(duenio) = 2 + self.refuerzo().poder()
	
	method cambiaRefuerzo(unRefuerzo) 
	{
		refuerzo = unRefuerzo
	}
	method precioDeLista() = self.refuerzo().precioRefuerzo(2)
}

