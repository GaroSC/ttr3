defmodule ExpoEscom.Accounts.User.Senders.SendPasswordResetEmail do
  @moduledoc """
  Sends a password reset email
  """

  use AshAuthentication.Sender
  use ExpoEscomWeb, :verified_routes

  @impl true
  def send(_user, token, _) do
    # Example of how you might send this email
    # ExpoEscom.Accounts.Emails.send_password_reset_email(
    #   user,
    #   token
    # )

    IO.puts("""
    Click this link to reset your password:

    #{url(~p"/password-reset/#{token}")}
    """)
  end
end
