defmodule Solution10 do

  def run do
    input = IO.read(:stdio, :all) |> String.strip
    res = 1..50 |> Enum.reduce(input, fn (n, acc) -> l = String.length(acc); IO.puts("#{n} #{l}"); look_and_say(acc) end)
    IO.puts(String.length(res))
  end

  def look_and_say(str) do
    look_and_say(str, 1, <<>>)
  end

  def look_and_say(<<x>>, n, acc), do: <<acc::binary, Integer.to_string(n)::binary, x>>
  def look_and_say(<<x, x, rest::binary>>, n, acc) do
#   IO.puts("CASE 1 --- #{x} | #{n} | #{acc} | #{rest}")
    look_and_say(<<x, rest::binary>>, n + 1, <<acc::binary>>)
  end
  def look_and_say(<<x, rest::binary>>, n, acc) do
#    IO.puts("CASE 2 --- #{x} | #{n} | #{acc} | #{rest}")
    look_and_say(rest, 1, <<acc::binary, Integer.to_string(n)::binary, x>>)
  end

end
