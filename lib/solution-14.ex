defmodule Solution14 do

  def run do
    deer = IO.stream(:stdio, :line) |> Enum.reduce(HashDict.new(), &parse/2)
    res1 = Enum.map(deer, &distance(&1, 2503)) |> top
    res2 = 1..2503 |> Enum.reduce(deer, &score/2) |> Enum.map(fn({_, x}) -> x.score end) |> top
    IO.inspect([part1: res1, part2: res2])
  end

  def parse(line, acc) do
    [_, g1, g2, g3 ,g4] = Regex.run(~r/(\w+).* (\d+) .* (\d+) .* (\d+) /, line)
    Dict.put(acc, g1, %{speed: to_i(g2), fly: to_i(g3), rest: to_i(g4), score: 0})
  end

  def distance({_, %{speed: speed, fly: fly, rest: rest}}, secs) do
    div(secs, fly + rest) * speed * fly + min(fly, rem(secs, fly + rest)) * speed
  end

  def score(secs, deer) do
    list = deer |> Enum.map(&distance(&1, secs)) |> Enum.zip(deer) |> rsort
    {maxDist, _} = List.first(list)
    leaders = Enum.take_while(list, fn({dist, _}) -> dist == maxDist end)
    leaders |> Enum.reduce(
      deer, fn({_, {key, d}}, acc) -> Dict.put(acc, key, %{d | score: d.score + 1}) end)
  end

  def to_i(x), do: String.to_integer(x)
  def top(list), do: list |> Enum.sort |> List.last
  def rsort(list), do: list |> Enum.sort |> Enum.reverse

end
