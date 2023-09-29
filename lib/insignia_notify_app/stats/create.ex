defmodule InsigniaNotifyApp.Stats.Create do
  alias InsigniaNotifyApp.Stats.Statistic
  alias InsigniaNotifyApp.Repo

  def call(params) do
    params
    |> Statistic.changeset()
    |> Repo.insert()
  end
end
