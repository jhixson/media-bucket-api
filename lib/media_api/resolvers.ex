defmodule MediaApi.Resolvers do
  alias MediaApi.Media

  def get_items(_parent, _args, _context) do
    items = Media.list_items()
    {:ok, items}
  end

  def update_item(_parent, %{item: attrs}, _context) do
    Media.get_item!(attrs.id)
    |> Media.update_item(attrs)
  end
end
