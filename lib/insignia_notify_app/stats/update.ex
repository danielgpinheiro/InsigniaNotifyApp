defmodule InsigniaNotifyApp.Stats.Update do
  alias InsigniaNotifyApp.Stats.Statistic
  alias InsigniaNotifyApp.Repo

  def call(stats, params) do
    stats
    |> Statistic.changeset(params)
    |> Repo.update()
  end
end
