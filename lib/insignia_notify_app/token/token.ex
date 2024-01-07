defmodule InsigniaNotifyApp.Token.Token do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "token_users" do
    field :user_token, :string
    field :old_token, :string

    timestamps()
  end

  def changeset(token_users \\ %__MODULE__{}, attrs) do
    fields = __MODULE__.__schema__(:fields)

    token_users
    |> cast(attrs, fields)
  end
end
