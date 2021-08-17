defmodule MediaApi.Resolvers do
  alias MediaApi.Media

  def get_categories(_parent, _args, _context) do
    categories = Media.list_categories()
    {:ok, categories}
  end

  def get_category_items(_parent, %{category_id: category_id}, _context) do
    category = Media.get_category!(category_id)
    {:ok, category}
  end

  def add_item(_parent, %{item: attrs}, _context) do
    Media.create_item(attrs)
  end

  def update_item(_parent, %{id: id, item: attrs}, _context) do
    Media.get_item!(id)
    |> Media.update_item(attrs)
  end
end
