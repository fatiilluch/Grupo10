object hechizoBasico 
{
	var nombre = "Hechizo Basico"
	
	method nombre() = nombre
	
	method nombre(nuevoNombre) {
		nombre = nuevoNombre
	}

	method poder() = 10		
	method esPoderoso() = false 
	
	method precioDeLista(duenio) = 10

	/*method peso()
	{
		if (self.poder().odd())
			return 2
		else 
			return 1
	}*/
}
