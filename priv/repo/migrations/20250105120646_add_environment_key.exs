defmodule HelloPhoenix.Repo.Migrations.AddEnvironmentKey do
  use Ecto.Migration

  def change do
    alter table(:environments) do
      add :key, :string
    end
  end
end
