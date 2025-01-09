defmodule ExpoEscom.Eventos.Alumno do
  use Ash.Resource,
    domain: ExpoEscom.Eventos,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "alumnos"
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
      authorize_if relates_to_actor_via(:user)
    end
  end

  attributes do
    integer_primary_key :id

    attribute :numero_boleta, :string, allow_nil?: false
  end

  relationships do
    belongs_to :carrera, ExpoEscom.Eventos.Carrera, attribute_type: :integer
    belongs_to :equipo, ExpoEscom.Eventos.Equipo, attribute_type: :integer
    belongs_to :user, ExpoEscom.Accounts.User
  end
end
