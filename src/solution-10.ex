defmodule Solution10 do

  def run do
    input = IO.read(:stdio, :all) |> String.strip |> String.codepoints
    IO.inspect([part1: say_n(input, 40), part2: say_n(input, 50)])
  end

  def say_n(str, n) do
    1..n |> Enum.reduce(str, fn(n, acc) -> IO.puts(n); say(acc) end) |> length
  end

  def say(str), do: Enum.reverse(say(str, 1, []))

  def say([x], n, acc), do: [x, Integer.to_string(n) | acc]
  def say([x, x | tail], n, acc), do: say([x | tail], n + 1, acc)
  def say([x | tail], n, acc), do: say(tail, 1, [x, Integer.to_string(n) | acc])

end
