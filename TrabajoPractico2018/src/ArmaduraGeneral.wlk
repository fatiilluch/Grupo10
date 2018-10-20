import Personaje.*
import CotaMalla.*
import bendicion.*
import hechizoBasico.*
import HechizoDeLogo.*
import armadura.*

class ArmaduraGeneral 
{	
	var property refuerzo
	var property valorBase = 2
		//var property peso = 10
	//var property fechaCompra = 100
	
	method poderDeLucha(duenio) = self.valorBase() + self.refuerzo().poder()
	
	method cambiaRefuerzo(unRefuerzo) 
	{
		refuerzo = unRefuerzo
	}
	
	method precioDeLista(duenio) = self.refuerzo().precioRefuerzo(self.valorBase(),duenio)
	
	//method pesoTotal() = (self.peso() - self.factorDeCorreccion()) + self.refuerzo().peso()

	//method factorDeCorreccion() = (self.fechaCompra() / 1000).max(1)
}
 