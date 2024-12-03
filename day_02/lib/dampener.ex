defmodule ProblemDampener do

  @doc"""
  Take a level and delete one item from it if it fails validation,
  keep trying from the tail end of the list until we pass
  """
  @spec safety_dampener( [number()] ) :: boolean()
  def safety_dampener(level) do
    # So the hack here is that we go from negative index to the end.
    # Lists in elixir are all linked lists so it's more efficient to
    # start our search at the front which would be (-length)
    safety_dampener(level, 0..length(level))
  end

  def safety_dampener(level, index..limit) when index != limit do
    case SafeLevels.is_level_safe(List.delete_at(level, index)) do
      false -> safety_dampener(level, (index + 1)..limit)
      true -> true
    end
  end

  def safety_dampener(_, _) do
    false
  end
end