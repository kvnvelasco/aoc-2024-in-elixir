defmodule Day03Test do
  use ExUnit.Case

  test "test_case" do
    %{total: total} =
      Machine.run_machine(
        "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
        %MulMachine{}
      )

    assert total == 161
  end

  test "part_a" do
    input = File.read!(Path.join(__DIR__, "input.txt"))

    %{total: total} =
      Machine.run_machine(
        input,
        %MulMachine{}
      )

    assert total == 188_116_424
  end

  test "part_b" do
    input = File.read!(Path.join(__DIR__, "input.txt"))

    %{total: total} =
      Machine.run_machine(
        input,
        %DoDontMachine{}
      )

    assert total == 104_245_808
  end
end
