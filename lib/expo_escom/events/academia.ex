defmodule ExpoEscom.Eventos.Academia do
  use Ash.Resource, domain: ExpoEscom.Eventos

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
