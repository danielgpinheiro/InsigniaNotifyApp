defmodule InsigniaNotifyAppWeb.NotificationController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyApp.Notifications

  def set_game_notification(params) do
    case Notifications.get_by(params) do
      {:error, :not_found} ->
        %{
          new_sessions: false,
          end_sessions: false,
          new_players: false,
          fewer_players: false,
          user_id: params.user_id,
          game_serial: params.game_serial
        }
        |> Map.replace(String.to_atom(params.notification_name), params.value)
        |> Notifications.create()

      {:ok, game_notifications} ->
        new_game_notifications =
          %{
            new_sessions: game_notifications.new_sessions,
            end_sessions: game_notifications.end_sessions,
            new_players: game_notifications.new_players,
            fewer_players: game_notifications.fewer_players,
            user_id: params.user_id,
            game_serial: params.game_serial
          }
          |> Map.replace(String.to_atom(params.notification_name), params.value)

        Notifications.update(game_notifications, new_game_notifications)
    end
  end

  def get_game_notification(params) do
    Notifications.get_by(params)
  end
end
