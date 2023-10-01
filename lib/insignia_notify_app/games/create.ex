defmodule InsigniaNotifyApp.Games.Create do
  alias InsigniaNotifyApp.Games.Game
  alias InsigniaNotifyApp.Repo

  def call(params) do
    params
    |> Game.changeset()
    |> Repo.insert()
  end
end
