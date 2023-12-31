defmodule MediaApi.Factory do
  use ExMachina.Ecto, repo: MediaApi.Repo

  def item_factory do
    %MediaApi.Media.Item{
      title: "Back to the Future",
      status: :pending
    }
  end

  def category_factory do
    %MediaApi.Media.Category{
      title: "Movies"
    }
  end
end
