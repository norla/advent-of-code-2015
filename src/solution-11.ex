defmodule Solution11 do

  def run do
    pwd = IO.read(:stdio, :all) |> String.strip
    IO.inspect(try_pwd(inc(pwd, 7)))
  end

  def try_pwd(pwd) do
    case check(pwd, %{pairs: 0, straight: 0, pos: 0, ok: false}) do
      %{ok: false, pos: pos} ->
        IO.puts(pwd)
        try_pwd(inc(pwd, pos - 1))
      
      state -> {state,pwd}
    end
  end

  def check(<<>>, state), do: %{state | :ok => state.pairs > 1 && state.straight > 0}
  def check(<<x, _::binary>>, state) when (x == ?l or x == ?o or x == ?l), do: state
  def check(<<x, x, x, tail::binary>>, state)  when x == x do
    check(<<x, tail::binary>>, %{state | pairs: state.pairs + 1, pos: state.pos + 2})
  end
  def check(<<x, y, tail::binary>>, state) when x == y do
    check(<<x, tail::binary>>, %{state | pairs: state.pairs + 1, pos: state.pos + 1})
  end
  def check(<<x, y , z, tail::binary>>, state) when (y == x + 1 and z == y + 1) do
    check(<<y, z, tail::binary>>, %{state | straight: 1, pos: state.pos + 1})
  end
  def check(<<_, tail::binary>>, state), do: check(tail, %{state | pos: state.pos + 1})

  def inc(pwd, pos) do
    pwd |> String.codepoints |> Enum.slice(0..pos)
    |> List.update_at(pos, fn (<<c>>) -> <<rem((c - 96), 26) + 97>> end)
    |> Enum.concat(List.duplicate("a", 7 - pos)) |> Enum.join
  end

end
