defmodule ExpoEscom.Secrets do
  use AshAuthentication.Secret

  def secret_for([:authentication, :tokens, :signing_secret], ExpoEscom.Accounts.User, _opts) do
    Application.fetch_env(:expo_escom, :token_signing_secret)
  end
end
