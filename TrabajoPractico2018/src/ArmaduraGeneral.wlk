import Personaje.*
import CotaMalla.*
import bendicion.*
import hechizoBasico.*
import HechizoDeLogo.*
import HechizoComercial.*
import armadura.*

class ArmaduraGeneral 
{
	
	var property refuerzo
	var property valorBase = 2
	var a = 0
	var cotaMalla = new CotaMalla()
	var hechizoComercial = new HechizoComercial()
	var hechizoLogo = new HechizoDeLogo() 
	//var property peso = 10
	//var property fechaCompra = 100
	
	method poderDeLucha(duenio) = self.refuerzo().poder()
	
	method cambiaRefuerzo(unRefuerzo) {
		refuerzo = unRefuerzo
	}
	
	method precioDeLista(duenio)
	{
		if (self.refuerzo() == cotaMalla)
		{
			a = self.refuerzo().poder()/2
		}
		else if (self.refuerzo() == bendicion )
		{
			a = self.valorBase()
		} 
		else if (self.refuerzo() == hechizoBasico)
		{
			a = self.valorBase() + hechizoBasico.precioDeLista(duenio)
		}
		else if (self.refuerzo() == hechizoLogo)
		{
			a = self.valorBase() + hechizoLogo.precioDeLista(duenio)
		}
		else if (self.refuerzo() == hechizoComercial)
		{
			a = self.valorBase() + hechizoComercial.precioDeLista(duenio)
		}
		else if (self.refuerzo() == ninguno)
		{
			a = 2
		}
		
		return a
	}

	//method pesoTotal() = (self.peso() - self.factorDeCorreccion()) + self.refuerzo().peso()

	//method factorDeCorreccion() = (self.fechaCompra() / 1000).max(1)

	
}
 