defmodule Solution9 do

	def run do
		roads = IO.stream(:stdio, :line) |> Enum.map(&parse_road/1) |> Enum.into(HashDict.new)
		towns = roads |> Dict.keys |> List.flatten |> Enum.uniq
		routes = permute(towns) |> Enum.map(&route_len(&1, roads)) |> Enum.sort
		IO.inspect([part1: List.first(routes), part2: List.last(routes)])
	end

  def route_len([from, to], roads), do: Dict.get(roads, Enum.sort([from, to]))
	def route_len([from, to | tail], roads) do
		Dict.get(roads, Enum.sort([from, to])) + route_len([to | tail], roads)
	end

  def permute([]), do: [[]]
  def permute(list), do: for x <- list, y <- permute(list -- [x]), do: [x|y]

	def parse_road(str) do
		[_, from, to, dist] = Regex.run(~r/(\w+) to (\w+) = (\d+)/, str)
		{Enum.sort([from, to]), String.to_integer(dist)}
	end

end
