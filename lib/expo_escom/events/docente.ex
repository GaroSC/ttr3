defmodule ExpoEscom.Eventos.Docente do
  use Ash.Resource, domain: ExpoEscom.Eventos

  attributes do
    integer_primary_key :id

    attribute :es_jurado, :boolean

    attribute :turno, :atom do
      constraints one_of: [:matutino, :vespertino]
    end
  end
end
