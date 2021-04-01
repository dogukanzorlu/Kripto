defmodule Kripto.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      KriptoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Kripto.PubSub},
      # Start the Endpoint (http/https)
      KriptoWeb.Endpoint,

      # Packages
      {Finch, name: KriptoFinch},

      # Sockets
      {Kripto.Market.Crypto.Socket, %{}}
      # Start a worker by calling: Kripto.Worker.start_link(arg)
      # {Kripto.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kripto.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    KriptoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
