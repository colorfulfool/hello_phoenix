defmodule HelloPhoenixWeb.FlagControllerTest do
  use HelloPhoenixWeb.ConnCase

  import HelloPhoenix.HelloPhoenixWebFixtures

  alias HelloPhoenix.HelloPhoenixWeb.Flag

  @create_attrs %{
    enabled: true,
    name: "some name",
    value: "some value",
    description: "some description"
  }
  @update_attrs %{
    enabled: false,
    name: "some updated name",
    value: "some updated value",
    description: "some updated description"
  }
  @invalid_attrs %{enabled: nil, name: nil, value: nil, description: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all flags", %{conn: conn} do
      conn = get(conn, ~p"/api/flags")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create flag" do
    test "renders flag when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/flags", flag: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/flags/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "enabled" => true,
               "name" => "some name",
               "value" => "some value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/flags", flag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update flag" do
    setup [:create_flag]

    test "renders flag when data is valid", %{conn: conn, flag: %Flag{id: id} = flag} do
      conn = put(conn, ~p"/api/flags/#{flag}", flag: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/flags/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "enabled" => false,
               "name" => "some updated name",
               "value" => "some updated value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, flag: flag} do
      conn = put(conn, ~p"/api/flags/#{flag}", flag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete flag" do
    setup [:create_flag]

    test "deletes chosen flag", %{conn: conn, flag: flag} do
      conn = delete(conn, ~p"/api/flags/#{flag}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/flags/#{flag}")
      end
    end
  end

  defp create_flag(_) do
    flag = flag_fixture()
    %{flag: flag}
  end
end
