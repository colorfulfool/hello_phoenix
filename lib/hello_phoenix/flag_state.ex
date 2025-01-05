defmodule HelloPhoenix.FlagState do
  use Ecto.Schema
  import Ecto.Changeset

  alias HelloPhoenix.Flag
  alias HelloPhoenix.Environment

  schema "flag_states" do
    field :enabled, :boolean, default: false
    field :value, :string

    belongs_to :flag, Flag
    belongs_to :environment, Environment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(flag_state, attrs) do
    flag_state
    |> cast(attrs, [:enabled, :value])
    |> validate_required([:enabled, :value])
  end
end
