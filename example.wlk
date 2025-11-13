
object CentroKinesiologia () {
  const pacientes=[]
  const aparatos=[]

  method coloresDeAparatos(){
    return aparatos.map({a=>a.colorActual()})
  }
  method pacientesMenoresA8{
    return pacientes.filter({p=>p.edad()<8})
  }

method cantidadPacientesQueNoCumplenRutina(){
  return pacientes.count({p=>!p.rutinaAsignada()})
}



class Paciente {
  const edad
  var fortalezaM
  var nivelDolor
  const elementosRutinaAsignada = [] 

  method edad() = edad
  method fortalezaMuscular() = fortalezaM
  method nivelDolor() = nivelDolor

  method puedeUsar(unAparato) {
    unAparato.condicionUso(self)
  } 
method usarAparato(unAparato) {
  if(self.puedeUsar(unAparato)) {
   unAparato.efectodeUsar(self) }
}

method efectoMagneto() {
  nivelDolor=(nivelDolor *0.9).max(0)
}

method efectoBicicleta() {
  nivelDolor=(nivelDolor-4).max(0)
  fortalezaM=(fortalezaM+3)
}

method efectoMinitramp() {
  fortalezaM=fortalezaM+(edad*0.1)
}

method rutinaAsignada() = elementosRutinaAsignada.all({a=>self.puedeUsar(a)}) 
method Rutina() { 
elementosRutinaAsignada.forEach({a=>self.usarAparato(a)})
}

method realizarRutina() {
  if (self.rutinaAsignada()) {
    self.Rutina()
    }
  }
}

class Magneto  {
  var color

  method colorActual()=color

  method modificarColor(nuevoColor) {
    color=nuevoColor
  }
  
  method condicionUso(unPaciente) =true

  method efectodeUsar(unPaciente) {
    unPaciente.efectoMagneto()
  }
}

class Bicicleta {

   var color

  method colorActual()=color

  method modificarColor(nuevoColor) {
    color=nuevoColor
  }

  method condicionUso(unPaciente) = unPaciente.edad()>8 

  method efectodeUsar(unPaciente) {
    unPaciente.efectoBicicleta()
  }
}

class Minitramp {

   var color

  method colorActual()=color

  method modificarColor(nuevoColor) {
    color=nuevoColor
  }
  method condicionUso(unPaciente) = unPaciente.nivelDolor()<20 
   method efectodeUsar(unPaciente) {
    unPaciente.efectoMinitramp() }
}


class PacienteResistente inherits Paciente {
 override method realizarRutina(){
  super()
  fortalezaM+= elementosRutinaAsignada.size()
 }
}

class PacienteCaprichoso inherits Paciente {
override method rutinaAsignada(){
  elementosRutinaAsignada.any({a=>a.colorActual()=="Rojo"})
}
method condicionExtra(){
  if(self.rutinaAsignada()){
  self.realizarRutina()
  self.realizarRutina()
  }
}
}


class PacienteRapidaRecuperacion inherits Paciente {
 override method realizarRutina(){
  super()
  nivelDolor=(nivelDolor*0.8).max(0)
 }
}








