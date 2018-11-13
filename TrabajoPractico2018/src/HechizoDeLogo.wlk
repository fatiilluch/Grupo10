class Hechizos 
{	
	var property nombre
	var property multiplicador
		
	method poder() = self.nombre().size() 
	method esPoderoso() = self.poder() > 15 
	
	method precioDeLista() = self.poder() 
	
	method peso()
	{
		if (self.poder().odd())
			return 1
		else 
			return 2
	}
	
	method precioRefuerzo(valorBase) = valorBase + self.precioDeLista()
}

class HechizoDeLogo inherits Hechizos 
{		
	override method poder() = super() * self.multiplicador()	
}

class HechizoComercial inherits HechizoDeLogo
{
	override method poder() = super() * 0.2
}
