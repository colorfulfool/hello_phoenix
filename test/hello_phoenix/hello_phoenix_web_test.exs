defmodule HelloPhoenix.HelloPhoenixWebTest do
  use HelloPhoenix.DataCase

  alias HelloPhoenix.HelloPhoenixWeb

  describe "flags" do
    alias HelloPhoenix.HelloPhoenixWeb.Flag

    import HelloPhoenix.HelloPhoenixWebFixtures

    @invalid_attrs %{enabled: nil, name: nil, value: nil, description: nil}

    test "list_flags/0 returns all flags" do
      flag = flag_fixture()
      assert HelloPhoenixWeb.list_flags() == [flag]
    end

    test "get_flag!/1 returns the flag with given id" do
      flag = flag_fixture()
      assert HelloPhoenixWeb.get_flag!(flag.id) == flag
    end

    test "create_flag/1 with valid data creates a flag" do
      valid_attrs = %{enabled: true, name: "some name", value: "some value", description: "some description"}

      assert {:ok, %Flag{} = flag} = HelloPhoenixWeb.create_flag(valid_attrs)
      assert flag.enabled == true
      assert flag.name == "some name"
      assert flag.value == "some value"
      assert flag.description == "some description"
    end

    test "create_flag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HelloPhoenixWeb.create_flag(@invalid_attrs)
    end

    test "update_flag/2 with valid data updates the flag" do
      flag = flag_fixture()
      update_attrs = %{enabled: false, name: "some updated name", value: "some updated value", description: "some updated description"}

      assert {:ok, %Flag{} = flag} = HelloPhoenixWeb.update_flag(flag, update_attrs)
      assert flag.enabled == false
      assert flag.name == "some updated name"
      assert flag.value == "some updated value"
      assert flag.description == "some updated description"
    end

    test "update_flag/2 with invalid data returns error changeset" do
      flag = flag_fixture()
      assert {:error, %Ecto.Changeset{}} = HelloPhoenixWeb.update_flag(flag, @invalid_attrs)
      assert flag == HelloPhoenixWeb.get_flag!(flag.id)
    end

    test "delete_flag/1 deletes the flag" do
      flag = flag_fixture()
      assert {:ok, %Flag{}} = HelloPhoenixWeb.delete_flag(flag)
      assert_raise Ecto.NoResultsError, fn -> HelloPhoenixWeb.get_flag!(flag.id) end
    end

    test "change_flag/1 returns a flag changeset" do
      flag = flag_fixture()
      assert %Ecto.Changeset{} = HelloPhoenixWeb.change_flag(flag)
    end
  end
end
