defmodule ExpoEscom.Eventos do
  use Ash.Domain

  resources do
    resource ExpoEscom.Eventos.Evento
    resource ExpoEscom.Eventos.Actividad
    resource ExpoEscom.Eventos.Academia
    resource ExpoEscom.Eventos.Docentes
    resource ExpoEscom.Eventos.Departamento
  end
end
