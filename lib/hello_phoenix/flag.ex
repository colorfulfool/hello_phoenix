defmodule HelloPhoenix.Flag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "flags" do
    field :name, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(flag, attrs) do
    flag
    |> cast(attrs, [:name, :description, :enabled, :value])
    |> validate_required([:name, :description, :enabled, :value])
  end
end
