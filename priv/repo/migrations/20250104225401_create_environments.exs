defmodule HelloPhoenix.Repo.Migrations.CreateEnvironments do
  use Ecto.Migration

  def change do
    create table(:environments) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
