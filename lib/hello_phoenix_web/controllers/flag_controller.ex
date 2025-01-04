defmodule HelloPhoenixWeb.FlagController do
  use HelloPhoenixWeb, :controller

  alias HelloPhoenix.HelloPhoenixWeb
  alias HelloPhoenix.HelloPhoenixWeb.Flag

  action_fallback HelloPhoenixWeb.FallbackController

  def index(conn, _params) do
    flags = HelloPhoenixWeb.list_flags()
    render(conn, :index, flags: flags)
  end

  def create(conn, %{"flag" => flag_params}) do
    with {:ok, %Flag{} = flag} <- HelloPhoenixWeb.create_flag(flag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/flags/#{flag}")
      |> render(:show, flag: flag)
    end
  end

  def show(conn, %{"id" => id}) do
    flag = HelloPhoenixWeb.get_flag!(id)
    render(conn, :show, flag: flag)
  end

  def update(conn, %{"id" => id, "flag" => flag_params}) do
    flag = HelloPhoenixWeb.get_flag!(id)

    with {:ok, %Flag{} = flag} <- HelloPhoenixWeb.update_flag(flag, flag_params) do
      render(conn, :show, flag: flag)
    end
  end

  def delete(conn, %{"id" => id}) do
    flag = HelloPhoenixWeb.get_flag!(id)

    with {:ok, %Flag{}} <- HelloPhoenixWeb.delete_flag(flag) do
      send_resp(conn, :no_content, "")
    end
  end
end
