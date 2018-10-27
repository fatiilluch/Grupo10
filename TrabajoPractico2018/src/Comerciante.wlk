class Comerciante
{
	var property comision 
	var property comerciante = independiente
	var property articulos = []
	var property minimoNoImponible
	
	method cobrarImpuesto(precioDeLista) = self.comerciante().valorAgregado(self.comision(), precioDeLista, minimoNoImponible)
	
	method tieneElArtefacto(artefacto) = self.articulos().contains(artefacto)
	
	method agregaArticulo(articulo)
	{
		articulos.add(articulo) 
	}
	
	method recategorizate()
	{
		if (self.comerciante() == registrado)
		{
			self.comerciante(conImpuestoALasGanancias)
		}
		else if (self.comerciante() == independiente)
			{
				self.comision(self.comision()*2)
				if(self.comision() > 2.1)
				{
					self.comerciante(registrado)
				}
			}
	}
}

object independiente inherits Comerciante 
{
	method valorAgregado(comision, precio, minimoNoImponible) = comision
}

object registrado inherits Comerciante 
{
	method valorAgregado(comision, precio, minimoNoImponible) = precio * 0.21
}

object conImpuestoALasGanancias inherits Comerciante
{
	method valorAgregado(comision, precio, minimoNoImponible)
	{
       if (precio >  minimoNoImponible) 
       {
       	return (precio - minimoNoImponible) * 0.35
       }
       return 0
    }   
}