defmodule ExpoEscom.Eventos do
  use Ash.Domain

  resources do
    resource ExpoEscom.Eventos.Academia
    resource ExpoEscom.Eventos.Actividad
    resource ExpoEscom.Eventos.Alumno
    resource ExpoEscom.Eventos.Carrera
    resource ExpoEscom.Eventos.Departamento
    resource ExpoEscom.Eventos.Docente
    resource ExpoEscom.Eventos.Equipo
    resource ExpoEscom.Eventos.Evento
  end
end
