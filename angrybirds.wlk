object islaPajaro{
	var pajaros =[]
	var evento
	method pajarosFuertes(){
		return pajaros.filter{pajaro => pajaro.fuerza() > 50}
	}
	method fuerzaIsla(){
		return self.pajarosFuertes().sum{pajaro => pajaro.fuerza()}
	}
	method ocurrirEvento(){
		 evento.ocurrir(self)
	}
	method tranquilizarPajaros(){
		pajaros.forEach{pajaro => pajaro.disminuirIra()}
	}
	method enojarPajaros(cerditos){
		pajaros.forEach{pajaro => pajaro.hacerEnojar(cerditos)}
	}
	method fuerzaPajaros(){
		return pajaros.map{pajaro => pajaro.fuerza()}
	}
}

object sesionManejoIra{
	method ocurrir(isla){
		isla.tranquilizarPajaros()
	}
}

object invasion{
	var cerditos
	method ocurrir(isla){
		isla.enojarPajaros(cerditos)
	}
}

class Pajaro{
	var ira
	var property enojos
	method fuerza(){
		return ira * 2
	}
	method enojarse(){
		enojos += 1
		return self.fuerza()
	}
	method cantidadDeEnojos(){
		return enojos 
	}
	method disminuirIra(){
		ira -= 5
	}
	method hacerEnojar(cerditos){
		enojos += 1/100
	}
}

class Comun inherits Pajaro{
	
}

class Red inherits Pajaro{
	override method fuerza(){
		return ira * 10 * self.cantidadDeEnojos()
	}
}

class Bomb inherits Pajaro{
	var topeMaximoFuerza = 9000
	method cambiarTope(cuanto){
		topeMaximoFuerza = cuanto
	}
	override method fuerza(){
		if(super() > topeMaximoFuerza){
			error.throwWithMessage("No debe superar el tope maximo")
		}
			return super()
	}
}

class Chuck inherits Pajaro{
	var velocidad
	override method fuerza(){
		if(velocidad < 80){
			return 150
		}
			return 5 * velocidad
	}
	override method disminuirIra(){
		ira -= 0
	}
}

class Terence inherits Pajaro{
	var multiplicador
	method cambiarMultiplicador(nuevo){
		multiplicador = nuevo
	}
	override method fuerza(){
		return ira + self.cantidadDeEnojos() + multiplicador 
	}
}

class Matilda inherits Pajaro{
	var huevos = []
	override method fuerza(){
		return super() + self.fuerzaHuevos()
	}
	method fuerzaHuevos(){
		return huevos.sum{huevo => huevo.fuerza(self)}
	}
}

object huevo{
	method fuerza(pajaro){
		if(pajaro.enojos() != 0){
			return 2
		}
			return 1
	}
}
object islaCerdo{
	var cerdos = []
	var obstaculos = []
	method serAtacadoPor(islaPajaro){
		if(islaPajaro.fuerzaPajaros() > self.resistenciaObstaculos()){
			self.perderObstaculos()
		}
			
	}
	method perderObstaculos(){
		obstaculos.clear()
	}
	method resistenciaObstaculos(){
		return obstaculos.map{obstaculo => obstaculo.resistencia()}
	}
}

