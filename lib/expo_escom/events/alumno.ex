defmodule ExpoEscom.Eventos.Alumno do
  use Ash.Resource, domain: ExpoEscom.Eventos

  attributes do
    integer_primary_key :id

    attribute :nombre, :string do
      allow_nil? false
    end
  end

  relationships do
    belongs_to :carrera, ExpoEscom.Eventos.Carrera
    belongs_to :equipo, ExpoEscom.Eventos.Equipo
  end

end
