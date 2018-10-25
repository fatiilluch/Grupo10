class HechizoDeLogo 
{
	var property nombre
	var property multiplicador
	
	method nombre () = nombre 
	
	method nombre(unNombre) 
	{
		nombre = unNombre
	}
	
	method multiplicador() = multiplicador
	
	method multiplicador(nuevoMultiplicador)
	{
		multiplicador = nuevoMultiplicador
	}
	
	method poder() = self.nombre().size() * self.multiplicador()
		
	method esPoderoso() = self.poder() > 15 

	method peso()
	{
		if (self.poder().odd())
			return 1
		else 
			return 2
	}
	
	method precioDeLista(duenio) = self.poder()	
	
	method precioRefuerzo(valorBase, duenio) = valorBase + self.precioDeLista(duenio)
}

class HechizoComercial inherits HechizoDeLogo
{
	var property multiplicadorComercial = 2
	override method poder() = self.nombre().size() * 0.2 * self.multiplicadorComercial()
}
