defmodule HelloPhoenix.Repo.Migrations.RemoveFlagColumns do
  use Ecto.Migration

  def change do
    alter table(:flags) do
      remove :enabled
      remove :value
    end
  end
end
