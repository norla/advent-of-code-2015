defmodule Solution3_1 do

  def run do
    acc = {{0, 0}, HashDict.new}
    {_, map} = File.stream!("input-3.txt", [], 1) |> Enum.reduce(acc, &move/2)
    Dict.size(map)
  end

  defp move(dir, {{xPos, yPos}, map}) do
    newPos = case dir do
      "^" -> {xPos    , yPos + 1}
      "v" -> {xPos    , yPos - 1}
      ">" -> {xPos + 1, yPos    }
      "<" -> {xPos - 1, yPos    }
      _   -> {xPos    , yPos    }
    end
    {newPos, Dict.put(map, newPos, 1)}
  end

  def run2 do
    acc = {[{0, 0}, {0, 0}], HashDict.new}
    {_, map} = File.stream!("input-3.txt", [], 1) |> Enum.reduce(acc, &move2/2)
    Dict.size(map)
  end

  def move2(dir, {{xPos, yPos}, other}) do
    newPos = case dir do
      "^" -> {xPos    , yPos + 1}
      "v" -> {xPos    , yPos - 1}
      ">" -> {xPos + 1, yPos    }
      "<" -> {xPos - 1, yPos    }
      _   -> {xPos    , yPos    }
    end
  {{other, newPos}, Dict.put(map, newPos, 1)}
  
end

