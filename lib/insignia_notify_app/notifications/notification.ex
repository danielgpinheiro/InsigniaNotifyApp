defmodule InsigniaNotifyApp.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "game_notification_preferences" do
    field :game_serial, :string
    field :new_sessions, :boolean
    field :end_sessions, :boolean
    field :new_players, :boolean
    field :fewer_players, :boolean
    field :user_id, :string

    timestamps()
  end

  def changeset(game_notification \\ %__MODULE__{}, attrs) do
    fields = __MODULE__.__schema__(:fields)

    game_notification
    |> cast(attrs, fields)
  end
end
