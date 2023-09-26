defmodule InsigniaNotifyApp.Settings.Setting do
  use Ecto.Schema
  import Ecto.Changeset

  alias InsigniaNotifyApp.Identity.User

  @required_params [:notification_sound, :user_id]

  @primary_key {:id, Ecto.ULID, autogenerate: true}
  @foreign_key_type Ecto.ULID
  schema "notification_settings" do
    field :notification_sound, :string
    belongs_to :user, User

    timestamps()
  end

  def changeset(notification_settings \\ %__MODULE__{}, attrs) do
    fields = __MODULE__.__schema__(:fields)

    notification_settings
    |> cast(attrs, fields)
    |> validate_required([:notification_sound])
    |> unique_constraint(:user_id, name: :notification_settings_user_id_unique)
    |> foreign_key_constraint(:user_id)
  end
end
