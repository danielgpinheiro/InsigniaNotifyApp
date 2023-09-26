defmodule InsigniaNotifyApp.Settings.Get do
  alias InsigniaNotifyApp.Settings.Setting
  alias InsigniaNotifyApp.Repo

  def call(user_id) do
    case Repo.get_by(Setting, user_id: user_id) do
      nil -> {:error, :not_found}
      notification_settings -> {:ok, notification_settings}
    end
  end
end
