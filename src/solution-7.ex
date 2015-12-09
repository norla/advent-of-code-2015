defmodule Solution7 do

  use Bitwise

  def run do
    input = IO.read(:stdio, :all) |> String.strip |> String.split("\n")
    cmds1 = input |> Enum.map(&parse/1)
    a1 = resolve_key(cmds1, "a")
    cmds2 = Enum.map(cmds1,
      fn(cmd = %{:out => "b"}) -> %{cmd | :args => [a1], :deps => []}
        (x) -> x
      end)
    a2 = resolve_key(cmds2, "a")
    IO.inspect([part1: a1, part2: a2])
  end

  def resolve_key(cmds, key, resolved \\ HashDict.new) do
    {cmds, resolved} = Enum.reduce(cmds, {[], resolved}, &resolve/2)
    if res = Dict.get(resolved, key), do: res, else: resolve_key(cmds, key, resolved)
  end

  def parse(cmd) do
		[input, output] = cmd |> String.strip |> String.split(" -> ")
		{args, op} = case String.split(input) do
                   [x, op, y] -> {[x, y], op}
			             [op, x] -> {[x], op}
			             [x] -> {[x], "ID"}
                 end
    cmd = %{:out => output, :deps => [], :args => [], :op => op}
    Enum.reduce(args, cmd, &init_cmd/2)
	end

  def init_cmd(x, cmd) do
    if Regex.match?(~r/\d+/, x) do
      %{cmd | :args => [String.to_integer(x) | cmd.args]}
    else
      %{cmd | :deps => [x | cmd.deps]}
    end
  end

	def resolve(cmd, {cmds, resolved}) do
    met = cmd.deps |> Enum.map(&Dict.get(resolved, &1)) |> Enum.filter(fn(x) -> x !== nil end)
		if length(cmd.deps) == length(met)  do
      {cmds, Dict.put(resolved, cmd.out, apply_op(%{cmd | :args => met ++ cmd.args}))}
    else
      {[cmd | cmds], resolved}
    end
  end

  def apply_op(%{:op => "AND", :args => [x, y]}), do: x &&& y
  def apply_op(%{:op => "OR", :args => [x, y]}), do: x ||| y
  def apply_op(%{:op => "RSHIFT", :args => [x, y]}), do: bsr(x, y)
  def apply_op(%{:op => "LSHIFT", :args => [x, y]}), do: bsl(x, y)
  def apply_op(%{:op => "NOT", :args => [x]}), do: ~~~x
  def apply_op(%{:op => "ID", :args => [x]}), do: x

end
