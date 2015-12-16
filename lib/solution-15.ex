defmodule Solution15 do

  @calories_prop 4

  def run do
    ingredients = IO.stream(:stdio, :line) |> Enum.map(&parse/1)
    cookies = perm(100, 4) |> Enum.map(&List.flatten/1)
    scores = cookies |> Enum.map(&score(&1, ingredients))
    calories = cookies |> Enum.map(&calories(&1, ingredients))
    {res2, _} = Enum.zip(scores, calories) |> Enum.filter(fn({_, c}) -> c == 500 end)
    |> Enum.sort |> List.last
    IO.inspect([part1: scores |> Enum.sort |> List.last, part2: res2])
  end

  def parse(line) do
     Regex.scan(~r/(-*\d+)/, line, [capture: :first]) |> List.flatten |> Enum.map(&String.to_integer/1)
  end

  def score(cookie, ingredients) do
    props =  0..length(ingredients) - 1
    props |> Enum.reduce(1, fn(prop, acc) -> acc * max(sum_props(cookie, ingredients, prop), 0)
    end)
  end

  def calories(cookie, ingredients), do: sum_props(cookie, ingredients, @calories_prop)

  def sum_props(cookie, ingredients, prop) do
    ingredients |> Enum.with_index |> Enum.reduce(0,
      fn({ingredient, n}, acc) ->
        acc + Enum.at(ingredient, prop) * Enum.at(cookie, n)
      end)
  end

  def perm(items, 1), do: [items]
  def perm(items, pots) do
    1..(items - pots + 1) |> Enum.map(fn(n) ->
      cartesian([n], perm(items - n, pots - 1))
    end) |> Enum.concat
  end

  def cartesian(c1, c2), do: for i <- c1, j <- c2, do:  [i, j]

end

