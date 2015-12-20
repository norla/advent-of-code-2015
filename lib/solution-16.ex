import String, only: [to_integer: 1, strip: 1, to_atom: 1]
import Enum, only: [map: 2, reduce: 3, with_index: 1, filter: 2, all?: 2]

defmodule Solution16 do

  @gifter [children: 3, cats: 7, samoyeds: 2, pomeranians: 3, akitas: 0, vizslas: 0,
           goldfish: 5, trees: 3, cars: 2, perfumes: 1]

  def run do
    sues = IO.stream(:stdio, :line) |> map(&parse/1) |> with_index
    [{_, sue1}] = filter(sues, &sue_1?/1)
    [{_, sue2}] = filter(sues, &sue_2?/1)
    IO.inspect([part1: sue1 + 1, part2: sue2 + 1])
  end

  def parse(line) do
    Regex.scan(~r/([\w ]+): (\d+)/, line) |> map(fn([_, prop, val]) ->
      {prop |> strip |> to_atom, to_integer(val)}
    end)
  end

  def sue_1?({sue, _}), do: sue -- @gifter == []

  def sue_2?({sue, n}) do
    (!sue[:cats] || sue[:cats] > @gifter[:cats]) &&
    (!sue[:trees] || sue[:trees] > @gifter[:trees]) &&
    (!sue[:pomeranians] || sue[:pomeranians] < @gifter[:pomeranians]) &&
    (!sue[:goldfish] || sue[:goldfish] < @gifter[:goldfish]) &&
    sue_1?({[:cats, :trees, :pomeranians, :goldfish] |> reduce(sue, &Keyword.delete(&2, &1)), n})
  end

end
