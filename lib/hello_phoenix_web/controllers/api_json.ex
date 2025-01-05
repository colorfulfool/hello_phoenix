defmodule HelloPhoenixWeb.ApiJSON do
  alias HelloPhoenix.FlagState

  def flags(%{flags: flags, identity: identity}) do
    %{
      identity: identity,
      flags: for(flag <- flags, do: data(flag))
    }
  end

  defp data(%FlagState{} = flag_state) do
    %{
      name: flag_state.flag.name,
      enabled: flag_state.enabled,
      value: flag_state.value
    }
  end
end
