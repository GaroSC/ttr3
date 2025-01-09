defmodule ExpoEscom.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExpoEscomWeb.Telemetry,
      ExpoEscom.Repo,
      {DNSCluster, query: Application.get_env(:expo_escom, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ExpoEscom.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ExpoEscom.Finch},
      # Start a worker by calling: ExpoEscom.Worker.start_link(arg)
      # {ExpoEscom.Worker, arg},
      # Start to serve requests, typically the last entry
      ExpoEscomWeb.Endpoint,
      TwMerge.Cache,
      {AshAuthentication.Supervisor, [otp_app: :expo_escom]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExpoEscom.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExpoEscomWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
