defmodule InsigniaNotifyApp.Token.Create do
  alias InsigniaNotifyApp.Token.Token
  alias InsigniaNotifyApp.Repo

  def call(params) do
    params |> Token.changeset() |> Repo.insert()
  end
end
