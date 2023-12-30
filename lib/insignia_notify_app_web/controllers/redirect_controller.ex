defmodule InsigniaNotifyAppWeb.RedirectController do
  use InsigniaNotifyAppWeb, :controller

  def index(conn, _params) do
    # conn
    # |> redirect(to: "/games")
    # |> halt()
    conn
    |> put_status(:ok)
    |> json(%{message: "Bem vindo ao InsigniaNotifyApp"})
  end
end
