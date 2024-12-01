defmodule Day1 do
  def part_1(input) do
    input_pairs = String.split(input, "\n", trim: true)

    input_pairs
      |> eat_pairs
      |> unzip
      |> sort
      |> diff_pairs
  end

  def part_2(input) do
    String.split(input, "\n", trim: true)
      |> eat_pairs
      |> unzip
      |> sort
      |> sum_mul_similarity

  end

  def sum_mul_similarity({l, r}) do

    sum_mul_similarity(l, r, 0)
  end

  def sum_mul_similarity([l | lt], [r | rt], total) do

    {next_l, next_r, count} = find_similarity([l | lt], [r | rt], 0)

    sum_mul_similarity(next_l, [r | rt], total + count)
  end

  def sum_mul_similarity(_list_l, [], total) do
    total
  end

  def sum_mul_similarity([], _list_r, total) do
    total
  end




  def find_similarity([left | list_l], [right | list_right], count) when left == right  do
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

  def sort({l, r}) do
    {Enum.sort(l), Enum.sort(r)}
  end

  def diff_pairs({left, right}) do
    diff_pairs(left, right, 0)
  end

  def diff_pairs([l | tail_l], [r | tail_r], acc) do
    diff_pairs(tail_l, tail_r, acc + abs(l - r))
  end

  def diff_pairs([], [], acc) do
    acc
  end

  def eat_pairs(list) do
    eat_pairs(list, [])
  end

  def eat_pairs([current | tail], acc) do
    [first, second] = String.split(current, " ", parts: 2, trim: true)


    eat_pairs(tail, acc ++ [{first |> String.trim |> String.to_integer, second |> String.trim |> String.to_integer}])
  end

  def eat_pairs([], acc) do
    acc
  end

  def unzip(list) do
    unzip(list, [], [])
  end

  def unzip([current | tail], left, right) do
    {to_left, to_right} = current
    unzip(tail, left ++ [to_left], right ++ [to_right])
  end

  def unzip([], left, right) do
    {left, right}
  end
end
