defmodule HelloPhoenix.HelloPhoenixWeb do
  import Ecto.Query, warn: false
  alias HelloPhoenix.Environment
  alias HelloPhoenix.Repo

  alias HelloPhoenix.Flag
  alias HelloPhoenix.FlagState

  def list_flags(%{:environment => environment_key}) do
    environment = from e in Environment, select: e.id, where: e.key == ^environment_key

    FlagState
    |> join(:inner, [fs], f in assoc(fs, :flag))
    |> where([fs], fs.environment_id == subquery(environment))
  end

  def compute_flags(%{:environment => environment_key, :identity => identity_key}) do
    list_flags(%{:environment => environment_key})
    |> select([fs, f], %{:name => f.name, :enabled => fs.enabled, :value => fs.value})
    |> Repo.all()
  end

  def compute_flags(%{:environment => environment_key}) do
    list_flags(%{:environment => environment_key})
    |> preload([fs, f], flag: f)
    |> Repo.all()
  end

  def get_flag!(id), do: Repo.get!(Flag, id)

  def create_flag(attrs \\ %{}) do
    %Flag{}
    |> Flag.changeset(attrs)
    |> Repo.insert()
  end

  def update_flag(%Flag{} = flag, attrs) do
    flag
    |> Flag.changeset(attrs)
    |> Repo.update()
  end

  def delete_flag(%Flag{} = flag) do
    Repo.delete(flag)
  end

  def change_flag(%Flag{} = flag, attrs \\ %{}) do
    Flag.changeset(flag, attrs)
  end
end
