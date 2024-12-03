defmodule OperationMatcherTest do
  use ExUnit.Case

  test "can_do_multiplication" do
    {:ok, {mul, _}} = OperationMatcher.mul("mul(10,5)")

    assert mul == 50
  end
end
