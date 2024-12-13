defmodule ExpoEscom.Eventos.Carrera do
  use Ash.Resource, domain: ExpoEscom.Eventos

  attributes do
    integer_primary_key :id

    attribute :nombre, :atom do
      constraints one_of: [:ISC, :IA, :CD]
    end
  end

  relationships do
    has_many :alumnos. ExpoEscom.Eventos.Alumno
  end

end
