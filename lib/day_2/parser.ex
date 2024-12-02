defmodule ParserDay2 do
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> parse([])
  end

  defp parse([line | lines], output) do
    level = line
            |> String.trim()
            |> String.split(" ")
            |> Enum.map(&(String.to_integer(&1)))

    parse(lines, [level | output])
  end

  defp parse([], output) do
    Enum.reverse(output)
  end
end