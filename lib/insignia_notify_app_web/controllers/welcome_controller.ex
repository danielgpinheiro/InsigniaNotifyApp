defmodule InsigniaNotifyAppWeb.WelcomeController do
  use InsigniaNotifyAppWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Bem vindo ao InsigniaNotifyApp"})
  end
end
