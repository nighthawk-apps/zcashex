defmodule Zcashex.Client do
  @moduledoc """
  Client that communicates with the Zcash node.
  """
  use GenServer
  require Logger

  def init(state) do
    {:ok, state}
  end

  @doc """
  Calls a given Zcashd's JSON-RPC endpoint with params
  """
  def handle_call({:call_endpoint, method, params}, _from, state) do
    response =
      HTTPoison.post(
        "http://#{state.host}:#{state.port}",
        Poison.encode!(%{
          "jsonrpc" => "1.0",
          "id" => "zcashex",
          "method" => method,
          "params" => params
        }),
        [{"Content-Type", "text/plain"}],
        hackney: [basic_auth: {state.username, state.password}],
        recv_timeout: 5000
      )

    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, %{"error" => nil, "id" => "zcashex", "result" => result}} = Poison.decode(body)
        {:reply, {:ok, result}, state}

      {:ok, %HTTPoison.Response{body: body}} ->
        case Poison.decode(body) do
          {:ok, %{"error" => %{"message" => message}, "id" => "zcashex", "result" => nil}} ->
            {:reply, {:error, message}, state}

          _ ->
            {:reply, {:error, "Unknown error."}, state}
        end

      _ ->
        {:reply, {:error, "Unknown error."}, state}
    end
  end

  @doc """
  Calls a given Zcashd's JSON-RPC endpoint with params
  """
  def handle_call({:call_endpoint, method}, from, state) do
    Zcashex.Client.handle_call({:call_endpoint, method, []}, from, state)
  end
end
