defmodule HelloPhoenixWeb.DashboardController do
  use HelloPhoenixWeb, :controller

  alias HelloPhoenix.HelloPhoenixWeb

  def features(conn, params) do
    environment = HelloPhoenixWeb.get_environment(params[:environment])
    render(conn, "features.html", %{:environment => environment})
  end
end
