defmodule InsigniaNotifyApp.Filters.Filter do
  use Ecto.Schema
  import Ecto.Changeset

  alias InsigniaNotifyApp.Identity.User

  @primary_key {:id, Ecto.ULID, autogenerate: true}
  @foreign_key_type Ecto.ULID
  schema "order_by_preferences" do
    field :order_by, :string
    belongs_to :user, User

    timestamps()
  end

  def changeset(order_by_preferences \\ %__MODULE__{}, attrs) do
    fields = __MODULE__.__schema__(:fields)

    order_by_preferences
    |> cast(attrs, fields)
    |> validate_required([:order_by])
    |> unique_constraint(:user_id, name: :order_by_preferences_user_id_unique)
    |> foreign_key_constraint(:user_id)
  end
end
