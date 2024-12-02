defmodule ParserTests do
  use ExUnit.Case

  test "parser" do

    assert Parser.parse_input("""
1 2
3 4
""") == [{1, 2}, {3, 4}]

  end
end