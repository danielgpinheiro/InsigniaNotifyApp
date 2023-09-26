defmodule InsigniaNotifyAppWeb.RedirectController do
  use InsigniaNotifyAppWeb, :controller

  def index(conn, _params) do
    conn
    |> redirect(to: "/games")
    |> halt()
  end
end
