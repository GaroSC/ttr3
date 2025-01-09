defmodule ExpoEscom.Eventos.Docente do
  use Ash.Resource,
    domain: ExpoEscom.Eventos,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "docentes"
    repo ExpoEscom.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  policies do
    policy action_type(:read) do
      authorize_if always()
    end

    policy action_type([:create, :update, :destroy]) do
      authorize_if ExpoEscom.Checks.IsAdminUser
      authorize_if relates_to_actor_via(:usuario)
    end
  end

  attributes do
    integer_primary_key :id

    attribute :es_jurado, :boolean
    attribute :turno, :atom, constraints: [one_of: [:matutino, :vespertino]]
  end

  relationships do
    belongs_to :academia, ExpoEscom.Eventos.Academia, attribute_type: :integer
    belongs_to :user, ExpoEscom.Accounts.User
    has_one :actividad, ExpoEscom.Eventos.Actividad
    has_one :equipo, ExpoEscom.Eventos.Equipo
  end
end
