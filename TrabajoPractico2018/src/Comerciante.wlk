class Comerciante
{
	var property comision 
	var property comerciante = independiente
	var property articulos = []
	var property minimoNoImponible
	
	method cobrarImpuesto(precioDeLista) = self.comision() + self.comerciante().valorAgregado(self.comision(), precioDeLista, minimoNoImponible)
	
	method tieneElArtefacto(artefacto) = self.articulos().contains(artefacto)
	
	method agregaArticulo(articulo)
	{
		articulos.add(articulo) 
	}
}

object independiente 
{
	method valorAgregado(comision, precio, minimoNoImponible) = comision
}

object registrado 
{
	method valorAgregado(comision, precio, minimoNoImponible) = 0.21
}

object conImpuestoALasGanancias
{
	var property valor
	method valorAgregado(comision, precio, minimoNoImponible)
	{
       if (precio >  minimoNoImponible) 
       {
       	valor = precio + (precio - minimoNoImponible) * 0.35
       }
       return valor
    }
    
}

/*si el importe de lo que se vende es menor al mínimo no imponible 
(definidos para todos por igual), 
no tiene recargo, pero si lo supera, se le suma el 35% de la diferencia de importes.*/ 
