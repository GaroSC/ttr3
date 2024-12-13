defmodule ExpoEscom.Eventos.Alumno do
  use Ash.Resource, domain: ExpoEscom.Eventos

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    integer_primary_key :id

    attribute :numero_boleta, :string, allow_nil?: false
  end

  relationships do
    belongs_to :carrera, ExpoEscom.Eventos.Carrera
    belongs_to :equipo, ExpoEscom.Eventos.Equipo
  end
end
