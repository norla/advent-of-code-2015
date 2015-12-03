defmodule Solution1 do
  def run do
    moves = IO.read(:stdio, :all) |> String.strip |> String.codepoints |>
            Enum.map(fn("(") -> 1; (")") -> -1 end)
    finalFloor = Enum.sum(moves)
    movesTilBasement = Enum.reduce_while(moves, {0, 1}, &basement/2)
    IO.inspect([part1: finalFloor, part2: movesTilBasement])
  end

  defp basement(-1, {0, n}), do: {:halt, n}
  defp basement(delta, {floor, n}), do: {:cont, {floor + delta, n + 1}}
end
