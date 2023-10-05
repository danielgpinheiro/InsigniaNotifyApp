defmodule InsigniaNotifyApp.Notifications.Get do
  alias InsigniaNotifyApp.Notifications.Notification
  alias InsigniaNotifyApp.Repo

  import Ecto.Query

  def call(params) do
    case Notification
         |> where(game_serial: ^params.game_serial)
         |> where(user_id: ^params.user_id)
         |> Repo.one() do
      nil -> {:error, :not_found}
      game_notifications -> {:ok, game_notifications}
    end
  end

  def call2(user_id) do
    case Notification
         |> where(user_id: ^user_id)
         |> Repo.all() do
      nil -> {:error, :not_found}
      game_notifications -> {:ok, game_notifications}
    end
  end
end
