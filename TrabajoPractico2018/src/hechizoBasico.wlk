object hechizoBasico 
{
	var nombre = "Hechizo Basico"
	
	method nombre() = nombre
	
	method nombre(nuevoNombre) 
	{
		nombre = nuevoNombre
	}

	method poder() = 10		
	method esPoderoso() = false 
	
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
