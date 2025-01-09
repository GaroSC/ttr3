defmodule ExpoEscom.Checks.IsAdminUser do
  use Ash.Policy.SimpleCheck

  alias ExpoEscom.Accounts.User

  def describe(_) do
    "Verifica si el usuario es un administrador del sistema"
  end

  def match?(%User{rol: :administrador}, _context, _opts), do: true
  def match?(_user, _context, _opts), do: false
end
