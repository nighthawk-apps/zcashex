defmodule Zcashex do
  @moduledoc """
  Documentation for `Zcashex`.
  """

  @spec start_link(String.t(), String.t(), String.t(), non_neg_integer()) ::
          :ignore | {:error, any} | {:ok, pid}
  def start_link(host, port, username, password) do
    GenServer.start_link(
      Zcashex.Client,
      %{
        host: host,
        port: port,
        username: username,
        password: password
      },
      name: __MODULE__
    )
  end

  # @doc """
  # returns the node's state info
  # https://zcash-rpc.github.io/getinfo.html
  # """
  # @spec get_info :: {:ok, map()} | {:error, String.t()}
  # def get_info do
  #   GenServer.call(__MODULE__, {:call_endpoint, "getinfo"})
  # end

  @info_methods ~w(getblockchaininfo
                   getmempoolinfo
                   gettxoutsetinfo
                   getinfo
                   getmemoryinfo
                   getmininginfo
                   getnetworkinfo
                   getpeerinfo
                   getbestblockhash
                   getblockcount
                   getdifficulty
                   )a
  Enum.each(@info_methods, fn method ->
    @doc """
    https://zcash-rpc.github.io/#{method}.html
    """
    def unquote(method)() do
      GenServer.call(__MODULE__, {:call_endpoint, unquote(method)})
    end
  end)

  def getblock(hash, verbosity)
      when is_binary(hash) and is_integer(verbosity) and verbosity in 0..2 do
    GenServer.call(__MODULE__, {:call_endpoint, "getblock", [hash, verbosity]}, 120_000)
  end

  def getblock(hash, verbosity)
      when is_integer(hash) and is_integer(verbosity) and verbosity in 0..2 do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "getblock", [Integer.to_string(hash), verbosity]},
      120_000
    )
  end

  def getblocksubsidy() do
    GenServer.call(__MODULE__, {:call_endpoint, "getblocksubsidy"})
  end

  def getblocksubsidy(height) when is_integer(height) do
    GenServer.call(__MODULE__, {:call_endpoint, "getblocksubsidy", [height]})
  end

  @doc """
  https://zcash-rpc.github.io/getnetworksolps.html
  """
  def getnetworksolps(blocks \\ 120, height \\ -1) do
    GenServer.call(__MODULE__, {:call_endpoint, "getnetworksolps", [blocks, height]})
  end

  def getblockhashes(high, low, no_orphans \\ true, logical_times \\ true)
      when is_integer(high) and is_integer(low) and is_boolean(no_orphans) and
             is_boolean(logical_times) do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "getblockhashes",
       [high, low, %{"noOrphans" => no_orphans, "logicalTimes" => logical_times}]}
    )
  end

  @doc """
  https://zcash-rpc.github.io/getrawtransaction.html
  """
  def getrawtransaction(transaction_id, verbosity \\ 1)
      when is_integer(verbosity) and verbosity >= 0 do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "getrawtransaction", [transaction_id, verbosity]},
      120_000
    )
  end

  @doc """
  https://zcash-rpc.github.io/sendrawtransaction.html
  """
  def sendrawtransaction(hex) do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "sendrawtransaction", [hex]},
      120_000
    )
  end

  @doc """
  https://github.com/zcash/zcash/blob/master/doc/payment-disclosure.md
  """
  def z_validatepaymentdisclosure(hex) do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "z_validatepaymentdisclosure", [hex]},
      120_000
    )
  end

  @doc """
  https://zcash-rpc.github.io/getaddressbalance.html
  """
  def getaddressbalance(taddr) when is_binary(taddr) do
    payload = %{"addresses" => [taddr]}

    GenServer.call(
      __MODULE__,
      {:call_endpoint, "getaddressbalance", [payload]},
      120_000
    )
  end

  @doc """
  https://zcash-rpc.github.io/getaddressbalance.html
  """
  def getaddressbalance(taddr) when is_list(taddr) do
    payload = %{"addresses" => taddr}

    GenServer.call(
      __MODULE__,
      {:call_endpoint, "getaddressbalance", [payload]},
      120_000
    )
  end

  @doc """
  https://zcash-rpc.github.io/getaddressdeltas.html
  """
  def getaddressdeltas(taddr, start_block \\ nil, end_block \\ nil, chaininfo \\ true) do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "getaddressdeltas",
       [
         %{
           "addresses" => [taddr],
           "start" => start_block,
           "end" => end_block,
           "chainInfo" => chaininfo
         }
       ]},
      120_000
    )
  end

  @doc """
  https://zcash-rpc.github.io/getaddresstxids.html
  """
  def getaddresstxids(taddr, start_block \\ nil, end_block \\ nil) do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "getaddresstxids",
       [
         %{
           "addresses" => [taddr],
           "start" => start_block,
           "end" => end_block
         }
       ]},
      120_000
    )
  end

  @doc """
  https://zcash-rpc.github.io/decoderawtransaction.html
  """
  def decoderawtransaction(hexstring) do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "decoderawtransaction", [hexstring]},
      120_000
    )
  end

  @doc """
  https://zcash-rpc.github.io/validateaddress.html
  """
  def validateaddress(address) do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "validateaddress", [address]},
      120_000
    )
  end

  @doc """
  https://zcash-rpc.github.io/z_validateaddress.html
  """
  def z_validateaddress(address) do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "z_validateaddress", [address]},
      120_000
    )
  end

  @doc """
  https://zcash-rpc.github.io/getblockheader.html
  """
  def getblockheader(hash) do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "getblockheader", [hash]},
      120_000
    )
  end

  @doc """
  https://zcash-rpc.github.io/getrawmempool.html
  """
  def getrawmempool(verbose) do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "getrawmempool", [verbose]},
      120_000
    )
  end

  @doc """
  Note: this function can only be used on the regtest network
  https://zcash-rpc.github.io/generate.html
  """
  def generate(count) do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "generate", [count]},
      120_000
    )
  end

  @doc """
  https://zcash.github.io/rpc/z_listunifiedreceivers.html
  """
  def z_listunifiedreceivers(unified_address) do
    GenServer.call(
      __MODULE__,
      {:call_endpoint, "z_listunifiedreceivers", [unified_address]}
    )
  end
end
