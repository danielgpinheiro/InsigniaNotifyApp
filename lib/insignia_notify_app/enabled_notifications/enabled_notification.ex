defmodule InsigniaNotifyApp.EnabledNotifications.EnabledNotification do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "enabled_notifications" do
    field :enabled, :boolean
    field :user_id, :string

    timestamps()
  end

  def changeset(enabled_notifications \\ %__MODULE__{}, attrs) do
    fields = __MODULE__.__schema__(:fields)

    enabled_notifications
    |> cast(attrs, fields)
  end
end
