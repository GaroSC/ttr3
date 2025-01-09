defmodule ExpoEscom.Eventos.Actividad do
  use Ash.Resource,
    domain: ExpoEscom.Eventos,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "actividades"
    repo ExpoEscom.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  policies do
    policy action_type(:read) do
      authorize_if always()
    end

    policy action_type(:create) do
      authorize_if ExpoEscom.Checks.IsAdminUser
      authorize_if ExpoEscom.Checks.IsJefeDepartamentoUser
      authorize_if relates_to_actor_via([:academia, :docente, :user])
    end

    policy action_type(:update) do
      authorize_if ExpoEscom.Checks.IsAdminUser
      authorize_if ExpoEscom.Checks.IsJefeDepartamentoUser
      authorize_if relates_to_actor_via([:academia, :docente, :user])
    end

    policy action_type(:destroy) do
      authorize_if ExpoEscom.Checks.IsAdminUser
      authorize_if ExpoEscom.Checks.IsJefeDepartamentoUser
      authorize_if relates_to_actor_via([:academia, :docente, :user])
    end
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
    belongs_to :evento, ExpoEscom.Eventos.Evento, attribute_type: :integer
    belongs_to :academia, ExpoEscom.Eventos.Academia, attribute_type: :integer
    belongs_to :docente, ExpoEscom.Eventos.Docente, attribute_type: :integer
    has_one :equipo, ExpoEscom.Eventos.Equipo
  end
end
