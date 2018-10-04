import rolando.*

object espejo{
	
	var espejo = 0
	
	method mejorPertenencia(){
			espejo = rolando.artefactos().max( { polenta => polenta.poderDeLucha()} ).poderDeLucha()
	}
	
	method poderDeLucha() = espejo
	
}

/* 
object espejo {
	var duenio = rolando
	
	method poderDeLucha() 
	{
		if (self.estaEnElEspejo())
		{
			return self.elPoderMaximoDeLaListaDeArtefactos()
		}
		else
		{
			return 0
		}
	}	
	
	method estaEnElEspejo() = duenio.artefactos().forEach({artefacto => artefacto.equals(self)})
	
	method elPoderMaximoDeLaListaDeArtefactos() = duenio.artefactos().max{artefacto => artefacto.poderDeLucha()}
}	*/
