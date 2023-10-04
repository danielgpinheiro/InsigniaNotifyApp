defmodule InsigniaNotifyAppWeb.NotificationController do
  use InsigniaNotifyAppWeb, :controller

  def test() do
    # https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send
    IO.inspect("TESSTEEEE")
  end
end
