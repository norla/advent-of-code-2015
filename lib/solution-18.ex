defmodule Solution18 do

  @surround [{-1, -1}, {0, -1}, {1, -1}, {-1, 0}, {1, 0}, {-1, 1}, {0, 1}, {1, 1}]
  @corners [{0, 0}, {0, 99}, {99, 0}, {99, 99}]

  def run do
    lights = IO.stream(:stdio, :line) |> Enum.with_index |> Enum.reduce(HashDict.new, &parse/2)
    res1 = 1..100 |> Enum.reduce(lights, fn(_, acc) -> run(acc) end) |> sum_lights
    res2 = 1..100 |> Enum.reduce(lights, fn(_, acc) -> acc |> light_corners |> run end) |> light_corners |> sum_lights
    IO.inspect([part1: res1, part2: res2])
  end

  def sum_lights(lights), do: lights |> Enum.map(fn({_, n}) -> n end) |> Enum.sum

  def parse({line, y}, lights) do
    line |> String.strip |> String.codepoints |> Enum.with_index |> Enum.reduce(lights, fn({ch, x}, acc) ->
      Dict.put(acc, {x, y}, case ch do "#" -> 1; "." -> 0 end)
    end)
  end

  def surround(x, y, lights) do
    Enum.reduce(@surround, 0, fn({dx, dy}, acc) -> acc + Dict.get(lights, {x + dx, y + dy}, 0) end)
  end

  def run(lights) do
    Enum.reduce(lights, HashDict.new(), &do_light(&1, lights, &2))
  end

  def light_corners(lights), do: @corners |> Enum.reduce(lights, fn(pos, acc) -> Dict.put(acc, pos, 1) end)

  def do_light(light = {pos, _}, lights, acc), do: Dict.put(acc, pos, do_light(light, lights))

  def do_light({{x, y}, 0}, lights), do: if (surround(x, y, lights) == 3), do: 1, else: 0
  def do_light({{x, y}, 1}, lights), do: if (surround(x, y, lights) in [2, 3]), do: 1, else: 0

  def do_light_2
end
