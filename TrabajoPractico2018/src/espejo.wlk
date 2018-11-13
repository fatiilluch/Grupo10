import rolando.*
import Artefacto.*

object espejo inherits Artefacto
{		 
	override method fechaCompra() = new Date() 
	
	override method peso() = 0
	
	method poderDeLucha(duenio) = duenio.mejorPoderDeLucha() 
	
	method precioDeLista() = 90
}
