defmodule AdventOfCode.Mixfile do
  use Mix.Project

  def project do
    [app: :advent_of_code,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:poison, "~> 1.5"}]
  end
end
