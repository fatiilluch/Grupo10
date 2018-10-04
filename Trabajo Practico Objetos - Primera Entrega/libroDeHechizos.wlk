import rolando.*
import hechizoBasico.*
import espectroMalefico.*

object libroDeHechizos {
	
	var property hechizos = #{}
	
	method hechizosPoderosos() = self.hechizos().forEach({artefacto => artefacto.equals(self)}).filter({artefacto => artefacto.esPoderoso()}).sum({obj => obj.poderDeLucha()})
	
	method agregaHechizo(nuevoHechizo){
		hechizos.add(nuevoHechizo)
	}
	
	// hechizos = {espectroMalefico, hechizoBasico} 
	//method poder() = self.hechizos().sum({bla => bla.poder()})
	
}

/*Por otra parte, puede suceder que Rolando 
en vez de tener un simple hechizo preferido, 
adopte como preferido un libro de hechizos, 
en el que están detallados varios hechizos. 
En este caso, el poder de hechicería 
que aporta es la sumatoria del poder de 
todos los hechizos poderosos que contenga.
*/