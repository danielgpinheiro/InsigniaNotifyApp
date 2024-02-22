# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :insignia_notify_app, :job_url, System.fetch_env("JOB_URL")
config :insignia_notify_app, :interval_time, System.fetch_env("INTERVAL_TIME")

config :insignia_notify_app,
  ecto_repos: [InsigniaNotifyApp.Repo]

# Configures the endpoint
config :insignia_notify_app, InsigniaNotifyAppWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: InsigniaNotifyAppWeb.ErrorHTML, json: InsigniaNotifyAppWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: InsigniaNotifyApp.PubSub,
  live_view: [signing_salt: "hy8gysPG"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args: ~w(js/app.ts --bundle --target=es2017 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
