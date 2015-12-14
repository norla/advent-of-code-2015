defmodule Solution1 do

  def run do
    deltas = IO.read(:stdio, :all) |> String.codepoints |> Enum.map(&parse/1)
    finalFloor = Enum.sum(deltas)
    movesTilBasement = Enum.reduce_while(deltas, {0, 0}, &basement/2)
    IO.inspect([part1: finalFloor, part2: movesTilBasement])
  end

  defp basement(_, {-1, n}), do: {:halt, n}
  defp basement(delta, {floor, n}), do: {:cont, {floor + delta, n + 1}}

  defp parse("("), do: 1
  defp parse(")"), do: -1

end
