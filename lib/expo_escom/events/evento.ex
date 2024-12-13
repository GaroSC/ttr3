defmodule ExpoEscom.Eventos.Evento do
  use Ash.Resource, domain: ExpoEscom.Eventos, data_layer: AshPostgres.DataLayer

  postgres do
    table "eventos"
    repo ExpoEscom.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    integer_primary_key :id

    attribute :nombre, :string, allow_nil?: false, public?: true
    attribute :descripcion, :string, allow_nil?: false, public?: true
    attribute :ano, :integer, allow_nil?: false, public?: true
    attribute :color_fondo, :string, allow_nil?: false, public?: true
    attribute :url_cartel, :string, allow_nil?: false, public?: true
  end

  relationships do
    has_many :actividades, ExpoEscom.Eventos.Actividad
  end
end
