defmodule InsigniaNotifyApp.EnabledNotifications.Create do
  alias InsigniaNotifyApp.EnabledNotifications.EnabledNotification
  alias InsigniaNotifyApp.Repo

  def call(params) do
    params
    |> EnabledNotification.changeset()
    |> Repo.insert()
  end
end
