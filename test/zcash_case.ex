defmodule ZcashexCase do
  @moduledoc """
  Test Case and helpers for testing Zcashex.
  """

  use ExUnit.CaseTemplate

  alias Zcashex

  setup_all do

   host = System.get_env("zcashd_hostname") || "localhost"
   port = System.get_env("rpc_port") || 18347
   username = System.get_env("rpc_username") || "zcashrpc"
   password = System.get_env("rpc_password") || "notsecure"


   child_spec = %{
        id: Zcashex,
        start: {Zcashex, :start_link, [host, port, username, password]}
      }

    with {:ok, client} <- start_supervised(child_spec) do
      IO.inspect(client)
      {:ok, client: client}
    end
  end



end
