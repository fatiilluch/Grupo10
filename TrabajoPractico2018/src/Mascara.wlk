import fuerzaOscura.*

class MascaraOscura
{
	var property indiceDeOscuridad = 0
	var property minimoDePoder = 4 
	var property peso
	var property fechaCompra 
	var property fechaHoy = new Date()
	
	var property resultado = 0
	
	method fechaCompra(dia,mes,anio) = new Date(dia,mes,anio)

	method pesoTotal(duenio) = self.peso() - self.factorDeCorreccion() + self.superaTresUnidades(0)
		
	method superaTresUnidades(duenio) 
	{
		if (self.poderDeLucha(duenio) >= 3 )
    	{  
           return self.poderDeLucha(duenio) - 3
    	}
    	return 0
	}
	
	method factorDeCorreccion() = (self.diasDesdeQueSeComproElArtefacto()/1000).min(1)
	
	method diasDesdeQueSeComproElArtefacto() = self.fechaHoy() - self.fechaCompra()
	
	method poderDeLucha(duenio) = self.minimoDePoder().max((fuerzaOscura.poder()/2) * self.indiceDeOscuridad())
	
	method precioDeLista() = 10 * self.indiceDeOscuridad()
}