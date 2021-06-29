defmodule ZcashexTest do
  use ZcashexCase, async: true
  doctest Zcashex
  alias Zcashex

  test "getblockcount" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, count} = Zcashex.getblockcount()
    assert count > 0
  end

  test "getblockchaininfo" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, info} = Zcashex.getblockchaininfo()
    assert Map.has_key?(info, "bestblockhash")
  end

  test "getmempoolinfo" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, info} = Zcashex.getmempoolinfo()
    assert Map.has_key?(info, "fullyNotified")
  end

  test "gettxoutsetinfo" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, info} = Zcashex.gettxoutsetinfo()
    assert Map.has_key?(info, "hash_serialized")
  end

  test "getinfo" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, info} = Zcashex.getinfo()
    assert Map.has_key?(info, "subversion")
  end

  test "getmemoryinfo" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, info} = Zcashex.getmemoryinfo()
    assert Map.has_key?(info, "locked")
  end

  test "getmininginfo" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, info} = Zcashex.getmininginfo()
    assert Map.has_key?(info, "networkhashps")
  end

  test "getnetworkinfo" do
    {:ok, info} = Zcashex.getnetworkinfo()
    assert Map.has_key?(info, "connections")
  end

  test "getpeerinfo" do
    {:ok, info} = Zcashex.getpeerinfo()
    assert is_list(info)
  end

  test "getbestblockhash" do
    {:ok, hash} = Zcashex.getbestblockhash()
    assert is_binary(hash)
  end

  test "getdifficulty" do
    {:ok, difficulty} = Zcashex.getdifficulty()
    assert is_number(difficulty)
  end

end
