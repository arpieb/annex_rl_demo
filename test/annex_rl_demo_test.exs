defmodule AnnexRlDemoTest do
  use ExUnit.Case
  doctest AnnexRlDemo

  test "greets the world" do
    assert AnnexRlDemo.hello() == :world
  end
end
