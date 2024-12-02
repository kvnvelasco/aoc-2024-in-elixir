defmodule ProblemDampener do

  @doc"""
  Take a level and delete one item from it if it fails validation,
  keep trying until we get to the bottom then bail.
  """
  def safety_dampener(level) do
    safety_dampener(level, length(level) - 1)
  end

  def safety_dampener(level, damped_item) when damped_item >= 0 do
    case SafeLevels.is_level_safe(List.delete_at(level, damped_item)) do
      false -> safety_dampener(level, damped_item - 1)
      true -> true
    end

  end

  def safety_dampener(_, _) do
    false
  end
end