defmodule MediaApi.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :title, :string, null: false
      add :notes, :text
      add :rating, :integer
      add :status, :string, default: "pending"

      timestamps()
    end

  end
end
