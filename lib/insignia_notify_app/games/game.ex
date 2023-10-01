defmodule InsigniaNotifyApp.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:serial, :string, []}
  schema "games" do
    field :name, :string
    field :url, :string
    field :thumbnail, :string
    field :code, :string
    field :online_users, :integer
    field :active_players, :integer
    field :active_sessions, :integer
    field :last_active_players, :integer
    field :last_active_sessions, :integer
    field :has_leaderboards_feature, :boolean
    field :has_live_aware_feature, :boolean
    field :has_matchmaking_feature, :boolean
    field :has_user_generated_content_feature, :boolean
  end

  def changeset(game \\ %__MODULE__{}, attrs) do
    fields = __MODULE__.__schema__(:fields)

    game
    |> cast(attrs, fields)
  end
end
