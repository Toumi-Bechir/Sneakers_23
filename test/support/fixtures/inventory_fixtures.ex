defmodule Sneakers23.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sneakers23.Inventory` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{

      })
      |> Sneakers23.Inventory.create_product()

    product
  end

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{

      })
      |> Sneakers23.Inventory.create_item()

    item
  end

  @doc """
  Generate a item_availability.
  """
  def item_availability_fixture(attrs \\ %{}) do
    {:ok, item_availability} =
      attrs
      |> Enum.into(%{

      })
      |> Sneakers23.Inventory.create_item_availability()

    item_availability
  end
end
