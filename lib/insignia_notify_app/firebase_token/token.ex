defmodule InsigniaNotifyApp.FirebaseToken.Token do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "firebase_token_users" do
    field :token, :string

    timestamps()
  end

  def changeset(firebase_token \\ %__MODULE__{}, attrs) do
    fields = __MODULE__.__schema__(:fields)

    firebase_token
    |> cast(attrs, fields)
  end
end
