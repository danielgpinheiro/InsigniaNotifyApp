defmodule InsigniaNotifyApp.EnabledNotifications.Update do
  alias InsigniaNotifyApp.EnabledNotifications.EnabledNotification
  alias InsigniaNotifyApp.Repo

  def call(enabled_notifications, params) do
    enabled_notifications
    |> EnabledNotification.changeset(params)
    |> Repo.update()
  end
end
