defmodule InsigniaNotifyApp.Settings.Update do
  alias InsigniaNotifyApp.Settings.Setting
  alias InsigniaNotifyApp.Repo

  def call(notification_settings, params) do
    notification_settings
    |> Setting.changeset(params)
    |> Repo.update()
  end
end
