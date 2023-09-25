defmodule InsigniaNotifyAppWeb.Session do
  @moduledoc """
  Manages user-authenticated sessions.
  """
  alias InsigniaNotifyApp.Identity
  alias InsigniaNotifyApp.Identity.User
  use InsigniaNotifyAppWeb, :controller

  def fetch_current_user(conn, _opts) do
    with encoded_value when is_binary(encoded_value) <- get_session(conn, :user_token),
         {:ok, decoded_value} <- Base.decode64(encoded_value, padding: false),
         {:ok, %User{id: user_id}} <- Identity.get_by_token(decoded_value) do
      conn
      |> put_session(:user_id, user_id)
    else
      _error ->
        conn
        |> clear_session()
    end
  end

  def create(conn, %{"value" => value}) do
    decoded_value = Base.decode64!(value, padding: false)

    case Identity.get_by_token(decoded_value, :session) do
      {:ok, %User{id: user_id}} ->
        conn
        |> put_session(:user_token, value)
        |> put_session(:user_id, user_id)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: ~p"/games")

      {:error, _} ->
        conn
        |> clear_session()
        |> put_flash(:error, "Please sign in.")
        |> redirect(to: ~p"/login")
    end
  end

  def delete(conn, _params) do
    conn
    |> get_session("user_id")
    |> Identity.delete_all_user_sessions()

    conn
    |> clear_session()
    |> put_flash(:info, "Successfully signed out.")
    |> redirect(to: ~p"/login")
  end
end
