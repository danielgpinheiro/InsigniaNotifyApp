defmodule InsigniaNotifyAppWeb.SettingsController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyApp.Settings
  alias InsigniaNotifyApp.EnabledNotifications

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

  def get_enabled_notifications_by_user_id(user_id) do
    EnabledNotifications.get_by(user_id)
  end

  def change_enabled_notifications(params) do
    case EnabledNotifications.get_by(params.user_id) do
      {:error, :not_found} ->
        EnabledNotifications.create(params)

      {:ok, enabled_notifications} ->
        EnabledNotifications.update(enabled_notifications, params)
    end
  end
end
