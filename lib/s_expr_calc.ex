defmodule SExprCalc do
  @moduledoc """
  S-Expression Calculator.
  """

  # Take s-expression string, return a list of tokens
  defp create_tokens(program) do
    program
    |> String.replace(")", "")
    |> String.replace("(", "")
    |> String.replace(~r/ +/, " ")
    |> String.trim()
    |> String.split(" ")
  end

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
	exit("unexpected token.")
    end
  end

  # Process list of strings, returning token representation.
  defp symbolize(tokens) when is_list(tokens) and length(tokens) > 1, do: Enum.map(tokens, fn x -> symbolize(x) end)
  defp symbolize(token) when is_list(token), do: symbolize([token])
  defp symbolize(token) do
    cond do
      token == "add" ->
	:+
      token == "multiply" ->
	:*
      true ->
	to_number(token)
    end
  end

  @doc """
  Parse given string, returning a list representation of the syntax similar to an AST.

  ## Examples

      iex> program = "(add (multiply 1 2) (add 2 3))
      iex> SExprCalc.parse(program)
      [:+, :*, 1, 2, :+, 2, 3]

  """
  def parse(program) do
    program
    |> create_tokens()
    |> symbolize()
  end
end
