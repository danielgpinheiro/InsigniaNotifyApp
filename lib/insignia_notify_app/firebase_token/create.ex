defmodule InsigniaNotifyApp.FirebaseToken.Create do
  alias InsigniaNotifyApp.FirebaseToken.Token
  alias InsigniaNotifyApp.Repo

  def call(params) do
    params |> Token.changeset() |> Repo.insert()
  end
end
