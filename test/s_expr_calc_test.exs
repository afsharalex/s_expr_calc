defmodule SExprCalcTest do
  use ExUnit.Case
  doctest SExprCalc

  describe "parse/1" do
    test "simple addition s-expression" do
      program = "(add 1 1)"
      expected = [:+, 1, 1]
      result = SExprCalc.parse(program)

      assert expected -- result == []
      assert result -- expected == []
    end

    test "simple multiplication s-expression" do
      program = "(multiply 2 3)"
      expected = [:*, 2, 3]
      result = SExprCalc.parse(program)

      assert expected -- result == []
      assert result -- expected == []
    end

    test "complex addition and multiplication s-expression" do
      program = "(add (add 1 1) (multiply 2 2))"
      expected = [:+, :+, 1, 1, :*, 2, 2]
      result = SExprCalc.parse(program)

      assert expected -- result == []
      assert result -- expected == []
    end
  end
end
