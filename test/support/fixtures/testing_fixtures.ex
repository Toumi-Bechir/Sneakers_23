defmodule Sneakers23.TestingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sneakers23.Testing` context.
  """

  @doc """
  Generate a test.
  """
  def test_fixture(attrs \\ %{}) do
    {:ok, test} =
      attrs
      |> Enum.into(%{

      })
      |> Sneakers23.Testing.create_test()

    test
  end
end
