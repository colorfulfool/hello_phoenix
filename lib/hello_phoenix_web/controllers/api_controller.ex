defmodule HelloPhoenixWeb.ApiController do
  use HelloPhoenixWeb, :controller

  alias HelloPhoenix.HelloPhoenixWeb

  action_fallback HelloPhoenixWeb.FallbackController

  def flags(conn, %{"identity" => identity, "environment" => environment}) do
    render(conn, "flags.json", %{
      :flags => HelloPhoenixWeb.compute_flags(%{"environment" => environment}),
      :identity => identity
    })
  end
end
