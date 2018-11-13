import fuerzaOscura.*
import Artefacto.*

class MascaraOscura inherits Artefacto
{
	var property indiceDeOscuridad = 0
	var property minimoDePoder = 4 
	
	var property resultado = 0
	
	override method pesoTotal() = super()  + (self.poderDeLucha(0) - 3).max(0)

	method poderDeLucha(duenio) = self.minimoDePoder().max((fuerzaOscura.poder()/2) * self.indiceDeOscuridad())
	
	method precioDeLista() = 10 * self.indiceDeOscuridad()
}