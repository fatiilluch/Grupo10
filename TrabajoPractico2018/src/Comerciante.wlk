class Comerciante
{
	var property comision 
	var property comerciante = independiente
	
	method cobrarImpuesto() = self.comision() + self.comerciante().valorAgregado() 
}

object independiente 
{
	var property comision = 10
	method valorAgregado() = comision
}

object registrado 
{
	method valorAgregado() = 0.21
}

object conImpuestoALasGanancias
{
	var property comision = 10
	method valorAgregado(){} // TODO
}

/*si el importe de lo que se vende es menor al mínimo no imponible 
(definidos para todos por igual), 
no tiene recargo, pero si lo supera, se le suma el 35% de la diferencia de importes.*/ 
