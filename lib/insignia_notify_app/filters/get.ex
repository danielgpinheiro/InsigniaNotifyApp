defmodule InsigniaNotifyApp.Filters.Get do
  alias InsigniaNotifyApp.Filters.Filter
  alias InsigniaNotifyApp.Repo

  def call(user_id) do
    case Repo.get_by(Filter, user_id: user_id) do
      nil -> {:error, :not_found}
      order_by_preferences -> {:ok, order_by_preferences}
    end
  end
end
