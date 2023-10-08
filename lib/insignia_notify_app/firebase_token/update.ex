defmodule InsigniaNotifyApp.FirebaseToken.Update do
  alias InsigniaNotifyApp.FirebaseToken.Token
  alias InsigniaNotifyApp.Repo

  def call(firebase_token, params) do
    firebase_token
    |> Token.changeset(params)
    |> Repo.update()
  end
end
