defmodule Solution6 do

  def run do
    lights = for _ <- 0 .. 999, do: for _ <- 0 .. 999, do: false
    cmds = IO.stream(:stdio, :line) |> Enum.map(&parseCmd/1)
    res = Enum.reduce(cmds, lights, &doCmd/2)
    |> Enum.reduce(0, fn(row, acc) -> acc + Enum.count(row, &(&1)) end)
    IO.inspect(res)
  end

  def parseCmd(str) do
    [_, cmd, startX, startY, endX, endY] =
      Regex.run(~r/(.*) (\d+),(\d+) through (\d+),(\d+)/, str, [])
    {cmd, to_i(startX), to_i(startY), to_i(endX), to_i(endY)}
  end

  def doCmd(cmd = {_, _, startY, _, endY}, lights) do
    IO.inspect(cmd)
    res = map_range(lights, startY, endY, fn(row) -> doRow(cmd, row) end)
    res
  end

  def doRow({action, startX, _, endX, _}, row) do
    res = map_range(row, startX, endX, fn(bulb) -> doBulb(action, bulb) end)
    res
  end

  def doBulb("turn on", _), do: true
  def doBulb("turn off", _), do: false
  def doBulb("toggle", bulb), do: !bulb

  def to_i(str), do: String.to_integer(str)

  def map_range(list, start, stop, fun) do
    {head, tmp} = Enum.split(list, start)
    {mid, tail} = Enum.split(tmp, stop - start + 1)
    Enum.concat([head, Enum.map(mid, fun), tail])
  end
end
