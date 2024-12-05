defmodule Day04Test do
  use ExUnit.Case

  test "test_case" do
    input = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

    slices =
      Slicer.slice(input, :rows) ++
        Slicer.slice(input, :columns) ++ Slicer.slice(input, :diagonals)

    result =
      slices
      |> Enum.map(fn slice ->
        PatternSearch.count_occurrences_of(slice, "XMAS") +
          PatternSearch.count_occurrences_of(slice, "SAMX")
      end)
      |> Enum.sum()

    assert result == 18
  end

  test "part_a" do
    input = File.read!(Path.join(__DIR__, "input.txt"))

    slices =
      Slicer.slice(input, :rows) ++
        Slicer.slice(input, :columns) ++ Slicer.slice(input, :diagonals)

    result =
      slices
      |> Enum.map(fn slice ->
        PatternSearch.count_occurrences_of(slice, "XMAS") +
          PatternSearch.count_occurrences_of(slice, "SAMX")
      end)
      |> Enum.sum()

    assert result == 2646
  end

  test "part_b_test" do
    slices =
      Slicer.slice(
        """
        MMMSXXMASM
        MSAMXMSMSA
        AMXSXMAAMM
        MSAMASMSMX
        XMASAMXAMM
        XXAMMXXAMA
        SMSMSASXSS
        SAXAMASAAA
        MAMMMXMMMM
        MXMXAXMASX
        """,
        :diagonals,
        with_indices: true,
        min_len: 3
      )

    matches =
      Enum.flat_map(slices, &MasSearcher.get_mas_occurrences/1)

    matches =
      matches
      |> Enum.group_by(fn {_, center, _} -> center end)
      |> Map.filter(fn {k, v} -> length(v) == 2 end)
      |> Enum.count()

    assert matches == 9
  end

  test "part_b" do
    input = File.read!(Path.join(__DIR__, "input.txt"))

    slices =
      Slicer.slice(
        input,
        :diagonals,
        with_indices: true,
        min_len: 3
      )

    matches =
      Enum.flat_map(slices, &MasSearcher.get_mas_occurrences/1)

    matches =
      matches
      |> Enum.group_by(fn {_, center, _} -> center end)
      |> Map.filter(fn {k, v} -> length(v) == 2 end)
      |> Enum.count()

    assert matches == 2000
  end
end
