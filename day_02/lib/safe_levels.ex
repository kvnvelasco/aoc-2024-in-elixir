defmodule SafeLevels do

  def is_level_safe([current, next | _] = list) do
    cond do
      current > next -> is_level_safe(list, :desc)
      current < next -> is_level_safe(list, :asc)
      true -> false
    end
  end

  def is_level_safe([current, next | tail], :desc) when (current - next) in 1..3 do
    is_level_safe([next | tail], :desc)
  end

  def is_level_safe([current, next | tail], :asc) when (next-current) in 1..3 do
    is_level_safe([next | tail], :asc)
  end


  def is_level_safe([_], _) do
    true
  end

  def is_level_safe([_ | _], _) do
    false
  end

end