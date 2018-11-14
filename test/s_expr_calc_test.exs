defmodule SExprCalcTest do
  use ExUnit.Case
  doctest SExprCalc

  describe "calc/1" do
    test "simple addtion" do
      program = "(add 2 2)"
      expected = 4
      result = SExprCalc.calc(program)

      assert expected == result
    end

    test "simple multiplication" do
      program = "(multiply 2 2)"
      expected = 4
      result = SExprCalc.calc(program)

      assert expected == result
    end

    test "complex addition and multiplication" do
      program = "(add 1 (multiply (add 2 2) (multiply 4 2)))"
      expected = 33
      result = SExprCalc.calc(program)

      assert expected == result
    end
  end
end
