import rolando.*
import Artefacto.* 

class CollarDivino inherits Artefacto
{
	var property perlas = 5
	
	override method pesoTotal() = super() + (self.perlas()*0.5)
	
	method poderDeLucha(duenio) = self.perlas()
	
	method precioDeLista() = 2 * self.perlas()
}