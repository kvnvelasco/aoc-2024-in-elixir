defmodule Slicer do
  def slice(input, :rows) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&String.to_char_list/1)
  end

  def slice(input, :columns) do
    rows = slice(input, :rows)
    slice(rows, 0, :columns)
  end

  def slice(rows, column_number, :columns) when is_list(rows) do
    case slice(rows, column_number, :column) do
      [] -> []
      current_column -> [current_column | slice(rows, column_number + 1, :columns)]
    end
  end

  def slice([row | rows], column_number, :column) do
    case Enum.fetch(row, column_number) do
      {:ok, character} -> [character | slice(rows, column_number, :column)]
      _ -> []
    end
  end

  def slice([], _, :column) do
    []
  end

  # starting at the upper left, get each diagonal that is pointed at the bottom right
  def slice(
        input,
        :diagonals,
        opts \\ [min_len: 4, with_indices: false]
      ) do
    min_len = Keyword.get(opts, :min_len, 4)
    with_indices = Keyword.get(opts, :with_indices, false)

    rows =
      if with_indices do
        String.split(input, "\n", trim: true)
        |> Enum.with_index()
        |> Enum.map(fn {row, y} ->
          Enum.with_index(String.to_charlist(row)) |> Enum.map(fn {cell, x} -> {cell, {x, y}} end)
        end)
      else
        slice(input, :rows)
      end

    width = length(hd(rows))
    height = length(rows)

    top_row = for idx <- 1..(width - 2), do: {idx, 0}
    left_column = for idx <- 1..(height - 1), do: {0, idx}
    right_column = for idx <- 1..(height - 1), do: {width - 1, idx}

    ltr_starts = [{0, 0} | top_row ++ left_column]
    rtl_starts = [{width - 1, 0} | top_row ++ right_column]

    ((ltr_starts |> get_diagonals(rows, :ltr)) ++ (rtl_starts |> get_diagonals(rows, :rtl)))
    |> Enum.filter(fn f -> length(f) >= min_len end)
  end

  def get_diagonals([], _, _), do: []

  def get_diagonals([{x, y} | starts], matrix, direction) do
    {_, rows} = Enum.split(matrix, y)

    [
      get_diagonal(
        rows,
        x,
        case direction do
          :ltr -> 1
          :rtl -> -1
        end
      )
      | get_diagonals(starts, matrix, direction)
    ]
  end

  def get_diagonal([row | rest], x_coordinate, direction) when x_coordinate >= 0 do
    case Enum.fetch(row, x_coordinate) do
      {:ok, value} -> [value | get_diagonal(rest, x_coordinate + direction, direction)]
      _ -> []
    end
  end

  def get_diagonal(_, _, -1), do: []
  def get_diagonal([], _, _), do: []
end
