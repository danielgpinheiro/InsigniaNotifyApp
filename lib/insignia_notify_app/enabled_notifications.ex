defmodule InsigniaNotifyApp.EnabledNotifications do
  alias InsigniaNotifyApp.EnabledNotifications.Create
  alias InsigniaNotifyApp.EnabledNotifications.Get
  alias InsigniaNotifyApp.EnabledNotifications.Update

  defdelegate get_by(user_id), to: Get, as: :call
  defdelegate create(params), to: Create, as: :call
  defdelegate update(enabled_notifications, params), to: Update, as: :call
end
