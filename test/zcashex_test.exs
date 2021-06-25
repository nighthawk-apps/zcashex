defmodule ZcashexTest do
  use ZcashexCase, async: true
  doctest Zcashex
  alias Zcashex

  test "getblockcount on regtest" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, count} = Zcashex.getblockcount()
    assert count > 0
  end
end
