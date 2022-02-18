defmodule Sneakers23.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias Sneakers23.Repo

  alias Sneakers23.Inventory.Product

  alias __MODULE__.{CompleteProduct, DatabaseLoader, Server, Store}

  def child_spec(opts) do
    loader = Keyword.get(opts, :loader, DatabaseLoader)
    name = Keyword.get(opts, :name, __MODULE__)

    %{
      id: Server,
      start: {Server, :start_link, [[loader_mod: loader, name: name]]}
    }
  end

  def get_complete_products(opts \\ []) do
    pid = Keyword.get(opts, :pid, __MODULE__)
    {:ok, inventory} = Server.get_inventory(pid)
    complete_products = CompleteProduct.get_complete_products(inventory)
    {:ok, complete_products}
  end

  def mark_product_released!(id), do: mark_product_released!(id, [])

  def mark_product_released!(product_id, opts) do
    pid = Keyword.get(opts, :pid, __MODULE__)

    %{id: id} = Store.mark_product_released!(product_id) # update database status
    {:ok, inventory} = Server.mark_product_released!(pid, id) #trigger handle_call
    {:ok, product} = CompleteProduct.get_product_by_id(inventory, id)
    Sneaker23Web.notify_product_released(product)

    :ok
  end

  def item_sold!(id), do: item_sold!(id, [])

  def item_sold!(item_id, opts) do
    pid = Keyword.get(opts, :pid, __MODULE__)

    avail = Store.fetch_availability_for_item(item_id)
    {:ok, _old_inv, _inv} = Server.set_item_availability(pid, avail)

    :ok
  end
  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  alias Sneakers23.Inventory.Item

  @doc """
  Returns the list of items.

  ## Examples

      iex> list_items()
      [%Item{}, ...]

  """
  def list_items do
    Repo.all(Item)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id), do: Repo.get!(Item, id)

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change_item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end

  alias Sneakers23.Inventory.Item_availability

  @doc """
  Returns the list of item_availabilities.

  ## Examples

      iex> list_item_availabilities()
      [%Item_availability{}, ...]

  """
  def list_item_availabilities do
    Repo.all(Item_availability)
  end

  @doc """
  Gets a single item_availability.

  Raises `Ecto.NoResultsError` if the Item availability does not exist.

  ## Examples

      iex> get_item_availability!(123)
      %Item_availability{}

      iex> get_item_availability!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item_availability!(id), do: Repo.get!(Item_availability, id)

  @doc """
  Creates a item_availability.

  ## Examples

      iex> create_item_availability(%{field: value})
      {:ok, %Item_availability{}}

      iex> create_item_availability(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item_availability(attrs \\ %{}) do
    %Item_availability{}
    |> Item_availability.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item_availability.

  ## Examples

      iex> update_item_availability(item_availability, %{field: new_value})
      {:ok, %Item_availability{}}

      iex> update_item_availability(item_availability, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item_availability(%Item_availability{} = item_availability, attrs) do
    item_availability
    |> Item_availability.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item_availability.

  ## Examples

      iex> delete_item_availability(item_availability)
      {:ok, %Item_availability{}}

      iex> delete_item_availability(item_availability)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item_availability(%Item_availability{} = item_availability) do
    Repo.delete(item_availability)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item_availability changes.

  ## Examples

      iex> change_item_availability(item_availability)
      %Ecto.Changeset{data: %Item_availability{}}

  """
  def change_item_availability(%Item_availability{} = item_availability, attrs \\ %{}) do
    Item_availability.changeset(item_availability, attrs)
  end
end
