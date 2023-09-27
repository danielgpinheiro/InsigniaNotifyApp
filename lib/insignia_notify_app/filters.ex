defmodule InsigniaNotifyApp.Filters do
  alias InsigniaNotifyApp.Filters.Create
  alias InsigniaNotifyApp.Filters.Get
  alias InsigniaNotifyApp.Filters.Update

  defdelegate get_by(user_id), to: Get, as: :call
  defdelegate create(params), to: Create, as: :call
  defdelegate update(order_by_preferences, params), to: Update, as: :call
end
