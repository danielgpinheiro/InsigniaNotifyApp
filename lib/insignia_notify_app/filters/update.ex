defmodule InsigniaNotifyApp.Filters.Update do
  alias InsigniaNotifyApp.Filters.Filter
  alias InsigniaNotifyApp.Repo

  def call(order_by_preferences, params) do
    order_by_preferences
    |> Filter.changeset(params)
    |> Repo.update()
  end
end
