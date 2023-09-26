defmodule InsigniaNotifyApp.Settings.Create do
  alias InsigniaNotifyApp.Settings.Setting
  alias InsigniaNotifyApp.Repo

  def call(params) do
    params
    |> Setting.changeset()
    |> Repo.insert()
  end
end
