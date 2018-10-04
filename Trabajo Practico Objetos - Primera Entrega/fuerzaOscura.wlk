object fuerzaOscura {
	var fuerza = 5 
	
	method poder() = fuerza
	method fuerza(nuevaFuerza) {
		fuerza = nuevaFuerza
	}
	
	method eclipse() {
		fuerza = fuerza * 2
	} 
}

//El valor de la fuerza oscura es un cálculo global 
//que afecta a todos (incluído Rolando). Por ahora, 
//la fuerza oscura tiene valor 5, pero puede cambiar 
//a lo largo del tiempo ante determinados sucesos que 
//pasen en el mundo