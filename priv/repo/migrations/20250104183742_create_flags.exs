defmodule HelloPhoenix.Repo.Migrations.CreateFlags do
  use Ecto.Migration

  def change do
    create table(:flags) do
      add :name, :string
      add :description, :text
      add :enabled, :boolean, default: false, null: false
      add :value, :string

      timestamps(type: :utc_datetime)
    end
  end
end
