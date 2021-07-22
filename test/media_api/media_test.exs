defmodule MediaApi.MediaTest do
  use MediaApi.DataCase

  alias MediaApi.Media

  describe "items" do
    alias MediaApi.Media.Item

    @valid_attrs %{status: "pending", title: "some title"}
    @update_attrs %{notes: "some notes", rating: 8, status: "finished"}
    @invalid_attrs %{title: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Media.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Media.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Media.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Media.create_item(@valid_attrs)
      assert item.status == :pending
      assert item.title == "some title"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Media.update_item(item, @update_attrs)
      assert item.notes == "some notes"
      assert item.rating == 8
      assert item.status == :finished
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_item(item, @invalid_attrs)
      assert item == Media.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Media.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Media.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Media.change_item(item)
    end
  end
end
