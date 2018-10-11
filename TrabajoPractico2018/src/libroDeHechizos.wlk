import rolando.*
import hechizoBasico.*
import espectroMalefico.*

object libroDeHechizos {
	
	var property hechizos = []
	
	method poder() = self.sumarPoderDeLucha(self.filtrarPoderosos(   ))
	
	method filtrarLibroDeHechizos() = self.hechizos().filter({artefacto => artefacto.equals(self)})
	
	method filtrarPoderosos() = self.filtrarLibroDeHechizos().filter({artefacto => artefacto.esPoderoso()})
	
	method sumarPoderDeLucha(lista) = self.filtrarPoderosos().sum({obj => obj.poderDeLucha()})
	
	method agregaHechizo(nuevoHechizo){
		hechizos.add(nuevoHechizo)
	}
}

//el resultado de filtrarlbro da una lista, la lista no entiende filtrarpoderosos

/*Por otra parte, puede suceder que Rolando 
en vez de tener un simple hechizo preferido, 
adopte como preferido un libro de hechizos, 
en el que están detallados varios hechizos. 
En este caso, el poder de hechicería 
que aporta es la sumatoria del poder de 
todos los hechizos poderosos que contenga.
*/