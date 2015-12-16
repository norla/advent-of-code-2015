defmodule Solution15 do

  def run do
    ingredients = IO.stream(:stdio, :line) |> Enum.map(&parse/1)
    IO.inspect(ingredients)
    amounts = perm(100, 4) |> Enum.map(&List.flatten/1)
    scores = amounts |> Enum.map(&score(&1, ingredients)) |> Enum.sort
    IO.inspect(scores |> List.last)
  end

  def parse(line) do
     Regex.scan(~r/(-*\d+)/, line, [capture: :first]) |> List.flatten |> List.delete_at(4) |> Enum.map(&String.to_integer/1)
  end

  def score(cookie, ingredients) do
    props =  0..length(ingredients) - 1
    props |> Enum.reduce(1, fn(prop, acc) ->
      acc * max (ingredients |> Enum.with_index |> Enum.reduce(0, fn({ingredient, n}, acc) ->
        acc + Enum.at(ingredient, prop) * Enum.at(cookie, n)
      end), 0)
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

