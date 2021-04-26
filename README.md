# Zcashex

A elixir client library to interact with the JSON-RPC endpoint provided by a [Zcash full node](https://github.com/zcash/zcash).

Note: this project is under active development.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `zcashex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:zcashex, "~> 0.1.0"}
  ]
end
```

Usage:

manually:

```
{ok, pid} = Zcashex.start_link("localhost", 1234, "zcashrpc", "changeme")
GenServer.call(pid, {:call_endpoint, "getinfo"})
// or
Zcashex.getinfo
```

Example result:


```
{:ok,
 %{
   "balance" => 0.0,
   "blocks" => 1373123,
   "build" => "v4.2.0",
   "connections" => 6,
   "difficulty" => 50.67076107617935,
   "errors" => "",
   "errorstimestamp" => 1618768136,
   "keypoololdest" => 1609001920,
   "keypoolsize" => 101,
   "paytxfee" => 0.0,
   "protocolversion" => 170013,
   "proxy" => "",
   "relayfee" => 1.0e-6,
   "subversion" => "/MagicBean:4.2.0/",
   "testnet" => true,
   "timeoffset" => 0,
   "version" => 4020050,
   "walletversion" => 60000
 }}
 ```


Benchmarks:
```
Benchee.run(
  %{
    "info" => fn  -> Zcashex.getinfo end
  },
    time: 10,
  memory_time: 2,
  formatters: [{Benchee.Formatters.Console, extended_statistics: true}]
)
```
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/zcashex](https://hexdocs.pm/zcashex).

