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
            id
            title
            items {
              id
              categoryId
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
                %{"id" => category.id, "title" => category.title, "items" => [
                  %{
                    "id" => item1.id,
                    "categoryId" => item1.category_id,
                    "title" => item1.title,
                    "status" => enum_to_upstring(item1.status)
                  },
                  %{
                    "id" => item2.id,
                    "categoryId" => item2.category_id,
                    "title" => item2.title,
                    "status" => enum_to_upstring(item2.status)
                  }
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
          updateItem(id: #{item1.id}, item: {
            category_id: #{item1.category_id}
            title: "#{item1.title}"
            status: STARTED
          }) {
            id
            categoryId
            title
            status
          }
        }
        """
      })

    assert json_response(conn, 200) == %{
            "data" => %{
              "updateItem" => %{
                "id" => item1.id,
                "categoryId" => item1.category_id,
                "title" => item1.title,
                "status" => "STARTED"
              }
            }
          }
  end

  test "add item", %{conn: conn} do
    category = insert(:category)

    conn =
      post(conn, "/graph", %{
        "query" => """
        mutation{
          addItem(item: {
            category_id: #{category.id}
            title: "Air Bud"
            status: PENDING
          }) {
            id
            categoryId
            title
            status
          }
        }
        """
      })

    new_item =
      MediaApi.Media.Item
      |> Ecto.Query.first()
      |> MediaApi.Repo.one()

    assert json_response(conn, 200) == %{
            "data" => %{
              "addItem" => %{
                "id" => new_item.id,
                "categoryId" => category.id,
                "title" => "Air Bud",
                "status" => "PENDING"
              }
            }
          }
  end
end
