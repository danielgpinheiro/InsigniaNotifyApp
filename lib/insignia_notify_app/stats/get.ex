defmodule InsigniaNotifyApp.Stats.Get do
  alias InsigniaNotifyApp.Stats.Statistic
  alias InsigniaNotifyApp.Repo

  def call() do
    case Repo.get(Statistic, 1) do
      nil -> {:error, :not_found}
      stats -> {:ok, stats}
    end
  end
end
