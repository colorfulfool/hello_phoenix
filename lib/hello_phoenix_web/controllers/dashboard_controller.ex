defmodule HelloPhoenixWeb.DashboardController do
  use HelloPhoenixWeb, :controller

  alias HelloPhoenix.HelloPhoenixWeb

  def features(conn, params) do
    environment = HelloPhoenixWeb.get_environment(params[:environment])
    flags = HelloPhoenixWeb.compute_flags(%{:environment_key => environment.key})

    render(conn, "features.html", %{:flags => flags, :environment => environment})
  end
end
