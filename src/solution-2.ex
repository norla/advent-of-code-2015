defmodule Solution2 do

  def run do
    input = IO.read(:stdio, :all)
    IO.inspect([part1: run(&paper/1, input), part2: run(&ribbon/1, input)])
  end

  defp run(calc, inout) do
    String.split(input, "\n") |> Enum.map(&sides/1) |> Enum.map(calc) |> Enum.sum
  end

  defp sides(""), do: [0, 0, 0]
  defp sides(line) do
    String.strip(line) |> String.split("x") |> Enum.map(&String.to_integer/1) |> Enum.sort
  end

  defp paper([s, m, l]), do: (2 * s * m) + (2 * m * l) + (2 * s * l) + (s * m)

  defp ribbon([s, m, l]), do: (2 * s) + (2 * m) + (s * m * l)

end