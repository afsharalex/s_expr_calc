defmodule SExprCalc do
  @moduledoc """
  S-Expression Calculator.
  """

  alias SExprCalc.Calc

  ########
  # MAIN #
  ########

  @doc """
  Given an S-Expression string, parse and evaluate, return the result.

  ## Examples

      iex> program = "(add (multiply (add 2 2) (multiply 4 2)) 1)"
      iex> SExprCalc.calc(program)
      33

  """
  def calc(program) do
    program
    |> Calc.parse()
    |> Calc.evaluate()
  end
end
