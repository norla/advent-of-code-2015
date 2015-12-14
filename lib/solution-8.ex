defmodule Solution8 do

  def run do
    input = IO.stream(:stdio, :line) |> Enum.into([])
    res1 = input |> Enum.map(&cnt/1) |> Enum.sum
    res2 = input |> Enum.map(&cnt2/1) |> Enum.sum
    IO.inspect([part1: res1, part2: res2])
  end

  def cnt(str), do: cnt(str,0)

  def cnt(<<"\\", "x", _, _, rest::binary>>, n), do: cnt(rest, n + 3)
  def cnt(<<>>, n), do: n + 2
  def cnt(<<"\\\\", rest::binary>>, n), do: cnt(rest, n + 1)
  def cnt(<<"\\\"", rest::binary>>, n), do: cnt(rest, n + 1)
  def cnt(<<_, rest::binary>>, n), do: cnt(rest, n)

  def cnt2(str), do: cnt2(str,0)

  def cnt2(<<"\\", "x", _, _, rest::binary>>, n), do: cnt2(rest, n + 1)
  def cnt2(<<>>, n), do: n + 4
  def cnt2(<<"\\\\", rest::binary>>, n), do: cnt2(rest, n + 2)
  def cnt2(<<"\\\"", rest::binary>>, n), do: cnt2(rest, n + 2)
  def cnt2(<<_, rest::binary>>, n), do: cnt2(rest, n)

end
