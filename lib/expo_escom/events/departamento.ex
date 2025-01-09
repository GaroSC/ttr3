defmodule ExpoEscom.Eventos.Departamento do
  use Ash.Resource,
    domain: ExpoEscom.Eventos,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "departamentos"
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
    end
  end

  attributes do
    integer_primary_key :id

    attribute :nombre, :string, allow_nil?: false
  end

  relationships do
    has_many :academias, ExpoEscom.Eventos.Academia
  end
end
