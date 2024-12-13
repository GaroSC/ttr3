defmodule ExpoEscom.Eventos.Evento do
  use Ash.Resource, domain: ExpoEscom.Eventos

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:nombre, :descripcion, :ano, :color_fondo, :url_cartel]
    end

    update :update do
      accept [:nombre, :descripcion, :ano, :color_fondo, :url_cartel]
    end
  end

  attributes do
    integer_primary_key :id

    attribute :nombre, :string do
      allow_nil? false
      public? true
    end

    attribute :descripcion, :string do
      allow_nil? false
      public? true
    end

    attribute :ano, :integer do
      allow_nil? false
      public? true
    end

    attribute :color_fondo, :string do
      allow_nil? false
      public? true
    end

    attribute :url_cartel, :string do
      allow_nil? false
      public? true
    end
  end

  relationships do
    has_many :actividades, ExpoEscom.Eventos.Actividad
  end
end
