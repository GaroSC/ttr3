defmodule ExpoEscom.Eventos.Carrera do
  use Ash.Resource, domain: ExpoEscom.Eventos

  attributes do
    integer_primary_key :id

    attribute :nombre, :string do
      allow_nil? false
    end
  end

  relationships do
    has_many :alumnos, ExpoEscom.Eventos.Alumno
  end
end
