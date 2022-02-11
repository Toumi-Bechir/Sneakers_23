defmodule Sneakers23.Inventory.Item_availability do
  use Ecto.Schema
  import Ecto.Changeset

  schema "item_availabilities" do
    field :available_count, :integer
    belongs_to :item, Sneakers23.Inventory.Item

    timestamps()
  end

  @doc false
  def changeset(item_availability, attrs) do
    item_availability
    |> cast(attrs, [])
    |> validate_required([])
  end
end