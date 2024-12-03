defmodule Day02Test do
  use ExUnit.Case

  test "part_a" do
    result =     File.read!(Path.join(__DIR__, "input.txt"))
                 |> Parser.parse()
             |> Stream.map(&SafeLevels.is_level_safe/1)
             |> Stream.filter(&(&1))
             |> Enum.count()
             |> IO.inspect

    assert result == 624
  end

  test "part_b" do
    result =   File.read!(Path.join(__DIR__, "input.txt"))
               |> Parser.parse()
             |> Stream.map(&ProblemDampener.safety_dampener/1)
             |> Stream.filter(&(&1))
             |> Enum.count()
             |> IO.inspect
    assert result == 658
  end
end
