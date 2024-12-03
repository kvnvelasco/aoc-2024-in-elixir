defmodule MachineTest do
  use ExUnit.Case

  test "machine runs to completion" do
    state =
      Machine.run_machine(
        "1234567910",
        fn <<_x, tail::binary>>, state -> {state + 1, tail} end,
        0
      )

    assert state == 10
  end
end
