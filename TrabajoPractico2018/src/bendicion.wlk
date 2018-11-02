import rolando.*

object bendicion 
{
	var property personaje = rolando
	
	method poder() = self.personaje().nivelDeHechiceria()
	
	method precioRefuerzo(valorBase) = valorBase

	method peso() = 0	
}