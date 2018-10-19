class HechizoComercial
{
	var nombre = "Hechizo Comercial"
	var property multiplicador = 2
	
	method nombre() = nombre
	
	method nombre(nuevoNombre) {
		nombre = nuevoNombre
	}

	method poder() = self.nombre().size() * 0.2	* self.multiplicador()
	method esPoderoso() = self.poder() > 15 

	/*method peso()
	{
		if (self.poder().odd())
			return 2
		else 
			return 1
	}*/

}

