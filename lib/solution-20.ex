defmodule Solution20 do

  def run do
    IO.inspect([part1: run(&elf/3), part2: run(&elf_2/3)])
  end

  def run(fun) do
    1..2900000
    |> Enum.reduce(HashDict.new, fn(house, houses) ->
      if (rem(house, 100) == 0), do: IO.puts("#{house}")
      fun.(house, house, houses)
    end)
    |> Enum.sort
    |> Enum.find(nil, fn({_, val}) -> val > 29000000 end)
  end

  def elf(n, _, houses) when n > 2900000, do: houses
  def elf(n, house, houses), do: elf(n + house, house, gift(houses, n, house * 10))

  def elf_2(n, house, houses) when n > (house * 50), do: houses
  def elf_2(n, house, houses), do: elf_2(n + house, house, gift(houses, n, house * 11))

  def gift(houses, house, gifts), do: Dict.update(houses, house, gifts, &(&1 + gifts))

end

#
