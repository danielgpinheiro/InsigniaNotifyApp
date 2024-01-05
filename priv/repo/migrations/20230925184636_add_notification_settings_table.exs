defmodule InsigniaNotifyApp.Repo.Migrations.AddNotificationSettingsTable do
  use Ecto.Migration

  def change do
    create table(:notification_settings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :notification_sound, :string
      add :user_id, :string

      timestamps()
    end
  end
end
