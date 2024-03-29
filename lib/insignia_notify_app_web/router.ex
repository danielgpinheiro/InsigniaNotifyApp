defmodule InsigniaNotifyAppWeb.Router do
  use InsigniaNotifyAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {InsigniaNotifyAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  live_session :default do
    scope "/", InsigniaNotifyAppWeb do
      pipe_through :browser

      get "/", RedirectController, :index

      live "/login", LoginLive, :login
      live "/games", GamesLive, :games
      live "/settings", SettingsLive, :settings
    end
  end

  scope "/api", InsigniaNotifyAppWeb do
    pipe_through :api

    get "/", WelcomeController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", InsigniaNotifyAppWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard in development
  if Application.compile_env(:insignia_notify_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: InsigniaNotifyAppWeb.Telemetry
    end
  end
end
