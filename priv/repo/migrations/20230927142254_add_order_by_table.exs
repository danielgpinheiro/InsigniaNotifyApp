defmodule InsigniaNotifyApp.Repo.Migrations.AddOrderByTable do
  use Ecto.Migration

  def change do
    create table(:order_by_preferences, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :order_by, :string
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create unique_index(:order_by_preferences, [:user_id],
             name: :order_by_preferences_user_id_unique
           )
  end
end
