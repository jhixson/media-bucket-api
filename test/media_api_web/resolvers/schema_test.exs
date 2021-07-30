defmodule MediaApiWeb.SchemaTest do
  use MediaApiWeb.ConnCase
  import MediaApi.TestUtilities

  test "list items", %{conn: conn} do
    item1 = insert(:item, title: "Back to the Future Part 2", status: :finished)
    item2 = insert(:item, title: "Back to the Future Part 3", status: :pending)

    conn =
      post(conn, "/graph", %{
        "query" => """
        query getItems {
          items {
            title
            status
          }
        }
        """
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "items" => [
                 %{"title" => item1.title, "status" => enum_to_upstring(item1.status)},
                 %{"title" => item2.title, "status" => enum_to_upstring(item2.status)}
               ]
             }
           }
  end

  test "update item status", %{conn: conn} do
    item1 = insert(:item, title: "Back to the Future Part 2", status: :finished)
    insert(:item, title: "Back to the Future Part 3", status: :pending)

    conn =
      post(conn, "/graph", %{
        "query" => """
        mutation{
          updateItem(item: {
            id: #{item1.id}
            status:STARTED
          }) {
            title
            status
          }
        }
        """
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "updateItem" => %{
                 "title" => item1.title,
                 "status" => "STARTED"
               }
             }
           }
  end
end
