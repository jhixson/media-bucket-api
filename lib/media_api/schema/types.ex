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
    field :title, :string
    field :notes, :string
    field :rating, :integer
    field :status, :status
  end
end