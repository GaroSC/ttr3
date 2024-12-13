defmodule ExpoEscom.Eventos.Docentes do
  use Ash.Resource, domain: ExpoEscom.Eventos

  attributes do
    integer_primary_key_ :id

    attribute :es_jurado, :bool do
    end

    attribute :turno, :atom do
      constraint(one_of: [:matutino, :vespertino])
    end
  end
end
