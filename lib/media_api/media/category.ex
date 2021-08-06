defmodule MediaApi.Media.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias MediaApi.Media.Item

  schema "categories" do
    field :title, :string

    has_many(:items, Item)

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
