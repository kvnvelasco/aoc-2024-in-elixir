defmodule PartB do
  def sum_mul_similarity({l, r}) do
    sum_mul_similarity(l, r, 0)
  end

  def sum_mul_similarity([l | lt], [r | rt], total) do
    {next_l, _next_r, count} = find_similarity([l | lt], [r | rt], 0)

    sum_mul_similarity(next_l, [r | rt], total + count)
  end

  def sum_mul_similarity(_list_l, [], total) do
    total
  end

  def sum_mul_similarity([], _list_r, total) do
    total
  end

  def find_similarity([left | list_l], [right | list_right], count) when left == right do
    find_similarity([left | list_l], list_right, count + 1)
  end

  def find_similarity([left | list_l], [right | list_right], count) when left > right do
    find_similarity([left | list_l], list_right, count)
  end

  def find_similarity([left | list_l], [right | list_right], count) when left < right do
    {list_l, [right | list_right], count * left}
  end

  def find_similarity([left | l], [], count) do
    {l, [], count * left}
  end
end
