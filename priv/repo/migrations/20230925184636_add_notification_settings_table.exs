defmodule InsigniaNotifyApp.Repo.Migrations.AddNotificationSettingsTable do
  use Ecto.Migration

  def change do
    create table(:notification_settings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :notification_sound, :string
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create unique_index(:notification_settings, [:user_id],
             name: :notification_settings_user_id_unique
           )
  end
end
