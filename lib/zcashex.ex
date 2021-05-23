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

  def getblock(hash, verbosity) when is_integer(verbosity) and verbosity in 0..2 do
    GenServer.call(__MODULE__, {:call_endpoint, "getblock", [hash, verbosity]}, 120_000)
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
end
