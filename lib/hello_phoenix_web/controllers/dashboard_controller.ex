defmodule HelloPhoenixWeb.DashboardController do
  use HelloPhoenixWeb, :controller

  alias HelloPhoenix.HelloPhoenixWeb

  def home(conn, params) do
    environment = HelloPhoenixWeb.get_environment(params[:environment])
    flags = HelloPhoenixWeb.compute_flags(%{:environment => environment.key})

    render(conn, "home.html", %{:flags => flags, :environment => environment})
  end
end
