object espectroMalefico 
{
	var nombre = "Espectro Malefico"

	//Tener la posibilidad de que el espectro maléfico cambie de nombre.	
	method nombre(nuevoNombre)
	{
		nombre = nuevoNombre
	}
	method nombre() = nombre
	
	method poder() = self.nombre().size()
		
	method esPoderoso() = self.nombre().size() > 15 
}


