defmodule CountOperator do
  defstruct count: 0
end


defimpl Operator, for: CountOperator do
  def operate(%{count: count} = state, <<_, tail::binary>>) do
    { %{state | :count => count + 1}, tail }
  end
end

defmodule MachineTest do
  use ExUnit.Case

  test "machine runs to completion" do
    %{count: count} =
      Machine.run_machine(
        "1234567910",
        %CountOperator{}
      )

    assert count == 10
  end
end


