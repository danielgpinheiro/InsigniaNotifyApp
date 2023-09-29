defmodule InsigniaNotifyApp.Stats.Statistic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stats" do
    field :registered_users, :string
    field :games_supported, :string
    field :users_online_now, :string

    timestamps()
  end

  def changeset(stats \\ %__MODULE__{}, attrs) do
    fields = __MODULE__.__schema__(:fields)

    stats
    |> cast(attrs, fields)
  end
end
