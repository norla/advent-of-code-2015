defmodule Solution5 do

  def run() do
    input = IO.read(:stdio, :all) |> String.split("\n") |> Enum.map(&String.codepoints/1)
    res1 = input |> Enum.map(&nice/1) |> Enum.count(&(&1))
    res2 = input |> Enum.map(&nice2/1) |> Enum.count(&(&1))
    IO.inspect([part1: res1, part2: res2])
  end

  def nice(list), do: nice(list, {false, 0})

  def nice([], {double, vowels}), do: double && vowels >= 3
  def nice(["a", "b" | _], _), do: false
  def nice(["c", "d" | _], _), do: false
  def nice(["p", "q" | _], _), do: false
  def nice(["x", "y" | _], _), do: false
  def nice([x, x | tail], {_, vowels}) do
    nice([x | tail], {true, incVowels(x, vowels)})
  end
  def nice([x | tail], {double, vowels}) do
    nice(tail, {double, incVowels(x, vowels)})
  end

  def incVowels(x, n) when x in ["a", "e", "i", "o", "u"], do: n + 1
  def incVowels(_, n), do: n

  def nice2(list), do: nice2(list, {false, {false, []}})

  def nice2([], {double, {pairsFound, _}}), do: double && pairsFound
  def nice2([x, x, x | tail], {_, pairs}) do nice2([x | tail], {true, checkPairs(pairs, x, x)})
  end
  def nice2([x, y, x | tail], {_, pairs}) do
    nice2([y, x | tail], {true, checkPairs(pairs, x, y)})
  end
  def nice2([x, y | tail], {double, pairs}) do
    nice2([y | tail], {double, checkPairs(pairs, x, y)})
  end
  def nice2([_ | tail], state), do: nice2(tail, state)

  def checkPairs({true, list}, _, _), do: {true, list}
  def checkPairs({false, list}, x, y) do
    case [x, y] in list do
      true -> {true, []}
      false -> {false, [[x, y] | list]}
    end
  end
end
