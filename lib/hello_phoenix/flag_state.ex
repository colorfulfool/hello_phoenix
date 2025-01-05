defmodule HelloPhoenix.FlagState do
  use Ecto.Schema
  import Ecto.Changeset

  schema "flag_states" do
    field :enabled, :boolean, default: false
    field :value, :string
    field :flag_id, :id
    field :environment_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(flag_state, attrs) do
    flag_state
    |> cast(attrs, [:enabled, :value])
    |> validate_required([:enabled, :value])
  end
end
