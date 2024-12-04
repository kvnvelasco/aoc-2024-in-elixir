defmodule Machine do
  # Given a specific string "program" input and a parser operation:
  # The operation is called with the input in the form
  # operation(input, state) -> {next_state, next_input} | :error
  # in the event of a good operation, the machine calls itself again until there
  # is no more input.
  # in the event of an error, the machine (assuming there must be corruption) advances
  # the program counter by 1 and attempts to run the operation again.
  def run_machine(<<_h, tail::binary>> = input, operator) do
    case Operator.operate(operator, input) do
      {next_state, remaining_program} -> run_machine(remaining_program, next_state)
      :error -> run_machine(tail, operator)
      _ -> run_machine(tail, operator)
    end
  end

  def run_machine(<<>>, operator) do
    operator
  end
end

defprotocol Operator do
  def operate(state, input)
end


defmodule MulMachine do
  defstruct total: 0
end

defimpl Operator, for: MulMachine do
  def operate(%{total: total} = state, input) do
    case OperationMatcher.mul(input) do
      {:ok, {value, remaining_input}} -> {%{state | :total => total + value}, remaining_input}
      _ -> :error
    end
  end
end


defmodule DoDontMachine do
  defstruct total: 0, enabled: true
  def test_cond_map(pattern, func) do
    case pattern do
      {:ok, result} -> func.(result)
      _ -> false
    end
  end
end

defimpl Operator, for: DoDontMachine do
  def operate(%{enabled: enabled, total: total} = state, input) do
    OperationMatcher.dont_inst(input)
    |> DoDontMachine.test_cond_map(&{%{state | :enabled => false}, &1})
    || OperationMatcher.do_inst(input)
       |> DoDontMachine.test_cond_map(&{%{state | :enabled => true}, &1})
    || OperationMatcher.mul(input)
       |> DoDontMachine.test_cond_map(fn {product, rest} ->
      if enabled,
         do: {%{state | :total => total + product}, rest},
         else: {state, rest}
    end)
  end
end