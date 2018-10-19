class HechizoDeLogo 
{
	var nombre
	var multiplicador
	
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

	/*method peso()
	{
		if (self.poder().odd())
			return 2
		else 
			return 1
	}*/
	
	method precioDeLista(duenio) = self.poder()	
}
