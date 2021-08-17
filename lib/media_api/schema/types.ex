defmodule MediaApi.Schema.Types do
  use Absinthe.Schema.Notation

  enum :status do
    description "Media item statuses"
    value :pending, description: "Not Started"
    value :started, description: "Started"
    value :finished, description: "Finished"
  end

  @desc "An item"
  object :item do
    field :id, non_null(:integer)
    field :category_id, non_null(:integer)
    field :title, non_null(:string)
    field :notes, :string
    field :rating, :integer
    field :status, :status
  end

  input_object :item_input do
    field :category_id, non_null(:integer)
    field :title, non_null(:string)
    field :notes, :string
    field :rating, :integer
    field :status, :status
  end

  @desc "A category"
  object :category do
    field :id, non_null(:integer)
    field :title, non_null(:string)
    field :items, non_null(list_of(non_null(:item)))
  end
end
