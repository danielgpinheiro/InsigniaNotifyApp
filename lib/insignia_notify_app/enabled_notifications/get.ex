defmodule InsigniaNotifyApp.EnabledNotifications.Get do
  alias InsigniaNotifyApp.EnabledNotifications.EnabledNotification
  alias InsigniaNotifyApp.Repo

  def call(user_id) do
    case Repo.get_by(EnabledNotification, user_id: user_id) do
      nil -> {:error, :not_found}
      enabled_notifications -> {:ok, enabled_notifications}
    end
  end
end
