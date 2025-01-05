defmodule HelloPhoenixWeb.ApiController do
  use HelloPhoenixWeb, :controller

  alias HelloPhoenix.HelloPhoenixWeb

  action_fallback HelloPhoenixWeb.FallbackController

  def flags(conn, %{"environment" => environment, "identity" => identity}) do
    flags = HelloPhoenixWeb.compute_flags(%{:environment => environment})
    render(conn, "flags.json", flags: flags, identity: identity)
  end
end
