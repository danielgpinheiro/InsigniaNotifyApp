defmodule InsigniaNotifyApp.Repo.Migrations.AddFirebaseTokenUsers do
  use Ecto.Migration

  def change do
    create table(:firebase_token_users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :firebase_token, :string
      add :user_id, :string

      timestamps()
    end
  end
end
