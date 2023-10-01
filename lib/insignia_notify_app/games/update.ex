defmodule InsigniaNotifyApp.Games.Update do
  alias InsigniaNotifyApp.Games.Game
  alias InsigniaNotifyApp.Repo

  def call(game, params) do
    game
    |> Game.changeset(params)
    |> Repo.update()
  end
end
