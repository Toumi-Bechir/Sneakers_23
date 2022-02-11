defmodule Sneakers23Web.Item_availabilityController do
  use Sneakers23Web, :controller

  alias Sneakers23.Inventory
  alias Sneakers23.Inventory.Item_availability

  def index(conn, _params) do
    item_availabilities = Inventory.list_item_availabilities()
    render(conn, "index.html", item_availabilities: item_availabilities)
  end

  def new(conn, _params) do
    changeset = Inventory.change_item_availability(%Item_availability{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"item_availability" => item_availability_params}) do
    case Inventory.create_item_availability(item_availability_params) do
      {:ok, item_availability} ->
        conn
        |> put_flash(:info, "Item availability created successfully.")
        |> redirect(to: Routes.item_availability_path(conn, :show, item_availability))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    item_availability = Inventory.get_item_availability!(id)
    render(conn, "show.html", item_availability: item_availability)
  end

  def edit(conn, %{"id" => id}) do
    item_availability = Inventory.get_item_availability!(id)
    changeset = Inventory.change_item_availability(item_availability)
    render(conn, "edit.html", item_availability: item_availability, changeset: changeset)
  end

  def update(conn, %{"id" => id, "item_availability" => item_availability_params}) do
    item_availability = Inventory.get_item_availability!(id)

    case Inventory.update_item_availability(item_availability, item_availability_params) do
      {:ok, item_availability} ->
        conn
        |> put_flash(:info, "Item availability updated successfully.")
        |> redirect(to: Routes.item_availability_path(conn, :show, item_availability))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", item_availability: item_availability, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    item_availability = Inventory.get_item_availability!(id)
    {:ok, _item_availability} = Inventory.delete_item_availability(item_availability)

    conn
    |> put_flash(:info, "Item availability deleted successfully.")
    |> redirect(to: Routes.item_availability_path(conn, :index))
  end
end
