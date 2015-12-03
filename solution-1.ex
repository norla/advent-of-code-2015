defmodule Solution1_1 do

  def run do
    File.stream!("input-1.txt", [], 1) |> Enum.reduce(0, &move/2)
  end

  defp move("(", floor), do: floor + 1
  defp move(")", floor), do: floor - 1
  defp move(_, floor), do: floor

end

defmodule Solution1_2 do

  def run do
    move((File.read!("input-1.txt") |> String.codepoints), {0, 1})
  end

  defp move([")" | _], {0, n}), do: n
  defp move(["(" | tail], {floor, n}), do: move(tail, {floor + 1,  n + 1})
  defp move([")" | tail], {floor, n}), do: move(tail, {floor - 1,  n + 1})
  
end

