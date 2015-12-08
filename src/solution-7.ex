defmodule Solution7 do

  use Bitwise

  def run do
    {unres, res} = IO.stream(:stdio, :line) |> Enum.reduce({[], []}, &run/2)
    res = resolve_all(unres, res)
    IO.inspect(List.keyfind(res, "a", 0))
  end

  def resolve_all(unres, res) do
    case Enum.reduce(unres, {[], res}, &resolve/2) do
      {[], newRes} -> newRes
      {newUnres, newRes} -> resolve_all(newUnres, newRes)
    end
  end

  def run(cmd, {unresolved, resolved}) do
		[input, output] = cmd |> String.strip |> String.split(" -> ")
		dep = case String.split(input) do
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
		Enum.reduce([dep | unresolved], {[], resolved}, &resolve/2)
	end

	def resolve(dep = {inputs, op, output}, {unresolved, resolved}) do
    met = inputs |> Enum.map(&keyfind(resolved, &1))
    unmet = met |> Enum.filter(fn (x) -> x == nil end)
		case unmet do
      [] -> {unresolved, [{output, apply_op(op, met)} | resolved]}
			_ -> {[dep | unresolved], resolved}
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

  def keyfind(list, key) do
    case List.keyfind(list, key, 0) do
      {_, val} -> val;
      nil -> nil
    end
  end
end
