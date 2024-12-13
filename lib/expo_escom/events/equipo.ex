defmodule ExpoEscom.Eventos.Equipo do
  use Ash.Resource, domain: ExpoEscom.Eventos, data_layer: AshPostgres.DataLayer

  postgres do
    table "equipos"
    repo ExpoEscom.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    integer_primary_key :id

    attribute :nombre, :string, allow_nil?: false
    attribute :asignatura, :string, allow_nil?: false
    attribute :puntaje, :integer
  end

  relationships do
    has_many :alumnos, ExpoEscom.Eventos.Alumno
  end
end
