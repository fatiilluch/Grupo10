class Comerciante
{ 
	var property comerciante = new Independiente()
	
	method cobrarPrecio(articulo) = self.comerciante().valorAgregado(articulo)
	
	method recategorizate() 
	{
		self.comerciante(self.comerciante().recategoria())
	}
	
	method comision() = self.comerciante().comision()
}

class Independiente 
{	
	var property comision
	
	method valorAgregado(articulo) = articulo.precioDeLista() + self.comision()
	
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
	method valorAgregado(articulo) = articulo.precioDeLista()*1.21
	
	method recategoria()
	{
		return new ConImpuestoALasGanancias()
	}
}
class ConImpuestoALasGanancias
{
	var property minimoNoImponible = 5
	
	method valorAgregado(articulo)
	{
       if (articulo.precioDeLista() >  self.minimoNoImponible()) 
       {
       		return (articulo.precioDeLista() + (articulo.precioDeLista() - self.minimoNoImponible()) * 0.35)
       }
       return 0
    }   
    
    method recategoria() 
    {
    	return self
    }
}