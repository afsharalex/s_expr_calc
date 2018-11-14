defmodule SExprCalc.CLI do
  def main(args) do
    program = hd(args)
    IO.puts SExprCalc.calc(program)
  end
end
