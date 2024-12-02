defmodule Operations do
  @doc"""
  Takes a set of paired inputs and splits them out into two lists
  """
  @spec unzip([Parser.input_pairs()]) :: { [number()] , [number()]}
  def unzip(list) do
    unzip(list, [], [])
  end

  defp unzip([current | tail], left, right) do
    {to_left, to_right} = current
    unzip(tail, left ++ [to_left], right ++ [to_right])
  end

  defp unzip([], left, right) do
    {left, right}
  end
end