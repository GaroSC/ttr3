defmodule ExpoEscom.Eventos.Academia do
  use Ash.Resource, domain: ExpoEscom.Eventos, data_layer: AshPostgres.DataLayer

  postgres do
    table "academias"
    repo ExpoEscom.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    integer_primary_key :id

    attribute :nombre, :string, allow_nil?: false
  end

  relationships do
    has_many :docentes, ExpoEscom.Eventos.Docente
  end
end
