defmodule ExpoEscom.Eventos.Equipo do
  use Ash.Resource, domain: ExpoEscom.Eventos

  attributes do
    integer_primary_key :id

    attribute :nombre, :string do
      allow_nil? false
    end

    attribute :asignatura, :string do
      allow_nil? false
    end

    attribute :puntaje, :float do
      allow_nil? false
    end

  end

  relationships do
    has_many :alumnos. ExpoEscom.Eventos.Alumno
  end

end
