defmodule ExpoEscom.Checks.IsAlumnoUser do
  use Ash.Policy.SimpleCheck

  alias ExpoEscom.Accounts.User

  def describe(_) do
    "Verifica si el usuario es de tipo alumno"
  end

  def match?(%User{rol: :alumno}, _context, _opts), do: true
  def match?(_user, _context, _opts), do: false
end
