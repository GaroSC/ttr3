defmodule ExpoEscom.Eventos.Actividad do
  use Ash.Resource, domain: ExpoEscom.Eventos

  attributes do
    integer_primary_key :id

    attribute :nombre, :string do
      allow_nil? false
      public? true
    end

    attribute :comienza_en, :datetime
    attribute :url_cartel, :string

    attribute :tipo, :atom do
      constraints one_of: [:concurso, :presentacion]
    end

    attribute :premio, :string
    attribute :url_evaluacion, :string
  end

  relationships do
    belongs_to :evento, ExpoEscom.Eventos.Evento
  end
end
