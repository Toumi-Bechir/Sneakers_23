defmodule Sneakers23.InventoryTest do
  use Sneakers23.DataCase

  alias Sneakers23.Inventory

  describe "products" do
    alias Sneakers23.Inventory.Product

    import Sneakers23.InventoryFixtures

    @invalid_attrs %{}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Inventory.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Inventory.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{}

      assert {:ok, %Product{} = product} = Inventory.create_product(valid_attrs)
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{}

      assert {:ok, %Product{} = product} = Inventory.update_product(product, update_attrs)
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_product(product, @invalid_attrs)
      assert product == Inventory.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Inventory.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Inventory.change_product(product)
    end

    test "the update is sent to the client", %{test: test_name} do
      {_,%{p1: p1}} = Test.Factory.InventoryFactory.complete_products()
      {:ok, pid} = Server.start_link(name: test_name, Loader_mod: DatabaseLoader)
      Sneakers23Web.Endpoint.subscribe("product:#{p1.id}")

      Inventory.mark_product_released!(p1.id, pid: pid)
      assert_received %Phoenix.Socket.Broadcast{event: "released"}
    end
  end

  describe "items" do
    alias Sneakers23.Inventory.Item

    import Sneakers23.InventoryFixtures

    @invalid_attrs %{}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Inventory.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Inventory.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{}

      assert {:ok, %Item{} = item} = Inventory.create_item(valid_attrs)
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{}

      assert {:ok, %Item{} = item} = Inventory.update_item(item, update_attrs)
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_item(item, @invalid_attrs)
      assert item == Inventory.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Inventory.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Inventory.change_item(item)
    end
  end

  describe "item_availabilities" do
    alias Sneakers23.Inventory.Item_availability

    import Sneakers23.InventoryFixtures

    @invalid_attrs %{}

    test "list_item_availabilities/0 returns all item_availabilities" do
      item_availability = item_availability_fixture()
      assert Inventory.list_item_availabilities() == [item_availability]
    end

    test "get_item_availability!/1 returns the item_availability with given id" do
      item_availability = item_availability_fixture()
      assert Inventory.get_item_availability!(item_availability.id) == item_availability
    end

    test "create_item_availability/1 with valid data creates a item_availability" do
      valid_attrs = %{}

      assert {:ok, %Item_availability{} = item_availability} = Inventory.create_item_availability(valid_attrs)
    end

    test "create_item_availability/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_item_availability(@invalid_attrs)
    end

    test "update_item_availability/2 with valid data updates the item_availability" do
      item_availability = item_availability_fixture()
      update_attrs = %{}

      assert {:ok, %Item_availability{} = item_availability} = Inventory.update_item_availability(item_availability, update_attrs)
    end

    test "update_item_availability/2 with invalid data returns error changeset" do
      item_availability = item_availability_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_item_availability(item_availability, @invalid_attrs)
      assert item_availability == Inventory.get_item_availability!(item_availability.id)
    end

    test "delete_item_availability/1 deletes the item_availability" do
      item_availability = item_availability_fixture()
      assert {:ok, %Item_availability{}} = Inventory.delete_item_availability(item_availability)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_item_availability!(item_availability.id) end
    end

    test "change_item_availability/1 returns a item_availability changeset" do
      item_availability = item_availability_fixture()
      assert %Ecto.Changeset{} = Inventory.change_item_availability(item_availability)
    end
  end
end
