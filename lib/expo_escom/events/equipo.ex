defmodule ExpoEscom.Eventos.Equipo do
  use Ash.Resource,
    domain: ExpoEscom.Eventos,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  postgres do
    table "equipos"
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
      forbid_if ExpoEscom.Checks.IsAlumnoUser
      authorize_if always()
    end

    policy action_type(:update) do
      authorize_if ExpoEscom.Checks.IsAdminUser
      forbid_if ExpoEscom.Checks.IsAlumnoUser
      authorize_if relates_to_actor_via([:docente, :user])
    end

    policy action_type(:destroy) do
      authorize_if ExpoEscom.Checks.IsAdminUser
      forbid_if ExpoEscom.Checks.IsAlumnoUser
      authorize_if relates_to_actor_via([:docente, :user])
    end
  end

  attributes do
    integer_primary_key :id

    attribute :nombre, :string, allow_nil?: false
    attribute :asignatura, :string, allow_nil?: false
    attribute :puntaje, :integer
  end

  relationships do
    has_many :alumnos, ExpoEscom.Eventos.Alumno
    belongs_to :actividad, ExpoEscom.Eventos.Actividad, attribute_type: :integer
    belongs_to :docente, ExpoEscom.Eventos.Docente, attribute_type: :integer
  end
end
