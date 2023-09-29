defmodule InsigniaNotifyApp.Repo.Migrations.AddStatsTable do
  use Ecto.Migration

  def change do
    create table(:stats) do
      add :id, :integer, primary_key: true
      add :registered_users, :string
      add :games_supported, :string
      add :users_online_now, :string

      timestamps()
    end
  end
end
