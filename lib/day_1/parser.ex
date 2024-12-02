defmodule Parser do
  @type input_pairs() :: {number(), number()}

  @spec parse_input(String.t()) :: list(input_pairs())
  def parse_input(input) do
    parse_input(String.split(input, "\n", trim: true), [])
  end

  @spec parse_input(list(String.t()), [input_pairs()]) :: list(input_pairs())
  defp parse_input([head| tail], final_list) do
    [first, second] = String.split(head, " ", parts: 2, trim: true)

    trim_parse = (& (&1 |> String.trim |> String.to_integer))

    parse_input(
      tail,
      final_list ++ [ {trim_parse.(first), trim_parse.(second)} ]
    )
  end

  defp parse_input([], final_list) do
    final_list
  end
end