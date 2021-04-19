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

  @doc """
  returns the node's state info
  https://zcash-rpc.github.io/getinfo.html
  """
  @spec get_info :: {:ok, map()} | {:error, String.t()}
  def get_info do
    GenServer.call(__MODULE__, {:call_endpoint, "getinfo"})
  end
end
