defmodule InsigniaNotifyApp.Repo.Migrations.AddEnabledNotificationTable do
  use Ecto.Migration

  def change do
    create table(:enabled_notifications, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :enabled, :boolean
      add :user_id, :string

      timestamps()
    end
  end
end
