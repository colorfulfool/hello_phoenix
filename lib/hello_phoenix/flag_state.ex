defmodule HelloPhoenix.FlagState do
  use Ecto.Schema
  import Ecto.Changeset

  alias HelloPhoenix.Flag

  schema "flag_states" do
    field :enabled, :boolean, default: false
    field :value, :string
    field :environment_id, :id
    belongs_to :flag, Flag

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(flag_state, attrs) do
    flag_state
    |> cast(attrs, [:enabled, :value])
    |> validate_required([:enabled, :value])
  end
end
