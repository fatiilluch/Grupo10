import CollarDivino.*

class Artefacto 
{
	var property peso
	var property fechaCompra 
	var property fechaHoy = new Date()
		
	method fechaCompra(dia,mes,anio) = new Date(dia,mes,anio)
	
	method pesoTotal() = self.peso() - self.factorDeCorreccion()
	
	method factorDeCorreccion() = (self.diasDesdeQueSeComproElArtefacto()/1000).min(1)
	
	method diasDesdeQueSeComproElArtefacto() = self.fechaHoy() - self.fechaCompra()
}

//un artefacto puede ser:
//una armadura, una mascara, un espejo, un libro de hehcizos, un arma filosa o un collar Divino