defmodule HelloPhoenixWeb.ApiJSON do
  alias HelloPhoenix.FlagState

  def flags(%{flags: flags, identity: identity}) do
    %{
      identity: identity,
      flags: flags
    }
  end
end
