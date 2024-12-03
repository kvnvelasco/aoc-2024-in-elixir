defmodule Day03Test do
  use ExUnit.Case

  test "test_case" do
    output =
      Machine.run_machine(
        "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
        fn input, state ->
          case OperationMatcher.mul(input) do
            {:ok, {value, remaining_input}} -> {state + value, remaining_input}
            _ -> :error
          end
        end,
        0
      )

    assert output == 161
  end

  test "part_a" do
    input = File.read!(Path.join(__DIR__, "input.txt"))

    output =
      Machine.run_machine(
        input,
        fn input, state ->
          case OperationMatcher.mul(input) do
            {:ok, {value, remaining_input}} -> {state + value, remaining_input}
            _ -> :error
          end
        end,
        0
      )

    assert output == 188_116_424
  end

  test "part_b" do
    input = File.read!(Path.join(__DIR__, "input.txt"))

    %{total: total} =
      Machine.run_machine(
        input,
        &DoDontMachine.machine_function/2,
        %{:enabled => true, :total => 0}
      )

    assert total == 104_245_808
  end
end
