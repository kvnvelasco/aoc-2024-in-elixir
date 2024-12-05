defmodule PatternSearch do
  def count_occurrences_of(charlist, pattern) when is_list(charlist) do
    count_occurrences_of(to_string(charlist), pattern)
  end

  def count_occurrences_of(<<_, rest::binary>> = string, pattern) do
    cond do
      String.starts_with?(string, pattern) ->
        1 + count_occurrences_of(string |> String.replace_prefix(pattern, ""), pattern)

      true ->
        count_occurrences_of(rest, pattern)
    end
  end

  def count_occurrences_of(<<>>, _), do: 0
end

defmodule MasSearcher do
  def get_mas_occurrences([{?M, m_coord}, {?A, a_coord}, {?S, s_coord} | rest]) do
    [{{?M, m_coord}, {?A, a_coord}, {?S, s_coord}} | get_mas_occurrences([{?S, s_coord} | rest])]
  end

  def get_mas_occurrences([{?S, s_coord}, {?A, a_coord}, {?M, m_coord} | rest]) do
    [{{?S, s_coord}, {?A, a_coord}, {?M, m_coord}} | get_mas_occurrences([{?M, m_coord} | rest])]
  end

  def get_mas_occurrences([head | tail]), do: get_mas_occurrences(tail)
  def get_mas_occurrences([]), do: []
end
