defmodule InsigniaNotifyApp.Repo.Migrations.AddGameNotificationPreferences do
  use Ecto.Migration

  def change do
    create table(:game_notification_preferences, primary_key: false) do
      add :game_serial, :string, primary_key: true
      add :new_sessions, :boolean
      add :end_sessions, :boolean
      add :new_players, :boolean
      add :fewer_players, :boolean
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end
  end
end
