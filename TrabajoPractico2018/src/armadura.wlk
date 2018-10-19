import rolando.*
import hechizo.*
import cotaDeMalla.*
import bendicion.*
import hechizoBasico.*
import HechizoDeLogo.*
import HechizoComercial.*
import CotaMalla.*


object armadura
{
	var property refuerzo = ninguno
	var a = 0
	var cotaMalla = new CotaMalla()
	var hechizoComercial = new HechizoComercial()
	var hechizoLogo = new HechizoDeLogo() 
	
	method poderDeLucha(duenio) = 2 + self.refuerzo().poder()
	
	method cambiaRefuerzo(unRefuerzo) {
		refuerzo = unRefuerzo
	}
	method precioDeLista(duenio)
	{
		if (self.refuerzo() == cotaMalla)
		{
			a = self.refuerzo().poder()/2
		}
		else if ((self.refuerzo() == bendicion) || (self.refuerzo() == ninguno))
		{
			a = 2
		} 
		else if (self.refuerzo() == hechizoBasico)
		{
			a = 2 + hechizoBasico.precioDeLista(duenio)
		}
		else if (self.refuerzo() == hechizoLogo)
		{
			a = 2 + hechizoLogo.precioDeLista(duenio)
		}
		else if (self.refuerzo() == hechizoComercial)
		{
			a = 2 + hechizoComercial.precioDeLista(duenio)
		}
		return a
	}
}

object ninguno 
{ 
	method poder() = 0 

	//method peso() = 0 
}




