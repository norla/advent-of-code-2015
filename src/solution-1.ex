defmodule Solution1 do

  def run do
    deltas =
      IO.read(:stdio, :all) |> String.strip |> String.codepoints
      |> Enum.map(fn("(") -> 1; (")") -> -1 end)
    finalFloor = Enum.sum(deltas)
    movesTilBasement = Enum.reduce_while(moves, {0, 0}, &basement/2)
    IO.inspect([part1: finalFloor, part2: movesTilBasement])
  end

  defp basement(_, {-1, n}), do: {:halt, n}
  defp basement(delta, {floor, n}), do: {:cont, {floor + delta, n + 1}}

end
