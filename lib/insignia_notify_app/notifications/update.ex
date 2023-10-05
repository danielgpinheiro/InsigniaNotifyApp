defmodule InsigniaNotifyApp.Notifications.Update do
  alias InsigniaNotifyApp.Notifications.Notification
  alias InsigniaNotifyApp.Repo

  def call(game_notification, params) do
    game_notification
    |> Notification.changeset(params)
    |> Repo.update()
  end
end
