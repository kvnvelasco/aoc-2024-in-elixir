defmodule OperationMatcher do
  def mul(<<"mul", rest::binary>>) do
    case digit_pair(rest) do
      {left, right, rest} -> {:ok, {left * right, rest}}
      {:no_match, rest} -> {:no_match, rest}
      _ -> {:no_match, rest}
    end
  end

  def mul(binary) do
    {:no_match, binary}
  end

  # tries and extracts a pair of digits enclosed by parentheses
  def digit_pair(<<"(", rest::binary>>) do
    case Integer.parse(rest, 10) do
      {left_number, <<",", rest::binary>>} ->
        case Integer.parse(rest, 10) do
          {right_number, <<")", rest::binary>>} ->
            {left_number, right_number, rest}

          _ ->
            {:no_match, rest}
        end

      _ ->
        {:no_match, rest}
    end
  end

  def digit_pair(rest) do
    {:no_match, rest}
  end

  def do_inst(binary) do
    case binary do
      <<"do()", rest::binary>> -> {:ok, rest}
      _ -> {:no_match, binary}
    end
  end

  def dont_inst(binary) do
    case binary do
      <<"don't()", rest::binary>> -> {:ok, rest}
      _ -> {:no_match, binary}
    end
  end
end
