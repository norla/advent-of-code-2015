defmodule Solution2 do

  def run do
    boxes =
      IO.read(:stdio, :all) |> String.strip |> String.split |> Enum.map(&box/1)
    IO.inspect([part1: run(&paper/1, boxes), part2: run(&ribbon/1, boxes)])
  end

  defp run(calc, box) do
    box |> Enum.map(calc) |> Enum.sum
  end

  defp box(line) do
    line |> String.strip |> String.split("x") |> Enum.map(&String.to_integer/1)
    |> Enum.sort
  end

  defp paper([s, m, l]), do: (2 * s * m) + (2 * m * l) + (2 * s * l) + (s * m)

  defp ribbon([s, m, l]), do: (2 * s) + (2 * m) + (s * m * l)
  
end
