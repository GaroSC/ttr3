defmodule ExpoEscom.Eventos.Actividad do
  use Ash.Resource, domain: ExpoEscom.Eventos, data_layer: AshPostgres.DataLayer

  postgres do
    table "actividades"
    repo ExpoEscom.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    integer_primary_key :id

    attribute :nombre, :string, allow_nil?: false, public?: true
    attribute :comienza_en, :datetime
    attribute :url_cartel, :string
    attribute :tipo, :atom, constraints: [one_of: [:concurso, :presentacion]]
    attribute :premio, :string
    attribute :url_evaluacion, :string
  end

  relationships do
    belongs_to :evento, ExpoEscom.Eventos.Evento
  end
end
