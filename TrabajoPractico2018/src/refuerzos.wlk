import rolando.*
import cotaDeMalla.*
import bendicion.*
import hechizoBasico.*
import HechizoDeLogo.*

object ninguno 
{ 
	method poder() = 0 
	method precioRefuerzo(valorBase) = 2
	method peso() = 0 
}

class CotaMalla 
{	
	var property poder
	method precioRefuerzo(valorBase) = self.poder()/2
	method peso() = 1
}

object bendicion 
{
	var property personaje = rolando

	method poder() = self.personaje().nivelDeHechiceria()
	method precioRefuerzo(valorBase) = valorBase
	method peso() = 0	
}
