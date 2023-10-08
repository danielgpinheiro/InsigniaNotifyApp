defmodule InsigniaNotifyAppWeb.FirebaseTokenController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyApp.FirebaseToken

  def change_firebase_token(params) do
    case FirebaseToken.get_by(params.user_id) do
      {:error, :not_found} ->
        FirebaseToken.create(params)

      {:ok, tokens} ->
        FirebaseToken.update(tokens, params)
    end
  end

  def get_all() do
    FirebaseToken.get_all()
  end
end
