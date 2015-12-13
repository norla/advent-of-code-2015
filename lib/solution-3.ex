defmodule Solution3 do

  def run do
    santa = {0, 0}
    input = IO.read(:stdio, :all)
    IO.inspect([part1: run([santa], input), part2: run([santa, santa], input)])
  end

  defp run(santas, input) do
    acc = {santas, HashDict.new}
    {_, map} = String.codepoints(input) |> Enum.reduce(acc, &step/2)
    Dict.size(map)
  end

  defp step(dir, {[santa | tail], map}) do
    newSanta = moveSanta(dir, santa)
    {switchSantas([newSanta | tail]), Dict.put(map, newSanta, 1)}
  end

  defp moveSanta(dir, {xPos, yPos}) do
    case dir do
      "^" -> {xPos, yPos + 1}
      "v" -> {xPos, yPos - 1}
      ">" -> {xPos + 1, yPos}
      "<" -> {xPos - 1, yPos}
      _   -> {xPos, yPos}
    end
  end

  defp switchSantas([santa1, santa2]), do: [santa2, santa1]
  defp switchSantas(x), do: x

end

