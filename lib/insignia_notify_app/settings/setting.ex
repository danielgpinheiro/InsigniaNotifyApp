defmodule InsigniaNotifyApp.Settings.Setting do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "notification_settings" do
    field :notification_sound, :string
    field :user_id, :string

    timestamps()
  end

  def changeset(notification_settings \\ %__MODULE__{}, attrs) do
    fields = __MODULE__.__schema__(:fields)

    notification_settings
    |> cast(attrs, fields)
    |> validate_required([:notification_sound])
  end
end
