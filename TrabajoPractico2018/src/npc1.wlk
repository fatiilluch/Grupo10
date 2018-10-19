import Personaje.*

class Npcs inherits Personaje 
{	
	//override method habilidadDeLucha() = (((self.artefactos().sum( {poder => poder.poderDeLucha(self)} ) + self.valorBaseDeLucha()) * Nivel.estadoNivel().estado()}
}

class Nivel 
{
	var property estadoNivel = facil
}

object facil 
{
	method estado() = 1
}

object dificil 
{
	method estado() = 4
}

object medio 
{
	method estado() = 2
}
