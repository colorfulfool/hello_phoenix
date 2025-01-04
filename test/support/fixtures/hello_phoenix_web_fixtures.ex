defmodule HelloPhoenix.HelloPhoenixWebFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelloPhoenix.HelloPhoenixWeb` context.
  """

  @doc """
  Generate a flag.
  """
  def flag_fixture(attrs \\ %{}) do
    {:ok, flag} =
      attrs
      |> Enum.into(%{
        description: "some description",
        enabled: true,
        name: "some name",
        value: "some value"
      })
      |> HelloPhoenix.HelloPhoenixWeb.create_flag()

    flag
  end
end
