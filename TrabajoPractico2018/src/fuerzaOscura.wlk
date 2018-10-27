object fuerzaOscura 
{
	var fuerza = 5 
	
	method poder() = fuerza
	method fuerza(nuevaFuerza) 
	{
		fuerza = nuevaFuerza
	}
	
	method eclipse() 
	{
		fuerza = fuerza * 2
	} 
}