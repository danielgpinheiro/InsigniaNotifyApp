defmodule InsigniaNotifyAppWeb.NotificationController do
  use InsigniaNotifyAppWeb, :controller

  alias InsigniaNotifyAppWeb.Http.Api

  def check_to_send_notification(params) do
    %{
      user_token: params.firebase_user_token,
      user_id: params.user_id,
      server_token: Goth.fetch!(InsigniaNotifyApp.Goth).token
    }
    |> push_notification()
  end

  defp push_notification(params) do
    body_message =
      "\xF0\x9F\x86\x95 \xF0\x9F\x8E\xAE game_name (game_serial) has game_active_players active players and game_active_sessions sessions now"

    no_session_message =
      "\xF0\x9F\x9A\xAB \xF0\x9F\x8E\xAE game_name (game_serial) no longer has active sessions"

    title_message = "New game session in Insignia"
    # title_message = "No more game session in this game"

    url = "https://fcm.googleapis.com/v1/projects/insignia-notify/messages:send"

    notification_body =
      Jason.encode!(%{
        message: %{
          token: params.user_token,
          notification: %{
            body: body_message,
            title: title_message,
            image: "https://r2-cdn.insignia.live/Shl9AF66oSfXRmcAdNj580DyHtpLfm8ETKBnnD1i.png"
          },
          data: %{
            sound: "beep"
          }
        }
      })

    headers = [Authorization: "Bearer #{params.server_token}"]

    # Api.post(url, notification_body, headers)
  end
end
