defmodule ExpoEscom.Accounts do
  use Ash.Domain

  resources do
    resource ExpoEscom.Accounts.Token
    resource ExpoEscom.Accounts.User
  end
end
