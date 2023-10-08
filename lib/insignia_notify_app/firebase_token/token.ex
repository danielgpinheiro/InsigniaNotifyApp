defmodule InsigniaNotifyApp.FirebaseToken.Token do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.ULID, autogenerate: true}
  schema "firebase_token_users" do
    field :firebase_token, :string
    field :user_id, :string

    timestamps()
  end

  def changeset(firebase_toke \\ %__MODULE__{}, attrs) do
    fields = __MODULE__.__schema__(:fields)

    firebase_toke
    |> cast(attrs, fields)
  end
end
