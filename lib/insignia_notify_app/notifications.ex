defmodule InsigniaNotifyApp.Notifications do
  alias InsigniaNotifyApp.Notifications.Create
  alias InsigniaNotifyApp.Notifications.Get
  alias InsigniaNotifyApp.Notifications.Update

  defdelegate get_by(params), to: Get, as: :call
  defdelegate get_all_by_user_id(user_id), to: Get, as: :call2
  defdelegate create(params), to: Create, as: :call
  defdelegate update(game_notification, params), to: Update, as: :call
end
