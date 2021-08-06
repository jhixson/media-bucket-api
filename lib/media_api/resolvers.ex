defmodule MediaApi.Resolvers do
  alias MediaApi.Media

  def get_category_items(_parent, %{category_id: category_id}, _context) do
    category = Media.get_category!(category_id)
    {:ok, category}
  end

  def update_item(_parent, %{item: attrs}, _context) do
    Media.get_item!(attrs.id)
    |> Media.update_item(attrs)
  end
end
