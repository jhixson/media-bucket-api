defmodule MediaApi.Schema do
  use Absinthe.Schema

  alias MediaApi.Resolvers

  import_types MediaApi.Schema.Types

  query do

    field :categories, type: non_null(list_of(non_null(:category))) do
      resolve(&Resolvers.get_categories/3)
    end

    field :category_items, type: list_of(:category) do
      arg :category_id, non_null(:integer)

      resolve(&Resolvers.get_category_items/3)
    end

    field :item, type: non_null(:item) do
      arg :id, non_null(:integer)

      resolve(&Resolvers.get_item/3)
    end
  end

  mutation do
    field :add_item, type: :item do
      arg :item, non_null(:item_input)

      resolve(&Resolvers.add_item/3)
    end

    field :update_item, type: :item do
      arg :id, non_null(:integer)
      arg :item, non_null(:item_input)

      resolve(&Resolvers.update_item/3)
    end

    field :delete_item, type: :item do
      arg :id, non_null(:integer)

      resolve(&Resolvers.delete_item/3)
    end
  end
end
