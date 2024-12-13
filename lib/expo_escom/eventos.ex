defmodule ExpoEscom.Eventos do
  use Ash.Domain

  resources do
    resource ExpoEscom.Eventos.Evento
    resource ExpoEscom.Eventos.Actividad
  end
end
