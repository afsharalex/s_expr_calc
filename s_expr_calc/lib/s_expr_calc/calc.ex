defmodule SExprCalc.Calc do
  @moduledoc """
  Heart of S-Expression Calculator.
  """

  ####################
  # HELPER FUNCTIONS #
  ####################

  # Takes a string and returns Float, Integer, or exits with error.
  defp to_number(token) do
    case Integer.parse(token) do
      {n_int, left_over} ->
        if String.contains?(left_over, ".") do
          {n_flt, _left_over} = Float.parse(token)
          n_flt
        else
          n_int
        end

      :error ->
        exit("unexpected token: '#{token}'.")
    end
  end

  # Return true if valid operator, false if not.
  defp is_operator(token) do
    case token do
      :+ ->
        true

      :* ->
        true

      :- ->
        true

      # ':/' would return float so we use div to avoid that.
      :div ->
        true

      _ ->
        false
    end
  end

  ###########
  # PARSING #
  ###########

  # Take s-expression string, return a list of tokens
  defp create_tokens(program) when is_bitstring(program) do
    program
    |> String.replace(")", "")
    |> String.replace("(", "")
    |> String.replace(~r/ +/, " ")
    |> String.trim()
    |> String.split(" ")
  end

  # Process list of strings, returning token representation.
  defp symbolize(tokens) when is_list(tokens) and length(tokens) > 1 do
    Enum.map(tokens, fn x -> symbolize(x) end)
  end

  # if not given as single string, Elixir will think it is binary
  defp symbolize(tokens) when is_list(tokens) do
    [x] = tokens
    symbolize(x)
  end

  defp symbolize(token) do
    cond do
      token == "add" ->
        :+

      token == "multiply" ->
        :*

      token == "subtract" ->
        :-

      token == "divide" ->
        :div

      true ->
        to_number(token)
    end
  end

  @doc """
  Parse given string, returning a list representation of the syntax similar to an AST.

  ## Examples

      iex> program = "(add (multiply 1 2) (add 2 3))"
      iex> SExprCalc.Calc.parse(program)
      [:+, :*, 1, 2, :+, 2, 3]

  """
  def parse(program) do
    program
    |> create_tokens()
    |> symbolize()
  end

  ##############
  # EVALUATION #
  ##############

  @doc """
  Evaluate list representation of syntax, and perform calculations as needed, returning result.

  ## Examples

      iex> program = [:+, :*, 2, 2, :+, 1, 1]
      iex> SExprCalc.Calc.evaluate(program)
      6

  """
  def evaluate(program) when is_list(program) and length(program) == 3 do
    [h | t] = program
    apply(Kernel, h, t)
  end

  def evaluate(program) when is_list(program) and length(program) > 2 do
    program =
      Enum.reduce_while(Enum.with_index(program), [], fn {x, i}, acc ->
        if is_operator(x) and i < length(program) - 2 do
          a = Enum.at(program, i + 1)
          b = Enum.at(program, i + 2)

          if is_number(a) and is_number(b) do
            lst =
              List.delete_at(program, i)
              |> List.delete_at(i)
              |> List.delete_at(i)
              |> List.insert_at(i, evaluate([x, a, b]))

            {:halt, acc ++ lst}
          else
            {:cont, acc}
          end
        else
          {:cont, acc}
        end
      end)

    evaluate(program)
  end

  def evaluate(program), do: program
end
