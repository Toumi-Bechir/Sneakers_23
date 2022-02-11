defmodule Sneakers23Web.Item_availabilityControllerTest do
  use Sneakers23Web.ConnCase

  import Sneakers23.InventoryFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all item_availabilities", %{conn: conn} do
      conn = get(conn, Routes.item_availability_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Item availabilities"
    end
  end

  describe "new item_availability" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.item_availability_path(conn, :new))
      assert html_response(conn, 200) =~ "New Item availability"
    end
  end

  describe "create item_availability" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.item_availability_path(conn, :create), item_availability: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.item_availability_path(conn, :show, id)

      conn = get(conn, Routes.item_availability_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Item availability"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.item_availability_path(conn, :create), item_availability: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Item availability"
    end
  end

  describe "edit item_availability" do
    setup [:create_item_availability]

    test "renders form for editing chosen item_availability", %{conn: conn, item_availability: item_availability} do
      conn = get(conn, Routes.item_availability_path(conn, :edit, item_availability))
      assert html_response(conn, 200) =~ "Edit Item availability"
    end
  end

  describe "update item_availability" do
    setup [:create_item_availability]

    test "redirects when data is valid", %{conn: conn, item_availability: item_availability} do
      conn = put(conn, Routes.item_availability_path(conn, :update, item_availability), item_availability: @update_attrs)
      assert redirected_to(conn) == Routes.item_availability_path(conn, :show, item_availability)

      conn = get(conn, Routes.item_availability_path(conn, :show, item_availability))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, item_availability: item_availability} do
      conn = put(conn, Routes.item_availability_path(conn, :update, item_availability), item_availability: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Item availability"
    end
  end

  describe "delete item_availability" do
    setup [:create_item_availability]

    test "deletes chosen item_availability", %{conn: conn, item_availability: item_availability} do
      conn = delete(conn, Routes.item_availability_path(conn, :delete, item_availability))
      assert redirected_to(conn) == Routes.item_availability_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.item_availability_path(conn, :show, item_availability))
      end
    end
  end

  defp create_item_availability(_) do
    item_availability = item_availability_fixture()
    %{item_availability: item_availability}
  end
end
