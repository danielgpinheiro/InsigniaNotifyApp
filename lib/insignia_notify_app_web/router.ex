defmodule InsigniaNotifyAppWeb.Router do
  use InsigniaNotifyAppWeb, :router

  (
    alias InsigniaNotifyAppWeb.SessionHooks.AssignUser
    alias InsigniaNotifyAppWeb.SessionHooks.RequireUser
    import InsigniaNotifyAppWeb.Session, only: [fetch_current_user: 2]
  )

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {InsigniaNotifyAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # HTTP controller routes
  scope "/", InsigniaNotifyAppWeb do
    pipe_through :browser

    post "/session", Session, :create
    delete "/session", Session, :delete
  end

  # Unprotected LiveViews
  live_session :guest, on_mount: [AssignUser] do
    scope "/", InsigniaNotifyAppWeb do
      pipe_through :browser

      live "/login", LoginLive
    end
  end

  # Protected LiveViews
  live_session :authenticated, on_mount: [AssignUser, RequireUser] do
    scope "/", InsigniaNotifyAppWeb do
      pipe_through :browser

      live "/", GamesLive, :games
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
