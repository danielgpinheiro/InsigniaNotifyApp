defmodule InsigniaNotifyApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      InsigniaNotifyAppWeb.Telemetry,
      # Start the Ecto repository
      InsigniaNotifyApp.Repo,
      # Start the UserTokenCleaner
      {InsigniaNotifyApp.UserTokenCleaner, interval_minutes: 10},
      # Start the PubSub system
      {Phoenix.PubSub, name: InsigniaNotifyApp.PubSub},
      # Start the Endpoint (http/https)
      InsigniaNotifyAppWeb.Endpoint,

      # Insignia HTML Crawler Interval Job
      {InsigniaNotifyAppWeb.IntervalController, 0}

      # Start a worker by calling: InsigniaNotifyApp.Worker.start_link(arg)
      # {InsigniaNotifyApp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: InsigniaNotifyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InsigniaNotifyAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
