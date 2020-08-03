defmodule ExMon.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ExMon.Repo,
      # Start the Telemetry supervisor
      ExMonWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExMon.PubSub},
      # Start the Endpoint (http/https)
      ExMonWeb.Endpoint
      # Start a worker by calling: ExMon.Worker.start_link(arg)
      # {ExMon.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExMon.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ExMonWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
