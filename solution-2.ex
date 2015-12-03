defmodule Solution2 do

  def run(fileName) do
    File.read!(fileName) |> String.split("\n") |> Enum.map(&paper/1) |> Enum.sum
  end

  defp paper(""), do: 0
  defp paper(line) do
    [s, m, l] =
      String.split(line, "x") |> Enum.map(&String.to_integer/1) |> Enum.sort
    (2 * s * m) + (2 * m * l) + (2 * s * l) + (s * m)
  end
end