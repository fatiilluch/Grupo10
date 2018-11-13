import Personaje.*
import hechizoBasico.*
import HechizoDeLogo.*
import refuerzos.*
import Artefacto.*

class ArmaduraGeneral inherits Artefacto
{	
	var property refuerzo = ninguno
	var property valorBase = 2
		
	method poderDeLucha(duenio) = self.valorBase() + self.refuerzo().poder()
	
	method cambiaRefuerzo(unRefuerzo) { refuerzo = unRefuerzo }
	
	method precioDeLista() = self.refuerzo().precioRefuerzo(self.valorBase())
	
	override method pesoTotal() = super() + self.refuerzo().peso()
}