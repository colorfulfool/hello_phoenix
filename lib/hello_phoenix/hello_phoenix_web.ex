defmodule HelloPhoenix.HelloPhoenixWeb do
  import Ecto.Query, warn: false
  alias HelloPhoenix.Repo

  alias HelloPhoenix.HelloPhoenixWeb.Flag

  def compute_flags(%{:environment_id => environment_id}) do
    FlagState
    |> where(environment_id: ^environment_id)
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
