defmodule SafeLevels do

  def is_level_safe([current, next | _] = list) do
    cond do
      current > next -> is_level_safe(list, :desc)
      current < next -> is_level_safe(list, :asc)
      true -> false
    end
  end

  def is_level_safe([current, next | tail], :desc) when current-next > 0 and current-next < 4 do
    is_level_safe([next | tail], :desc)
  end

  def is_level_safe([current, next | tail], :asc) when next-current > 0 and next-current < 4 do
    is_level_safe([next | tail], :asc)
  end


  def is_level_safe([last], _) do
    true
  end

  def is_level_safe([current | tail], _) do
    false
  end

end
