defmodule MediaApi.TestUtilities do
  def enum_to_upstring(atom) do
    atom |> Atom.to_string() |> String.upcase()
  end
end
