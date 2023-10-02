defmodule InsigniaNotifyApp.Repo.Migrations.AddGamesTable do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :serial, :string, primary_key: true
      add :name, :string
      add :url, :string
      add :thumbnail, :string
      add :code, :string
      add :online_users, :integer
      add :active_users, :integer
      add :active_sessions, :integer
      add :last_active_users, :integer
      add :last_active_sessions, :integer
      add :has_leaderboards_feature, :boolean
      add :has_live_aware_feature, :boolean
      add :has_matchmaking_feature, :boolean
      add :has_user_generated_content_feature, :boolean
    end

    create index(:games, [:serial])
  end
end
