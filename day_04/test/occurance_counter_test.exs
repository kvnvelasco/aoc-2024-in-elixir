defmodule OccurrenceTest do
  use ExUnit.Case

  test "can_count_occurances" do
    result = PatternSearch.count_occurrences_of("ABCDDDABCWWDABC", "ABC")

    assert result == 3
  end
end
