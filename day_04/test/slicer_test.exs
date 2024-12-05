defmodule SlicerTest do
  use ExUnit.Case

  test "can_slice_columns" do
    result =
      Slicer.slice(
        ["ABC", "DEF", "GEH"] |> Enum.map(&String.to_char_list/1),
        0,
        :column
      )

    assert result == ~c"ADG"

    result =
      Slicer.slice(
        """
        ABC
        DEF
        GHI
        """,
        :columns
      )

    assert result == [~c"ADG", ~c"BEH", ~c"CFI"]

    result =
      Slicer.slice(
        """
        ABC
        DEF
        GHI
        """,
        :rows
      )

    assert result == [~c"ABC", ~c"DEF", ~c"GHI"]
  end

  test "can_slice_diagonals" do
    result =
      Slicer.slice(
        """
        ABC
        DEF
        GHI
        """,
        :diagonals,
        min_len: 2
      )

    assert result == [~c"AEI", ~c"BF", ~c"DH", ~c"CEG", ~c"BD", ~c"FH"]
  end
end
