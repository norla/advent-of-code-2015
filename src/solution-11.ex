defmodule Solution11 do

  def run do
    pwd = IO.read(:stdio, :all) |> String.strip
    pwd1 = next_pwd(pwd)
    pwd2 = next_pwd(pwd1)
    IO.inspect([part1: pwd1, part2: pwd2])
  end

  def next_pwd(pwd) do
    next = inc(pwd)
    if check(next, %{pairs: 0, straight: 0}), do: next, else: next_pwd(next)
  end

  def check(<<>>, state), do: state.pairs > 1 && state.straight > 0
  def check(<<x, _::binary>>, _) when (x == ?l or x == ?o or x == ?l), do: false
  def check(<<x, x, x, tail::binary>>, state) do
    check(<<x, tail::binary>>, %{state | pairs: state.pairs + 1})
  end
  def check(<<x, x, tail::binary>>, state) do
    check(<<x, tail::binary>>, %{state | pairs: state.pairs + 1})
  end
  def check(<<x, y , z, tail::binary>>, state) when (y == x + 1 and z == y + 1) do
    check(<<y, z, tail::binary>>, %{state | straight: 1})
  end
  def check(<<_, tail::binary>>, state), do: check(tail, state)

  def inc(pwd) do
    Regex.replace(~r/(.*)([a-y])(z*)$/s, pwd,
      fn (_,x,<<y>>,z) ->
        <<x::binary, rem((y - 96), 26) + 97, (String.replace(z, "z", "a"))::binary>>
      end)
   end

end
