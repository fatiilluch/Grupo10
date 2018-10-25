import Personaje.*
import CotaMalla.*
import bendicion.*
import hechizoBasico.*
import HechizoDeLogo.*
import armadura.*

class ArmaduraGeneral 
{	
	var property refuerzo
	var property valorBase = 2
	var property peso
	var property fechaCompra 
	var property fechaHoy = new Date()
	
	method fechaCompra(dia,mes,anio) = new Date(dia,mes,anio)
	
	method poderDeLucha(duenio) = self.valorBase() + self.refuerzo().poder()
	
	method cambiaRefuerzo(unRefuerzo) 
	{
		refuerzo = unRefuerzo
	}
	
	method diasDesdeQueSeComproElArtefacto() = self.fechaHoy() - self.fechaCompra()
	
	method precioDeLista(duenio) = self.refuerzo().precioRefuerzo(self.valorBase(),duenio)
	
	method pesoTotal(duenio) = (self.peso() - self.factorDeCorreccion()) + self.refuerzo().peso()

	method factorDeCorreccion() = (self.diasDesdeQueSeComproElArtefacto() / 1000).min(1)
}