defmodule InsigniaNotifyApp.Settings do
  alias InsigniaNotifyApp.Settings.Create
  alias InsigniaNotifyApp.Settings.Get
  alias InsigniaNotifyApp.Settings.Update

  defdelegate get_by(user_id), to: Get, as: :call
  defdelegate create(params), to: Create, as: :call
  defdelegate update(notification_settings, params), to: Update, as: :call
end
