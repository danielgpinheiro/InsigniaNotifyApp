defmodule InsigniaNotifyApp.Repo.Migrations.AddGameNotificationPreferences do
  use Ecto.Migration

  def change do
    create table(:game_notification_preferences, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :game_serial, :string
      add :new_sessions, :boolean
      add :end_sessions, :boolean
      add :new_players, :boolean
      add :fewer_players, :boolean
      add :user_id, :string

      timestamps()
    end
  end
end
