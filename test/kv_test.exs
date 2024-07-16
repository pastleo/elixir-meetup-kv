defmodule KVTest do
  use ExUnit.Case
  doctest KV
  doctest KV.Command

  test "greets the world" do
    assert KV.hello() == :world
  end
end
