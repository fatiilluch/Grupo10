import rolando.*
import hechizo.*
import cotaDeMalla.*
import bendicion.*
import hechizoBasico.*
import HechizoDeLogo.*
import CotaMalla.*

object armadura
{
	var property refuerzo = ninguno
		
	method poderDeLucha(duenio) = 2 + self.refuerzo().poder()
	
	method cambiaRefuerzo(unRefuerzo) 
	{
		refuerzo = unRefuerzo
	}
	method precioDeLista(duenio) = self.refuerzo().precioRefuerzo(2)
}

object ninguno 
{ 
	method poder() = 0 

	method precioRefuerzo(valorBase, duenio) = 2
	
	method peso() = 0 
}




