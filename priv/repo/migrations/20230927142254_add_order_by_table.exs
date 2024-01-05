defmodule InsigniaNotifyApp.Repo.Migrations.AddOrderByTable do
  use Ecto.Migration

  def change do
    create table(:order_by_preferences, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :order_by, :string
      add :user_id, :string

      timestamps()
    end
  end
end
