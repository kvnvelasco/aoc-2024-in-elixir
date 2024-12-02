


# Test case

levels = ParserDay2.parse("""
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
""")

levels
|> Stream.map(&SafeLevels.is_level_safe/1)
|> Stream.filter(&(&1))
|> Enum.to_list()
|> IO.inspect

IO.puts("Part A:")

File.read("lib/day_2/input.txt")
  |> then(fn {:ok, input} -> input end)
  |> ParserDay2.parse()
  |> Stream.map(&SafeLevels.is_level_safe/1)
  |> Stream.filter(&(&1))
  |> Enum.count()
  |> IO.inspect



