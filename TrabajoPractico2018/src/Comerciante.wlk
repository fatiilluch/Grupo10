class Comerciante
{ 
	var property comerciante = new Independiente()
	
	method cobrarImpuesto(articulo) = self.comerciante().valorAgregado(articulo.precioDeLista())
	
	method recategorizate() 
	{
		self.comerciante(self.comerciante().recategoria())
	}
	
	//method comision() = self.comerciante().comision()
	//method minimoNoImponible() = self.comerciante().minimoNoImponible()
}

class Independiente 
{	
	var property comision
	
	method valorAgregado(precio) = comision
	
	method recategoria() 
	{
		self.comision(self.comision() * 2)
		if(self.comision() > 2.1)
		{
			return new Registrado()
		}
		return self
	}
}

class Registrado
{
	method valorAgregado(precio) = precio * 0.21
	
	method recategoria()
	{
		return new ConImpuestoALasGanancias()
	}
}
class ConImpuestoALasGanancias
{
	var property minimoNoImponible = 5
	
	method valorAgregado(precio)
	{
       if (precio >  self.minimoNoImponible()) 
       {
       	return (precio - self.minimoNoImponible()) * 0.35
       }
       return 0
    }   
    
    method recategoria() 
    {
    	return self
    }
}