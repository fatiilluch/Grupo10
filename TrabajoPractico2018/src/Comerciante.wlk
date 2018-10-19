//import Personaje.*

class Comerciante
{
	var property comision
}

class ComercianteIndependiente inherits Comerciante
{
	method impuestoAdicional() = comision
}

class ComercianteRegistrado inherits Comerciante
{
	method impuestoAdicional() = 0.21
}

class ComercianteConImpuestoALasGanancias inherits Comerciante
{
	method impuestoAdicional() = 0
}
/*i el importe de lo que se vende es menor al mínimo no imponible 
(definidos para todos por igual), 
no tiene recargo, pero si lo supera, se le suma el 35% de la diferencia de importes.*/ 
