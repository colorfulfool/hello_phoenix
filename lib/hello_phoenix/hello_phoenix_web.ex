defmodule HelloPhoenix.HelloPhoenixWeb do
  import Ecto.Query, warn: false

  alias HelloPhoenix.Environment
  alias HelloPhoenix.Repo
  alias HelloPhoenix.Flag
  alias HelloPhoenix.FlagState
  alias HelloPhoenixWeb.Endpoint

  def get_environment(nil) do
    Environment |> Repo.one()
  end

  def get_environment(key) do
    Environment |> where(key: ^key) |> Repo.one()
  end

  def list_environments() do
    Environment |> order_by(asc: :name) |> Repo.all()
  end

  def list_flags(%{:environment_id => environment_id}) do
    FlagState
    |> join(:inner, [fs], f in assoc(fs, :flag))
    |> where([fs], fs.environment_id == ^environment_id)
    |> order_by([fs, f], asc: f.name)
  end

  def list_flags(%{:environment_key => environment_key}) do
    environment = from e in Environment, select: e.id, where: e.key == ^environment_key

    FlagState
    |> join(:inner, [fs], f in assoc(fs, :flag))
    |> where([fs], fs.environment_id == subquery(environment))
    |> order_by([fs, f], asc: f.name)
  end

  def compute_flags(%{:environment_key => environment_key, :identity_key => _identity_key}) do
    list_flags(%{:environment_key => environment_key})
    |> select([fs, f], %{:name => f.name, :enabled => fs.enabled, :value => fs.value})
    |> Repo.all()
  end

  def compute_flags(%{:environment_id => environment_id}) do
    list_flags(%{:environment_id => environment_id})
    |> preload([fs, f], flag: f)
    |> Repo.all()
  end

  def compute_flags(%{:environment_key => environment_key}) do
    list_flags(%{:environment_key => environment_key})
    |> preload([fs, f], flag: f)
    |> Repo.all()
  end

  def get_flag!(id), do: Repo.get!(Flag, id)

  def create_flag(attrs \\ %{}) do
    %Flag{}
    |> Flag.changeset(attrs)
    |> Repo.insert()
  end

  def update_flag_state(%FlagState{} = flag_state, attrs) do
    case change_flag_state(flag_state, attrs) |> Repo.update() do
      {:ok, new_flag_state} ->
        Endpoint.broadcast("flag_states", "item_changed", new_flag_state)
    end
  end

  def delete_flag(%Flag{} = flag) do
    Repo.delete(flag)
  end

  def change_flag_state(%FlagState{} = flag_state, attrs \\ %{}) do
    FlagState.changeset(flag_state, attrs)
  end

  def set_flag_state_enabled(id, value) do
    FlagState |> where(id: ^id) |> Repo.update_all(set: [enabled: value])
  end
end
