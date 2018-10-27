import Personaje.*
import Mascara.*

class Npcs inherits Personaje 
{	
	var property nivel
	override method habilidadDeLucha() = (self.artefactos().sum({poder => poder.poderDeLucha(self)}) + self.valorBaseDeLucha()) * self.nivel().estado()
}

object facil 
{
	method estado() = 1
}

object medio 
{
	method estado() = 2
}

object dificil 
{
	method estado() = 4
}

