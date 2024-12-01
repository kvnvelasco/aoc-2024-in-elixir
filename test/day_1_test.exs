defmodule Day1Tests do
  use ExUnit.Case

  test "line_eater" do

    assert Day1.eat_pairs(["1 2", "3 4"], []) == [{1, 2}, {3, 4}]

  end

  test "unzipper" do
    assert Day1.unzip([{1, 2}, {3, 4}]) == { [1, 3], [2, 4] }
  end

  test "diff_pairs" do
    assert Day1.diff_pairs({[1, 2], [3, 4]}) == 4
    assert Day1.diff_pairs({[1, 3], [7, 10]}) == 13
  end

  test "test_input" do
    result = Day1.part_1("""
3   4
4   3
2   5
1   3
3   9
3   3
""")

    assert result == 11
  end

  test "day_1_run" do
    {:ok, data} = File.read("test/day_1_input.txt")
    assert Day1.part_1(data) == 1660292
  end

  test "similarity_score" do
    assert Day1.sum_mul_similarity([1, 2, 3, 4], [3, 3, 3], 0) == 9
  end

  test "day_1_b_test_data" do
    assert Day1.part_2("""
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
""") == 31
  end

  test "day_1a_run" do
    {:ok, data} = File.read("test/day_1_input.txt")
    assert Day1.part_2(data) == 22776016
  end
end