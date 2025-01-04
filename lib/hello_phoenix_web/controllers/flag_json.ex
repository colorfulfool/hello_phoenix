defmodule HelloPhoenixWeb.FlagJSON do
  alias HelloPhoenix.HelloPhoenixWeb.Flag

  @doc """
  Renders a list of flags.
  """
  def index(%{flags: flags}) do
    %{data: for(flag <- flags, do: data(flag))}
  end

  @doc """
  Renders a single flag.
  """
  def show(%{flag: flag}) do
    %{data: data(flag)}
  end

  defp data(%Flag{} = flag) do
    %{
      id: flag.id,
      name: flag.name,
      description: flag.description,
      enabled: flag.enabled,
      value: flag.value
    }
  end
end
