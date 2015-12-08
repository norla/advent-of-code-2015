defmodule Solution7 do

  use Bitwise

  def run do
    input = IO.read(:stdio, :all) |> String.strip |> String.split("\n")
    cmds1 = input |> Enum.map(&parse/1)
    a1 = resolve_all(cmds1) |> Dict.get("a")
    cmds2 = List.keyreplace(cmds1, "b", 2, {[], a1, "b"})
    a2 = resolve_all(cmds2) |> Dict.get("a")
    IO.inspect([part1: a1, part2: a2])
  end

  def resolve_all(cmds, res \\ HashDict.new) do
    case Enum.reduce(cmds, {[], res}, &resolve/2) do
      {[], newRes} -> newRes
      {newCmds, newRes} -> resolve_all(newCmds, newRes)
    end
  end

  def parse(cmd) do
		[input, output] = cmd |> String.strip |> String.split(" -> ")
		case String.split(input) do
      ["1", "AND", y] -> {[y], {"AND", 1}, output}
			[x, "AND", y] -> {[x, y], "AND", output}
      [x, "OR", y] -> {[x, y], "OR", output}
      [wire, "RSHIFT", n] -> {[wire], {"BSR", String.to_integer(n)}, output}
      [wire, "LSHIFT", n] -> {[wire], {"BSL", String.to_integer(n)}, output}
			["NOT", wire] -> {[wire], "NOT", output}
			[x] ->
        if Regex.match?(~r/\d+/, x) do
          {[], String.to_integer(x), output}
        else
          {[x], "ID", output}
        end
		end
	end

	def resolve(cmd = {inputs, op, output}, {unresolved, resolved}) do
    met = inputs |> Enum.map(&Dict.get(resolved, &1)) |> Enum.filter(fn(x) -> x !== nil end)
		case length(met) === length(inputs) do
      true -> {unresolved, Dict.put(resolved, output, apply_op(op, met))}
			_ -> {[cmd | unresolved], resolved}
    end
  end

  def apply_op("AND", [x, y]), do: x &&& y
  def apply_op({"AND", x}, [y]), do: x &&& y
  def apply_op("OR", [x, y]), do: x ||| y
  def apply_op("NOT", [x]), do: ~~~x
  def apply_op("ID", [x]), do: x
  def apply_op({"BSR", n}, [x]), do: bsr(x, n)
  def apply_op({"BSL", n}, [x]), do: bsl(x, n)
  def apply_op(signal, []) when is_integer(signal), do: signal

end
