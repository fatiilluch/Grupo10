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

	method pesoTotal(duenio) = self.peso() - self.factorDeCorreccion() + self.superaTresUnidades(duenio)
		
	method superaTresUnidades(duenio) 
	{
		if (self.poderDeLucha(duenio) >= 3 )
    	{  
           self.resultado(self.poderDeLucha(duenio) + (self.poderDeLucha(duenio) - 3))
           return self.resultado()
    	}
    	return 0
	}

	method factorDeCorreccion() = (self.diasDesdeQueSeComproElArtefacto()/1000).min(1)
	
	method diasDesdeQueSeComproElArtefacto() = self.fechaHoy() - self.fechaCompra()
	
	method poderDeLucha(duenio) = self.minimoDePoder().max((fuerzaOscura.poder()/2) * self.indiceDeOscuridad())
	
	method precioDeLista(duenio) = 10 * self.indiceDeOscuridad()
}


5 kg. (3 + 2 que es el peso extra, 
	la fuerza oscura en un eclipse duplica su poder a 10, 
	la mitad es 5 y como supera 3 => suma 2
)


/*las máscaras oscuras le agregan un kg. más por cada 
valor de lucha que supere las 3 unidades. 
Por ejemplo: si tiene un valor de lucha de 10, le agrega 7 kilos, 
si tiene 2 unidades como valor de lucha le agrega 0 kilos. 
Recordamos que el valor de lucha es la mitad del valor de la 
fuerza oscura multiplicado por el índice de oscuridad, 
con un mínimo dependiente de cada máscara.*/ 
	