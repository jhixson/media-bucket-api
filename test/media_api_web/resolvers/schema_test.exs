defmodule MediaApiWeb.SchemaTest do
  use MediaApiWeb.ConnCase

  @items_query """
  query getItems {
    items {
      title
      status
    }
  }
  """

  test "items query", %{conn: conn} do
    insert(:item, title: "Back to the Future Part 2", status: :finished)
    insert(:item, title: "Back to the Future Part 3", status: :pending)

    conn =
      post(conn, "/graph", %{
        "query" => @items_query
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "items" => [
                 %{"title" => "Back to the Future Part 2", "status" => "FINISHED"},
                 %{"title" => "Back to the Future Part 3", "status" => "PENDING"}
               ]
             }
           }
  end
end
