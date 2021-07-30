defmodule MediaApi.Schema do
  use Absinthe.Schema

  alias MediaApi.Resolvers

  import_types MediaApi.Schema.Types

  query do
    field :items, type: list_of(:item) do
      resolve(&Resolvers.get_items/3)
    end
  end

  mutation do
    field :update_item, type: :item do
      arg :item, non_null(:item_input)

      resolve(&Resolvers.update_item/3)
    end
  end
end
