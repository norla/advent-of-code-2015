defmodule Solution4 do

  def run do
    key = IO.read(:stdio, :all) |> String.strip
    IO.inspect([part1: find(key, 0, "00000"), part2: find(key, 0, "000000")])
  end

  defp find(key, n, prefix) do
    md5 = :crypto.hash(:md5, "#{key}#{n}") |> Base.encode16
    if String.starts_with?(md5, prefix), do: n, else: find(key, n + 1, prefix)
  end
  
end
