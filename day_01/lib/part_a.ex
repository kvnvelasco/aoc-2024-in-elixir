defmodule PartA do
  def compute_total_difference({left, right}) do
    compute_total_difference(left, right, 0)
  end

  def compute_total_difference([l | tail_l], [r | tail_r], acc) do
    compute_total_difference(tail_l, tail_r, acc + abs(l - r))
  end

  def compute_total_difference([], [], acc) do
    acc
  end
end
