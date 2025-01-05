defmodule HelloPhoenix.Repo.Migrations.CreateFlagStates do
  use Ecto.Migration

  def change do
    create table(:flag_states) do
      add :enabled, :boolean, default: false, null: false
      add :value, :string
      add :flag_id, references(:flags, on_delete: :nothing)
      add :environment_id, references(:environments, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:flag_states, [:flag_id])
    create index(:flag_states, [:environment_id])
  end
end
