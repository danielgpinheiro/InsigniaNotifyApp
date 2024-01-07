defmodule InsigniaNotifyApp.Token.Update do
  alias InsigniaNotifyApp.Token.Token
  alias InsigniaNotifyApp.Repo

  def call(token_users, params) do
    token_users
    |> Token.changeset(params)
    |> Repo.update()
  end
end
