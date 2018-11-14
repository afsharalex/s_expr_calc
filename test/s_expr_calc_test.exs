defmodule SExprCalcTest do
  use ExUnit.Case
  doctest SExprCalc

  test "greets the world" do
    assert SExprCalc.hello() == :world
  end
end
