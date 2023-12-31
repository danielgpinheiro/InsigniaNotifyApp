defmodule InsigniaNotifyAppWeb.RedirectController do
  use InsigniaNotifyAppWeb, :controller

  def index(conn, _params) do
    conn
    |> redirect(to: "/login")
    |> halt()
  end
end
