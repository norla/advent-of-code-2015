defmodule Solution12 do

  def run do
    input = IO.read(:stdio, :all)
    IO.inspect([part1: part1(input), part2: part2(input)])
  end

  def part1(input) do
    Regex.scan(~r/(-*\d+)/, input)
    |> Enum.map(fn ([x, _]) -> String.to_integer(x) end) |> Enum.sum
  end

  def part2(input), do: part2(Poison.Parser.parse!(input), 0)

  def part2(obj = %{}, n) do
    vals = Map.values(obj)
    if (Enum.member?(vals, "red")), do: n, else: Enum.reduce(vals, n, &part2/2)
  end
  def part2(l, n) when is_list(l), do: Enum.reduce(l, n, &part2/2)
  def part2(i, n) when is_integer(i), do: n + i
  def part2(_, n), do: n

end





