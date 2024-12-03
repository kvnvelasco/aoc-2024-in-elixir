defmodule SafeLevels do

  def is_level_safe([current, next | _] = list) do
    cond do
      current > next -> is_level_safe(list, :desc)
      current < next -> is_level_safe(list, :asc)
      true -> false
    end
  end

  # The two functions below act as a kind of switch between two possible modes.
  # The first definition above checks the current and next item to decide the mode
  # (asc, desc) and once we are in that mode, we can only match other conditions that are
  # also in that mode, this means that if the conditions fail, we won't match and will fall
  # through to the failure case.
  # e.g [1, 2, 3, 4] gets called with :asc :asc :asc
  # but [1, 2, 5, 3] gets called with :asc :asc: :desc
  # there is no matching function that allows you to change from  :asc to :desc so we don't match
  # and the failure function at the end is called instead.

  def is_level_safe([current, next | tail], :desc) when (current - next) in 1..3 do
    is_level_safe([next | tail], :desc)
  end

  def is_level_safe([current, next | tail], :asc) when (next-current) in 1..3 do
    is_level_safe([next | tail], :asc)
  end


  # We made it to the end of the list and there is nothing next to compare to
  # All conditions must have passed in the above two recursions to make it here,
  # this must mean the level is valid
  def is_level_safe([_], _) do
    true
  end

  # In this case there is more than one item in the list
  # and we failed to match on the conditions above, this must mean there is a failure
  # and the level is not safe
  def is_level_safe([_ | _], _) do
    false
  end

end
