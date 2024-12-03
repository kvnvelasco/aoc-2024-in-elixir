defmodule Day01Test do
  use ExUnit.Case

  test "part_a" do
    result =
      File.read!(Path.join(__DIR__, "input.txt"))
      |> Parser.parse_input()
      |> Operations.unzip()
      |> then(fn {l1, l2} -> {Enum.sort(l1), Enum.sort(l2)} end)
      |> PartA.compute_total_difference()
      |> IO.inspect()

    assert result == 1_660_292
  end

  test "part_b" do
    result =
      File.read!(Path.join(__DIR__, "input.txt"))
      |> Parser.parse_input()
      |> Operations.unzip()
      |> then(fn {l1, l2} -> {Enum.sort(l1), Enum.sort(l2)} end)
      |> PartB.sum_mul_similarity()
      |> IO.inspect()

    assert result == 22_776_016
  end
end
