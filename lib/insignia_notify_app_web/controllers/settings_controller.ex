defmodule InsigniaNotifyAppWeb.SettingsController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyApp.Settings

  def change_settings(params) do
    case Settings.get_by(params.user_id) do
      {:error, :not_found} ->
        Settings.create(params)

      {:ok, settings} ->
        Settings.update(settings, params)
    end
  end

  def get_settings_by_user_id(user_id) do
    Settings.get_by(user_id)
  end
end
