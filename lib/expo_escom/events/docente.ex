defmodule ExpoEscom.Eventos.Docente do
  use Ash.Resource, domain: ExpoEscom.Eventos, data_layer: AshPostgres.DataLayer

  postgres do
    table "docentes"
    repo ExpoEscom.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    integer_primary_key :id

    attribute :es_jurado, :boolean
    attribute :turno, :atom, constraints: [one_of: [:matutino, :vespertino]]
  end

  relationships do
    belongs_to :departamento, ExpoEscom.Eventos.Departamento
    belongs_to :academia, ExpoEscom.Eventos.Academia
  end
end
