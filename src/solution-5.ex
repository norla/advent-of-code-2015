defmodule Solution5 do

  @vowels String.to_char_list("aeiou")

  def run() do
    input = IO.read(:stdio, :all) |> String.split("\n")
    res1 = input |> Enum.map(&nice1/1) |> Enum.count(&(&1))
    res2 = input |> Enum.map(&nice2/1) |> Enum.count(&(&1))
    IO.inspect([part1: res1, part2: res2])
  end

  # Part 1
  def nice1(list), do: nice1(list, {false, 0})

  def nice1(<<>>, {double, vowels}), do: double && vowels >= 3
  def nice1(<<"a", "b", _::binary>>, _), do: false
  def nice1(<<"c", "d", _::binary>>, _), do: false
  def nice1(<<"p", "q", _::binary>>, _), do: false
  def nice1(<<"x", "y", _::binary>>, _), do: false
  def nice1(<<x, x, tail::binary>>, {_, vowels}) do
    nice1(<<x, tail::binary>>, {true, incVowels(x, vowels)})
  end
  def nice1(<<x, tail::binary>>, {double, vowels}) do
    nice1(tail, {double, incVowels(x, vowels)})
  end

  def incVowels(x, n) when x in @vowels, do: n + 1
  def incVowels(_, n), do: n

  # Part 2
  def nice2(str), do: nice2(str, {false, {false, []}})

  def nice2(<<>>, {hasDouble, {hasPairs, _}}), do: hasDouble && hasPairs
  def nice2(<<x, x, x, rest::binary>>, {_, pairs}) do
    nice2(<<x, rest::binary>>, {true, checkPairs(pairs, x, x)})
  end
  def nice2(<<x, y, x, rest::binary>>, {_, pairs}) do
    nice2(<<y, x, rest::binary>>, {true, checkPairs(pairs, x, y)})
  end
  def nice2(<<x, y, rest::binary>>, {hasDouble, pairs}) do
    nice2(<<y, rest::binary>>, {hasDouble, checkPairs(pairs, x, y)})
  end
  def nice2(<<_, rest::binary>>, state), do: nice2(rest, state)

  def checkPairs({true, list}, _, _), do: {true, list}
  def checkPairs({false, list}, x, y), do: {[x, y] in list, [[x, y] | list]}

end
