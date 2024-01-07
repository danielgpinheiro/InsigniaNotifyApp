defmodule InsigniaNotifyApp.Filters.Filter do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "order_by_preferences" do
    field :order_by, :string
    field :user_id, :string

    timestamps()
  end

  def changeset(order_by_preferences \\ %__MODULE__{}, attrs) do
    fields = __MODULE__.__schema__(:fields)

    order_by_preferences
    |> cast(attrs, fields)
  end
end
