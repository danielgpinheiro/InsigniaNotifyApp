defmodule InsigniaNotifyApp.Filters.Create do
  alias InsigniaNotifyApp.Filters.Filter
  alias InsigniaNotifyApp.Repo

  def call(params) do
    params
    |> Filter.changeset()
    |> Repo.insert()
  end
end
