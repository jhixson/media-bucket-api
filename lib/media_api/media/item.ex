defmodule MediaApi.Media.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :notes, :string
    field :rating, :integer
    field :status, Ecto.Enum, values: [:pending, :started, :finished]
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:title, :notes, :rating, :status])
    |> validate_required([:title])
  end
end
