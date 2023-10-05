defmodule InsigniaNotifyApp.Notifications.Create do
  alias InsigniaNotifyApp.Notifications.Notification
  alias InsigniaNotifyApp.Repo

  def call(params) do
    params |> Notification.changeset() |> Repo.insert()
  end
end
