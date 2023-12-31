defmodule InsigniaNotifyAppWeb.NotificationController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyApp.Token
  alias InsigniaNotifyApp.Notifications
  alias InsigniaNotifyApp.Settings.Setting
  alias InsigniaNotifyAppWeb.Http.Api
  alias InsigniaNotifyAppWeb.GamesController
  alias InsigniaNotifyAppWeb.SettingsController

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

  def notification_job do
    {_, tokens} = Token.get_all()
    games = GamesController.get_games()

    Enum.map(tokens, fn token ->
      {_, value} = SettingsController.get_enabled_notifications_by_user_id(token.id)

      enabled = if value == :not_found, do: true, else: value.enabled

      if enabled do
        check_to_send_notification(%{
          user_id: token.id,
          firebase_user_token: token.user_token,
          games: games
        })
      end
    end)
  end

  defp check_to_send_notification(params) do
    case Notifications.get_all_by_user_id(params.user_id) do
      {:error, _} ->
        {:ok}

      {:ok, game_notifications} ->
        notification_params = %{
          user_token: params.firebase_user_token,
          user_id: params.user_id,
          server_token: Goth.fetch!(InsigniaNotifyApp.Goth).token
        }

        Enum.map(game_notifications, fn game_notification ->
          game =
            Enum.find(params.games, fn game -> game.serial == game_notification.game_serial end)

          if game.last_active_sessions < game.active_sessions and
               game_notification.new_sessions do
            notification_params
            |> Map.put(
              :body_message,
              "\xF0\x9F\x86\x95 \xF0\x9F\x8E\xAE #{game.name} (#{game.serial}) has #{game.active_sessions} sessions now"
            )
            |> Map.put(:title_message, "New game session in Insignia")
            |> Map.put(:thumbnail, game.thumbnail)
            |> push_notification()
          end

          if game.last_active_sessions > game.active_sessions and
               game_notification.end_sessions do
            notification_params
            |> Map.put(
              :body_message,
              "\xF0\x9F\x9A\xAB \xF0\x9F\x8E\xAE #{game.name} (#{game.serial}) no longer has active sessions"
            )
            |> Map.put(:title_message, "No more game session in this game")
            |> Map.put(:thumbnail, game.thumbnail)
            |> push_notification()
          end
        end)
    end
  end

  defp push_notification(params) do
    sound =
      case SettingsController.get_settings_by_user_id(params.user_id) do
        {:ok, %Setting{notification_sound: notification_sound}} ->
          notification_sound

        {:error, _} ->
          "beep"
      end

    url = "https://fcm.googleapis.com/v1/projects/insignia-notify/messages:send"

    notification_body =
      Jason.encode!(%{
        message: %{
          token: params.user_token,
          notification: %{
            body: params.body_message,
            title: params.title_message,
            image: params.thumbnail
          },
          data: %{
            sound: sound
          }
        }
      })

    headers = [Authorization: "Bearer #{params.server_token}"]

    Api.post(url, notification_body, headers)
  end
end
