defmodule MediaApiWeb.SchemaTest do
  use MediaApiWeb.ConnCase
  import MediaApi.TestUtilities

  test "list items", %{conn: conn} do
    category = insert(:category)
    item1 = insert(:item, title: "Back to the Future Part 2", status: :finished, category_id: category.id)
    item2 = insert(:item, title: "Back to the Future Part 3", status: :pending, category_id: category.id)

    conn =
      post(conn, "/graph", %{
        "query" => """
        query categoryItems {
          categoryItems(categoryId: #{category.id}){
            title
            items {
              title
              status
            }
          }
        }
        """
      })

    assert json_response(conn, 200) == %{
            "data" => %{
              "categoryItems" => [
                %{"title" => category.title, "items" => [
                  %{"title" => item1.title, "status" => enum_to_upstring(item1.status)},
                  %{"title" => item2.title, "status" => enum_to_upstring(item2.status)}
                ]}
              ]
            }
          }
  end

  test "update item status", %{conn: conn} do
    category = insert(:category)
    item1 = insert(:item, title: "Back to the Future Part 2", status: :finished, category_id: category.id)
    insert(:item, title: "Back to the Future Part 3", status: :pending, category_id: category.id)

    conn =
      post(conn, "/graph", %{
        "query" => """
        mutation{
          updateItem(item: {
            id: #{item1.id}
            category_id: #{item1.category_id}
            status: STARTED
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
