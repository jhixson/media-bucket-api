defmodule MediaApi.Schema do
  use Absinthe.Schema

  alias MediaApi.Resolvers

  import_types MediaApi.Schema.Types

  query do
    field :items, type: list_of(:item) do
      resolve(&Resolvers.get_items/3)
    end
  end
end
