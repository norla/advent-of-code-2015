defmodule Solution6 do

  def run do
    cmds = IO.stream(:stdio, :line) |> Enum.map(&parseCmd/1)
    IO.inspect([part1: run(cmds, &doBulb1/2), part2: run(cmds, &doBulb2/2)])
  end

  def run(cmds, bulbFn) do
    lights = for _ <- 0 .. 999, do: for _ <- 0 .. 999, do: 0
    Enum.reduce(cmds, lights, fn(cmd, acc) -> doCmd(cmd, acc, bulbFn) end)
    |> Enum.reduce(0, fn(row, acc) -> acc + Enum.sum(row) end)
  end

  def parseCmd(str) do
    [_, cmd, startX, startY, endX, endY] =
      Regex.run(~r/(.*) (\d+),(\d+) through (\d+),(\d+)/, str, [])
    {cmd, to_i(startX), to_i(startY), to_i(endX), to_i(endY)}
  end

  def doCmd(cmd = {_, _, startY, _, endY}, lights, bulbFn) do
    map_range(lights, startY, endY, fn(row) -> doRow(cmd, row, bulbFn) end)
  end

  def doRow({action, startX, _, endX, _}, row, bulbFn) do
    map_range(row, startX, endX, fn(bulb) -> bulbFn.(action, bulb) end)
  end

  def doBulb1("turn on", _), do: 1
  def doBulb1("turn off", _), do: 0
  def doBulb1("toggle", 0), do: 1
  def doBulb1("toggle", 1), do: 0

  def doBulb2("turn on", x), do: x + 1
  def doBulb2("turn off", x), do: max(0, x - 1)
  def doBulb2("toggle", x), do: x + 2

  def to_i(str), do: String.to_integer(str)

  def map_range(list, start, stop, fun) do
    {head, tmp} = Enum.split(list, start)
    {mid, tail} = Enum.split(tmp, stop - start + 1)
    Enum.concat([head, Enum.map(mid, fun), tail])
  end
end
