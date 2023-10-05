defmodule InsigniaNotifyApp.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  alias InsigniaNotifyApp.Identity.User

  @primary_key {:game_serial, :string, []}
  @foreign_key_type Ecto.ULID
  schema "game_notification_preferences" do
    field :new_sessions, :boolean
    field :end_sessions, :boolean
    field :new_players, :boolean
    field :fewer_players, :boolean
    belongs_to :user, User

    timestamps()
  end

  def changeset(game_notification \\ %__MODULE__{}, attrs) do
    fields = __MODULE__.__schema__(:fields)

    game_notification
    |> cast(attrs, fields)
    |> foreign_key_constraint(:user_id)
  end
end
