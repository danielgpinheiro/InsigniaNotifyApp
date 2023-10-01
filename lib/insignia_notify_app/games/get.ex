defmodule InsigniaNotifyApp.Games.Get do
  alias InsigniaNotifyApp.Games.Game
  alias InsigniaNotifyApp.Repo

  def call_get(serial) do
    case Repo.get(Game, serial) do
      nil -> {:error, :not_found}
      game -> {:ok, game}
    end
  end

  def call_get_all() do
    case Repo.all(Game) do
      nil -> {:error, :not_found}
      games -> {:ok, games}
    end
  end
end
