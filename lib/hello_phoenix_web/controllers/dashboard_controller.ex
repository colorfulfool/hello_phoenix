defmodule HelloPhoenixWeb.DashboardController do
  use HelloPhoenixWeb, :controller

  alias HelloPhoenix.HelloPhoenixWeb

  def features(conn, params) do
    environment = HelloPhoenixWeb.get_environment(params[:environment])
    flag_states = HelloPhoenixWeb.compute_flags(%{:environment_id => environment.id})
    render(conn, "features.html", %{:environment => environment, :flag_states => flag_states})
  end

  def scheduling(conn, params) do
    environment = HelloPhoenixWeb.get_environment(params[:environment])
    render(conn, "scheduling.html", %{:environment => environment})
  end
end
