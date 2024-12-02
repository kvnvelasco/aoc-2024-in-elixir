File.read("lib/day_1/input.txt")
  |> then(fn {:ok, input} -> Parser.parse_input(input) end)
  |> Operations.unzip()
  |> then(fn {l1, l2} -> {Enum.sort(l1), Enum.sort(l2)} end)
  |> PartB.sum_mul_similarity()
  |> IO.inspect


