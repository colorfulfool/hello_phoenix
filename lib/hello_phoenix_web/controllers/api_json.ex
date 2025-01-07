defmodule HelloPhoenixWeb.ApiJSON do
  def flags(%{flags: flags, identity: identity}) do
    %{
      identity: identity,
      flags: flags
    }
  end
end
