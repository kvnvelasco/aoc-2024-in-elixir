defmodule Machine do
  # Given a specific string "program" input and a parser operation:
  # The operation is called with the input in the form
  # operation(input, state) -> {next_state, next_input} | :error
  # in the event of a good operation, the machine calls itself again until there
  # is no more input.
  # in the event of an error, the machine (assuming there must be corruption) advances
  # the program counter by 1 and attempts to run the operation again.
  def run_machine(<<_h, tail::binary>> = input, operation, state) do
    case operation.(input, state) do
      {next_state, remaining_program} -> run_machine(remaining_program, operation, next_state)
      :error -> run_machine(tail, operation, state)
      _ -> run_machine(tail, operation, state)
    end
  end

  def run_machine(<<>>, _, state) do
    state
  end
end


defmodule DoDontMachine do
  def machine_function(input, %{enabled: enabled, total: total} = state) do
    OperationMatcher.dont_inst(input)
    |> test_cond_map(&{%{state | :enabled => false}, &1})
    || OperationMatcher.do_inst(input)
    |> test_cond_map(&{%{state | :enabled => true}, &1})
    || OperationMatcher.mul(input)
    |> test_cond_map(fn {product, rest} ->
        if enabled,
          do: {%{state | :total => total + product}, rest},
          else: {state, rest}
    end)
  end

  defp test_cond_map(pattern, func) do
    case pattern do
      {:ok, result} -> func.(result)
      _ -> false
    end
  end
end
