defmodule HelloPhoenixWeb.ApiController do
  use HelloPhoenixWeb, :controller

  alias HelloPhoenix.HelloPhoenixWeb

  def flags(conn, %{"environment" => environment_key, "identity" => identity_key}) do
    flags =
      HelloPhoenixWeb.compute_flags(%{
        :environment_key => environment_key,
        :identity_key => identity_key
      })

    render(conn, "flags.json", flags: flags, identity: identity_key)
  end
end
