defmodule ExpoEscom.Eventos.Docente do
  use Ash.Resource, domain: ExpoEscom.Eventos

  defaults [:read, :destroy, create: :*, update: :*]

  attributes do
    integer_primary_key :id

    attribute :es_jurado, :boolean
    attribute :turno, :atom, constraints: [one_of: [:matutino, :vespertino]]
  end

  relationships do
    belongs_to :departamentos, ExpoEscom.Eventos.Departamento
    belongs_to :academias, ExpoEscom.Eventos.Academia
  end
end
