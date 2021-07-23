defmodule MediaApi.Resolvers do
  def get_items(_parent, _args, _context) do
    items = MediaApi.Media.list_items()
    {:ok, items}
  end
end
