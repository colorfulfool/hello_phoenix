defmodule HelloPhoenix.Environment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "environments" do
    field :name, :string
    field :key, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(environment, attrs) do
    environment
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
